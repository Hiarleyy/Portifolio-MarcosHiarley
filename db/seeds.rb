# frozen_string_literal: true
# Seed data generated from current database on 2026-08-11 20:50:23

puts "Cleaning database..."
# Using destroy_all to ensure active storage attachments are also deleted
Article.destroy_all
Project.destroy_all
AdminUser.destroy_all

puts "Seeding Admin Users..."
admins = [{:email=>"admin@portfolio.com"}]

admins.each do |admin_data|
  # We use a default password 'password123' for seeded admin users.
  # Change this in production or via the admin panel.
  AdminUser.find_or_create_by!(email: admin_data[:email]) do |u|
    u.password = 'password123'
    u.password_confirmation = 'password123'
  end
  puts "Created Admin User: #{admin_data[:email]}"
end

# Setup paths for attachments
images_dir = Rails.root.join('db', 'seeds', 'images')

puts "Seeding Projects..."
projects = [
  {
    title: "Plataforma Redação Elite",
    description: "A Plataforma Redação Elite é uma aplicação web educacional desenvolvida com foco na gestão e no aprimoramento da produção textual de estudantes. O sistema permite o cadastro e envio de redações, realização de correções com feedback estruturado, além do acompanhamento contínuo do desempenho dos alunos.\r\n",
    technologies: "Node.js, Prisma ORM, JavaScript, React.js",
    live_url: "https://redacaoelite.com/",
    github_url: "",
    featured: true,
    position: 0,
    screenshot_filename: "project_4_screenshot.png"
  },
  {
    title: "SuperAgenda",
    description: "Desenvolvimento de uma Agenda corporativa com funcionalidade de organização empresarial com base em kanban, com funcionalidades de lembrete via whatsapp para clientes, progressao e bonificação para funcionarios, análise de desempenho e entre outros",
    technologies: "Next.js, TypeOrm, Python",
    live_url: "",
    github_url: "",
    featured: true,
    position: 0,
    screenshot_filename: "project_5_screenshot.png"
  },
  {
    title: "K-means Ns-3",
    description: "Este projeto implementa uma solução de otimização para posicionamento de antenas em redes 5G utilizando o algoritmo K-means. O sistema combina simulações NS-3 (Network Simulator 3) com análise de dados em Python para otimizar a localização de estações base (eNodeB/gNodeB) baseada na distribuição de usuários e métricas de qualidade de sinal.",
    technologies: "Linux, Python, C++, IOT, ",
    live_url: "",
    github_url: "https://github.com/Hiarleyy/K-means_Ns-3",
    featured: true,
    position: 0,
    screenshot_filename: "project_6_screenshot.jpg"
  },
  {
    title: "Desenvolvimento de Iframe para plataforma MEGA CRM",
    description: "Desenvolvimento de dashboard scripts para embbending com iframe na plataforma MEGA CRM, com funcionalidades de monitoramento e produtividade para times de venda",
    technologies: "ruby on rails, javascript",
    live_url: "https://github.com/megaapp977/stack/discussions",
    github_url: "https://github.com/insilicotec/Relatorios-de-fechamento",
    featured: true,
    position: 0,
    screenshot_filename: "project_7_screenshot.png"
  }
]

projects.each do |proj_data|
  screenshot_filename = proj_data.delete(:screenshot_filename)
  project = Project.create!(proj_data)
  
  if screenshot_filename
    image_path = images_dir.join(screenshot_filename)
    if File.exist?(image_path)
      project.screenshot.attach(
        io: File.open(image_path),
        filename: screenshot_filename,
        content_type: "image/#{File.extname(screenshot_filename).delete('.')}"
      )
    end
  end
  
  puts "Created Project: #{project.title}"
end

