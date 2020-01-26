Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89384149B33
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAZO66 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:58:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55862 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgAZO66 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:58:58 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B03904778A3581BCA123;
        Sun, 26 Jan 2020 22:58:54 +0800 (CST)
Received: from SZA160416817.china.huawei.com (10.45.215.46) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Sun, 26 Jan 2020 22:58:46 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Optimize eqe buffer allocation flow
Date:   Sun, 26 Jan 2020 22:58:35 +0800
Message-ID: <20200126145835.11368-1-liweihang@huawei.com>
X-Mailer: git-send-email 2.10.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.45.215.46]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The eqe has a private multi-hop addressing implementation, but there is
already a set of interfaces in the hns driver that can achieve this.

So, simplify the eqe buffer allocation process by using the mtr interface
and remove large amount of repeated logic.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  10 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 481 ++++++----------------------
 2 files changed, 108 insertions(+), 383 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a4c45bf..dab3f3c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -757,14 +757,8 @@ struct hns_roce_eq {
 	int				eqe_ba_pg_sz;
 	int				eqe_buf_pg_sz;
 	int				hop_num;
-	u64				*bt_l0;	/* Base address table for L0 */
-	u64				**bt_l1; /* Base address table for L1 */
-	u64				**buf;
-	dma_addr_t			l0_dma;
-	dma_addr_t			*l1_dma;
-	dma_addr_t			*buf_dma;
-	u32				l0_last_num; /* L0 last chunk num */
-	u32				l1_last_num; /* L1 last chunk num */
+	struct hns_roce_mtr		mtr;
+	struct hns_roce_buf		buf;
 	int				eq_max_cnt;
 	int				eq_period;
 	int				shift;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c462b19..88f2e76 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5287,44 +5287,24 @@ static void set_eq_cons_index_v2(struct hns_roce_eq *eq)
 	hns_roce_write64(hr_dev, doorbell, eq->doorbell);
 }
 
-static struct hns_roce_aeqe *get_aeqe_v2(struct hns_roce_eq *eq, u32 entry)
+static inline void *get_eqe_buf(struct hns_roce_eq *eq, unsigned long offset)
 {
 	u32 buf_chk_sz;
-	unsigned long off;
 
 	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
-	off = (entry & (eq->entries - 1)) * HNS_ROCE_AEQ_ENTRY_SIZE;
-
-	return (struct hns_roce_aeqe *)((char *)(eq->buf_list->buf) +
-		off % buf_chk_sz);
-}
-
-static struct hns_roce_aeqe *mhop_get_aeqe(struct hns_roce_eq *eq, u32 entry)
-{
-	u32 buf_chk_sz;
-	unsigned long off;
-
-	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
-
-	off = (entry & (eq->entries - 1)) * HNS_ROCE_AEQ_ENTRY_SIZE;
-
-	if (eq->hop_num == HNS_ROCE_HOP_NUM_0)
-		return (struct hns_roce_aeqe *)((u8 *)(eq->bt_l0) +
-			off % buf_chk_sz);
+	if (eq->buf.nbufs == 1)
+		return eq->buf.direct.buf + offset % buf_chk_sz;
 	else
-		return (struct hns_roce_aeqe *)((u8 *)
-			(eq->buf[off / buf_chk_sz]) + off % buf_chk_sz);
+		return eq->buf.page_list[offset / buf_chk_sz].buf +
+		       offset % buf_chk_sz;
 }
 
 static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_aeqe *aeqe;
 
-	if (!eq->hop_num)
-		aeqe = get_aeqe_v2(eq, eq->cons_index);
-	else
-		aeqe = mhop_get_aeqe(eq, eq->cons_index);
-
+	aeqe = get_eqe_buf(eq, (eq->cons_index & (eq->entries - 1)) *
+			   HNS_ROCE_AEQ_ENTRY_SIZE);
 	return (roce_get_bit(aeqe->asyn, HNS_ROCE_V2_AEQ_AEQE_OWNER_S) ^
 		!!(eq->cons_index & eq->entries)) ? aeqe : NULL;
 }
@@ -5417,44 +5397,12 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 	return aeqe_found;
 }
 
