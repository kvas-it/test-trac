.PHONY: run clean

PORT=8000

PYTHON=venv/bin/python
PIP=venv/bin/pip
TRACADMIN=venv/bin/trac-admin
TRACD=venv/bin/tracd

run: penv .htpasswd
	${TRACD} -s -p ${PORT} --basic-auth="penv,.htpasswd,Test" penv

.htpasswd: penv
	${PYTHON} htpasswd.py -bc .htpasswd admin admin
	${PYTHON} htpasswd.py -b .htpasswd bot bot

penv: ${TRACADMIN}
	${TRACADMIN} penv initenv Test sqlite:db/trac.db
	${TRACADMIN} penv component add test-component-1
	${TRACADMIN} penv component add test-component-2
	${TRACADMIN} penv milestone add test-milestone-1.1
	${TRACADMIN} penv milestone completed test-milestone-1.1 now
	${TRACADMIN} penv milestone add test-milestone-1.2
	${TRACADMIN} penv milestone add test-milestone-1.3
	${TRACADMIN} penv permission add admin TRAC_ADMIN
	${TRACADMIN} penv permission add bot TRAC_ADMIN

${TRACADMIN}: venv
	${PIP} install trac

venv:
	virtualenv venv

clean:
	rm -Rf venv penv .htpasswd
