Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28B720C2C
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Jun 2023 01:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjFBXDO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 19:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjFBXDN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 19:03:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A501B9
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685746991; x=1717282991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q7h1ZMhxbNURQuA5XtOk+EhWSJbIdH6dbKl6oWdFYHw=;
  b=Xdj8L2A8cdTqCbgnsGT2D/7ZjtCmvVaaRyj3/x/beSOYHQIZwziDBbDZ
   fgK3sZGRfmMbwSY524M4x91VC1K75JVl6cNR9veDXVImwFComlqeF7f9R
   H9Ic8urvRQg/bZqmmCLmQhYDg8n2vLEixhSZfNl27LKVcdfp+OGEP3kVQ
   iLkxGbUeYFeCwvJyARVUWIIfrHq7ZLo8spL63GRAXxS3C8UM5iBW+eqgv
   /fy7oVDY11FlGRb+xdFYUsK57V6+1iY1RB7t4mkjMJmygPWpdNXfZ+rOx
   +Ru0uPWEen+ApM7/S92LaG2HaRLRjMlNA2R4BR7GuFTseBJk+X/6/ldFN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="335609064"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="335609064"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 16:03:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="708007183"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="708007183"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.96.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 16:03:10 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next v1] RDMA/irdma: Implement egress VLAN priority
Date:   Fri,  2 Jun 2023 18:02:57 -0500
Message-Id: <20230602230257.1430-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

When a VLAN interface is in use, get and use the VLAN
egress mapping.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
v0-->v1:
Use rcu_dereference on GID attribute __rcu pointer
vs the function arg in irdma_roce_get_vlan_prio

 drivers/infiniband/hw/irdma/cm.c    | 50 +++++++++++++++++++++++++++++++++++--
 drivers/infiniband/hw/irdma/verbs.c | 45 ++++++++++++++++++++++++++-------
 2 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 70009b9..926823f 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -1555,6 +1555,26 @@ static int irdma_del_multiple_qhash(struct irdma_device *iwdev,
 	return ret;
 }
 
