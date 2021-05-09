Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51417377609
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 11:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhEIJhP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 05:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhEIJhO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 May 2021 05:37:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3E15613E8;
        Sun,  9 May 2021 09:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620552971;
        bh=NNn0uJEsZRFXR91wj8X+mBzYJYdBKTNqyz0ZDY48sZE=;
        h=From:To:Cc:Subject:Date:From;
        b=PTg09FbxXkngNkg7rOTjgpCGYSAr7fjUTWeXdoSfBY4WqrR8nayX9vAvcDf8CHqpI
         4RshxrJ6I+hJxwNr6AJyYMH8GBbnNAVqq74CFpyLh6dc2Xv/Y1l71mORdMVrSHxNBX
         UOY0uqpDdnOyDJnCHI/wHoUv84SuJ3hr1v33/QxQPATjFtTbX793kHCNVZBJDs5Cui
         QPHvMF2AXdjTOw3Pj9nPnf06xVkicqW/L/8kS513fpMWhyRkk0bkNpzhSmwFQPq8RE
         2zf3VoxY0azZkRJIitYpvgpxVU7zPYdTyUWYxZSV71Bo1Qh+i7rLldTXYkzB1E4At4
         aWM4zTgL2uH9Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Remove never used ib_modify_wq function call
Date:   Sun,  9 May 2021 12:36:06 +0300
Message-Id: <c5e48d517b9163fe4f9ffd224050b83fdb3571c6.1620552935.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The function ib_modify_wq() is not used, so remove it.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 21 ---------------------
 include/rdma/ib_verbs.h         |  2 --
 2 files changed, 23 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 2b0798151fb7..a2dfe2d3a3c6 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2445,27 +2445,6 @@ int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata)
 }
 EXPORT_SYMBOL(ib_destroy_wq_user);
 
-/**
- * ib_modify_wq - Modifies the specified WQ.
- * @wq: The WQ to modify.
- * @wq_attr: On input, specifies the WQ attributes to modify.
- * @wq_attr_mask: A bit-mask used to specify which attributes of the WQ
- *   are being modified.
- * On output, the current values of selected WQ attributes are returned.
- */
-int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
-		 u32 wq_attr_mask)
-{
-	int err;
-
-	if (!wq->device->ops.modify_wq)
-		return -EOPNOTSUPP;
-
-	err = wq->device->ops.modify_wq(wq, wq_attr, wq_attr_mask, NULL);
-	return err;
-}
-EXPORT_SYMBOL(ib_modify_wq);
-
 int ib_check_mr_status(struct ib_mr *mr, u32 check_mask,
 		       struct ib_mr_status *mr_status)
 {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index fc82fd24eddc..5473dd4e56f2 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4286,8 +4286,6 @@ struct net_device *ib_device_netdev(struct ib_device *dev, u32 port);
 struct ib_wq *ib_create_wq(struct ib_pd *pd,
 			   struct ib_wq_init_attr *init_attr);
 int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
-int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *attr,
-		 u32 wq_attr_mask);
 
 int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
 		 unsigned int *sg_offset, unsigned int page_size);
-- 
2.31.1

