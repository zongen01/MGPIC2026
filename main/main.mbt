///|
using @html {a, button, div, h1, h2, h3, li, span, ul}

///|
using @rabbita {type Dispatch, type Html}

///|
enum Lang {
  Zh
  En
}

///|
enum Theme {
  Light
  Dark
}

///|
enum Msg {
  ToggleLang
  ToggleTheme
}

///|
struct Model {
  lang : Lang
  theme : Theme
}

///|
fn next_lang(lang : Lang) -> Lang {
  match lang {
    Zh => En
    En => Zh
  }
}

///|
fn next_theme(theme : Theme) -> Theme {
  match theme {
    Light => Dark
    Dark => Light
  }
}

///|
fn update(msg : Msg, model : Model) -> Model {
  match msg {
    ToggleLang => { ..model, lang: next_lang(model.lang) }
    ToggleTheme => { ..model, theme: next_theme(model.theme) }
  }
}

///|
fn root_class(theme : Theme) -> String {
  match theme {
    Light => "site light"
    Dark => "site dark"
  }
}

///|
fn lang_button_label(lang : Lang) -> String {
  match lang {
    Zh => "EN"
    En => "中文"
  }
}

///|
fn theme_button_label(lang : Lang, theme : Theme) -> String {
  match lang {
    Zh => match theme {
      Light => "夜间"
      Dark => "日间"
    }
    En => match theme {
      Light => "Dark"
      Dark => "Light"
    }
  }
}

///|
fn topbar(dispatch : Dispatch[Msg], model : Model) -> Html {
  div(class="topbar", [
    div(class="brand", [
      div(class="brand-mark", "M"),
      div(class="brand-text", [
        div(class="brand-title", "MGPIC 2026"),
        div(class="brand-subtitle", "MoonBit Open Source Challenge"),
      ]),
    ]),
    div(class="toolbar", [
      button(class="toolbar-btn", on_click=dispatch(ToggleLang), lang_button_label(model.lang)),
      button(
        class="toolbar-btn toolbar-btn-primary",
        on_click=dispatch(ToggleTheme),
        theme_button_label(model.lang, model.theme),
      ),
    ]),
  ])
}

///|
fn stats(items : Array[(String, String)]) -> Html {
  div(
    class="stats-grid",
    items.map(item => {
      let (k, v) = item
      div(class="stat-card", [div(class="stat-key", k), div(class="stat-value", v)])
    }),
  )
}

///|
fn card(title : String, body : String) -> Html {
  div(class="card", [h3(class="card-title", title), div(class="card-body", body)])
}

///|
fn timeline(items : Array[(String, String, String)]) -> Html {
  div(
    class="timeline-list",
    items.map(item => {
      let (step, title, body) = item
      div(class="timeline-item", [
        div(class="timeline-step", step),
        div(class="timeline-content", [
          h3(class="timeline-title", title),
          div(class="timeline-body", body),
        ]),
      ])
    }),
  )
}

///|
fn section_block(title : String, subtitle : String, body : Html) -> Html {
  div(class="section-block", [
    div(class="section-head", [
      div(class="section-kicker", subtitle),
      h2(class="section-title", title),
    ]),
    body,
  ])
}

