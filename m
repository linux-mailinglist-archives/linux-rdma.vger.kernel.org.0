Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15D02D9933
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Dec 2020 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438375AbgLNNr3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Dec 2020 08:47:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9203 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438166AbgLNNrX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Dec 2020 08:47:23 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CvjMd31KWzks6W;
        Mon, 14 Dec 2020 21:45:49 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:46:25 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] infiniband: core: Delete useless kfree code
Date:   Mon, 14 Dec 2020 21:46:55 +0800
Message-ID: <20201214134655.4991-1-zhengyongjun3@huawei.com>
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

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/infiniband/core/cma_configfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 7ec4af2ed87a..c6e7cd9bc25a 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -235,7 +235,6 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
 
 	return 0;
 free:
-	kfree(ports);
 	cma_dev_group->ports = NULL;
 	return err;
 }
-- 
2.22.0

