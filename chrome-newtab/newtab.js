const clockEl = document.getElementById("clock");
const dateEl = document.getElementById("date");

function tick() {
  const now = new Date();
  const hh = String(now.getHours()).padStart(2, "0");
  const mm = String(now.getMinutes()).padStart(2, "0");
  clockEl.textContent = `${hh}:${mm}`;
  dateEl.textContent = now.toLocaleDateString(undefined, {
    weekday: "long",
    day: "numeric",
    month: "long",
  });
}

tick();
setInterval(tick, 10_000);

document.getElementById("search").addEventListener("submit", (e) => {
  e.preventDefault();
  const q = document.getElementById("q").value.trim();
  if (q) {
    window.location.href = "https://www.google.com/search?q=" + encodeURIComponent(q);
  }
});
