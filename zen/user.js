// Zen prefs for the Espresso (Blur) theme.
// Symlinked into the active profile; applied on Zen startup.

// Enable userChrome.css / userContent.css loading.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Allow a transparent browser window so the macOS system blur shows through.
user_pref("browser.tabs.allow_transparent_browser", true);

// Sidebar bookmarks mod (zen/mods/sidebar-bookmarks.css): hide folder icons.
user_pref("zen.sidebar.bookmarks.hide-folder-icon", true);
