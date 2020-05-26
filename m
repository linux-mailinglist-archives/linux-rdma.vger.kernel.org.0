Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7771DE79A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 15:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgEVNDk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 09:03:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729822AbgEVNDf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 May 2020 09:03:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D89583B66A40BE31DD48;
        Fri, 22 May 2020 21:03:26 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 22 May 2020 21:03:16 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/4] RDMA/hns: Remove redundant type cast for general pointers
Date:   Fri, 22 May 2020 21:02:56 +0800
Message-ID: <1590152579-32364-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1590152579-32364-1-git-send-email-liweihang@huawei.com>
References: <1590152579-32364-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to do a type cast on genernal pointers, they could be
assigned to any type of variables. In addition, optimize initialization
of some variables and adjust order of them.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 180 ++++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  28 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   2 +-
 3 files changed, 73 insertions(+), 137 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index b4b98e8..8ff6b92 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -503,16 +503,13 @@ static void hns_roce_set_odb(struct hns_roce_dev *hr_dev, u32 odb_alept,
 static void hns_roce_set_sdb_ext(struct hns_roce_dev *hr_dev, u32 ext_sdb_alept,
 				 u32 ext_sdb_alful)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_db_table *db = &priv->db_table;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_v1_priv *priv;
-	struct hns_roce_db_table *db;
 	dma_addr_t sdb_dma_addr;
 	__le32 tmp;
 	u32 val;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	db = &priv->db_table;
-
 	/* Configure extend SDB threshold */
 	roce_write(hr_dev, ROCEE_EXT_DB_SQ_WL_EMPTY_REG, ext_sdb_alept);
 	roce_write(hr_dev, ROCEE_EXT_DB_SQ_WL_REG, ext_sdb_alful);
@@ -545,16 +542,13 @@ static void hns_roce_set_sdb_ext(struct hns_roce_dev *hr_dev, u32 ext_sdb_alept,
 static void hns_roce_set_odb_ext(struct hns_roce_dev *hr_dev, u32 ext_odb_alept,
 				 u32 ext_odb_alful)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_db_table *db = &priv->db_table;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_v1_priv *priv;
-	struct hns_roce_db_table *db;
 	dma_addr_t odb_dma_addr;
 	__le32 tmp;
 	u32 val;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	db = &priv->db_table;
-
 	/* Configure extend ODB threshold */
 	roce_write(hr_dev, ROCEE_EXT_DB_OTHERS_WL_EMPTY_REG, ext_odb_alept);
 	roce_write(hr_dev, ROCEE_EXT_DB_OTHERS_WL_REG, ext_odb_alful);
@@ -583,16 +577,13 @@ static void hns_roce_set_odb_ext(struct hns_roce_dev *hr_dev, u32 ext_odb_alept,
 static int hns_roce_db_ext_init(struct hns_roce_dev *hr_dev, u32 sdb_ext_mod,
 				u32 odb_ext_mod)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_db_table *db = &priv->db_table;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_v1_priv *priv;
-	struct hns_roce_db_table *db;
 	dma_addr_t sdb_dma_addr;
 	dma_addr_t odb_dma_addr;
 	int ret = 0;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	db = &priv->db_table;
-
 	db->ext_db = kmalloc(sizeof(*db->ext_db), GFP_KERNEL);
 	if (!db->ext_db)
 		return -ENOMEM;
@@ -692,14 +683,14 @@ static struct hns_roce_qp *hns_roce_v1_create_lp_qp(struct hns_roce_dev *hr_dev,
 
 static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_free_mr *free_mr = &priv->free_mr;
 	struct hns_roce_caps *caps = &hr_dev->caps;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct device *dev = &hr_dev->pdev->dev;
 	struct ib_cq_init_attr cq_init_attr;
-	struct hns_roce_free_mr *free_mr;
 	struct ib_qp_attr attr = { 0 };
-	struct hns_roce_v1_priv *priv;
 	struct hns_roce_qp *hr_qp;
-	struct ib_device *ibdev;
 	struct ib_cq *cq;
 	struct ib_pd *pd;
 	union ib_gid dgid;
@@ -712,14 +703,10 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	u8 port = 0;
 	u8 sl;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	free_mr = &priv->free_mr;
-
 	/* Reserved cq for loop qp */
 	cq_init_attr.cqe		= HNS_ROCE_MIN_WQE_NUM * 2;
 	cq_init_attr.comp_vector	= 0;
 
-	ibdev = &hr_dev->ib_dev;
 	cq = rdma_zalloc_drv_obj(ibdev, ib_cq);
 	if (!cq)
 		return -ENOMEM;
@@ -868,16 +855,13 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 
 static void hns_roce_v1_release_lp_qp(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_free_mr *free_mr = &priv->free_mr;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_free_mr *free_mr;
-	struct hns_roce_v1_priv *priv;
 	struct hns_roce_qp *hr_qp;
 	int ret;
 	int i;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	free_mr = &priv->free_mr;
-
 	for (i = 0; i < HNS_ROCE_V1_RESV_QP; i++) {
 		hr_qp = free_mr->mr_free_qp[i];
 		if (!hr_qp)
@@ -897,18 +881,15 @@ static void hns_roce_v1_release_lp_qp(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_db_init(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_db_table *db = &priv->db_table;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_v1_priv *priv;
-	struct hns_roce_db_table *db;
 	u32 sdb_ext_mod;
 	u32 odb_ext_mod;
 	u32 sdb_evt_mod;
 	u32 odb_evt_mod;
 	int ret = 0;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	db = &priv->db_table;
-
 	memset(db, 0, sizeof(*db));
 
 	/* Default DB mode */
@@ -954,15 +935,12 @@ static void hns_roce_v1_recreate_lp_qp_work_fn(struct work_struct *work)
 
 static int hns_roce_v1_recreate_lp_qp(struct hns_roce_dev *hr_dev)
 {
-	struct device *dev = &hr_dev->pdev->dev;
+	long end = HNS_ROCE_V1_RECREATE_LP_QP_TIMEOUT_MSECS;
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_free_mr *free_mr = &priv->free_mr;
 	struct hns_roce_recreate_lp_qp_work *lp_qp_work;
-	struct hns_roce_free_mr *free_mr;
-	struct hns_roce_v1_priv *priv;
+	struct device *dev = &hr_dev->pdev->dev;
 	struct completion comp;
-	long end = HNS_ROCE_V1_RECREATE_LP_QP_TIMEOUT_MSECS;
-
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	free_mr = &priv->free_mr;
 
 	lp_qp_work = kzalloc(sizeof(struct hns_roce_recreate_lp_qp_work),
 			     GFP_KERNEL);
@@ -1021,29 +999,21 @@ static int hns_roce_v1_send_lp_wqe(struct hns_roce_qp *hr_qp)
 
 static void hns_roce_v1_mr_free_work_fn(struct work_struct *work)
 {
-	struct hns_roce_mr_free_work *mr_work;
-	struct ib_wc wc[HNS_ROCE_V1_RESV_QP];
-	struct hns_roce_free_mr *free_mr;
-	struct hns_roce_cq *mr_free_cq;
-	struct hns_roce_v1_priv *priv;
-	struct hns_roce_dev *hr_dev;
-	struct hns_roce_mr *hr_mr;
-	struct hns_roce_qp *hr_qp;
-	struct device *dev;
 	unsigned long end =
 		msecs_to_jiffies(HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS) + jiffies;
-	int i;
-	int ret;
+	struct hns_roce_mr_free_work *mr_work =
+		container_of(work, struct hns_roce_mr_free_work, work);
+	struct hns_roce_dev *hr_dev = to_hr_dev(mr_work->ib_dev);
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_free_mr *free_mr = &priv->free_mr;
+	struct hns_roce_cq *mr_free_cq = free_mr->mr_free_cq;
+	struct hns_roce_mr *hr_mr = mr_work->mr;
+	struct device *dev = &hr_dev->pdev->dev;
+	struct ib_wc wc[HNS_ROCE_V1_RESV_QP];
+	struct hns_roce_qp *hr_qp;
 	int ne = 0;
-
-	mr_work = container_of(work, struct hns_roce_mr_free_work, work);
-	hr_mr = (struct hns_roce_mr *)mr_work->mr;
-	hr_dev = to_hr_dev(mr_work->ib_dev);
-	dev = &hr_dev->pdev->dev;
-
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	free_mr = &priv->free_mr;
-	mr_free_cq = free_mr->mr_free_cq;
+	int ret;
+	int i;
 
 	for (i = 0; i < HNS_ROCE_V1_RESV_QP; i++) {
 		hr_qp = free_mr->mr_free_qp[i];
@@ -1092,18 +1062,15 @@ static void hns_roce_v1_mr_free_work_fn(struct work_struct *work)
 static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 				struct hns_roce_mr *mr, struct ib_udata *udata)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_free_mr *free_mr = &priv->free_mr;
+	long end = HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS;
 	struct device *dev = &hr_dev->pdev->dev;
 	struct hns_roce_mr_free_work *mr_work;
-	struct hns_roce_free_mr *free_mr;
-	struct hns_roce_v1_priv *priv;
-	struct completion comp;
-	long end = HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS;
 	unsigned long start = jiffies;
+	struct completion comp;
 	int ret = 0;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	free_mr = &priv->free_mr;
-
 	if (mr->enabled) {
 		if (hns_roce_hw_destroy_mpt(hr_dev, NULL,
 					    key_to_hw_index(mr->key) &
@@ -1155,12 +1122,9 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 
 static void hns_roce_db_free(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_db_table *db = &priv->db_table;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_v1_priv *priv;
-	struct hns_roce_db_table *db;
-
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	db = &priv->db_table;
 
 	if (db->sdb_ext_mod) {
 		dma_free_coherent(dev, HNS_ROCE_V1_EXT_SDB_SIZE,
@@ -1181,17 +1145,14 @@ static void hns_roce_db_free(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_raq_init(struct hns_roce_dev *hr_dev)
 {
-	int ret;
-	u32 val;
-	__le32 tmp;
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_raq_table *raq = raq = &priv->raq_table;
+	struct device *dev = &hr_dev->pdev->dev;
 	int raq_shift = 0;
 	dma_addr_t addr;
-	struct hns_roce_v1_priv *priv;
-	struct hns_roce_raq_table *raq;
-	struct device *dev = &hr_dev->pdev->dev;
-
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	raq = &priv->raq_table;
+	__le32 tmp;
+	u32 val;
+	int ret;
 
 	raq->e_raq_buf = kzalloc(sizeof(*(raq->e_raq_buf)), GFP_KERNEL);
 	if (!raq->e_raq_buf)
@@ -1271,12 +1232,9 @@ static int hns_roce_raq_init(struct hns_roce_dev *hr_dev)
 
 static void hns_roce_raq_free(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_raq_table *raq = &priv->raq_table;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_v1_priv *priv;
-	struct hns_roce_raq_table *raq;
-
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	raq = &priv->raq_table;
 
 	dma_free_coherent(dev, HNS_ROCE_V1_RAQ_SIZE, raq->e_raq_buf->buf,
 			  raq->e_raq_buf->map);
@@ -1310,12 +1268,10 @@ static void hns_roce_port_enable(struct hns_roce_dev *hr_dev, int enable_flag)
 
 static int hns_roce_bt_init(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_v1_priv *priv;
 	int ret;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-
 	priv->bt_table.qpc_buf.buf = dma_alloc_coherent(dev,
 		HNS_ROCE_BT_RSV_BUF_SIZE, &priv->bt_table.qpc_buf.map,
 		GFP_KERNEL);
@@ -1353,10 +1309,8 @@ static int hns_roce_bt_init(struct hns_roce_dev *hr_dev)
 
 static void hns_roce_bt_free(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_v1_priv *priv;
-
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
 
 	dma_free_coherent(dev, HNS_ROCE_BT_RSV_BUF_SIZE,
 		priv->bt_table.cqc_buf.buf, priv->bt_table.cqc_buf.map);
@@ -1370,12 +1324,9 @@ static void hns_roce_bt_free(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_tptr_init(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_buf_list *tptr_buf = &priv->tptr_table.tptr_buf;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_buf_list *tptr_buf;
-	struct hns_roce_v1_priv *priv;
-
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	tptr_buf = &priv->tptr_table.tptr_buf;
 
 	/*
 	 * This buffer will be used for CQ's tptr(tail pointer), also
@@ -1396,12 +1347,9 @@ static int hns_roce_tptr_init(struct hns_roce_dev *hr_dev)
 
 static void hns_roce_tptr_free(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_buf_list *tptr_buf = &priv->tptr_table.tptr_buf;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_buf_list *tptr_buf;
-	struct hns_roce_v1_priv *priv;
-
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	tptr_buf = &priv->tptr_table.tptr_buf;
 
 	dma_free_coherent(dev, HNS_ROCE_V1_TPTR_BUF_SIZE,
 			  tptr_buf->buf, tptr_buf->map);
@@ -1409,14 +1357,11 @@ static void hns_roce_tptr_free(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_free_mr_init(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_free_mr *free_mr = &priv->free_mr;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_free_mr *free_mr;
-	struct hns_roce_v1_priv *priv;
 	int ret = 0;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	free_mr = &priv->free_mr;
-
 	free_mr->free_mr_wq = create_singlethread_workqueue("hns_roce_free_mr");
 	if (!free_mr->free_mr_wq) {
 		dev_err(dev, "Create free mr workqueue failed!\n");
@@ -1435,11 +1380,8 @@ static int hns_roce_free_mr_init(struct hns_roce_dev *hr_dev)
 
 static void hns_roce_free_mr_free(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_free_mr *free_mr;
-	struct hns_roce_v1_priv *priv;
-
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	free_mr = &priv->free_mr;
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_free_mr *free_mr = &priv->free_mr;
 
 	flush_workqueue(free_mr->free_mr_wq);
 	destroy_workqueue(free_mr->free_mr_wq);
@@ -2050,16 +1992,12 @@ static void hns_roce_v1_write_cqc(struct hns_roce_dev *hr_dev,
 				  struct hns_roce_cq *hr_cq, void *mb_buf,
 				  u64 *mtts, dma_addr_t dma_handle)
 {
-	struct hns_roce_cq_context *cq_context = NULL;
-	struct hns_roce_buf_list *tptr_buf;
-	struct hns_roce_v1_priv *priv;
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
+	struct hns_roce_buf_list *tptr_buf = &priv->tptr_table.tptr_buf;
+	struct hns_roce_cq_context *cq_context = mb_buf;
 	dma_addr_t tptr_dma_addr;
 	int offset;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-	tptr_buf = &priv->tptr_table.tptr_buf;
-
-	cq_context = mb_buf;
 	memset(cq_context, 0, sizeof(*cq_context));
 
 	/* Get the tptr for this CQ. */
@@ -2400,16 +2338,14 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_hem_table *table, int obj,
 				 int step_idx)
 {
+	struct hns_roce_v1_priv *priv = hr_dev->priv;
 	struct device *dev = &hr_dev->pdev->dev;
-	struct hns_roce_v1_priv *priv;
-	unsigned long flags = 0;
 	long end = HW_SYNC_TIMEOUT_MSECS;
 	__le32 bt_cmd_val[2] = {0};
+	unsigned long flags = 0;
 	void __iomem *bt_cmd;
 	u64 bt_ba = 0;
 
-	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
-
 	switch (table->type) {
 	case HEM_TYPE_QPC:
 		bt_ba = priv->bt_table.qpc_buf.map >> 12;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d2c58d3..150df4e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -844,7 +844,7 @@ static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 					unsigned long instance_stage,
 					unsigned long reset_stage)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 
@@ -870,7 +870,7 @@ static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 
 static int hns_roce_v2_cmd_sw_resetting(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 
@@ -887,7 +887,7 @@ static int hns_roce_v2_cmd_sw_resetting(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_v2_rst_process_cmd(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 	unsigned long instance_stage;	/* the current instance stage */
@@ -967,7 +967,7 @@ static void hns_roce_free_cmq_desc(struct hns_roce_dev *hr_dev,
 
 static int hns_roce_init_cmq_ring(struct hns_roce_dev *hr_dev, bool ring_type)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_v2_cmq_ring *ring = (ring_type == TYPE_CSQ) ?
 					    &priv->cmq.csq : &priv->cmq.crq;
 
@@ -980,7 +980,7 @@ static int hns_roce_init_cmq_ring(struct hns_roce_dev *hr_dev, bool ring_type)
 
 static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_v2_cmq_ring *ring = (ring_type == TYPE_CSQ) ?
 					    &priv->cmq.csq : &priv->cmq.crq;
 	dma_addr_t dma = ring->desc_dma_addr;
@@ -1006,7 +1006,7 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 
 static int hns_roce_v2_cmq_init(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	int ret;
 
 	/* Setup the queue entries for command queue */
@@ -1050,7 +1050,7 @@ static int hns_roce_v2_cmq_init(struct hns_roce_dev *hr_dev)
 
 static void hns_roce_v2_cmq_exit(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
 	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.csq);
 	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.crq);
@@ -1072,15 +1072,15 @@ static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
 
 static int hns_roce_cmq_csq_done(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
 	u32 head = roce_read(hr_dev, ROCEE_TX_CMQ_HEAD_REG);
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
 	return head == priv->cmq.csq.next_to_use;
 }
 
 static int hns_roce_cmq_csq_clean(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
 	struct hns_roce_cmq_desc *desc;
 	u16 ntc = csq->next_to_clean;
@@ -1105,7 +1105,7 @@ static int hns_roce_cmq_csq_clean(struct hns_roce_dev *hr_dev)
 static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmq_desc *desc, int num)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
 	struct hns_roce_cmq_desc *desc_to_use;
 	bool complete = false;
@@ -1233,7 +1233,7 @@ static int hns_roce_cmq_query_hw_info(struct hns_roce_dev *hr_dev)
 
 static bool hns_roce_func_clr_chk_rst(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 	unsigned long reset_cnt;
@@ -1253,7 +1253,7 @@ static bool hns_roce_func_clr_chk_rst(struct hns_roce_dev *hr_dev)
 static void hns_roce_func_clr_rst_prc(struct hns_roce_dev *hr_dev, int retval,
 				      int flag)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 	unsigned long instance_stage;
@@ -6006,7 +6006,7 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 static void __hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 					   bool reset)
 {
-	struct hns_roce_dev *hr_dev = (struct hns_roce_dev *)handle->priv;
+	struct hns_roce_dev *hr_dev = handle->priv;
 
 	if (!hr_dev)
 		return;
@@ -6086,7 +6086,7 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 	handle->rinfo.reset_state = HNS_ROCE_STATE_RST_DOWN;
 	clear_bit(HNS_ROCE_RST_DIRECT_RETURN, &handle->rinfo.state);
 
-	hr_dev = (struct hns_roce_dev *)handle->priv;
+	hr_dev = handle->priv;
 	if (!hr_dev)
 		return 0;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 532dcf6..e176b0a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1979,7 +1979,7 @@ int hns_roce_v2_query_cqc_info(struct hns_roce_dev *hr_dev, u32 cqn,
 static inline void hns_roce_write64(struct hns_roce_dev *hr_dev, __le32 val[2],
 				    void __iomem *dest)
 {
-	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 
-- 
2.8.1

