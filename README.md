# Fencing World & Energy Solutions

A responsive, single-page Flutter Web site for Fencing World & Energy Solutions.
The UI uses GetX for route setup, dependency injection, section navigation, and
quotation-form state.

## Run and build

```sh
flutter pub get
flutter run -d chrome
flutter build web --release
```

## Deploy to GitHub Pages

Pushing to `main` automatically builds and deploys the site with GitHub Actions.
The workflow builds with the `/fw_es/` base path for this repository. In the
GitHub repository settings, set **Pages → Build and deployment → Source** to
**GitHub Actions**. Once the first workflow run succeeds, the site is available
at <https://vikashkp9030.github.io/fw_es/>.

The page is static: the quote form validates in the browser only and does not
send or store submitted information. Connect a backend only when one is
available and the company is ready to receive submissions.

## Branding and imagery

The supplied company logo and fencing photographs are bundled under
`assets/images/` and declared in `pubspec.yaml`. The home page hero, company
overview, and project gallery use these local images. Industry cards continue
to use Unsplash-hosted photos with gradient/icon fallbacks; replace those URLs
with locally hosted or licensed alternatives before deployment if a fully
self-contained build is required.

The phone and email values are clearly marked placeholders near the top of
`home_view.dart`; replace `_phoneDisplay` and `_emailDisplay` with the official
contact details when supplied.
