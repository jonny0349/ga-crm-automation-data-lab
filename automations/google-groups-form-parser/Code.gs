function appendFromPasteToData(){
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const paste = ss.getSheetByName("PASTE");
  const data = ss.getSheetByName("DATA");

  if (!paste) throw new Error('Tab "PASTE" not found. Rename your tab to PASTE.');
  if (!data) throw new Error('Tab "DATA" not found. Rename your tabe to DATA');

  // Read just the pasted area (A2:B) down to last row with content
  const lastRow = paste.getLastRow();
  if(lastRow < 2) throw new Error('Nothing found in PASTE sheet. Paste the form starting at A2.');

  const block = paste.getRange(2,1, lastRow - 1, 2).getValues(); // A2:B(lastRow)

  // Helper: normalize label text from column A
  const norm = (s) => 
    String(s || "")
    .toLowerCase()
    .replace(/[*:]/g, "") //Remove * and : 
    .replace(/\s+/g," ") //Collapse spaces
    .trim();
  
  //Extract fields by scanning lable/value rows
  let name = "", email = "", phone = "", address = "", program = "", start = "", message = "";

  block.forEach(([label, value]) => {
    const k = norm(label);
    const v = String(value || "").trim();

    if(!k) return;

    if (k === "name") name = v;
    else if (k === "email") email = v;
    else if (k === "phone") phone = v;
    else if (k === "address") address = v;
    else if (k.includes("program") && k.includes("interest")) program = v;
    else if (k.includes("intend to start classes")) start = v;
    else if (k === "message") message = v;
  });

  // Append to DATA (Timestamp + fields)
  data.appendRow([new Date(), name, email, phone, address, program, start, message]);

  // Clear staging area for next paste
  paste.getRange(2, 1, lastRow -1, 2).clearContent();
}
