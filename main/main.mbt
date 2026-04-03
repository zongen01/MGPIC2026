///|
using @html {
  a,
  article,
  button,
  details,
  div,
  footer,
  h1,
  h2,
  h3,
  header,
  li,
  main_,
  nav,
  nothing,
  p,
  section,
  span,
  strong,
  summary,
  ul,
}

///|
using @rabbita {type Cmd, type Dispatch, type Html}

///|
#cfg(target="js")
extern "js" fn get_browser_lang() -> String =
  #| () => navigator.language || document.documentElement.lang || "zh-CN"

///|
#cfg(not(target="js"))
fn get_browser_lang() -> String {
  "zh-CN"
}

///|
#cfg(target="js")
extern "js" fn prefers_dark_mode() -> Bool =
  #| () => window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches

///|
#cfg(not(target="js"))
fn prefers_dark_mode() -> Bool {
  true
}

///|
enum Locale {
  Zh
  En
}

///|
enum Theme {
  Light
  Dark
}

///|
struct Model {
  locale : Locale
  theme : Theme
}

///|
fn initial_model() -> Model {
  {
    locale: if get_browser_lang().has_prefix("zh") { Zh } else { En },
    theme: if prefers_dark_mode() { Dark } else { Light },
  }
}

///|
enum Msg {
  ToggleLocale
  ToggleTheme
}

///|
fn update(dispatch : Dispatch[Msg], msg : Msg, model : Model) -> (Cmd, Model) {
  ignore(dispatch)
  match msg {
    ToggleLocale =>
      (
        @rabbita.none,
        {
          ..model,
          locale: match model.locale {
            Zh => En
            En => Zh
          },
        },
      )
    ToggleTheme =>
      (
        @rabbita.none,
        {
          ..model,
          theme: match model.theme {
            Light => Dark
            Dark => Light
          },
        },
      )
  }
}

///|
fn t(locale : Locale, zh~ : String, en~ : String) -> String {
  match locale {
    Zh => zh
    En => en
  }
}

///|
struct NavItem {
  label : String
  href : String
}

///|
struct Metric {
  label : String
  value : String
}

///|
struct InfoCard {
  title : String
  desc : String
}

///|
struct PathCard {
  badge : String
  title : String
  desc : String
  bullets : Array[String]
}

///|
struct TimelineItem {
  step : String
  title : String
  desc : String
}

///|
struct FaqItem {
  question : String
  answer : String
  opened : Bool
}

///|
fn site_class(theme : Theme) -> String {
  match theme {
    Light => "site site--light"
    Dark => "site site--dark"
  }
}

///|
fn locale_toggle_label(locale : Locale) -> String {
  match locale {
    Zh => "EN"
    En => "中文"
  }
}

///|
fn theme_toggle_label(model : Model) -> String {
  match model.theme {
    Light => t(model.locale, zh="夜间", en="Dark")
    Dark => t(model.locale, zh="日间", en="Light")
  }
}

///|
fn nav_items(locale : Locale) -> Array[NavItem] {
  [
    { label: t(locale, zh="介绍", en="About"), href: "#about" },
    { label: t(locale, zh="参与路径", en="Tracks"), href: "#paths" },
    { label: t(locale, zh="时间安排", en="Timeline"), href: "#timeline" },
    { label: t(locale, zh="支持计划", en="Support"), href: "#support" },
    { label: t(locale, zh="FAQ", en="FAQ"), href: "#faq" },
  ]
}

///|
fn hero_eyebrow(locale : Locale) -> String {
  t(
    locale,
    zh="MoonBit Programming Innovation Challenge 2026",
    en="MoonBit Programming Innovation Challenge 2026",
  )
}

///|
fn hero_title(locale : Locale) -> String {
  t(
    locale,
    zh="把赛事做成一次真正的\nMoonBit 开源生态增长计划",
    en="Turn the contest into a real\nMoonBit open-source growth program",
  )
}

///|
fn hero_text(locale : Locale) -> String {
  t(
    locale,
    zh="MGPIC 2026 不只是一次比赛，而是一场围绕 GitHub 开源协作、工程化项目交付与长期生态沉淀展开的开发者动员计划。赛事将通过任务池、模板仓库、Codex 启动支持与项目孵化机制，帮助更多开发者真正开始并持续参与 MoonBit 开源生态建设。",
    en="MGPIC 2026 is not only a contest. It is an open-source mobilization program built around GitHub collaboration, engineering delivery, and long-term ecosystem growth. The event will use task pools, starter repositories, Codex-assisted onboarding, and incubation mechanisms to help more developers begin and stay active in the MoonBit ecosystem.",
  )
}

