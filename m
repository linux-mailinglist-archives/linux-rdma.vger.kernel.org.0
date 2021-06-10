Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2657B3A2AB7
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFJLwf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:52:35 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5374 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFJLwe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 07:52:34 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G12J401qbz6vFh;
        Thu, 10 Jun 2021 19:46:44 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
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
Subject: [PATCH for-next 2/6] RDMA/hns: Remove the unused hns_roce_bitmap_free_range function
Date:   Thu, 10 Jun 2021 19:50:10 +0800
Message-ID: <1623325814-55737-3-git-send-email-liweihang@huawei.com>
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

hns_roce_bitmap_free_range() is only called inside hns_roce_bitmap_free(),
and the input parameter "cnt" is set to a constant 1. In addition, the
driver does not use alloc_range scenarios, so free_range does not need to
exist.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 12 +-----------
 drivers/infiniband/hw/hns/hns_roce_device.h |  3 ---
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 8b68f93..f950ec4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -66,20 +66,10 @@ int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
 void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj,
 			  int rr)
 {
-	hns_roce_bitmap_free_range(bitmap, obj, 1, rr);
-}
-
-void hns_roce_bitmap_free_range(struct hns_roce_bitmap *bitmap,
-				unsigned long obj, int cnt,
-				int rr)
-{
-	int i;
-
 	obj &= bitmap->max + bitmap->reserved_top - 1;
 
 	spin_lock(&bitmap->lock);
-	for (i = 0; i < cnt; i++)
-		clear_bit(obj + i, bitmap->table);
+	clear_bit(obj, bitmap->table);
 
 	if (!rr)
 		bitmap->last = min(bitmap->last, obj);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 0048e5f..cbf3b9b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1163,9 +1163,6 @@ int hns_roce_bitmap_init(struct hns_roce_bitmap *bitmap, u32 num, u32 mask,
 			 u32 reserved_bot, u32 resetrved_top);
 void hns_roce_bitmap_cleanup(struct hns_roce_bitmap *bitmap);
 void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev);
-void hns_roce_bitmap_free_range(struct hns_roce_bitmap *bitmap,
-				unsigned long obj, int cnt,
-				int rr);
 
 int hns_roce_create_ah(struct ib_ah *ah, struct rdma_ah_init_attr *init_attr,
 		       struct ib_udata *udata);
-- 
2.7.4

