# Stitch Scanned Images

## stitchv1.py

stitch-scanned-images.py original com correções de bug
este stitch distorce as imagens antes de realizar o enblend final.

## stitchv2.sh

stitch mais simples. Sem distorcer as imagens antes do enblend.

## stitchv3.sh

stitch parecido com o stitchv2, mas todas as variáveis de otimização são zeradas antes da aplicação dessa otimização em si.


## Dependências do stitch-scanned-images.py

Python 3.2+, Hugin (`autooptimiser`, `cpclean`, `cpfind`, `nona`, `pto_gen`,
`pano_modify`, `pano_trafo`, `pto_var`), Enblend, ImageMagick (`convert`)

wand (imagemagick lib for python) http://docs.wand-py.org/en/0.5.6/

## License

Distributed under the [MIT License](http://www.opensource.org/licenses/MIT).