///|
fn view_zh(dispatch : Dispatch[Msg], model : Model) -> Html {
  div(class=root_class(model.theme), [
    div(class="page-shell", [
      topbar(dispatch, model),
      div(class="hero", [
        div(class="hero-copy", [
          div(class="eyebrow", "MoonBit Programming Innovation Challenge 2026"),
          h1(class="hero-title", "以开源为主线，构建 MGPIC 2026 官方网站"),
          div(
            class="hero-text",
            "本次重构将默认采用 MoonBit 与 Rabbita 技术方案，并逐步补齐中英双语、日夜模式、参赛指南、项目列表和长期可维护的信息架构。",
          ),
          div(class="hero-actions", [
            a(class="action primary", href="#guide", "参赛者指南"),
            a(class="action", href="https://www.moonbitlang.cn/", target=Blank, "了解 MoonBit"),
          ]),
        ]),
        div(class="hero-side", [
          div(class="hero-panel", [
            div(class="panel-kicker", "2026 目标"),
            div(class="panel-title", "1000 名有效参赛者"),
            div(class="panel-body", "围绕公开仓库、持续提交、项目孵化与成果展示，形成可验证的开源增长成果。"),
          ]),
          stats([
            ("目标仓库", "300+"),
            ("重点项目", "100+"),
            ("默认技术", "MoonBit + Rabbita"),
            ("网站结构", "指南 / 项目 / 展示"),
          ]),
        ]),
      ]),
      section_block(
        "网站将按“宣传页 + 指南站点”双层结构演进",
        "网站定位",
        div(class="card-grid", [
          card("开源优先", "强调 GitHub 仓库、提交历史、README、演示与后续维护，不再只是一次性比赛页面。"),
          card("工程导向", "重点展示项目路径、开发过程、里程碑与交付要求，让网站真正服务参赛者。"),
          card("生态沉淀", "优秀项目将进入展示、孵化与长期维护通道，形成 MoonBit 生态资产。"),
        ]),
      ),
      div(id="guide", class="section-block", [
        div(class="section-head", [
          div(class="section-kicker", "参赛者指南"),
          h2(class="section-title", "参考开源项目项目制指南来组织信息，而不是只做宣传页"),
        ]),
        div(class="guide-grid", [
          card("开始前你需要知道什么", "先理解赛事目标、推荐路径、交付要求和评审方式，再决定如何报名。"),
          card("如何选择参与路径", "区分开源入门、开源贡献和项目挑战三类路径，为不同经验层级提供入口。"),
          card("如何准备项目申报", "围绕问题、目标、里程碑、交付、风险与测试来写计划，而不是写空泛介绍。"),
          card("如何与导师或维护者沟通", "先阅读文档与仓库，再带着问题沟通，提升项目匹配和沟通效率。"),
          card("开发阶段如何推进", "通过周报、commit、里程碑检查和 Demo Day 管理过程，而不是只看最终结果。"),
          card("中期检查与最终结项", "结项同时看功能、工程质量、文档、可运行性与开源协作过程。"),
        ]),
      ]),
      section_block(
        "网站后续将继续扩展为完整指南站点",
        "路线图",
        timeline([
          ("01", "切换技术栈", "从静态 HTML 迁移到 MoonBit + Rabbita，建立可持续的组件化结构。"),
          ("02", "接入双语", "用统一内容结构承载中文与英文，保证官网和指南内容可同步维护。"),
          ("03", "接入主题模式", "提供日间与夜间两种界面，提高可读性和整体完成度。"),
          ("04", "补齐指南与项目池", "新增参赛者指南、项目列表、FAQ、支持计划和展示模块。"),
          ("05", "发布 GitHub Pages", "通过 Actions 自动构建与发布，形成稳定的官方站点。"),
        ]),
      ),
      section_block(
        "后续重点补充模块",
        "下一步",
        div(class="support-grid", [
          card("项目列表", "按难度、方向、是否适合新手等维度进行分类。"),
          card("支持计划", "展示任务池、模板仓库、导师与社区答疑支持。"),
          card("展示与榜单", "接入 Showcase、周榜、优秀项目和长期孵化入口。"),
        ]),
      ),
      div(class="footer", [
        div(class="footer-title", "MGPIC 2026 · MoonBit Open Source Challenge"),
        div(class="footer-links", [
          a(href="https://www.moonbitlang.cn/", target=Blank, "MoonBit"),
          span("·"),
          a(href="https://mooncakes.io/docs/moonbit-community/rabbita@0.11.8", target=Blank, "Rabbita"),
          span("·"),
          a(href="https://blog.summer-ospp.ac.cn/help/student%20guide", target=Blank, "开源项目指南参考"),
        ]),
      ]),
    ]),
  ])
}

