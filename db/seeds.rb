# frozen_string_literal: true
# Script to insert real LinkedIn articles by Marcos Hiarley

Article.delete_all

articles = [
  {
    title: "Como contribuí para um projeto open source (e o que aprendi)",
    slug: "como-contribui-para-um-projeto-open-source-e-o-que-aprendi",
    excerpt: "Como um bug em produção me levou a contribuir com um projeto open source — e o que aprendi sobre código, comunicação e comunidade ao abrir meus primeiros Pull Requests.",
    published: true,
    featured: true,
    published_at: Date.new(2026, 8, 5),
    body: <<~BODY
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
    published_at: Date.new(2025, 5, 1),
    body: <<~BODY
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
    published_at: Date.new(2024, 4, 1),
    body: <<~BODY
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

articles.each do |data|
  Article.create!(data)
  puts "Created: #{data[:title]}"
end

puts "Total articles: #{Article.count}"
