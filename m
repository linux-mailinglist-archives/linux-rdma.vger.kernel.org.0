Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EA0377EF9
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 11:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhEJJJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 05:09:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2483 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJJJ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 05:09:57 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FdwCP1vQvzRfHC;
        Mon, 10 May 2021 17:06:25 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeml757-chm.china.huawei.com (10.1.199.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 10 May 2021 17:08:48 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 17:08:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] RDMA/cm: Delete two redundant condition branches
Date:   Mon, 10 May 2021 17:08:40 +0800
Message-ID: <20210510090840.3474-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The statement of the last "if (xxx)" branch is the same as the "else"
branch. Delete it to simplify code.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/infiniband/core/cm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 0ead0d223154011..510beb25f5b8a0b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -668,8 +668,6 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
 			link = &(*link)->rb_right;
 		else if (be64_lt(service_id, cur_cm_id_priv->id.service_id))
 			link = &(*link)->rb_left;
-		else if (be64_gt(service_id, cur_cm_id_priv->id.service_id))
-			link = &(*link)->rb_right;
 		else
 			link = &(*link)->rb_right;
 	}
@@ -700,8 +698,6 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
 			node = node->rb_right;
 		else if (be64_lt(service_id, cm_id_priv->id.service_id))
 			node = node->rb_left;
-		else if (be64_gt(service_id, cm_id_priv->id.service_id))
-			node = node->rb_right;
 		else
 			node = node->rb_right;
 	}
-- 
2.26.0.106.g9fadedd


