This repository contains a definition of the [KM3](https://link.springer.com/chapter/10.1007/11768869_14) metamodeling language in Cheptre, a variant of [Ceptre](https://github.com/chrisamaphone/interactive-lp).

### Dependencies

In order to run the code from this repository you need:
* to use Linux (although it may work with other operating systems, this has not been tested),
* to have docker installed, and configured so that you can run containers with your account, for instance:
	* `sudo apt install docker.io`
	* then [add yourself to group docker](https://docs.docker.com/engine/install/linux-postinstall/)
* to have [logged in to the GitHub container registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-with-a-personal-access-token-classic).

### Running the Code

If everything is correctly setup, then you should be able to run the `./edit-km3.sh` script to start editing models.

Once you have confirmed model edition works, you can also try to replay scenario1 using: `./runScenario.sh scenario1.txt`.

### Code Description

* `KM3.pl` contains a Prolog implementation of KM3 along with a sample PetriNet metamodel, and model.
	* In addition to the `node`s, `edge`s, and `prop`s necessary to define the models' structure, it also contains well-formedness rules.
	* This code was referenced from the [original KM3 paper](https://link.springer.com/chapter/10.1007/11768869_14), and the KM3 part of it was provided as an appendix of an extended version of that paper, as well as in [Frédéric Jouault's PhD thesis](https://www.theses.fr/110218140).
* `pl2cep.sh` is a script to translate the `node`s, `edge`s, and `prop`s of `KM3.pl` into `km3.cep` (provided for reproducibility)
* `cheptre.sh` is a script to run Cheptre using docker
* `edit-km3.sh` is a script to run Cheptre (using `cheptre.sh`) with the .cep files from this repository
* `runScenario.sh` is a script that can replay scenarios, such as the one from scenario1.txt
* Cheptre code
	* `graph.cep` contains the model type definitions
	* `km3.cep` contains the translation of `KM3.pl` to Cheptre
	* `graph-helpers.cep` contains some helper bwd relations
	* `graph-validity.cep` defines the `wfr` bwd relation that encodes the KM3 well-formedness rules
	* `checking-with-manual-memoization.cep` makes it possible to check a model's validity
	* `graph-edit.cep` contains the model edition rules
	* `graph-navigate.cep` contains some model navigation rules

