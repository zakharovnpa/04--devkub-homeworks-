## Задание 3(*): Работа с Jsonnet. Создание из файла yaml шаблона jsonnet для создания манифестов. Конвертирование файлов

### Ход выполнения
```
controlplane $ 
controlplane $ cd app1
bash: cd: app1: No such file or directory
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
drwxr-xr-x 4 root root 4.0K Aug 18 16:17 fb-pod-app1
drwxr-xr-x 4 root root 4.0K Aug 18 16:17 fb-pod-app2
drwxr-xr-x 4 root root 4.0K Aug 18 16:17 fb-pod-app3
-rw-r--r-- 1 root root    0 Aug 18 16:17 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 stage-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 stage-pvc.yaml
controlplane $ 
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 .
drwx------ 9 root root 4.0K Aug 18 16:19 ..
drwxr-xr-x 2 root root 4.0K Aug 18 16:17 app1
drwxr-xr-x 2 root root 4.0K Aug 18 16:17 app2
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 stage
controlplane $ 
controlplane $ cd app1
controlplane $ 
controlplane $ ls -lha
total 8.0K
drwxr-xr-x 2 root root 4.0K Aug 18 16:17 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
controlplane $ 
controlplane $ vi fb-pod.yaml
controlplane $ 
controlplane $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet

Command 'jsonnetfmt' not found, but can be installed with:

apt install jsonnet

yaml2jsonnet: command not found
controlplane $ 
controlplane $ apt install jsonnet
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  jsonnet
0 upgraded, 1 newly installed, 0 to remove and 166 not upgraded.
Need to get 378 kB of archives.
After this operation, 1964 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 jsonnet amd64 0.15.0+ds-1build1 [378 kB]
Fetched 378 kB in 1s (512 kB/s)  
Selecting previously unselected package jsonnet.
(Reading database ... 73096 files and directories currently installed.)
Preparing to unpack .../jsonnet_0.15.0+ds-1build1_amd64.deb ...
Unpacking jsonnet (0.15.0+ds-1build1) ...
Setting up jsonnet (0.15.0+ds-1build1) ...
controlplane $ 
controlplane $ 
controlplane $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet
yaml2jsonnet: command not found
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ vi fb-pod.yaml
controlplane $ 
controlplane $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet
yaml2jsonnet: command not found
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ apt install jsonnet
Reading package lists... Done
Building dependency tree       
Reading state information... Done
jsonnet is already the newest version (0.15.0+ds-1build1).
0 upgraded, 0 newly installed, 0 to remove and 166 not upgraded.
controlplane $ 
controlplane $ apt install python3-pip -y
Reading package lists... Done
Building dependency tree       
Reading state information... Done
python3-pip is already the newest version (20.0.2-5ubuntu1.6).
0 upgraded, 0 newly installed, 0 to remove and 166 not upgraded.
controlplane $ 
controlplane $ pip install yaml2jsonnet
Collecting yaml2jsonnet
  Downloading yaml2jsonnet-1.0.1-py3-none-any.whl (19 kB)
Collecting ruamel.yaml<0.17.0,>=0.16.10
  Downloading ruamel.yaml-0.16.13-py2.py3-none-any.whl (111 kB)
     |████████████████████████████████| 111 kB 10.4 MB/s 
Collecting ruamel.yaml.clib>=0.1.2; platform_python_implementation == "CPython" and python_version < "3.10"
  Downloading ruamel.yaml.clib-0.2.6-cp38-cp38-manylinux1_x86_64.whl (570 kB)
     |████████████████████████████████| 570 kB 59.3 MB/s 
Installing collected packages: ruamel.yaml.clib, ruamel.yaml, yaml2jsonnet
Successfully installed ruamel.yaml-0.16.13 ruamel.yaml.clib-0.2.6 yaml2jsonnet-1.0.1
```
```
controlplane $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod.jsonnet
```
* fb-pod.jsonnet
```
{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
    labels: {
      app: 'fb',
    },
  },
  spec: {
    type: 'NodePort',
    ports: [
      {
        port: 80,
        nodePort: '{{ .Values.nodePort }}',
      },
    ],
    selector: {
      app: 'fb-pod',
    },
  },
}
```
```
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod.yaml   
```
* fb-pod.yaml   
```
---
{
  "apiVersion": "v1",
  "kind": "Service",
  "metadata": {
    "name": "{{ .Values.name }}",
    "namespace": "{{ .Values.namespace }}",
    "labels": {
      "app": "fb"
    }
  },
  "spec": {
    "type": "NodePort",
    "ports": [
      {
        "port": 80,
        "nodePort": "{{ .Values.nodePort }}"
      }
    ],
    "selector": {
      "app": "fb-pod"
    }
  }
}
```
```
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ rm fb-pod.yaml 
controlplane $ 
controlplane $ jsonnet fb-pod.jsonnet > fb-pod.yaml
controlplane $ 
controlplane $ cat fb-pod.yaml
```
* fb-pod.yaml
```
{
   "apiVersion": "v1",
   "kind": "Service",
   "metadata": {
      "labels": {
         "app": "fb"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "ports": [
         {
            "nodePort": "{{ .Values.nodePort }}",
            "port": 80
         }
      ],
      "selector": {
         "app": "fb-pod"
      },
      "type": "NodePort"
   }
}
```
```
controlplane $ 
controlplane $ vi deployment.json
controlplane $ 
controlplane $ 
controlplane $ cat deployment.json 
```
* deployment.json 
```
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "fb-app"
    },
    "name": "{{ .Values.name }}",
    "namespace": "{{ .Values.namespace }}"
  },
  "spec": {
    "replicas": "{{ .Values.replicaCount }}",
    "selector": {
      "matchLabels": {
        "app": "fb-app"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "fb-app"
        }
      },
      "spec": {
        "containers": [
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "frontend",
            "ports": [
              {
                "containerPort": 80
              }
            ],
            "volumeMounts": [
              {
                "mountPath": "/static",
                "name": "my-volume"
              }
            ]
          },
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "backend",
            "volumeMounts": [
              {
                "mountPath": "/tmp/cache",
                "name": "my-volume"
              }
            ]
          }
        ],
        "volumes": [
          {
            "name": "my-volume",
            "emptyDir": {
            }
          }
        ]
      }
    }
  }
}
```
```
controlplane $ 
controlplane $ 
controlplane $                                                              
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Aug 18 16:37 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
-rw-r--r-- 1 root root 1.5K Aug 18 16:37 deployment.json
-rw-r--r-- 1 root root  354 Aug 18 16:29 fb-pod.jsonnet
-rw-r--r-- 1 root root  419 Aug 18 16:36 fb-pod.yaml
controlplane $ 
controlplane $ vi deployment.yaml
controlplane $ 
controlplane $ cat deployment.yaml 
```
* deployment.yaml 
```
--
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: "{{ .Values.name }}"
  namespace: "{{ .Values.namespace }}"
spec:
  replicas: "{{ .Values.replicaCount }}"
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}"  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}"
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
```
```
controlplane $ 
controlplane $ 
controlplane $ yaml2jsonnet deployment.yaml | jsonnetfmt - -o deployment.jsonnet
Traceback (most recent call last):
  File "/usr/local/bin/yaml2jsonnet", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 58, in main
    run(args)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 47, in run
    convert_yaml(yaml_data, args.out, args.document_comments)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/yaml2jsonnet.py", line 14, in convert_yaml
    JsonnetRenderer(events, output, array, inject_comments).render()
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 203, in render
    for event in self.events:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 676, in parse
    while parser.check_event():
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/parser.py", line 140, in check_event
    self.current_event = self.state()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/parser.py", line 176, in parse_stream_start
    token.move_comment(self.scanner.peek_token())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/scanner.py", line 1778, in peek_token
    self._gather_comments()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/scanner.py", line 1806, in _gather_comments
    self.fetch_more_tokens()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/scanner.py", line 283, in fetch_more_tokens
    return self.fetch_value()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/scanner.py", line 652, in fetch_value
    raise ScannerError(
ruamel.yaml.scanner.ScannerError: mapping values are not allowed here
  in "<unicode string>", line 2, column 11:
    apiVersion: apps/v1
              ^ (line: 2)
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ cat deployment.json 
```
* deployment.json 
```
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "fb-app"
    },
    "name": "{{ .Values.name }}",
    "namespace": "{{ .Values.namespace }}"
  },
  "spec": {
    "replicas": "{{ .Values.replicaCount }}",
    "selector": {
      "matchLabels": {
        "app": "fb-app"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "fb-app"
        }
      },
      "spec": {
        "containers": [
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "frontend",
            "ports": [
              {
                "containerPort": 80
              }
            ],
            "volumeMounts": [
              {
                "mountPath": "/static",
                "name": "my-volume"
              }
            ]
          },
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "backend",
            "volumeMounts": [
              {
                "mountPath": "/tmp/cache",
                "name": "my-volume"
              }
            ]
          }
        ],
        "volumes": [
          {
            "name": "my-volume",
            "emptyDir": {
            }
          }
        ]
      }
    }
  }
}
```

