Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA322DBC6B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 09:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgLPICm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 03:02:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9894 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLPICm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 03:02:42 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CwndD53SYz7Dbk;
        Wed, 16 Dec 2020 16:01:20 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 16:01:48 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dledford@redhat.com>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] infiniband: core: Delete useless kfree code
Date:   Wed, 16 Dec 2020 16:02:19 +0800
Message-ID: <20201216080219.18184-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The parameter of kfree function is NULL, so kfree code is useless, delete it.
Therefore, goto expression is no longer needed, so simplify it.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/infiniband/core/cma_configfs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 7ec4af2ed87a..51f59ed6916b 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -202,7 +202,6 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
 	unsigned int i;
 	unsigned int ports_num;
 	struct cma_dev_port_group *ports;
-	int err;
 
 	ibdev = cma_get_ib_dev(cma_dev);
 
@@ -214,8 +213,8 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
 			GFP_KERNEL);
 
 	if (!ports) {
-		err = -ENOMEM;
-		goto free;
+		cma_dev_group->ports = NULL;
+		return -ENOMEM;
 	}
 
 	for (i = 0; i < ports_num; i++) {
@@ -234,10 +233,6 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
 	cma_dev_group->ports = ports;
 
 	return 0;
-free:
-	kfree(ports);
-	cma_dev_group->ports = NULL;
-	return err;
 }
 
 static void release_cma_dev(struct config_item  *item)
-- 
2.22.0

