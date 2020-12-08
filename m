Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB92D248D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 08:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgLHHgn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 02:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgLHHgn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 02:36:43 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/3] RDMA/core: Do not indicate device ready when device enablement fails
Date:   Tue,  8 Dec 2020 09:35:44 +0200
Message-Id: <20201208073545.9723-3-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201208073545.9723-1-leon@kernel.org>
References: <20201208073545.9723-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

In procedure ib_register_device, procedure kobject_uevent is called
(advertising that the device is ready for userspace usage) even when
device_enable_and_get() returned an error.

As a result, various RDMA modules attempted to register for the device
even while the device driver was preparing to unregister the device.

Fix this by advertising the device availability only after enabling
the device succeeds.

Fixes: e7a5b4aafd82 ("RDMA/device: Don't fire uevent before device is fully initialized")
Suggested-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 11485b8748a2..e96f979e6d52 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1397,9 +1397,6 @@ int ib_register_device(struct ib_device *device, const char *name,
 	}
 
 	ret = enable_device_and_get(device);
-	dev_set_uevent_suppress(&device->dev, false);
-	/* Mark for userspace that device is ready */
-	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 	if (ret) {
 		void (*dealloc_fn)(struct ib_device *);
 
@@ -1419,8 +1416,12 @@ int ib_register_device(struct ib_device *device, const char *name,
 		ib_device_put(device);
 		__ib_unregister_device(device);
 		device->ops.dealloc_driver = dealloc_fn;
+		dev_set_uevent_suppress(&device->dev, false);
 		return ret;
 	}
+	dev_set_uevent_suppress(&device->dev, false);
+	/* Mark for userspace that device is ready */
+	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 	ib_device_put(device);
 
 	return 0;
-- 
2.28.0