-static struct hns_roce_ceqe *get_ceqe_v2(struct hns_roce_eq *eq, u32 entry)
-{
-	u32 buf_chk_sz;
-	unsigned long off;
-
-	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
-	off = (entry & (eq->entries - 1)) * HNS_ROCE_CEQ_ENTRY_SIZE;
-
-	return (struct hns_roce_ceqe *)((char *)(eq->buf_list->buf) +
-		off % buf_chk_sz);
-}
-
-static struct hns_roce_ceqe *mhop_get_ceqe(struct hns_roce_eq *eq, u32 entry)
-{
-	u32 buf_chk_sz;
-	unsigned long off;
-
-	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
-
-	off = (entry & (eq->entries - 1)) * HNS_ROCE_CEQ_ENTRY_SIZE;
-
-	if (eq->hop_num == HNS_ROCE_HOP_NUM_0)
-		return (struct hns_roce_ceqe *)((u8 *)(eq->bt_l0) +
-			off % buf_chk_sz);
-	else
-		return (struct hns_roce_ceqe *)((u8 *)(eq->buf[off /
-			buf_chk_sz]) + off % buf_chk_sz);
-}
-
 static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_ceqe *ceqe;
 
-	if (!eq->hop_num)
-		ceqe = get_ceqe_v2(eq, eq->cons_index);
-	else
-		ceqe = mhop_get_ceqe(eq, eq->cons_index);
-
+	ceqe = get_eqe_buf(eq, (eq->cons_index & (eq->entries - 1)) *
+			   HNS_ROCE_CEQ_ENTRY_SIZE);
 	return (!!(roce_get_bit(ceqe->comp, HNS_ROCE_V2_CEQ_CEQE_OWNER_S))) ^
 		(!!(eq->cons_index & eq->entries)) ? ceqe : NULL;
 }
@@ -5614,90 +5562,11 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, int eqn)
 		dev_err(dev, "[mailbox cmd] destroy eqc(%d) failed.\n", eqn);
 }
 
-static void hns_roce_mhop_free_eq(struct hns_roce_dev *hr_dev,
-				  struct hns_roce_eq *eq)
+static void free_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 {
-	struct device *dev = hr_dev->dev;
-	u64 idx;
-	u64 size;
-	u32 buf_chk_sz;
-	u32 bt_chk_sz;
-	u32 mhop_num;
-	int eqe_alloc;
-	int i = 0;
-	int j = 0;
-
-	mhop_num = hr_dev->caps.eqe_hop_num;
-	buf_chk_sz = 1 << (hr_dev->caps.eqe_buf_pg_sz + PAGE_SHIFT);
-	bt_chk_sz = 1 << (hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT);
-
-	if (mhop_num == HNS_ROCE_HOP_NUM_0) {
-		dma_free_coherent(dev, (unsigned int)(eq->entries *
-				  eq->eqe_size), eq->bt_l0, eq->l0_dma);
-		return;
-	}
-
-	dma_free_coherent(dev, bt_chk_sz, eq->bt_l0, eq->l0_dma);
-	if (mhop_num == 1) {
-		for (i = 0; i < eq->l0_last_num; i++) {
-			if (i == eq->l0_last_num - 1) {
-				eqe_alloc = i * (buf_chk_sz / eq->eqe_size);
-				size = (eq->entries - eqe_alloc) * eq->eqe_size;
-				dma_free_coherent(dev, size, eq->buf[i],
-						  eq->buf_dma[i]);
-				break;
-			}
-			dma_free_coherent(dev, buf_chk_sz, eq->buf[i],
-					  eq->buf_dma[i]);
-		}
-	} else if (mhop_num == 2) {
-		for (i = 0; i < eq->l0_last_num; i++) {
-			dma_free_coherent(dev, bt_chk_sz, eq->bt_l1[i],
-					  eq->l1_dma[i]);
-
-			for (j = 0; j < bt_chk_sz / BA_BYTE_LEN; j++) {
-				idx = i * (bt_chk_sz / BA_BYTE_LEN) + j;
-				if ((i == eq->l0_last_num - 1)
-				     && j == eq->l1_last_num - 1) {
-					eqe_alloc = (buf_chk_sz / eq->eqe_size)
-						    * idx;
-					size = (eq->entries - eqe_alloc)
-						* eq->eqe_size;
-					dma_free_coherent(dev, size,
-							  eq->buf[idx],
-							  eq->buf_dma[idx]);
-					break;
-				}
-				dma_free_coherent(dev, buf_chk_sz, eq->buf[idx],
-						  eq->buf_dma[idx]);
-			}
-		}
-	}
-	kfree(eq->buf_dma);
-	kfree(eq->buf);
-	kfree(eq->l1_dma);
-	kfree(eq->bt_l1);
-	eq->buf_dma = NULL;
-	eq->buf = NULL;
-	eq->l1_dma = NULL;
-	eq->bt_l1 = NULL;
-}
-
-static void hns_roce_v2_free_eq(struct hns_roce_dev *hr_dev,
-				struct hns_roce_eq *eq)
-{
-	u32 buf_chk_sz;
-
-	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
-
-	if (hr_dev->caps.eqe_hop_num) {
-		hns_roce_mhop_free_eq(hr_dev, eq);
-		return;
-	}
-
-	dma_free_coherent(hr_dev->dev, buf_chk_sz, eq->buf_list->buf,
-			  eq->buf_list->map);
-	kfree(eq->buf_list);
+	if (!eq->hop_num || eq->hop_num == HNS_ROCE_HOP_NUM_0)
+		hns_roce_mtr_cleanup(hr_dev, &eq->mtr);
+	hns_roce_buf_free(hr_dev, eq->buf.size, &eq->buf);
 }
 
 static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
