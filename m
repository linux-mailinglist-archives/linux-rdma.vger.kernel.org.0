Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85EC3A2AB9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFJLwf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:52:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3833 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhFJLwe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 07:52:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G12Gv1TrWzWsvJ;
        Thu, 10 Jun 2021 19:45:43 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:50:36 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 19:50:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yangyang Li <liyangyang20@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 1/6] RDMA/hns: Remove the unused hns_roce_bitmap_alloc_range function
Date:   Thu, 10 Jun 2021 19:50:09 +0800
Message-ID: <1623325814-55737-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623325814-55737-1-git-send-email-liweihang@huawei.com>
References: <1623325814-55737-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

The function is no longer used.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 39 -----------------------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 --
 2 files changed, 41 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 51374b68..8b68f93 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -69,45 +69,6 @@ void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj,
 	hns_roce_bitmap_free_range(bitmap, obj, 1, rr);
 }
 
-int hns_roce_bitmap_alloc_range(struct hns_roce_bitmap *bitmap, int cnt,
-				int align, unsigned long *obj)
-{
-	int ret = 0;
-	int i;
-
-	if (likely(cnt == 1 && align == 1))
-		return hns_roce_bitmap_alloc(bitmap, obj);
-
-	spin_lock(&bitmap->lock);
-
-	*obj = bitmap_find_next_zero_area(bitmap->table, bitmap->max,
-					  bitmap->last, cnt, align - 1);
-	if (*obj >= bitmap->max) {
-		bitmap->top = (bitmap->top + bitmap->max + bitmap->reserved_top)
-			       & bitmap->mask;
-		*obj = bitmap_find_next_zero_area(bitmap->table, bitmap->max, 0,
-						  cnt, align - 1);
-	}
-
-	if (*obj < bitmap->max) {
-		for (i = 0; i < cnt; i++)
-			set_bit(*obj + i, bitmap->table);
-
-		if (*obj == bitmap->last) {
-			bitmap->last = (*obj + cnt);
-			if (bitmap->last >= bitmap->max)
-				bitmap->last = 0;
-		}
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
 void hns_roce_bitmap_free_range(struct hns_roce_bitmap *bitmap,
 				unsigned long obj, int cnt,
 				int rr)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 7d00d4c..0048e5f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1163,8 +1163,6 @@ int hns_roce_bitmap_init(struct hns_roce_bitmap *bitmap, u32 num, u32 mask,
 			 u32 reserved_bot, u32 resetrved_top);
 void hns_roce_bitmap_cleanup(struct hns_roce_bitmap *bitmap);
 void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev);
-int hns_roce_bitmap_alloc_range(struct hns_roce_bitmap *bitmap, int cnt,
-				int align, unsigned long *obj);
 void hns_roce_bitmap_free_range(struct hns_roce_bitmap *bitmap,
 				unsigned long obj, int cnt,
 				int rr);
-- 
2.7.4

