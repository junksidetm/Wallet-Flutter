# Wallet-Flutter — Improvement Plan & Milestones

> Branch: `Improv` · Baseline: v4.5.5 (main) + Improv UI work · Written 2026-10-14
> Goal: more **Material 3 Expressive**, more **efficient**, more **capable**, more **robust**.
> Verification is CI-only (no local builds). Each milestone ends with a green `Build Wallet APKs` run.

## Baseline audit (what the code looks like today)

Measured on `Improv` after the main merge (generated `*.g.dart` and `isar_community/` excluded).

| Area | Finding | Where |
|---|---|---|
| Size | Release APK is **88 MB** (split) / **107 MB** (universal). 65 MB of fonts are in `assets/fonts`, including a 27 MB iOS emoji font and 35 MB of icon fonts that were declared twice. | `pubspec.yaml`, CI `--no-tree-shake-icons` |
| Money | Amounts and balances are stored as `double`. The `decimal` dependency is declared but never used (0 call sites). | `transaction_model.dart:16`, `account.dart:29` |
| Data | 32 `findAll()` calls; statistics load whole collections into Dart and aggregate there, on the UI isolate. No `compute()`/isolate anywhere. | `statistics_service.dart` (16 calls), `json_service.dart`, `csv_service.dart` |
| Startup | `main()` awaits notification init before `runApp`. Every repository/service provider does `ref.watch(isarProvider).value!` (22×), so any read during loading crashes. | `main.dart`, `providers.dart` |
| Errors | 47 `catch` blocks, 10 of them empty `catch (_) {}`. | notification, update, csv, auth, icon picker |
| Design tokens | 149 `Color(0x…)` + 144 `Colors.*` literals; 190 inline `fontSize:`; 159 inline `TextStyle(`; 30 hard-coded `Duration(milliseconds:)`. | personalization, theme selection, loans, transaction tile, reports |
| Accessibility | 0 `Semantics` widgets. 25 of 28 `IconButton`s had no tooltip (fixed in 5.1.2). | app-wide |
| Lints | `deprecated_member_use` and `use_build_context_synchronously` are silenced; 8 `withOpacity` calls remain. | `analysis_options.yaml` |
| Tests | 64 lines in total (2 files). CI runs neither `flutter analyze` nor `flutter test`. | `test/`, `build_apks.yml` |
| CI/parity | GitHub Actions only. No `.gitlab-ci.yml` or `.forgejo/workflows`, so GitLab and Codeberg have no builds, Pages or releases. Flutter is on unpinned `stable`. | repo root |
| Repo hygiene | Vendored `isar_community/` (358 files); build output tracked in git (`android/build/reports/...`). | repo root |

---

## M0 — Housekeeping & correctness ✅ (done in v5.1.2)

| What | How |
|---|---|
| Branches | Only `main` and `Improv` remain. `sandbox/Improv` was merged in first, so its landing-page redesign is kept. The Dependabot branches were deleted; their bumps are folded into M6. |
| Tags/releases | Removed `v.4.5.5` (typo duplicate of v4.0.5), `v1.4.1` (same commit as v2.0.1) and `v1.0.0-b12`. Renamed `v1.0.0-b14` → `v4.5.5` (release "Wallet v4.5.5"). Same tag set on GitHub, GitLab and Codeberg. |
| Release tagging | CI now tags `v<pubspec version>` and releases only once per version. Notes come from `release-notes/v<version>.md`. |
| Links | In-app links, the updater API and the landing page point to `github.com/junksidetm/Wallet-Flutter`. |
| Robustness | Recurring check runs once per launch. Isar inspector is debug-only. Updater version compare tolerates suffixes. |
| Size | Removed 7 unused icon font declarations (~35 MB). |
| A11y | Tooltips added to 25 icon buttons. |
| Merge fixes | Removed placeholder cards from Home; carousel cards are tappable; Accounts page dots follow the carousel. |

## M1 — Robustness (target v5.2.0)

1. **Money as integer minor units.** Add `int amountMinor` / `balanceMinor` fields, keep reading the `double` fields, and migrate with a one-time Isar write txn guarded by a `schemaVersion` pref. Do the math with `decimal` (already a dependency) in `CurrencyEngine`. Remove the `double` fields one release later.
2. **Provider safety.** Replace `ref.watch(isarProvider).value!` with `requireValue` behind a single `isarReadyProvider`, and gate the router on it so nothing reads the DB before it opens.
3. **Error handling.** Replace the 10 empty catches with `LogService.logError(...)`. Return typed `Result`s from backup/restore/CSV import, and have the UI show actionable messages instead of `Text('Error: $err')`.
4. **Backup integrity.** Add a schema version, a SHA-256 checksum and a dry-run validation before restore. Make restore atomic (single `writeTxn`, rollback on failure).
5. **Startup.** Call `runApp` first, then initialise notifications in the background. Show a branded splash instead of a bare spinner.
6. **Tests.** Unit tests for `CurrencyEngine`, `DebtPayoffEngine`, `StreakEngine`, `RecurringService` (no double-posting), a CSV/JSON round-trip and `UpdateService.isNewerVersion`. Add `flutter analyze --no-fatal-infos` and `flutter test` as CI steps before the build.

## M2 — Efficiency (target v5.3.0)

