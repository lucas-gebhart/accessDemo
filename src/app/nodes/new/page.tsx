import { NodeForm } from "@/components/NodeForm";
import { createNode } from "@/lib/actions";
import { getLookups } from "@/lib/queries";
import { NODE_FORM_LOOKUPS } from "@/lib/nodeLookups";

export const dynamic = "force-dynamic";

export default async function NewNodePage() {
  const lookups = await getLookups(NODE_FORM_LOOKUPS);
  return (
    <div className="space-y-4">
      <h1 className="text-2xl font-semibold">New node</h1>
      <NodeForm action={createNode} lookups={lookups} submitLabel="Create node" cancelHref="/nodes" />
    </div>
  );
}
