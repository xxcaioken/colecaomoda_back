# ColecaoModa Back - API To-Do List

> **Projeto desenvolvido como teste técnico para demonstrar competências em Elixir/Phoenix**

## 🎯 Sobre o Projeto

Este projeto implementa uma **API REST completa** para gerenciamento de tarefas (To-Do List), desenvolvida com **Elixir** e **Phoenix Framework**. O objetivo foi criar uma solução robusta, escalável e seguindo as melhores práticas da linguagem e do ecossistema.

## 🚀 Tecnologias e Ferramentas

- **Elixir 1.19** - Linguagem funcional com alta concorrência
- **Phoenix 1.7.21** - Framework web moderno e performático
- **Ecto** - ORM elegante com query builder
- **SQLite3** - Banco de dados leve para desenvolvimento
- **JSON API** - Padrão REST para comunicação

## 🏗️ Arquitetura e Decisões Técnicas

### **Padrão Phoenix Context**
Implementei a arquitetura recomendada pelo Phoenix, separando responsabilidades em camadas bem definidas:

```
📁 Contexto de Negócio (Tasks)
├── Schema (Task) - Estrutura de dados e validações
├── Context (Tasks) - Lógica de negócio encapsulada
└── Migration - Versionamento do banco de dados

📁 Interface Web (TaskController)
├── Controller - Gerenciamento de requisições HTTP
├── JSON View - Serialização padronizada
└── Router - Definição de rotas RESTful
```

### **Modelagem de Dados Inteligente**
- **Schema Task** com validações apropriadas
- Campo `completed` com valor padrão `false`
- Timestamps automáticos para auditoria
- Validação obrigatória apenas para `title`

### **API RESTful Completa**
Implementei todos os endpoints necessários seguindo convenções REST:

| Método | Endpoint | Funcionalidade |
|--------|----------|----------------|
| `GET` | `/api/tasks` | Listar todas as tarefas |
| `POST` | `/api/tasks` | Criar nova tarefa |
| `GET` | `/api/tasks/:id` | Obter tarefa específica |
| `PUT/PATCH` | `/api/tasks/:id` | Atualizar tarefa |
| `DELETE` | `/api/tasks/:id` | Remover tarefa |
| `PATCH` | `/api/tasks/:id/complete` | Marcar como concluída |

### **Funcionalidade Adicional**
Criei um endpoint específico para **completar tarefas** (`PATCH /api/tasks/:id/complete`), demonstrando:
- Compreensão de princípios REST
- Facilidade de uso para o frontend
- Separação de responsabilidades

## 💡 Destaques da Implementação

### **1. Código Limpo e Padronizado**
- Seguimento rigoroso das convenções Elixir/Phoenix
- Código autodocumentado sem comentários desnecessários
- Estrutura modular e de fácil manutenção

### **2. Tratamento de Erros Robusto**
- Uso do `action_fallback` para tratamento centralizado
- Validações no nível do schema
- Respostas HTTP apropriadas

### **3. Flexibilidade de Banco de Dados**
- SQLite para desenvolvimento (simplicidade)
- Arquitetura preparada para PostgreSQL em produção
- Migrations versionadas para controle de schema

### **4. Performance e Escalabilidade**
- Queries otimizadas com Ecto
- Estrutura preparada para crescimento
- Padrões que facilitam testes e manutenção

### **5. API JSON Pura**
- Respostas em JSON puro (sem renderização server-side)
- CORS configurado para integração com frontends
- Headers apropriados para APIs REST
- Ideal para consumo por SPAs (React, Vue, Angular)

## 🔧 Como Executar

### Pré-requisitos
- Erlang/OTP 27+
- Elixir 1.15+
- SQLite3

### Instalação e Configuração

### 1. Instale as dependências
```bash
mix deps.get
```

### 2. Configure o banco de dados
```bash
mix ecto.create
mix ecto.migrate
```

### 3. Inicie o servidor
```bash
mix phx.server
```

🌐 **API disponível em:** `http://localhost:4000`

## 📋 Exemplos de Uso

### Listar tarefas
```bash
curl http://localhost:4000/api/tasks
# Resposta: {"data": []}
```

### Criar uma tarefa
```bash
curl -X POST http://localhost:4000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"task": {"title": "Implementar autenticação"}}'
# Resposta: {"data": {"id": 1, "title": "Implementar autenticação", "completed": false, ...}}
```

### Obter uma tarefa específica
```bash
curl http://localhost:4000/api/tasks/1
# Resposta: {"data": {"id": 1, "title": "...", "completed": false, ...}}
```

### Atualizar uma tarefa
```bash
curl -X PUT http://localhost:4000/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"task": {"title": "Tarefa atualizada", "completed": true}}'
```

### Marcar como concluída
```bash
curl -X PATCH http://localhost:4000/api/tasks/1/complete
# Resposta: {"data": {"id": 1, "title": "...", "completed": true, ...}}
```

### Deletar uma tarefa
```bash
curl -X DELETE http://localhost:4000/api/tasks/1
# Resposta: 204 No Content
```

## 🧪 Qualidade e Testes

```bash
# Executar testes
mix test

# Verificar rotas
mix phx.routes

# Console interativo para debugging
iex -S mix
```

## 🎨 Diferenciais Implementados

### **1. Endpoint Especializado**
Além dos CRUDs básicos, implementei um endpoint específico para completar tarefas, mostrando compreensão de design de APIs.

### **2. Contexto Rico**
O contexto `Tasks` não apenas expõe funções CRUD, mas também operações de negócio como `complete_task/1`.

### **3. Validações Inteligentes**
Campo `completed` opcional na criação (valor padrão), mas `title` obrigatório - balanceando usabilidade e integridade.

### **4. Estrutura Profissional**
Organização de código que facilita:
- Manutenção por equipes
- Adição de novas funcionalidades
- Testes automatizados
- Deploy em produção

## 🚀 Próximos Passos (Roadmap)

- [ ] Implementação de autenticação JWT
- [ ] Paginação para listagem de tarefas
- [ ] Filtros e busca
- [ ] Categorização de tarefas
- [ ] API de usuários
- [ ] Testes de integração completos
- [ ] Deploy automatizado

## 💼 Considerações Finais

Este projeto demonstra minha capacidade de:
- **Desenvolver APIs robustas** com Elixir/Phoenix
- **Aplicar boas práticas** de arquitetura de software
- **Criar código limpo** e bem estruturado
- **Documentar adequadamente** soluções técnicas
- **Pensar em escalabilidade** desde o início

A implementação está pronta para integração com frontend React e pode ser facilmente expandida para atender requisitos mais complexos de produção.
