Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82739164B2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEGNin (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:38:43 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40240 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726428AbfEGNin (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:38:43 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:40 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdF2021865;
        Tue, 7 May 2019 16:38:39 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 02/25] RDMA/core: Save the MR type in the ib_mr structure
Date:   Tue,  7 May 2019 16:38:16 +0300
Message-Id: <1557236319-9986-3-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
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
index 062a86c04123..095d714b9c1c 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -744,6 +744,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 
 	mr->device  = pd->device;
 	mr->pd      = pd;
+	mr->type    = IB_MR_TYPE_USER;
 	mr->dm	    = NULL;
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 4d4be0c2b752..730a5aa40458 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -125,6 +125,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 
 	mr->device  = pd->device;
 	mr->pd      = pd;
+	mr->type    = IB_MR_TYPE_DM;
 	mr->dm      = dm;
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 5a5e83f5f0fc..412d3aa2ed74 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -297,6 +297,7 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 
 		mr->device	= pd->device;
 		mr->pd		= pd;
+		mr->type        = IB_MR_TYPE_DMA;
 		mr->uobject	= NULL;
 		mr->need_inval	= false;
 
@@ -2001,6 +2002,7 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd,
 		mr->need_inval = false;
 		mr->res.type = RDMA_RESTRACK_MR;
 		rdma_restrack_kadd(&mr->res);
+		mr->type = mr_type;
 	}
 
 	return mr;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index fb532c634e91..535daa61c404 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -759,11 +759,20 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate);
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
@@ -1696,6 +1705,7 @@ struct ib_mr {
 	u64		   iova;
 	u64		   length;
 	unsigned int	   page_size;
+	enum ib_mr_type	   type;
 	bool		   need_inval;
 	union {
 		struct ib_uobject	*uobject;	/* user */
-- 
2.16.3

