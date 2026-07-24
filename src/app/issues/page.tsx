import Link from "next/link";

import { Badge, Card, KpiBadge, Table } from "@/components/ui";
import { resolveIssueAction } from "@/lib/actions";
import { listIssues } from "@/lib/queries";

export const dynamic = "force-dynamic";

function date(value: Date | null) {
  return value ? new Date(value).toISOString().slice(0, 10) : "—";
}

export default async function IssuesPage({
  searchParams,
}: {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
}) {
  const params = await searchParams;
  const risksOnly = params.risks === "1";
  const openOnly = params.all !== "1";
  const issues = await listIssues({ risksOnly, openOnly });

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-semibold">Issues &amp; Risks</h1>
          <p className="text-sm text-slate-500">
            Port of <code>_IssuesBasicList</code>. Issues and risks live in one table, split by the{" "}
            <code>IsARisk</code> flag.
          </p>
        </div>
        <div className="flex gap-2 text-sm">
          <Link
            href={risksOnly ? "/issues" : "/issues?risks=1"}
            className="rounded border border-slate-300 px-3 py-2 hover:bg-slate-100 dark:border-slate-700 dark:hover:bg-slate-800"
          >
            {risksOnly ? "Show all" : "Risks only"}
          </Link>
          <Link
            href={openOnly ? "/issues?all=1" : "/issues"}
            className="rounded border border-slate-300 px-3 py-2 hover:bg-slate-100 dark:border-slate-700 dark:hover:bg-slate-800"
          >
            {openOnly ? "Include resolved" : "Open only"}
          </Link>
        </div>
      </div>

      <Card>
        <Table
          head={[
            "Description",
            "Kind",
            "Project",
            "Owner",
            "Team",
            "Risk type",
            "Severity",
            "Probability",
            "Action status",
            "Raised",
            "Resolved",
            "",
          ]}
        >
          {issues.map((issue) => (
            <tr key={issue.issue_id}>
              <td className="px-3 py-2">
                <div className="font-medium">{issue.description}</div>
                {issue.action_description && (
                  <div className="text-xs text-slate-500">{issue.action_description}</div>
                )}
              </td>
              <td className="px-3 py-2">
                <Badge tone={issue.is_a_risk ? "red" : "slate"}>
                  {issue.is_a_risk ? "Risk" : "Issue"}
                </Badge>
              </td>
              <td className="px-3 py-2">{issue.project}</td>
              <td className="px-3 py-2">{issue.owner}</td>
              <td className="px-3 py-2">{issue.owner_team}</td>
              <td className="px-3 py-2">{issue.risk_type}</td>
              <td className="px-3 py-2">
                <KpiBadge status={issue.severity_status_kpi} />
              </td>
              <td className="px-3 py-2 tabular-nums">
                {issue.occurence_probability === null
                  ? "—"
                  : `${(issue.occurence_probability * 100).toFixed(0)}%`}
              </td>
              <td className="px-3 py-2">{issue.action_status}</td>
              <td className="px-3 py-2">{date(issue.creation_date)}</td>
              <td className="px-3 py-2">{date(issue.resolution_date)}</td>
              <td className="px-3 py-2">
                {!issue.resolution_date && (
                  <form action={resolveIssueAction}>
                    <input type="hidden" name="issue_id" value={issue.issue_id} />
                    <button
                      type="submit"
                      className="rounded border border-slate-300 px-2 py-0.5 text-xs hover:bg-slate-100 dark:border-slate-700 dark:hover:bg-slate-800"
                    >
                      Resolve
                    </button>
                  </form>
                )}
              </td>
            </tr>
          ))}
        </Table>
        {issues.length === 0 && <p className="text-sm text-slate-500">Nothing to show.</p>}
      </Card>
    </div>
  );
}
