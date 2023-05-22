Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F9E70C2DA
	for <lists+linux-rdma@lfdr.de>; Mon, 22 May 2023 17:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjEVP6y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbjEVP6w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 11:58:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A22F1
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684771130; x=1716307130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRiweW8h/I3RjTNHOlN5ATe8IGtDloCcUtU4YNpOiIo=;
  b=VwLbYnd2MHobcDONHY6f8LyJKx1iTT65T8Aub1lX9cMaM4uTG273kZUm
   /04jdtdVrhWTFpev4t0X5wGkghi0Xs7zHDVJpyYetPpgD4UnO4h0Y16pd
   t+vPaqC4+j1cI1Ua+XueJ7OijrMBuDomIpl1ngMjxl8jc4oJMho3/P8CK
   V0ADjF/KyUY4MQM+85dOB4T75WQ//mk3M+BzpB2FKxmFF7h8mvKI4sVCt
   hei58bzbIqwerCEjpPw5qTC/sIQr30QnxQIRsN5tr0J6iYylPQKCOz+cQ
   vqwuC83u27BOmBSxOO+TOtVMebpeBjM6VnelIxKfoub88blo0spktuPjW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="337546892"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="337546892"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:58:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="734312895"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="734312895"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.172.160])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:58:48 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next] RDMA/irdma: Implement egress VLAN priority
Date:   Mon, 22 May 2023 10:56:52 -0500
Message-Id: <20230522155654.1309-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230522155654.1309-1-shiraz.saleem@intel.com>
References: <20230522155654.1309-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index ab5cdf7..52084651 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1097,6 +1097,24 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 	return 0;
 }
 
+static u8 irdma_roce_get_vlan_prio(struct net_device __rcu *ndev_rcu, u8 prio)
+{
+	struct net_device *ndev;
+
+	rcu_read_lock();
+	ndev = rcu_dereference(ndev_rcu);
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
+		ctx_info->user_pri = irdma_roce_get_vlan_prio(sgid_attr->ndev,
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
+		prio = irdma_roce_get_vlan_prio(sgid_attr->ndev, prio);
+
+		ah_info->vlan_tag |= (u16)prio << VLAN_PRIO_SHIFT;
 		ah_info->insert_vlan_tag = true;
-		ah_info->vlan_tag |=
-			rt_tos2priority(ah_info->tc_tos) << VLAN_PRIO_SHIFT;
 	}
 
 	return 0;
-- 
1.8.3.1

