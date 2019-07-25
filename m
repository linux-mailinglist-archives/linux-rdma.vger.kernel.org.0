Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B079075625
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbfGYRsx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 13:48:53 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:58956 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403879AbfGYRsx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 13:48:53 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x6PHmnri007746;
        Thu, 25 Jul 2019 10:48:50 -0700
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: [PATCH rdma-core 1/2] cxgb4: fix chipversion initialization
Date:   Thu, 25 Jul 2019 23:18:41 +0530
Message-Id: <20190725174841.26794-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.18.0.232.gb7bd9486b055
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With Commit `0c3cecfe04d5a`, device and vendor members of structure
verbs_match_ent are left unintialised. This causes c4iw_alloc_context()
failure due to incorrect chipversion.
This patch reorders the code to fetch chipversion from ib device attributes.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 providers/cxgb4/dev.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/providers/cxgb4/dev.c b/providers/cxgb4/dev.c
index ce3e7757699f..84711993ea32 100644
--- a/providers/cxgb4/dev.c
+++ b/providers/cxgb4/dev.c
@@ -144,22 +144,6 @@ static struct verbs_context *c4iw_alloc_context(struct ibv_device *ibdev,
 
 	verbs_set_ops(&context->ibv_ctx, &c4iw_ctx_common_ops);
 
-	switch (rhp->chip_version) {
-	case CHELSIO_T6:
-		PDBG("%s T6/T5/T4 device\n", __FUNCTION__);
-	case CHELSIO_T5:
-		PDBG("%s T5/T4 device\n", __FUNCTION__);
-	case CHELSIO_T4:
-		PDBG("%s T4 device\n", __FUNCTION__);
-		verbs_set_ops(&context->ibv_ctx, &c4iw_ctx_t4_ops);
-		break;
-	default:
-		PDBG("%s unknown hca type %d\n", __FUNCTION__,
-		     rhp->chip_version);
-		goto err_unmap;
-		break;
-	}
-
 	if (!rhp->mmid2ptr) {
 		int ret;
 
@@ -196,6 +180,23 @@ static struct verbs_context *c4iw_alloc_context(struct ibv_device *ibdev,
 				context->status_page->write_cmpl_supported;
 	}
 
+	rhp->chip_version = CHELSIO_CHIP_VERSION(attr.vendor_part_id >> 8);
+	switch (rhp->chip_version) {
+	case CHELSIO_T6:
+		PDBG("%s T6/T5/T4 device\n", __FUNCTION__);
+	case CHELSIO_T5:
+		PDBG("%s T5/T4 device\n", __FUNCTION__);
+	case CHELSIO_T4:
+		PDBG("%s T4 device\n", __FUNCTION__);
+		verbs_set_ops(&context->ibv_ctx, &c4iw_ctx_t4_ops);
+		break;
+	default:
+		PDBG("%s unknown hca type %d\n", __FUNCTION__,
+		     rhp->chip_version);
+		goto err_unmap;
+		break;
+	}
+
 	return &context->ibv_ctx;
 
 err_unmap:
@@ -456,7 +457,6 @@ static struct verbs_device *c4iw_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
 
 	pthread_spin_init(&dev->lock, PTHREAD_PROCESS_PRIVATE);
 	c4iw_abi_version = sysfs_dev->abi_ver;
-	dev->chip_version = CHELSIO_CHIP_VERSION(sysfs_dev->match->device >> 8);
 	dev->abi_version = sysfs_dev->abi_ver;
 	list_node_init(&dev->list);
 
-- 
2.18.0.232.gb7bd9486b055

