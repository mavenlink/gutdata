Here are details of the initial process of renaming things to "gut data"

The following was done only on these directories (they were moved to another directory that was opened in vscode to rename things):
- `bin/`
- `lib/`
- `spec/`
- `tmp/`

The only files changed not in those directories were
- `./gooddata` # File renamed to `.gutdata`; `GoodData` replaced with `GutData` and `gooddata` replaced with `gutdata`
- `./gooddata.gemspec` # File renamed to `./gutdata.gemspec`; `GoodData` replaced with `GutData` and `gooddata` replaced with `gutdata` except for the email and homepage lines

Search and replace done in vscode
Case sensitive on

Search for "GoodData::"
1407 results in 200 files
Replace all with "GutData::"

Search for "Copyright (c) 2010-2015 GoodData Corporation"
308 results in 308 files
Replace all with "Copyright (c) 2010-2015 GutData Corporation"

Search for "module GoodData"
186 results in 186 files
Replace all with "module GutData"

Search for "GoodDataMiddleware"
5 results in 3 files
Replace all with "GutDataMiddleware"

Search for "# GoodData"
8 results in 7 files
Replace all with "# GutData"

Search for "GoodData.logger"
72 results in 13 files
Replace all with "GutData.logger"

Search for "GoodData.connect"
112 results in 47 files
Replace all with "GutData.connect"

Search for "GoodData.logging_on"
4 results in 2 files
Replace all with "GutData.logging_on"

Search for "GoodData.logging_off"
5 results in 3 files
Replace all with "GutData.logging_off"

Search for "GoodData."
71 results in 31 files
Verified they were all either method calls or comments
Replace all with "GutData."

Search for "GoodData"
51 results in 24 files
Replaced occurrences in ruby comments, README, "describe GoodData"

Search for "GoodData"
21 results in 11 files
shared.rb (5)
api.rb (2)
auth.rb (2)
workspace.prm (2)
blueprint_updates_spec.rb (1)
blueprint_with_grain_spec.rb (1)
create_project_spec.rb (1)
full_process_schedule_spec.rb (3)
schedule_spec.rb (2)
logging_spec.rb (1)
project_spec.rb (1)
Replace all with "GutData"

Search for "require 'gutdata"
129 results in 95 files
Replace all with "require 'gutdata"

Search for "require_relative 'gooddata"
13 results in 1 file (gooddata.rb)
Replace all with "require_relative 'gutdata"

Search for "gooddata.com"
237 results in 35 files
Replace all temporarily with "ZZZCOMEBACK111ZZZ"

Search for "gooddata"
78 results in 27 files
Replace all in comments (with the exception of a few comments talking about urls) and in requires with "gutdata"

Search for ".gooddata"
9 results in 4 files
Replace all with ".gutdata" except for those in domain.rb (yes to replacing relative file paths. no to replacing urls)

Search for "lib/gooddata"
9 results in 1 file (spec_helper.rb)
Replace all with "lib/gutdata"

Search for "require 'gutdata/bricks/middleware/gooddata_middleware'"
1 result
Replace with "require 'gutdata/bricks/middleware/gutdata_middleware'"

Search for "./spec/data/gooddata_version_process/gooddata_version.zip"
3 results in 2 files
Replace with "./spec/data/gutdata_version_process/gutdata_version.zip"

Search for "gooddata"
36 results in 16 files
Leave all these. They seem to all fall in these categories:
- used for domain names
- inconsequential strings
- test data
- tempfile names
- cli params
- in gem_version_string
- "DATA_GOODDATA_DIR=${PROJECT}/data/gooddata" in workspace.prm - not sure if this one needs to be changed or not. Note this is also the only occurrence of "GOODDATA". It has been left how it was

Search for "ZZZCOMEBACK111ZZZ"
237 results in 35 files
Replace all with "gooddata.com"

Files renamed

bin/gooddata -> bin/gutdata
lib/gooddata.rb -> lib/gutdata.rb
lib/gooddata/ -> lib/gutdata/
gooddata_middleware.rb -> gutdata_middleware.rb
gooddata_middleware_spec.rb -> gutdata_middleware_spec.rb
gooddata_version.rb -> gutdata_version.rb
gooddata_version.zip -> gutdata_version.zip
.gooddata -> .gutdata
spec/data/gooddata_version_process/ -> spec/data/gutdata_version_process/

Second round of renames (in whole directory):
Search for "# Copyright (c) 2010-2015 GutData Corporation. All rights reserved."
199 results in 199 files - all in lib/
Replace all with "# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved."

Case sensitive on
Search for "require 'gooddata"
128 results in 94 files
Replace with "require 'gutdata"

