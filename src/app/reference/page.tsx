import { Card, Table } from "@/components/ui";
import { getLookups, LOOKUP_NAMES } from "@/lib/queries";

export const dynamic = "force-dynamic";

function title(name: string) {
  return name.replace(/_/g, " ").replace(/\b\w/g, (character) => character.toUpperCase());
}

export default async function ReferencePage() {
  const lookups = await getLookups(LOOKUP_NAMES);

  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-2xl font-semibold">Reference Data</h1>
        <p className="text-sm text-slate-500">
          The lookup tables behind every combo box — equivalent to the Access{" "}
          <code>_EntityData_*</code> subforms. All values are the originals from the OpenSLIM
          database backup.
        </p>
      </div>
      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
        {LOOKUP_NAMES.map((name) => (
          <Card key={name} title={`${title(name)} (${lookups[name].length})`}>
            <div className="max-h-72 overflow-y-auto">
              <Table head={["Id", "Name"]}>
                {lookups[name].map((row) => (
                  <tr key={row.id}>
                    <td className="px-3 py-1 tabular-nums text-slate-500">{row.id}</td>
                    <td className="px-3 py-1">{row.name}</td>
                  </tr>
                ))}
              </Table>
            </div>
          </Card>
        ))}
      </div>
    </div>
  );
}