///|
fn hero_kv_title(locale : Locale) -> String {
  t(
    locale,
    zh="MoonBit 开源创新挑战计划",
    en="MoonBit Open Source Challenge",
  )
}

///|
fn hero_kv_subtitle(locale : Locale) -> String {
  t(
    locale,
    zh="以开源协作、工程实践与长期生态沉淀为主线的 2026 年度开发者赛事",
    en="A 2026 developer challenge for open-source collaboration, engineering practice, and long-term ecosystem growth",
  )
}

///|
fn hero_kv_tags(locale : Locale) -> Array[String] {
  [
    t(locale, zh="开源协作", en="Open source"),
    t(locale, zh="工程实践", en="Engineering"),
    t(locale, zh="项目孵化", en="Incubation"),
    t(locale, zh="GitHub 协作", en="GitHub collaboration"),
  ]
}

///|
fn hero_metrics(locale : Locale) -> Array[Metric] {
  [
    { label: t(locale, zh="目标仓库", en="Target repos"), value: "300+" },
    { label: t(locale, zh="重点项目", en="Key projects"), value: "100+" },
    { label: t(locale, zh="核心方向", en="Core direction"), value: t(locale, zh="开源 × 工程", en="Open source x engineering") },
    { label: t(locale, zh="启动支持", en="Kickoff support"), value: "Codex" },
  ]
}

///|
fn about_cards(locale : Locale) -> Array[InfoCard] {
  [
    {
      title: t(locale, zh="开源优先", en="Open-source first"),
      desc: t(locale, zh="围绕 GitHub 仓库、提交历史、README、演示与持续维护展开，鼓励真实协作与长期积累。", en="The program centers on GitHub repositories, commit history, READMEs, demos, and ongoing maintenance to encourage real collaboration and durable results."),
    },
    {
      title: t(locale, zh="工程导向", en="Engineering oriented"),
      desc: t(locale, zh="重点关注系统设计、实现质量、可运行性、文档、测试与后续演进能力。", en="It focuses on system design, implementation quality, runnability, documentation, testing, and long-term evolution."),
    },
    {
      title: t(locale, zh="生态沉淀", en="Ecosystem growth"),
      desc: t(locale, zh="优秀项目将进入展示、孵化与长期共建通道，反哺 MoonBit 样例、内容与工具生态。", en="Strong projects can move into showcase, incubation, and long-term collaboration tracks that feed back into MoonBit examples, content, and tooling."),
    },
  ]
}

///|
fn path_cards(locale : Locale) -> Array[PathCard] {
  [
    {
      badge: "Path A",
      title: t(locale, zh="开源入门组", en="Open-source starter track"),
      desc: t(locale, zh="面向第一次接触 MoonBit 的开发者，通过 Starter Repo、示例任务与工作坊完成从 0 到 1 的启动。", en="For developers who are new to MoonBit, with starter repositories, example tasks, and workshops that help them get from zero to one."),
      bullets: [
        t(locale, zh="环境搭建与最小项目", en="Environment setup and a minimal project"),
        t(locale, zh="首个 Issue / PR", en="First issue or PR"),
        t(locale, zh="新手任务池", en="Starter task pool"),
      ],
    },
    {
      badge: "Path B",
      title: t(locale, zh="开源贡献组", en="Contribution track"),
      desc: t(locale, zh="围绕 MoonBit 生态项目、文档、测试、工具链与社区仓库进行持续贡献，强调贡献质量与活跃度。", en="For continuous contribution to MoonBit ecosystem projects, docs, tests, tooling, and community repositories, with an emphasis on contribution quality and consistency."),
      bullets: [
        t(locale, zh="Good First Issue", en="Good first issue"),
        t(locale, zh="文档 / 测试 / 示例任务", en="Docs, tests, and example tasks"),
        t(locale, zh="周度贡献榜", en="Weekly contribution leaderboard"),
      ],
    },
    {
      badge: "Path C",
      title: t(locale, zh="项目挑战组", en="Project challenge track"),
      desc: t(locale, zh="面向希望做出完整项目和冲击重点展示的开发者，以项目申报、里程碑开发和最终答辩为主线推进。", en="For builders aiming to deliver full projects and reach the featured showcase through project proposals, milestone development, and a final presentation."),
      bullets: [
        t(locale, zh="项目申报与预答辩", en="Project proposal and early review"),
        t(locale, zh="中期验收与 Demo Day", en="Midterm review and demo day"),
        t(locale, zh="项目展示与孵化推荐", en="Showcase and incubation recommendations"),
      ],
    },
  ]
}

