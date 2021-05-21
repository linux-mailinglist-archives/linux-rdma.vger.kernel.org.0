Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5D38C416
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhEUJ5F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:57:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3614 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbhEUJzS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:55:18 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fmhg23dS9zQpj8;
        Fri, 21 May 2021 17:50:22 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:54 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:54 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 05/17] RDMA/core: Use refcount_t instead of atomic_t on refcount of mcast_port
Date:   Fri, 21 May 2021 17:53:33 +0800
Message-ID: <1621590825-60693-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
References: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/multicast.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index de134a4..a236532 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -61,7 +61,7 @@ struct mcast_port {
 	struct mcast_device	*dev;
 	spinlock_t		lock;
 	struct rb_root		table;
-	atomic_t		refcount;
+	refcount_t		refcount;
 	struct completion	comp;
 	u32			port_num;
 };
@@ -178,7 +178,7 @@ static struct mcast_group *mcast_insert(struct mcast_port *port,
 
 static void deref_port(struct mcast_port *port)
 {
-	if (atomic_dec_and_test(&port->refcount))
+	if (refcount_dec_and_test(&port->refcount))
 		complete(&port->comp);
 }
 
@@ -589,7 +589,7 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
 		kfree(group);
 		group = cur_group;
 	} else
-		atomic_inc(&port->refcount);
+		refcount_inc(&port->refcount);
 found:
 	atomic_inc(&group->refcount);
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -840,7 +840,7 @@ static int mcast_add_one(struct ib_device *device)
 		spin_lock_init(&port->lock);
 		port->table = RB_ROOT;
 		init_completion(&port->comp);
-		atomic_set(&port->refcount, 1);
+		refcount_set(&port->refcount, 1);
 		++count;
 	}
 
-- 
2.7.4

