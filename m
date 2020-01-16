Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C245F13D313
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 05:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgAPEOr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 23:14:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729551AbgAPEOq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 23:14:46 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B4787985251908BAAE2;
        Thu, 16 Jan 2020 12:14:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 12:14:34 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <shiraz.saleem@intel.com>, <aditr@vmware.com>,
        <mkalderon@marvell.com>, <aelior@marvell.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH RFC for-next 4/6] RDMA/qedr: remove deliver net device event
Date:   Thu, 16 Jan 2020 12:10:45 +0800
Message-ID: <1579147847-12158-5-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/hw/qedr/main.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index dcdc85a..d85894b 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -957,24 +957,11 @@ static void qedr_remove(struct qedr_dev *dev)
 	ib_dealloc_device(&dev->ibdev);
 }
 
-static void qedr_close(struct qedr_dev *dev)
-{
-	if (test_and_clear_bit(QEDR_ENET_STATE_BIT, &dev->enet_state))
-		qedr_ib_dispatch_event(dev, QEDR_PORT, IB_EVENT_PORT_ERR);
-}
-
 static void qedr_shutdown(struct qedr_dev *dev)
 {
-	qedr_close(dev);
 	qedr_remove(dev);
 }
 
-static void qedr_open(struct qedr_dev *dev)
-{
-	if (!test_and_set_bit(QEDR_ENET_STATE_BIT, &dev->enet_state))
-		qedr_ib_dispatch_event(dev, QEDR_PORT, IB_EVENT_PORT_ACTIVE);
-}
-
 static void qedr_mac_address_change(struct qedr_dev *dev)
 {
 	union ib_gid *sgid = &dev->sgid_tbl[0];
@@ -1014,12 +1001,6 @@ static void qedr_mac_address_change(struct qedr_dev *dev)
 static void qedr_notify(struct qedr_dev *dev, enum qede_rdma_event event)
 {
 	switch (event) {
-	case QEDE_UP:
-		qedr_open(dev);
-		break;
-	case QEDE_DOWN:
-		qedr_close(dev);
-		break;
 	case QEDE_CLOSE:
 		qedr_shutdown(dev);
 		break;
-- 
2.8.1

