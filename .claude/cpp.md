# C++ Style and Dependencies

## C++ Style

- Make effective use of the pImpl idiom: `struct M; std::shared_ptr<M> m;` (or `unique_ptr`).

## Dependencies

- Favour header-only libraries over compiled ones when a suitable option exists.
- Prefer vendored submodules over homebrew installs where practicable.
- When bringing in third-party repos, submodule them into `vendor/github.com/<org>/<repo>` (or `bitbucket.com`, etc).
- When bringing in single `.h` libraries, put them in `vendor/include`.
- If there's an associated `.c`/`.cpp`, put it in `vendor/src`.
- Use spdlog for logging. Never use printf/fprintf for diagnostic output. Prefer the `SPDLOG_INFO`, `SPDLOG_WARN`, `SPDLOG_ERROR`, etc. macros over direct `spdlog::info`/`spdlog::error` calls, as the macros automatically include source file and line information.
- Preferred libraries (use these unless there is a strong reason not to):
  - **Rendering**: bgfx (with bx/bimg utilities)
  - **Windowing/input**: SDL3 (+ SDL3_image, SDL3_ttf)
  - **Logging**: spdlog (header-only)
  - **Linear algebra**: linalg.h (header-only)
  - **Testing**: doctest (header-only)
  - **Image I/O**: stb_image / stb_image_write (header-only)
  - **Triangulation**: earcut.hpp (header-only), Triangle (C library for quality meshes)
  - **Database**: SQLite3
- When vendoring third-party code, always include the dependency's original LICENSE file alongside it. For distributed projects, maintain a NOTICES file (or THIRD_PARTY if one already exists) with attribution for all bundled dependencies.
