Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664283F7233
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhHYJrv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 05:47:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8773 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbhHYJru (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Aug 2021 05:47:50 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gvh2G3V3MzYtHj;
        Wed, 25 Aug 2021 17:46:30 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:47:03 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:47:03 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Bugfix for incorrect association between dip_idx and dgid
Date:   Wed, 25 Aug 2021 17:43:12 +0800
Message-ID: <1629884592-23424-4-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629884592-23424-1-git-send-email-liangwenpeng@huawei.com>
References: <1629884592-23424-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Junxian Huang <huangjunxian4@hisilicon.com>

dip_idx and dgid should be a one-to-one mapping relationship, but when
qp_num loops back to the start number, it may happen that two different
dgid are assiociated to the same dip_idx incorrectly.

One solution is to store the qp_num that is not assigned to dip_idx in an
array. When a dip_idx needs to be allocated to a new dgid, an spare qp_num
is extracted and assigned to dip_idx.

Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")

Signed-off-by: Junxian Huang <huangjunxian4@hisilicon.com>
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  9 ++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  9 ++++++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  8 ++++++--
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 10 +++++++++-
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 2129da3..9467c39 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -496,6 +496,12 @@ struct hns_roce_bank {
 	u32 next; /* Next ID to allocate. */
 };
 
+struct hns_roce_idx_table {
+	u32 *spare_idx;
+	u32 head;
+	u32 tail;
+};
+
 struct hns_roce_qp_table {
 	struct hns_roce_hem_table	qp_table;
 	struct hns_roce_hem_table	irrl_table;
@@ -504,6 +510,7 @@ struct hns_roce_qp_table {
 	struct mutex			scc_mutex;
 	struct hns_roce_bank bank[HNS_ROCE_QP_BANK_NUM];
 	struct mutex bank_mutex;
+	struct hns_roce_idx_table	idx_table;
 };
 
 struct hns_roce_cq_table {
@@ -1144,7 +1151,7 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 void hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
-void hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
+int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1ad2a91..fcf67db 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4504,12 +4504,18 @@ static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 {
 	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	u32 *spare_idx = hr_dev->qp_table.idx_table.spare_idx;
+	u32 *head =  &hr_dev->qp_table.idx_table.head;
+	u32 *tail =  &hr_dev->qp_table.idx_table.tail;
 	struct hns_roce_dip *hr_dip;
 	unsigned long flags;
 	int ret = 0;
 
 	spin_lock_irqsave(&hr_dev->dip_list_lock, flags);
 
+	spare_idx[*tail] = ibqp->qp_num;
+	*tail = (*tail == hr_dev->caps.num_qps - 1) ? 0 : (*tail + 1);
+
 	list_for_each_entry(hr_dip, &hr_dev->dip_list, node) {
 		if (!memcmp(grh->dgid.raw, hr_dip->dgid, 16)) {
 			*dip_idx = hr_dip->dip_idx;
@@ -4527,7 +4533,8 @@ static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	}
 
 	memcpy(hr_dip->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
-	hr_dip->dip_idx = *dip_idx = ibqp->qp_num;
+	hr_dip->dip_idx = *dip_idx = spare_idx[*head];
+	*head = (*head == hr_dev->caps.num_qps - 1) ? 0 : (*head + 1);
 	list_add_tail(&hr_dip->node, &hr_dev->dip_list);
 
 out:
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 6467f8f..b409134 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -746,6 +746,12 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 		goto err_uar_table_free;
 	}
 
+	ret = hns_roce_init_qp_table(hr_dev);
+	if (ret) {
+		dev_err(dev, "Failed to init qp_table.\n");
+		goto err_uar_table_free;
+	}
+
 	hns_roce_init_pd_table(hr_dev);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
@@ -755,8 +761,6 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 
 	hns_roce_init_cq_table(hr_dev);
 
-	hns_roce_init_qp_table(hr_dev);
-
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
 		hns_roce_init_srq_table(hr_dev);
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index fd0f71a..0d0d5aa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1411,12 +1411,17 @@ bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, u32 nreq,
 	return cur + nreq >= hr_wq->wqe_cnt;
 }
 
-void hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
+int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 	unsigned int reserved_from_bot;
 	unsigned int i;
 
+	qp_table->idx_table.spare_idx = kcalloc(hr_dev->caps.num_qps,
+					sizeof(u32), GFP_KERNEL);
+	if (!qp_table->idx_table.spare_idx)
+		return -ENOMEM;
+
 	mutex_init(&qp_table->scc_mutex);
 	mutex_init(&qp_table->bank_mutex);
 	xa_init(&hr_dev->qp_table_xa);
@@ -1434,6 +1439,8 @@ void hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 					       HNS_ROCE_QP_BANK_NUM - 1;
 		hr_dev->qp_table.bank[i].next = hr_dev->qp_table.bank[i].min;
 	}
+
+	return 0;
 }
 
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
@@ -1442,4 +1449,5 @@ void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
 
 	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++)
 		ida_destroy(&hr_dev->qp_table.bank[i].ida);
+	kfree(hr_dev->qp_table.idx_table.spare_idx);
 }
-- 
2.8.1

