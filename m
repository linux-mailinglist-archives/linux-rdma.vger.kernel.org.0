Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC2B2AE6F2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Nov 2020 04:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgKKDRH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 22:17:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7169 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgKKDRG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Nov 2020 22:17:06 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CW8zB1wS6z15TsS;
        Wed, 11 Nov 2020 11:16:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Nov 2020 11:16:52 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] RDMA/pvrdma: fix missing kfree in pvrdma_register_device
Date:   Wed, 11 Nov 2020 11:22:02 +0800
Message-ID: <20201111032202.17925-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix missing kfree in pvrdma_register_device() when fails
to do ib_device_set_netdev.

Fixes: 4b38da75e089 ("RDMA/drivers: Convert easy drivers to use ib_device_set_netdev()")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index fa2a3fa0c3e4..f71d99946bed 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -266,7 +266,7 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
 	}
 	ret = ib_device_set_netdev(&dev->ib_dev, dev->netdev, 1);
 	if (ret)
-		return ret;
+		goto err_qp_free;
 	spin_lock_init(&dev->srq_tbl_lock);
 	rdma_set_device_sysfs_group(&dev->ib_dev, &pvrdma_attr_group);
 
-- 
2.23.0

