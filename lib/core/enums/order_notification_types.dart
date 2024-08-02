enum OrderSocketNotificationType {
  newOrderAlert("NewOrderAlert"),
  notify("Notify"),
  customerPickup("CustomerPickup"),
  cancelOrder("CancelOrder"),
  reOrder("ReOrder"),
  pickupByBiker("PickupByBiker"),
  returnByBiker("ReturnByBiker"),
  returnOrder("ReturnOrder"),
  punishItem("PunishItem"),
  receivedTestMessage("OnReceivedTestMessage"),
  quickPay("QuickPay"),
  shopConfirm("ShopConfirm");

  const OrderSocketNotificationType(this.type);
  final String type;
}
