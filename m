Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191B5521C6F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 May 2022 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiEJOhb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344591AbiEJOe7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 10:34:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0AE2C7A6B
        for <linux-rdma@vger.kernel.org>; Tue, 10 May 2022 06:53:46 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KyKH4097Lz1JBwg;
        Tue, 10 May 2022 21:52:32 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 21:53:43 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 21:53:42 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Add support for extended doorbell of HIP09
Date:   Tue, 10 May 2022 21:52:42 +0800
Message-ID: <20220510135242.51094-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The link table of the extended doorbell of HIP09 will be allocated from the
sram of the device instead of the host memory.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.h    |   4 +
 drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 186 +++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   6 +-
 4 files changed, 153 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 052a3d60905a..9468b344e4c8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -111,6 +111,10 @@ enum {
 	/* SCC CTX BT commands */
 	HNS_ROCE_CMD_READ_SCCC_BT0	= 0xa4,
 	HNS_ROCE_CMD_WRITE_SCCC_BT0	= 0xa5,
+
+	/* EXT DB commands */
+	HNS_ROCE_CMD_WRITE_EXT_DB_BT0	= 0xb0,
+	HNS_ROCE_CMD_READ_EXT_DB_BT0	= 0xb4,
 };
 
 enum {
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index eb40fb795aaf..8e683ecfd6cc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -828,6 +828,8 @@ struct hns_roce_caps {
 	u32		gmv_hop_num;
 	u32		sl_num;
 	u32		llm_buf_pg_sz;
+	u32		llm_ba_idx;
+	u32		llm_ba_num;
 	u32		chunk_sz; /* chunk size in non multihop mode */
 	u64		flags;
 	u16		default_ceq_max_cnt;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d233b6c2b29a..48081593e298 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1688,6 +1688,19 @@ static int load_func_res_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 	return 0;
 }
 
+/* Default extended caps for HIP08 and overwritten by HIP09 */
+static void setup_default_ext_caps(struct hns_roce_dev *hr_dev, bool is_vf)
+{
+	struct hns_roce_caps *caps = &hr_dev->caps;
+
+	caps->num_pi_qps = caps->num_qps;
+
+	if (!is_vf) {
+		caps->llm_ba_idx = 0;
+		caps->llm_ba_num = HNS_ROCE_V2_EXT_LLM_MAX_DEPTH;
+	}
+}
+
 static int load_ext_cfg_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 {
 	struct hns_roce_cmq_desc desc;
@@ -1708,6 +1721,12 @@ static int load_ext_cfg_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 	qp_num = hr_reg_read(req, EXT_CFG_QP_NUM) / func_num;
 	caps->num_qps = round_down(qp_num, HNS_ROCE_QP_BANK_NUM);
 
+	/* The extended doorbell memory on the PF is shared by all its VFs. */
+	if (!is_vf) {
+		caps->llm_ba_idx = hr_reg_read(req, EXT_CFG_LLM_IDX);
+		caps->llm_ba_num = hr_reg_read(req, EXT_CFG_LLM_NUM);
+	}
+
 	return 0;
 }
 
@@ -1743,6 +1762,8 @@ static int query_func_resource_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 		return ret;
 	}
 
+	setup_default_ext_caps(hr_dev, is_vf);
+
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
 		ret = load_ext_cfg_caps(hr_dev, is_vf);
 		if (ret)
@@ -2543,46 +2564,53 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		return hns_roce_v2_pf_profile(hr_dev);
 }
 
-static void config_llm_table(struct hns_roce_buf *data_buf, void *cfg_buf)
+static u64 gen_llm_entry_val(struct hns_roce_buf *data_buf, u32 cur_ptr)
 {
-	u32 i, next_ptr, page_num;
-	__le64 *entry = cfg_buf;
 	dma_addr_t addr;
-	u64 val;
+	u32 next_ptr;
 
-	page_num = data_buf->npages;
-	for (i = 0; i < page_num; i++) {
-		addr = hns_roce_buf_page(data_buf, i);
-		if (i == (page_num - 1))
-			next_ptr = 0;
-		else
-			next_ptr = i + 1;
+	addr = hns_roce_buf_page(data_buf, cur_ptr);
 
-		val = HNS_ROCE_EXT_LLM_ENTRY(addr, (u64)next_ptr);
-		entry[i] = cpu_to_le64(val);
-	}
+	if (cur_ptr == (data_buf->npages - 1))
+		next_ptr = 0;
+	else
+		next_ptr = cur_ptr + 1;
+
+	return HNS_ROCE_EXT_LLM_ENTRY(addr, (u64)next_ptr);
+}
+
+static void config_llm_to_host_mem(struct hns_roce_link_table *link_tbl)
+{
+	struct hns_roce_buf *data_buf = link_tbl->buf;
+	__le64 *entry = link_tbl->table.buf;
+	u32 i;
+
+	for (i = 0; i < data_buf->npages; i++)
+		entry[i] = cpu_to_le64(gen_llm_entry_val(data_buf, i));
 }
 
 static int set_llm_cfg_to_hw(struct hns_roce_dev *hr_dev,
-			     struct hns_roce_link_table *table)
+			     struct hns_roce_link_table *table,
+			     bool enable)
 {
 	struct hns_roce_cmq_desc desc[2];
 	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
 	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
 	struct hns_roce_buf *buf = table->buf;
 	enum hns_roce_opcode_type opcode;
-	dma_addr_t addr;
+	u64 addr;
 
 	opcode = HNS_ROCE_OPC_CFG_EXT_LLM;
 	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, false);
 	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, false);
 
