Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE781EFBAC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 11:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfKEKno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 05:43:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388203AbfKEKno (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 05:43:44 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 29499C34EB5828C8AFE0;
        Tue,  5 Nov 2019 18:43:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 18:43:30 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 9/9] {topost} RDMA/hns: Modify appropriate printings
Date:   Tue, 5 Nov 2019 18:39:54 +0800
Message-ID: <1572950394-42910-10-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
References: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Modify some printings that is not in uniformed style, non-standard or with
spelling errors.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c   | 20 ++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_main.c |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c  |  8 ++++----
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 699c987..e25fa19 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -105,32 +105,34 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev, int nent,
 	mtts = hns_roce_table_find(hr_dev, mtt_table,
 				   hr_mtt->first_seg, &dma_handle);
 	if (!mtts) {
-		dev_err(dev, "CQ alloc.Failed to find cq buf addr.\n");
+		dev_err(dev, "Failed to find mtt for CQ buf.\n");
 		return -EINVAL;
 	}
 
 	if (vector >= hr_dev->caps.num_comp_vectors) {
-		dev_err(dev, "CQ alloc.Invalid vector.\n");
+		dev_err(dev, "Invalid vector(0x%x) for CQ alloc.\n", vector);
 		return -EINVAL;
 	}
 	hr_cq->vector = vector;
 
 	ret = hns_roce_bitmap_alloc(&cq_table->bitmap, &hr_cq->cqn);
 	if (ret) {
-		dev_err(dev, "CQ alloc.Failed to alloc index.\n");
+		dev_err(dev, "Num of CQ out of range.\n");
 		return ret;
 	}
 
 	/* Get CQC memory HEM(Hardware Entry Memory) table */
 	ret = hns_roce_table_get(hr_dev, &cq_table->table, hr_cq->cqn);
 	if (ret) {
-		dev_err(dev, "CQ alloc.Failed to get context mem.\n");
+		dev_err(dev,
+			"Get context mem failed(%d) when CQ(0x%lx) alloc.\n",
+			ret, hr_cq->cqn);
 		goto err_out;
 	}
 
 	ret = xa_err(xa_store(&cq_table->array, hr_cq->cqn, hr_cq, GFP_KERNEL));
 	if (ret) {
-		dev_err(dev, "CQ alloc failed xa_store.\n");
+		dev_err(dev, "Failed to xa_store CQ.\n");
 		goto err_put;
 	}
 
@@ -148,7 +150,9 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev, int nent,
 	ret = hns_roce_hw_create_cq(hr_dev, mailbox, hr_cq->cqn);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret) {
-		dev_err(dev, "CQ alloc.Failed to cmd mailbox.\n");
+		dev_err(dev,
+			"Send cmd mailbox failed(%d) when CQ(0x%lx) alloc.\n",
+			ret, hr_cq->cqn);
 		goto err_xa;
 	}
 
@@ -418,7 +422,7 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	int ret;
 
 	if (cq_entries < 1 || cq_entries > hr_dev->caps.max_cqes) {
-		dev_err(dev, "Creat CQ failed. entries=%d, max=%d\n",
+		dev_err(dev, "Create CQ failed. entries=%d, max=%d\n",
 			cq_entries, hr_dev->caps.max_cqes);
 		return -EINVAL;
 	}
@@ -448,7 +452,7 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	ret = hns_roce_cq_alloc(hr_dev, cq_entries, &hr_cq->hr_buf.hr_mtt,
 				hr_cq, vector);
 	if (ret) {
-		dev_err(dev, "Creat CQ .Failed to cq_alloc.\n");
+		dev_err(dev, "Alloc CQ failed(%d).\n", ret);
 		goto err_dbmap;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b5d196c..b9200d53 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -111,7 +111,7 @@ static int handle_en_event(struct hns_roce_dev *hr_dev, u8 port,
 
 	netdev = hr_dev->iboe.netdevs[port];
 	if (!netdev) {
-		dev_err(dev, "port(%d) can't find netdev\n", port);
+		dev_err(dev, "Can't find netdev on port(%u)!\n", port);
 		return -ENODEV;
 	}
 
@@ -253,7 +253,7 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u8 port_num,
 	net_dev = hr_dev->iboe.netdevs[port];
 	if (!net_dev) {
 		spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
-		dev_err(dev, "find netdev %d failed!\r\n", port);
+		dev_err(dev, "Find netdev %u failed!\n", port);
 		return -EINVAL;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index ecfa875..b0e5e8b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1029,7 +1029,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, 0,
 						hr_qp);
 		if (ret) {
-			ibdev_err(ibdev, "Create RC QP 0x%06lx failed(%d)\n",
+			ibdev_err(ibdev, "Create QP 0x%06lx failed(%d)\n",
 				  hr_qp->qpn, ret);
 			kfree(hr_qp);
 			return ERR_PTR(ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 96ff782..a1bfa51 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -95,8 +95,7 @@ static int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn,
 				       srq->mtt.first_seg,
 				       &dma_handle_wqe);
 	if (!mtts_wqe) {
-		dev_err(hr_dev->dev,
-			"SRQ alloc.Failed to find srq buf addr.\n");
+		dev_err(hr_dev->dev, "Failed to find mtt for srq buf.\n");
 		return -EINVAL;
 	}
 
@@ -106,13 +105,14 @@ static int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn,
 				       &dma_handle_idx);
 	if (!mtts_idx) {
 		dev_err(hr_dev->dev,
-			"SRQ alloc.Failed to find idx que buf addr.\n");
+			"Failed to find mtt for srq idx queue buf.\n");
 		return -EINVAL;
 	}
 
 	ret = hns_roce_bitmap_alloc(&srq_table->bitmap, &srq->srqn);
 	if (ret) {
-		dev_err(hr_dev->dev, "SRQ alloc.Failed to alloc index.\n");
+		dev_err(hr_dev->dev,
+			"Failed to alloc a bit from srq bitmap.\n");
 		return -ENOMEM;
 	}
 
-- 
2.8.1

