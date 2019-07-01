Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93739B66
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 08:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFHGnV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 02:43:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726836AbfFHGnV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Jun 2019 02:43:21 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0152CDE70D08F53EF660;
        Sat,  8 Jun 2019 14:43:18 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 8 Jun 2019 14:43:11 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V5 for-next 1/3] RDMA/hns: Add mtr support for mixed multihop addressing
Date:   Sat, 8 Jun 2019 14:46:08 +0800
Message-ID: <1559976370-46306-2-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559976370-46306-1-git-send-email-oulijun@huawei.com>
References: <1559976370-46306-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, the MTT(memory translate table) design required a buffer
space must has the same hopnum, but the hip08 hw can support mixed
hopnum config in a buffer space.

This patch adds the MTR(memory translate region) design for supporting
mixed multihop.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
V4->V5:
1. Delete unnecessary mb().

V3->V4:
- No fix

V2->V3:
- No fix

V1->V2:
1. Remove the package for kernel primitives and directly use it
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  36 +++
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 460 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  14 +
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 118 +++++++
 4 files changed, 628 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index ce23338..0ec5a24 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -341,6 +341,29 @@ struct hns_roce_mtt {
 	enum hns_roce_mtt_type	mtt_type;
 };
 
+struct hns_roce_buf_region {
+	int offset; /* page offset */
+	u32 count; /* page count*/
+	int hopnum; /* addressing hop num */
+};
+
+#define HNS_ROCE_MAX_BT_REGION	3
+#define HNS_ROCE_MAX_BT_LEVEL	3
+struct hns_roce_hem_list {
+	struct list_head root_bt;
+	/* link all bt dma mem by hop config */
+	struct list_head mid_bt[HNS_ROCE_MAX_BT_REGION][HNS_ROCE_MAX_BT_LEVEL];
+	struct list_head btm_bt; /* link all bottom bt in @mid_bt */
+	dma_addr_t root_ba; /* pointer to the root ba table */
+	int bt_pg_shift;
+};
+
+/* memory translate region */
+struct hns_roce_mtr {
+	struct hns_roce_hem_list hem_list;
+	int buf_pg_shift;
+};
+
 struct hns_roce_mw {
 	struct ib_mw		ibmw;
 	u32			pdn;
@@ -1111,6 +1134,19 @@ void hns_roce_mtt_cleanup(struct hns_roce_dev *hr_dev,
 int hns_roce_buf_write_mtt(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_mtt *mtt, struct hns_roce_buf *buf);
 
+void hns_roce_mtr_init(struct hns_roce_mtr *mtr, int bt_pg_shift,
+		       int buf_pg_shift);
+int hns_roce_mtr_attach(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+			dma_addr_t **bufs, struct hns_roce_buf_region *regions,
+			int region_cnt);
+void hns_roce_mtr_cleanup(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_mtr *mtr);
+
+/* hns roce hw need current block and next block addr from mtt */
+#define MTT_MIN_COUNT	 2
+int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr);
+
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_eq_table(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 157c84a..8006ef4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1157,3 +1157,463 @@ void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
 					   &hr_dev->mr_table.mtt_cqe_table);
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->mr_table.mtt_table);
 }
