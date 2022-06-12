# Defined in - @ line 1
function udemymicroservices --wraps='kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission' --description 'alias udemymicroservices kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission'
  kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission $argv;
end
