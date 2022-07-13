### Лог создания образа Backend 

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/backend# docker build -t zakharovnpa/k8s-backend:12.07.22 .
Sending build context to Docker daemon  20.48kB
Step 1/9 : FROM python:3.9-buster
 ---> 999912f2c071
Step 2/9 : ENV DATABASE_URL=postgres://postgres:postgres@db:5432/news
 ---> Running in 7324f5741cf5
Removing intermediate container 7324f5741cf5
 ---> 056877d49c98
Step 3/9 : RUN mkdir /app && python -m pip install pipenv
 ---> Running in 06e093391fb1
Collecting pipenv
  Downloading pipenv-2022.7.4-py2.py3-none-any.whl (3.7 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.7/3.7 MB 7.2 MB/s eta 0:00:00
Requirement already satisfied: pip>=22.0.4 in /usr/local/lib/python3.9/site-packages (from pipenv) (22.0.4)
Collecting virtualenv
  Downloading virtualenv-20.15.1-py2.py3-none-any.whl (10.1 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 10.1/10.1 MB 10.0 MB/s eta 0:00:00
Collecting certifi
  Downloading certifi-2022.6.15-py3-none-any.whl (160 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 160.2/160.2 KB 13.3 MB/s eta 0:00:00
Collecting virtualenv-clone>=0.2.5
  Downloading virtualenv_clone-0.5.7-py3-none-any.whl (6.6 kB)
Requirement already satisfied: setuptools>=36.2.1 in /usr/local/lib/python3.9/site-packages (from pipenv) (58.1.0)
Collecting platformdirs<3,>=2
  Downloading platformdirs-2.5.2-py3-none-any.whl (14 kB)
Collecting six<2,>=1.9.0
  Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Collecting distlib<1,>=0.3.1
  Downloading distlib-0.3.4-py2.py3-none-any.whl (461 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 461.2/461.2 KB 9.7 MB/s eta 0:00:00
Collecting filelock<4,>=3.2
  Downloading filelock-3.7.1-py3-none-any.whl (10 kB)
Installing collected packages: distlib, virtualenv-clone, six, platformdirs, filelock, certifi, virtualenv, pipenv
Successfully installed certifi-2022.6.15 distlib-0.3.4 filelock-3.7.1 pipenv-2022.7.4 platformdirs-2.5.2 six-1.16.0 virtualenv-20.15.1 virtualenv-clone-0.5.7


**Красным цветом ###################################################### Красным цветом**
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv
WARNING: You are using pip version 22.0.4; however, version 22.1.2 is available.
You should consider upgrading via the '/usr/local/bin/python -m pip install --upgrade pip' command.
**Красным цветом ###################################################### Красным цветом**

Removing intermediate container 06e093391fb1
 ---> 585528af6188
Step 4/9 : WORKDIR /app
 ---> Running in ba0576db7c9e
Removing intermediate container ba0576db7c9e
 ---> 08d231da8d94
Step 5/9 : ADD Pipfile /app/Pipfile
 ---> dd15e82f6759
Step 6/9 : ADD Pipfile.lock /app/Pipfile.lock
 ---> 1b042e242d4e
Step 7/9 : RUN pipenv install
 ---> Running in 665bc3e82161
 
**Красным цветом ###################################################### Красным цветом**
Creating a virtualenv for this project...
Pipfile: /app/Pipfile
Using /usr/local/bin/python3.9 (3.9.13) to create virtualenv...
⠹ Creating virtual environment...created virtual environment CPython3.9.13.final.0-64 in 834ms
  creator CPython3Posix(dest=/root/.local/share/virtualenvs/app-4PlAip0Q, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/root/.local/share/virtualenv)
    added seed packages: pip==22.1.2, setuptools==62.6.0, wheel==0.37.1
  activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator

✔ Successfully created virtual environment! 
Virtualenv location: /root/.local/share/virtualenvs/app-4PlAip0Q
Installing dependencies from Pipfile.lock (e9059d)...
  🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 11/11 — 00:00:19
**Красным цветом ###################################################### Красным цветом**
  
To activate this project's virtualenv, run pipenv shell.
Alternatively, run a command inside the virtualenv with pipenv run.
Removing intermediate container 665bc3e82161
 ---> 01e0930173c1
Step 8/9 : ADD main.py /app/main.py
 ---> f70ad4c3ce94
Step 9/9 : CMD pipenv run uvicorn main:app --reload --host 0.0.0.0 --port 9000
 ---> Running in c77922512e7c
Removing intermediate container c77922512e7c
 ---> 5d97bf6ad02f
Successfully built 5d97bf6ad02f
Successfully tagged zakharovnpa/k8s-backend:12.07.22

```
