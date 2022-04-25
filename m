Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD4050E7F0
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 20:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiDYSUV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 14:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiDYSUU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 14:20:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18C3B282
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650910635; x=1682446635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pWZv4l5LQ+CoAV5A3VkGyMs2OCn1dMWyctZXhNHzAzA=;
  b=DzIWQXY2vHnLNL0RmQw3CAbLlnjMK599oWlpogi2sujYpL5A5DOc02fF
   HSB/jhyhd+qm8YjdRSTR6Di8WuoZ+WER7IjwGI4L6RD7JWW/tgiy45YPG
   YCneX/QCfInxSoP07fXwI/evd7dNAl6VLRQRDRYFqhP5cqDw3pMrQrhO9
   bvd0FczvBDjsb3cxhxx/qFnyQhTq+BGZLYZ7mSZTSnvXkOcBR4YOj/RgT
   RISDusrpeWWeuaP8La1a4nqh2JT7kfJYEKaZFlETA0/fTpp6rqel8MTLz
   IHP3OLabQPdDv5XGclX94sjfn6nIaPdEdUNGISjqaOMCBj6osu+qe5vBd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252697320"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="252697320"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:17:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="537708105"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.50.71])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:17:14 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 2/3] RDMA/irdma: Reduce iWARP QP destroy time
Date:   Mon, 25 Apr 2022 13:17:02 -0500
Message-Id: <20220425181703.1634-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220425181703.1634-1-shiraz.saleem@intel.com>
References: <20220425181703.1634-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QP destroy is synchronous and waits for its refcnt to be decremented in
irdma_cm_node_free_cb (for iWARP) which fires after the RCU grace period
elapses.

Applications running a large number of connections are exposed to high
wait times on destroy QP for events like SIGABORT.

The long poll for this wait time is the firing of the call_rcu callback
during a CM node destroy which can be slow. It holds the QP reference
count and blocks the destroy QP from completing.

call_rcu only needs to make sure that list walkers have a reference
to the cm_node object before freeing it and thus need to wait for grace
period elapse. The rest of the connection teardown in
irdma_cm_node_free_cb is moved out of the grace period wait in
irdma_destroy_connection. Also, replace call_rcu with a simple kfree_rcu
as it just needs to do a kfree on the cm_node

Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index d185f3a0..656baa3 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -2308,10 +2308,8 @@ static void irdma_cm_free_ah(struct irdma_cm_node *cm_node)
 	return NULL;
 }
 
-static void irdma_cm_node_free_cb(struct rcu_head *rcu_head)
+static void irdma_destroy_connection(struct irdma_cm_node *cm_node)
 {
-	struct irdma_cm_node *cm_node =
-			    container_of(rcu_head, struct irdma_cm_node, rcu_head);
 	struct irdma_cm_core *cm_core = cm_node->cm_core;
 	struct irdma_qp *iwqp;
 	struct irdma_cm_info nfo;
@@ -2359,7 +2357,6 @@ static void irdma_cm_node_free_cb(struct rcu_head *rcu_head)
 	}
 
 	cm_core->cm_free_ah(cm_node);
-	kfree(cm_node);
 }
 
 /**
@@ -2387,8 +2384,9 @@ void irdma_rem_ref_cm_node(struct irdma_cm_node *cm_node)
 
 	spin_unlock_irqrestore(&cm_core->ht_lock, flags);
 
-	/* wait for all list walkers to exit their grace period */
-	call_rcu(&cm_node->rcu_head, irdma_cm_node_free_cb);
+	irdma_destroy_connection(cm_node);
+
+	kfree_rcu(cm_node, rcu_head);
 }
 
 /**
-- 
1.8.3.1

