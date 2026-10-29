# Atualização do painel da Apicultura (passo a passo)

Pasta do projeto: `C:\CIIAGRO2\painel_cadeias\Apicultura`
Use o **Git Bash**: `cd /c/CIIAGRO2/painel_cadeias/Apicultura`
(No Git Bash, rode os comandos `python scripts/...`. No Explorer, os `.bat` funcionam com dois cliques.)

A apicultura usa a MESMA tabela de carga da bovinocultura (`sisateg_receita_despesa`).
Por isso, se você acabou de atualizar a bovinocultura, **não precisa baixar de novo**: use `--so-resumo`.

## Qual comando usar

| Quando | Comando | .bat | Tempo |
|---|---|---|---|
| Bovinocultura acabou de atualizar (o mais comum) | `python scripts/atualizar_tudo.py --so-resumo` | `atualizar_so_resumo.bat` | curto |
| Atualizar sozinho (baixa do SisATeG) | `python scripts/atualizar_tudo.py --rapido` | `atualizar_apicultura.bat` | poucos minutos |
| Toda semana (olha 120 dias) | `python scripts/atualizar_tudo.py` | `atualizar_apicultura_completo.bat` | mais demorado |
| **1ª vez com o SQL novo, ou mudou o SQL** | `python scripts/atualizar_tudo.py --so-resumo --completo` | `atualizar_so_resumo_completo.bat` | só refaz o resumo |
| Recarregar a história | `python scripts/atualizar_tudo.py --desde 2024-06-01` | `atualizar_historia_completa.bat` | 15 a 20 min |

## Primeira vez com esta versão
1. `python scripts/atualizar_tudo.py --so-resumo --completo`
2. Espere aparecer **"Pronto"**.
3. Ctrl+F5 no painel.
4. Aba **Conferência**: suba a planilha do SisATeG da apicultura (um mês) e veja se bate.

## Rotina diária
1. Visitas: `C:\CIIAGRO2\integracao_ateg_painel_servidor\atualizar_visitas.bat`.
2. Bovinocultura: `python scripts/atualizar_tudo.py --rapido` (na pasta dela).
3. Apicultura: `python scripts/atualizar_tudo.py --so-resumo` (nesta pasta).
4. Ctrl+F5 no painel.
Se der erro, nada é trocado no servidor (transação única). Rode de novo.

## Regras (iguais às da bovinocultura)
- O mês da visita é a `referencia_visita` da tabela de visitas (se válida e a até 366 dias da data do item). Sem referência, vale a data mais recente dos itens.
- Visitas excluídas no SisATeG (`dt_exclusao_visita`) ficam de fora.
- Se o item tem quantidade ativa e não tem preço principal ativo, usa o preço detalhado ativo.
- O projeto **TREINAMENTO SP** nunca aparece (filtros, gráficos, tabelas, Excel e Conferência).
- Supervisor = o do `ranking_tecnicos` (uma linha por técnico, a com mais visitas); se o técnico não estiver no ranking, o do SisATeG.
- Valor do lançamento = QUANTIDADE x VALOR_UNITARIO. Atividade APICULTURA, status ATIVO, tipo PRINCIPAL.
- Receita bruta = receita menos empréstimo e investimento (venda de bem). Despesa direta = despesa menos empréstimo, investimento e o item "Mão de obra familiar" do subgrupo Mão de obra (o mesmo item em outros subgrupos CONTA; o mel consumido pela mão de obra familiar CONTA como despesa direta, como no SisATeG).

## Conferência com a planilha
- Casa pelo **ID da Visita** e compara Receitas (receita bruta + venda de bem e empréstimo), Despesas Diretas e, se a planilha tiver, a produção de mel (kg).
- Esperado: 0 diferenças. Visitas "sem lançamento de apicultura" são normais.
- Para ver o que o SisATeG tem numa visita: `python scripts/consultar_visita.py <id_visita>`.

## Se der erro
- `Unsupported content type` no ODBC: rode de novo (a carga tenta 3 vezes por mês).
- pgAdmin travado: veja `pg_stat_activity` e use `pg_terminate_backend(pid)`. Nunca `DROP ... CASCADE`.
- Rode SQL do banco local só em `api_sisateg`. O servidor é `painel_ateg`.
