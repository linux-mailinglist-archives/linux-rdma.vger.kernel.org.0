Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A6260BA4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgIHHQb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 03:16:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728479AbgIHHQa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 03:16:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BA239FE7E1C798FD10FB;
        Tue,  8 Sep 2020 15:16:26 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Sep 2020 15:16:22 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH for-next] RDMA/hns: Avoid unncessary initialization
Date:   Tue, 8 Sep 2020 14:52:24 +0800
Message-ID: <1599547944-30671-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some variables have been initialized when used. As a result,
here removes some unncessary initial assignment.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c   |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 30 +++++++++++++++---------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c  |  5 +++--
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 +-
 6 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index c8db6f8..0336282 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -338,8 +338,8 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 	void __iomem *bt_cmd;
 	__le32 bt_cmd_val[2];
 	__le32 bt_cmd_h = 0;
-	__le32 bt_cmd_l = 0;
-	u64 bt_ba = 0;
+	__le32 bt_cmd_l;
+	u64 bt_ba;
 	int ret = 0;
 
 	/* Find the HEM(Hardware Entry Memory) entry */
@@ -1404,7 +1404,7 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
-	int ret = 0;
+	int ret;
 	int unit;
 	int i;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index aeb3a6f..7e4b63c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -70,15 +70,15 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
 	struct device *dev = &hr_dev->pdev->dev;
 	struct hns_roce_sq_db sq_db = {};
-	int ps_opcode = 0, i = 0;
+	int ps_opcode, i;
 	unsigned long flags = 0;
 	void *wqe = NULL;
 	__le32 doorbell[2];
-	u32 wqe_idx = 0;
-	int nreq = 0;
 	int ret = 0;
-	u8 *smac;
 	int loopback;
