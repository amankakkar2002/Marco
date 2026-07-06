/// <summary>
/// AK QR Merging 07072026
///     <code>New Object Created </code>
/// </summary>
codeunit 50110 "QR Buffer Mgt."
{
    SingleInstance = true;

    var
        TempSwissQRBillBuffer: Record "Swiss QR-Bill Buffer" temporary;

    procedure AddBuffer(var Buffer: Record "Swiss QR-Bill Buffer" temporary)
    begin
        TempSwissQRBillBuffer.AddBufferRecord(Buffer);
    end;

    procedure GetBuffer(var Buffer: Record "Swiss QR-Bill Buffer" temporary)
    begin
        if TempSwissQRBillBuffer.FindSet() then
            repeat
                Buffer.AddBufferRecord(TempSwissQRBillBuffer);
            until TempSwissQRBillBuffer.Next() = 0;
    end;

    procedure ClearBuffer()
    begin
        TempSwissQRBillBuffer.DeleteAll();
    end;
}