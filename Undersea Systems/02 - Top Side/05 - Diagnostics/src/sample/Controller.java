package sample;

import com.jfoenix.controls.JFXButton;
import com.jfoenix.controls.JFXRadioButton;
import com.jfoenix.controls.JFXTextField;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.eclipse.paho.client.mqttv3.IMqttClient;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;



public class Controller implements Initializable {

    //declare all controllers
    public JFXTextField mqttIP;
    public JFXTextField mqttPort;
    public JFXTextField mqttID;
    public Label brokerStatus;
    public JFXButton mqttConnectButton;
    public JFXButton mqttDisconnectButton;
    public boolean brokerStatusFlag = false;
    MqttClient client = null;

    //things to do on load start
    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }


    public void mqttConnectBroker() {

         //setup the broker addresses here
         String IPAddress = mqttIP.getText();
         String Port = mqttPort.getText();
         String BrokerID = mqttID.getText();
         String broker = "tcp://" + IPAddress + ":" + Port;
         MemoryPersistence persistence = new MemoryPersistence();

         try {
             //setup connection parameters
             client = new MqttClient(broker,BrokerID, persistence);

             //MQTT Connect Options
             MqttConnectOptions connOpts = new MqttConnectOptions();
             connOpts.setCleanSession(true);
             //TODO: Add the last will and testatment with connOpts.setWill(...)

             //connect to the broker
             System.out.println("Connecting to broker: " + broker);
             client.connect(connOpts);
             brokerStatusFlag = true;
             System.out.println("Connected");
         }
         catch (MqttException me) {
             System.out.println("reason " + me.getReasonCode());
             System.out.println("msg " + me.getMessage());
             System.out.println("loc " + me.getLocalizedMessage());
             System.out.println("cause " + me.getCause());
             System.out.println("excep " + me);
             me.printStackTrace();
         }

        //update the status of everything
        updateMqttStatus();

     }



    //disconnect from the broker
    public void mqttDisconnectBroker(){
        System.out.println("Button Pressed");
        try {
            System.out.println("Disconnecting...");
            client.disconnect();
            System.out.println("Disconnected");
            brokerStatus.setText("Connected");
        } catch (MqttException e) {
            e.printStackTrace();
        }

        //update the status of everything
        updateMqttStatus();
    }

    //launch the broker
    public void launchBroker(){
        try {
            Runtime.getRuntime().exec("cmd /c start \"\" C:/users/Braden/Desktop/Mosquitto_Verbose.bat");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public void updateMqttStatus(){
        //set the text stat
        boolean clientStatus = client.isConnected();
        if (clientStatus){
            brokerStatus.setText("Connected");
        }else{
            brokerStatus.setText("Disconnected");
        }


    }

}
