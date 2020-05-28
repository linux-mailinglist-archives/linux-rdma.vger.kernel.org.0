Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7321E59EB
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 09:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgE1HzO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 03:55:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgE1HzO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 May 2020 03:55:14 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E437587AD107F6AD0F4C;
        Thu, 28 May 2020 15:55:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 28 May 2020 15:55:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] IB/hfi1: Remove set but not used variable 'priv'
Date:   Thu, 28 May 2020 07:59:46 +0000
Message-ID: <20200528075946.123480-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

drivers/infiniband/hw/hfi1/netdev_rx.c: In function 'hfi1_netdev_free':
drivers/infiniband/hw/hfi1/netdev_rx.c:374:27: warning:
 variable 'priv' set but not used [-Wunused-but-set-variable]

It is never used, so can be removed, then null check before
kfree is unneeded.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hfi1/netdev_rx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 58af6a454761..bd6546b52159 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -371,14 +371,9 @@ int hfi1_netdev_alloc(struct hfi1_devdata *dd)
 
 void hfi1_netdev_free(struct hfi1_devdata *dd)
 {
-	struct hfi1_netdev_priv *priv;
-
-	if (dd->dummy_netdev) {
-		priv = hfi1_netdev_priv(dd->dummy_netdev);
-		dd_dev_info(dd, "hfi1 netdev freed\n");
-		kfree(dd->dummy_netdev);
-		dd->dummy_netdev = NULL;
-	}
+	dd_dev_info(dd, "hfi1 netdev freed\n");
+	kfree(dd->dummy_netdev);
+	dd->dummy_netdev = NULL;
 }
 
 /**



