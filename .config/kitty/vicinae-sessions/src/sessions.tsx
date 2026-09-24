import { Action, ActionPanel, List, Toast, closeMainWindow, showToast } from "@vicinae/api";
import { useEffect, useState } from "react";
import { readdir } from "node:fs/promises";
import { homedir } from "node:os";
import { join } from "node:path";
import { spawn } from "node:child_process";

const directory = join(process.env.XDG_CONFIG_HOME || join(homedir(), ".config"), "kitty", "sessions");
const extension = /\.(kitty-session|kitty_session|session)$/;

async function launch(file: string) {
  try {
    // No shell interpolation: filenames containing spaces are safe.
    await new Promise<void>((resolve, reject) => {
      const child = spawn("/usr/bin/kitty", ["--session", join(directory, file)], {
        detached: true,
        stdio: "ignore",
      });
      child.once("error", reject);
      child.once("spawn", () => { child.unref(); resolve(); });
    });
    await closeMainWindow();
  } catch (error) {
    await showToast({ style: Toast.Style.Failure, title: "Could not launch Kitty", message: String(error) });
  }
}

export default function Sessions() {
  const [files, setFiles] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    let disposed = false;
    let timer: ReturnType<typeof setTimeout>;
    async function refresh() {
      try {
        const entries = await readdir(directory, { withFileTypes: true });
        const next = entries
          .filter((entry) => (entry.isFile() || entry.isSymbolicLink()) && extension.test(entry.name))
          .map((entry) => entry.name)
          .sort((a, b) => a.localeCompare(b));
        if (!disposed) { setFiles(next); setError(""); }
      } catch (error) {
        if (!disposed) { setFiles([]); setError(String(error)); }
      } finally {
        if (!disposed) {
          setLoading(false);
          timer = setTimeout(refresh, 2000);
        }
      }
    }
    void refresh();
    return () => { disposed = true; clearTimeout(timer); };
  }, []);

  return (
    <List isLoading={loading} searchBarPlaceholder="Search Kitty sessions…">
      <List.EmptyView title={error ? "Cannot read sessions" : "No sessions found"} description={error || directory} />
      {files.map((file) => (
        <List.Item
          key={file}
          id={file}
          title={file.replace(extension, "")}
          subtitle={file}
          icon="icon.svg"
          actions={
            <ActionPanel>
              <Action title="Open in New Kitty Window" onAction={() => launch(file)} />
            </ActionPanel>
          }
        />
      ))}
    </List>
  );
}
