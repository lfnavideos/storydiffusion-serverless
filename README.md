# StoryDiffusion Serverless - A Bíblia em Vídeos

Template RunPod Serverless customizado para gerar imagens consistentes de personagens bíblicos.

## Recursos

- **18+ personagens bíblicos** pré-definidos (Abraão, Moisés, Davi, Jesus, Maria, etc.)
- **Consistência visual** entre múltiplas cenas
- **3 estilos visuais**: photorealistic, artistic, epic
- **Suporte a imagem de referência** para personagens customizados
- **Otimizado para SDXL** com RealVisXL v4.0

## Requisitos

- **GPU**: 24GB VRAM (RTX 4090, A10, L4)
- **Modelo**: ~15GB de download na primeira execução

## Deploy no RunPod

1. Criar novo Serverless Endpoint
2. Selecionar "Deploy from GitHub"
3. Apontar para este repositório
4. Selecionar GPU com 24GB+ VRAM

## API

### Exemplo 1: Usando banco de personagens

```json
{
  "input": {
    "scenes": [
      {"character": "abraham", "action": "looking at starry night sky with tears of joy"},
      {"character": "abraham", "action": "receiving three divine visitors at his tent"},
      {"character": "abraham", "action": "walking up Mount Moriah with young Isaac"}
    ],
    "width": 768,
    "height": 768,
    "num_inference_steps": 25,
    "seed": 42,
    "style": "photorealistic"
  }
}
```

### Exemplo 2: Prompts livres

```json
{
  "input": {
    "prompts": [
      "Moses parting the Red Sea, dramatic lighting, epic scene",
      "Moses receiving the Ten Commandments on Mount Sinai",
      "Moses leading israelites through the desert"
    ],
    "style": "epic"
  }
}
```

### Resposta

```json
{
  "images": [
    {"index": 0, "base64": "...", "prompt": "...", "character": "abraham"},
    {"index": 1, "base64": "...", "prompt": "...", "character": "abraham"},
    {"index": 2, "base64": "...", "prompt": "...", "character": "abraham"}
  ],
  "seed": 42,
  "count": 3,
  "style": "photorealistic"
}
```

## Personagens Disponíveis

| ID | Nome | Descrição |
|----|------|-----------|
| abraham | Abraão | Patriarca idoso, barba branca longa |
| moses | Moisés | Profeta, barba grisalha, cajado |
| david | Davi | Jovem pastor, cabelos castanhos cacheados |
| david_king | Davi Rei | Rei maduro, coroa dourada |
| jesus | Jesus | Cabelos castanhos longos, expressão serena |
| mary | Maria | Jovem mulher, véu, expressão gentil |
| joseph | José | Carpinteiro, barba castanha |
| peter | Pedro | Pescador, cabelos grisalhos cacheados |
| paul | Paulo | Careca, barba escura, olhar intenso |
| noah | Noé | Muito idoso, barba branca muito longa |
| daniel | Daniel | Jovem nobre, porte digno |
| adam | Adão | Homem perfeito, sem barba inicial |
| eve | Eva | Mulher bela, cabelos longos |
| solomon | Salomão | Rei rico, sábio, joias |
| elijah | Elias | Profeta selvagem, cabelos longos |
| john_baptist | João Batista | Asceta, vestes de pelo de camelo |
| goliath | Golias | Gigante guerreiro, armadura pesada |
| samson | Sansão | Extremamente musculoso, cabelos muito longos |

## Estilos

- **photorealistic**: 8K, iluminação cinematográfica, texturas realistas
- **artistic**: Estilo pintura a óleo, arte religiosa clássica
- **epic**: Cenas épicas, iluminação dramática, névoa volumétrica

## Variáveis de Ambiente

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| MODEL_ID | SG161222/RealVisXL_V4.0 | Modelo SDXL a usar |

## Custos Estimados

- ~$0.005-0.01 por imagem no RunPod (RTX 4090)
- ~20-30 segundos por imagem
- Cold start: ~2-3 minutos (download do modelo)
