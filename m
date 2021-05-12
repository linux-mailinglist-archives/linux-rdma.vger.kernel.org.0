Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4585637B7AF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhELIRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 04:17:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2455 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhELIRa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 04:17:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg6xc0rWTzCrZZ;
        Wed, 12 May 2021 16:13:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 16:16:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Remove timeout link table for HIP08
Date:   Wed, 12 May 2021 16:16:10 +0800
Message-ID: <1620807370-9409-3-git-send-email-liweihang@huawei.com>
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

The timeout link table works in HIP08 ES version and the hns driver only
support the CS version for HIP08, so delete the related code.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 177 +++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  16 +--
 3 files changed, 76 insertions(+), 120 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 97800d2..5bd4013 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -854,8 +854,7 @@ struct hns_roce_caps {
 	u32		gmv_buf_pg_sz;
 	u32		gmv_hop_num;
 	u32		sl_num;
-	u32		tsq_buf_pg_sz;
-	u32		tpq_buf_pg_sz;
+	u32		llm_buf_pg_sz;
 	u32		chunk_sz;	/* chunk size in non multihop mode */
 	u64		flags;
 	u16		default_ceq_max_cnt;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a3f7dc5..e105e21 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2062,7 +2062,7 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 	caps->eqe_buf_pg_sz = 0;
 
 	/* Link Table */
-	caps->tsq_buf_pg_sz = 0;
+	caps->llm_buf_pg_sz = 0;
 
 	/* MR */
 	caps->pbl_ba_pg_sz = HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
@@ -2478,43 +2478,16 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	return ret;
 }
 
-static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
-				      enum hns_roce_link_table_type type)
+static void config_llm_table(struct hns_roce_buf *data_buf, void *cfg_buf)
 {
-	struct hns_roce_cmq_desc desc[2];
-	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
-	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	struct hns_roce_link_table *link_tbl;
-	enum hns_roce_opcode_type opcode;
 	u32 i, next_ptr, page_num;
-	struct hns_roce_buf *buf;
+	__le64 *entry = cfg_buf;
 	dma_addr_t addr;
-	__le64 *entry;
 	u64 val;
 
-	switch (type) {
-	case TSQ_LINK_TABLE:
-		link_tbl = &priv->tsq;
-		opcode = HNS_ROCE_OPC_CFG_EXT_LLM;
-		break;
-	case TPQ_LINK_TABLE:
-		link_tbl = &priv->tpq;
-		opcode = HNS_ROCE_OPC_CFG_TMOUT_LLM;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* Setup data table block address to link table entry */
-	buf = link_tbl->buf;
-	page_num = buf->npages;
-	if (WARN_ON(page_num > HNS_ROCE_V2_EXT_LLM_MAX_DEPTH))
-		return -EINVAL;
-
-	entry = link_tbl->table.buf;
+	page_num = data_buf->npages;
 	for (i = 0; i < page_num; i++) {
-		addr = hns_roce_buf_page(buf, i);
+		addr = hns_roce_buf_page(data_buf, i);
 		if (i == (page_num - 1))
 			next_ptr = 0;
 		else
@@ -2523,13 +2496,25 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 		val = HNS_ROCE_EXT_LLM_ENTRY(addr, (u64)next_ptr);
 		entry[i] = cpu_to_le64(val);
 	}
+}
 
+static int set_llm_cfg_to_hw(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_link_table *table)
+{
+	struct hns_roce_cmq_desc desc[2];
+	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
+	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
+	struct hns_roce_buf *buf = table->buf;
+	enum hns_roce_opcode_type opcode;
+	dma_addr_t addr;
+
+	opcode = HNS_ROCE_OPC_CFG_EXT_LLM;
 	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, false);
 	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, false);
 
-	hr_reg_write(r_a, CFG_LLM_A_BA_L, lower_32_bits(link_tbl->table.map));
-	hr_reg_write(r_a, CFG_LLM_A_BA_H, upper_32_bits(link_tbl->table.map));
+	hr_reg_write(r_a, CFG_LLM_A_BA_L, lower_32_bits(table->table.map));
+	hr_reg_write(r_a, CFG_LLM_A_BA_H, upper_32_bits(table->table.map));
 	hr_reg_write(r_a, CFG_LLM_A_DEPTH, buf->npages);
 	hr_reg_write(r_a, CFG_LLM_A_PGSZ, to_hr_hw_page_shift(buf->page_shift));
 	hr_reg_enable(r_a, CFG_LLM_A_INIT_EN);
@@ -2540,7 +2525,7 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 	hr_reg_write(r_a, CFG_LLM_A_HEAD_NXTPTR, 1);
 	hr_reg_write(r_a, CFG_LLM_A_HEAD_PTR, 0);
 
