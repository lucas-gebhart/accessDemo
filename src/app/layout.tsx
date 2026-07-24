import type { Metadata } from "next";
import Link from "next/link";

import "./globals.css";

export const metadata: Metadata = {
  title: "OpenSLIM",
  description:
    "Simple & Lightweight Infrastructure Manager — a modern rebuild of the Microsoft Access OpenSLIM application",
};

/** One entry per top-level form on the original Access "MainMenu" switchboard. */
const NAV = [
  { href: "/", label: "Dashboard" },
  { href: "/nodes", label: "Nodes" },
  { href: "/projects", label: "Portfolio" },
  { href: "/tasks", label: "Tasks" },
  { href: "/issues", label: "Issues & Risks" },
  { href: "/reference", label: "Reference Data" },
];

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body className="min-h-screen bg-slate-50 text-slate-900 antialiased dark:bg-slate-950 dark:text-slate-100">
        <div className="flex min-h-screen flex-col">
          <header className="border-b border-slate-200 bg-white dark:border-slate-800 dark:bg-slate-900">
            <div className="mx-auto flex max-w-7xl flex-wrap items-center gap-6 px-6 py-3">
              <Link href="/" className="text-lg font-semibold tracking-tight">
                Open<span className="text-sky-600">SLIM</span>
              </Link>
              <nav className="flex flex-wrap gap-4 text-sm">
                {NAV.map((item) => (
                  <Link
                    key={item.href}
                    href={item.href}
                    className="text-slate-600 hover:text-sky-600 dark:text-slate-300"
                  >
                    {item.label}
                  </Link>
                ))}
              </nav>
            </div>
          </header>
          <main className="mx-auto w-full max-w-7xl flex-1 px-6 py-6">{children}</main>
          <footer className="border-t border-slate-200 px-6 py-4 text-xs text-slate-500 dark:border-slate-800">
            Rebuilt from the Microsoft Access application{" "}
            <a className="underline" href="https://github.com/cveira/openslim">
              cveira/openslim
            </a>{" "}
            (openslim-v373b0.mdb).
          </footer>
        </div>
      </body>
    </html>
  );
}