```
controlplane $ yaml2jsonnet deployment.json | jsonnetfmt - -o deployment.jsonnet
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 2 root root 4.0K Aug 18 16:41 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
-rw-r--r-- 1 root root 1.5K Aug 18 16:37 deployment.json
-rw-r--r-- 1 root root 1.4K Aug 18 16:41 deployment.jsonnet
-rw-r--r-- 1 root root  958 Aug 18 16:39 deployment.yaml
-rw-r--r-- 1 root root  354 Aug 18 16:29 fb-pod.jsonnet
-rw-r--r-- 1 root root  419 Aug 18 16:36 fb-pod.yaml
controlplane $ 
controlplane $ cat deployment.jsonnet 
```
* deployment.jsonnet 
```
{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    labels: {
      app: 'fb-app',
    },
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
  },
  spec: {
    replicas: '{{ .Values.replicaCount }}',
    selector: {
      matchLabels: {
        app: 'fb-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'fb-app',
        },
      },
      spec: {
        containers: [
          {
            image: '{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'frontend',
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
              {
                mountPath: '/static',
                name: 'my-volume',
              },
            ],
          },
          {
            image: '{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'backend',
            volumeMounts: [
              {
                mountPath: '/tmp/cache',
                name: 'my-volume',
              },
            ],
          },
        ],
        volumes: [
          {
            name: 'my-volume',
            emptyDir: {
            },
          },
        ],
      },
    },
  },
}
```

```
controlplane $ 
controlplane $ cat deployment.json    
```
* deployment.json    
```
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "fb-app"
    },
    "name": "{{ .Values.name }}",
    "namespace": "{{ .Values.namespace }}"
  },
  "spec": {
    "replicas": "{{ .Values.replicaCount }}",
    "selector": {
      "matchLabels": {
        "app": "fb-app"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "fb-app"
        }
      },
      "spec": {
        "containers": [
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "frontend",
            "ports": [
              {
                "containerPort": 80
              }
            ],
            "volumeMounts": [
              {
                "mountPath": "/static",
                "name": "my-volume"
              }
            ]
          },
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "backend",
            "volumeMounts": [
              {
                "mountPath": "/tmp/cache",
                "name": "my-volume"
              }
            ]
          }
        ],
        "volumes": [
          {
            "name": "my-volume",
            "emptyDir": {
            }
          }
        ]
      }
    }
  }
}
```