+static u8 irdma_iw_get_vlan_prio(u32 *loc_addr, u8 prio, bool ipv4)
+{
+	struct net_device *ndev;
+
+	if (ipv4)
+		ndev = ip_dev_find(&init_net, htonl(loc_addr[0]));
+	else
+		ndev = irdma_netdev_vlan_ipv6(loc_addr, NULL, NULL);
+
+	if (!ndev)
+		return prio;
+	if (is_vlan_dev(ndev))
+		prio = (vlan_dev_get_egress_qos_mask(ndev, prio) & VLAN_PRIO_MASK)
+			>> VLAN_PRIO_SHIFT;
+	if (ipv4)
+		dev_put(ndev);
+
+	return prio;
+}
+
 /**
  * irdma_netdev_vlan_ipv6 - Gets the netdev and mac
  * @addr: local IPv6 address
@@ -1667,6 +1687,12 @@ static int irdma_add_mqh_6(struct irdma_device *iwdev,
 					    ifp->addr.in6_u.u6_addr32);
 			memcpy(cm_info->loc_addr, child_listen_node->loc_addr,
 			       sizeof(cm_info->loc_addr));
+			if (!iwdev->vsi.dscp_mode)
+				cm_info->user_pri =
+				irdma_iw_get_vlan_prio(child_listen_node->loc_addr,
+						       cm_info->user_pri,
+						       false);
+
 			ret = irdma_manage_qhash(iwdev, cm_info,
 						 IRDMA_QHASH_TYPE_TCP_SYN,
 						 IRDMA_QHASH_MANAGE_TYPE_ADD,
@@ -1751,6 +1777,11 @@ static int irdma_add_mqh_4(struct irdma_device *iwdev,
 				ntohl(ifa->ifa_address);
 			memcpy(cm_info->loc_addr, child_listen_node->loc_addr,
 			       sizeof(cm_info->loc_addr));
+			if (!iwdev->vsi.dscp_mode)
+				cm_info->user_pri =
+				irdma_iw_get_vlan_prio(child_listen_node->loc_addr,
+						       cm_info->user_pri,
+						       true);
 			ret = irdma_manage_qhash(iwdev, cm_info,
 						 IRDMA_QHASH_TYPE_TCP_SYN,
 						 IRDMA_QHASH_MANAGE_TYPE_ADD,
@@ -2219,6 +2250,10 @@ static void irdma_cm_free_ah(struct irdma_cm_node *cm_node)
 		} else {
 			cm_node->tos = max(listener->tos, cm_info->tos);
 			cm_node->user_pri = rt_tos2priority(cm_node->tos);
+			cm_node->user_pri =
+				irdma_iw_get_vlan_prio(cm_info->loc_addr,
+						       cm_node->user_pri,
+						       cm_info->ipv4);
 		}
 		ibdev_dbg(&iwdev->ibdev,
 			  "DCB: listener: TOS:[%d] UP:[%d]\n", cm_node->tos,
@@ -3832,11 +3867,15 @@ int irdma_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	cm_info.cm_id = cm_id;
 	cm_info.qh_qpid = iwdev->vsi.ilq->qp_id;
 	cm_info.tos = cm_id->tos;
-	if (iwdev->vsi.dscp_mode)
+	if (iwdev->vsi.dscp_mode) {
 		cm_info.user_pri =
 			iwqp->sc_qp.vsi->dscp_map[irdma_tos2dscp(cm_info.tos)];
-	else
+	} else {
 		cm_info.user_pri = rt_tos2priority(cm_id->tos);
+		cm_info.user_pri = irdma_iw_get_vlan_prio(cm_info.loc_addr,
+							  cm_info.user_pri,
+							  cm_info.ipv4);
+	}
 
 	if (iwqp->sc_qp.dev->ws_add(iwqp->sc_qp.vsi, cm_info.user_pri))
 		return -ENOMEM;
@@ -3990,6 +4029,13 @@ int irdma_create_listen(struct iw_cm_id *cm_id, int backlog)
 			if (err)
 				goto error;
 		} else {
+			if (!iwdev->vsi.dscp_mode) {
+				cm_listen_node->user_pri =
+				irdma_iw_get_vlan_prio(cm_info.loc_addr,
+						       cm_info.user_pri,
+						       cm_info.ipv4);
+				cm_info.user_pri = cm_listen_node->user_pri;
+			}
 			err = irdma_manage_qhash(iwdev, &cm_info,
 						 IRDMA_QHASH_TYPE_TCP_SYN,
 						 IRDMA_QHASH_MANAGE_TYPE_ADD,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 6242ab6..96e7568 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1097,6 +1097,24 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 	return 0;
 }
 
+static u8 irdma_roce_get_vlan_prio(const struct ib_gid_attr *attr, u8 prio)
+{
+	struct net_device *ndev;
+
+	rcu_read_lock();
+	ndev = rcu_dereference(attr->ndev);
+	if (!ndev)
+		goto exit;
+	if (is_vlan_dev(ndev)) {
+		u16 vlan_qos = vlan_dev_get_egress_qos_mask(ndev, prio);
+
+		prio = (vlan_qos & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+	}
+exit:
+	rcu_read_unlock();
+	return prio;
+}
+
 /**
  * irdma_modify_qp_roce - modify qp request
  * @ibqp: qp's pointer for modify
@@ -1173,7 +1191,8 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	if (attr_mask & IB_QP_AV) {
 		struct irdma_av *av = &iwqp->roce_ah.av;
-		const struct ib_gid_attr *sgid_attr;
+		const struct ib_gid_attr *sgid_attr =
+				attr->ah_attr.grh.sgid_attr;
 		u16 vlan_id = VLAN_N_VID;
 		u32 local_ip[4];
 
@@ -1188,17 +1207,22 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 						   roce_info->dest_qp);
 			irdma_qp_rem_qos(&iwqp->sc_qp);
 			dev->ws_remove(iwqp->sc_qp.vsi, ctx_info->user_pri);
-			ctx_info->user_pri = rt_tos2priority(udp_info->tos);
-			iwqp->sc_qp.user_pri = ctx_info->user_pri;
-			if (dev->ws_add(iwqp->sc_qp.vsi, ctx_info->user_pri))
-				return -ENOMEM;
-			irdma_qp_add_qos(&iwqp->sc_qp);
+			if (iwqp->sc_qp.vsi->dscp_mode)
+				ctx_info->user_pri =
+				iwqp->sc_qp.vsi->dscp_map[irdma_tos2dscp(udp_info->tos)];
+			else
+				ctx_info->user_pri = rt_tos2priority(udp_info->tos);
 		}
-		sgid_attr = attr->ah_attr.grh.sgid_attr;
 		ret = rdma_read_gid_l2_fields(sgid_attr, &vlan_id,
 					      ctx_info->roce_info->mac_addr);
 		if (ret)
 			return ret;
+		ctx_info->user_pri = irdma_roce_get_vlan_prio(sgid_attr,
+							      ctx_info->user_pri);
+		if (dev->ws_add(iwqp->sc_qp.vsi, ctx_info->user_pri))
+			return -ENOMEM;
+		iwqp->sc_qp.user_pri = ctx_info->user_pri;
+		irdma_qp_add_qos(&iwqp->sc_qp);
 
 		if (vlan_id >= VLAN_N_VID && iwdev->dcb_vlan_mode)
 			vlan_id = 0;
@@ -4259,9 +4283,12 @@ static int irdma_setup_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *attr)
 		ah_info->vlan_tag = 0;
 
 	if (ah_info->vlan_tag < VLAN_N_VID) {
+		u8 prio = rt_tos2priority(ah_info->tc_tos);
+
+		prio = irdma_roce_get_vlan_prio(sgid_attr, prio);
+
+		ah_info->vlan_tag |= (u16)prio << VLAN_PRIO_SHIFT;
 		ah_info->insert_vlan_tag = true;
-		ah_info->vlan_tag |=
-			rt_tos2priority(ah_info->tc_tos) << VLAN_PRIO_SHIFT;
 	}
 
 	return 0;
-- 
1.8.3.1

