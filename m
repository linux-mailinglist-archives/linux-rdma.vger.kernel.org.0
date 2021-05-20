Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5DF389BEE
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 05:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhETDhX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 23:37:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3436 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhETDhX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 23:37:23 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlwLJ6dwTzCsk0;
        Thu, 20 May 2021 11:33:12 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:36:00 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 11:35:59 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next] RDMA/hns: Refactor extend link table allocation
Date:   Thu, 20 May 2021 11:35:51 +0800
Message-ID: <1621481751-27375-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The timeout link table works in HIP08 ES version and the hns driver only
support the CS version for HIP08, so delete the related code. Then simplify
the buffer allocation for link table to make the code more readable.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v1:
* Merge the first patch in the series into the second one.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620807370-9409-1-git-send-email-liweihang@huawei.com/

 drivers/infiniband/hw/hns/hns_roce_device.h |   3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 255 ++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  72 +++-----
 3 files changed, 124 insertions(+), 206 deletions(-)

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
index 49bb4f5..e105e21 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2062,7 +2062,7 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 	caps->eqe_buf_pg_sz = 0;
 
 	/* Link Table */
-	caps->tsq_buf_pg_sz = 0;
+	caps->llm_buf_pg_sz = 0;
 
 	/* MR */
 	caps->pbl_ba_pg_sz = HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
@@ -2478,168 +2478,136 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	return ret;
 }
 
-static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
-				      enum hns_roce_link_table_type type)
+static void config_llm_table(struct hns_roce_buf *data_buf, void *cfg_buf)
 {
-	struct hns_roce_cmq_desc desc[2];
-	struct hns_roce_cfg_llm_a *req_a =
-				(struct hns_roce_cfg_llm_a *)desc[0].data;
-	struct hns_roce_cfg_llm_b *req_b =
-				(struct hns_roce_cfg_llm_b *)desc[1].data;
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	struct hns_roce_link_table *link_tbl;
-	struct hns_roce_link_table_entry *entry;
-	enum hns_roce_opcode_type opcode;
-	u32 page_num;
+	u32 i, next_ptr, page_num;
+	__le64 *entry = cfg_buf;
+	dma_addr_t addr;
+	u64 val;
 
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
+	page_num = data_buf->npages;
+	for (i = 0; i < page_num; i++) {
+		addr = hns_roce_buf_page(data_buf, i);
+		if (i == (page_num - 1))
+			next_ptr = 0;
+		else
+			next_ptr = i + 1;
+
+		val = HNS_ROCE_EXT_LLM_ENTRY(addr, (u64)next_ptr);
+		entry[i] = cpu_to_le64(val);
 	}
+}
 
