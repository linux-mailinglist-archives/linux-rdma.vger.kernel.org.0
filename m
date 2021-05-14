Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568AD3801CD
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhENCNG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 22:13:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3660 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhENCNF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 May 2021 22:13:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhBm80QXzz1BMNQ;
        Fri, 14 May 2021 10:09:12 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 10:11:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 3/6] RDMA/hns: Use refcount_t APIs for HEM
Date:   Fri, 14 May 2021 10:11:36 +0800
Message-ID: <1620958299-4869-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

refcount_t is better than integer for reference counting, it will WARN on
overflow/underflow and avoid use-after-free risks.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 33 ++++++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_hem.h |  4 ++--
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index cfd2e1b..84f3cd1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -271,7 +271,7 @@ static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
 	if (!hem)
 		return NULL;
 
-	hem->refcount = 0;
+	refcount_set(&hem->refcount, 0);
 	INIT_LIST_HEAD(&hem->chunk_list);
 
 	order = get_order(hem_alloc_size);
@@ -618,7 +618,7 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 
 	mutex_lock(&table->mutex);
 	if (table->hem[index.buf]) {
-		++table->hem[index.buf]->refcount;
+		refcount_inc(&table->hem[index.buf]->refcount);
 		goto out;
 	}
 
@@ -637,7 +637,7 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 		}
 	}
 
-	++table->hem[index.buf]->refcount;
+	refcount_set(&table->hem[index.buf]->refcount, 1);
 	goto out;
 
 err_alloc:
@@ -663,7 +663,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	mutex_lock(&table->mutex);
 
 	if (table->hem[i]) {
-		++table->hem[i]->refcount;
+		refcount_inc(&table->hem[i]->refcount);
 		goto out;
 	}
 
@@ -686,7 +686,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 		goto out;
 	}
 
-	++table->hem[i]->refcount;
+	refcount_set(&table->hem[i]->refcount, 1);
 out:
 	mutex_unlock(&table->mutex);
 	return ret;
@@ -753,11 +753,11 @@ static void hns_roce_table_mhop_put(struct hns_roce_dev *hr_dev,
 		return;
 	}
 
-	mutex_lock(&table->mutex);
-	if (check_refcount && (--table->hem[index.buf]->refcount > 0)) {
-		mutex_unlock(&table->mutex);
+	if (!check_refcount)
+		mutex_lock(&table->mutex);
+	else if (!refcount_dec_and_mutex_lock(&table->hem[index.buf]->refcount,
+					      &table->mutex))
 		return;
-	}
 
 	clear_mhop_hem(hr_dev, table, obj, &mhop, &index);
 	free_mhop_hem(hr_dev, table, &mhop, &index);
@@ -779,16 +779,15 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 	i = (obj & (table->num_obj - 1)) /
 	    (table->table_chunk_size / table->obj_size);
 
-	mutex_lock(&table->mutex);
+	if (!refcount_dec_and_mutex_lock(&table->hem[i]->refcount,
+					 &table->mutex))
+		return;
 
-	if (--table->hem[i]->refcount == 0) {
-		/* Clear HEM base address */
-		if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
-			dev_warn(dev, "Clear HEM base address failed.\n");
+	if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
+		dev_warn(dev, "failed to clear HEM base address.\n");
 
-		hns_roce_free_hem(hr_dev, table->hem[i]);
-		table->hem[i] = NULL;
-	}
+	hns_roce_free_hem(hr_dev, table->hem[i]);
+	table->hem[i] = NULL;
 
 	mutex_unlock(&table->mutex);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 13fdeb3..ffa65e8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -88,8 +88,8 @@ struct hns_roce_hem_chunk {
 };
 
 struct hns_roce_hem {
-	struct list_head	 chunk_list;
-	int			 refcount;
+	struct list_head chunk_list;
+	refcount_t refcount;
 };
 
 struct hns_roce_hem_iter {
-- 
2.7.4

