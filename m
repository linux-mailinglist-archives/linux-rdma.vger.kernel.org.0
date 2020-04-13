Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3611A6603
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 13:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgDML6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 07:58:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729296AbgDML6T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 07:58:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 764E1D8929F56313FD06;
        Mon, 13 Apr 2020 19:58:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 19:58:11 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/6] RDMA/hns: Optimize 0 hop addressing for EQE buffer
Date:   Mon, 13 Apr 2020 19:58:08 +0800
Message-ID: <1586779091-51410-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
References: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Use the new mtr interface to simple the hop 0 addressing and multihop
addressing process.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   6 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 171 ++++++++--------------------
 2 files changed, 48 insertions(+), 129 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c37617d..39577c2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -794,17 +794,11 @@ struct hns_roce_eq {
 	int				over_ignore;
 	int				coalesce;
 	int				arm_st;
-	u64				eqe_ba;
-	int				eqe_ba_pg_sz;
-	int				eqe_buf_pg_sz;
 	int				hop_num;
 	struct hns_roce_mtr		mtr;
-	struct hns_roce_buf		buf;
 	int				eq_max_cnt;
 	int				eq_period;
 	int				shift;
-	dma_addr_t			cur_eqe_ba;
-	dma_addr_t			nxt_eqe_ba;
 	int				event_type;
 	int				sub_type;
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 998015d..335a637 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4993,7 +4993,7 @@ static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_aeqe *aeqe;
 
-	aeqe = hns_roce_buf_offset(&eq->buf,
+	aeqe = hns_roce_buf_offset(eq->mtr.kmem,
 				   (eq->cons_index & (eq->entries - 1)) *
 				   HNS_ROCE_AEQ_ENTRY_SIZE);
 
@@ -5093,7 +5093,7 @@ static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_ceqe *ceqe;
 
-	ceqe = hns_roce_buf_offset(&eq->buf,
+	ceqe = hns_roce_buf_offset(eq->mtr.kmem,
 				   (eq->cons_index & (eq->entries - 1)) *
 				   HNS_ROCE_CEQ_ENTRY_SIZE);
 	return (!!(roce_get_bit(ceqe->comp, HNS_ROCE_V2_CEQ_CEQE_OWNER_S))) ^
@@ -5254,17 +5254,15 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, int eqn)
 
 static void free_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 {
-	if (!eq->hop_num || eq->hop_num == HNS_ROCE_HOP_NUM_0)
-		hns_roce_mtr_cleanup(hr_dev, &eq->mtr);
-	hns_roce_buf_free(hr_dev, &eq->buf);
+	hns_roce_mtr_destroy(hr_dev, &eq->mtr);
 }
 
-static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
-				struct hns_roce_eq *eq,
-				void *mb_buf)
+static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
+		      void *mb_buf)
 {
+	u64 eqe_ba[MTT_MIN_COUNT] = { 0 };
 	struct hns_roce_eq_context *eqc;
-	u64 ba[MTT_MIN_COUNT] = { 0 };
+	u64 bt_ba = 0;
 	int count;
 
 	eqc = mb_buf;
@@ -5272,32 +5270,18 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 
 	/* init eqc */
 	eq->doorbell = hr_dev->reg_base + ROCEE_VF_EQ_DB_CFG0_REG;
-	eq->hop_num = hr_dev->caps.eqe_hop_num;
 	eq->cons_index = 0;
 	eq->over_ignore = HNS_ROCE_V2_EQ_OVER_IGNORE_0;
 	eq->coalesce = HNS_ROCE_V2_EQ_COALESCE_0;
 	eq->arm_st = HNS_ROCE_V2_EQ_ALWAYS_ARMED;
-	eq->eqe_ba_pg_sz = hr_dev->caps.eqe_ba_pg_sz;
-	eq->eqe_buf_pg_sz = hr_dev->caps.eqe_buf_pg_sz;
 	eq->shift = ilog2((unsigned int)eq->entries);
 
 	/* if not multi-hop, eqe buffer only use one trunk */
-	eq->eqe_buf_pg_sz = eq->buf.page_shift - PAGE_ADDR_SHIFT;
-	if (!eq->hop_num || eq->hop_num == HNS_ROCE_HOP_NUM_0) {
-		eq->eqe_ba = eq->buf.direct.map;
-		eq->cur_eqe_ba = eq->eqe_ba;
-		if (eq->buf.npages > 1)
-			eq->nxt_eqe_ba = eq->eqe_ba + (1 << eq->eqe_buf_pg_sz);
-		else
-			eq->nxt_eqe_ba = eq->eqe_ba;
-	} else {
-		count = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, ba,
-					  MTT_MIN_COUNT, &eq->eqe_ba);
-		eq->cur_eqe_ba = ba[0];
-		if (count > 1)
-			eq->nxt_eqe_ba = ba[1];
-		else
-			eq->nxt_eqe_ba = ba[0];
+	count = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, eqe_ba, MTT_MIN_COUNT,
+				  &bt_ba);
+	if (count < 1) {
+		dev_err(hr_dev->dev, "failed to find EQE mtr\n");
+		return -ENOBUFS;
 	}
 
 	/* set eqc state */