///|
fn timeline_items(locale : Locale) -> Array[TimelineItem] {
  [
    {
      step: "01",
      title: t(locale, zh="预热与合作招募", en="Warm-up and partnerships"),
      desc: t(locale, zh="发布视觉与主张，启动社区、高校与合作伙伴联动。", en="Launch the brand, narrative, and coordination with communities, universities, and partners."),
    },
    {
      step: "02",
      title: t(locale, zh="报名与训练营", en="Registration and bootcamp"),
      desc: t(locale, zh="开放预登记，发布 Starter Repo、任务池与直播答疑。", en="Open early registration and publish starter repositories, task pools, and live Q&A support."),
    },
    {
      step: "03",
      title: t(locale, zh="开源贡献与项目开发", en="Contribution and project build"),
      desc: t(locale, zh="围绕公开仓库、持续提交与项目孵化展开正式开发。", en="Enter the active build phase around public repositories, continuous commits, and project incubation."),
    },
    {
      step: "04",
      title: t(locale, zh="中期验收与 Demo Day", en="Midterm review and demo day"),
      desc: t(locale, zh="通过活跃度、里程碑与项目质量筛选重点项目。", en="Use activity, milestones, and project quality to identify standout work."),
    },
    {
      step: "05",
      title: t(locale, zh="决赛答辩与成果开放", en="Final review and open release"),
      desc: t(locale, zh="展示优秀项目，发布榜单，并开启后续生态共建通道。", en="Present standout projects, publish final results, and open the next stage of ecosystem collaboration."),
    },
  ]
}

///|
fn support_cards(locale : Locale) -> Array[InfoCard] {
  [
    {
      title: t(locale, zh="Codex 启动支持", en="Codex kickoff support"),
      desc: t(locale, zh="帮助选手完成仓库初始化、任务拆解、样例生成、文档搭建与开发提速，重点解决“不会开始”和“起步太慢”的问题。", en="Help participants initialize repositories, break down tasks, generate examples, build documentation, and accelerate development so they can actually get started."),
    },
    {
      title: t(locale, zh="开源任务池与模板仓库", en="Task pool and starter repositories"),
      desc: t(locale, zh="通过 Starter Repo、Good First Issue 与任务池，让不同能力层级的开发者都有明确入口。", en="Use starter repositories, good first issues, and curated task pools to give developers at different levels a clear entry point."),
    },
    {
      title: t(locale, zh="与开源之夏式项目孵化衔接", en="Incubation beyond the contest"),
      desc: t(locale, zh="把 MGPIC 中表现突出的学生与项目导向更长期的导师制、项目制和深度开源贡献通道。", en="Guide strong students and projects toward longer-term mentorship, project incubation, and deeper open-source collaboration."),
    },
  ]
}

///|
fn faq_items(locale : Locale) -> Array[FaqItem] {
  [
    {
      question: t(locale, zh="这次赛事和往年最大的区别是什么？", en="What is the biggest difference from previous years?"),
      answer: t(locale, zh="2026 更强调开源协作、工程实践与长期沉淀，不只是一次性提交作品，而是围绕公开仓库与持续开发展开。", en="The 2026 edition puts much more weight on open-source collaboration, engineering practice, and long-term outcomes instead of one-off submissions."),
      opened: true,
    },
    {
      question: t(locale, zh="没有 MoonBit 经验也能参加吗？", en="Can beginners with no MoonBit experience still join?"),
      answer: t(locale, zh="可以。网站结构里已经预留 Starter Repo、任务池和入门训练营入口，便于新人完成启动。", en="Yes. The site already reserves space for starter repositories, task pools, and beginner bootcamp materials to help newcomers get started."),
      opened: false,
    },
    {
      question: t(locale, zh="Codex 会在什么阶段发挥作用？", en="At which stage will Codex be most useful?"),
      answer: t(locale, zh="更适合项目启动、任务拆解、文档搭建、样例生成和开发提速阶段，后续可根据项目表现分层支持。", en="It is most useful during project kickoff, task planning, documentation setup, sample generation, and development acceleration, with further support layered by project progress."),
      opened: false,
    },
    {
      question: t(locale, zh="是否会和开源之夏形成联动？", en="Will it connect with a summer-of-code style program?"),
      answer: t(locale, zh="页面已按照可联动方向预留结构，后续可继续补充正式合作信息、项目机制与导师安排。", en="The current structure already reserves room for that direction, and future updates can add formal collaboration details, project mechanisms, and mentor plans."),
      opened: false,
    },
  ]
}