@@ -5705,6 +5574,8 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 				void *mb_buf)
 {
 	struct hns_roce_eq_context *eqc;
+	u64 ba[MTT_MIN_COUNT] = { 0 };
+	int count;
 
 	eqc = mb_buf;
 	memset(eqc, 0, sizeof(struct hns_roce_eq_context));
@@ -5720,10 +5591,23 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 	eq->eqe_buf_pg_sz = hr_dev->caps.eqe_buf_pg_sz;
 	eq->shift = ilog2((unsigned int)eq->entries);
 
-	if (!eq->hop_num)
-		eq->eqe_ba = eq->buf_list->map;
-	else
-		eq->eqe_ba = eq->l0_dma;
+	/* if not muti-hop, eqe buffer only use one trunk */
+	if (!eq->hop_num || eq->hop_num == HNS_ROCE_HOP_NUM_0) {
+		eq->eqe_ba = eq->buf.direct.map;
+		eq->cur_eqe_ba = eq->eqe_ba;
+		if (eq->buf.npages > 1)
+			eq->nxt_eqe_ba = eq->eqe_ba + (1 << eq->eqe_buf_pg_sz);
+		else
+			eq->nxt_eqe_ba = eq->eqe_ba;
+	} else {
+		count = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, ba,
+					  MTT_MIN_COUNT, &eq->eqe_ba);
+		eq->cur_eqe_ba = ba[0];
+		if (count > 1)
+			eq->nxt_eqe_ba = ba[1];
+		else
+			eq->nxt_eqe_ba = ba[0];
+	}
 
 	/* set eqc state */
 	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_EQ_ST_M, HNS_ROCE_EQC_EQ_ST_S,
@@ -5821,220 +5705,97 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 		       HNS_ROCE_EQC_NXT_EQE_BA_H_S, eq->nxt_eqe_ba >> 44);
 }
 
-static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
-				  struct hns_roce_eq *eq)
+static int map_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
+		      u32 page_shift)
 {
-	struct device *dev = hr_dev->dev;
-	int eq_alloc_done = 0;
-	int eq_buf_cnt = 0;
-	int eqe_alloc;
-	u32 buf_chk_sz;
-	u32 bt_chk_sz;
-	u32 mhop_num;
-	u64 size;
-	u64 idx;
+	struct hns_roce_buf_region region = {};
+	dma_addr_t *buf_list = NULL;
 	int ba_num;
-	int bt_num;
-	int record_i;
-	int record_j;
-	int i = 0;
-	int j = 0;
-
-	mhop_num = hr_dev->caps.eqe_hop_num;
-	buf_chk_sz = 1 << (hr_dev->caps.eqe_buf_pg_sz + PAGE_SHIFT);
-	bt_chk_sz = 1 << (hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT);
+	int ret;
 
 	ba_num = DIV_ROUND_UP(PAGE_ALIGN(eq->entries * eq->eqe_size),
-			      buf_chk_sz);
-	bt_num = DIV_ROUND_UP(ba_num, bt_chk_sz / BA_BYTE_LEN);
+			      1 << page_shift);
+	hns_roce_init_buf_region(&region, hr_dev->caps.eqe_hop_num, 0, ba_num);
 