+	/* If device mem is used, then the BA field means the starting index */
 	hr_reg_write(r_a, CFG_LLM_A_BA_L, lower_32_bits(table->table.map));
 	hr_reg_write(r_a, CFG_LLM_A_BA_H, upper_32_bits(table->table.map));
 	hr_reg_write(r_a, CFG_LLM_A_DEPTH, buf->npages);
 	hr_reg_write(r_a, CFG_LLM_A_PGSZ, to_hr_hw_page_shift(buf->page_shift));
-	hr_reg_enable(r_a, CFG_LLM_A_INIT_EN);
+	hr_reg_write(r_a, CFG_LLM_A_INIT_EN, enable);
 
 	addr = to_hr_hw_page_addr(hns_roce_buf_page(buf, 0));
 	hr_reg_write(r_a, CFG_LLM_A_HEAD_BA_L, lower_32_bits(addr));
@@ -2598,41 +2626,101 @@ static int set_llm_cfg_to_hw(struct hns_roce_dev *hr_dev,
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
 
+static int config_llm_to_dev_mem(struct hns_roce_dev *hr_dev,
+				 struct hns_roce_link_table *link_tbl)
+{
+	struct hns_roce_buf *data_buf = link_tbl->buf;
+	struct device *dev = hr_dev->dev;
+	int ret;
+	u32 i;
+
+	ret = set_llm_cfg_to_hw(hr_dev, link_tbl, false);
+	if (ret) {
+		dev_err(dev, "failed to set llm in dev mem ret = %d.\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < data_buf->npages; i++) {
+		ret = config_hem_ba_to_hw(hr_dev,
+					  gen_llm_entry_val(data_buf, i),
+					  HNS_ROCE_CMD_WRITE_EXT_DB_BT0,
+					  i);
+		if (ret) {
+			dev_err(dev,
+				"failed to set llm buf, i = %u, ret = %d.\n",
+				i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static struct hns_roce_link_table *
-alloc_link_table_buf(struct hns_roce_dev *hr_dev)
+alloc_link_table_buf(struct hns_roce_dev *hr_dev, bool bt_in_dev_mem)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	struct hns_roce_link_table *link_tbl;
-	u32 pg_shift, size, min_size;
+	struct hns_roce_link_table *link_tbl = &priv->ext_llm;
+	struct hns_roce_caps *caps = &hr_dev->caps;
+	u32 pg_shift, size, min_size, max_size;
+	u32 vf_num, qid_num;
+	int ret;
 
-	link_tbl = &priv->ext_llm;
-	pg_shift = hr_dev->caps.llm_buf_pg_sz + PAGE_SHIFT;
-	size = hr_dev->caps.num_qps * HNS_ROCE_V2_EXT_LLM_ENTRY_SZ;
-	min_size = HNS_ROCE_EXT_LLM_MIN_PAGES(hr_dev->caps.sl_num) << pg_shift;
+	pg_shift = caps->llm_buf_pg_sz + HNS_HW_PAGE_SHIFT;
 
-	/* Alloc data table */
-	size = max(size, min_size);
+	/* The extend doorbell memory is shared by all VFs */
+	vf_num = max_t(u32, 1, hr_dev->func_num);
+	size = caps->num_qps * vf_num * HNS_ROCE_V2_EXT_LLM_ENTRY_SZ;
+	qid_num = max_t(u32, 1, caps->sl_num) * vf_num;
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		min_size = HNS_ROCE_V3_EXT_LLM_MIN_PAGES(qid_num) << pg_shift;
+		size += min_size;
+	} else {
+		min_size = HNS_ROCE_V2_EXT_LLM_MIN_PAGES(qid_num) << pg_shift;
+	}
+	max_size = max_t(u32, min_size, caps->llm_ba_num << pg_shift);
+	size = clamp_t(u32, size, min_size, max_size);
+
+	/* Alloc data pages */
 	link_tbl->buf = hns_roce_buf_alloc(hr_dev, size, pg_shift, 0);
-	if (IS_ERR(link_tbl->buf))
+	if (IS_ERR(link_tbl->buf)) {
+		dev_err(hr_dev->dev, "failed to alloc llm buf.\n");
 		return ERR_PTR(-ENOMEM);
+	}
 
-	/* Alloc config table */
-	size = link_tbl->buf->npages * sizeof(u64);
-	link_tbl->table.buf = dma_alloc_coherent(hr_dev->dev, size,
-						 &link_tbl->table.map,
-						 GFP_KERNEL);
-	if (!link_tbl->table.buf) {
-		hns_roce_buf_free(hr_dev, link_tbl->buf);
-		return ERR_PTR(-ENOMEM);
+	if (link_tbl->buf->npages > caps->llm_ba_num) {
+		dev_err(hr_dev->dev, "failed to check llm depth, %u > %u.\n",
+			link_tbl->buf->npages, caps->llm_ba_num);
+		ret = -EINVAL;
+		goto err_free_buf;
+	}
+
+	/* Alloc BA table to store data pages */
+	if (bt_in_dev_mem) {
+		link_tbl->table.map = caps->llm_ba_idx <<
+				      HNS_ROCE_EXT_LLM_SHFIT;
+		link_tbl->table.buf = NULL;
+	} else {
+		link_tbl->table.buf = dma_alloc_coherent(hr_dev->dev,
+					    link_tbl->buf->npages * sizeof(u64),
+					    &link_tbl->table.map, GFP_KERNEL);
+		if (!link_tbl->table.buf) {
+			ret = -ENOMEM;
+			goto err_free_buf;
+		}
 	}
 
 	return link_tbl;
+
+err_free_buf:
+	hns_roce_buf_free(hr_dev, link_tbl->buf);
+	return ERR_PTR(ret);
 }
 
 static void free_link_table_buf(struct hns_roce_dev *hr_dev,
 				struct hns_roce_link_table *tbl)
 {
-	if (tbl->buf) {
+	if (tbl->table.buf && tbl->buf) {
 		u32 size = tbl->buf->npages * sizeof(u64);
 
 		dma_free_coherent(hr_dev->dev, size, tbl->table.buf,
@@ -2645,21 +2733,31 @@ static void free_link_table_buf(struct hns_roce_dev *hr_dev,
 static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_link_table *link_tbl;
+	bool bt_in_dev_mem;
 	int ret;
 
-	link_tbl = alloc_link_table_buf(hr_dev);
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		bt_in_dev_mem = true;
+	else
+		bt_in_dev_mem = false;
+
+	link_tbl = alloc_link_table_buf(hr_dev, bt_in_dev_mem);
 	if (IS_ERR(link_tbl))
-		return -ENOMEM;
+		return PTR_ERR(link_tbl);
 
-	if (WARN_ON(link_tbl->buf->npages > HNS_ROCE_V2_EXT_LLM_MAX_DEPTH)) {
-		ret = -EINVAL;
-		goto err_alloc;
+	if (bt_in_dev_mem) {
+		ret = config_llm_to_dev_mem(hr_dev, link_tbl);
+		if (ret)
+			goto err_alloc;
+	} else {
+		config_llm_to_host_mem(link_tbl);
 	}
 
-	config_llm_table(link_tbl->buf, link_tbl->table.buf);
-	ret = set_llm_cfg_to_hw(hr_dev, link_tbl);
-	if (ret)
+	ret = set_llm_cfg_to_hw(hr_dev, link_tbl, true);
+	if (ret) {
+		dev_err(hr_dev->dev, "failed to enable llm, ret = %d.\n", ret);
 		goto err_alloc;
+	}
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 9cbb230de03b..c5e3ba97602d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -123,6 +123,8 @@ enum {
 	HNS_ROCE_CMD_FLAG_ERR_INTR = BIT(5),
 };
 
+#define HNS_ROCE_EXT_LLM_SHFIT		3
+
 #define HNS_ROCE_CMQ_DESC_NUM_S		3
 
 #define HNS_ROCE_CMQ_SCC_CLR_DONE_CNT		5
@@ -1428,7 +1430,9 @@ struct hns_roce_link_table {
 };
 
 #define HNS_ROCE_EXT_LLM_ENTRY(addr, id) (((id) << (64 - 12)) | ((addr) >> 12))
-#define HNS_ROCE_EXT_LLM_MIN_PAGES(que_num) ((que_num) * 4 + 2)
+/* min pages = {(qid num) * (app list num)} + (free list num) + (extra pages) */
+#define HNS_ROCE_V2_EXT_LLM_MIN_PAGES(que_num) ((que_num) * 4 + 1 + 1)
+#define HNS_ROCE_V3_EXT_LLM_MIN_PAGES(que_num) ((que_num) * 2 + 1 + 1)
 
 struct hns_roce_v2_free_mr {
 	struct ib_qp *rsv_qp[HNS_ROCE_FREE_MR_USED_QP_NUM];
-- 
2.33.0

