import Link from "next/link";

import { Badge, Card, KpiBadge, Progress, Table } from "@/components/ui";
import { updateTaskProgressAction } from "@/lib/actions";
import { listTasks } from "@/lib/queries";

export const dynamic = "force-dynamic";

function date(value: Date | null) {
  return value ? new Date(value).toISOString().slice(0, 10) : "—";
}

export default async function TasksPage({
  searchParams,
}: {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
}) {
  const params = await searchParams;
  const openOnly = params.all !== "1";
  const tasks = await listTasks({ openOnly });

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold">Tasks</h1>
          <p className="text-sm text-slate-500">
            Port of <code>Tasks_OpenedButPending</code>; setting progress to 100% closes the task,
            mirroring the Access form logic.
          </p>
        </div>
        <Link
          href={openOnly ? "/tasks?all=1" : "/tasks"}
          className="rounded border border-slate-300 px-3 py-2 text-sm hover:bg-slate-100 dark:border-slate-700 dark:hover:bg-slate-800"
        >
          {openOnly ? "Show all tasks" : "Show open only"}
        </Link>
      </div>

      <Card>
        <Table
          head={[
            "Task",
            "Project",
            "Work stream",
            "Owner",
            "Priority",
            "Progress",
            "KPI",
            "Scheduled end",
            "Closed",
            "Flags",
            "Update",
          ]}
        >
          {tasks.map((task) => (
            <tr key={task.task_id}>
              <td className="px-3 py-2">
                <div className="font-medium">{task.task_name}</div>
                <div className="text-xs text-slate-500">{task.category}</div>
              </td>
              <td className="px-3 py-2">{task.project}</td>
              <td className="px-3 py-2">{task.work_stream}</td>
              <td className="px-3 py-2">{task.updater}</td>
              <td className="px-3 py-2">{task.priority}</td>
              <td className="px-3 py-2">
                <Progress value={task.current_progress} />
              </td>
              <td className="px-3 py-2">
                <KpiBadge status={task.global_status_kpi} />
              </td>
              <td className="px-3 py-2">{date(task.scheduled_end_date)}</td>
              <td className="px-3 py-2">{date(task.end_date)}</td>
              <td className="px-3 py-2">
                <div className="flex gap-1">
                  {task.is_blocked && <Badge tone="red">Blocked</Badge>}
                  {task.is_freezed && <Badge>Frozen</Badge>}
                  {task.rescheduling_count > 0 && <Badge>{task.rescheduling_count}× resched.</Badge>}
                </div>
              </td>
              <td className="px-3 py-2">
                <form action={updateTaskProgressAction} className="flex items-center gap-1">
                  <input type="hidden" name="task_id" value={task.task_id} />
                  <input
                    type="number"
                    name="current_progress"
                    min="0"
                    max="100"
                    step="5"
                    defaultValue={task.current_progress}
                    className="w-16 rounded border border-slate-300 px-1 py-0.5 text-sm dark:border-slate-700 dark:bg-slate-800"
                  />
                  <button
                    type="submit"
                    className="rounded bg-sky-600 px-2 py-0.5 text-xs text-white hover:bg-sky-700"
                  >
                    Save
                  </button>
                </form>
              </td>
            </tr>
          ))}
        </Table>
        {tasks.length === 0 && <p className="text-sm text-slate-500">No tasks.</p>}
      </Card>
    </div>
  );
}