-	addr = to_hr_hw_page_addr(hns_roce_buf_page(buf, page_num - 1));
+	addr = to_hr_hw_page_addr(hns_roce_buf_page(buf, buf->npages - 1));
 	hr_reg_write(r_b, CFG_LLM_B_TAIL_BA_L, lower_32_bits(addr));
 	hr_reg_write(r_b, CFG_LLM_B_TAIL_BA_H, upper_32_bits(addr));
 	hr_reg_write(r_b, CFG_LLM_B_TAIL_PTR, buf->npages - 1);
@@ -2548,87 +2533,81 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
 
-static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
-				    enum hns_roce_link_table_type type)
+static struct hns_roce_link_table *
+alloc_link_table_buf(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_link_table *link_tbl;
 	u32 pg_shift, size, min_size;
-	int ret;
 
-	switch (type) {
-	case TSQ_LINK_TABLE:
-		link_tbl = &priv->tsq;
-		pg_shift = hr_dev->caps.tsq_buf_pg_sz + PAGE_SHIFT;
-		size = hr_dev->caps.num_qps * HNS_ROCE_V2_TSQ_EXT_LLM_ENTRY_SZ;
-		min_size = HNS_ROCE_TSQ_EXT_LLM_MIN_PAGES(hr_dev->caps.sl_num)
-				<< pg_shift;
-		break;
-	case TPQ_LINK_TABLE:
-		link_tbl = &priv->tpq;
-		pg_shift = hr_dev->caps.tpq_buf_pg_sz + PAGE_SHIFT;
-		size = hr_dev->caps.num_cqs * HNS_ROCE_V2_TPQ_EXT_LLM_ENTRY_SZ;
-		min_size = HNS_ROCE_TPQ_EXT_LLM_MIN_PAGES(1) << pg_shift;
-		break;
-	default:
-		return -EINVAL;
-	}
+	link_tbl = &priv->ext_llm;
+	pg_shift = hr_dev->caps.llm_buf_pg_sz + PAGE_SHIFT;
+	size = hr_dev->caps.num_qps * HNS_ROCE_V2_EXT_LLM_ENTRY_SZ;
+	min_size = HNS_ROCE_EXT_LLM_MIN_PAGES(hr_dev->caps.sl_num) << pg_shift;
 
 	/* Alloc data table */
 	size = max(size, min_size);
 	link_tbl->buf = hns_roce_buf_alloc(hr_dev, size, pg_shift, 0);
 	if (IS_ERR(link_tbl->buf))
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	/* Alloc link table */
+	/* Alloc config table */
 	size = link_tbl->buf->npages * sizeof(u64);
 	link_tbl->table.buf = dma_alloc_coherent(hr_dev->dev, size,
 						 &link_tbl->table.map,
 						 GFP_KERNEL);
 	if (!link_tbl->table.buf) {
-		ret = -ENOMEM;
-		goto err_alloc_buf;
+		hns_roce_buf_free(hr_dev, link_tbl->buf);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	ret = hns_roce_config_link_table(hr_dev, type);
-	if (ret)
-		goto err_alloc_table;
+	return link_tbl;
+}
 
-	return 0;
+static void free_link_table_buf(struct hns_roce_dev *hr_dev,
+				struct hns_roce_link_table *tbl)
+{
+	if (tbl->buf) {
+		u32 size = tbl->buf->npages * sizeof(u64);
 
-err_alloc_table:
-	dma_free_coherent(hr_dev->dev, size, link_tbl->table.buf,
-			  link_tbl->table.map);
-err_alloc_buf:
-	hns_roce_buf_free(hr_dev, link_tbl->buf);
-	return ret;
+		dma_free_coherent(hr_dev->dev, size, tbl->table.buf,
+				  tbl->table.map);
+	}
+
+	hns_roce_buf_free(hr_dev, tbl->buf);
 }
 
-static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
-				     enum hns_roce_link_table_type type)
+static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_link_table *link_tbl;
+	int ret;
 
-	switch (type) {
-	case TSQ_LINK_TABLE:
-		link_tbl = &priv->tsq;
-		break;
-	case TPQ_LINK_TABLE:
-		link_tbl = &priv->tpq;
-		break;
-	default:
-		return;
+	link_tbl = alloc_link_table_buf(hr_dev);
+	if (IS_ERR(link_tbl))
+		return -ENOMEM;
+
+	if (WARN_ON(link_tbl->buf->npages > HNS_ROCE_V2_EXT_LLM_MAX_DEPTH)) {
+		ret = -EINVAL;
+		goto err_alloc;
 	}
 
-	if (link_tbl->table.buf) {
-		u32 size = link_tbl->buf->npages * sizeof(u64);
+	config_llm_table(link_tbl->buf, link_tbl->table.buf);
+	ret = set_llm_cfg_to_hw(hr_dev, link_tbl);
+	if (ret)
+		goto err_alloc;
 
-		dma_free_coherent(hr_dev->dev, size, link_tbl->table.buf,
-				  link_tbl->table.map);
-	}
+	return 0;
 
-	hns_roce_buf_free(hr_dev, link_tbl->buf);
+err_alloc:
+	free_link_table_buf(hr_dev, link_tbl);
+	return ret;
+}
+
+static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+
+	free_link_table_buf(hr_dev, &priv->ext_llm);
 }
 
 static void free_dip_list(struct hns_roce_dev *hr_dev)
