Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95AD11522
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 10:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBIMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 04:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfEBIMf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 04:12:35 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E34D20651;
        Thu,  2 May 2019 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556784754;
        bh=AxrzhpwFXsrxztnzM0oAq0UQ0IBgv0V46yj6xMkxqLc=;
        h=From:To:Cc:Subject:Date:From;
        b=oDmnDjmfwsAWywJvcVIa68n1qWMM7eWGT7ZxAs59a49u28DSjmuE9rr3L0z4AgotH
         FFEEuMj2hY665tJMauRVXmOzodJ3dPJAgexcxNVYGC4rVe+9NlVR/V8fqw7V3WNR6C
         N9Y5dvP0bz6caYwWAH1gpkREMOhcOqonRt/f38xY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH rdma-next v1] RDMA/device: Don't fire uevent before device is fully initialized
Date:   Thu,  2 May 2019 11:12:29 +0300
Message-Id: <20190502081229.18372-1-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

When the refcount is 0 the device is invisible to netlink. However
in the patch below the refcount = 1 was moved to after the device_add().
This creates a race where userspace can issue a netlink query after the
device_add() event and not see the device as visible.

Ensure that no uevent is fired before device is fully registered.

Fixes: d79af7242bb2 ("RDMA/device: Expose ib_device_try_get(()")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 Changelog v0->v1:
 * Dropped uevent suppress in compat devices.
---
 drivers/infiniband/core/device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8ae4906a60e7..7c51406e34e2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1244,6 +1244,11 @@ int ib_register_device(struct ib_device *device, const char *name)

 	ib_device_register_rdmacg(device);

+	/*
+	 * Ensure that ADD uevent is not fired because it
+	 * too early amd device is not initialized yet.
+	 */
+	dev_set_uevent_suppress(&device->dev, true);
 	ret = device_add(&device->dev);
 	if (ret)
 		goto cg_cleanup;
@@ -1262,6 +1267,9 @@ int ib_register_device(struct ib_device *device, const char *name)
 	}

 	ret = enable_device_and_get(device);
+	dev_set_uevent_suppress(&device->dev, false);
+	/* Mark for userspace that device is ready */
+	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 	if (ret) {
 		void (*dealloc_fn)(struct ib_device *);

@@ -1292,6 +1300,7 @@ int ib_register_device(struct ib_device *device, const char *name)
 dev_cleanup:
 	device_del(&device->dev);
 cg_cleanup:
+	dev_set_uevent_suppress(&device->dev, false);
 	ib_device_unregister_rdmacg(device);
 	ib_cache_cleanup_one(device);
 	return ret;
--
2.20.1

