Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71E13D314
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 05:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgAPEOq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 23:14:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730782AbgAPEOq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 23:14:46 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 96124B73007A4B1015A4;
        Thu, 16 Jan 2020 12:14:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 12:14:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <shiraz.saleem@intel.com>, <aditr@vmware.com>,
        <mkalderon@marvell.com>, <aelior@marvell.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH RFC for-next 6/6] qede: remove invalid notify operation
Date:   Thu, 16 Jan 2020 12:10:47 +0800
Message-ID: <1579147847-12158-7-git-send-email-liweihang@huawei.com>
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

The qedr notify() has removed the processing of QEDE_UP and QEDE_DOWN,
so qede no longer needs to notify rdma of these two events.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/net/ethernet/qlogic/qede/qede_rdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_rdma.c b/drivers/net/ethernet/qlogic/qede/qede_rdma.c
index ffabc2d..0493279 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_rdma.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_rdma.c
@@ -145,8 +145,6 @@ void qede_rdma_dev_remove(struct qede_dev *edev, bool recovery)
 
 static void _qede_rdma_dev_open(struct qede_dev *edev)
 {
-	if (qedr_drv && edev->rdma_info.qedr_dev && qedr_drv->notify)
-		qedr_drv->notify(edev->rdma_info.qedr_dev, QEDE_UP);
 }
 
 static void qede_rdma_dev_open(struct qede_dev *edev)
@@ -161,8 +159,6 @@ static void qede_rdma_dev_open(struct qede_dev *edev)
 
 static void _qede_rdma_dev_close(struct qede_dev *edev)
 {
-	if (qedr_drv && edev->rdma_info.qedr_dev && qedr_drv->notify)
-		qedr_drv->notify(edev->rdma_info.qedr_dev, QEDE_DOWN);
 }
 
 static void qede_rdma_dev_close(struct qede_dev *edev)
-- 
2.8.1