///|
fn section_intro(
  _locale : Locale,
  eyebrow : String,
  title : String,
  desc : String,
) -> Html {
  div(class="section-head", [
    p(class="eyebrow", eyebrow),
    h2(title),
    if desc == "" {
      nothing
    } else {
      p(desc)
    },
  ])
}

///|
fn view_header(dispatch : Dispatch[Msg], model : Model) -> Html {
  header(class="site-header", [
    div(class="container nav-shell", [
      a(class="brand", href="#top", [
        span(class="brand-badge", "M"),
        div(class="brand-copy", [
          strong("MGPIC 2026"),
          p(
            class="brand-subtitle",
            t(model.locale, zh="MoonBit 开源创新挑战计划", en="MoonBit Open Source Challenge"),
          ),
        ]),
      ]),
      nav(class="nav-links", nav_items(model.locale).map(fn(item) {
        a(href=item.href, item.label)
      })),
      div(class="toolbar", [
        button(class="toolbar-btn", on_click=dispatch(ToggleLocale), locale_toggle_label(model.locale)),
        button(class="toolbar-btn toolbar-btn--primary", on_click=dispatch(ToggleTheme), theme_toggle_label(model)),
        a(
          class="nav-action",
          href="#join",
          t(model.locale, zh="关注赛事", en="Follow the event"),
        ),
      ]),
    ]),
  ])
}

///|
fn view_metric(metric : Metric) -> Html {
  div(class="stat-card", [
    span(class="stat-key", metric.label),
    strong(class="stat-value", metric.value),
  ])
}

///|
fn view_hero_banner(model : Model) -> Html {
  div(class="hero-banner", [
    div(class="hero-banner-grid", [
      div(class="hero-banner-copy", [
        p(class="hero-banner-kicker", hero_eyebrow(model.locale)),
        div(class="hero-banner-wordmark", [
          span(class="hero-banner-word", "MGPIC"),
          span(class="hero-banner-year", "2026"),
        ]),
        h2(class="hero-banner-title", hero_kv_title(model.locale)),
        p(class="hero-banner-subtitle", hero_kv_subtitle(model.locale)),
        div(class="hero-banner-tags", hero_kv_tags(model.locale).map(fn(label) {
          span(class="hero-banner-tag", label)
        })),
      ]),
      div(class="hero-banner-art", [
        div(class="hero-stage-m", "M"),
        span(class="hero-stage-orb hero-stage-orb--left", ""),
        span(class="hero-stage-orb hero-stage-orb--right", ""),
        div(class="hero-stage-panel hero-stage-panel--left", [
          span(class="hero-stage-panel-label", t(model.locale, zh="任务池", en="Task pool")),
          strong(
            class="hero-stage-panel-value",
            t(
              model.locale,
              zh="公开仓库 / Good First Issue",
              en="Public repos / good first issues",
            ),
          ),
        ]),
        div(class="hero-stage-panel hero-stage-panel--right", [
          span(class="hero-stage-panel-label", t(model.locale, zh="项目交付", en="Project delivery")),
          strong(
            class="hero-stage-panel-value",
            t(
              model.locale,
              zh="Demo Day / 孵化推荐",
              en="Demo day / incubation",
            ),
          ),
        ]),
        div(class="hero-console", [
          div(class="hero-console-top", [
            span(class="hero-console-topline", "moon check --target js"),
            span(class="hero-console-status", t(model.locale, zh="生态构建中", en="Build in progress")),
          ]),
          div(class="hero-console-screen", [
            p(class="hero-console-line hero-console-line--strong", "Open Source x Engineering"),
            p(class="hero-console-line", "GitHub / Starter Repo / Codex"),
            p(
              class="hero-console-line",
              t(
                model.locale,
                zh="面向 1000 名开发者的年度挑战计划",
                en="A challenge program for 1,000 builders",
              ),
            ),
          ]),
          div(class="hero-console-tags", [
            span(class="hero-console-tag", "GitHub"),
            span(class="hero-console-tag", "Codex"),
            span(class="hero-console-tag", "MoonBit"),
          ]),
        ]),
      ]),
    ]),
  ])
}