-	if (mhop_num == HNS_ROCE_HOP_NUM_0) {
-		if (eq->entries > buf_chk_sz / eq->eqe_size) {
-			dev_err(dev, "eq entries %d is larger than buf_pg_sz!",
-				eq->entries);
-			return -EINVAL;
-		}
-		eq->bt_l0 = dma_alloc_coherent(dev, eq->entries * eq->eqe_size,
-					       &(eq->l0_dma), GFP_KERNEL);
-		if (!eq->bt_l0)
-			return -ENOMEM;
-
-		eq->cur_eqe_ba = eq->l0_dma;
-		eq->nxt_eqe_ba = 0;
+	/* alloc a tmp list for storing eq buf address */
+	ret = hns_roce_alloc_buf_list(&region, &buf_list, 1);
+	if (ret) {
+		dev_err(hr_dev->dev, "alloc eq buf_list error\n");
+		return ret;
+	}
 
-		return 0;
+	ba_num = hns_roce_get_kmem_bufs(hr_dev, buf_list, region.count,
+					region.offset, &eq->buf);
+	if (ba_num != region.count) {
+		dev_err(hr_dev->dev, "get eqe buf err,expect %d,ret %d.\n",
+			region.count, ba_num);
+		ret = -ENOBUFS;
+		goto done;
 	}
 
-	eq->buf_dma = kcalloc(ba_num, sizeof(*eq->buf_dma), GFP_KERNEL);
-	if (!eq->buf_dma)
-		return -ENOMEM;
-	eq->buf = kcalloc(ba_num, sizeof(*eq->buf), GFP_KERNEL);
-	if (!eq->buf)
-		goto err_kcalloc_buf;
-
-	if (mhop_num == 2) {
-		eq->l1_dma = kcalloc(bt_num, sizeof(*eq->l1_dma), GFP_KERNEL);
-		if (!eq->l1_dma)
-			goto err_kcalloc_l1_dma;
-
-		eq->bt_l1 = kcalloc(bt_num, sizeof(*eq->bt_l1), GFP_KERNEL);
-		if (!eq->bt_l1)
-			goto err_kcalloc_bt_l1;
-	}
-
-	/* alloc L0 BT */
-	eq->bt_l0 = dma_alloc_coherent(dev, bt_chk_sz, &eq->l0_dma, GFP_KERNEL);
-	if (!eq->bt_l0)
-		goto err_dma_alloc_l0;
-
-	if (mhop_num == 1) {
-		if (ba_num > (bt_chk_sz / BA_BYTE_LEN))
-			dev_err(dev, "ba_num %d is too large for 1 hop\n",
-				ba_num);
-
-		/* alloc buf */
-		for (i = 0; i < bt_chk_sz / BA_BYTE_LEN; i++) {
-			if (eq_buf_cnt + 1 < ba_num) {
-				size = buf_chk_sz;
-			} else {
-				eqe_alloc = i * (buf_chk_sz / eq->eqe_size);
-				size = (eq->entries - eqe_alloc) * eq->eqe_size;
-			}
-			eq->buf[i] = dma_alloc_coherent(dev, size,
-							&(eq->buf_dma[i]),
-							GFP_KERNEL);
-			if (!eq->buf[i])
-				goto err_dma_alloc_buf;
+	hns_roce_mtr_init(&eq->mtr, PAGE_SHIFT + hr_dev->caps.eqe_ba_pg_sz,
+			  page_shift);
+	ret = hns_roce_mtr_attach(hr_dev, &eq->mtr, &buf_list, &region, 1);
+	if (ret)
+		dev_err(hr_dev->dev, "mtr attatch error for eqe\n");
 
-			*(eq->bt_l0 + i) = eq->buf_dma[i];
+	goto done;
 
-			eq_buf_cnt++;
-			if (eq_buf_cnt >= ba_num)
-				break;
-		}
-		eq->cur_eqe_ba = eq->buf_dma[0];
-		if (ba_num > 1)
-			eq->nxt_eqe_ba = eq->buf_dma[1];
-
-	} else if (mhop_num == 2) {
-		/* alloc L1 BT and buf */
-		for (i = 0; i < bt_chk_sz / BA_BYTE_LEN; i++) {
-			eq->bt_l1[i] = dma_alloc_coherent(dev, bt_chk_sz,
-							  &(eq->l1_dma[i]),
-							  GFP_KERNEL);
-			if (!eq->bt_l1[i])
-				goto err_dma_alloc_l1;
-			*(eq->bt_l0 + i) = eq->l1_dma[i];
-
-			for (j = 0; j < bt_chk_sz / BA_BYTE_LEN; j++) {
-				idx = i * bt_chk_sz / BA_BYTE_LEN + j;
-				if (eq_buf_cnt + 1 < ba_num) {
-					size = buf_chk_sz;
-				} else {
-					eqe_alloc = (buf_chk_sz / eq->eqe_size)
-						    * idx;
-					size = (eq->entries - eqe_alloc)
-						* eq->eqe_size;
-				}
-				eq->buf[idx] = dma_alloc_coherent(dev, size,
-								  &(eq->buf_dma[idx]),
-								  GFP_KERNEL);
-				if (!eq->buf[idx])
-					goto err_dma_alloc_buf;
-
-				*(eq->bt_l1[i] + j) = eq->buf_dma[idx];
-
-				eq_buf_cnt++;
-				if (eq_buf_cnt >= ba_num) {
-					eq_alloc_done = 1;
-					break;
-				}
-			}
+	hns_roce_mtr_cleanup(hr_dev, &eq->mtr);
+done:
+	hns_roce_free_buf_list(&buf_list, 1);
 
-			if (eq_alloc_done)
-				break;
-		}
-		eq->cur_eqe_ba = eq->buf_dma[0];
-		if (ba_num > 1)
-			eq->nxt_eqe_ba = eq->buf_dma[1];
-	}
+	return ret;
+}
 
