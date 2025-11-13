# AutoHotkey Script Search Tool - Design Guidelines

## Design Approach

**Selected Approach:** Design System - Material Design & GitHub-inspired
**Justification:** This is a developer-focused utility tool requiring efficiency, clear information hierarchy, and familiar patterns. Drawing from GitHub's code-centric interface and Material Design's robust component system ensures usability for technical users while maintaining visual polish.

**Key Principles:**
- Information clarity over decorative elements
- Fast visual scanning of search results
- Clear action hierarchy (search, download, generate)
- Code-friendly aesthetics

## Typography

**Font Stack:**
- Primary: Inter (via Google Fonts) - UI elements, body text
- Monospace: Fira Code (via Google Fonts) - code snippets, file names

**Hierarchy:**
- Page Titles: text-3xl font-bold (48px)
- Section Headers: text-2xl font-semibold (32px)
- Card Titles: text-lg font-medium (18px)
- Body Text: text-base (16px)
- Code/Metadata: text-sm font-mono (14px)
- Labels: text-xs uppercase tracking-wide (12px)

## Layout System

**Spacing Primitives:** Tailwind units of 2, 4, 6, and 8
- Component padding: p-4, p-6
- Section margins: mb-6, mb-8
- Element gaps: gap-4, gap-6
- Container spacing: px-4 md:px-8

**Grid System:**
- Max container width: max-w-7xl mx-auto
- Search results: grid-cols-1 lg:grid-cols-2 gap-6
- Script cards: grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4

## Component Library

### Header
- Fixed top navigation with shadow
- Logo/title left, primary navigation center, user actions right
- Search bar prominent in header (expandable on mobile)
- Height: h-16
- Icons: Heroicons (outline style)

### Search Interface
- Large search input: h-12 with rounded-lg borders
- Dual tabs: "GitHub Search" | "My Scripts"
- Filter chips below search (AHK v1, AHK v2, Stars, Recent)
- Advanced filters collapsible panel

### Search Results Cards
Each result card contains:
- Repository name and owner (text-lg font-medium)
- File path in monospace (text-sm)
- Star count and language badge
- Code preview (4-6 lines, syntax highlighted background)
- Action buttons: "View on GitHub" (outline), "Download" (filled)
- Card: rounded-lg border with hover:shadow-lg transition

### Script Library Grid
- Cards with script icon/thumbnail
- Script name (text-lg font-semibold)
- Description (text-sm, 2-line clamp)
- Tags (rounded-full badges)
- Download count and rating
- "Download" and "Preview" buttons

### AI Code Generator Panel
- Prominent textarea for user request (min-h-32)
- "Generate Script" button (large, filled)
- Loading state with progress indicator
- Generated code display with copy button
- Syntax highlighting for AHK code blocks

### Personal Script Manager
- Upload area: dashed border, drag-and-drop zone
- List view toggle (grid/list)
- Each entry: script name, description field, tags input, edit/delete actions
- "Add New Script" floating action button (bottom-right)

### Code Display
- Monospace font throughout
- Line numbers in gutter
- Copy button top-right corner
- Syntax highlighting background panels
- Max height with scroll: max-h-96 overflow-y-auto

### Action Buttons
- Primary (Download, Generate): filled, rounded-md, h-10 px-6
- Secondary (View, Preview): outline, rounded-md, h-10 px-6
- Icon buttons: square, h-10 w-10, rounded-md
- Button groups: gap-2, flex-wrap

### Notifications/Alerts
- Toast notifications: fixed bottom-right, slide-in animation
- Success/error states with appropriate icons
- Dismissible after 4 seconds
- Multiple toasts stack vertically with gap-2

### Modal Dialogs
- Centered overlay with backdrop blur
- Max width: max-w-2xl for forms, max-w-4xl for code preview
- Header with title and close button
- Footer with action buttons right-aligned

### Footer
- Simple single-row layout
- Links: Documentation, GitHub Repo, Report Issue
- Version number and "Open Web App" link (for AHK script users)
- Padding: py-8

## Mobile Optimization

- Search input: full width on mobile
- Results: single column stack
- Collapsible filters into drawer
- Bottom navigation for primary actions
- Larger touch targets: min-h-12

## Animations

**Minimal, Purposeful Motion:**
- Card hover: subtle lift (hover:shadow-lg transition-shadow)
- Button press: slight scale (active:scale-95)
- Toast entrance: slide-in-right
- NO scroll animations, NO parallax, NO unnecessary transitions

## Images

**No hero image required.** This is a utility tool - lead immediately with the search interface.

**Icon Usage:**
- Heroicons throughout (search, download, code, folder, star, external-link)
- Consistent 20px (h-5 w-5) for inline icons
- 24px (h-6 w-6) for standalone buttons

**Script Thumbnails:**
- Use file type icons or category icons (keyboard, mouse, window, automation)
- Fallback: geometric patterns based on script name hash

## Accessibility

- All interactive elements keyboard navigable
- Focus rings: ring-2 ring-offset-2
- ARIA labels on icon-only buttons
- High contrast text throughout
- Screen reader announcements for search results count