///|
fn view_hero(model : Model) -> Html {
  section(id="top", class="hero", [
    div(class="container", [
      view_hero_banner(model),
      div(class="hero-inner", [
        div(class="hero-copy", [
          p(class="eyebrow", t(model.locale, zh="Program Vision", en="Program Vision")),
          h1(class="hero-title", hero_title(model.locale)),
          p(class="hero-text", hero_text(model.locale)),
          div(class="hero-actions", [
            a(
              class="button primary",
              href="#join",
              t(model.locale, zh="报名通道预留", en="Reserve the sign-up channel"),
            ),
            a(
              class="button secondary",
              href="https://www.moonbitlang.cn/",
              target=Blank,
              rel="noreferrer",
              t(model.locale, zh="了解 MoonBit", en="Explore MoonBit"),
            ),
          ]),
        ]),
        div(class="hero-panel", [
          div(class="stat-card stat-card--large", [
            span(class="stat-key", t(model.locale, zh="2026 目标", en="2026 Goal")),
            strong(
              class="stat-value stat-value--large",
              t(model.locale, zh="1000 名有效参赛者", en="1,000 effective participants"),
            ),
            p(
              t(model.locale, zh="围绕公开仓库、真实提交、项目孵化和成果展示，形成可验证的开源增长成果。", en="Turn public repositories, real commits, project incubation, and visible showcases into measurable open-source growth."),
            ),
          ]),
          div(class="stats-grid", hero_metrics(model.locale).map(fn(metric) { view_metric(metric) })),
        ]),
      ]),
    ]),
  ])
}

///|
fn view_info_card(card : InfoCard) -> Html {
  article(class="info-card", [
    h3(card.title),
    p(card.desc),
  ])
}

///|
fn view_path_card(card : PathCard) -> Html {
  article(class="path-card", [
    span(class="tag", card.badge),
    h3(card.title),
    p(card.desc),
    ul(class="path-points", card.bullets.map(fn(item) {
      li(item)
    })),
  ])
}

///|
fn view_timeline_item(item : TimelineItem) -> Html {
  article(class="timeline-item", [
    strong(class="timeline-step", item.step),
    div(class="timeline-body", [
      h3(item.title),
      p(item.desc),
    ]),
  ])
}

///|
fn view_faq_item(item : FaqItem) -> Html {
  details(class="faq-item", open=item.opened, [
    summary(item.question),
    p(item.answer),
  ])
}

///|
fn view_about(model : Model) -> Html {
  section(id="about", class="section", [
    div(class="container", [
      section_intro(
        model.locale,
        t(model.locale, zh="赛事定位", en="Positioning"),
        t(model.locale, zh="把一场赛事，做成一次真正的开源生态增长", en="Turn a contest into real open-source ecosystem growth"),
        t(model.locale, zh="MGPIC 2026 的重点不只是“交作品”，而是推动更多开发者围绕 MoonBit 建立公开仓库、持续提交代码、完成项目演进，并沉淀可展示、可复用、可继续维护的开源成果。", en="MGPIC 2026 is not only about shipping a final entry. It is about helping more developers build public repositories around MoonBit, keep contributing code, evolve projects, and leave behind reusable, maintainable open-source work."),
      ),
      div(class="card-grid", about_cards(model.locale).map(fn(card) { view_info_card(card) })),
    ]),
  ])
}

///|
fn view_paths(model : Model) -> Html {
  section(id="paths", class="section section--alt", [
    div(class="container", [
      section_intro(
        model.locale,
        t(model.locale, zh="参与路径", en="Tracks"),
        t(model.locale, zh="让不同阶段的开发者，都能顺利进入 MoonBit 开源生态", en="Create clear entry points for developers at different stages"),
        "",
      ),
      div(class="card-grid", path_cards(model.locale).map(fn(card) { view_path_card(card) })),
    ]),
  ])
}