@@ -2733,27 +2712,17 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 	if (hr_dev->is_vf)
 		return 0;
 
-	/* TSQ includes SQ doorbell and ack doorbell */
-	ret = hns_roce_init_link_table(hr_dev, TSQ_LINK_TABLE);
+	ret = hns_roce_init_link_table(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev, "failed to init TSQ, ret = %d.\n", ret);
-		goto err_tsq_init_failed;
-	}
-
-	ret = hns_roce_init_link_table(hr_dev, TPQ_LINK_TABLE);
-	if (ret) {
-		dev_err(hr_dev->dev, "failed to init TPQ, ret = %d.\n", ret);
-		goto err_tpq_init_failed;
+		dev_err(hr_dev->dev, "failed to init llm, ret = %d.\n", ret);
+		goto err_llm_init_failed;
 	}
 
 	return 0;
 
-err_tsq_init_failed:
+err_llm_init_failed:
 	put_hem_table(hr_dev);
 
-err_tpq_init_failed:
-	hns_roce_free_link_table(hr_dev, TPQ_LINK_TABLE);
-
 	return ret;
 }
 
@@ -2761,10 +2730,8 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
 	hns_roce_function_clear(hr_dev);
 
-	if (!hr_dev->is_vf) {
-		hns_roce_free_link_table(hr_dev, TPQ_LINK_TABLE);
-		hns_roce_free_link_table(hr_dev, TSQ_LINK_TABLE);
-	}
+	if (!hr_dev->is_vf)
+		hns_roce_free_link_table(hr_dev);
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
 		free_dip_list(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 7bad434..1db199a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -93,8 +93,7 @@
 #define HNS_ROCE_V3_SCCC_SZ			64
 #define HNS_ROCE_V3_GMV_ENTRY_SZ		32
 
-#define HNS_ROCE_V2_TSQ_EXT_LLM_ENTRY_SZ	8
-#define HNS_ROCE_V2_TPQ_EXT_LLM_ENTRY_SZ	4
+#define HNS_ROCE_V2_EXT_LLM_ENTRY_SZ		8
 #define HNS_ROCE_V2_EXT_LLM_MAX_DEPTH		4096
 
 #define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		PAGE_SIZE
@@ -238,7 +237,6 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_QUERY_PF_RES			= 0x8400,
 	HNS_ROCE_OPC_ALLOC_VF_RES			= 0x8401,
 	HNS_ROCE_OPC_CFG_EXT_LLM			= 0x8403,
-	HNS_ROCE_OPC_CFG_TMOUT_LLM			= 0x8404,
 	HNS_ROCE_OPC_QUERY_PF_TIMER_RES			= 0x8406,
 	HNS_ROCE_OPC_QUERY_FUNC_INFO			= 0x8407,
 	HNS_ROCE_OPC_QUERY_PF_CAPS_NUM                  = 0x8408,
@@ -1718,26 +1716,18 @@ struct hns_roce_v2_cmq {
 	u16 tx_timeout;
 };
 
-enum hns_roce_link_table_type {
-	TSQ_LINK_TABLE,
-	TPQ_LINK_TABLE,
-};
-
 struct hns_roce_link_table {
 	struct hns_roce_buf_list table;
 	struct hns_roce_buf *buf;
 };
 
 #define HNS_ROCE_EXT_LLM_ENTRY(addr, id) (((id) << (64 - 12)) | ((addr) >> 12))
-
-#define HNS_ROCE_TSQ_EXT_LLM_MIN_PAGES(que_num) ((que_num) * 4 + 2)
-#define HNS_ROCE_TPQ_EXT_LLM_MIN_PAGES(que_num) ((que_num) * 8 + 2)
+#define HNS_ROCE_EXT_LLM_MIN_PAGES(que_num) ((que_num) * 4 + 2)
 
 struct hns_roce_v2_priv {
 	struct hnae3_handle *handle;
 	struct hns_roce_v2_cmq cmq;
-	struct hns_roce_link_table tsq;
-	struct hns_roce_link_table tpq;
+	struct hns_roce_link_table ext_llm;
 };
 
 struct hns_roce_eq_context {
-- 
2.7.4

