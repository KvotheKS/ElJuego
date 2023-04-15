# Definições de padrão de código, pastas e arquivos do projeto

## Regras de codificação
### Espaçamento
* 1 Tab = 4 espaços
    * Para arrumar isso no editor da godot, vá em:
    >Editor>Editor Settings>General>Text Editor>Indent>Type=Spaces, Size=4

### Cases e nomes
* Variáveis: camelCase
* Variáveis privadas: _camelCase
* Funções: snake_case
* Consts, enums: UPPER_CASE
* Classes: PascalCase

### Organização da informação dentro dos arquivos .gd

A informação deve ser distribuida nessa ordem:
```
[Heranças]
...
[Classes internas]
...
[Variáveis globais]
...
[Funções]
...
[Funções de sinais]
...
```
Isso pode ser alterado caso extremamente necessário, mas é preferível que se distribua dessa forma.

### Observações

* Abreviações podem e devem ser utilizadas, desde que seu significado independa de contexto e não seja ambíguo. Termos de uso comum como *min, max, avg* são um exemplo disso;

* Organize os blocos de tarefas no código, agrupando linhas que desempenhem uma tarefa e usando linhas vazias entre os blocos para separar;

* Comentários devem ir direto ao ponto, explicando como usar a estrutura que descrevem e o intervalo de entradas e saídas esperados;

    * Tenha bom senso em definir o que precisa ou não de comentários. Trechos óbvios não precisam, mas garanta que será óbvio para os outros; 

* Evite nomes esotéricos como o famoso *brimbus*, a não ser que sua variável seja uma temporária sem relevância e apareça em no máximo duas linhas.

* Caso possível, quebre linhas longas com muita informação em mais de uma linha no bloco.
    * Você pode usar as guias para ajudar a julgar o tamanho da linha, configure-as em: 
    > Editor>Editor Settings>General>Text Editor>Appearance>Show Line Length Guidelines=on, Line Length Guideline Soft=80, Line Length Guideline Hard=120

* Código verboso demais dá sono.

___
## Regras de estruturação de pastas e arquivos

A hierarquia de pastas pode seguir esse modelo, a partir da res:// do projeto:
```
res://
│
├── Addons
├── Assets
│   ├── Font
│   ├── Map
│   ├── Music
│   ├── SoundFX
│   ├── Sprite
│   └── Text
├── .Docs //Pasta oculta ao projeto
├── Scenes
└── Scripts

```

A estrutura interna dessas pastas principais pode se dividir em:
```
Parent
│
├── Enemy
│   └── ...
├── HUD
├── NPC
│   └── ...
├── Player
├── Scenario
│   └── ...
├── Shader
└── ...
```
É bom evitar criar mais que 5 níveis de pasta, ou os imports de arquivos podem ficar longos. 

A partir dessa estrutura, a organização fica pelos filenames expressando o que fazer:
```
[name/action]_[number].extension
```
Por exemplo, um player possui duas spritesheets para a animação de idle. Os filenames serão:
```
res://
│
└── Assets
    └── Sprite
        └── Player
            ├── idle_000.png
            └── idle_001.png
```
___
## Extras
* Códigos, pastas e arquivos devem estar em inglês.
___
