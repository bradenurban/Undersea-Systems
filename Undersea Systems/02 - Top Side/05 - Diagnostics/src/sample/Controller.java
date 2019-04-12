package sample;

import com.jfoenix.controls.JFXButton;
import com.jfoenix.controls.JFXTextField;
import javafx.beans.property.ReadOnlyStringWrapper;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TreeItem;
import javafx.scene.control.TreeTableColumn;
import javafx.scene.control.TreeTableView;
import javafx.util.Callback;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import sun.reflect.generics.tree.Tree;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;



public class Controller<mqttValue> implements Initializable {

    //declare all controllers
    public JFXTextField mqttIP;
    public JFXTextField mqttPort;
    public JFXTextField mqttID;
    public Label brokerStatus;
    public JFXButton mqttConnectButton;
    public JFXButton mqttDisconnectButton;

    MqttClient client = null;

    public TreeTableView  <mqttMessages>        mqttTableView;
    public TreeTableColumn<mqttMessages,String> mqttTopicCol ;
    public TreeTableColumn<mqttMessages,String> mattValueCol ;

    TreeItem<mqttMessages> item1 = new TreeItem<>(new mqttMessages("Test Value","1234"));
    TreeItem<mqttMessages> parent1 = new TreeItem<>(new mqttMessages("Diagnostics",""));
    TreeItem<mqttMessages> root = new TreeItem<>(new mqttMessages("Undersea Systems",""));





    //things to do on load start
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        parent1.getChildren().setAll(item1);
        root.getChildren().setAll(parent1);

        mqttTopicCol.setCellValueFactory(param -> param.getValue().getValue().getTopicProperty());
        mattValueCol.setCellValueFactory(param -> param.getValue().getValue().getValueProperty());

        mqttTableView.setRoot(root);



    }

    class mqttMessages{
        SimpleStringProperty topicProperty;
        SimpleStringProperty valueProperty;

        public mqttMessages(String mqttTopic,String mqttValue){
            this.topicProperty = new SimpleStringProperty(mqttTopic);
            this.valueProperty = new SimpleStringProperty(mqttValue);
        }

        public SimpleStringProperty getTopicProperty(){
            return topicProperty;
        }
        public SimpleStringProperty getValueProperty(){
            return valueProperty;
        }

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
