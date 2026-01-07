namespace Talknado.Server;

class Program
{
    static int Main(string[] args)
    {
        var password = string.Empty;
        if (args.Length == 1)
        {
            password = args[0];

        }

        using var serverHost = new ServerHost();

        var connectionKey = serverHost.StartServer(password);
        if (connectionKey != null)
        {
            Console.WriteLine(connectionKey);
        }
        else
        {
            return 1;
        }

        Thread.Sleep(Timeout.Infinite);

        return 0;
    }
}