-	page_num = link_tbl->npages;
-	entry = link_tbl->table.buf;
+static int set_llm_cfg_to_hw(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_link_table *table)
+{
+	struct hns_roce_cmq_desc desc[2];
+	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
+	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
+	struct hns_roce_buf *buf = table->buf;
+	enum hns_roce_opcode_type opcode;
+	dma_addr_t addr;
 
+	opcode = HNS_ROCE_OPC_CFG_EXT_LLM;
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
+	hr_reg_write(r_a, CFG_LLM_A_BA_L, lower_32_bits(table->table.map));
+	hr_reg_write(r_a, CFG_LLM_A_BA_H, upper_32_bits(table->table.map));
+	hr_reg_write(r_a, CFG_LLM_A_DEPTH, buf->npages);
+	hr_reg_write(r_a, CFG_LLM_A_PGSZ, to_hr_hw_page_shift(buf->page_shift));
+	hr_reg_enable(r_a, CFG_LLM_A_INIT_EN);
+
+	addr = to_hr_hw_page_addr(hns_roce_buf_page(buf, 0));
+	hr_reg_write(r_a, CFG_LLM_A_HEAD_BA_L, lower_32_bits(addr));
+	hr_reg_write(r_a, CFG_LLM_A_HEAD_BA_H, upper_32_bits(addr));
+	hr_reg_write(r_a, CFG_LLM_A_HEAD_NXTPTR, 1);
+	hr_reg_write(r_a, CFG_LLM_A_HEAD_PTR, 0);
 
-	req_b->tail_ba_l = cpu_to_le32(entry[page_num - 1].blk_ba0);
-	roce_set_field(req_b->tail_ba_h, CFG_LLM_TAIL_BA_H_M,
-		       CFG_LLM_TAIL_BA_H_S,
-		       entry[page_num - 1].blk_ba1_nxt_ptr &
-		       HNS_ROCE_LINK_TABLE_BA1_M);
-	roce_set_field(req_b->tail_ptr, CFG_LLM_TAIL_PTR_M, CFG_LLM_TAIL_PTR_S,
-		       (entry[page_num - 2].blk_ba1_nxt_ptr &
-			HNS_ROCE_LINK_TABLE_NXT_PTR_M) >>
-			HNS_ROCE_LINK_TABLE_NXT_PTR_S);
+	addr = to_hr_hw_page_addr(hns_roce_buf_page(buf, buf->npages - 1));
+	hr_reg_write(r_b, CFG_LLM_B_TAIL_BA_L, lower_32_bits(addr));
+	hr_reg_write(r_b, CFG_LLM_B_TAIL_BA_H, upper_32_bits(addr));
+	hr_reg_write(r_b, CFG_LLM_B_TAIL_PTR, buf->npages - 1);
 
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
 
-static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
-				    enum hns_roce_link_table_type type)
+static struct hns_roce_link_table *
+alloc_link_table_buf(struct hns_roce_dev *hr_dev)
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
-
-	switch (type) {
-	case TSQ_LINK_TABLE:
-		link_tbl = &priv->tsq;
-		buf_chk_sz = 1 << (hr_dev->caps.tsq_buf_pg_sz + PAGE_SHIFT);
-		pg_num_a = hr_dev->caps.num_qps * 8 / buf_chk_sz;
-		pg_num_b = hr_dev->caps.sl_num * 4 + 2;
-		break;
-	case TPQ_LINK_TABLE:
-		link_tbl = &priv->tpq;
-		buf_chk_sz = 1 << (hr_dev->caps.tpq_buf_pg_sz +	PAGE_SHIFT);
-		pg_num_a = hr_dev->caps.num_cqs * 4 / buf_chk_sz;
-		pg_num_b = 2 * 4 * func_num + 2;
-		break;
-	default:
-		return -EINVAL;
+	u32 pg_shift, size, min_size;
+
+	link_tbl = &priv->ext_llm;
+	pg_shift = hr_dev->caps.llm_buf_pg_sz + PAGE_SHIFT;
+	size = hr_dev->caps.num_qps * HNS_ROCE_V2_EXT_LLM_ENTRY_SZ;
+	min_size = HNS_ROCE_EXT_LLM_MIN_PAGES(hr_dev->caps.sl_num) << pg_shift;
+
+	/* Alloc data table */
+	size = max(size, min_size);
+	link_tbl->buf = hns_roce_buf_alloc(hr_dev, size, pg_shift, 0);
+	if (IS_ERR(link_tbl->buf))
+		return ERR_PTR(-ENOMEM);
+
+	/* Alloc config table */
+	size = link_tbl->buf->npages * sizeof(u64);
+	link_tbl->table.buf = dma_alloc_coherent(hr_dev->dev, size,
+						 &link_tbl->table.map,
+						 GFP_KERNEL);
+	if (!link_tbl->table.buf) {
+		hns_roce_buf_free(hr_dev, link_tbl->buf);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	pg_num = max(pg_num_a, pg_num_b);
-	size = pg_num * sizeof(struct hns_roce_link_table_entry);
+	return link_tbl;
+}
 
-	link_tbl->table.buf = dma_alloc_coherent(dev, size,
-						 &link_tbl->table.map,
-						 GFP_KERNEL);
-	if (!link_tbl->table.buf)
-		goto out;
+static void free_link_table_buf(struct hns_roce_dev *hr_dev,
+				struct hns_roce_link_table *tbl)
+{
+	if (tbl->buf) {
+		u32 size = tbl->buf->npages * sizeof(u64);
 
-	link_tbl->pg_list = kcalloc(pg_num, sizeof(*link_tbl->pg_list),
-				    GFP_KERNEL);
-	if (!link_tbl->pg_list)
-		goto err_kcalloc_failed;
+		dma_free_coherent(hr_dev->dev, size, tbl->table.buf,
+				  tbl->table.map);
+	}
 
-	entry = link_tbl->table.buf;
-	for (i = 0; i < pg_num; ++i) {
-		link_tbl->pg_list[i].buf = dma_alloc_coherent(dev, buf_chk_sz,
-							      &t, GFP_KERNEL);
-		if (!link_tbl->pg_list[i].buf)
-			goto err_alloc_buf_failed;
+	hns_roce_buf_free(hr_dev, tbl->buf);
+}
 
-		link_tbl->pg_list[i].map = t;
+static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_link_table *link_tbl;
+	int ret;
 
-		entry[i].blk_ba0 = (u32)(t >> 12);
-		entry[i].blk_ba1_nxt_ptr = (u32)(t >> 44);
+	link_tbl = alloc_link_table_buf(hr_dev);
+	if (IS_ERR(link_tbl))
+		return -ENOMEM;
 
-		if (i < (pg_num - 1))
-			entry[i].blk_ba1_nxt_ptr |=
-				(i + 1) << HNS_ROCE_LINK_TABLE_NXT_PTR_S;
+	if (WARN_ON(link_tbl->buf->npages > HNS_ROCE_V2_EXT_LLM_MAX_DEPTH)) {
+		ret = -EINVAL;
+		goto err_alloc;
 	}
-	link_tbl->npages = pg_num;
-	link_tbl->pg_sz = buf_chk_sz;
-
-	return hns_roce_config_link_table(hr_dev, type);
 
-err_alloc_buf_failed:
-	for (i -= 1; i >= 0; i--)
-		dma_free_coherent(dev, buf_chk_sz,
-				  link_tbl->pg_list[i].buf,
-				  link_tbl->pg_list[i].map);
-	kfree(link_tbl->pg_list);
+	config_llm_table(link_tbl->buf, link_tbl->table.buf);
+	ret = set_llm_cfg_to_hw(hr_dev, link_tbl);
+	if (ret)
+		goto err_alloc;
 
-err_kcalloc_failed:
-	dma_free_coherent(dev, size, link_tbl->table.buf,
-			  link_tbl->table.map);
+	return 0;
 
-out:
-	return -ENOMEM;
+err_alloc:
+	free_link_table_buf(hr_dev, link_tbl);
+	return ret;
 }
 
-static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
-				     struct hns_roce_link_table *link_tbl)
+static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev)
 {
-	struct device *dev = hr_dev->dev;
-	int size;
-	int i;
-
-	size = link_tbl->npages * sizeof(struct hns_roce_link_table_entry);
-
-	for (i = 0; i < link_tbl->npages; ++i)
-		if (link_tbl->pg_list[i].buf)
-			dma_free_coherent(dev, link_tbl->pg_sz,
-					  link_tbl->pg_list[i].buf,
-					  link_tbl->pg_list[i].map);
-	kfree(link_tbl->pg_list);
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
-	dma_free_coherent(dev, size, link_tbl->table.buf,
-			  link_tbl->table.map);
+	free_link_table_buf(hr_dev, &priv->ext_llm);
 }
 
 static void free_dip_list(struct hns_roce_dev *hr_dev)
