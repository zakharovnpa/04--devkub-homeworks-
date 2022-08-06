{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    labels: {
      app: 'fb-app',
    },
    name: 'fb-pod',
    namespace: 'stage',
  },
  spec: {
    replicas: 1,
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
            image: 'zakharovnpa/k8s-frontend:05.07.22',
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
            image: 'zakharovnpa/k8s-backend:05.07.22',
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