```
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ mv deployment.yaml deployment.txt
controlplane $ 
controlplane $ jsonnet deployment.jsonnet > deployment.yaml
controlplane $ 
controlplane $ cat deployment.yaml 
```
* deployment.yaml 
```
{
   "apiVersion": "apps/v1",
   "kind": "Deployment",
   "metadata": {
      "labels": {
         "app": "fb-app"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "replicas": "{{ .Values.replicaCount }}",
      "selector": {
         "matchLabels": {
            "app": "fb-app"
         }
      },
      "template": {
         "metadata": {
            "labels": {
               "app": "fb-app"
            }
         },
         "spec": {
            "containers": [
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "frontend",
                  "ports": [
                     {
                        "containerPort": 80
                     }
                  ],
                  "volumeMounts": [
                     {
                        "mountPath": "/static",
                        "name": "my-volume"
                     }
                  ]
               },
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "backend",
                  "volumeMounts": [
                     {
                        "mountPath": "/tmp/cache",
                        "name": "my-volume"
                     }
                  ]
               }
            ],
            "volumes": [
               {
                  "emptyDir": { },
                  "name": "my-volume"
               }
            ]
         }
      }
   }
}
```

```
controlplane $ 
controlplane $ 
controlplane $ jsonnet --help
Jsonnet commandline interpreter v0.15.0

jsonnet {<option>} <filename>

Available options:
  -h / --help             This message
  -e / --exec             Treat filename as code
  -J / --jpath <dir>      Specify an additional library search dir (right-most wins)
  -o / --output-file <file> Write to the output file rather than stdout
  -m / --multi <dir>      Write multiple files to the directory, list files on stdout
  -y / --yaml-stream      Write output as a YAML stream of JSON documents
  -S / --string           Expect a string, manifest as plain text
  -s / --max-stack <n>    Number of allowed stack frames
  -t / --max-trace <n>    Max length of stack trace before cropping
  --gc-min-objects <n>    Do not run garbage collector until this many
  --gc-growth-trigger <n> Run garbage collector after this amount of object growth
  --version               Print version
Available options for specifying values of 'external' variables:
Provide the value as a string:
  -V / --ext-str <var>[=<val>]     If <val> is omitted, get from environment var <var>
       --ext-str-file <var>=<file> Read the string from the file
Provide a value as Jsonnet code:
  --ext-code <var>[=<code>]    If <code> is omitted, get from environment var <var>
  --ext-code-file <var>=<file> Read the code from the file
Available options for specifying values of 'top-level arguments':
Provide the value as a string:
  -A / --tla-str <var>[=<val>]     If <val> is omitted, get from environment var <var>
       --tla-str-file <var>=<file> Read the string from the file
Provide a value as Jsonnet code:
  --tla-code <var>[=<code>]    If <code> is omitted, get from environment var <var>
  --tla-code-file <var>=<file> Read the code from the file
Environment variables:
JSONNET_PATH is a colon (semicolon on Windows) separated list of directories added
in reverse order before the paths specified by --jpath (i.e. left-most wins)
E.g. JSONNET_PATH=a:b jsonnet -J c -J d is equivalent to:
JSONNET_PATH=d:c:a:b jsonnet
jsonnet -J b -J a -J c -J d

In all cases:
<filename> can be - (stdin)
Multichar options are expanded e.g. -abc becomes -a -b -c.
The -- option suppresses option processing for subsequent arguments.
Note that since filenames and jsonnet programs can begin with -, it is advised to
use -- if the argument is unknown, e.g. jsonnet -- "$FILENAME".
```

```
controlplane $ mv deployment.yaml deployment-2.txt
controlplane $ 
controlplane $ jsonnet deployment.jsonnet -y deployment.yaml
ERROR: only one filename is allowed

controlplane $ 
controlplane $                                              
controlplane $ ll -lha
total 32K
drwxr-xr-x 2 root root 4.0K Aug 18 16:47 ./
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ../
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
-rw-r--r-- 1 root root 1.7K Aug 18 16:44 deployment-2.txt
-rw-r--r-- 1 root root 1.5K Aug 18 16:37 deployment.json
-rw-r--r-- 1 root root 1.4K Aug 18 16:41 deployment.jsonnet
-rw-r--r-- 1 root root  958 Aug 18 16:39 deployment.txt
-rw-r--r-- 1 root root  354 Aug 18 16:29 fb-pod.jsonnet
-rw-r--r-- 1 root root  419 Aug 18 16:36 fb-pod.yaml
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 32K
drwxr-xr-x 2 root root 4.0K Aug 18 16:47 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
-rw-r--r-- 1 root root 1.7K Aug 18 16:44 deployment-2.txt
-rw-r--r-- 1 root root 1.5K Aug 18 16:37 deployment.json
-rw-r--r-- 1 root root 1.4K Aug 18 16:41 deployment.jsonnet
-rw-r--r-- 1 root root  958 Aug 18 16:39 deployment.txt
-rw-r--r-- 1 root root  354 Aug 18 16:29 fb-pod.jsonnet
-rw-r--r-- 1 root root  419 Aug 18 16:36 fb-pod.yaml
```

