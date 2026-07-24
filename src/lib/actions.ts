"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

import { pool, query } from "@/lib/db";
import {
  NODE_FIELDS,
  describeIssues,
  nodeFormValues,
  parseNodeForm,
  type NodeInput,
} from "@/lib/nodeForm";

/** `values` is echoed back so a rejected form re-renders with what the user typed. */
export type ActionState = { error?: string; values?: Record<string, string | boolean> };

function columnList(input: NodeInput) {
  const columns = NODE_FIELDS.filter((field) => input[field] !== undefined);
  const values = columns.map((column) => input[column]);
  return { columns, values };
}

export async function createNode(_state: ActionState, formData: FormData): Promise<ActionState> {
  const parsed = parseNodeForm(formData);
  if (!parsed.success) {
    return { error: describeIssues(parsed.error), values: nodeFormValues(formData) };
  }
  const { columns, values } = columnList(parsed.data);
  const placeholders = columns.map((_, index) => `$${index + 1}`).join(", ");
  const rows = await query<{ node_id: number }>(
    `insert into nodes (${columns.join(", ")}, node_is_deleted)
     values (${placeholders}, false) returning node_id`,
    values,
  );
  revalidatePath("/", "layout");
  redirect(`/nodes/${rows[0].node_id}`);
}

export async function updateNode(
  nodeId: number,
  _state: ActionState,
  formData: FormData,
): Promise<ActionState> {
  const parsed = parseNodeForm(formData);
  if (!parsed.success) {
    return { error: describeIssues(parsed.error), values: nodeFormValues(formData) };
  }
  const { columns, values } = columnList(parsed.data);
  const assignments = columns.map((column, index) => `${column} = $${index + 1}`).join(", ");
  await query(
    `update nodes set ${assignments}, inventory_last_update_date = now()
      where node_id = $${columns.length + 1}`,
    [...values, nodeId],
  );
  revalidatePath("/", "layout");
  redirect(`/nodes/${nodeId}`);
}

/** The Access front end never hard-deletes a node; it flips NodeIsDeleted. */
export async function softDeleteNode(nodeId: number) {
  await query(
    `update nodes set node_is_deleted = true, node_is_active = false,
            inventory_last_update_date = now() where node_id = $1`,
    [nodeId],
  );
  revalidatePath("/", "layout");
  redirect("/nodes");
}

export async function setTaskProgress(taskId: number, progress: number) {
  const client = await pool.connect();
  try {
    await client.query("begin");
    await client.query(
      `update tasks
          set current_progress = $2::real,
              end_date = case when $2::real >= 100 then coalesce(end_date, now()) else null end,
              last_update_date = now()
        where task_id = $1`,
      [taskId, progress],
    );
    await client.query("commit");
  } catch (error) {
    await client.query("rollback");
    throw error;
  } finally {
    client.release();
  }
  revalidatePath("/", "layout");
}

export async function updateTaskProgressAction(formData: FormData) {
  const taskId = Number(formData.get("task_id"));
  const progress = Number(formData.get("current_progress"));
  if (Number.isNaN(taskId) || Number.isNaN(progress)) return;
  await setTaskProgress(taskId, Math.min(Math.max(progress, 0), 100));
}

export async function resolveIssueAction(formData: FormData) {
  const issueId = Number(formData.get("issue_id"));
  if (Number.isNaN(issueId)) return;
  await query(
    `update issues set resolution_date = now(), is_active = false, last_update_date = now()
      where issue_id = $1`,
    [issueId],
  );
  revalidatePath("/", "layout");
}
