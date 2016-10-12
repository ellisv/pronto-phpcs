# Pronto runner for PHP CodeSniffer

[![Build Status](https://travis-ci.org/EllisV/pronto-phpcs.svg?branch=master)](https://travis-ci.org/EllisV/pronto-phpcs)

Pronto runner for [PHP CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer).
[What is Pronto?](https://github.com/mmozuras/pronto)

Configuration
-------------

Configuration is available via following environment variables

| Name                      | Description                                                               | Default |
|---------------------------|---------------------------------------------------------------------------|---------|
| `PRONTO_PHPCS_EXECUTABLE` | Path to a PHP CodeSniffer executable                                      | phpcs   |
| `PRONTO_PHPCS_STANDARD`   | Which standard to run. Name of a built in standard or a path to standard. | PSR2    |

Copyright
---------

Copyright (c) 2016 Eligijus Vitkauskas. See [LICENSE](LICENSE) for further details.
