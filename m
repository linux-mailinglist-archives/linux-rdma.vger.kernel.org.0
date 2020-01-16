Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5036013D312
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 05:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgAPEOq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 23:14:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730133AbgAPEOq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 23:14:46 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 904F2D13E9CA731AC38F;
        Thu, 16 Jan 2020 12:14:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 12:14:34 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <shiraz.saleem@intel.com>, <aditr@vmware.com>,
        <mkalderon@marvell.com>, <aelior@marvell.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH RFC for-next 5/6] RDMA/vmw_pvrdma: remove deliver net device event
Date:   Thu, 16 Jan 2020 12:10:46 +0800
Message-ID: <1579147847-12158-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
References: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The code that handles the link event of the net device has been moved
into the core, and the related processing should been removed from the
provider's driver.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index e580ae9..b3877c5 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -694,9 +694,6 @@ static void pvrdma_netdevice_event_handle(struct pvrdma_dev *dev,
 
 	switch (event) {
 	case NETDEV_REBOOT:
-	case NETDEV_DOWN:
-		pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ERR);
-		break;
 	case NETDEV_UP:
 		pvrdma_write_reg(dev, PVRDMA_REG_CTL,
 				 PVRDMA_DEVICE_CTL_UNQUIESCE);
@@ -706,8 +703,6 @@ static void pvrdma_netdevice_event_handle(struct pvrdma_dev *dev,
 		if (pvrdma_read_reg(dev, PVRDMA_REG_ERR))
 			dev_err(&dev->pdev->dev,
 				"failed to activate device during link up\n");
-		else
-			pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ACTIVE);
 		break;
 	case NETDEV_UNREGISTER:
 		ib_device_set_netdev(&dev->ib_dev, NULL, 1);
-- 
2.8.1

