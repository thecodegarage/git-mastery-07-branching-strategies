#!/bin/bash
set -e

cd "$(dirname "$0")"

echo "🚀 Building branching practice environment..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if src/ directory already exists
if [ -d "src" ]; then
    echo -e "${YELLOW}⚠️  Warning: Practice environment already exists${NC}"
    read -p "Delete and rebuild? This will reset all practice work. (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting. Run script again when ready to reset."
        exit 1
    fi
    
    echo -e "${BLUE}🧹 Cleaning up existing practice environment...${NC}"
    git reset --hard origin/master 2>/dev/null || git reset --hard HEAD~10 2>/dev/null || true
    git branch | grep -v "^\*" | grep -v "master" | grep -v "main" | xargs -r git branch -D 2>/dev/null || true
    rm -rf src/
    echo -e "${GREEN}✅ Cleanup complete${NC}"
    echo ""
fi

echo -e "${BLUE}📁 Creating project structure...${NC}"
mkdir -p src features tests

# Git Flow demonstration - Release management
export GIT_AUTHOR_NAME="Release Manager"
export GIT_AUTHOR_EMAIL="release@company.com"
export GIT_COMMITTER_NAME="Release Manager"
export GIT_COMMITTER_EMAIL="release@company.com"

# Create 40 commits demonstrating branching strategies
for i in {1..40}; do
    export GIT_AUTHOR_DATE="2024-01-$(printf "%02d" $((i/2+1)))T$(printf "%02d" $((i%24))):00:00"
    export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
    
    case $i in
        1)
            cat > src/app.js << 'EOF'
const App = { version: '1.0.0' };
module.exports = App;
EOF
            git add src/app.js
            git commit -m "Initial release v1.0.0"
            ;;
        2|3|4|5|6|7|8)
            echo "// Main feature $i" >> src/app.js
            git add src/app.js
            git commit -m "Feature: Add functionality $i"
            ;;
        9)
            cat > features/feature-a.js << 'EOF'
module.exports = { name: 'Feature A' };
EOF
            git add features/feature-a.js
            git commit -m "Start Feature A development"
            ;;
        10|11|12|13|14|15)
            echo "// Feature A - part $i" >> features/feature-a.js
            git add features/feature-a.js
            git commit -m "Feature A: Implement part $((i-9))"
            ;;
        16)
            cat > features/feature-b.js << 'EOF'
module.exports = { name: 'Feature B' };
EOF
            git add features/feature-b.js
            git commit -m "Start Feature B development"
            ;;
        17|18|19|20|21|22)
            echo "// Feature B - iteration $i" >> features/feature-b.js
            git add features/feature-b.js
            git commit -m "Feature B: Development iteration $((i-16))"
            ;;
        23)
            cat > src/hotfix.js << 'EOF'
module.exports = { fix: 'Critical bug fix' };
EOF
            git add src/hotfix.js
            git commit -m "Hotfix: Critical production bug"
            ;;
        24|25|26|27|28)
            echo "// Release preparation $i" >> src/app.js
            git add src/app.js
            git commit -m "Release: Prepare v1.1.0 ($i)"
            ;;
        29)
            cat > tests/integration.test.js << 'EOF'
describe('Integration Tests', () => {});
EOF
            git add tests/integration.test.js
            git commit -m "Add integration tests"
            ;;
        30|31|32|33|34)
            echo "// Test case $i" >> tests/integration.test.js
            git add tests/integration.test.js
            git commit -m "Test: Add test case $i"
            ;;
        35|36|37|38)
            echo "// Refinement $i" >> src/app.js
            git add src/app.js
            git commit -m "Refine implementation ($i)"
            ;;
        39)
            cat > CHANGELOG.md << 'EOF'
# Changelog

## v1.1.0
- Feature A
- Feature B
- Bug fixes
EOF
            git add CHANGELOG.md
            git commit -m "Update changelog for v1.1.0"
            ;;
        40)
            cat > src/app.js << 'EOF'
const App = { version: '1.1.0' };
module.exports = App;
EOF
            git add src/app.js
            git commit -m "Release v1.1.0"
            ;;
    esac
done

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo -e "${BLUE}📊 Created 40 commits demonstrating branching strategies${NC}"
echo ""
echo "Next steps:"
echo "  1. Verify: git log --oneline --graph --all"
echo "  2. Start exercises: open EXERCISES.md"
echo ""
echo "To reset and start over, just run ./build-history.sh again"
