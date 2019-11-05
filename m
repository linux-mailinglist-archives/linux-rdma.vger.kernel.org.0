Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B28BEF42E
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 04:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfKEDrp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 22:47:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729711AbfKEDrp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 22:47:45 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 58410609BD900BC54E05;
        Tue,  5 Nov 2019 11:47:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 11:47:32 +0800
From:   Yixian Liu <liuyixian@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <parav@mellanox.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
Date:   Tue, 5 Nov 2019 11:48:10 +0800
Message-ID: <1572925690-7336-1-git-send-email-liuyixian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This warning can be triggered easily when adding a large number of
VLANs while the capacity of GID table is small.

Fixes: 598ff6bae689 ("IB/core: Refactor GID modify code for RoCE")
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
---
 drivers/infiniband/core/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 00fb3ea..2990075 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -579,8 +579,8 @@ static int __ib_cache_gid_add(struct ib_device *ib_dev, u8 port,
 out_unlock:
 	mutex_unlock(&table->lock);
 	if (ret)
-		pr_warn("%s: unable to add gid %pI6 error=%d\n",
-			__func__, gid->raw, ret);
+		pr_warn_ratelimited("%s: unable to add gid %pI6 error=%d\n",
+				    __func__, gid->raw, ret);
 	return ret;
 }
 
-- 
2.7.4

