import 'package:material_ui/material_ui.dart';

// ---------------------------------------------------------------------------
// Enhancement 4: the app's own name.
// ---------------------------------------------------------------------------
/// "Tambayan" is Filipino for a hangout spot, the place where barkadas
/// gather to chat. It's shown in the AppBar logo and as the app title.
const String kAppName = 'Tambayan';

/// The signed-in user (used for the comment box and the Profile tab).
const String kCurrentUser = 'Mhark Denver Merete';

// ---------------------------------------------------------------------------
// Enhancement 5: color palette ("Twilight Tambayan": violet + coral).
// The variable names are kept so every widget that already uses them
// picks up the new colors automatically.
// ---------------------------------------------------------------------------
const Color fbPrimary = Color(0xFF6C3CE1); // violet: logo, links, active icons
const Color fbSecondary = Color(0xFFFF7A59); // coral: badges, highlights
const Color fbDarkPrimary = Color(0xFF3B1F8C); // deep violet: headers, text
const Color fbLightPrimary = Color(0xFFB9A4F5); // lavender: borders, accents
const Color fbTextColorWhite = Color(0xFFFFFFFF);

// Supporting colors
const Color fbBackground = Color(0xFFF5F2FC); // page background
const Color fbUnreadTint = Color(0xFFEDE6FD); // unread notification row
const Color fbTextDark = Color(0xFF1E1B2E); // main text
const Color fbTextGrey = Color(0xFF6E6A80); // dates, counts, hints
