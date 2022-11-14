flutter gen-l10n --no-synthetic-package --output-dir=lib/hqlocal

--template-arb-file
flutter gen-l10n --no-synthetic-package --template-arb-file=app_en.arb --output-dir=lib/hqlocal

flutter gen-l10n --no-synthetic-package --template-arb-file=app_es.arb --output-dir=lib/hqlocal


flutter pub run intl_translation:appes_es.arb --output-dir=lib/l10n lib/main.dart

会在lib/gen_l10n目录生成代码
flutter gen-l10n --no-synthetic-package  --output-dir=lib/gen_l10n

flutter gen-l10n --template-arb-file=app_zh.arb --no-synthetic-package  --output-dir=lib/gen_l10n
