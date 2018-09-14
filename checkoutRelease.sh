#!/bin/sh

BRANCH=swift-4.2-RELEASE

echo "♻️ \033[1m Resetting the repositories...\033[0m"
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'/.git ] && echo \\* Cleaning '{}' && cd '{}' && git reset --hard HEAD && git clean -fd" \;
echo "📡 \033[1m Pulling remote updates..\033[0m"
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'/.git ] && echo \\* Updating '{}' && cd '{}' && git pull --all && git fetch --tags" \;
echo "✳️ \033[1m Switching all the repositories to ${BRANCH}...\033[0m"
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'/.git ] && echo \\* Switching '{}' to ${BRANCH} && cd '{}' && git checkout ${BRANCH}" \;
echo "✅ \033[1m Applying the required patches...\033[0m"
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'.diffs ] && echo \\* Applying patches to '{}' && cd '{}'  && for f in ../'{}'.diffs/*.diff; do patch -p1 < \$f; done;" \;