1. **Push aggregation into Isar.** Use `.amountProperty().sum()`, `count()` and indexed `where()` ranges on `date` and `accountId` instead of `findAll()` + Dart loops (16 call sites in `StatisticsService`).
2. **Off the UI isolate.** Run CSV/JSON export/import and heavy report math via `Isolate.run`.
3. **Fewer rebuilds.** Use `ref.watch(provider.select(...))` in hot widgets (home hero, transaction tiles). Wrap charts and the animated balance hero in `RepaintBoundary`. Paginate the all-transactions list with slivers.
4. **APK size, round 2.**
   - The 27 MB `AppleColorEmoji` fallback font: subset it to the emoji actually used, make it a downloadable option, or drop it in favour of system Noto.
   - Remove `--no-tree-shake-icons`. This needs the icon picker to keep const icon tables, or a curated subset.
   - Target: split APK under 40 MB.
5. **Gradle.** Keep the 2 GB daemon limit (4 GB host). Watch CI for R8 OOM and raise the limit only in CI via `GRADLE_OPTS`.

## M3 — Material 3 Expressive design system (target v5.4.0)

Check https://m3.material.io/ and the current Flutter release notes before each item. Use framework widgets where Flutter ships them, otherwise in-house widgets in `lib/core/widgets/` (several already exist).

1. **Tokens first.**
   - Colour: move the 293 literal colours to `ColorScheme` roles plus a `ThemeExtension` for finance semantics (income, expense, transfer, debt).
   - Type: map the 190 inline sizes onto the M3 type scale, using GoogleSansFlex variable axes (`wght`, `wdth`, `ROND`, `GRAD`).
   - Shape: corner-family scale (extra-small → extra-large, full) in `expressive_shape.dart`.
   - Motion: spring tokens (spatial/effects × fast/default/slow) replacing the 30 hard-coded durations.
2. **Components.**
   - Button groups and split buttons for transaction type and filters.
   - Shape-morphing loading indicator instead of the 31 `CircularProgressIndicator`s.
   - FAB menu (the `ExpressiveMorphingFab` exists).
   - Wire up `TransactionSearchAnchor` and `ExpressiveSegmentedControl`.
   - Large/medium flexible top app bars.
   - Navigation bar with an expressive active indicator.
3. **Tactile keypad.** Bring `TactileKeypad` into Add Transaction as an option (setting: system keyboard / keypad). The 5.1.2 merge kept main's layout because the keypad version conflicted.
4. **Motion & haptics.** Shared-axis/container transforms for routes. Pair haptics with key interactions via `HapticService`. Respect `MediaQuery.disableAnimations` (reduce motion).
5. **Consistency pass.** Make settings, loans, reports and people use the connected segmented groups and the same card and surface tones.

## M4 — Capability (target v5.5.0)

- Receipts: photo attachments per transaction (`image_picker` and `image_cropper` are already dependencies).
- Budgets: monthly rollover, category caps and alert thresholds as notifications.
- Recurring: skip, snooze and "post now", plus an upcoming-bills timeline.
- Multi-currency: per-account currency with a cached FX table (offline fallback) via `ExchangeRateService`.
- Encrypted backups: password-protected archive, plus scheduled auto-backup to a user-picked folder (SAF).
- CSV import: column-mapping wizard for other apps' exports.
- Home-screen widget and quick-add shortcut (`shortcuts_util.dart` exists).
- App lock: auto-lock timeout and hiding app content in recents.

## M5 — Accessibility (runs alongside M3)

- `Semantics` labels on charts (summary text), the balance hero and custom tiles; merge semantics on list rows.
- Text scaling to 200% without overflow (FittedBox/wrap audit); 48 dp minimum touch targets.
- Contrast check of finance colours in light, dark and dynamic schemes.
- Turn `use_build_context_synchronously` back on and fix the warnings it reports.

## M6 — Dependencies & toolchain

- Apply the Dependabot bumps by hand: `local_auth` 3.x, `image_cropper` 12.x, `flutter_local_notifications` 22.x, `flutter_secure_storage` 10.3.x, `path_provider` 2.1.6, plus the GitHub Actions bumps (checkout, setup-java, upload-artifact). Do them one at a time, with a CI run each.
- Evaluate Riverpod 3 and code-gen providers. Replace the 8 legacy `StateNotifier`s.
- Replace vendored `isar_community/` with the published package if it builds in CI. Untrack `android/build/`.
- Pin the Flutter version in CI for reproducible releases.
- Turn `deprecated_member_use` back on and finish the `withOpacity` → `withValues` migration.

## M7 — CI/CD & mirror parity

- Add `.gitlab-ci.yml` and `.forgejo/workflows/build.yml` that build the same signed APKs (same keystore secrets), publish GitLab/Codeberg Pages, and create releases with the same notes and assets.
- Generate a changelog from `release-notes/`.
- Fix the `tea` (Codeberg CLI) login on the workstation; the current token is malformed.

## Release cadence

| Version | Contents |
|---|---|
| **5.1.2** | M0 (this release) |
| 5.2.x | M1 robustness + tests in CI |
| 5.3.x | M2 efficiency + size |
| 5.4.x | M3 design system + M5 accessibility |
| 5.5.x | M4 capability |
| ongoing | M6, M7 |

Release flow: work on `Improv` → green CI → bump `pubspec.yaml` + add `release-notes/v<ver>.md` → merge into `main` → CI tags `v<ver>` and publishes the release → `scripts/sync-mirrors.ps1`.
