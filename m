Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5862FC3A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfE3NZk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:25:40 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34896 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbfE3NZk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:25:40 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 May 2019 16:25:31 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4UDPVZU007883;
        Thu, 30 May 2019 16:25:31 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 02/20] RDMA/core: Save the MR type in the ib_mr structure
Date:   Thu, 30 May 2019 16:25:13 +0300
Message-Id: <1559222731-16715-3-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a preparation for the signature verbs API change. This change is
needed since the MR type will define, in the upcoming patches, the need
for allocating internal resources in LLD for signature handover related
operations. It will also help to make sure that signature related
functions are called with an appropriate MR type and fail otherwise.
Also introduce new mr types IB_MR_TYPE_USER, IB_MR_TYPE_DMA and
IB_MR_TYPE_DM for correctness.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c          |  1 +
 drivers/infiniband/core/uverbs_std_types_mr.c |  1 +
 drivers/infiniband/core/verbs.c               |  2 ++
 include/rdma/ib_verbs.h                       | 10 ++++++++++
 4 files changed, 14 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5a3a1780ceea..1590f4d9cd65 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -745,6 +745,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 
 	mr->device  = pd->device;
 	mr->pd      = pd;
+	mr->type    = IB_MR_TYPE_USER;
 	mr->dm	    = NULL;
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 610d3b9f7654..7ca79bfa3487 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -128,6 +128,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 
 	mr->device  = pd->device;
 	mr->pd      = pd;
+	mr->type    = IB_MR_TYPE_DM;
 	mr->dm      = dm;
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 4fd5aad890d2..e080202ff673 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -299,6 +299,7 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 
 		mr->device	= pd->device;
 		mr->pd		= pd;
+		mr->type        = IB_MR_TYPE_DMA;
 		mr->uobject	= NULL;
 		mr->need_inval	= false;
 
@@ -2011,6 +2012,7 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 		mr->need_inval = false;
 		mr->res.type = RDMA_RESTRACK_MR;
 		rdma_restrack_kadd(&mr->res);
+		mr->type = mr_type;
 	}
 
 	return mr;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5fcd242f313a..482237908fb9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -793,11 +793,20 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate);
  *                            register any arbitrary sg lists (without
  *                            the normal mr constraints - see
  *                            ib_map_mr_sg)
+ * @IB_MR_TYPE_DM:            memory region that is used for device
+ *                            memory registration
+ * @IB_MR_TYPE_USER:          memory region that is used for the user-space
+ *                            application
+ * @IB_MR_TYPE_DMA:           memory region that is used for DMA operations
+ *                            without address translations (VA=PA)
  */
 enum ib_mr_type {
 	IB_MR_TYPE_MEM_REG,
 	IB_MR_TYPE_SIGNATURE,
 	IB_MR_TYPE_SG_GAPS,
+	IB_MR_TYPE_DM,
+	IB_MR_TYPE_USER,
+	IB_MR_TYPE_DMA,
 };
 
 enum ib_mr_status_check {
@@ -1730,6 +1739,7 @@ struct ib_mr {
 	u64		   iova;
 	u64		   length;
 	unsigned int	   page_size;
+	enum ib_mr_type	   type;
 	bool		   need_inval;
 	union {
 		struct ib_uobject	*uobject;	/* user */
-- 
2.16.3