+
+struct roce_hem_item {
+	struct list_head list; /* link all hems in the same bt level */
+	struct list_head sibling; /* link all hems in last hop for mtt */
+	void *addr;
+	dma_addr_t dma_addr;
+	size_t count; /* max ba numbers */
+	int start; /* start buf offset in this hem */
+	int end; /* end buf offset in this hem */
+};
+
+static struct roce_hem_item *hem_list_alloc_item(struct hns_roce_dev *hr_dev,
+						   int start, int end,
+						   int count, bool exist_bt,
+						   int bt_level)
+{
+	struct roce_hem_item *hem;
+
+	hem = kzalloc(sizeof(*hem), GFP_KERNEL);
+	if (!hem)
+		return NULL;
+
+	if (exist_bt) {
+		hem->addr = dma_alloc_coherent(hr_dev->dev,
+						   count * BA_BYTE_LEN,
+						   &hem->dma_addr, GFP_KERNEL);
+		if (!hem->addr) {
+			kfree(hem);
+			return NULL;
+		}
+	}
+
+	hem->count = count;
+	hem->start = start;
+	hem->end = end;
+	INIT_LIST_HEAD(&hem->list);
+	INIT_LIST_HEAD(&hem->sibling);
+
+	return hem;
+}
+
+static void hem_list_free_item(struct hns_roce_dev *hr_dev,
+			       struct roce_hem_item *hem, bool exist_bt)
+{
+	if (exist_bt)
+		dma_free_coherent(hr_dev->dev, hem->count * BA_BYTE_LEN,
+				  hem->addr, hem->dma_addr);
+	kfree(hem);
+}
+
+static void hem_list_free_all(struct hns_roce_dev *hr_dev,
+			      struct list_head *head, bool exist_bt)
+{
+	struct roce_hem_item *hem, *temp_hem;
+
+	list_for_each_entry_safe(hem, temp_hem, head, list) {
+		list_del(&hem->list);
+		hem_list_free_item(hr_dev, hem, exist_bt);
+	}
+}
+
+static void hem_list_link_bt(struct hns_roce_dev *hr_dev, void *base_addr,
+			     u64 table_addr)
+{
+	*(u64 *)(base_addr) = table_addr;
+}
+
+/* assign L0 table address to hem from root bt */
+static void hem_list_assign_bt(struct hns_roce_dev *hr_dev,
+			       struct roce_hem_item *hem, void *cpu_addr,
+			       u64 phy_addr)
+{
+	hem->addr = cpu_addr;
+	hem->dma_addr = (dma_addr_t)phy_addr;
+}
+
+static inline bool hem_list_page_is_in_range(struct roce_hem_item *hem,
+					     int offset)
+{
+	return (hem->start <= offset && offset <= hem->end);
+}
+
+static struct roce_hem_item *hem_list_search_item(struct list_head *ba_list,
+						    int page_offset)
+{
+	struct roce_hem_item *hem, *temp_hem;
+	struct roce_hem_item *found = NULL;
+
+	list_for_each_entry_safe(hem, temp_hem, ba_list, list) {
+		if (hem_list_page_is_in_range(hem, page_offset)) {
+			found = hem;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static bool hem_list_is_bottom_bt(int hopnum, int bt_level)
+{
+	/*
+	 * hopnum    base address table levels
+	 * 0		L0(buf)
+	 * 1		L0 -> buf
+	 * 2		L0 -> L1 -> buf
+	 * 3		L0 -> L1 -> L2 -> buf
+	 */
+	return bt_level >= (hopnum ? hopnum - 1 : hopnum);
+}
+
+/**
+ * calc base address entries num
+ * @hopnum: num of mutihop addressing
+ * @bt_level: base address table level
+ * @unit: ba entries per bt page
+ */
+static u32 hem_list_calc_ba_range(int hopnum, int bt_level, int unit)
+{
+	u32 step;
+	int max;
+	int i;
+
+	if (hopnum <= bt_level)
+		return 0;
+	/*
+	 * hopnum  bt_level   range
+	 * 1	      0       unit
+	 * ------------
+	 * 2	      0       unit * unit
+	 * 2	      1       unit
+	 * ------------
+	 * 3	      0       unit * unit * unit
+	 * 3	      1       unit * unit
+	 * 3	      2       unit
+	 */
+	step = 1;
+	max = hopnum - bt_level;
+	for (i = 0; i < max; i++)
+		step = step * unit;
+
+	return step;
+}
+
+/**
+ * calc the root ba entries which could cover all regions
+ * @regions: buf region array
+ * @region_cnt: array size of @regions
+ * @unit: ba entries per bt page
+ */
+int hns_roce_hem_list_calc_root_ba(const struct hns_roce_buf_region *regions,
+				   int region_cnt, int unit)
+{
+	struct hns_roce_buf_region *r;
+	int total = 0;
+	int step;
+	int i;
+
+	for (i = 0; i < region_cnt; i++) {
+		r = (struct hns_roce_buf_region *)&regions[i];
+		if (r->hopnum > 1) {
+			step = hem_list_calc_ba_range(r->hopnum, 1, unit);
+			if (step > 0)
+				total += (r->count + step - 1) / step;
+		} else {
+			total += r->count;
+		}
+	}
+
+	return total;
+}
+
+static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
+				 const struct hns_roce_buf_region *r, int unit,
+				 int offset, struct list_head *mid_bt,
+				 struct list_head *btm_bt)
+{
+	struct roce_hem_item *hem_ptrs[HNS_ROCE_MAX_BT_LEVEL] = { NULL };
+	struct list_head temp_list[HNS_ROCE_MAX_BT_LEVEL];
+	struct roce_hem_item *cur, *pre;
+	const int hopnum = r->hopnum;
+	int start_aligned;
+	int distance;
+	int ret = 0;
+	int max_ofs;
+	int level;
+	u32 step;
+	int end;
+
+	if (hopnum <= 1)
+		return 0;
+
+	if (hopnum > HNS_ROCE_MAX_BT_LEVEL) {
+		dev_err(hr_dev->dev, "invalid hopnum %d!\n", hopnum);
+		return -EINVAL;
+	}
+
+	if (offset < r->offset) {
+		dev_err(hr_dev->dev, "invalid offset %d,min %d!\n",
+			offset, r->offset);
+		return -EINVAL;
+	}
+
+	distance = offset - r->offset;
+	max_ofs = r->offset + r->count - 1;
+	for (level = 0; level < hopnum; level++)
+		INIT_LIST_HEAD(&temp_list[level]);
+
+	/* config L1 bt to last bt and link them to corresponding parent */
+	for (level = 1; level < hopnum; level++) {
+		cur = hem_list_search_item(&mid_bt[level], offset);
+		if (cur) {
+			hem_ptrs[level] = cur;
+			continue;
+		}
+
+		step = hem_list_calc_ba_range(hopnum, level, unit);
+		if (step < 1) {
+			ret = -EINVAL;
+			goto err_exit;
+		}
+
+		start_aligned = (distance / step) * step + r->offset;
+		end = min_t(int, start_aligned + step - 1, max_ofs);
+		cur = hem_list_alloc_item(hr_dev, start_aligned, end, unit,
+					  true, level);
+		if (!cur) {
+			ret = -ENOMEM;
+			goto err_exit;
+		}
+		hem_ptrs[level] = cur;
+		list_add(&cur->list, &temp_list[level]);
+		if (hem_list_is_bottom_bt(hopnum, level))
+			list_add(&cur->sibling, &temp_list[0]);
+
+		/* link bt to parent bt */
+		if (level > 1) {
+			pre = hem_ptrs[level - 1];
+			step = (cur->start - pre->start) / step * BA_BYTE_LEN;
+			hem_list_link_bt(hr_dev, pre->addr + step,
+					 cur->dma_addr);
+		}
+	}
+
+	list_splice(&temp_list[0], btm_bt);
+	for (level = 1; level < hopnum; level++)
+		list_splice(&temp_list[level], &mid_bt[level]);
+
+	return 0;
+
+err_exit:
+	for (level = 1; level < hopnum; level++)
+		hem_list_free_all(hr_dev, &temp_list[level], true);
+
+	return ret;
+}
+
+static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
+				  struct hns_roce_hem_list *hem_list, int unit,
+				  const struct hns_roce_buf_region *regions,
+				  int region_cnt)
+{
+	struct roce_hem_item *hem, *temp_hem, *root_hem;
+	struct list_head temp_list[HNS_ROCE_MAX_BT_REGION];
+	const struct hns_roce_buf_region *r;
+	struct list_head temp_root;
+	struct list_head temp_btm;
+	void *cpu_base;
+	u64 phy_base;
+	int ret = 0;
+	int offset;
+	int total;
+	int step;
+	int i;
+
+	r = &regions[0];
+	root_hem = hem_list_search_item(&hem_list->root_bt, r->offset);
+	if (root_hem)
+		return 0;
+
+	INIT_LIST_HEAD(&temp_root);
+	total = r->offset;
+	/* indicate to last region */
+	r = &regions[region_cnt - 1];
+	root_hem = hem_list_alloc_item(hr_dev, total, r->offset + r->count - 1,
+				       unit, true, 0);
+	if (!root_hem)
+		return -ENOMEM;
+	list_add(&root_hem->list, &temp_root);
+
+	hem_list->root_ba = root_hem->dma_addr;
+
+	INIT_LIST_HEAD(&temp_btm);
+	for (i = 0; i < region_cnt; i++)
+		INIT_LIST_HEAD(&temp_list[i]);
+
+	total = 0;
+	for (i = 0; i < region_cnt && total < unit; i++) {
+		r = &regions[i];
+		if (!r->count)
+			continue;
+
+		/* all regions's mid[x][0] shared the root_bt's trunk */
+		cpu_base = root_hem->addr + total * BA_BYTE_LEN;
+		phy_base = root_hem->dma_addr + total * BA_BYTE_LEN;
+
+		/* if hopnum is 0 or 1, cut a new fake hem from the root bt
+		 * which's address share to all regions.
+		 */
+		if (hem_list_is_bottom_bt(r->hopnum, 0)) {
+			hem = hem_list_alloc_item(hr_dev, r->offset,
+						  r->offset + r->count - 1,
+						  r->count, false, 0);
+			if (!hem) {
+				ret = -ENOMEM;
+				goto err_exit;
+			}
+			hem_list_assign_bt(hr_dev, hem, cpu_base, phy_base);
+			list_add(&hem->list, &temp_list[i]);
+			list_add(&hem->sibling, &temp_btm);
+			total += r->count;
+		} else {
+			step = hem_list_calc_ba_range(r->hopnum, 1, unit);
+			if (step < 1) {
+				ret = -EINVAL;
+				goto err_exit;
+			}
+			/* if exist mid bt, link L1 to L0 */
+			list_for_each_entry_safe(hem, temp_hem,
+					  &hem_list->mid_bt[i][1], list) {
+				offset = hem->start / step * BA_BYTE_LEN;
+				hem_list_link_bt(hr_dev, cpu_base + offset,
+						 hem->dma_addr);
+				total++;
+			}
+		}
+	}
+
+	list_splice(&temp_btm, &hem_list->btm_bt);
+	list_splice(&temp_root, &hem_list->root_bt);
+	for (i = 0; i < region_cnt; i++)
+		list_splice(&temp_list[i], &hem_list->mid_bt[i][0]);
+
+	return 0;
+
+err_exit:
+	for (i = 0; i < region_cnt; i++)
+		hem_list_free_all(hr_dev, &temp_list[i], false);
+
+	hem_list_free_all(hr_dev, &temp_root, true);
+
+	return ret;
+}
+
+/* construct the base address table and link them by address hop config */
+int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_hem_list *hem_list,
+			      const struct hns_roce_buf_region *regions,
+			      int region_cnt)
+{
+	const struct hns_roce_buf_region *r;
+	int ofs, end;
+	int ret = 0;
+	int unit;
+	int i;
+
+	if (region_cnt > HNS_ROCE_MAX_BT_REGION) {
+		dev_err(hr_dev->dev, "invalid region region_cnt %d!\n",
+			region_cnt);
+		return -EINVAL;
+	}
+
+	unit = (1 << hem_list->bt_pg_shift) / BA_BYTE_LEN;
+	for (i = 0; i < region_cnt; i++) {
+		r = &regions[i];
+		if (!r->count)
+			continue;
+
+		end = r->offset + r->count;
+		for (ofs = r->offset; ofs < end; ofs += unit) {
+			ret = hem_list_alloc_mid_bt(hr_dev, r, unit, ofs,
+						    hem_list->mid_bt[i],
+						    &hem_list->btm_bt);
+			if (ret) {
+				dev_err(hr_dev->dev,
+					"alloc hem trunk fail ret=%d!\n", ret);
+				goto err_alloc;
+			}
+		}
+	}
+
+	ret = hem_list_alloc_root_bt(hr_dev, hem_list, unit, regions,
+				     region_cnt);
+	if (ret)
+		dev_err(hr_dev->dev, "alloc hem root fail ret=%d!\n", ret);
+	else
+		return 0;
+
+err_alloc:
+	hns_roce_hem_list_release(hr_dev, hem_list);
+
+	return ret;
+}
+
+void hns_roce_hem_list_release(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_hem_list *hem_list)
+{
+	int i, j;
+
+	for (i = 0; i < HNS_ROCE_MAX_BT_REGION; i++)
+		for (j = 0; j < HNS_ROCE_MAX_BT_LEVEL; j++)
+			hem_list_free_all(hr_dev, &hem_list->mid_bt[i][j],
+					  j != 0);
+
+	hem_list_free_all(hr_dev, &hem_list->root_bt, true);
+	INIT_LIST_HEAD(&hem_list->btm_bt);
+	hem_list->root_ba = 0;
+}
+
+void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list,
+			    int bt_page_order)
+{
+	int i, j;
+
+	INIT_LIST_HEAD(&hem_list->root_bt);
+	INIT_LIST_HEAD(&hem_list->btm_bt);
+	for (i = 0; i < HNS_ROCE_MAX_BT_REGION; i++)
+		for (j = 0; j < HNS_ROCE_MAX_BT_LEVEL; j++)
+			INIT_LIST_HEAD(&hem_list->mid_bt[i][j]);
+
+	hem_list->bt_pg_shift = bt_page_order;
+}
+
+void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
+				 struct hns_roce_hem_list *hem_list,
+				 int offset, int *mtt_cnt, u64 *phy_addr)
+{
+	struct list_head *head = &hem_list->btm_bt;
+	struct roce_hem_item *hem, *temp_hem;
+	void *cpu_base = NULL;
+	u64 phy_base = 0;
+	int nr = 0;
+
+	list_for_each_entry_safe(hem, temp_hem, head, sibling) {
+		if (hem_list_page_is_in_range(hem, offset)) {
+			nr = offset - hem->start;
+			cpu_base = hem->addr + nr * BA_BYTE_LEN;
+			phy_base = hem->dma_addr + nr * BA_BYTE_LEN;
+			nr = hem->end + 1 - offset;
+			break;
+		}
+	}
+
+	if (mtt_cnt)
+		*mtt_cnt = nr;
+
+	if (phy_addr)
+		*phy_addr = phy_base;
+
+	return cpu_base;
+}
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index d9d6689..e865fc8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -133,6 +133,20 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_hem_mhop *mhop);
 bool hns_roce_check_whether_mhop(struct hns_roce_dev *hr_dev, u32 type);
 
