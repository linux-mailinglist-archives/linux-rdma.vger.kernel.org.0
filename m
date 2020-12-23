Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396B22E1D17
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Dec 2020 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgLWOMk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Dec 2020 09:12:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9678 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgLWOMj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Dec 2020 09:12:39 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1FVW5McjzkvT3;
        Wed, 23 Dec 2020 22:10:59 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:11:47 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] mlx5: use DEFINE_MUTEX (and mutex_init() had been too late)
Date:   Wed, 23 Dec 2020 22:12:23 +0800
Message-ID: <20201223141223.313-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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

