Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25175433A0A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhJSPTU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 11:19:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:11469 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232601AbhJSPTU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 11:19:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="228422223"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="228422223"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 08:17:07 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="594286135"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.209.137.150])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 08:17:06 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc 2/2] RDMA/irdma: Do not hold qos mutex twice on QP resume
Date:   Tue, 19 Oct 2021 10:16:54 -0500
Message-Id: <20211019151654.1943-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211019151654.1943-1-shiraz.saleem@intel.com>
References: <20211019151654.1943-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

When irdma_ws_add fails, irdma_ws_remove is used to cleanup the leaf node.
This lead to holding the qos mutex twice in the QP resume path. Fix this
by avoiding the call to irdma_ws_remove and unwinding the error in
irdma_ws_add. This skips the call to irdma_tc_in_use function which is not
needed in the error unwind cases.

Fixes: 3ae331c75128 ("RDMA/irdma: Add QoS definitions")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/ws.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ws.c b/drivers/infiniband/hw/irdma/ws.c
index b68c575..b0d6ee0 100644
--- a/drivers/infiniband/hw/irdma/ws.c
+++ b/drivers/infiniband/hw/irdma/ws.c
@@ -330,8 +330,10 @@ enum irdma_status_code irdma_ws_add(struct irdma_sc_vsi *vsi, u8 user_pri)
 
 		tc_node->enable = true;
 		ret = irdma_ws_cqp_cmd(vsi, tc_node, IRDMA_OP_WS_MODIFY_NODE);
-		if (ret)
+		if (ret) {
+			vsi->unregister_qset(vsi, tc_node);
 			goto reg_err;
+		}
 	}
 	ibdev_dbg(to_ibdev(vsi->dev),
 		  "WS: Using node %d which represents VSI %d TC %d\n",
@@ -350,6 +352,10 @@ enum irdma_status_code irdma_ws_add(struct irdma_sc_vsi *vsi, u8 user_pri)
 	}
 	goto exit;
 
+reg_err:
+	irdma_ws_cqp_cmd(vsi, tc_node, IRDMA_OP_WS_DELETE_NODE);
+	list_del(&tc_node->siblings);
+	irdma_free_node(vsi, tc_node);
 leaf_add_err:
 	if (list_empty(&vsi_node->child_list_head)) {
 		if (irdma_ws_cqp_cmd(vsi, vsi_node, IRDMA_OP_WS_DELETE_NODE))
@@ -369,11 +375,6 @@ enum irdma_status_code irdma_ws_add(struct irdma_sc_vsi *vsi, u8 user_pri)
 exit:
 	mutex_unlock(&vsi->dev->ws_mutex);
 	return ret;
-
-reg_err:
-	mutex_unlock(&vsi->dev->ws_mutex);
-	irdma_ws_remove(vsi, user_pri);
-	return ret;
 }
 
 /**
-- 
1.8.3.1