+void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list,
+			    int bt_page_order);
+int hns_roce_hem_list_calc_root_ba(const struct hns_roce_buf_region *regions,
+				   int region_cnt, int unit);
+int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_hem_list *hem_list,
+			      const struct hns_roce_buf_region *regions,
+			      int region_cnt);
+void hns_roce_hem_list_release(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_hem_list *hem_list);
+void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
+				 struct hns_roce_hem_list *hem_list,
+				 int offset, int *mtt_cnt, u64 *phy_addr);
+
 static inline void hns_roce_hem_first(struct hns_roce_hem *hem,
 				      struct hns_roce_hem_iter *iter)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 38ed4ac..6db0dae 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -1496,3 +1496,121 @@ int hns_roce_dealloc_mw(struct ib_mw *ibmw)
 
 	return 0;
 }
+
+void hns_roce_mtr_init(struct hns_roce_mtr *mtr, int bt_pg_shift,
+		       int buf_pg_shift)
+{
+	hns_roce_hem_list_init(&mtr->hem_list, bt_pg_shift);
+	mtr->buf_pg_shift = buf_pg_shift;
+}
+
+void hns_roce_mtr_cleanup(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_mtr *mtr)
+{
+	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
+}
+EXPORT_SYMBOL_GPL(hns_roce_mtr_cleanup);
+
+static int hns_roce_write_mtr(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_mtr *mtr, dma_addr_t *bufs,
+			      struct hns_roce_buf_region *r)
+{
+	int offset;
+	int count;
+	int npage;
+	u64 *mtts;
+	int end;
+	int i;
+
+	offset = r->offset;
+	end = offset + r->count;
+	npage = 0;
+	while (offset < end) {
+		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
+						  offset, &count, NULL);
+		if (!mtts)
+			return -ENOBUFS;
+
+		/* Save page addr, low 12 bits : 0 */
+		for (i = 0; i < count; i++) {
+			if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
+				mtts[i] = cpu_to_le64(bufs[npage] >>
+							PAGE_ADDR_SHIFT);
+			else
+				mtts[i] = cpu_to_le64(bufs[npage]);
+
+			npage++;
+		}
+		offset += count;
+	}
+
+	return 0;
+}
+
+int hns_roce_mtr_attach(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+			dma_addr_t **bufs, struct hns_roce_buf_region *regions,
+			int region_cnt)
+{
+	struct hns_roce_buf_region *r;
+	int ret;
+	int i;
+
+	ret = hns_roce_hem_list_request(hr_dev, &mtr->hem_list, regions,
+					region_cnt);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < region_cnt; i++) {
+		r = &regions[i];
+		ret = hns_roce_write_mtr(hr_dev, mtr, bufs[i], r);
+		if (ret) {
+			dev_err(hr_dev->dev,
+				"write mtr[%d/%d] err %d,offset=%d.\n",
+				i, region_cnt, ret,  r->offset);
+			goto err_write;
+		}
+	}
+
+	return 0;
+
+err_write:
+	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
+
+	return ret;
+}
+
+int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
+{
+	u64 *mtts = mtt_buf;
+	int mtt_count;
+	int total = 0;
+	u64 *addr;
+	int npage;
+	int left;
+
+	if (mtts == NULL || mtt_max < 1)
+		goto done;
+
+	left = mtt_max;
+	while (left > 0) {
+		mtt_count = 0;
+		addr = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
+						  offset + total,
+						  &mtt_count, NULL);
+		if (!addr || !mtt_count)
+			goto done;
+
+		npage = min(mtt_count, left);
+		memcpy(&mtts[total], addr, BA_BYTE_LEN * npage);
+		left -= npage;
+		total += npage;
+	}
+
+done:
+	if (base_addr)
+		*base_addr = mtr->hem_list.root_ba;
+
+	return total;
+}
+EXPORT_SYMBOL_GPL(hns_roce_mtr_find);
-- 
1.9.1

