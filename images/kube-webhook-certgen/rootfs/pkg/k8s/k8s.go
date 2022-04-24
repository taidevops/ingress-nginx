package k8s

import (
	"context"
	"fmt"

	log "github.com/sirupsen/logrus"
	admissionv1 "k8s.io/api/admissionregistration/v1"
	v1 "k8s.io/api/core/v1"
	k8serrors "k8s.io/apimachinery/pkg/api/errors"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/kube-aggregator/pkg/client/clientset_generated/clientset"
)

type k8s struct {
	clientset           kubernetes.Interface
	aggregatorClientset clientset.Interface
}

func New(clientset kubernetes.Interface, aggregatorClientset clientset.Interface) *k8s {
	if clientset == nil {
		log.Fatal("no kubernetes client given")
	}

	if aggregatorClientset == nil {
		log.Fatal("no kubernetes aggregator client given")
	}

	return &k8s{
		clientset:           clientset,
		aggregatorClientset: aggregatorClientset,
	}
}

type PathOptions struct {
	
}