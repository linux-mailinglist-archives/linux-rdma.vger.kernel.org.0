Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC732E273C
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Dec 2020 14:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgLXNXi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Dec 2020 08:23:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9989 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgLXNXi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Dec 2020 08:23:38 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D1rMm1hl6zhxHL;
        Thu, 24 Dec 2020 21:22:12 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 21:22:46 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <leon@kernel.org>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] mlx5: use DEFINE_MUTEX() for mutex lock
Date:   Thu, 24 Dec 2020 21:23:23 +0800
Message-ID: <20201224132323.31126-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 246e3cbe0b2c..8a260773722f 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -79,7 +79,7 @@ static DEFINE_MUTEX(mlx5_ib_multiport_mutex);
  * doesn't work on kernel modules memory
  */
 static unsigned long xlt_emergency_page;
-static struct mutex xlt_emergency_page_mutex;
+static DEFINE_MUTEX(xlt_emergency_page_mutex);
 
 struct mlx5_ib_dev *mlx5_ib_get_ibdev_from_mpi(struct mlx5_ib_multiport_info *mpi)
 {
@@ -4874,8 +4874,6 @@ static int __init mlx5_ib_init(void)
 	if (!xlt_emergency_page)
 		return -ENOMEM;
 
-	mutex_init(&xlt_emergency_page_mutex);
-
 	mlx5_ib_event_wq = alloc_ordered_workqueue("mlx5_ib_event_wq", 0);
 	if (!mlx5_ib_event_wq) {
 		free_page(xlt_emergency_page);
-- 
2.22.0