+	u32 wqe_idx;
+	int nreq;
+	u8 *smac;
 
 	if (unlikely(ibqp->qp_type != IB_QPT_GSI &&
 		ibqp->qp_type != IB_QPT_RC)) {
@@ -888,7 +888,7 @@ static int hns_roce_db_init(struct hns_roce_dev *hr_dev)
 	u32 odb_ext_mod;
 	u32 sdb_evt_mod;
 	u32 odb_evt_mod;
-	int ret = 0;
+	int ret;
 
 	memset(db, 0, sizeof(*db));
 
@@ -1148,8 +1148,8 @@ static int hns_roce_raq_init(struct hns_roce_dev *hr_dev)
 	struct hns_roce_v1_priv *priv = hr_dev->priv;
 	struct hns_roce_raq_table *raq = &priv->raq_table;
 	struct device *dev = &hr_dev->pdev->dev;
-	int raq_shift = 0;
 	dma_addr_t addr;
+	int raq_shift;
 	__le32 tmp;
 	u32 val;
 	int ret;
@@ -1360,7 +1360,7 @@ static int hns_roce_free_mr_init(struct hns_roce_dev *hr_dev)
 	struct hns_roce_v1_priv *priv = hr_dev->priv;
 	struct hns_roce_free_mr *free_mr = &priv->free_mr;
 	struct device *dev = &hr_dev->pdev->dev;
-	int ret = 0;
+	int ret;
 
 	free_mr->free_mr_wq = create_singlethread_workqueue("hns_roce_free_mr");
 	if (!free_mr->free_mr_wq) {
@@ -1440,8 +1440,8 @@ static int hns_roce_v1_reset(struct hns_roce_dev *hr_dev, bool dereset)
 
 static int hns_roce_v1_profile(struct hns_roce_dev *hr_dev)
 {
-	int i = 0;
 	struct hns_roce_caps *caps = &hr_dev->caps;
+	int i;
 
 	hr_dev->vendor_id = roce_read(hr_dev, ROCEE_VENDOR_ID_REG);
 	hr_dev->vendor_part_id = roce_read(hr_dev, ROCEE_VENDOR_PART_ID_REG);
@@ -1643,7 +1643,7 @@ static int hns_roce_v1_chk_mbox(struct hns_roce_dev *hr_dev,
 				unsigned long timeout)
 {
 	u8 __iomem *hcr = hr_dev->reg_base + ROCEE_MB1_REG;
-	unsigned long end = 0;
+	unsigned long end;
 	u32 status = 0;
 
 	end = msecs_to_jiffies(timeout) + jiffies;
@@ -1671,7 +1671,7 @@ static int hns_roce_v1_set_gid(struct hns_roce_dev *hr_dev, u8 port,
 {
 	unsigned long flags;
 	u32 *p = NULL;
-	u8 gid_idx = 0;
+	u8 gid_idx;
 
 	gid_idx = hns_get_gid_index(hr_dev, port, gid_index);
 
@@ -2445,7 +2445,7 @@ static int hns_roce_v1_qp_modify(struct hns_roce_dev *hr_dev,
 
 	struct hns_roce_cmd_mailbox *mailbox;
 	struct device *dev = &hr_dev->pdev->dev;
-	int ret = 0;
+	int ret;
 
 	if (cur_state >= HNS_ROCE_QP_NUM_STATE ||
 	    new_state >= HNS_ROCE_QP_NUM_STATE ||
@@ -3394,7 +3394,7 @@ static int hns_roce_v1_q_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct device *dev = &hr_dev->pdev->dev;
 	struct hns_roce_qp_context *context;
-	int tmp_qp_state = 0;
+	int tmp_qp_state;
 	int ret = 0;
 	int state;
 
@@ -3934,7 +3934,7 @@ static irqreturn_t hns_roce_v1_msix_interrupt_eq(int irq, void *eq_ptr)
 {
 	struct hns_roce_eq  *eq  = eq_ptr;
 	struct hns_roce_dev *hr_dev = eq->hr_dev;
-	int int_work = 0;
+	int int_work;
 
 	if (eq->type_flag == HNS_ROCE_CEQ)
 		/* CEQ irq routine, CEQ is pulse irq, not clear */
@@ -4132,9 +4132,9 @@ static int hns_roce_v1_create_eq(struct hns_roce_dev *hr_dev,
 	void __iomem *eqc = hr_dev->eq_table.eqc_base[eq->eqn];
 	struct device *dev = &hr_dev->pdev->dev;
 	dma_addr_t tmp_dma_addr;
-	u32 eqconsindx_val = 0;
 	u32 eqcuridx_val = 0;
-	u32 eqshift_val = 0;
+	u32 eqconsindx_val;
+	u32 eqshift_val;
 	__le32 tmp2 = 0;
 	__le32 tmp1 = 0;
 	__le32 tmp = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 96e08b4..3966262 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5383,7 +5383,7 @@ static irqreturn_t hns_roce_v2_msix_interrupt_eq(int irq, void *eq_ptr)
 {
 	struct hns_roce_eq *eq = eq_ptr;
 	struct hns_roce_dev *hr_dev = eq->hr_dev;
-	int int_work = 0;
+	int int_work;
 
 	if (eq->type_flag == HNS_ROCE_CEQ)
 		/* Completion event interrupt */
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 5907cfd..e85fc90 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -141,8 +141,8 @@ static int hns_roce_netdev_event(struct notifier_block *self,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct hns_roce_ib_iboe *iboe = NULL;
 	struct hns_roce_dev *hr_dev = NULL;
-	u8 port = 0;
-	int ret = 0;
+	int ret;
+	u8 port;
 
 	hr_dev = container_of(self, struct hns_roce_dev, iboe.nb);
 	iboe = &hr_dev->iboe;
@@ -817,6 +817,7 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev)
 	struct list_head cq_list;
 	unsigned long flags_qp;
 	unsigned long flags;
+	int num;
 
 	INIT_LIST_HEAD(&cq_list);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index e5df388..2628ba5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -773,7 +773,7 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	size_t direct_size;
 	size_t total_size;
 	unsigned long tmp;
-	int ret = 0;
+	int ret;
 
 	total_size = mtr_bufs_size(buf_attr);
 	if (total_size < 1) {
@@ -967,7 +967,7 @@ static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
 			    unsigned int *buf_page_shift)
 {
 	struct hns_roce_buf_region *r;
-	unsigned int page_shift = 0;
+	unsigned int page_shift;
 	int page_cnt = 0;
 	size_t buf_size;
 	int region_cnt;
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index b9e2dbd..686b0c8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -285,7 +285,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	struct hns_roce_srq *srq = to_hr_srq(ib_srq);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_ib_create_srq ucmd = {};
-	int ret = 0;
+	int ret;
 	u32 cqn;
 
 	/* Check the actual SRQ wqe and SRQ sge num */
-- 
1.9.1

