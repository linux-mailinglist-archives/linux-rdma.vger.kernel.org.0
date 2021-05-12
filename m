Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0FA37B7B0
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhELIRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 04:17:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2454 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhELIRa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 04:17:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg6xc15blzCrb1;
        Wed, 12 May 2021 16:13:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 16:16:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 1/2] RDMA/hns: Refactor extend link table allocation
Date:   Wed, 12 May 2021 16:16:09 +0800
Message-ID: <1620807370-9409-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620807370-9409-1-git-send-email-liweihang@huawei.com>
References: <1620807370-9409-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Simplify the buffer allocation for link table to make the code more
readable.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 194 +++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  64 +++-------
 2 files changed, 110 insertions(+), 148 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 49bb4f5..a3f7dc5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2482,15 +2482,16 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 				      enum hns_roce_link_table_type type)
 {
 	struct hns_roce_cmq_desc desc[2];
-	struct hns_roce_cfg_llm_a *req_a =
-				(struct hns_roce_cfg_llm_a *)desc[0].data;
-	struct hns_roce_cfg_llm_b *req_b =
-				(struct hns_roce_cfg_llm_b *)desc[1].data;
+	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
+	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_link_table *link_tbl;
-	struct hns_roce_link_table_entry *entry;
 	enum hns_roce_opcode_type opcode;
-	u32 page_num;
+	u32 i, next_ptr, page_num;
+	struct hns_roce_buf *buf;
+	dma_addr_t addr;
+	__le64 *entry;
+	u64 val;
 
 	switch (type) {
 	case TSQ_LINK_TABLE:
@@ -2505,36 +2506,44 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 		return -EINVAL;
 	}
 
-	page_num = link_tbl->npages;
+	/* Setup data table block address to link table entry */
+	buf = link_tbl->buf;
+	page_num = buf->npages;
+	if (WARN_ON(page_num > HNS_ROCE_V2_EXT_LLM_MAX_DEPTH))
+		return -EINVAL;
+
 	entry = link_tbl->table.buf;
+	for (i = 0; i < page_num; i++) {
+		addr = hns_roce_buf_page(buf, i);
+		if (i == (page_num - 1))
+			next_ptr = 0;
+		else
+			next_ptr = i + 1;
+
+		val = HNS_ROCE_EXT_LLM_ENTRY(addr, (u64)next_ptr);
+		entry[i] = cpu_to_le64(val);
+	}
 
 	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, false);
 	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-
 	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, false);
 
-	req_a->base_addr_l = cpu_to_le32(link_tbl->table.map & 0xffffffff);
-	req_a->base_addr_h = cpu_to_le32(link_tbl->table.map >> 32);
-	roce_set_field(req_a->depth_pgsz_init_en, CFG_LLM_QUE_DEPTH_M,
-		       CFG_LLM_QUE_DEPTH_S, link_tbl->npages);
-	roce_set_field(req_a->depth_pgsz_init_en, CFG_LLM_QUE_PGSZ_M,
-		       CFG_LLM_QUE_PGSZ_S, link_tbl->pg_sz);
-	roce_set_field(req_a->depth_pgsz_init_en, CFG_LLM_INIT_EN_M,
-		       CFG_LLM_INIT_EN_S, 1);
-	req_a->head_ba_l = cpu_to_le32(entry[0].blk_ba0);
-	req_a->head_ba_h_nxtptr = cpu_to_le32(entry[0].blk_ba1_nxt_ptr);
-	roce_set_field(req_a->head_ptr, CFG_LLM_HEAD_PTR_M, CFG_LLM_HEAD_PTR_S,
-		       0);
+	hr_reg_write(r_a, CFG_LLM_A_BA_L, lower_32_bits(link_tbl->table.map));
+	hr_reg_write(r_a, CFG_LLM_A_BA_H, upper_32_bits(link_tbl->table.map));
+	hr_reg_write(r_a, CFG_LLM_A_DEPTH, buf->npages);
+	hr_reg_write(r_a, CFG_LLM_A_PGSZ, to_hr_hw_page_shift(buf->page_shift));
+	hr_reg_enable(r_a, CFG_LLM_A_INIT_EN);
 
