Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F672D5C95
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 14:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgLJN6Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 08:58:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9499 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389759AbgLJN6T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 08:58:19 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsFnD2v4jzhq75;
        Thu, 10 Dec 2020 21:56:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:56:27 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 08/11] RDMA/hns: Clear redundant variable initialization
Date:   Thu, 10 Dec 2020 21:54:36 +0800
Message-ID: <1607608479-54518-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607608479-54518-1-git-send-email-liweihang@huawei.com>
References: <1607608479-54518-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xinhao Liu <liuxinhao5@hisilicon.com>

There is no need to initialize some variable because they will be assigned
with a value later.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c   | 2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 303c8dd..f19bbcc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -887,7 +887,7 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 		unsigned long buf_chunk_size;
 		unsigned long bt_chunk_size;
 		unsigned long bt_chunk_num;
-		unsigned long num_bt_l0 = 0;
+		unsigned long num_bt_l0;
 		u32 hop_num;
 
 		if (get_hem_table_config(hr_dev, &mhop, type))
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index eb0fd72..0f4273d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -353,8 +353,8 @@ static int hns_roce_v1_post_recv(struct ib_qp *ibqp,
 	unsigned long flags = 0;
 	unsigned int wqe_idx;
 	int ret = 0;
-	int nreq = 0;
-	int i = 0;
+	int nreq;
+	int i;
 	u32 reg_val;
 
 	spin_lock_irqsave(&hr_qp->rq.lock, flags);
@@ -2300,7 +2300,7 @@ int hns_roce_v1_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	struct hns_roce_qp *cur_qp = NULL;
 	unsigned long flags;
 	int npolled;
-	int ret = 0;
+	int ret;
 
 	spin_lock_irqsave(&hr_cq->lock, flags);
 
@@ -4123,7 +4123,7 @@ static int hns_roce_v1_create_eq(struct hns_roce_dev *hr_dev,
 	void __iomem *eqc = hr_dev->eq_table.eqc_base[eq->eqn];
 	struct device *dev = &hr_dev->pdev->dev;
 	dma_addr_t tmp_dma_addr;
-	u32 eqcuridx_val = 0;
+	u32 eqcuridx_val;
 	u32 eqconsindx_val;
 	u32 eqshift_val;
 	__le32 tmp2 = 0;
-- 
2.8.1

