Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56E868F323
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Feb 2023 17:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBHQZc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Feb 2023 11:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHQZb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Feb 2023 11:25:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFEBDBF8
        for <linux-rdma@vger.kernel.org>; Wed,  8 Feb 2023 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675873529; x=1707409529;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ikokXB9NI3SgbLeE2gqJemSv6gr4vkWn0zh0/xztms=;
  b=M64kDRDGpLXfQzgEeJSzC3KqNAnAZfIF12s650uu6HMUnW+uXZrXS2AB
   HYAflYiOBllrxeQUTYQqJ6+Le3JL3PN1L/eW7SfGAAJ26QMNTeAzHVOjR
   glAIMTho5oZBEwttcwQGTybbsqoFfTYH4Zn+ZXsR/Oo/C1SZv+89RME8R
   5t6XJGbQu7Orml08HndRCneRgbaH2woLvssU2i9AOpBl4QLppDUc7JmVL
   mCAE8mca+5fSMty9n7ZPn1YWVf2kDlLbk9eK9UNMMKhl4i264G0SQUp1T
   tI1TuALNZmQ14RQhJ9toqp1Amhgv7ecVZBiwxsNja9YwEVWR8mFRvuHgj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329872024"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329872024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 08:25:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="810007639"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="810007639"
Received: from romeroma-mobl.amr.corp.intel.com (HELO sindhude-MOBL.amr.corp.intel.com) ([10.255.39.67])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 08:25:28 -0800
From:   Sindhu Devale <sindhu.devale@intel.com>
To:     jgg@nvidia.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        shiraz.saleem@intel.com, mustafa.ismail@intel.com,
        Sindhu Devale <sindhu.devale@intel.com>
Subject: [PATCH for-rc] RDMA/irdma: Fix for RoCEv2 traffic after IP deleted
Date:   Wed,  8 Feb 2023 10:25:07 -0600
Message-Id: <20230208162507.1381-1-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Currently, traffic on a RoCEv2 RC QP can continue after the IP address is deleted from the interface.
Fix this by finding QP's that use the deleted IP and modify to the error state.

Fixes: cc0315564d6e("RDMA/irdma: Fix sleep from invalid context BUG")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c    | 113 +++++++++++++++++++++++++---
 drivers/infiniband/hw/irdma/cm.h    |   6 +-
 drivers/infiniband/hw/irdma/utils.c |  27 ++++++-
 drivers/infiniband/hw/irdma/verbs.h |   9 +++
 4 files changed, 135 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 7b086fe63a24..1db4c6f996b9 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -4037,18 +4037,19 @@ int irdma_destroy_listen(struct iw_cm_id *cm_id)
 }
 
 /**
- * irdma_teardown_list_prep - add conn nodes slated for tear down to list
+ * irdma_iw_teardown_list_prep - add conn nodes slated for tear
+ * down to list
  * @cm_core: cm's core
  * @teardown_list: a list to which cm_node will be selected
  * @ipaddr: pointer to ip address
  * @nfo: pointer to cm_info structure instance
  * @disconnect_all: flag indicating disconnect all QPs
  */
-static void irdma_teardown_list_prep(struct irdma_cm_core *cm_core,
-				     struct list_head *teardown_list,
-				     u32 *ipaddr,
-				     struct irdma_cm_info *nfo,
-				     bool disconnect_all)
+static void irdma_iw_teardown_list_prep(struct irdma_cm_core *cm_core,
+					struct list_head *teardown_list,
+					u32 *ipaddr,
+					struct irdma_cm_info *nfo,
+					bool disconnect_all)
 {
 	struct irdma_cm_node *cm_node;
 	int bkt;
@@ -4062,6 +4063,73 @@ static void irdma_teardown_list_prep(struct irdma_cm_core *cm_core,
 	}
 }
 
