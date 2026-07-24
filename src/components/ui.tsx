import Link from "next/link";
import type { ReactNode } from "react";

export function Card({
  title,
  action,
  children,
}: {
  title?: string;
  action?: ReactNode;
  children: ReactNode;
}) {
  return (
    <section className="rounded-lg border border-slate-200 bg-white shadow-sm dark:border-slate-800 dark:bg-slate-900">
      {(title || action) && (
        <header className="flex items-center justify-between border-b border-slate-200 px-4 py-3 dark:border-slate-800">
          {title && <h2 className="text-sm font-semibold tracking-wide uppercase">{title}</h2>}
          {action}
        </header>
      )}
      <div className="p-4">{children}</div>
    </section>
  );
}

export function Stat({
  label,
  value,
  hint,
  href,
}: {
  label: string;
  value: ReactNode;
  hint?: string;
  href?: string;
}) {
  const body = (
    <div className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm transition hover:border-sky-400 dark:border-slate-800 dark:bg-slate-900">
      <div className="text-xs font-medium tracking-wide text-slate-500 uppercase">{label}</div>
      <div className="mt-1 text-3xl font-semibold">{value}</div>
      {hint && <div className="mt-1 text-xs text-slate-500">{hint}</div>}
    </div>
  );
  return href ? <Link href={href}>{body}</Link> : body;
}

/**
 * The Access reports colour every record by its KPI status row
 * (TblKpiStatus: 5=Green, 6=Yellow, 7=Orange, 8=Red).
 */
const KPI_STYLES: Record<number, { label: string; className: string }> = {
  1: { label: "Unknown", className: "bg-slate-100 text-slate-700" },
  2: { label: "N/A", className: "bg-slate-100 text-slate-700" },
  3: { label: "Unavailable", className: "bg-slate-100 text-slate-700" },
  4: { label: "Unassigned", className: "bg-slate-100 text-slate-700" },
  5: { label: "Green", className: "bg-emerald-100 text-emerald-800" },
  6: { label: "Yellow", className: "bg-yellow-100 text-yellow-800" },
  7: { label: "Orange", className: "bg-orange-100 text-orange-800" },
  8: { label: "Red", className: "bg-red-100 text-red-800" },
};

export function KpiBadge({ status }: { status: number }) {
  const kpi = KPI_STYLES[status] ?? KPI_STYLES[1];
  return (
    <span className={`rounded px-2 py-0.5 text-xs font-medium ${kpi.className}`}>{kpi.label}</span>
  );
}

export function Badge({ children, tone = "slate" }: { children: ReactNode; tone?: "slate" | "green" | "red" }) {
  const tones = {
    slate: "bg-slate-100 text-slate-700",
    green: "bg-emerald-100 text-emerald-800",
    red: "bg-red-100 text-red-800",
  } as const;
  return <span className={`rounded px-2 py-0.5 text-xs font-medium ${tones[tone]}`}>{children}</span>;
}

export function Progress({ value }: { value: number }) {
  const pct = Math.min(Math.max(value, 0), 100);
  return (
    <div className="flex items-center gap-2">
      <div className="h-2 w-24 overflow-hidden rounded bg-slate-200 dark:bg-slate-700">
        <div className="h-full bg-sky-500" style={{ width: `${pct}%` }} />
      </div>
      <span className="text-xs tabular-nums text-slate-500">{pct.toFixed(0)}%</span>
    </div>
  );
}

export function BarList({ rows }: { rows: { label: string; total: number }[] }) {
  const max = Math.max(1, ...rows.map((row) => row.total));
  if (rows.length === 0) return <p className="text-sm text-slate-500">No data.</p>;
  return (
    <ul className="space-y-2">
      {rows.map((row) => (
        <li key={row.label} className="grid grid-cols-[10rem_1fr_2.5rem] items-center gap-2">
          <span className="truncate text-sm" title={row.label}>
            {row.label}
          </span>
          <span className="h-2 rounded bg-slate-200 dark:bg-slate-700">
            <span
              className="block h-full rounded bg-sky-500"
              style={{ width: `${(row.total / max) * 100}%` }}
            />
          </span>
          <span className="text-right text-sm tabular-nums">{row.total}</span>
        </li>
      ))}
    </ul>
  );
}

export function Table({ head, children }: { head: string[]; children: ReactNode }) {
  return (
    <div className="overflow-x-auto">
      <table className="w-full border-collapse text-sm">
        <thead>
          <tr className="border-b border-slate-200 text-left text-xs tracking-wide text-slate-500 uppercase dark:border-slate-800">
            {head.map((label) => (
              <th key={label} className="px-3 py-2 font-medium whitespace-nowrap">
                {label}
              </th>
            ))}
          </tr>
        </thead>
        <tbody className="divide-y divide-slate-100 dark:divide-slate-800">{children}</tbody>
      </table>
    </div>
  );
}

export function Field({ label, children }: { label: string; children: ReactNode }) {
  return (
    <div className="flex flex-col gap-1">
      <span className="text-xs font-medium tracking-wide text-slate-500 uppercase">{label}</span>
      <span className="text-sm">{children}</span>
    </div>
  );
}
