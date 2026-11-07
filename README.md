# 이력서 웹사이트 + PDF

`index.html` 하나만 수정하면 **웹 이력서**와 **PDF 이력서**가 함께 업데이트됩니다.

```
index.html                    ← 이력서 내용 (여기만 고치면 됨)
style.css                     ← 디자인 (화면용 + @media print 인쇄/PDF용)
.github/workflows/deploy.yml  ← push 하면 PDF 생성 + GitHub Pages 배포
build-pdf.sh                  ← 로컬에서 PDF 미리보기
```

## 동작 방식

1. `main` 브랜치에 push
2. GitHub Actions가 headless Chrome으로 `index.html`을 A4 PDF로 인쇄해서 `resume.pdf` 생성
3. 웹페이지와 `resume.pdf`를 함께 GitHub Pages에 배포
4. 사이트의 **PDF 다운로드** 버튼 → 항상 최신 PDF

## 처음 설정 (한 번만)

1. GitHub에 `minios-x-x.github.io` 이름으로 저장소를 만듭니다 (이 이름이면 주소가 `https://minios-x-x.github.io`가 됨)
2. 이 폴더의 파일을 push 합니다
   ```bash
   git init && git add . && git commit -m "init resume"
   git branch -M main
   git remote add origin https://github.com/minios-x-x/minios-x-x.github.io.git
   git push -u origin main
   ```
3. 저장소 **Settings → Pages → Build and deployment → Source** 를 **GitHub Actions** 로 변경
4. **Actions** 탭에서 워크플로가 끝나면 사이트와 `/resume.pdf`가 열립니다

## 로컬에서 PDF 확인

```bash
./build-pdf.sh
```

Chrome이 없다면 브라우저에서 `index.html`을 열고 **인쇄 → PDF로 저장**해도 같은 결과가 나옵니다
(설정에서 "머리글과 바닥글" 체크 해제).

## 수정 팁

- PDF는 `style.css`의 `@media print` 블록과 `@page` 설정을 따릅니다. 여백, 글자 크기는 여기서 조정하세요.
- PDF가 2페이지로 넘어가면 `@media print`의 `font-size`나 `section { margin-top }`를 조금 줄이세요.
- 항목이 페이지 중간에서 잘리지 않도록 `.item`에 `break-inside: avoid`가 적용되어 있습니다.
- 개인 도메인을 쓰려면 Settings → Pages → Custom domain에 입력하세요.
