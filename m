Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F270F91BCB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 06:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbfHSEVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 00:21:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfHSEVZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 00:21:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 766DCBBBA840527426B5;
        Mon, 19 Aug 2019 12:21:15 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 19 Aug 2019
 12:21:09 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <parav@mellanox.com>, <swise@opengridcomputing.com>,
        <danielj@mellanox.com>, <danitg@mellanox.com>,
        <willy@infradead.org>, <linux-rdma@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] RDMA/cma: fix null-ptr-deref Read in cma_cleanup
Date:   Mon, 19 Aug 2019 12:27:39 +0800
Message-ID: <1566188859-103051-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In cma_init, if cma_configfs_init fails, need to free the
previously memory and return fail, otherwise will trigger
null-ptr-deref Read in cma_cleanup.

cma_cleanup
  cma_configfs_exit
    configfs_unregister_subsystem

Fixes: 045959db65c6 ("IB/cma: Add configfs for rdma_cm")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/infiniband/core/cma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 19f1730..a68d0cc 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4724,10 +4724,14 @@ static int __init cma_init(void)
 	if (ret)
 		goto err;

-	cma_configfs_init();
+	ret = cma_configfs_init();
+	if (ret)
+		goto err_ib;

 	return 0;

+err_ib:
+	ib_unregister_client(&cma_client);
 err:
 	unregister_netdevice_notifier(&cma_nb);
 	ib_sa_unregister_client(&sa_client);
--
2.7.4

