Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21ED37B79B
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 10:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhELINk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 04:13:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2640 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhELINj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 04:13:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg6rM3t7XzQmKL;
        Wed, 12 May 2021 16:09:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 16:12:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Weihang Li" <liweihang@huawei.com>
Subject: [PATCH for-next 4/4] RDMA/rxe: Remove unused parameter udata
Date:   Wed, 12 May 2021 16:12:22 +0800
Message-ID: <1620807142-39157-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
References: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The old version of ib_umem_get() need these udata as a parameter but now
they are unnecessary.

Fixes: c320e527e154 ("IB: Allow calls to ib_umem_get from kernel ULPs")
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   | 2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index ef8061d..b21038c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -79,7 +79,7 @@ enum copy_direction {
 void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
 
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
-		     int access, struct ib_udata *udata, struct rxe_mr *mr);
+		     int access, struct rxe_mr *mr);
 
 int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 9f63947..373b46aa 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -121,7 +121,7 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 }
 
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
-		     int access, struct ib_udata *udata, struct rxe_mr *mr)
+		     int access, struct rxe_mr *mr)
 {
 	struct rxe_map		**map;
 	struct rxe_phys_buf	*buf = NULL;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index aeb5e23..86a0965 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -899,7 +899,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	rxe_add_ref(pd);
 
-	err = rxe_mr_init_user(pd, start, length, iova, access, udata, mr);
+	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
 	if (err)
 		goto err3;
 
-- 
2.7.4