///|
fn view_timeline(model : Model) -> Html {
  section(id="timeline", class="section", [
    div(class="container", [
      section_intro(
        model.locale,
        t(model.locale, zh="时间安排", en="Timeline"),
        t(model.locale, zh="建议采用五阶段推进赛事与开源增长", en="A five-stage rhythm for the event and ecosystem growth"),
        "",
      ),
      div(class="timeline-list", timeline_items(model.locale).map(fn(item) { view_timeline_item(item) })),
    ]),
  ])
}

///|
fn view_support(model : Model) -> Html {
  section(id="support", class="section section--alt", [
    div(class="container", [
      section_intro(
        model.locale,
        t(model.locale, zh="支持计划", en="Support"),
        t(model.locale, zh="降低启动门槛，同时把优秀项目引向更长期的开源路径", en="Lower the starting barrier and guide strong projects into longer-term open-source paths"),
        "",
      ),
      div(class="card-grid", support_cards(model.locale).map(fn(card) { view_info_card(card) })),
    ]),
  ])
}

///|
fn view_join(model : Model) -> Html {
  section(id="join", class="section", [
    div(class="container", [
      div(class="join-card", [
        div(class="join-copy", [
          p(class="eyebrow", t(model.locale, zh="Call for Builders", en="Call for Builders")),
          h2(
            t(
              model.locale,
              zh="加入 MGPIC 2026，\n一起把 MoonBit 开源生态真正做起来",
              en="Join MGPIC 2026 and help build the MoonBit open-source ecosystem for real",
            ),
          ),
          p(
            t(
              model.locale,
              zh="这一版官网已经重构为 MoonBit + Rabbita 单入口结构，后续可以继续接入正式报名链接、合作伙伴、评委阵容、项目库与动态展示数据。",
              en="This edition of the site has been restructured into a single MoonBit + Rabbita entry, so formal sign-up links, partners, judges, project listings, and live showcase data can be added incrementally.",
            ),
          ),
        ]),
        div(class="join-actions", [
          a(
            class="button primary",
            href="https://github.com/zongen01/MGPIC2026",
            target=Blank,
            rel="noreferrer",
            t(model.locale, zh="查看 GitHub 仓库", en="View GitHub repository"),
          ),
          a(
            class="button secondary",
            href="https://www.moonbitlang.cn/",
            target=Blank,
            rel="noreferrer",
            t(model.locale, zh="MoonBit 中文官网", en="MoonBit website"),
          ),
          a(
            class="button secondary",
            href="mailto:hello@moonbitlang.com",
            t(model.locale, zh="联系主办方", en="Contact organizer"),
          ),
        ]),
      ]),
    ]),
  ])
}

///|
fn view_faq(model : Model) -> Html {
  section(id="faq", class="section section--alt", [
    div(class="container", [
      section_intro(
        model.locale,
        "FAQ",
        t(model.locale, zh="常见问题", en="Frequently asked questions"),
        "",
      ),
      div(class="faq-list", faq_items(model.locale).map(fn(item) { view_faq_item(item) })),
    ]),
  ])
}

///|
fn view_footer(model : Model) -> Html {
  footer(class="site-footer", [
    div(class="container footer-inner", [
      div(class="footer-copy", [
        strong("MGPIC 2026"),
        p(t(model.locale, zh="MoonBit 开源创新挑战计划", en="MoonBit Open Source Challenge")),
      ]),
      div(class="footer-links", [
        a(href="https://www.moonbitlang.cn/", target=Blank, rel="noreferrer", t(model.locale, zh="MoonBit 中文官网", en="MoonBit website")),
        a(href="https://github.com/zongen01/MGPIC2026", target=Blank, rel="noreferrer", "GitHub"),
        a(href="https://mooncakes.io/docs/moonbit-community/rabbita@0.11.5", target=Blank, rel="noreferrer", "Rabbita"),
      ]),
    ]),
  ])
}

///|
fn view(dispatch : Dispatch[Msg], model : Model) -> Html {
  div(class=site_class(model.theme), [
    view_header(dispatch, model),
    main_(class="page-main", [
      view_hero(model),
      view_about(model),
      view_paths(model),
      view_timeline(model),
      view_support(model),
      view_join(model),
      view_faq(model),
    ]),
    view_footer(model),
  ])
}

///|
#warnings("-alert_unstable")
fn main {
  let (_, app) = @rabbita.cell_with_dispatch(
    model=initial_model(),
    update~,
    view~,
  )
  @rabbita.new(app).mount("mgpic-app")
}
