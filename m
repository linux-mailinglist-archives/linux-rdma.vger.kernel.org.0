Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B55E1EB5B6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 08:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFBGRD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 02:17:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbgFBGRD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jun 2020 02:17:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CDB40BC41E81E25A4047;
        Tue,  2 Jun 2020 14:16:54 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 14:16:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mike.marciniszyn@intel.com>, <dennis.dalessandro@intel.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>,
        <sadanand.warrier@intel.com>, <grzegorz.andrejczuk@intel.com>,
        <yuehaibing@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.carpenter@oracle.com>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] IB/hfi1: Use free_netdev() in hfi1_netdev_free()
Date:   Tue, 2 Jun 2020 14:16:35 +0800
Message-ID: <20200602061635.31224-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200601135644.GD4872@ziepe.ca>
References: <20200601135644.GD4872@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

dummy_netdev shold be freed by free_netdev() instead of
kfree(). Also remove unneeded variable 'priv'

Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hfi1/netdev_rx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 58af6a454761..63688e85e8da 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -371,12 +371,9 @@ int hfi1_netdev_alloc(struct hfi1_devdata *dd)
 
 void hfi1_netdev_free(struct hfi1_devdata *dd)
 {
-	struct hfi1_netdev_priv *priv;
-
 	if (dd->dummy_netdev) {
-		priv = hfi1_netdev_priv(dd->dummy_netdev);
 		dd_dev_info(dd, "hfi1 netdev freed\n");
-		kfree(dd->dummy_netdev);
+		free_netdev(dd->dummy_netdev);
 		dd->dummy_netdev = NULL;
 	}
 }
-- 
2.17.1


