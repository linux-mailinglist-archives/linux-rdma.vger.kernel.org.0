Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6ACE1054D
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 07:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfEAFqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 01:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfEAFqY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 01:46:24 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AF521734;
        Wed,  1 May 2019 05:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556689583;
        bh=yuDmkAw5pjFUgXkcwLXbFKBYEJc6Uy2DGZeyxnDCPJM=;
        h=From:To:Cc:Subject:Date:From;
        b=0hnRHMaeT4RMe88JR8oXJcXd0zE2ts0Cshbz6+lPaooUzT/Mvuk+3mgy+XdN9Ox8T
         Y9wZm0CU8fJTXd8TJhfj/iwdCbS4dCGpONS6l50/Wr/JckIkfbqViGomoCsLeY9Y1K
         DzZRUiPyM2hlu2ssZ4iKHI5PZg56EG9og19Xo2Ck=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH rdma-next] RDMA/device: Don't fire uevent before device is fully initialized
Date:   Wed,  1 May 2019 08:46:19 +0300
Message-Id: <20190501054619.14838-1-leon@kernel.org>
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
 drivers/infiniband/core/device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8ae4906a60e7..4cdc8588df7f 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -808,6 +808,7 @@ static int add_one_compat_dev(struct ib_device *device,
 	cdev->dev.release = compatdev_release;
 	dev_set_name(&cdev->dev, "%s", dev_name(&device->dev));

+	dev_set_uevent_suppress(&device->dev, true);
 	ret = device_add(&cdev->dev);
 	if (ret)
 		goto add_err;
@@ -828,6 +829,7 @@ static int add_one_compat_dev(struct ib_device *device,
 port_err:
 	device_del(&cdev->dev);
 add_err:
+	dev_set_uevent_suppress(&device->dev, false);
 	put_device(&cdev->dev);
 cdev_err:
 	xa_release(&device->compat_devs, rnet->id);
@@ -845,6 +847,7 @@ static void remove_one_compat_dev(struct ib_device *device, u32 id)
 	mutex_unlock(&device->compat_devs_mutex);
 	if (cdev) {
 		ib_free_port_attrs(cdev);
+		dev_set_uevent_suppress(&device->dev, false);
 		device_del(&cdev->dev);
 		put_device(&cdev->dev);
 	}
@@ -1207,6 +1210,7 @@ static int enable_device_and_get(struct ib_device *device)
 		ret = add_compat_devs(device);
 out:
 	up_read(&devices_rwsem);
+	dev_set_uevent_suppress(&device->dev, false);
 	return ret;
 }

@@ -1244,6 +1248,11 @@ int ib_register_device(struct ib_device *device, const char *name)

 	ib_device_register_rdmacg(device);

+	/*
+	 * Ensure that ADD uevent is not fired because it
+	 * too early amd device is not initialized yet.
+	 */
+	dev_set_uevent_suppress(&device->dev, true);
 	ret = device_add(&device->dev);
 	if (ret)
 		goto cg_cleanup;
@@ -1262,6 +1271,8 @@ int ib_register_device(struct ib_device *device, const char *name)
 	}

 	ret = enable_device_and_get(device);
+	/* Mark for userspace that device is ready */
+	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 	if (ret) {
 		void (*dealloc_fn)(struct ib_device *);

@@ -1292,6 +1303,7 @@ int ib_register_device(struct ib_device *device, const char *name)
 dev_cleanup:
 	device_del(&device->dev);
 cg_cleanup:
+	dev_set_uevent_suppress(&device->dev, false);
 	ib_device_unregister_rdmacg(device);
 	ib_cache_cleanup_one(device);
 	return ret;
--
2.20.1

