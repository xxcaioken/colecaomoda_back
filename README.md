# To-Do List API - Back-end

Este é meu projeto de back-end para o teste técnico de uma aplicação To-Do List simples, desenvolvida em **Elixir** com **Phoenix Framework**.

## 🎯 O que desenvolvi

Criei uma API REST completa para gerenciamento de tarefas (tasks) que permite:

- ✅ **Criar** uma nova tarefa com título e descrição
- ✅ **Listar** todas as tarefas existentes
- ✅ **Visualizar** uma tarefa específica
- ✅ **Atualizar** o conteúdo de uma tarefa
- ✅ **Deletar** uma tarefa da lista
- ✅ **Marcar/Desmarcar** uma tarefa como concluída

## 🛠️ Tecnologias Utilizadas

- **Elixir 1.18** - Linguagem principal
- **Phoenix 1.7** - Framework web
- **SQLite** - Banco de dados (escolhido pela simplicidade de setup)
- **Ecto** - ORM para gerenciamento do banco
- **ExUnit** - Framework de testes

## 🏗️ Arquitetura e Escolhas Técnicas

### Estrutura Modular

Organizei o código seguindo as melhores práticas do Phoenix, com separação clara de responsabilidades:

```
lib/
├── colecaomoda_back/          # Context layer (business logic)
│   └── tasks/
│       ├── task.ex            # Schema e changesets
│       └── tasks.ex           # Context functions
└── colecaomoda_back_web/      # Web layer (controllers/endpoints)
    └── controllers/
        └── task_controller.ex # REST endpoints
```

### Decisões Técnicas

1. **SQLite**: Escolhi SQLite pela simplicidade de configuração e deploy, sem necessidade de servidor de banco separado.

2. **Context Pattern**: Utilizei o padrão de Context do Phoenix para separar a lógica de negócio (módulo `Tasks`) da camada web (controller).

3. **Changesets robustos**: Implementei validações detalhadas:
   - Título obrigatório (mínimo 3, máximo 255 caracteres)
   - Trim automático de espaços em branco
   - Validação de tipos boolean para status de conclusão

4. **API REST completa**: Todos os endpoints seguem convenções RESTful:
   - `GET /api/tasks` - Lista todas as tarefas
   - `GET /api/tasks/:id` - Mostra uma tarefa específica
   - `POST /api/tasks` - Cria nova tarefa
   - `PUT /api/tasks/:id` - Atualiza uma tarefa
   - `DELETE /api/tasks/:id` - Deleta uma tarefa
   - `PUT /api/tasks/:id/complete` - Toggle do status de conclusão

5. **Tratamento de erros consistente**: Implementei um padrão uniforme de resposta de erros com códigos e mensagens claras.

## 🧪 Testes Automatizados

Desenvolvi uma suíte completa de testes (47 testes) cobrindo:

- **Testes de Schema**: Validação de changesets e regras de negócio
- **Testes de Context**: Funções de CRUD e casos de erro
- **Testes de Controller**: Endpoints HTTP e respostas JSON

Para executar os testes:
```bash
mix test
```

## 🚀 Como configurar e rodar

### Pré-requisitos
- Elixir 1.18+
- Erlang 26+

### Passos para execução

1. **Clone e acesse o diretório**:
   ```bash
   cd colecaomoda_back
   ```

2. **Instale as dependências**:
   ```bash
   mix deps.get
   ```

3. **Configure o banco de dados**:
   ```bash
   mix ecto.setup
   ```

4. **Execute os testes** (opcional):
   ```bash
   mix test
   ```

5. **Inicie o servidor**:
   ```bash
   mix phx.server
   ```

A API estará disponível em `http://localhost:4000`

## 📋 Endpoints da API

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/tasks` | Lista todas as tarefas |
| GET | `/api/tasks/:id` | Mostra uma tarefa específica |
| POST | `/api/tasks` | Cria uma nova tarefa |
| PUT | `/api/tasks/:id` | Atualiza uma tarefa |
| DELETE | `/api/tasks/:id` | Deleta uma tarefa |
| PUT | `/api/tasks/:id/complete` | Alterna status de conclusão |

### Exemplo de uso

**Criar uma tarefa**:
```bash
curl -X POST http://localhost:4000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"task": {"title": "Minha nova tarefa", "description": "Descrição opcional"}}'
```

**Listar tarefas**:
```bash
curl http://localhost:4000/api/tasks
```

## 🎯 Diferenciais implementados

- **Validações robustas** com mensagens de erro claras
- **Endpoint específico** para toggle de conclusão de tarefas
- **Testes abrangentes** (100% de cobertura da lógica de negócio)
- **Tratamento de erros** padronizado
- **Código modular** e bem documentado
- **Configuração simples** sem dependências externas complexas

## 💭 Reflexões sobre a implementação

Priorizo sempre código limpo, testável e fácil de manter. A escolha do Phoenix se justifica pela sua robustez, convenções bem estabelecidas e excelente suporte a APIs REST. A estrutura modular permite fácil extensão futura da aplicação.

---

*Desenvolvido como parte do teste técnico para demonstrar proficiência em Elixir/Phoenix e desenvolvimento de APIs REST.*
