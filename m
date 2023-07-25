Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE96761DC3
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGYPzV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjGYPzS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:55:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05992109
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300517; x=1721836517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H56wEK0aHcvJIE9/REfE/kh80v0z4+0OmjhYEpst4Ek=;
  b=YHkwECEbEgV4edex4Ur7FbL3xVCYS/9EUbHGhreYYCEScKW/nYuSZxvl
   p3zFPSOBp50/vssNtyBJllVnad17AXFzWES9A2OBAPQaq3GA3/25X6R4f
   Q+PB1q0uo07anMV7FZDTteOhmMQ3IBHPtnDRHJLFFrKyvwPKTVAPhoERT
   P26PDS0ERAs4KRW2dKtKK+RjMvfelIPunw12iDC9m+htiPX4TcPRV/aSj
   phwTrMC39tekEBSH+OOE5Vz5n8LbCDhjtPbIBkXcYgXPWnu4WeBu3co0z
   0telOl0fsE8Bm3jnW77zVP6r9CQPA6X4XIMsiKu2qWOI/xjAfe9QO/AFV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431574687"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431574687"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972743811"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972743811"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:16 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 4/4] RDMA/irdma: Cleanup and rename irdma_netdev_vlan_ipv6()
Date:   Tue, 25 Jul 2023 10:55:05 -0500
Message-Id: <20230725155505.1069-5-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230725155505.1069-1-shiraz.saleem@intel.com>
References: <20230725155505.1069-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

The return value from irdma_netdev_vlan_ipv6() is not used. Rename
the functions and change to a void return.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c    | 23 ++++++++++-------------
 drivers/infiniband/hw/irdma/main.h  |  2 +-
 drivers/infiniband/hw/irdma/verbs.c |  2 +-
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 70017048d7d1..42d1e9771066 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -1591,21 +1591,20 @@ static u8 irdma_iw_get_vlan_prio(u32 *loc_addr, u8 prio, bool ipv4)
 }
 
 /**
- * irdma_netdev_vlan_ipv6 - Gets the netdev and mac
+ * irdma_get_vlan_mac_ipv6 - Gets the vlan and mac
  * @addr: local IPv6 address
  * @vlan_id: vlan id for the given IPv6 address
  * @mac: mac address for the given IPv6 address
  *
- * Returns the net_device of the IPv6 address and also sets the
- * vlan id and mac for that address.
+ * Returns the vlan id and mac for an IPv6 address.
  */
-struct net_device *irdma_netdev_vlan_ipv6(u32 *addr, u16 *vlan_id, u8 *mac)
+void irdma_get_vlan_mac_ipv6(u32 *addr, u16 *vlan_id, u8 *mac)
 {
 	struct net_device *ip_dev = NULL;
 	struct in6_addr laddr6;
 
 	if (!IS_ENABLED(CONFIG_IPV6))
-		return NULL;
+		return;
 
 	irdma_copy_ip_htonl(laddr6.in6_u.u6_addr32, addr);
 	if (vlan_id)
@@ -1624,8 +1623,6 @@ struct net_device *irdma_netdev_vlan_ipv6(u32 *addr, u16 *vlan_id, u8 *mac)
 		}
 	}
 	rcu_read_unlock();
-
-	return ip_dev;
 }
 
 /**
@@ -3666,8 +3663,8 @@ int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 		cm_node->vlan_id = irdma_get_vlan_ipv4(cm_node->loc_addr);
 	} else {
 		cm_node->ipv4 = false;
-		irdma_netdev_vlan_ipv6(cm_node->loc_addr, &cm_node->vlan_id,
-				       NULL);
+		irdma_get_vlan_mac_ipv6(cm_node->loc_addr, &cm_node->vlan_id,
+					NULL);
 	}
 	ibdev_dbg(&iwdev->ibdev, "CM: Accept vlan_id=%d\n",
 		  cm_node->vlan_id);
@@ -3875,8 +3872,8 @@ int irdma_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 				    raddr6->sin6_addr.in6_u.u6_addr32);
 		cm_info.loc_port = ntohs(laddr6->sin6_port);
 		cm_info.rem_port = ntohs(raddr6->sin6_port);
-		irdma_netdev_vlan_ipv6(cm_info.loc_addr, &cm_info.vlan_id,
-				       NULL);
+		irdma_get_vlan_mac_ipv6(cm_info.loc_addr, &cm_info.vlan_id,
+					NULL);
 	}
 	cm_info.cm_id = cm_id;
 	cm_info.qh_qpid = iwdev->vsi.ilq->qp_id;
@@ -4005,8 +4002,8 @@ int irdma_create_listen(struct iw_cm_id *cm_id, int backlog)
 				    laddr6->sin6_addr.in6_u.u6_addr32);
 		cm_info.loc_port = ntohs(laddr6->sin6_port);
 		if (ipv6_addr_type(&laddr6->sin6_addr) != IPV6_ADDR_ANY) {
-			irdma_netdev_vlan_ipv6(cm_info.loc_addr,
-					       &cm_info.vlan_id, NULL);
+			irdma_get_vlan_mac_ipv6(cm_info.loc_addr,
+						&cm_info.vlan_id, NULL);
 		} else {
 			cm_info.vlan_id = 0xFFFF;
 			wildcard = true;
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index d3bddd48e864..ad2239aabbc5 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -533,7 +533,7 @@ void irdma_gen_ae(struct irdma_pci_f *rf, struct irdma_sc_qp *qp,
 void irdma_copy_ip_ntohl(u32 *dst, __be32 *src);
 void irdma_copy_ip_htonl(__be32 *dst, u32 *src);
 u16 irdma_get_vlan_ipv4(u32 *addr);
-struct net_device *irdma_netdev_vlan_ipv6(u32 *addr, u16 *vlan_id, u8 *mac);
+void irdma_get_vlan_mac_ipv6(u32 *addr, u16 *vlan_id, u8 *mac);
 struct ib_mr *irdma_reg_phys_mr(struct ib_pd *ib_pd, u64 addr, u64 size,
 				int acc, u64 *iova_start);
 int irdma_upload_qp_context(struct irdma_qp *iwqp, bool freeze, bool raw);
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 2009819bfad9..a1a42a7cd783 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3994,7 +3994,7 @@ static int irdma_attach_mcast(struct ib_qp *ibqp, union ib_gid *ibgid, u16 lid)
 	if (!ipv6_addr_v4mapped((struct in6_addr *)ibgid)) {
 		irdma_copy_ip_ntohl(ip_addr,
 				    sgid_addr.saddr_in6.sin6_addr.in6_u.u6_addr32);
-		irdma_netdev_vlan_ipv6(ip_addr, &vlan_id, NULL);
+		irdma_get_vlan_mac_ipv6(ip_addr, &vlan_id, NULL);
 		ipv4 = false;
 		ibdev_dbg(&iwdev->ibdev,
 			  "VERBS: qp_id=%d, IP6address=%pI6\n", ibqp->qp_num,
-- 
1.8.3.1

