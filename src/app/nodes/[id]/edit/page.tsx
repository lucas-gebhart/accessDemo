import { notFound } from "next/navigation";

import { NodeForm } from "@/components/NodeForm";
import { updateNode, type ActionState } from "@/lib/actions";
import { NODE_FORM_LOOKUPS } from "@/lib/nodeLookups";
import { getLookups, getNode } from "@/lib/queries";
import type { NodeInput } from "@/lib/nodeForm";

export const dynamic = "force-dynamic";

export default async function EditNodePage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const nodeId = Number(id);
  if (Number.isNaN(nodeId)) notFound();

  const [node, lookups] = await Promise.all([getNode(nodeId), getLookups(NODE_FORM_LOOKUPS)]);
  if (!node) notFound();

  const action = async (state: ActionState, formData: FormData) => {
    "use server";
    return updateNode(nodeId, state, formData);
  };

  return (
    <div className="space-y-4">
      <h1 className="text-2xl font-semibold">Edit {node.node_name}</h1>
      <NodeForm
        action={action}
        lookups={lookups}
        values={node as unknown as Partial<NodeInput>}
        submitLabel="Save changes"
        cancelHref={`/nodes/${nodeId}`}
      />
    </div>
  );
}
