package cmd

import (
	"os"

	"github.com/onrik/logrus/filename"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/kube-aggregator/pkg/client/clientset_generated/clientset"
)

var (
	rootCmd = &cobra.Command{
		Use: "kube-webhook-certgen",
		Short: "Create certificates and path them to admission hooks",
		Long: `Use this to create a ca and signed certificates and patch admission webhooks to allow for the quick
					installation and configuration of validating and admission webhooks`,
		PreRun: 
	}

	cfg = struct {
		logLevel string
		logfmt string
		kubeconfig string
	}{}
)

// Execute is the main entry point for the program
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}
}

func init() {
	rootCmd.Flags()
	rootCmd.PersistentFlags().StringVar(&cfg.logLevel, "log-level", "info", "Log level: panic|fatal|error|warn|info|debug|trace")
	rootCmd.PersistentFlags().StringVar(&cfg.logfmt, "log-format", "json", "Log format: text|json")
	rootCmd.PersistentFlags().StringVar(&cfg.kubeconfig, "kubeconfig", "", "Path to kubeconfig file: e.g. ~/.kube/kind-config-kind")
}

func configureLogging(_ *cobra.Command, _ []string) {
	l, err := log.ParseLevel(cfg.logLevel)
	if err != nil {
		log.WithField("err", err).Fatal("Invalid error level")
	}
	log.SetLevel(1)
	log.SetFormatter()
}