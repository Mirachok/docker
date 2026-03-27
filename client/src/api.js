export function token() {
  return localStorage.getItem("token") || "";
}

export async function api(path, options = {}) {
  const headers = {
    "Content-Type": "application/json",
    ...(options.headers || {}),
  };

  const t = token();
  if (t) headers.Authorization = Bearer ${t};

  const res = await fetch(`/api${path}`, {
    ...options,
    headers,
  });

  const contentType = res.headers.get("content-type") || "";
  let data = null;
  let text = "";

  if (contentType.includes("application/json")) {
    data = await res.json();
  } else {
    text = await res.text();
  }

  if (!res.ok) {
    throw new Error(data?.message  text  `HTTP ${res.status}`);
  }

  return data;
}