+static inline bool irdma_ip_vlan_match(u32 *ip1, u16 vlan_id1,
+				       bool check_vlan, u32 *ip2,
+				       u16 vlan_id2, bool ipv4)
+{
+	return (!check_vlan || vlan_id1 == vlan_id2) &&
+		!memcmp(ip1, ip2, ipv4 ? 4 : 16);
+}
+
+/**
+ * irdma_roce_teardown_list_prep - add conn nodes slated for
+ * tear down to list
+ * @iwdev: RDMA device
+ * @teardown_list: a list to which cm_node will be selected
+ * @ipaddr: pointer to ip address
+ * @nfo: pointer to cm_info structure instance
+ * @disconnect_all: flag indicating disconnect all QPs
+ */
+static void irdma_roce_teardown_list_prep(struct irdma_device *iwdev,
+					  struct list_head *teardown_list,
+					  u32 *ipaddr,
+					  struct irdma_cm_info *nfo,
+					  bool disconnect_all)
+{
+	struct irdma_sc_vsi *vsi = &iwdev->vsi;
+	struct irdma_sc_qp *sc_qp;
+	struct list_head *list_node;
+	struct irdma_qp *qp;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < IRDMA_MAX_USER_PRIORITY; i++) {
+		mutex_lock(&vsi->qos[i].qos_mutex);
+		list_for_each (list_node, &vsi->qos[i].qplist) {
+			u32 qp_ip[4];
+
+			sc_qp = container_of(list_node, struct irdma_sc_qp,
+					     list);
+			if (sc_qp->qp_uk.qp_type != IRDMA_QP_TYPE_ROCE_RC)
+				continue;
+
+			qp = sc_qp->qp_uk.back_qp;
+			if (!disconnect_all) {
+				if (nfo->ipv4)
+					qp_ip[0] = qp->udp_info.local_ipaddr[3];
+				else
+					memcpy(qp_ip,
+					       &qp->udp_info.local_ipaddr[0],
+					       sizeof(qp_ip));
+			}
+
+			if (disconnect_all ||
+			    irdma_ip_vlan_match(qp_ip,
+						qp->udp_info.vlan_tag & VLAN_VID_MASK,
+						qp->udp_info.insert_vlan_tag,
+						ipaddr, nfo->vlan_id, nfo->ipv4)) {
+				spin_lock_irqsave(&iwdev->rf->qptable_lock, flags);
+				if (iwdev->rf->qp_table[sc_qp->qp_uk.qp_id]) {
+					irdma_qp_add_ref(&qp->ibqp);
+					list_add(&qp->teardown_entry, teardown_list);
+				}
+				spin_unlock_irqrestore(&iwdev->rf->qptable_lock, flags);
+			}
+		}
+		mutex_unlock(&vsi->qos[i].qos_mutex);
+	}
+}
+
 /**
  * irdma_cm_event_connected - handle connected active node
  * @event: the info for cm_node of connection
@@ -4232,22 +4300,36 @@ void irdma_cm_teardown_connections(struct irdma_device *iwdev, u32 *ipaddr,
 	struct irdma_cm_node *cm_node;
 	struct list_head teardown_list;
 	struct ib_qp_attr attr;
+	struct irdma_qp *qp;
 
 	INIT_LIST_HEAD(&teardown_list);
 
 	rcu_read_lock();
-	irdma_teardown_list_prep(cm_core, &teardown_list, ipaddr, nfo, disconnect_all);
+	irdma_iw_teardown_list_prep(cm_core, &teardown_list, ipaddr, nfo, disconnect_all);
 	rcu_read_unlock();
 
+	attr.qp_state = IB_QPS_ERR;
 	list_for_each_safe (list_node, list_core_temp, &teardown_list) {
 		cm_node = container_of(list_node, struct irdma_cm_node,
 				       teardown_entry);
-		attr.qp_state = IB_QPS_ERR;
 		irdma_modify_qp(&cm_node->iwqp->ibqp, &attr, IB_QP_STATE, NULL);
 		if (iwdev->rf->reset)
 			irdma_cm_disconn(cm_node->iwqp);
 		irdma_rem_ref_cm_node(cm_node);
 	}
+
+	if (!iwdev->roce_mode)
+		return;
+
+	INIT_LIST_HEAD(&teardown_list);
+	irdma_roce_teardown_list_prep(iwdev, &teardown_list, ipaddr, nfo, disconnect_all);
+
+	list_for_each_safe (list_node, list_core_temp, &teardown_list) {
+		qp = container_of(list_node, struct irdma_qp, teardown_entry);
+		irdma_modify_qp_roce(&qp->ibqp, &attr, IB_QP_STATE, NULL);
+		irdma_ib_qp_event(qp, IRDMA_QP_EVENT_CATASTROPHIC);
+		irdma_qp_rem_ref(&qp->ibqp);
+	}
 }
 
 /**
@@ -4316,12 +4398,12 @@ static void irdma_qhash_ctrl(struct irdma_device *iwdev,
 /**
  * irdma_if_notify - process an ifdown on an interface
  * @iwdev: device pointer
- * @netdev: network device structure
+ * @vlan_id:VLAN ID of the netdev
  * @ipaddr: Pointer to IPv4 or IPv6 address
  * @ipv4: flag indicating IPv4 when true
  * @ifup: flag indicating interface up when true
  */
