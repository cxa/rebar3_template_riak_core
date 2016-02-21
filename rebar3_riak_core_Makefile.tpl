BASEDIR = $(shell pwd)
REBAR = rebar3
RELPATH = _build/default/rel/{{ name }}
APPNAME = {{ name }}
SHELL = /bin/bash

release:
	$(REBAR) cuttlefish release

compile:
	$(REBAR) compile

clean:
	$(REBAR) clean

test:
	$(REBAR) ct

devrel1:
	$(REBAR) as dev1 cuttlefish release

devrel2:
	$(REBAR) as dev2 cuttlefish release

devrel3:
	$(REBAR) as dev3 cuttlefish release

devrel: devrel1 devrel2 devrel3

dev1-console:
	$(BASEDIR)/_build/dev1/rel/{{ name }}/bin/$(APPNAME) console

dev2-console:
	$(BASEDIR)/_build/dev2/rel/{{ name }}/bin/$(APPNAME) console

dev3-console:
	$(BASEDIR)/_build/dev3/rel/{{ name }}/bin/$(APPNAME) console

devrel-start:
	for d in $(BASEDIR)/_build/dev*; do $$d/rel/{{ name }}/bin/$(APPNAME) start; done

devrel-join:
	for d in $(BASEDIR)/_build/dev{2,3}; do $$d/rel/{{ name }}/bin/$(APPNAME)-admin cluster join {{ name }}1@127.0.0.1; done

devrel-cluster-plan:
	$(BASEDIR)/_build/dev1/rel/{{ name }}/bin/$(APPNAME)-admin cluster plan

devrel-cluster-commit:
	$(BASEDIR)/_build/dev1/rel/{{ name }}/bin/$(APPNAME)-admin cluster commit

devrel-status:
	$(BASEDIR)/_build/dev1/rel/{{ name }}/bin/$(APPNAME)-admin member-status

devrel-ping:
	for d in $(BASEDIR)/_build/dev*; do $$d/rel/{{ name }}/bin/$(APPNAME) ping; done

devrel-stop:
	for d in $(BASEDIR)/_build/dev*; do $$d/rel/{{ name }}/bin/$(APPNAME) stop; done

start:
	$(BASEDIR)/$(RELPATH)/bin/$(APPNAME) start

stop:
	$(BASEDIR)/$(RELPATH)/bin/$(APPNAME) stop

console:
	$(BASEDIR)/$(RELPATH)/bin/$(APPNAME) console

attach:
	$(BASEDIR)/$(RELPATH)/bin/$(APPNAME) attach

