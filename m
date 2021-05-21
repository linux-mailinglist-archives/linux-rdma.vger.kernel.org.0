Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DC38C321
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhEUJb7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:31:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3462 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbhEUJbq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:31:46 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fmh8L57DszCvRn;
        Fri, 21 May 2021 17:27:14 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:30:02 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:30:02 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 2/5] RDMA/hns: Refactor root BT allocation for MTR
Date:   Fri, 21 May 2021 17:29:52 +0800
Message-ID: <1621589395-2435-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621589395-2435-1-git-send-email-liweihang@huawei.com>
References: <1621589395-2435-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Split the hem_list_alloc_root_bt() into serval small functions to make the
code flow more clear.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 230 ++++++++++++++++++++-----------
 1 file changed, 146 insertions(+), 84 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index cfd2e1b..63776da 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1053,7 +1053,7 @@ void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->mr_table.mtpt_table);
 }
 
-struct roce_hem_item {
+struct hns_roce_hem_item {
 	struct list_head list; /* link all hems in the same bt level */
 	struct list_head sibling; /* link all hems in last hop for mtt */
 	void *addr;
@@ -1063,12 +1063,18 @@ struct roce_hem_item {
 	int end; /* end buf offset in this hem */
 };
 
-static struct roce_hem_item *hem_list_alloc_item(struct hns_roce_dev *hr_dev,
-						   int start, int end,
-						   int count, bool exist_bt,
-						   int bt_level)
+/* All HEM items are linked in a tree structure */
+struct hns_roce_hem_head {
+	struct list_head branch[HNS_ROCE_MAX_BT_REGION];
+	struct list_head root;
+	struct list_head leaf;
+};
+
+static struct hns_roce_hem_item *
+hem_list_alloc_item(struct hns_roce_dev *hr_dev, int start, int end, int count,
+		    bool exist_bt, int bt_level)
 {
-	struct roce_hem_item *hem;
+	struct hns_roce_hem_item *hem;
 
 	hem = kzalloc(sizeof(*hem), GFP_KERNEL);
 	if (!hem)
@@ -1093,7 +1099,7 @@ static struct roce_hem_item *hem_list_alloc_item(struct hns_roce_dev *hr_dev,
 }
 
 static void hem_list_free_item(struct hns_roce_dev *hr_dev,
-			       struct roce_hem_item *hem, bool exist_bt)
+			       struct hns_roce_hem_item *hem, bool exist_bt)
 {
 	if (exist_bt)
 		dma_free_coherent(hr_dev->dev, hem->count * BA_BYTE_LEN,
@@ -1104,7 +1110,7 @@ static void hem_list_free_item(struct hns_roce_dev *hr_dev,
 static void hem_list_free_all(struct hns_roce_dev *hr_dev,
 			      struct list_head *head, bool exist_bt)
 {
-	struct roce_hem_item *hem, *temp_hem;
+	struct hns_roce_hem_item *hem, *temp_hem;
 
 	list_for_each_entry_safe(hem, temp_hem, head, list) {
 		list_del(&hem->list);
@@ -1120,24 +1126,24 @@ static void hem_list_link_bt(struct hns_roce_dev *hr_dev, void *base_addr,
 
 /* assign L0 table address to hem from root bt */
 static void hem_list_assign_bt(struct hns_roce_dev *hr_dev,
-			       struct roce_hem_item *hem, void *cpu_addr,
+			       struct hns_roce_hem_item *hem, void *cpu_addr,
 			       u64 phy_addr)
 {
 	hem->addr = cpu_addr;
 	hem->dma_addr = (dma_addr_t)phy_addr;
 }
 
-static inline bool hem_list_page_is_in_range(struct roce_hem_item *hem,
+static inline bool hem_list_page_is_in_range(struct hns_roce_hem_item *hem,
 					     int offset)
 {
 	return (hem->start <= offset && offset <= hem->end);
 }
 
-static struct roce_hem_item *hem_list_search_item(struct list_head *ba_list,
-						    int page_offset)
+static struct hns_roce_hem_item *hem_list_search_item(struct list_head *ba_list,
+						      int page_offset)
 {
-	struct roce_hem_item *hem, *temp_hem;
-	struct roce_hem_item *found = NULL;
+	struct hns_roce_hem_item *hem, *temp_hem;
+	struct hns_roce_hem_item *found = NULL;
 
 	list_for_each_entry_safe(hem, temp_hem, ba_list, list) {
 		if (hem_list_page_is_in_range(hem, page_offset)) {
@@ -1227,9 +1233,9 @@ static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
 				 int offset, struct list_head *mid_bt,
 				 struct list_head *btm_bt)
 {
-	struct roce_hem_item *hem_ptrs[HNS_ROCE_MAX_BT_LEVEL] = { NULL };
+	struct hns_roce_hem_item *hem_ptrs[HNS_ROCE_MAX_BT_LEVEL] = { NULL };
 	struct list_head temp_list[HNS_ROCE_MAX_BT_LEVEL];
-	struct roce_hem_item *cur, *pre;
+	struct hns_roce_hem_item *cur, *pre;
 	const int hopnum = r->hopnum;
 	int start_aligned;
 	int distance;
@@ -1307,56 +1313,96 @@ static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
-				  struct hns_roce_hem_list *hem_list, int unit,
-				  const struct hns_roce_buf_region *regions,
-				  int region_cnt)
+static struct hns_roce_hem_item *
+alloc_root_hem(struct hns_roce_dev *hr_dev, int unit, int *max_ba_num,
+	       const struct hns_roce_buf_region *regions, int region_cnt)
 {
-	struct list_head temp_list[HNS_ROCE_MAX_BT_REGION];
-	struct roce_hem_item *hem, *temp_hem, *root_hem;
 	const struct hns_roce_buf_region *r;
-	struct list_head temp_root;
-	struct list_head temp_btm;
-	void *cpu_base;
-	u64 phy_base;
-	int ret = 0;
+	struct hns_roce_hem_item *hem;
 	int ba_num;
 	int offset;
-	int total;
-	int step;
-	int i;
-
-	r = &regions[0];
-	root_hem = hem_list_search_item(&hem_list->root_bt, r->offset);
-	if (root_hem)
-		return 0;
 
 	ba_num = hns_roce_hem_list_calc_root_ba(regions, region_cnt, unit);
 	if (ba_num < 1)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	if (ba_num > unit)
-		return -ENOBUFS;
+		return ERR_PTR(-ENOBUFS);
 
-	ba_num = min_t(int, ba_num, unit);
-	INIT_LIST_HEAD(&temp_root);
-	offset = r->offset;
+	offset = regions[0].offset;
 	/* indicate to last region */
 	r = &regions[region_cnt - 1];
-	root_hem = hem_list_alloc_item(hr_dev, offset, r->offset + r->count - 1,
-				       ba_num, true, 0);
-	if (!root_hem)
+	hem = hem_list_alloc_item(hr_dev, offset, r->offset + r->count - 1,
+				  ba_num, true, 0);
+	if (!hem)
+		return ERR_PTR(-ENOMEM);
+
+	*max_ba_num = ba_num;
+
+	return hem;
+}
+
+static int alloc_fake_root_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
+			      u64 phy_base, const struct hns_roce_buf_region *r,
+			      struct list_head *branch_head,
+			      struct list_head *leaf_head)
+{
+	struct hns_roce_hem_item *hem;
+
+	hem = hem_list_alloc_item(hr_dev, r->offset, r->offset + r->count - 1,
+				  r->count, false, 0);
+	if (!hem)
 		return -ENOMEM;
-	list_add(&root_hem->list, &temp_root);
 
-	hem_list->root_ba = root_hem->dma_addr;
+	hem_list_assign_bt(hr_dev, hem, cpu_base, phy_base);
+	list_add(&hem->list, branch_head);
+	list_add(&hem->sibling, leaf_head);
 
-	INIT_LIST_HEAD(&temp_btm);
-	for (i = 0; i < region_cnt; i++)
-		INIT_LIST_HEAD(&temp_list[i]);
+	return r->count;
+}
+
+static int setup_middle_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
+			   int unit, const struct hns_roce_buf_region *r,
+			   const struct list_head *branch_head)
+{
+	struct hns_roce_hem_item *hem, *temp_hem;
+	int total = 0;
+	int offset;
+	int step;
+
+	step = hem_list_calc_ba_range(r->hopnum, 1, unit);
+	if (step < 1)
+		return -EINVAL;
+
+	/* if exist mid bt, link L1 to L0 */
+	list_for_each_entry_safe(hem, temp_hem, branch_head, list) {
+		offset = (hem->start - r->offset) / step * BA_BYTE_LEN;
+		hem_list_link_bt(hr_dev, cpu_base + offset, hem->dma_addr);
+		total++;
+	}
+
+	return total;
+}
+
+static int
+setup_root_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem_list *hem_list,
+	       int unit, int max_ba_num, struct hns_roce_hem_head *head,
+	       const struct hns_roce_buf_region *regions, int region_cnt)
+{
+	const struct hns_roce_buf_region *r;
+	struct hns_roce_hem_item *root_hem;
+	void *cpu_base;
+	u64 phy_base;
+	int i, total;
+	int ret;
+
+	root_hem = list_first_entry(&head->root,
+				    struct hns_roce_hem_item, list);
+	if (!root_hem)
+		return -ENOMEM;
 
 	total = 0;
-	for (i = 0; i < region_cnt && total < ba_num; i++) {
+	for (i = 0; i < region_cnt && total < max_ba_num; i++) {
 		r = &regions[i];
 		if (!r->count)
 			continue;
@@ -1368,48 +1414,64 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 		/* if hopnum is 0 or 1, cut a new fake hem from the root bt
 		 * which's address share to all regions.
 		 */
-		if (hem_list_is_bottom_bt(r->hopnum, 0)) {
-			hem = hem_list_alloc_item(hr_dev, r->offset,
-						  r->offset + r->count - 1,
-						  r->count, false, 0);
-			if (!hem) {
-				ret = -ENOMEM;
-				goto err_exit;
-			}
-			hem_list_assign_bt(hr_dev, hem, cpu_base, phy_base);
-			list_add(&hem->list, &temp_list[i]);
-			list_add(&hem->sibling, &temp_btm);
-			total += r->count;
-		} else {
-			step = hem_list_calc_ba_range(r->hopnum, 1, unit);
-			if (step < 1) {
-				ret = -EINVAL;
-				goto err_exit;
-			}
-			/* if exist mid bt, link L1 to L0 */
-			list_for_each_entry_safe(hem, temp_hem,
-					  &hem_list->mid_bt[i][1], list) {
-				offset = (hem->start - r->offset) / step *
-					  BA_BYTE_LEN;
-				hem_list_link_bt(hr_dev, cpu_base + offset,
-						 hem->dma_addr);
-				total++;
-			}
-		}
+		if (hem_list_is_bottom_bt(r->hopnum, 0))
+			ret = alloc_fake_root_bt(hr_dev, cpu_base, phy_base, r,
+						 &head->branch[i], &head->leaf);
+		else
+			ret = setup_middle_bt(hr_dev, cpu_base, unit, r,
+					      &hem_list->mid_bt[i][1]);
+
+		if (ret < 0)
+			return ret;
+
+		total += ret;
 	}
 
-	list_splice(&temp_btm, &hem_list->btm_bt);
-	list_splice(&temp_root, &hem_list->root_bt);
+	list_splice(&head->leaf, &hem_list->btm_bt);
+	list_splice(&head->root, &hem_list->root_bt);
 	for (i = 0; i < region_cnt; i++)
-		list_splice(&temp_list[i], &hem_list->mid_bt[i][0]);
+		list_splice(&head->branch[i], &hem_list->mid_bt[i][0]);
 
 	return 0;
+}
 
-err_exit:
+static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
+				  struct hns_roce_hem_list *hem_list, int unit,
+				  const struct hns_roce_buf_region *regions,
+				  int region_cnt)
+{
+	struct hns_roce_hem_item *root_hem;
+	struct hns_roce_hem_head head;
+	int max_ba_num;
+	int ret;
+	int i;
+
+	root_hem = hem_list_search_item(&hem_list->root_bt, regions[0].offset);
+	if (root_hem)
+		return 0;
+
+	max_ba_num = 0;
+	root_hem = alloc_root_hem(hr_dev, unit, &max_ba_num, regions,
+				  region_cnt);
+	if (IS_ERR(root_hem))
+		return PTR_ERR(root_hem);
+
+	/* List head for storing all allocated HEM items */
+	INIT_LIST_HEAD(&head.root);
+	INIT_LIST_HEAD(&head.leaf);
 	for (i = 0; i < region_cnt; i++)
-		hem_list_free_all(hr_dev, &temp_list[i], false);
+		INIT_LIST_HEAD(&head.branch[i]);
 
-	hem_list_free_all(hr_dev, &temp_root, true);
+	hem_list->root_ba = root_hem->dma_addr;
+	list_add(&root_hem->list, &head.root);
+	ret = setup_root_hem(hr_dev, hem_list, unit, max_ba_num, &head, regions,
+			     region_cnt);
+	if (ret) {
+		for (i = 0; i < region_cnt; i++)
+			hem_list_free_all(hr_dev, &head.branch[i], false);
+
+		hem_list_free_all(hr_dev, &head.root, true);
+	}
 
 	return ret;
 }
@@ -1495,7 +1557,7 @@ void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 				 int offset, int *mtt_cnt, u64 *phy_addr)
 {
 	struct list_head *head = &hem_list->btm_bt;
-	struct roce_hem_item *hem, *temp_hem;
+	struct hns_roce_hem_item *hem, *temp_hem;
 	void *cpu_base = NULL;
 	u64 phy_base = 0;
 	int nr = 0;
-- 
2.7.4