-void irdma_if_notify(struct irdma_device *iwdev, struct net_device *netdev,
+void irdma_if_notify(struct irdma_device *iwdev, u16 vlan_id,
 		     u32 *ipaddr, bool ipv4, bool ifup)
 {
 	struct irdma_cm_core *cm_core = &iwdev->cm_core;
@@ -4329,7 +4411,6 @@ void irdma_if_notify(struct irdma_device *iwdev, struct net_device *netdev,
 	struct irdma_cm_listener *listen_node;
 	static const u32 ip_zero[4] = { 0, 0, 0, 0 };
 	struct irdma_cm_info nfo = {};
-	u16 vlan_id = rdma_vlan_dev_vlan_id(netdev);
 	enum irdma_quad_hash_manage_type op = ifup ?
 					      IRDMA_QHASH_MANAGE_TYPE_ADD :
 					      IRDMA_QHASH_MANAGE_TYPE_DELETE;
@@ -4367,3 +4448,13 @@ void irdma_if_notify(struct irdma_device *iwdev, struct net_device *netdev,
 	if (!ifup)
 		irdma_cm_teardown_connections(iwdev, ipaddr, &nfo, false);
 }
+
+void irdma_if_notify_worker(struct work_struct *work)
+{
+	struct if_notify_work *iwork =
+		container_of(work, struct if_notify_work, work);
+
+	irdma_if_notify(iwork->iwdev, iwork->vlan_id, iwork->ipaddr,
+			iwork->ipv4, iwork->ifup);
+	kfree(iwork);
+}
diff --git a/drivers/infiniband/hw/irdma/cm.h b/drivers/infiniband/hw/irdma/cm.h
index 19c284975fc7..b175729556b6 100644
--- a/drivers/infiniband/hw/irdma/cm.h
+++ b/drivers/infiniband/hw/irdma/cm.h
@@ -397,17 +397,13 @@ int irdma_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
 int irdma_create_listen(struct iw_cm_id *cm_id, int backlog);
 int irdma_destroy_listen(struct iw_cm_id *cm_id);
 int irdma_add_arp(struct irdma_pci_f *rf, u32 *ip, bool ipv4, const u8 *mac);
-void irdma_cm_teardown_connections(struct irdma_device *iwdev, u32 *ipaddr,
-				   struct irdma_cm_info *nfo,
-				   bool disconnect_all);
+void irdma_if_notify_worker(struct work_struct *work);
 int irdma_cm_start(struct irdma_device *dev);
 int irdma_cm_stop(struct irdma_device *dev);
 bool irdma_ipv4_is_lpb(u32 loc_addr, u32 rem_addr);
 bool irdma_ipv6_is_lpb(u32 *loc_addr, u32 *rem_addr);
 int irdma_arp_table(struct irdma_pci_f *rf, u32 *ip_addr, bool ipv4,
 		    const u8 *mac_addr, u32 action);
-void irdma_if_notify(struct irdma_device *iwdev, struct net_device *netdev,
-		     u32 *ipaddr, bool ipv4, bool ifup);
 bool irdma_port_in_use(struct irdma_cm_core *cm_core, u16 port);
 void irdma_send_ack(struct irdma_cm_node *cm_node);
 void irdma_lpb_nop(struct irdma_sc_qp *qp);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 445e69e86409..a91bfc9ee6d4 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -140,6 +140,25 @@ static void irdma_gid_change_event(struct ib_device *ibdev)
 	ib_dispatch_event(&ib_event);
 }
 
+static void irdma_if_notify_sched(struct irdma_device *iwdev,
+				  struct net_device *netdev,
+				  u32 *ipaddr, bool ipv4, bool ifup)
+{
+	struct if_notify_work *work;
+
+	work = kzalloc(sizeof(*work), GFP_ATOMIC);
+	if (!work)
+		return;
+	work->iwdev = iwdev;
+	work->vlan_id = rdma_vlan_dev_vlan_id(netdev);
+	work->ipv4 = ipv4;
+	work->ifup = ifup;
+	memcpy(work->ipaddr, ipaddr, ipv4 ? 4 : 16);
+
+	INIT_WORK(&work->work, irdma_if_notify_worker);
+	queue_work(iwdev->cleanup_wq, &work->work);
+}
+
 /**
  * irdma_inetaddr_event - system notifier for ipv4 addr events
  * @notifier: not used
@@ -172,13 +191,13 @@ int irdma_inetaddr_event(struct notifier_block *notifier, unsigned long event,
 	case NETDEV_DOWN:
 		irdma_manage_arp_cache(iwdev->rf, real_dev->dev_addr,
 				       &local_ipaddr, true, IRDMA_ARP_DELETE);
-		irdma_if_notify(iwdev, real_dev, &local_ipaddr, true, false);
+		irdma_if_notify_sched(iwdev, netdev, &local_ipaddr, true, false);
 		irdma_gid_change_event(&iwdev->ibdev);
 		break;
 	case NETDEV_UP:
 	case NETDEV_CHANGEADDR:
 		irdma_add_arp(iwdev->rf, &local_ipaddr, true, real_dev->dev_addr);
-		irdma_if_notify(iwdev, real_dev, &local_ipaddr, true, true);
+		irdma_if_notify_sched(iwdev, netdev, &local_ipaddr, true, true);
 		irdma_gid_change_event(&iwdev->ibdev);
 		break;
 	default:
@@ -222,14 +241,14 @@ int irdma_inet6addr_event(struct notifier_block *notifier, unsigned long event,
 	case NETDEV_DOWN:
 		irdma_manage_arp_cache(iwdev->rf, real_dev->dev_addr,
 				       local_ipaddr6, false, IRDMA_ARP_DELETE);
-		irdma_if_notify(iwdev, real_dev, local_ipaddr6, false, false);
+		irdma_if_notify_sched(iwdev, netdev, local_ipaddr6, false, false);
 		irdma_gid_change_event(&iwdev->ibdev);
 		break;
 	case NETDEV_UP:
 	case NETDEV_CHANGEADDR:
 		irdma_add_arp(iwdev->rf, local_ipaddr6, false,
 			      real_dev->dev_addr);
-		irdma_if_notify(iwdev, real_dev, local_ipaddr6, false, true);
+		irdma_if_notify_sched(iwdev, netdev, local_ipaddr6, false, true);
 		irdma_gid_change_event(&iwdev->ibdev);
 		break;
 	default:
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index a536e9fa85eb..d1946779142c 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -142,6 +142,15 @@ struct disconn_work {
 
 struct iw_cm_id;
 
+struct if_notify_work {
+	struct work_struct work;
+	struct irdma_device *iwdev;
+	u32 ipaddr[4];
+	u16 vlan_id;
+	bool ipv4:1;
+	bool ifup:1;
+};
+
 struct irdma_qp_kmode {
 	struct irdma_dma_mem dma_mem;
 	struct irdma_sq_uk_wr_trk_info *sq_wrid_mem;
-- 
2.27.0