puts "Seeding Articles..."
articles = [
  {
    title: "Projetos complexos exigem mais do que memória, por que uso Obsidian como segundo cérebro",
    slug: "projetos-complexos-exigem-mais-do-que-memoria-por-que-uso-obsidian-como-segundo-cerebro",
    excerpt: "Já percebeu como projetos complexos raramente falham por falta de informação?\r\n\r\nna maioria das vezes o problema chega a ser o excesso de informações espalhadas em reuniões, documentos soltos, mensagens, ideias e referencias que nunca encontramos quando precisamos.\r\n\r\nFoi justamente esse desafio que me levou ao conceito já explorado a alguns anos na comunidade do Obsidian: **o segundo cérebro** **(Second Brain).**",
    published: true,
    featured: true,
    published_at: DateTime.iso8601("2026-08-10T14:19:53Z"),
    cover_filename: "article_7_cover.png",
    body: <<~'BODY'
  
  
  Já percebeu como projetos complexos raramente falham por falta de informação?
  
  na maioria das vezes o problema chega a ser o excesso de informações espalhadas em reuniões, documentos soltos, mensagens, ideias e referencias que nunca encontramos quando precisamos.
  
  Foi justamente esse desafio que me levou ao conceito já explorado a alguns anos na comunidade do Obsidian: **o segundo cérebro** **(Second Brain).**
  
  Mais do que um aplicativo de notas, usar o obsidian como segundo cérebro e organizar o conhecimento e as ideias de forma persistente de forma que continue útil mesmo após meses de desenvolvimento após ter sido registrado. E para o ambiente dev, o obsidian e uma das ferramentas mais interessantes para construir o seu **Second Brain**. Muito se dá por conta da alta capacidade de personalização com os plugins desenvolvidos pela comunidade para transformar o sistema do seu jeito, mas também o fato de você conseguir conectar qualquer nota do seu projeto com a funcionalidade dos links, que torna a busca e o gerenciamento das informações muito mais assertivo e organizado.
  
  ### Desafio dos projetos complexos
  
  Quem trabalha com desenvolvimento de software, gestão de produtos, pesquisa e consultoria, ou qualquer atividade de alta complexidade sabe que um projeto envolve muito mais do que tarefas a serem cumpridas. Existem decisões arquiteturais, aprendizados, hipóteses descartadas, reuniões importantes com informações cruciais e conexões entre assuntos que, no momento parecem irrelevantes mas acabam sendo fundamentais com o decorrer do desenvolvimento. Confiar apenas na memória para gerenciar tudo isso não escala.
  
  ## O poder das Conexões
  
  O que torna o Obsidian diferente das opções não é apenas o fato de armazenar as notas em arquivos Markdown locais, o verdadeiro diferencial está na forma como ele permite conectar as informações.
  
  Cada nota pode se relacionar com dezenas de outras utilizando os links bidirecionais. em vez de guardar as informações em pastas isoladas, você cria uma rede com seu conhecimento adquirido e cresce organicamente conforme o seu projeto evolui.
  
  Com o tempo, essa rede começa a revelar padrões que dificilmente seriam percebidas apenas navegando por diretórios ou pesquisando arquivos. É como transformar o seu conhecimento disperso em um mapa navegável.
  
  ## Organização 
  
  Uma das maiores vantagens do obsidian é que ele não obriga você a seguir uma metodologia específica. Independente do método de organização que você utiliza, como PARA ou Zettelkasten, na prática o mais importante é a criação do hábito de registrar as suas ideias, conectar os conceitos e revisar o conhecimento produzido.
  ## O conhecimento passa a trabalhar para você
  
  Existe uma diferença importante entre armazenar informações e construir conhecimento.
  
  Guardar notas é simples.
  
  Criar conexões entre elas é o que gera valor.
  
  Quando você começa a relacionar ideias, documentar decisões e revisitar aprendizados, seu sistema deixa de ser um repositório de arquivos e passa a funcionar como uma extensão do seu pensamento.
  
  Esse talvez seja o maior benefício de um Segundo Cérebro.
  
  Ele não substitui sua capacidade de pensar.
  
  Ele libera sua mente para pensar melhor.
  
  Porque, em vez de gastar energia tentando lembrar onde uma informação está, você pode concentrar seus esforços em resolver problemas, tomar decisões e criar novas soluções.
  
  E, em projetos complexos, essa diferença costuma ser enorme.
  
  Referências:
  - ### Obsidian: The Thinking Person's Set Up (FULL SET UP) - Vicky Zhao https://www.youtube.com/watch?v=Aded2v7_vag
  - # The Ultimate Obsidian for Beginner's Guide 2025 - CreaDev Labs https://www.youtube.com/watch?v=gafuqdKwD_U
  - # why I switched to using Obsidian (as a former Notion user) - Reysu https://www.youtube.com/watch?v=O7vGsBghWfc
  
  BODY
  },
  {
    title: "Como contribuí para um projeto open source (e o que aprendi)",
    slug: "como-contribui-para-um-projeto-open-source-e-o-que-aprendi",
    excerpt: "Como um bug em produção me levou a contribuir com um projeto open source — e o que aprendi sobre código, comunicação e comunidade ao abrir meus primeiros Pull Requests.",
    published: true,
    featured: true,
    published_at: DateTime.iso8601("2026-08-05T00:00:00Z"),
    cover_filename: "article_4_cover.png",
    body: <<~'BODY'
  ## A história que começa com um bug em produção
  
  Confesso: por muito tempo, eu fui só consumidor de open source. Usava, instalava, customizava… mas nunca tinha "devolvido" nada para a comunidade. Até que um problema em produção me forçou a mudar isso.
  
  Estava usando o **MEGA CRM**, um CRM para WhatsApp baseado no Chatwoot. Em um projeto de cliente, notei algo estranho: os iframes da plataforma demoravam uma eternidade para carregar. Em alguns casos, travavam completamente. Paralelo a isso, toda vez que precisávamos criar um novo template de iframe (agendamento, catálogo, formulário de lead), era como começar do zero. Sem reutilização. Sem padrão.
  
  Foi aí que pensei: _"Por que não consertar isso de uma vez por todas — e contribuir com o projeto?"_
  
  ## Mergulhando no código
  
  Comecei com o básico: fork no GitHub, clone local, ambiente rodando. E aí veio o choque. O MEGA é um fork do Chatwoot, que é **Rails + Vue**. Camadas de customização, arquivos espalhados, lógica de carregamento de iframes em lugares que eu nem imaginava.
  
  Passei dois dias só lendo código, issues antigas e PRs mergeados. Anotava tudo: qual arquivo controlava o render do iframe, onde tinha um cache que nunca era invalidado, qual componente Vue re-renderizava três vezes sem necessidade.
  
  ## As duas branches — e dois problemas diferentes
  
  Com o mapa na mão, criei **duas branches separadas**.
  
  **Branch 1 — Performance de carregamento:**
  - Implementei lazy loading para carregar o iframe só quando visível
  - Adicionei cache de assets críticos
  - Reduzi re-renderizações desnecessárias no Vue
  
  **Branch 2 — Templates reutilizáveis:**
  - Desenvolvi uma estrutura modular com JSON e componentes Vue
  - Criei três templates prontos: agendamento, catálogo e captura de leads
  - Escrevi documentação explicando como criar novos templates
  
  ## O review — a parte mais importante
  
  Abri dois pull requests separados. No título, deixei claro o que cada um fazia. Na descrição, expliquei o problema que resolvi, como resolvi, incluí GIFs mostrando antes e depois, e detalhei os passos para testar localmente.
  
  O maintainer respondeu em 24 horas. Alguns pontos foram diretos: sugeriu nomes mais descritivos para variáveis, pediu para extrair certa lógica para um utilitário, e pediu testes mínimos. Apliquei as mudanças, rebaseei, e os PRs foram mergeados.
  
  ## O que aprendi vai muito além de código
  
  **Ler código alheio se tornou um superpoder.** Nunca evolui tanto como desenvolvedor quanto nesses dias lendo uma base que não era minha. Aprendi a usar `git blame` sem medo — não para culpar, mas para entender contexto. Aprendi a ler histórico de issues e PRs antes de tocar em qualquer arquivo.
  
  **Comunicar importa tanto quanto codar.** Um PR bem escrito facilita o review em dez vezes. Detalhes como título descritivo, contexto de negócio e instruções claras de teste fazem o maintainer te levar a sério.
  
  **Open source é sobre pessoas.** O maintainer foi receptivo, mas direto. Aprendi a não levar feedback como crítica pessoal, a perguntar quando não entendia, e a agradecer publicamente — isso fortalece a comunidade.
  
  **Performance é soma de pequenos ganhos.** Nenhuma bala de prata. O que funcionou foi lazy loading estratégico, cache inteligente, menos re-renderizações. Cada ganho de 100, 150 milissegundos somou. No total, quase **meio segundo ganho** — e o cliente percebeu.
  
  ## Próximos passos
  
  Essa foi minha primeira contribuição de verdade. Mas já tenho planos: adicionar mais templates com integração ao Google Agenda e WhatsApp Business API, melhorar a documentação de customização, e contribuir com o Chatwoot upstream reportando bugs que afetam ambos os projetos.
  
  Se você também só consome open source, fica o convite: **comece pequeno**. Traduzir uma documentação, reportar um bug com passos claros, corrigir um erro de digitação. Cada PR é aprendizado. E, no meu caso, contribuiu para um projeto que uso em produção — o que torna cada melhoria ainda mais significativa.
  
  BODY
  },
  {
    title: "Redes Aéreas Inteligentes no 6G: Otimização da Cobertura com Drones e K-Means",
    slug: "redes-aereas-inteligentes-no-6g-otimizacao-cobertura-drones-kmeans",
    excerpt: "Artigo publicado no V Workshop de Redes 6G (W6G/SBRC 2025). Proposta de otimização 3D do posicionamento de drones como estações rádio base usando o algoritmo K-Means.",
    published: true,
    featured: true,
    published_at: DateTime.iso8601("2025-05-01T00:00:00Z"),
    cover_filename: "article_5_cover.jpg",
    body: <<~'BODY'
  ## Resumo
  
  Com o avanço rumo às redes de **6ª Geração (6G)**, a utilização de Veículos Aéreos Não Tripulados (UAVs / Drones) como estações rádio base voadoras (*Fly-BSs*) surge como uma solução promissora para provimento de cobertura sob demanda, mitigação de sombreamento e atendimento a áreas de alta densidade de usuários.
  
  Neste artigo publicado no **V Workshop de Redes 6G (W6G / SBRC — Sociedade Brasileira de Computação)**, propomos um modelo de otimização de posicionamento 3D de drones baseado no algoritmo de aprendizado de máquina **K-Means**.
  
  ## Motivação
  
  As redes 5G e 6G precisam entregar conectividade em locais de alta densidade temporária — eventos esportivos, festivais, cenários pós-desastres. A infraestrutura fixa é insuficiente nesses casos. Drones atuando como Fly-BSs permitem cobertura flexível e reposicionável em tempo real.
  
  ## Metodologia
  
  ```python
  # Otimização de posicionamento de Fly-BSs com K-Means
  from sklearn.cluster import KMeans
  import numpy as np
  
  def posicionar_drones(posicoes_usuarios, num_drones):
      kmeans = KMeans(n_clusters=num_drones, random_state=42)
      kmeans.fit(posicoes_usuarios)
      return kmeans.cluster_centers_
  ```
  
  O algoritmo agrupa os usuários em *clusters* espaciais e posiciona o drone no centroide de cada grupo, minimizando a distância média e maximizando a cobertura.
  
  ## Resultados
  
  O modelo proposto reduziu a **latência de enlace** e aumentou a **vazão do sistema** em cenários de alta mobilidade urbana e eventos com aglomeração.
  
  ## Conclusão
  
  A clusterização K-Means se mostrou eficiente e computacionalmente viável para o posicionamento dinâmico de drones em redes 6G.
  
  **Publicação:** V Workshop de Redes 6G (W6G 2025) — Sociedade Brasileira de Computação (SBC/SBRC)
  **Autores:** Marcos Hiarley, Robert Corrêa, Jasmine Araújo e José Jailton H. Ferreira Junior — UFPA
  
  BODY
  },
  {
    title: "Transmissão Sem Fio em Altas Frequências para Redes 5G e 6G",
    slug: "transmissao-sem-fio-altas-frequencias-redes-5g-6g",
    excerpt: "Publicação nos anais da ERAD-RS 2024 (SBC) abordando os desafios físicos de propagação e atenuação em ondas milimétricas (mmWave) para infraestrutura de redes 5G e 6G.",
    published: true,
    featured: false,
    published_at: DateTime.iso8601("2024-04-01T00:00:00Z"),
    cover_filename: "article_6_cover.jpg",
    body: <<~'BODY'
  ## Introdução
  
  A exploração das faixas de frequência de **Ondas Milimétricas (mmWave)** e **Sub-Terahertz (Sub-THz)** é a chave para viabilizar as elevadas taxas de transmissão projetadas para as redes **5G-Advanced** e **6G**.
  
  Este trabalho foi publicado nos anais da **XXIV Escola Regional de Alto Desempenho da Região Sul (ERAD-RS 2024 / SBC)** e analisa os principais desafios físicos impostos pelo canal sem fio em altas frequências.
  
  ## Desafios das Altas Frequências
  
  - **Atenuação atmosférica severa** — absortividade do oxigênio e vapor d'água em frequências acima de 60 GHz
  - **Perda por percurso (path loss)** significativamente maior que bandas sub-6 GHz
  - **Bloqueio por obstáculos** — paredes, vegetação e o próprio corpo humano causam atenuações expressivas
  - **Espalhamento temporal** — limitação da coerência de banda do canal
  
  ## Técnicas Mitigadoras
  
  ```cpp
  // Configuração de canal mmWave no NS-3
  Ptr<MmWaveChannelMatrix> channel = CreateObject<MmWaveChannelMatrix>();
  channel->SetAttribute("Scenario", StringValue("UrbanMicrostar"));
  channel->SetAttribute("Frequency", DoubleValue(28e9)); // 28 GHz
  ```
  
  A combinação de **Massive MIMO** com **Beamforming adaptativo** se mostrou indispensável para manter a estabilidade das conexões sem fio em frequências acima de 24 GHz.
  
  ## Resultados e Conclusões
  
  Com o uso de arranjos massivos de antenas e rastreamento dinâmico de feixes, é possível compensar grande parte das perdas impostas pelo canal em altas frequências, viabilizando taxas de transmissão superiores a **10 Gbps** em ambientes de curto alcance.
  
  **Publicação:** XXIV Escola Regional de Alto Desempenho da Região Sul (ERAD-RS 2024) — SBC
  **Autores:** Marcos Hiarley e José Jailton H. Ferreira Junior — UFPA
  
  BODY
  }
]

articles.each do |art_data|
  cover_filename = art_data.delete(:cover_filename)
  article = Article.create!(art_data)
  
  if cover_filename
    image_path = images_dir.join(cover_filename)
    if File.exist?(image_path)
      article.cover_image.attach(
        io: File.open(image_path),
        filename: cover_filename,
        content_type: "image/#{File.extname(cover_filename).delete('.')}"
      )
    end
  end
  
  puts "Created Article: #{article.title}"
end

puts "Database successfully seeded!"
puts "Seeded: #{AdminUser.count} admin users, #{Project.count} projects, #{Article.count} articles."
