Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A377129EFF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2019 09:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfLXIdD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 03:33:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfLXIdD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Dec 2019 03:33:03 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 833B62E7F00952D3E518;
        Tue, 24 Dec 2019 16:33:01 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 16:32:53 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 5/5] RDMA/mlx5: use true,false for bool variable
Date:   Tue, 24 Dec 2019 16:40:12 +0800
Message-ID: <1577176812-2238-6-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
References: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes coccicheck warning:

drivers/infiniband/hw/mlx5/mr.c:150:2-26: WARNING: Assignment of 0/1 to bool variable
drivers/infiniband/hw/mlx5/mr.c:1455:2-26: WARNING: Assignment of 0/1 to bool variable
drivers/infiniband/hw/mlx5/qp.c:1874:6-20: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 4 ++--
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index ea8bfc3..3f6c177 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -147,7 +147,7 @@ static int add_keys(struct mlx5_ib_dev *dev, int c, int num)
 			break;
 		}
 		mr->order = ent->order;
-		mr->allocated_from_cache = 1;
+		mr->allocated_from_cache = true;
 		mr->dev = dev;

 		MLX5_SET(mkc, mkc, free, 1);
@@ -1452,7 +1452,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			goto err;
 		}

-		mr->allocated_from_cache = 0;
+		mr->allocated_from_cache = false;
 	} else {
 		/*
 		 * Send a UMR WQE
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 7e51870..04126ef 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1871,7 +1871,7 @@ static void configure_requester_scat_cqe(struct mlx5_ib_dev *dev,
 {
 	enum ib_qp_type qpt = init_attr->qp_type;
 	int scqe_sz;
-	bool allow_scat_cqe = 0;
+	bool allow_scat_cqe = false;

 	if (qpt == IB_QPT_UC || qpt == IB_QPT_UD)
 		return;
--
2.7.4

