import '../../data/models/alert/alert_model.dart';
import '../../data/models/network/client_connection/client_connection.dart';
import '../byte_buffer/byte_buffer.dart';

class DataSender {
  // final TempMemory _tempMemory = TempMemory();

  void sendDataTo({required ClientConnectionModel client, required List<int> data}) {
    try {
      final ByteBuffer buffer = ByteBuffer();

      buffer.writeInteger(value: data.length);
      buffer.writeBytes(values: data);

      client.socket.add(buffer.getArray());
    } catch (e) {
      print('Erro ao enviar dados para o cliente ${client.id}: $e');
    }
  }

  void sendAlertMsg({required ClientConnectionModel client, required AlertModel alert}) {
    final ByteBuffer buffer = ByteBuffer();

    buffer.writeInteger(value: 1);

    buffer.writeString(value: alert.message);

    sendDataTo(client: client, data: buffer.getArray());

    buffer.flush();
  }
}

// Public Sub SendAlertMsg(ByVal index As Long, ByVal Msg As String)
// Dim Buffer As clsBuffer

//     If Not App.LogMode = 0 Then On Error GoTo errHandler
    
//     Set Buffer = New clsBuffer
//     Buffer.WriteLong SAlertMsg
//     Buffer.WriteString Msg
//     SendDataTo index, Buffer.ToArray()
//     DoEvents
//     CloseSocket index
//     Set Buffer = Nothing
    
//     Exit Sub
// errHandler:
//     HandleError "SendAlertMsg", "modTCP", Err.Number, Err.Description
//     Err.Clear
//     Exit Sub
// End Sub