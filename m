Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC73F1006
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 03:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhHSBkq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 21:40:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8041 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhHSBkp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 21:40:45 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GqnWL6ZCgzYr3y;
        Thu, 19 Aug 2021 09:39:42 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:40:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:40:07 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Delete unused hns bitmap interface
Date:   Thu, 19 Aug 2021 09:36:20 +0800
Message-ID: <1629336980-17499-4-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629336980-17499-1-git-send-email-liangwenpeng@huawei.com>
References: <1629336980-17499-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

The resources that use the hns bitmap interface:
qp, cq, mr, pd, xrcd, uar, srq, have been changed to IDA interfaces, and
the unused hns' own bitmap interfaces need to be deleted.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 70 -----------------------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ---
 2 files changed, 75 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 1dc35dd..d4fa0fd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -36,76 +36,6 @@
 #include "hns_roce_device.h"
 #include <rdma/ib_umem.h>
 
-int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
-{
-	int ret = 0;
-
-	spin_lock(&bitmap->lock);
-	*obj = find_next_zero_bit(bitmap->table, bitmap->max, bitmap->last);
-	if (*obj >= bitmap->max) {
-		bitmap->top = (bitmap->top + bitmap->max + bitmap->reserved_top)
-			       & bitmap->mask;
-		*obj = find_first_zero_bit(bitmap->table, bitmap->max);
-	}
-
-	if (*obj < bitmap->max) {
-		set_bit(*obj, bitmap->table);
-		bitmap->last = (*obj + 1);
-		if (bitmap->last == bitmap->max)
-			bitmap->last = 0;
-		*obj |= bitmap->top;
-	} else {
-		ret = -EINVAL;
-	}
-
-	spin_unlock(&bitmap->lock);
-
-	return ret;
-}
-
-void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj)
-{
-	obj &= bitmap->max + bitmap->reserved_top - 1;
-
-	spin_lock(&bitmap->lock);
-	clear_bit(obj, bitmap->table);
-
-	bitmap->last = min(bitmap->last, obj);
-	bitmap->top = (bitmap->top + bitmap->max + bitmap->reserved_top)
-		       & bitmap->mask;
-	spin_unlock(&bitmap->lock);
-}
-
-int hns_roce_bitmap_init(struct hns_roce_bitmap *bitmap, u32 num, u32 mask,
-			 u32 reserved_bot, u32 reserved_top)
-{
-	u32 i;
-
-	if (num != roundup_pow_of_two(num))
-		return -EINVAL;
-
-	bitmap->last = 0;
-	bitmap->top = 0;
-	bitmap->max = num - reserved_top;
-	bitmap->mask = mask;
-	bitmap->reserved_top = reserved_top;
-	spin_lock_init(&bitmap->lock);
-	bitmap->table = kcalloc(BITS_TO_LONGS(bitmap->max), sizeof(long),
-				GFP_KERNEL);
-	if (!bitmap->table)
-		return -ENOMEM;
-
-	for (i = 0; i < reserved_bot; ++i)
-		set_bit(i, bitmap->table);
-
-	return 0;
-}
-
-void hns_roce_bitmap_cleanup(struct hns_roce_bitmap *bitmap)
-{
-	kfree(bitmap->table);
-}
-
 void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf)
 {
 	struct hns_roce_buf_list *trunks;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 4b6c3c0..2129da3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1152,11 +1152,6 @@ void hns_roce_cleanup_eq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev);
 
-int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj);
-void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj);
-int hns_roce_bitmap_init(struct hns_roce_bitmap *bitmap, u32 num, u32 mask,
-			 u32 reserved_bot, u32 resetrved_top);
-void hns_roce_bitmap_cleanup(struct hns_roce_bitmap *bitmap);
 void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev);
 
 int hns_roce_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
-- 
2.8.1