///|
fn view_en(dispatch : Dispatch[Msg], model : Model) -> Html {
  div(class=root_class(model.theme), [
    div(class="page-shell", [
      topbar(dispatch, model),
      div(class="hero", [
        div(class="hero-copy", [
          div(class="eyebrow", "MoonBit Programming Innovation Challenge 2026"),
          h1(class="hero-title", "Rebuild the MGPIC 2026 website with an open source first architecture"),
          div(
            class="hero-text",
            "This refactor switches the site to MoonBit and Rabbita, then extends it with bilingual content, light and dark themes, participant guidance, project listings, and a more maintainable information structure.",
          ),
          div(class="hero-actions", [
            a(class="action primary", href="#guide", "Participant Guide"),
            a(class="action", href="https://www.moonbitlang.cn/", target=Blank, "Explore MoonBit"),
          ]),
        ]),
        div(class="hero-side", [
          div(class="hero-panel", [
            div(class="panel-kicker", "2026 Goal"),
            div(class="panel-title", "1,000 effective participants"),
            div(class="panel-body", "The event should produce verifiable open source outcomes through public repositories, ongoing commits, project incubation, and visible showcases."),
          ]),
          stats([
            ("Target repos", "300+"),
            ("Key projects", "100+"),
            ("Default stack", "MoonBit + Rabbita"),
            ("Site focus", "Guide / Projects / Showcase"),
          ]),
        ]),
      ]),
      section_block(
        "The site should evolve into both a landing page and a guide site",
        "Positioning",
        div(class="card-grid", [
          card("Open source first", "The site should highlight repositories, commit history, READMEs, demos, and long term maintenance instead of behaving like a one shot campaign page."),
          card("Engineering oriented", "It should clearly communicate project paths, process expectations, milestones, and delivery requirements."),
          card("Ecosystem oriented", "Strong projects should flow into showcase, incubation, and longer term MoonBit ecosystem maintenance."),
        ]),
      ),
      div(id="guide", class="section-block", [
        div(class="section-head", [
          div(class="section-kicker", "Participant Guide"),
          h2(class="section-title", "Organize the site like an open source program guide, not just a marketing page"),
        ]),
        div(class="guide-grid", [
          card("Before you start", "Understand the event goals, recommended tracks, deliverables, and review criteria before you apply."),
          card("Choose your participation path", "Separate entry paths for beginners, contributors, and project builders make the site useful to more developers."),
          card("Prepare your proposal", "Proposal writing should focus on problem, goal, milestones, deliverables, risk, and testing plan."),
          card("Communicate with mentors or maintainers", "Read docs and repositories first, then bring specific questions to mentors or maintainers."),
          card("Work during the coding period", "Use reports, commits, milestone checks, and demo reviews to manage progress, not only final output."),
          card("Midterm and final review", "Evaluation should include features, engineering quality, documentation, runnability, and open source collaboration."),
        ]),
      ]),
      section_block(
        "The site will keep expanding into a full guide hub",
        "Roadmap",
        timeline([
          ("01", "Switch the stack", "Move from static HTML into a maintainable MoonBit and Rabbita structure."),
          ("02", "Add bilingual content", "Use one content model to support both Chinese and English versions."),
          ("03", "Add theme modes", "Provide light and dark appearance options for readability and polish."),
          ("04", "Add guide and project list", "Introduce participant guide, project list, FAQ, support plan, and showcase modules."),
          ("05", "Publish with GitHub Pages", "Use GitHub Actions to build and publish a stable official site."),
        ]),
      ),
      section_block(
        "Modules to add next",
        "Next",
        div(class="support-grid", [
          card("Project list", "Classify projects by difficulty, direction, and beginner fit."),
          card("Support plan", "Show task pool, starter repositories, mentor support, and community channels."),
          card("Showcase and rankings", "Add showcase, weekly highlights, featured projects, and long term incubation entry points."),
        ]),
      ),
      div(class="footer", [
        div(class="footer-title", "MGPIC 2026 · MoonBit Open Source Challenge"),
        div(class="footer-links", [
          a(href="https://www.moonbitlang.cn/", target=Blank, "MoonBit"),
          span("·"),
          a(href="https://mooncakes.io/docs/moonbit-community/rabbita@0.11.8", target=Blank, "Rabbita"),
          span("·"),
          a(href="https://blog.summer-ospp.ac.cn/help/student%20guide", target=Blank, "Guide reference"),
        ]),
      ]),
    ]),
  ])
}

///|
fn view(dispatch : Dispatch[Msg], model : Model) -> Html {
  match model.lang {
    Zh => view_zh(dispatch, model)
    En => view_en(dispatch, model)
  }
}

///|
fn main {
  let app = @rabbita.simple_cell(model={ lang: Zh, theme: Dark }, update~, view~)
  @rabbita.new(app).mount("app")
}
