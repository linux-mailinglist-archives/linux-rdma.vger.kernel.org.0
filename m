Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203D83436C3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 03:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCVCrh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 22:47:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14046 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhCVCrE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Mar 2021 22:47:04 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F3f3P3G6szNpwN;
        Mon, 22 Mar 2021 10:44:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 10:46:53 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next] RDMA/hns: Fix memory corruption when allocating XRCDN
Date:   Mon, 22 Mar 2021 10:44:29 +0800
Message-ID: <1616381069-51759-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's incorrect to cast the type of pointer to xrcdn from (u32 *) to
(unsigned long *), then pass it into hns_roce_bitmap_alloc(), this will
lead to a memory corruption.

Fixes: 32548870d438 ("RDMA/hns: Add support for XRC on HIP09")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v1:
- xrcdn won't be set if hns_roce_bitmap_alloc() fails.
- Link: https://patchwork.kernel.org/project/linux-rdma/patch/1616143536-24874-1-git-send-email-liweihang@huawei.com/

 drivers/infiniband/hw/hns/hns_roce_pd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 3ca51ce..68a59ff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -140,8 +140,16 @@ void hns_roce_cleanup_uar_table(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev, u32 *xrcdn)
 {
-	return hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap,
-				     (unsigned long *)xrcdn);
+	unsigned long obj;
+	int ret;
+
+	ret = hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap, &obj);
+	if (ret)
+		return ret;
+
+	*xrcdn = (u32)obj;
+
+	return 0;
 }
 
 static void hns_roce_xrcd_free(struct hns_roce_dev *hr_dev,
-- 
2.8.1

