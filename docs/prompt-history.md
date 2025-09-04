# Prompt History - CrexAgent MCP Setup

This document contains the actual prompts and requests made during the setup process of this React + TypeScript + Vite project with shadcn/ui and Figma integration.

## 📝 Complete Prompt History

### 1. Initial Setup Request

```
Follow instructions in [shadcn-setup.prompt.md](file:///Users/pradip/Documents/Learning/CrexAgent%20%20MCP/.github/shadcn-setup.prompt.md).
```

**Context**: User requested to follow the comprehensive setup guide for React + TypeScript + Vite + Tailwind CSS v4 + shadcn/ui

### 2. Continue Setup

```
Continue: "Continue to iterate?"
```

**Context**: Asking to continue the setup process after initial steps were completed

### 3. Figma Integration Request

```
#mcp_figma-mcp-ser_get_variable_defs
```

**Context**: Using the Figma MCP server tool to extract design variables/tokens from Figma

### 4. Color Mapping Request

```
Map these colors to shadcn/ui's semantic color system (primary, secondary, accent, etc.)
```

**Context**: Request to map the extracted Figma colors to shadcn/ui's semantic color system

### 5. Primary Color Change

```
no Clementine is primary color use that as primary also remove design-token.ts no need to use that only use shadcn/ui's semantic color system
```

**Context**:

- Change primary color from Lochmara to Clementine
- Remove the design-tokens.ts file
- Use only shadcn/ui semantic color system (no custom TypeScript constants)

### 6. Cleanup Request

```
remove other unused color var
```

**Context**: Remove unused color variables from CSS (sidebar colors, old chart colors, etc.)

### 7. Try Again Request

```
Try Again
```

**Context**: Request to retry something (likely after an error or issue)

### 8. Codebase Analysis Request

```
Analyze this codebase to generate or update `.github/copilot-instructions.md` for guiding AI coding agents.

Focus on discovering the essential knowledge that would help an AI agents be immediately productive in this codebase. Consider aspects like:
- The "big picture" architecture that requires reading multiple files to understand - major components, service boundaries, data flows, and the "why" behind structural decisions
- Critical developer workflows (builds, tests, debugging) especially commands that aren't obvious from file inspection alone
- Project-specific conventions and patterns that differ from common practices
- Integration points, external dependencies, and cross-component communication patterns

Source existing AI conventions from `**/{.github/copilot-instructions.md,AGENT.md,AGENTS.md,CLAUDE.md,.cursorrules,.windsurfrules,.clinerules,.cursor/rules/**,.windsurf/rules/**,.clinerules/**,README.md}` (do one glob search).

Guidelines (read more at https://aka.ms/vscode-instructions-docs):
- If `.github/copilot-instructions.md` exists, merge intelligently - preserve valuable content while updating outdated sections
- Write concise, actionable instructions (~20-50 lines) using markdown structure
- Include specific examples from the codebase when describing patterns
- Avoid generic advice ("write tests", "handle errors") - focus on THIS project's specific approaches
- Document only discoverable patterns, not aspirational practices
- Reference key files/directories that exemplify important patterns

Update `.github/copilot-instructions.md` for the user, then ask for feedback on any unclear or incomplete sections to iterate.
```

**Context**: Request to analyze the codebase and create comprehensive Copilot instructions for AI agents

### 9. Git Commit Request

```
commit it as init commit
```

**Context**: Request to commit all changes as the initial commit to git repository

### 10. Symbol Reference

```
#sym:figmaTokens
```

**Context**: Referencing the figmaTokens symbol from design-tokens.ts file

### 11. MCP Server Reference

```
#figma-mcp-server
```

**Context**: Reference to work with the Figma MCP server functionality

### 12. Documentation Request

```
now give me a on doument for all process i have permone previusly with promnts
```

**Context**: Request for documentation of all processes performed, including the prompts used

### 13. Prompt History Request

```
no i need to add md file here i have already md so you give me promnt histoy wich i have give you
```

**Context**: Clarification that user wants the actual prompt history that they gave, not just process documentation

## 🔄 Prompt Patterns Observed

### Command-Style Prompts

- Direct tool references: `#mcp_figma-mcp-ser_get_variable_defs`
- Symbol references: `#sym:figmaTokens`
- Service references: `#figma-mcp-server`

### Instruction-Style Prompts

- File references: `Follow instructions in [file-path]`
- Specific changes: `remove other unused color var`
- Configuration changes: `Clementine is primary color`

### Analysis-Style Prompts

- Comprehensive requests with detailed requirements
- Multiple bullet points and guidelines
- Reference to external documentation

### Action-Style Prompts

- `commit it as init commit`
- `Try Again`
- `Continue to iterate`

## 🎯 Key Decisions Made Through Prompts

1. **Setup Foundation**: Follow comprehensive shadcn setup guide
2. **Figma Integration**: Extract design tokens via MCP server
3. **Color System**: Map Figma colors to shadcn/ui semantics
4. **Primary Color**: Change from Lochmara to Clementine
5. **Simplification**: Remove design-tokens.ts, use only CSS approach
6. **Code Quality**: Create AI agent instructions
7. **Documentation**: Record complete process and prompt history

## 📋 Prompt Categories

### Setup & Configuration

- Initial project setup
- Tool integration
- Color system configuration

### Refinement & Cleanup

- Color mapping changes
- File removal/cleanup
- Variable cleanup

### Documentation & Analysis

- Codebase analysis
- AI agent instructions
- Process documentation
- Prompt history

### Version Control

- Git commits
- Project finalization

---

**Note**: This represents the actual conversation flow and specific requests made during the project setup process.