```
controlplane $ jsonnet -y deployment.jsonnet                   
RUNTIME ERROR: stream mode: top-level object was a object, should be an array whose elements hold the JSON for each document in the stream.
        During manifestation
controlplane $ 
controlplane $ jsonnet -y deployment.json   
RUNTIME ERROR: stream mode: top-level object was a object, should be an array whose elements hold the JSON for each document in the stream.
        During manifestation
controlplane $ 
controlplane $ ^C

```
#### Дальенйшие действия привели к нужному результату.
```
controlplane $ jsonnet -y deployment.json
RUNTIME ERROR: stream mode: top-level object was a object, should be an array whose elements hold the JSON for each document in the stream.
        During manifestation
controlplane $ 
controlplane $ jsonnet -y deployment.jsonnet
```
* Создался файл с расширением jsonnet, но формата yaml 
```
---
{
   "apiVersion": "apps/v1",
   "kind": "Deployment",
   "metadata": {
      "labels": {
         "app": "fb-app"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "replicas": "{{ .Values.replicaCount }}",
      "selector": {
         "matchLabels": {
            "app": "fb-app"
         }
      },
      "template": {
         "metadata": {
            "labels": {
               "app": "fb-app"
            }
         },
         "spec": {
            "containers": [
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "frontend",
                  "ports": [
                     {
                        "containerPort": 80
                     }
                  ],
                  "volumeMounts": [
                     {
                        "mountPath": "/static",
                        "name": "my-volume"
                     }
                  ]
               },
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "backend",
                  "volumeMounts": [
                     {
                        "mountPath": "/tmp/cache",
                        "name": "my-volume"
                     }
                  ]
               }
            ],
            "volumes": [
               {
                  "emptyDir": { },
                  "name": "my-volume"
               }
            ]
         }
      }
   }
}
...
controlplane $ 
controlplane $ 
```
* Создался файл с расширением jsonnet, но формата yaml `-rw-r--r-- 1 root root 1.4K Aug 18 17:13 deployment.jsonnet`
```
controlplane $ 
controlplane $ ls -lha
total 32K
drwxr-xr-x 2 root root 4.0K Aug 18 17:13 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
-rw-r--r-- 1 root root 1.7K Aug 18 16:44 deployment-2.txt
-rw-r--r-- 1 root root 1.5K Aug 18 16:37 deployment.json
-rw-r--r-- 1 root root 1.4K Aug 18 17:13 deployment.jsonnet
-rw-r--r-- 1 root root  958 Aug 18 16:39 deployment.txt
-rw-r--r-- 1 root root  354 Aug 18 16:29 fb-pod.jsonnet
-rw-r--r-- 1 root root  419 Aug 18 16:36 fb-pod.yaml
controlplane $ 
controlplane $ date
Thu Aug 18 17:16:08 UTC 2022
```

