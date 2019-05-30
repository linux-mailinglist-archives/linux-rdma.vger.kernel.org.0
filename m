Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64C2FC3B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfE3NZk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:25:40 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34900 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbfE3NZk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:25:40 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 May 2019 16:25:32 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4UDPVZX007883;
        Thu, 30 May 2019 16:25:32 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 05/20] RDMA/core: Add signature attrs element for ib_mr structure
Date:   Thu, 30 May 2019 16:25:16 +0300
Message-Id: <1559222731-16715-6-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This element will describe the needed characteristics for the signature
operation per signature enabled memory region (type IB_MR_TYPE_INTEGRITY).
Also add meta_length attribute to ib_sig_attrs structure for saving the
mapped metadata length (needed for the new API implementation).

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c |  1 +
 drivers/infiniband/core/verbs.c      | 13 ++++++++++++-
 include/rdma/ib_verbs.h              |  2 +-
 include/rdma/signature.h             |  2 ++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 1590f4d9cd65..14bae90ca975 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -747,6 +747,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	mr->pd      = pd;
 	mr->type    = IB_MR_TYPE_USER;
 	mr->dm	    = NULL;
+	mr->sig_attrs = NULL;
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
 	mr->res.type = RDMA_RESTRACK_MR;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 96ddae029095..fc55482f51d6 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1967,6 +1967,7 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
 {
 	struct ib_pd *pd = mr->pd;
 	struct ib_dm *dm = mr->dm;
+	struct ib_sig_attrs *sig_attrs = mr->sig_attrs;
 	int ret;
 
 	rdma_restrack_del(&mr->res);
@@ -1975,6 +1976,7 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
 		atomic_dec(&pd->usecnt);
 		if (dm)
 			atomic_dec(&dm->usecnt);
+		kfree(sig_attrs);
 	}
 
 	return ret;
@@ -2016,6 +2018,7 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 		mr->res.type = RDMA_RESTRACK_MR;
 		rdma_restrack_kadd(&mr->res);
 		mr->type = mr_type;
+		mr->sig_attrs = NULL;
 	}
 
 	return mr;
@@ -2039,6 +2042,7 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 				    u32 max_num_meta_sg)
 {
 	struct ib_mr *mr;
+	struct ib_sig_attrs *sig_attrs;
 
 	if (!pd->device->ops.alloc_mr_integrity ||
 	    !pd->device->ops.map_mr_sg_pi)
@@ -2047,10 +2051,16 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	if (!max_num_meta_sg)
 		return ERR_PTR(-EINVAL);
 
+	sig_attrs = kzalloc(sizeof(struct ib_sig_attrs), GFP_KERNEL);
+	if (!sig_attrs)
+		return ERR_PTR(-ENOMEM);
+
 	mr = pd->device->ops.alloc_mr_integrity(pd, max_num_data_sg,
 						max_num_meta_sg);
-	if (IS_ERR(mr))
+	if (IS_ERR(mr)) {
+		kfree(sig_attrs);
 		return mr;
+	}
 
 	mr->device = pd->device;
 	mr->pd = pd;
@@ -2061,6 +2071,7 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	mr->res.type = RDMA_RESTRACK_MR;
 	rdma_restrack_kadd(&mr->res);
 	mr->type = IB_MR_TYPE_INTEGRITY;
+	mr->sig_attrs = sig_attrs;
 
 	return mr;
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 96b868a223c5..0a1713b86398 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1750,7 +1750,7 @@ struct ib_mr {
 	};
 
 	struct ib_dm      *dm;
-
+	struct ib_sig_attrs *sig_attrs; /* only for IB_MR_TYPE_INTEGRITY MRs */
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
diff --git a/include/rdma/signature.h b/include/rdma/signature.h
index 5998fe94dfd4..f24cc2a1d3c5 100644
--- a/include/rdma/signature.h
+++ b/include/rdma/signature.h
@@ -80,11 +80,13 @@ struct ib_sig_domain {
  * @check_mask: bitmask for signature byte check (8 bytes)
  * @mem: memory domain layout descriptor.
  * @wire: wire domain layout descriptor.
+ * @meta_length: metadata length
  */
 struct ib_sig_attrs {
 	u8			check_mask;
 	struct ib_sig_domain	mem;
 	struct ib_sig_domain	wire;
+	int			meta_length;
 };
 
 enum ib_sig_err_type {
-- 
2.16.3

