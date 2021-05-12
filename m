Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6857E37B798
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhELINj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 04:13:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2638 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhELINi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 04:13:38 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg6rM3BYYzQmH5;
        Wed, 12 May 2021 16:09:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 16:12:23 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "Weihang Li" <liweihang@huawei.com>
Subject: [PATCH for-next 2/4] RDMA/mlx4: Remove unused parameter udata
Date:   Wed, 12 May 2021 16:12:20 +0800
Message-ID: <1620807142-39157-3-git-send-email-liweihang@huawei.com>
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
Cc: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/mlx4/cq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index e9b5a4d..4cd738a 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -135,7 +135,7 @@ static void mlx4_ib_free_cq_buf(struct mlx4_ib_dev *dev, struct mlx4_ib_cq_buf *
 	mlx4_buf_free(dev->dev, (cqe + 1) * buf->entry_size, &buf->buf);
 }
 
-static int mlx4_ib_get_cq_umem(struct mlx4_ib_dev *dev, struct ib_udata *udata,
+static int mlx4_ib_get_cq_umem(struct mlx4_ib_dev *dev,
 			       struct mlx4_ib_cq_buf *buf,
 			       struct ib_umem **umem, u64 buf_addr, int cqe)
 {
@@ -210,7 +210,7 @@ int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		}
 
 		buf_addr = (void *)(unsigned long)ucmd.buf_addr;
-		err = mlx4_ib_get_cq_umem(dev, udata, &cq->buf, &cq->umem,
+		err = mlx4_ib_get_cq_umem(dev, &cq->buf, &cq->umem,
 					  ucmd.buf_addr, entries);
 		if (err)
 			goto err_cq;
@@ -327,8 +327,8 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 	if (!cq->resize_buf)
 		return -ENOMEM;
 
-	err = mlx4_ib_get_cq_umem(dev, udata, &cq->resize_buf->buf,
-				  &cq->resize_umem, ucmd.buf_addr, entries);
+	err = mlx4_ib_get_cq_umem(dev, &cq->resize_buf->buf, &cq->resize_umem,
+				  ucmd.buf_addr, entries);
 	if (err) {
 		kfree(cq->resize_buf);
 		cq->resize_buf = NULL;
-- 
2.7.4

