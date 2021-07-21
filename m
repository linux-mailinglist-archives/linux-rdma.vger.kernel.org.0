Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815813D08B2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhGUFdU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 01:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232710AbhGUFcl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 01:32:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08F2161007;
        Wed, 21 Jul 2021 06:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626847998;
        bh=tbn33wjjVuiv3kzeE4HsxsCHrdDaV9aipcwfnmjZej8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5uajfH+gfdLy2jcXsvVGBpH44/P+ViHDxQqEubl6BLMHGMCnHqmu7Qc2KxSyUgDt
         G59pu1TYVsMFQpGI89pf9391OpRHJzRGgp0UMjYT9ZJYKwpBwMHOgnUc02m+LCiFfX
         lNsdD4zjcOhRNoZA93HHVt5Tn7NtXoLxjAXCsk+b3Vb51ZKYpLVvJoxCycS8f2/++Y
         xuGD/bN8SuQBLI6eMZ/6tDojw8S9HsSDwKaQCGvjO2GxlElPjVepxzq7NbOudWSCtb
         J8Jc8g0N3BMTMrfCEGZFqZduHCdAi5S7wof5Hg0f3bo3SMUBbp3gflP1heHf3aGkIR
         uUXvQqih8MbJw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 3/7] RDMA/core: Remove protection from wrong in-kernel API usage
Date:   Wed, 21 Jul 2021 09:13:02 +0300
Message-Id: <8084238e374fe487c3f9728c2ee5ec8736c204d5.1626846795.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626846795.git.leonro@nvidia.com>
References: <cover.1626846795.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The ib_create_named_qp() is kernel verb that is not used for user
supplied attributes. In such case, it is ULP responsibility to provide
valid QP attributes.

In-kernel API shouldn't check it, exactly like other functions that
don't check device capabilities.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 635642a3ecbc..2090f3c9f689 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1219,16 +1219,6 @@ struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
 	struct ib_qp *qp;
 	int ret;
 
-	if (qp_init_attr->rwq_ind_tbl &&
-	    (qp_init_attr->recv_cq ||
-	    qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
-	    qp_init_attr->cap.max_recv_sge))
-		return ERR_PTR(-EINVAL);
-
-	if ((qp_init_attr->create_flags & IB_QP_CREATE_INTEGRITY_EN) &&
-	    !(device->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER))
-		return ERR_PTR(-EINVAL);
-
 	/*
 	 * If the callers is using the RDMA API calculate the resources
 	 * needed for the RDMA READ/WRITE operations.
-- 
2.31.1