-	eq->l0_last_num = i + 1;
-	if (mhop_num == 2)
-		eq->l1_last_num = j + 1;
+static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
+{
+	struct hns_roce_buf *buf = &eq->buf;
+	bool is_mhop = false;
+	u32 page_shift;
+	u32 mhop_num;
+	u32 max_size;
+	int ret;
 
-	return 0;
+	page_shift = PAGE_SHIFT + hr_dev->caps.eqe_buf_pg_sz;
+	mhop_num = hr_dev->caps.eqe_hop_num;
+	if (!mhop_num) {
+		max_size = 1 << page_shift;
+		buf->size = max_size;
+	} else if (mhop_num == HNS_ROCE_HOP_NUM_0) {
+		max_size = eq->entries * eq->eqe_size;
+		buf->size = max_size;
+	} else {
+		max_size = 1 << page_shift;
+		buf->size = PAGE_ALIGN(eq->entries * eq->eqe_size);
+		is_mhop = true;
+	}
 
-err_dma_alloc_l1:
-	dma_free_coherent(dev, bt_chk_sz, eq->bt_l0, eq->l0_dma);
-	eq->bt_l0 = NULL;
-	eq->l0_dma = 0;
-	for (i -= 1; i >= 0; i--) {
-		dma_free_coherent(dev, bt_chk_sz, eq->bt_l1[i],
-				  eq->l1_dma[i]);
-
-		for (j = 0; j < bt_chk_sz / BA_BYTE_LEN; j++) {
-			idx = i * bt_chk_sz / BA_BYTE_LEN + j;
-			dma_free_coherent(dev, buf_chk_sz, eq->buf[idx],
-					  eq->buf_dma[idx]);
-		}
+	ret = hns_roce_buf_alloc(hr_dev, buf->size, max_size, buf, page_shift);
+	if (ret) {
+		dev_err(hr_dev->dev, "alloc eq buf error\n");
+		return ret;
 	}
-	goto err_dma_alloc_l0;
-
-err_dma_alloc_buf:
-	dma_free_coherent(dev, bt_chk_sz, eq->bt_l0, eq->l0_dma);
-	eq->bt_l0 = NULL;
-	eq->l0_dma = 0;
-
-	if (mhop_num == 1)
-		for (i -= 1; i >= 0; i--)
-			dma_free_coherent(dev, buf_chk_sz, eq->buf[i],
-					  eq->buf_dma[i]);
-	else if (mhop_num == 2) {
-		record_i = i;
-		record_j = j;
-		for (; i >= 0; i--) {
-			dma_free_coherent(dev, bt_chk_sz, eq->bt_l1[i],
-					  eq->l1_dma[i]);
-
-			for (j = 0; j < bt_chk_sz / BA_BYTE_LEN; j++) {
-				if (i == record_i && j >= record_j)
-					break;
-
-				idx = i * bt_chk_sz / BA_BYTE_LEN + j;
-				dma_free_coherent(dev, buf_chk_sz,
-						  eq->buf[idx],
-						  eq->buf_dma[idx]);
-			}
+
+	if (is_mhop) {
+		ret = map_eq_buf(hr_dev, eq, page_shift);
+		if (ret) {
+			dev_err(hr_dev->dev, "map roce buf error\n");
+			goto err_alloc;
 		}
 	}
 
-err_dma_alloc_l0:
-	kfree(eq->bt_l1);
-	eq->bt_l1 = NULL;
-
-err_kcalloc_bt_l1:
-	kfree(eq->l1_dma);
-	eq->l1_dma = NULL;
-
-err_kcalloc_l1_dma:
-	kfree(eq->buf);
-	eq->buf = NULL;
-
-err_kcalloc_buf:
-	kfree(eq->buf_dma);
-	eq->buf_dma = NULL;
-
-	return -ENOMEM;
+	return 0;
+err_alloc:
+	hns_roce_buf_free(hr_dev, buf->size, buf);
+	return ret;
 }
 
 static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_eq *eq,
 				 unsigned int eq_cmd)
 {
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_cmd_mailbox *mailbox;
-	u32 buf_chk_sz = 0;
 	int ret;
 
 	/* Allocate mailbox memory */
@@ -6042,38 +5803,17 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
-	if (!hr_dev->caps.eqe_hop_num) {
-		buf_chk_sz = 1 << (hr_dev->caps.eqe_buf_pg_sz + PAGE_SHIFT);
-
-		eq->buf_list = kzalloc(sizeof(struct hns_roce_buf_list),
-				       GFP_KERNEL);
-		if (!eq->buf_list) {
-			ret = -ENOMEM;
-			goto free_cmd_mbox;
-		}
-
-		eq->buf_list->buf = dma_alloc_coherent(dev, buf_chk_sz,
-						       &(eq->buf_list->map),
-						       GFP_KERNEL);
-		if (!eq->buf_list->buf) {
-			ret = -ENOMEM;
-			goto err_alloc_buf;
-		}
-
-	} else {
-		ret = hns_roce_mhop_alloc_eq(hr_dev, eq);
-		if (ret) {
-			ret = -ENOMEM;
-			goto free_cmd_mbox;
-		}
+	ret = alloc_eq_buf(hr_dev, eq);
+	if (ret) {
+		ret = -ENOMEM;
+		goto free_cmd_mbox;
 	}
-
 	hns_roce_config_eqc(hr_dev, eq, mailbox->buf);
 
 	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, eq->eqn, 0,
 				eq_cmd, HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret) {
-		dev_err(dev, "[mailbox cmd] create eqc failed.\n");
+		dev_err(hr_dev->dev, "[mailbox cmd] create eqc failed.\n");
 		goto err_cmd_mbox;
 	}
 
@@ -6082,16 +5822,7 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 	return 0;
 
 err_cmd_mbox:
-	if (!hr_dev->caps.eqe_hop_num)
-		dma_free_coherent(dev, buf_chk_sz, eq->buf_list->buf,
-				  eq->buf_list->map);
-	else {
-		hns_roce_mhop_free_eq(hr_dev, eq);
-		goto free_cmd_mbox;
-	}
-
-err_alloc_buf:
-	kfree(eq->buf_list);
+	free_eq_buf(hr_dev, eq);
 
 free_cmd_mbox:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
@@ -6271,7 +6002,7 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 
 err_create_eq_fail:
 	for (i -= 1; i >= 0; i--)
-		hns_roce_v2_free_eq(hr_dev, &eq_table->eq[i]);
+		free_eq_buf(hr_dev, &eq_table->eq[i]);
 	kfree(eq_table->eq);
 
 	return ret;
@@ -6293,7 +6024,7 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	for (i = 0; i < eq_num; i++) {
 		hns_roce_v2_destroy_eqc(hr_dev, i);
 
-		hns_roce_v2_free_eq(hr_dev, &eq_table->eq[i]);
+		free_eq_buf(hr_dev, &eq_table->eq[i]);
 	}
 
 	kfree(eq_table->eq);
-- 
2.8.1


