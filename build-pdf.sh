#!/usr/bin/env bash
# 로컬(macOS)에서 resume.pdf 를 만들어 미리 확인하는 스크립트
# 사용법: ./build-pdf.sh
set -euo pipefail

cd "$(dirname "$0")"

CHROME=""
for c in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
  "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" \
  "$(command -v google-chrome || true)" \
  "$(command -v chromium || true)"; do
  if [ -n "$c" ] && [ -x "$c" ]; then CHROME="$c"; break; fi
done

if [ -z "$CHROME" ]; then
  echo "Chrome 계열 브라우저를 찾지 못했어요. Chrome을 설치하거나, 브라우저에서 index.html을 열고 인쇄 → PDF로 저장하세요." >&2
  exit 1
fi

"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
  --virtual-time-budget=10000 \
  --print-to-pdf="$PWD/resume.pdf" \
  "file://$PWD/index.html"

echo "생성 완료: $PWD/resume.pdf"
