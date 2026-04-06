public class IntegrationQueueable implements Queueable, Database.AllowsCallouts {

    public void execute(QueueableContext context) {
        try {
            BuscarContasService.buscarContas();
            BuscarUsuariosService.buscarUsuarios();
        } catch (Exception e) {
            System.debug('Erro no Queueable: ' + e.getMessage());
        }
    }
}