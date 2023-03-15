Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A6B6BB6B5
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 15:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjCOO4J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjCOOzy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 10:55:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE9823A79
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892099; x=1710428099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=80rnPN658u/2vQrbjAP78NXf33A3bqVGKcEBJ7VETvQ=;
  b=T4uicMSN8Ayx7hOrVge5UtGN5U/sfkBwE4ZL+4FRW/R3hsP+umStUc9s
   x+1Bl6H+e2zoWlECRBuC0FWxdL4huTzwxSoFXEFQxM0X8ndCb2wizVbhU
   +JO7FGjQn9c/+WkW6wgv+O0lRu34gRUabayxj/tCI81U5Q3EvZDesxGTH
   xaNR/x3LNfOE2OGgRk3ep1p4kaYJu0E9APM55PMCH+GFDc7gZqNduVicQ
   gEWhH+0a6ShcTty9SFeRn/4OK6gb3v8vuQJhtDzJQ3mIAZ+knq+oqCxot
   mKOtLGgpAM9UfQcaElXLIFpdZZj/pxFroJ8wqQttpfbQUJRiQvvwkkiWZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321561550"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321561550"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:52:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="748457454"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748457454"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.35.84])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:52:47 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 4/4] RDMA/irdma: Add ipv4 check to irdma_find_listener()
Date:   Wed, 15 Mar 2023 09:52:31 -0500
Message-Id: <20230315145231.931-5-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230315145231.931-1-shiraz.saleem@intel.com>
References: <20230315145231.931-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

Add ipv4 check to irdma_find_listener(). Otherwise the function
incorrectly finds and returns a listener with a different addr family for
the zero IP addr, if a listener with a zero IP addr and the same port as
the one searched for has already been created.

Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 195aa9e..8817864 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -1458,13 +1458,15 @@ static int irdma_send_fin(struct irdma_cm_node *cm_node)
  * irdma_find_listener - find a cm node listening on this addr-port pair
  * @cm_core: cm's core
  * @dst_addr: listener ip addr
+ * @ipv4: flag indicating IPv4 when true
  * @dst_port: listener tcp port num
  * @vlan_id: virtual LAN ID
  * @listener_state: state to match with listen node's
  */
 static struct irdma_cm_listener *
-irdma_find_listener(struct irdma_cm_core *cm_core, u32 *dst_addr, u16 dst_port,
-		    u16 vlan_id, enum irdma_cm_listener_state listener_state)
+irdma_find_listener(struct irdma_cm_core *cm_core, u32 *dst_addr, bool ipv4,
+		    u16 dst_port, u16 vlan_id,
+		    enum irdma_cm_listener_state listener_state)
 {
 	struct irdma_cm_listener *listen_node;
 	static const u32 ip_zero[4] = { 0, 0, 0, 0 };
@@ -1477,7 +1479,7 @@ static int irdma_send_fin(struct irdma_cm_node *cm_node)
 	list_for_each_entry (listen_node, &cm_core->listen_list, list) {
 		memcpy(listen_addr, listen_node->loc_addr, sizeof(listen_addr));
 		listen_port = listen_node->loc_port;
-		if (listen_port != dst_port ||
+		if (listen_node->ipv4 != ipv4 || listen_port != dst_port ||
 		    !(listener_state & listen_node->listener_state))
 			continue;
 		/* compare node pair, return node handle if a match */
@@ -2902,9 +2904,10 @@ static void irdma_process_pkt(struct irdma_cm_node *cm_node,
 	unsigned long flags;
 
 	/* cannot have multiple matching listeners */
-	listener = irdma_find_listener(cm_core, cm_info->loc_addr,
-				       cm_info->loc_port, cm_info->vlan_id,
-				       IRDMA_CM_LISTENER_EITHER_STATE);
+	listener =
+		irdma_find_listener(cm_core, cm_info->loc_addr, cm_info->ipv4,
+				    cm_info->loc_port, cm_info->vlan_id,
+				    IRDMA_CM_LISTENER_EITHER_STATE);
 	if (listener &&
 	    listener->listener_state == IRDMA_CM_LISTENER_ACTIVE_STATE) {
 		refcount_dec(&listener->refcnt);
@@ -3153,6 +3156,7 @@ void irdma_receive_ilq(struct irdma_sc_vsi *vsi, struct irdma_puda_buf *rbuf)
 
 		listener = irdma_find_listener(cm_core,
 					       cm_info.loc_addr,
+					       cm_info.ipv4,
 					       cm_info.loc_port,
 					       cm_info.vlan_id,
 					       IRDMA_CM_LISTENER_ACTIVE_STATE);
-- 
1.8.3.1

