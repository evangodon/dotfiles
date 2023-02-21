#!/usr/bin/env -S deno run --allow-net
import { bold, red } from "https://deno.land/std@0.168.0/fmt/colors.ts";

const TOKEN = "2b0c99ff7106866ec9c1a1d4214e9cb11bb57d7e";
const BASE_URL = "https://api.todoist.com/rest/v2";

const res = await fetch(`${BASE_URL}/tasks?label=computer`, {
  headers: {
    Authorization: `Bearer ${TOKEN}`,
  },
});

const tasks = await res.json();

type Task = {
  content: string;
};

const formatted = tasks.map((task: Task) => {
  return `▢ ${task.content}`;
});

const out = formatted.join("\n");

console.log(red(bold("Today's Tasks")));
console.log(out);
