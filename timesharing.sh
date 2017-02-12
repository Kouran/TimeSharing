#Script per l'avvio dell'applicazione TimeSharing
rake db:setup
curl -F "url=https://timesharing.pagekite.me/webhook" https://api.telegram.org/bot371175469:AAFZjsjbupLsvM4o7I0VPAADRd5cM_6-Y70/setWebhook
rails s -p 8443