@@ -2735,7 +2703,6 @@ static void put_hem_table(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	int ret;
 
 	ret = get_hem_table(hr_dev);
@@ -2745,40 +2712,26 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
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
-	hns_roce_free_link_table(hr_dev, &priv->tpq);
-
 	return ret;
 }
 
 static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-
 	hns_roce_function_clear(hr_dev);
 
-	if (!hr_dev->is_vf) {
-		hns_roce_free_link_table(hr_dev, &priv->tpq);
-		hns_roce_free_link_table(hr_dev, &priv->tsq);
-	}
+	if (!hr_dev->is_vf)
+		hns_roce_free_link_table(hr_dev);
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
 		free_dip_list(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index a2100a6..1db199a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -93,6 +93,9 @@
 #define HNS_ROCE_V3_SCCC_SZ			64
 #define HNS_ROCE_V3_GMV_ENTRY_SZ		32
 
+#define HNS_ROCE_V2_EXT_LLM_ENTRY_SZ		8
+#define HNS_ROCE_V2_EXT_LLM_MAX_DEPTH		4096
+
 #define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
@@ -234,7 +237,6 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_QUERY_PF_RES			= 0x8400,
 	HNS_ROCE_OPC_ALLOC_VF_RES			= 0x8401,
 	HNS_ROCE_OPC_CFG_EXT_LLM			= 0x8403,
-	HNS_ROCE_OPC_CFG_TMOUT_LLM			= 0x8404,
 	HNS_ROCE_OPC_QUERY_PF_TIMER_RES			= 0x8406,
 	HNS_ROCE_OPC_QUERY_FUNC_INFO			= 0x8407,
 	HNS_ROCE_OPC_QUERY_PF_CAPS_NUM                  = 0x8408,
@@ -1342,39 +1344,18 @@ struct hns_roce_func_clear {
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
@@ -1735,33 +1716,18 @@ struct hns_roce_v2_cmq {
 	u16 tx_timeout;
 };
 
-enum hns_roce_link_table_type {
-	TSQ_LINK_TABLE,
-	TPQ_LINK_TABLE,
-};
-
 struct hns_roce_link_table {
 	struct hns_roce_buf_list table;
-	struct hns_roce_buf_list *pg_list;
-	u32 npages;
-	u32 pg_sz;
-};
-
-struct hns_roce_link_table_entry {
-	u32 blk_ba0;
-	u32 blk_ba1_nxt_ptr;
+	struct hns_roce_buf *buf;
 };
-#define HNS_ROCE_LINK_TABLE_BA1_S 0
-#define HNS_ROCE_LINK_TABLE_BA1_M GENMASK(19, 0)
 
-#define HNS_ROCE_LINK_TABLE_NXT_PTR_S 20
-#define HNS_ROCE_LINK_TABLE_NXT_PTR_M GENMASK(31, 20)
+#define HNS_ROCE_EXT_LLM_ENTRY(addr, id) (((id) << (64 - 12)) | ((addr) >> 12))
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

