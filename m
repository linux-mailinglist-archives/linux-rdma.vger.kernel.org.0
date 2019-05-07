Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07232164B4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfEGNis (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:38:48 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40337 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbfEGNis (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:38:48 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:40 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdF5021865;
        Tue, 7 May 2019 16:38:40 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 05/25] RDMA/core: Add signature attrs element for ib_mr structure
Date:   Tue,  7 May 2019 16:38:19 +0300
Message-Id: <1557236319-9986-6-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This element will describe the needed characteristics for the signature
operation per signature enabled memory region (type IB_MR_TYPE_INTEGRITY).

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/core/uverbs_cmd.c |  1 +
 drivers/infiniband/core/verbs.c      | 13 ++++++++++++-
 include/rdma/ib_verbs.h              |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 095d714b9c1c..9643d19314cd 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -746,6 +746,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	mr->pd      = pd;
 	mr->type    = IB_MR_TYPE_USER;
 	mr->dm	    = NULL;
+	mr->sig_attrs = NULL;
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
 	mr->res.type = RDMA_RESTRACK_MR;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 9044e5f84ae4..151fc2e52b63 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1957,6 +1957,7 @@ int ib_dereg_mr(struct ib_mr *mr)
 {
 	struct ib_pd *pd = mr->pd;
 	struct ib_dm *dm = mr->dm;
+	struct ib_sig_attrs *sig_attrs = mr->sig_attrs;
 	int ret;
 
 	rdma_restrack_del(&mr->res);
@@ -1965,6 +1966,7 @@ int ib_dereg_mr(struct ib_mr *mr)
 		atomic_dec(&pd->usecnt);
 		if (dm)
 			atomic_dec(&dm->usecnt);
+		kfree(sig_attrs);
 	}
 
 	return ret;
@@ -2006,6 +2008,7 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd,
 		mr->res.type = RDMA_RESTRACK_MR;
 		rdma_restrack_kadd(&mr->res);
 		mr->type = mr_type;
+		mr->sig_attrs = NULL;
 	}
 
 	return mr;
@@ -2029,6 +2032,7 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 				    u32 max_num_meta_sg)
 {
 	struct ib_mr *mr;
+	struct ib_sig_attrs *sig_attrs;
 
 	if (!pd->device->ops.alloc_mr_integrity ||
 	    !pd->device->ops.map_mr_sg_pi)
@@ -2037,10 +2041,16 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
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
@@ -2051,6 +2061,7 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	mr->res.type = RDMA_RESTRACK_MR;
 	rdma_restrack_kadd(&mr->res);
 	mr->type = IB_MR_TYPE_INTEGRITY;
+	mr->sig_attrs = sig_attrs;
 
 	return mr;
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0e288fb5cd40..05c9996915d5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1716,7 +1716,7 @@ struct ib_mr {
 	};
 
 	struct ib_dm      *dm;
-
+	struct ib_sig_attrs *sig_attrs; /* only for IB_MR_TYPE_INTEGRITY MRs */
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
-- 
2.16.3

