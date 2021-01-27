Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9A305FCE
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 16:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhA0PfK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 10:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235510AbhA0PDf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D1F221919;
        Wed, 27 Jan 2021 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759640;
        bh=NI+RaUknc8Ab2FCGNlrnAUViCsML5JWGGhexb9cxZFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iB8V1wGJ7ZaZ69uspm1MJbVBNtf+7kmTFVmvdOkrbjOLkSTBQM+4Pp7s8lnZ1dE2e
         RQqyN703GrWSf500ErdFDIWPIGMvCPCu9/cQ7kb32pxm6+KVpkkJvke8YZX+HCfQ+A
         XSnsBC+8xf+2HjQp/g6H91eJf4uvDqI4CutQ1lo3FO0bUfpOvTYIf5txCipBRjAr5N
         EN/9YnXhu9AZgWgk2cSJeKqpBqEL8z6kO6y0ZWImaDntuxIIWxHclj0iCwqDzp2sA5
         /RsmjaHDV/U4U5MMTIIqoIlPz5Ya9m3ZVec36kEpchGuLyIWDJaQSRXy5DWVoHG6SA
         hizrzd548zwDQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 08/10] IB/cm: Avoid a loop when device has 255 ports
Date:   Wed, 27 Jan 2021 17:00:08 +0200
Message-Id: <20210127150010.1876121-9-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127150010.1876121-1-leon@kernel.org>
References: <20210127150010.1876121-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

When RDMA device has 255 ports, loop iterator i overflows.
Due to which cm_add_one() port iterator loops infinitely.
Use core provided port iterator to avoid the infinite loop.

Fixes: a977049dacde ("[PATCH] IB: Add the kernel CM implementation")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 98165589c8ab..be996dba040c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4333,7 +4333,7 @@ static int cm_add_one(struct ib_device *ib_device)
 	unsigned long flags;
 	int ret;
 	int count = 0;
-	u8 i;
+	unsigned int i;

 	cm_dev = kzalloc(struct_size(cm_dev, port, ib_device->phys_port_cnt),
 			 GFP_KERNEL);
@@ -4345,7 +4345,7 @@ static int cm_add_one(struct ib_device *ib_device)
 	cm_dev->going_down = 0;

 	set_bit(IB_MGMT_METHOD_SEND, reg_req.method_mask);
-	for (i = 1; i <= ib_device->phys_port_cnt; i++) {
+	rdma_for_each_port (ib_device, i) {
 		if (!rdma_cap_ib_cm(ib_device, i))
 			continue;

@@ -4431,7 +4431,7 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 		.clr_port_cap_mask = IB_PORT_CM_SUP
 	};
 	unsigned long flags;
-	int i;
+	unsigned int i;

 	write_lock_irqsave(&cm.device_lock, flags);
 	list_del(&cm_dev->list);
@@ -4441,7 +4441,7 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 	cm_dev->going_down = 1;
 	spin_unlock_irq(&cm.lock);

-	for (i = 1; i <= ib_device->phys_port_cnt; i++) {
+	rdma_for_each_port (ib_device, i) {
 		if (!rdma_cap_ib_cm(ib_device, i))
 			continue;

--
2.29.2

