#!/bin/bash
set -e
echo "🚀 Building branching practice environment..."
mkdir -p src
echo "console.log('app');" > src/app.js
git add src/app.js
git commit -m "Initial commit"
echo "✅ Setup complete! Start with EXERCISES.md"