@@ -5331,12 +5315,12 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 	/* set eqe_ba_pg_sz */
 	roce_set_field(eqc->byte_8, HNS_ROCE_EQC_BA_PG_SZ_M,
 		       HNS_ROCE_EQC_BA_PG_SZ_S,
-		       eq->eqe_ba_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(eq->mtr.hem_cfg.ba_pg_shift));
 
 	/* set eqe_buf_pg_sz */
 	roce_set_field(eqc->byte_8, HNS_ROCE_EQC_BUF_PG_SZ_M,
 		       HNS_ROCE_EQC_BUF_PG_SZ_S,
-		       eq->eqe_buf_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(eq->mtr.hem_cfg.buf_pg_shift));
 
 	/* set eq_producer_idx */
 	roce_set_field(eqc->byte_8, HNS_ROCE_EQC_PROD_INDX_M,
@@ -5355,13 +5339,13 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 		       HNS_ROCE_EQC_REPORT_TIMER_S,
 		       HNS_ROCE_EQ_INIT_REPORT_TIMER);
 
-	/* set eqe_ba [34:3] */
+	/* set bt_ba [34:3] */
 	roce_set_field(eqc->eqe_ba0, HNS_ROCE_EQC_EQE_BA_L_M,
-		       HNS_ROCE_EQC_EQE_BA_L_S, eq->eqe_ba >> 3);
+		       HNS_ROCE_EQC_EQE_BA_L_S, bt_ba >> 3);
 
-	/* set eqe_ba [64:35] */
+	/* set bt_ba [64:35] */
 	roce_set_field(eqc->eqe_ba1, HNS_ROCE_EQC_EQE_BA_H_M,
-		       HNS_ROCE_EQC_EQE_BA_H_S, eq->eqe_ba >> 35);
+		       HNS_ROCE_EQC_EQE_BA_H_S, bt_ba >> 35);
 
 	/* set eq shift */
 	roce_set_field(eqc->byte_28, HNS_ROCE_EQC_SHIFT_M, HNS_ROCE_EQC_SHIFT_S,
@@ -5373,15 +5357,15 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 
 	/* set cur_eqe_ba [27:12] */
 	roce_set_field(eqc->byte_28, HNS_ROCE_EQC_CUR_EQE_BA_L_M,
-		       HNS_ROCE_EQC_CUR_EQE_BA_L_S, eq->cur_eqe_ba >> 12);
+		       HNS_ROCE_EQC_CUR_EQE_BA_L_S, eqe_ba[0] >> 12);
 
 	/* set cur_eqe_ba [59:28] */
 	roce_set_field(eqc->byte_32, HNS_ROCE_EQC_CUR_EQE_BA_M_M,
-		       HNS_ROCE_EQC_CUR_EQE_BA_M_S, eq->cur_eqe_ba >> 28);
+		       HNS_ROCE_EQC_CUR_EQE_BA_M_S, eqe_ba[0] >> 28);
 
 	/* set cur_eqe_ba [63:60] */
 	roce_set_field(eqc->byte_36, HNS_ROCE_EQC_CUR_EQE_BA_H_M,
-		       HNS_ROCE_EQC_CUR_EQE_BA_H_S, eq->cur_eqe_ba >> 60);
+		       HNS_ROCE_EQC_CUR_EQE_BA_H_S, eqe_ba[0] >> 60);
 
 	/* set eq consumer idx */
 	roce_set_field(eqc->byte_36, HNS_ROCE_EQC_CONS_INDX_M,
@@ -5389,98 +5373,38 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 
 	/* set nex_eqe_ba[43:12] */
 	roce_set_field(eqc->nxt_eqe_ba0, HNS_ROCE_EQC_NXT_EQE_BA_L_M,
-		       HNS_ROCE_EQC_NXT_EQE_BA_L_S, eq->nxt_eqe_ba >> 12);
+		       HNS_ROCE_EQC_NXT_EQE_BA_L_S, eqe_ba[1] >> 12);
 
 	/* set nex_eqe_ba[63:44] */
 	roce_set_field(eqc->nxt_eqe_ba1, HNS_ROCE_EQC_NXT_EQE_BA_H_M,
-		       HNS_ROCE_EQC_NXT_EQE_BA_H_S, eq->nxt_eqe_ba >> 44);
-}
+		       HNS_ROCE_EQC_NXT_EQE_BA_H_S, eqe_ba[1] >> 44);
 