### Логи
* Tab 1
```
 apiVersion: v1
> kind: Service
> metadata:
>   name: "{{ .Values.name }}"
>   namespace: "{{ .Values.namespace }}"
>   labels:
>     app: fb
> spec:
>   type: NodePort
>   ports:
>   - port: 80
>     nodePort: "{{ .Values.nodePort }}"
>   selector:
>     app: fb-pod
> " > service.yaml && \
> cd .. && \
> echo "
> # Default values for fb-pod.
> # This is a YAML-formatted file.
> # Declare variables to be passed into your templates.
> 
> replicaCount: "1"
> 
> name: fb-pod-app1
> 
> namespace: app1
> 
> image:
>   repository: zakharovnpa
>   name_front: k8s-frontend
>   name_back: k8s-backend
>   tag: "05.07.22"
> nodePort: 30080
> " > values.yaml && \
> cd .. && \
> helm template fb-pod-app1 && \
> helm install fb-pod-app1 fb-pod-app1 && \
> cp -r fb-pod-app1 fb-pod-app2 && \
> cp -r fb-pod-app1 fb-pod-app3 && \
> echo "
> # Default values for fb-pod.
> # This is a YAML-formatted file.
> # Declare variables to be passed into your templates.
> 
> replicaCount: "1"
> 
> name: fb-pod-app2
> 
> namespace: app1
> 
> image:
>   repository: zakharovnpa
>   name_front: k8s-frontend
>   name_back: k8s-backend
>   tag: "12.07.22"
> nodePort: 30081
> " > fb-pod-app2/values.yaml && \
> echo "
> apiVersion: v2
> name: fb-pod-app3
> description: A Helm chart for Kubernetes
> type: application
> version: 0.1.0
> appVersion: "13.07.22"
> " > fb-pod-app3/Chart.yaml && \
> echo "
> apiVersion: v2
> name: fb-pod-app2
> description: A Helm chart for Kubernetes
> type: application
> version: 0.1.0
> appVersion: "12.07.22"
> " > fb-pod-app2/Chart.yaml && \
> echo "
> # Default values for fb-pod.
> # This is a YAML-formatted file.
> # Declare variables to be passed into your templates.
> 
> replicaCount: "1"
> 
> name: fb-pod-app3
> 
> namespace: app2
> 
> image:
>   repository: zakharovnpa
>   name_front: k8s-frontend
>   name_back: k8s-backend
>   tag: "13.07.22"
> nodePort: 30082
> " > fb-pod-app3/values.yaml && \
> kubectl -n app1 get po && \
> echo "kubectl -n app1 get po"
Downloading https://get.helm.sh/helm-v3.9.3-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
Thu Aug 18 16:17:13 UTC 2022
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0   265k      0 --:--:-- --:--:-- --:--:--  265k
Helm v3.9.3 is already latest
"stable" has been added to your repositories
"prometheus-community" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Thu Aug 18 16:17:18 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The NFS Provisioner service has now been installed.

A storage class named 'nfs' has now been created
and is available to provision dynamic volumes.

You can use this storageclass by creating a `PersistentVolumeClaim` with the
correct storageClassName attribute. For example:

    ---
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: test-dynamic-volume-claim
    spec:
      storageClassName: "nfs"
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 166 not upgraded.
Need to get 405 kB of archives.
After this operation, 1519 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libtirpc-common all 1.2.5-1ubuntu0.1 [7712 B]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libtirpc3 amd64 1.2.5-1ubuntu0.1 [77.9 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 keyutils amd64 1.6-6ubuntu1.1 [44.8 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 405 kB in 1s (524 kB/s)      
Selecting previously unselected package libtirpc-common.
(Reading database ... 72561 files and directories currently installed.)
Preparing to unpack .../0-libtirpc-common_1.2.5-1ubuntu0.1_all.deb ...
Unpacking libtirpc-common (1.2.5-1ubuntu0.1) ...
Selecting previously unselected package libtirpc3:amd64.
Preparing to unpack .../1-libtirpc3_1.2.5-1ubuntu0.1_amd64.deb ...
Unpacking libtirpc3:amd64 (1.2.5-1ubuntu0.1) ...
Selecting previously unselected package rpcbind.
Preparing to unpack .../2-rpcbind_1.2.5-8_amd64.deb ...
Unpacking rpcbind (1.2.5-8) ...
Selecting previously unselected package keyutils.
Preparing to unpack .../3-keyutils_1.6-6ubuntu1.1_amd64.deb ...
Unpacking keyutils (1.6-6ubuntu1.1) ...
Selecting previously unselected package libnfsidmap2:amd64.
Preparing to unpack .../4-libnfsidmap2_0.25-5.1ubuntu1_amd64.deb ...
Unpacking libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Selecting previously unselected package nfs-common.
Preparing to unpack .../5-nfs-common_1%3a1.3.4-2.5ubuntu3.4_amd64.deb ...
Unpacking nfs-common (1:1.3.4-2.5ubuntu3.4) ...
Setting up libtirpc-common (1.2.5-1ubuntu0.1) ...
Setting up keyutils (1.6-6ubuntu1.1) ...
Setting up libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Setting up libtirpc3:amd64 (1.2.5-1ubuntu0.1) ...
Setting up rpcbind (1.2.5-8) ...
Created symlink /etc/systemd/system/multi-user.target.wants/rpcbind.service → /lib/systemd/system/rpcbind.service.
Created symlink /etc/systemd/system/sockets.target.wants/rpcbind.socket → /lib/systemd/system/rpcbind.socket.
Setting up nfs-common (1:1.3.4-2.5ubuntu3.4) ...

Creating config file /etc/idmapd.conf with new version
Adding system user `statd' (UID 114) ...
Adding new user `statd' (UID 114) with group `nogroup' ...
Not creating home directory `/var/lib/nfs'.
Created symlink /etc/systemd/system/multi-user.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
Created symlink /etc/systemd/system/remote-fs.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
nfs-utils.service is a disabled or a static unit, not starting it.
Processing triggers for systemd (245.4-4ubuntu3.13) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libssh2-1 mc-data
Suggested packages:
  arj catdvi | texlive-binaries dbview djvulibre-bin epub-utils genisoimage gv imagemagick libaspell-dev links | w3m | lynx odt2txt poppler-utils python python-boto python-tz xpdf | pdf-viewer zip
The following NEW packages will be installed:
  libssh2-1 mc mc-data
0 upgraded, 3 newly installed, 0 to remove and 166 not upgraded.
Need to get 1817 kB of archives.
After this operation, 7994 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 libssh2-1 amd64 1.8.0-2.1build1 [75.4 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal/universe amd64 mc-data all 3:4.8.24-2ubuntu1 [1265 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/universe amd64 mc amd64 3:4.8.24-2ubuntu1 [477 kB]
Fetched 1817 kB in 1s (1716 kB/s)
Selecting previously unselected package libssh2-1:amd64.
(Reading database ... 72690 files and directories currently installed.)
Preparing to unpack .../libssh2-1_1.8.0-2.1build1_amd64.deb ...
Unpacking libssh2-1:amd64 (1.8.0-2.1build1) ...
Selecting previously unselected package mc-data.
Preparing to unpack .../mc-data_3%3a4.8.24-2ubuntu1_all.deb ...
Unpacking mc-data (3:4.8.24-2ubuntu1) ...
Selecting previously unselected package mc.
Preparing to unpack .../mc_3%3a4.8.24-2ubuntu1_amd64.deb ...
Unpacking mc (3:4.8.24-2ubuntu1) ...
Setting up mc-data (3:4.8.24-2ubuntu1) ...
Setting up libssh2-1:amd64 (1.8.0-2.1build1) ...
Setting up mc (3:4.8.24-2ubuntu1) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for mime-support (3.64ubuntu1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  tree
0 upgraded, 1 newly installed, 0 to remove and 166 not upgraded.
Need to get 43.0 kB of archives.
After this operation, 115 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 tree amd64 1.8.0-1 [43.0 kB]
Fetched 43.0 kB in 0s (103 kB/s)
Selecting previously unselected package tree.
(Reading database ... 73089 files and directories currently installed.)
Preparing to unpack .../tree_1.8.0-1_amd64.deb ...
Unpacking tree (1.8.0-1) ...
Setting up tree (1.8.0-1) ...
Processing triggers for man-db (2.9.1-1) ...
namespace/stage created
namespace/app1 created
namespace/app2 created
Thu Aug 18 16:17:40 UTC 2022
/root/My-Project/stage
Creating fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
  namespace: app1
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: fb-pod
---
# Source: fb-pod-app1/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app1
  namespace: app1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app1/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
NAME: fb-pod-app1
LAST DEPLOYED: Thu Aug 18 16:17:41 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app1 namespace. 
nodePort is port= 30080.
Application name=fb-pod-app1.
Image tag: 05.07.22.
ReplicaCount: 1.

---------------------------------------------------------
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-cch87   0/2     Pending   0          0s
kubectl -n app1 get po
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cd app1
bash: cd: app1: No such file or directory
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
drwxr-xr-x 4 root root 4.0K Aug 18 16:17 fb-pod-app1
drwxr-xr-x 4 root root 4.0K Aug 18 16:17 fb-pod-app2
drwxr-xr-x 4 root root 4.0K Aug 18 16:17 fb-pod-app3
-rw-r--r-- 1 root root    0 Aug 18 16:17 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 stage-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 stage-pvc.yaml
controlplane $ 
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 .
drwx------ 9 root root 4.0K Aug 18 16:19 ..
drwxr-xr-x 2 root root 4.0K Aug 18 16:17 app1
drwxr-xr-x 2 root root 4.0K Aug 18 16:17 app2
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 stage
controlplane $ 
controlplane $ cd app1
controlplane $ 
controlplane $ ls -lha
total 8.0K
drwxr-xr-x 2 root root 4.0K Aug 18 16:17 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
controlplane $ 
controlplane $ vi fb-pod.yaml
controlplane $ 
controlplane $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet

Command 'jsonnetfmt' not found, but can be installed with:

apt install jsonnet

yaml2jsonnet: command not found
controlplane $ 
controlplane $ apt install jsonnet
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  jsonnet
0 upgraded, 1 newly installed, 0 to remove and 166 not upgraded.
Need to get 378 kB of archives.
After this operation, 1964 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 jsonnet amd64 0.15.0+ds-1build1 [378 kB]
Fetched 378 kB in 1s (512 kB/s)  
Selecting previously unselected package jsonnet.
(Reading database ... 73096 files and directories currently installed.)
Preparing to unpack .../jsonnet_0.15.0+ds-1build1_amd64.deb ...
Unpacking jsonnet (0.15.0+ds-1build1) ...
Setting up jsonnet (0.15.0+ds-1build1) ...
controlplane $ 
controlplane $ 
controlplane $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet
yaml2jsonnet: command not found
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ vi fb-pod.yaml
controlplane $ 
controlplane $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet
yaml2jsonnet: command not found
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ apt install jsonnet
Reading package lists... Done
Building dependency tree       
Reading state information... Done
jsonnet is already the newest version (0.15.0+ds-1build1).
0 upgraded, 0 newly installed, 0 to remove and 166 not upgraded.
controlplane $ 
controlplane $ apt install python3-pip -y
Reading package lists... Done
Building dependency tree       
Reading state information... Done
python3-pip is already the newest version (20.0.2-5ubuntu1.6).
0 upgraded, 0 newly installed, 0 to remove and 166 not upgraded.
controlplane $ 
controlplane $ pip install yaml2jsonnet
Collecting yaml2jsonnet
  Downloading yaml2jsonnet-1.0.1-py3-none-any.whl (19 kB)
Collecting ruamel.yaml<0.17.0,>=0.16.10
  Downloading ruamel.yaml-0.16.13-py2.py3-none-any.whl (111 kB)
     |████████████████████████████████| 111 kB 10.4 MB/s 
Collecting ruamel.yaml.clib>=0.1.2; platform_python_implementation == "CPython" and python_version < "3.10"
  Downloading ruamel.yaml.clib-0.2.6-cp38-cp38-manylinux1_x86_64.whl (570 kB)
     |████████████████████████████████| 570 kB 59.3 MB/s 
Installing collected packages: ruamel.yaml.clib, ruamel.yaml, yaml2jsonnet
Successfully installed ruamel.yaml-0.16.13 ruamel.yaml.clib-0.2.6 yaml2jsonnet-1.0.1
controlplane $ 
controlplane $ 
controlplane $ yaml2jsonnet fb-pod.yaml | jsonnetfmt - -o fb-pod.jsonnet
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod.jsonnet
{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
    labels: {
      app: 'fb',
    },
  },
  spec: {
    type: 'NodePort',
    ports: [
      {
        port: 80,
        nodePort: '{{ .Values.nodePort }}',
      },
    ],
    selector: {
      app: 'fb-pod',
    },
  },
}
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod.yaml   
---
{
  "apiVersion": "v1",
  "kind": "Service",
  "metadata": {
    "name": "{{ .Values.name }}",
    "namespace": "{{ .Values.namespace }}",
    "labels": {
      "app": "fb"
    }
  },
  "spec": {
    "type": "NodePort",
    "ports": [
      {
        "port": 80,
        "nodePort": "{{ .Values.nodePort }}"
      }
    ],
    "selector": {
      "app": "fb-pod"
    }
  }
}

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ rm fb-pod.yaml 
controlplane $ 
controlplane $ jsonnet fb-pod.jsonnet > fb-pod.yaml
controlplane $ 
controlplane $ cat fb-pod.yaml
{
   "apiVersion": "v1",
   "kind": "Service",
   "metadata": {
      "labels": {
         "app": "fb"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "ports": [
         {
            "nodePort": "{{ .Values.nodePort }}",
            "port": 80
         }
      ],
      "selector": {
         "app": "fb-pod"
      },
      "type": "NodePort"
   }
}
controlplane $ 
controlplane $ vi deployment.json
controlplane $ 
controlplane $ 
controlplane $ cat deployment.json 
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "fb-app"
    },
    "name": "{{ .Values.name }}",
    "namespace": "{{ .Values.namespace }}"
  },
  "spec": {
    "replicas": "{{ .Values.replicaCount }}",
    "selector": {
      "matchLabels": {
        "app": "fb-app"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "fb-app"
        }
      },
      "spec": {
        "containers": [
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "frontend",
            "ports": [
              {
                "containerPort": 80
              }
            ],
            "volumeMounts": [
              {
                "mountPath": "/static",
                "name": "my-volume"
              }
            ]
          },
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "backend",
            "volumeMounts": [
              {
                "mountPath": "/tmp/cache",
                "name": "my-volume"
              }
            ]
          }
        ],
        "volumes": [
          {
            "name": "my-volume",
            "emptyDir": {
            }
          }
        ]
      }
    }
  }
}
controlplane $ 
controlplane $ 
controlplane $                                                              
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Aug 18 16:37 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
-rw-r--r-- 1 root root 1.5K Aug 18 16:37 deployment.json
-rw-r--r-- 1 root root  354 Aug 18 16:29 fb-pod.jsonnet
-rw-r--r-- 1 root root  419 Aug 18 16:36 fb-pod.yaml
controlplane $ 
controlplane $ vi deployment.yaml
controlplane $ 
controlplane $ cat deployment.yaml 
--
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: "{{ .Values.name }}"
  namespace: "{{ .Values.namespace }}"
spec:
  replicas: "{{ .Values.replicaCount }}"
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}"  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}"
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
controlplane $ 
controlplane $ 
controlplane $ yaml2jsonnet deployment.yaml | jsonnetfmt - -o deployment.jsonnet
Traceback (most recent call last):
  File "/usr/local/bin/yaml2jsonnet", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 58, in main
    run(args)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/cli.py", line 47, in run
    convert_yaml(yaml_data, args.out, args.document_comments)
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/yaml2jsonnet.py", line 14, in convert_yaml
    JsonnetRenderer(events, output, array, inject_comments).render()
  File "/usr/local/lib/python3.8/dist-packages/yaml2jsonnet/jsonnet_renderer.py", line 203, in render
    for event in self.events:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 676, in parse
    while parser.check_event():
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/parser.py", line 140, in check_event
    self.current_event = self.state()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/parser.py", line 176, in parse_stream_start
    token.move_comment(self.scanner.peek_token())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/scanner.py", line 1778, in peek_token
    self._gather_comments()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/scanner.py", line 1806, in _gather_comments
    self.fetch_more_tokens()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/scanner.py", line 283, in fetch_more_tokens
    return self.fetch_value()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/scanner.py", line 652, in fetch_value
    raise ScannerError(
ruamel.yaml.scanner.ScannerError: mapping values are not allowed here
  in "<unicode string>", line 2, column 11:
    apiVersion: apps/v1
              ^ (line: 2)
STATIC ERROR: <stdin>:1:1: unexpected end of file.
controlplane $ 
controlplane $ cat deployment.json 
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "fb-app"
    },
    "name": "{{ .Values.name }}",
    "namespace": "{{ .Values.namespace }}"
  },
  "spec": {
    "replicas": "{{ .Values.replicaCount }}",
    "selector": {
      "matchLabels": {
        "app": "fb-app"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "fb-app"
        }
      },
      "spec": {
        "containers": [
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "frontend",
            "ports": [
              {
                "containerPort": 80
              }
            ],
            "volumeMounts": [
              {
                "mountPath": "/static",
                "name": "my-volume"
              }
            ]
          },
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "backend",
            "volumeMounts": [
              {
                "mountPath": "/tmp/cache",
                "name": "my-volume"
              }
            ]
          }
        ],
        "volumes": [
          {
            "name": "my-volume",
            "emptyDir": {
            }
          }
        ]
      }
    }
  }
}
controlplane $ 
controlplane $ 
controlplane $ yaml2jsonnet deployment.json | jsonnetfmt - -o deployment.jsonnet
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 2 root root 4.0K Aug 18 16:41 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
-rw-r--r-- 1 root root 1.5K Aug 18 16:37 deployment.json
-rw-r--r-- 1 root root 1.4K Aug 18 16:41 deployment.jsonnet
-rw-r--r-- 1 root root  958 Aug 18 16:39 deployment.yaml
-rw-r--r-- 1 root root  354 Aug 18 16:29 fb-pod.jsonnet
-rw-r--r-- 1 root root  419 Aug 18 16:36 fb-pod.yaml
controlplane $ 
controlplane $ cat deployment.jsonnet 
{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    labels: {
      app: 'fb-app',
    },
    name: '{{ .Values.name }}',
    namespace: '{{ .Values.namespace }}',
  },
  spec: {
    replicas: '{{ .Values.replicaCount }}',
    selector: {
      matchLabels: {
        app: 'fb-app',
      },
    },
    template: {
      metadata: {
        labels: {
          app: 'fb-app',
        },
      },
      spec: {
        containers: [
          {
            image: '{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'frontend',
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
              {
                mountPath: '/static',
                name: 'my-volume',
              },
            ],
          },
          {
            image: '{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}',
            imagePullPolicy: 'IfNotPresent',
            name: 'backend',
            volumeMounts: [
              {
                mountPath: '/tmp/cache',
                name: 'my-volume',
              },
            ],
          },
        ],
        volumes: [
          {
            name: 'my-volume',
            emptyDir: {
            },
          },
        ],
      },
    },
  },
}
controlplane $ 
controlplane $ cat deployment.json    
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "fb-app"
    },
    "name": "{{ .Values.name }}",
    "namespace": "{{ .Values.namespace }}"
  },
  "spec": {
    "replicas": "{{ .Values.replicaCount }}",
    "selector": {
      "matchLabels": {
        "app": "fb-app"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "fb-app"
        }
      },
      "spec": {
        "containers": [
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "frontend",
            "ports": [
              {
                "containerPort": 80
              }
            ],
            "volumeMounts": [
              {
                "mountPath": "/static",
                "name": "my-volume"
              }
            ]
          },
          {
            "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
            "imagePullPolicy": "IfNotPresent",
            "name": "backend",
            "volumeMounts": [
              {
                "mountPath": "/tmp/cache",
                "name": "my-volume"
              }
            ]
          }
        ],
        "volumes": [
          {
            "name": "my-volume",
            "emptyDir": {
            }
          }
        ]
      }
    }
  }
}
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ mv deployment.yaml deployment.txt
controlplane $ 
controlplane $ jsonnet deployment.jsonnet > deployment.yaml
controlplane $ 
controlplane $ cat deployment.yaml 
{
   "apiVersion": "apps/v1",
   "kind": "Deployment",
   "metadata": {
      "labels": {
         "app": "fb-app"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "replicas": "{{ .Values.replicaCount }}",
      "selector": {
         "matchLabels": {
            "app": "fb-app"
         }
      },
      "template": {
         "metadata": {
            "labels": {
               "app": "fb-app"
            }
         },
         "spec": {
            "containers": [
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "frontend",
                  "ports": [
                     {
                        "containerPort": 80
                     }
                  ],
                  "volumeMounts": [
                     {
                        "mountPath": "/static",
                        "name": "my-volume"
                     }
                  ]
               },
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "backend",
                  "volumeMounts": [
                     {
                        "mountPath": "/tmp/cache",
                        "name": "my-volume"
                     }
                  ]
               }
            ],
            "volumes": [
               {
                  "emptyDir": { },
                  "name": "my-volume"
               }
            ]
         }
      }
   }
}
controlplane $ 
controlplane $ 
controlplane $ jsonnet --help
Jsonnet commandline interpreter v0.15.0

jsonnet {<option>} <filename>

Available options:
  -h / --help             This message
  -e / --exec             Treat filename as code
  -J / --jpath <dir>      Specify an additional library search dir (right-most wins)
  -o / --output-file <file> Write to the output file rather than stdout
  -m / --multi <dir>      Write multiple files to the directory, list files on stdout
  -y / --yaml-stream      Write output as a YAML stream of JSON documents
  -S / --string           Expect a string, manifest as plain text
  -s / --max-stack <n>    Number of allowed stack frames
  -t / --max-trace <n>    Max length of stack trace before cropping
  --gc-min-objects <n>    Do not run garbage collector until this many
  --gc-growth-trigger <n> Run garbage collector after this amount of object growth
  --version               Print version
Available options for specifying values of 'external' variables:
Provide the value as a string:
  -V / --ext-str <var>[=<val>]     If <val> is omitted, get from environment var <var>
       --ext-str-file <var>=<file> Read the string from the file
Provide a value as Jsonnet code:
  --ext-code <var>[=<code>]    If <code> is omitted, get from environment var <var>
  --ext-code-file <var>=<file> Read the code from the file
Available options for specifying values of 'top-level arguments':
Provide the value as a string:
  -A / --tla-str <var>[=<val>]     If <val> is omitted, get from environment var <var>
       --tla-str-file <var>=<file> Read the string from the file
Provide a value as Jsonnet code:
  --tla-code <var>[=<code>]    If <code> is omitted, get from environment var <var>
  --tla-code-file <var>=<file> Read the code from the file
Environment variables:
JSONNET_PATH is a colon (semicolon on Windows) separated list of directories added
in reverse order before the paths specified by --jpath (i.e. left-most wins)
E.g. JSONNET_PATH=a:b jsonnet -J c -J d is equivalent to:
JSONNET_PATH=d:c:a:b jsonnet
jsonnet -J b -J a -J c -J d

In all cases:
<filename> can be - (stdin)
Multichar options are expanded e.g. -abc becomes -a -b -c.
The -- option suppresses option processing for subsequent arguments.
Note that since filenames and jsonnet programs can begin with -, it is advised to
use -- if the argument is unknown, e.g. jsonnet -- "$FILENAME".
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ mv deployment.yaml deployment-2.txt
controlplane $ 
controlplane $ jsonnet deployment.jsonnet -y deployment.yaml
ERROR: only one filename is allowed

controlplane $ 
controlplane $                                              
controlplane $ ll -lha
total 32K
drwxr-xr-x 2 root root 4.0K Aug 18 16:47 ./
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ../
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
-rw-r--r-- 1 root root 1.7K Aug 18 16:44 deployment-2.txt
-rw-r--r-- 1 root root 1.5K Aug 18 16:37 deployment.json
-rw-r--r-- 1 root root 1.4K Aug 18 16:41 deployment.jsonnet
-rw-r--r-- 1 root root  958 Aug 18 16:39 deployment.txt
-rw-r--r-- 1 root root  354 Aug 18 16:29 fb-pod.jsonnet
-rw-r--r-- 1 root root  419 Aug 18 16:36 fb-pod.yaml
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 32K
drwxr-xr-x 2 root root 4.0K Aug 18 16:47 .
drwxr-xr-x 5 root root 4.0K Aug 18 16:17 ..
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pv.yaml
-rw-r--r-- 1 root root    0 Aug 18 16:17 app1-pvc.yaml
-rw-r--r-- 1 root root 1.7K Aug 18 16:44 deployment-2.txt
-rw-r--r-- 1 root root 1.5K Aug 18 16:37 deployment.json
-rw-r--r-- 1 root root 1.4K Aug 18 16:41 deployment.jsonnet
-rw-r--r-- 1 root root  958 Aug 18 16:39 deployment.txt
-rw-r--r-- 1 root root  354 Aug 18 16:29 fb-pod.jsonnet
-rw-r--r-- 1 root root  419 Aug 18 16:36 fb-pod.yaml
controlplane $ 
controlplane $ 
controlplane $ jsonnet -y deployment.jsonnet                   
RUNTIME ERROR: stream mode: top-level object was a object, should be an array whose elements hold the JSON for each document in the stream.
        During manifestation
controlplane $ 
controlplane $ jsonnet -y deployment.json   
RUNTIME ERROR: stream mode: top-level object was a object, should be an array whose elements hold the JSON for each document in the stream.
        During manifestation
controlplane $ 
controlplane $ ^C
controlplane $ jsonnet -y deployment.json
RUNTIME ERROR: stream mode: top-level object was a object, should be an array whose elements hold the JSON for each document in the stream.
        During manifestation
controlplane $ 
controlplane $ jsonnet -y deployment.jsonnet
---
{
   "apiVersion": "apps/v1",
   "kind": "Deployment",
   "metadata": {
      "labels": {
         "app": "fb-app"
      },
      "name": "{{ .Values.name }}",
      "namespace": "{{ .Values.namespace }}"
   },
   "spec": {
      "replicas": "{{ .Values.replicaCount }}",
      "selector": {
         "matchLabels": {
            "app": "fb-app"
         }
      },
      "template": {
         "metadata": {
            "labels": {
               "app": "fb-app"
            }
         },
         "spec": {
            "containers": [
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "frontend",
                  "ports": [
                     {
                        "containerPort": 80
                     }
                  ],
                  "volumeMounts": [
                     {
                        "mountPath": "/static",
                        "name": "my-volume"
                     }
                  ]
               },
               {
                  "image": "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}",
                  "imagePullPolicy": "IfNotPresent",
                  "name": "backend",
                  "volumeMounts": [
                     {
                        "mountPath": "/tmp/cache",
                        "name": "my-volume"
                     }
                  ]
               }
            ],
            "volumes": [
               {
                  "emptyDir": { },
                  "name": "my-volume"
               }
            ]
         }
      }
   }
}
...
controlplane $ 
controlplane $ 

```
