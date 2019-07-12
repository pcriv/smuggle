# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Refactor Export and Import services to allow inject the resolver dependency via construtor.

### Added

- Smuggle::Import::Resolver class.
- Smuggle::Export::Resolver class.

## [0.5.0] - 2019-04-24

### Changed

- `Smuggle::Importer::Base#defined_attributes` has been made `private`.
- Use `find_each` when given scope responds to it. (For when an `ActiveRecord::Relation` is given as scope)

## [0.4.0] - 2018-09-10

### Added

- Import functionality.

### Removed

- Dev dependency on factory_bot.

## 0.3.0 - 2018-08-29

### Added

- Changelog.
- Attribute labels.

[Unreleased]: https://github.com/pablocrivella/statics/compare/v0.5.0...HEAD
[0.5.0]: https://github.com/pablocrivella/statics/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/pablocrivella/statics/releases/tag/v0.4.0