-static int map_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
-		      u32 page_shift)
-{
-	struct hns_roce_buf_region region = {};
-	dma_addr_t *buf_list = NULL;
-	int ba_num;
-	int ret;
-
-	ba_num = DIV_ROUND_UP(PAGE_ALIGN(eq->entries * eq->eqe_size),
-			      1 << page_shift);
-	hns_roce_init_buf_region(&region, hr_dev->caps.eqe_hop_num, 0, ba_num);
-
-	/* alloc a tmp list for storing eq buf address */
-	ret = hns_roce_alloc_buf_list(&region, &buf_list, 1);
-	if (ret) {
-		dev_err(hr_dev->dev, "alloc eq buf_list error\n");
-		return ret;
-	}
-
-	ba_num = hns_roce_get_kmem_bufs(hr_dev, buf_list, region.count,
-					region.offset, &eq->buf);
-	if (ba_num != region.count) {
-		dev_err(hr_dev->dev, "get eqe buf err,expect %d,ret %d.\n",
-			region.count, ba_num);
-		ret = -ENOBUFS;
-		goto done;
-	}
-
-	hns_roce_mtr_init(&eq->mtr, PAGE_ADDR_SHIFT + hr_dev->caps.eqe_ba_pg_sz,
-			  page_shift);
-	ret = hns_roce_mtr_attach(hr_dev, &eq->mtr, &buf_list, &region, 1);
-	if (ret)
-		dev_err(hr_dev->dev, "mtr attach error for eqe\n");
-
-	goto done;
-
-	hns_roce_mtr_cleanup(hr_dev, &eq->mtr);
-done:
-	hns_roce_free_buf_list(&buf_list, 1);
-
-	return ret;
+	return 0;
 }
 
 static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 {
-	struct hns_roce_buf *buf = &eq->buf;
-	bool is_mhop = false;
-	u32 page_shift;
-	u32 mhop_num;
-	u32 max_size;
-	u32 buf_size;
-	int ret;
+	struct hns_roce_buf_attr buf_attr = {};
+	int err;
 
-	page_shift = PAGE_ADDR_SHIFT + hr_dev->caps.eqe_buf_pg_sz;
-	mhop_num = hr_dev->caps.eqe_hop_num;
-	if (!mhop_num) {
-		max_size = 1 << page_shift;
-		buf_size = max_size;
-	} else if (mhop_num == HNS_ROCE_HOP_NUM_0) {
-		max_size = eq->entries * eq->eqe_size;
-		buf_size = max_size;
-	} else {
-		max_size = 1 << page_shift;
-		buf_size = round_up(eq->entries * eq->eqe_size, max_size);
-		is_mhop = true;
-	}
+	if (hr_dev->caps.eqe_hop_num == HNS_ROCE_HOP_NUM_0)
+		eq->hop_num = 0;
+	else
+		eq->hop_num = hr_dev->caps.eqe_hop_num;
 
-	ret = hns_roce_buf_alloc(hr_dev, buf_size, max_size, buf, page_shift);
-	if (ret) {
-		dev_err(hr_dev->dev, "alloc eq buf error\n");
-		return ret;
-	}
+	buf_attr.page_shift = hr_dev->caps.eqe_buf_pg_sz + PAGE_ADDR_SHIFT;
+	buf_attr.region[0].size = eq->entries * eq->eqe_size;
+	buf_attr.region[0].hopnum = eq->hop_num;
+	buf_attr.region_count = 1;
+	buf_attr.fixed_page = true;
 
-	if (is_mhop) {
-		ret = map_eq_buf(hr_dev, eq, page_shift);
-		if (ret) {
-			dev_err(hr_dev->dev, "map roce buf error\n");
-			goto err_alloc;
-		}
-	}
+	err = hns_roce_mtr_create(hr_dev, &eq->mtr, &buf_attr,
+				  hr_dev->caps.srqwqe_ba_pg_sz +
+				  PAGE_ADDR_SHIFT, NULL, 0);
+	if (err)
+		dev_err(hr_dev->dev, "Failed to alloc EQE mtr, err %d\n", err);
 
-	return 0;
-err_alloc:
-	hns_roce_buf_free(hr_dev, buf);
-	return ret;
+	return err;
 }
 
 static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
@@ -5492,15 +5416,16 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 
 	/* Allocate mailbox memory */
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox))
-		return PTR_ERR(mailbox);
+	if (IS_ERR_OR_NULL(mailbox))
+		return -ENOMEM;
 
 	ret = alloc_eq_buf(hr_dev, eq);
-	if (ret) {
-		ret = -ENOMEM;
+	if (ret)
 		goto free_cmd_mbox;
-	}
-	hns_roce_config_eqc(hr_dev, eq, mailbox->buf);
+
+	ret = config_eqc(hr_dev, eq, mailbox->buf);
+	if (ret)
+		goto err_cmd_mbox;
 
 	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, eq->eqn, 0,
 				eq_cmd, HNS_ROCE_CMD_TIMEOUT_MSECS);
-- 
2.8.1