-	req_b->tail_ba_l = cpu_to_le32(entry[page_num - 1].blk_ba0);
-	roce_set_field(req_b->tail_ba_h, CFG_LLM_TAIL_BA_H_M,
-		       CFG_LLM_TAIL_BA_H_S,
-		       entry[page_num - 1].blk_ba1_nxt_ptr &
-		       HNS_ROCE_LINK_TABLE_BA1_M);
-	roce_set_field(req_b->tail_ptr, CFG_LLM_TAIL_PTR_M, CFG_LLM_TAIL_PTR_S,
-		       (entry[page_num - 2].blk_ba1_nxt_ptr &
-			HNS_ROCE_LINK_TABLE_NXT_PTR_M) >>
-			HNS_ROCE_LINK_TABLE_NXT_PTR_S);
+	addr = to_hr_hw_page_addr(hns_roce_buf_page(buf, 0));
+	hr_reg_write(r_a, CFG_LLM_A_HEAD_BA_L, lower_32_bits(addr));
+	hr_reg_write(r_a, CFG_LLM_A_HEAD_BA_H, upper_32_bits(addr));
+	hr_reg_write(r_a, CFG_LLM_A_HEAD_NXTPTR, 1);
+	hr_reg_write(r_a, CFG_LLM_A_HEAD_PTR, 0);
+
+	addr = to_hr_hw_page_addr(hns_roce_buf_page(buf, page_num - 1));
+	hr_reg_write(r_b, CFG_LLM_B_TAIL_BA_L, lower_32_bits(addr));
+	hr_reg_write(r_b, CFG_LLM_B_TAIL_BA_H, upper_32_bits(addr));
+	hr_reg_write(r_b, CFG_LLM_B_TAIL_PTR, buf->npages - 1);
 
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
@@ -2544,102 +2553,82 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_link_table *link_tbl;
-	struct hns_roce_link_table_entry *entry;
-	struct device *dev = hr_dev->dev;
-	u32 buf_chk_sz;
-	dma_addr_t t;
-	int func_num = 1;
-	u32 pg_num_a;
-	u32 pg_num_b;
-	u32 pg_num;
-	u32 size;
-	int i;
+	u32 pg_shift, size, min_size;
+	int ret;
 
 	switch (type) {
 	case TSQ_LINK_TABLE:
 		link_tbl = &priv->tsq;
-		buf_chk_sz = 1 << (hr_dev->caps.tsq_buf_pg_sz + PAGE_SHIFT);
-		pg_num_a = hr_dev->caps.num_qps * 8 / buf_chk_sz;
-		pg_num_b = hr_dev->caps.sl_num * 4 + 2;
+		pg_shift = hr_dev->caps.tsq_buf_pg_sz + PAGE_SHIFT;
+		size = hr_dev->caps.num_qps * HNS_ROCE_V2_TSQ_EXT_LLM_ENTRY_SZ;
+		min_size = HNS_ROCE_TSQ_EXT_LLM_MIN_PAGES(hr_dev->caps.sl_num)
+				<< pg_shift;
 		break;
 	case TPQ_LINK_TABLE:
 		link_tbl = &priv->tpq;
-		buf_chk_sz = 1 << (hr_dev->caps.tpq_buf_pg_sz +	PAGE_SHIFT);
-		pg_num_a = hr_dev->caps.num_cqs * 4 / buf_chk_sz;
-		pg_num_b = 2 * 4 * func_num + 2;
+		pg_shift = hr_dev->caps.tpq_buf_pg_sz + PAGE_SHIFT;
+		size = hr_dev->caps.num_cqs * HNS_ROCE_V2_TPQ_EXT_LLM_ENTRY_SZ;
+		min_size = HNS_ROCE_TPQ_EXT_LLM_MIN_PAGES(1) << pg_shift;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	pg_num = max(pg_num_a, pg_num_b);
-	size = pg_num * sizeof(struct hns_roce_link_table_entry);
+	/* Alloc data table */
+	size = max(size, min_size);
+	link_tbl->buf = hns_roce_buf_alloc(hr_dev, size, pg_shift, 0);
+	if (IS_ERR(link_tbl->buf))
+		return -ENOMEM;
 
-	link_tbl->table.buf = dma_alloc_coherent(dev, size,
+	/* Alloc link table */
+	size = link_tbl->buf->npages * sizeof(u64);
+	link_tbl->table.buf = dma_alloc_coherent(hr_dev->dev, size,
 						 &link_tbl->table.map,
 						 GFP_KERNEL);
-	if (!link_tbl->table.buf)
-		goto out;
-
-	link_tbl->pg_list = kcalloc(pg_num, sizeof(*link_tbl->pg_list),
-				    GFP_KERNEL);
-	if (!link_tbl->pg_list)
-		goto err_kcalloc_failed;
-
-	entry = link_tbl->table.buf;
-	for (i = 0; i < pg_num; ++i) {
-		link_tbl->pg_list[i].buf = dma_alloc_coherent(dev, buf_chk_sz,
-							      &t, GFP_KERNEL);
-		if (!link_tbl->pg_list[i].buf)
-			goto err_alloc_buf_failed;
-
-		link_tbl->pg_list[i].map = t;
-
-		entry[i].blk_ba0 = (u32)(t >> 12);
-		entry[i].blk_ba1_nxt_ptr = (u32)(t >> 44);
-
-		if (i < (pg_num - 1))
-			entry[i].blk_ba1_nxt_ptr |=
-				(i + 1) << HNS_ROCE_LINK_TABLE_NXT_PTR_S;
+	if (!link_tbl->table.buf) {
+		ret = -ENOMEM;
+		goto err_alloc_buf;
 	}
-	link_tbl->npages = pg_num;
-	link_tbl->pg_sz = buf_chk_sz;
 
-	return hns_roce_config_link_table(hr_dev, type);
+	ret = hns_roce_config_link_table(hr_dev, type);
+	if (ret)
+		goto err_alloc_table;
 
-err_alloc_buf_failed:
-	for (i -= 1; i >= 0; i--)
-		dma_free_coherent(dev, buf_chk_sz,
-				  link_tbl->pg_list[i].buf,
-				  link_tbl->pg_list[i].map);
-	kfree(link_tbl->pg_list);
+	return 0;
 
-err_kcalloc_failed:
-	dma_free_coherent(dev, size, link_tbl->table.buf,
+err_alloc_table:
+	dma_free_coherent(hr_dev->dev, size, link_tbl->table.buf,
 			  link_tbl->table.map);
-
-out:
-	return -ENOMEM;
+err_alloc_buf:
+	hns_roce_buf_free(hr_dev, link_tbl->buf);
+	return ret;
 }
 
 static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
-				     struct hns_roce_link_table *link_tbl)
+				     enum hns_roce_link_table_type type)
 {
-	struct device *dev = hr_dev->dev;
-	int size;
-	int i;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_link_table *link_tbl;
+
+	switch (type) {
+	case TSQ_LINK_TABLE:
+		link_tbl = &priv->tsq;
+		break;
+	case TPQ_LINK_TABLE:
+		link_tbl = &priv->tpq;
+		break;
+	default:
+		return;
+	}
 
-	size = link_tbl->npages * sizeof(struct hns_roce_link_table_entry);
+	if (link_tbl->table.buf) {
+		u32 size = link_tbl->buf->npages * sizeof(u64);
 
-	for (i = 0; i < link_tbl->npages; ++i)
-		if (link_tbl->pg_list[i].buf)
-			dma_free_coherent(dev, link_tbl->pg_sz,
-					  link_tbl->pg_list[i].buf,
-					  link_tbl->pg_list[i].map);
-	kfree(link_tbl->pg_list);
+		dma_free_coherent(hr_dev->dev, size, link_tbl->table.buf,
+				  link_tbl->table.map);
+	}
 
-	dma_free_coherent(dev, size, link_tbl->table.buf,
-			  link_tbl->table.map);
+	hns_roce_buf_free(hr_dev, link_tbl->buf);
 }
 
 static void free_dip_list(struct hns_roce_dev *hr_dev)
@@ -2735,7 +2724,6 @@ static void put_hem_table(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	int ret;
 
 	ret = get_hem_table(hr_dev);
@@ -2764,20 +2752,18 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 	put_hem_table(hr_dev);
 
 err_tpq_init_failed:
-	hns_roce_free_link_table(hr_dev, &priv->tpq);
+	hns_roce_free_link_table(hr_dev, TPQ_LINK_TABLE);
 
 	return ret;
 }
 
 static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-
 	hns_roce_function_clear(hr_dev);
 
 	if (!hr_dev->is_vf) {
-		hns_roce_free_link_table(hr_dev, &priv->tpq);
-		hns_roce_free_link_table(hr_dev, &priv->tsq);
+		hns_roce_free_link_table(hr_dev, TPQ_LINK_TABLE);
+		hns_roce_free_link_table(hr_dev, TSQ_LINK_TABLE);
 	}
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index a2100a6..7bad434 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -93,6 +93,10 @@
 #define HNS_ROCE_V3_SCCC_SZ			64
 #define HNS_ROCE_V3_GMV_ENTRY_SZ		32
 
+#define HNS_ROCE_V2_TSQ_EXT_LLM_ENTRY_SZ	8
+#define HNS_ROCE_V2_TPQ_EXT_LLM_ENTRY_SZ	4
+#define HNS_ROCE_V2_EXT_LLM_MAX_DEPTH		4096
+
 #define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
@@ -1342,39 +1346,18 @@ struct hns_roce_func_clear {
 #define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL	40
 #define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT	20
 
-struct hns_roce_cfg_llm_a {
-	__le32 base_addr_l;
-	__le32 base_addr_h;
-	__le32 depth_pgsz_init_en;
-	__le32 head_ba_l;
-	__le32 head_ba_h_nxtptr;
-	__le32 head_ptr;
-};
-
-#define CFG_LLM_QUE_DEPTH_S 0
-#define CFG_LLM_QUE_DEPTH_M GENMASK(12, 0)
-
-#define CFG_LLM_QUE_PGSZ_S 16
-#define CFG_LLM_QUE_PGSZ_M GENMASK(19, 16)
-
-#define CFG_LLM_INIT_EN_S 20
-#define CFG_LLM_INIT_EN_M GENMASK(20, 20)
-
-#define CFG_LLM_HEAD_PTR_S 0
-#define CFG_LLM_HEAD_PTR_M GENMASK(11, 0)
-
-struct hns_roce_cfg_llm_b {
-	__le32 tail_ba_l;
-	__le32 tail_ba_h;
-	__le32 tail_ptr;
-	__le32 rsv[3];
-};
-
-#define CFG_LLM_TAIL_BA_H_S 0
-#define CFG_LLM_TAIL_BA_H_M GENMASK(19, 0)
-
-#define CFG_LLM_TAIL_PTR_S 0
-#define CFG_LLM_TAIL_PTR_M GENMASK(11, 0)
+#define CFG_LLM_A_BA_L CMQ_REQ_FIELD_LOC(31, 0)
+#define CFG_LLM_A_BA_H CMQ_REQ_FIELD_LOC(63, 32)
+#define CFG_LLM_A_DEPTH CMQ_REQ_FIELD_LOC(76, 64)
+#define CFG_LLM_A_PGSZ CMQ_REQ_FIELD_LOC(83, 80)
+#define CFG_LLM_A_INIT_EN CMQ_REQ_FIELD_LOC(84, 84)
+#define CFG_LLM_A_HEAD_BA_L CMQ_REQ_FIELD_LOC(127, 96)
+#define CFG_LLM_A_HEAD_BA_H CMQ_REQ_FIELD_LOC(147, 128)
+#define CFG_LLM_A_HEAD_NXTPTR CMQ_REQ_FIELD_LOC(159, 148)
+#define CFG_LLM_A_HEAD_PTR CMQ_REQ_FIELD_LOC(171, 160)
+#define CFG_LLM_B_TAIL_BA_L CMQ_REQ_FIELD_LOC(31, 0)
+#define CFG_LLM_B_TAIL_BA_H CMQ_REQ_FIELD_LOC(63, 32)
+#define CFG_LLM_B_TAIL_PTR CMQ_REQ_FIELD_LOC(75, 64)
 
 /* Fields of HNS_ROCE_OPC_CFG_GLOBAL_PARAM */
 #define CFG_GLOBAL_PARAM_1US_CYCLES CMQ_REQ_FIELD_LOC(9, 0)
@@ -1742,20 +1725,13 @@ enum hns_roce_link_table_type {
 
 struct hns_roce_link_table {
 	struct hns_roce_buf_list table;
-	struct hns_roce_buf_list *pg_list;
-	u32 npages;
-	u32 pg_sz;
+	struct hns_roce_buf *buf;
 };
 
-struct hns_roce_link_table_entry {
-	u32 blk_ba0;
-	u32 blk_ba1_nxt_ptr;
-};
-#define HNS_ROCE_LINK_TABLE_BA1_S 0
-#define HNS_ROCE_LINK_TABLE_BA1_M GENMASK(19, 0)
+#define HNS_ROCE_EXT_LLM_ENTRY(addr, id) (((id) << (64 - 12)) | ((addr) >> 12))
 
-#define HNS_ROCE_LINK_TABLE_NXT_PTR_S 20
-#define HNS_ROCE_LINK_TABLE_NXT_PTR_M GENMASK(31, 20)
+#define HNS_ROCE_TSQ_EXT_LLM_MIN_PAGES(que_num) ((que_num) * 4 + 2)
+#define HNS_ROCE_TPQ_EXT_LLM_MIN_PAGES(que_num) ((que_num) * 8 + 2)
 
 struct hns_roce_v2_priv {
 	struct hnae3_handle *handle;
-- 
2.7.4

