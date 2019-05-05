Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F225D1411B
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 18:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfEEQdb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 12:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEQdb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 12:33:31 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5813A206DF;
        Sun,  5 May 2019 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557074010;
        bh=0+MGb+q+Lgzv9cQDX5KatpnJUXpNd0N9pc98843P8lE=;
        h=From:To:Cc:Subject:Date:From;
        b=rofrB6g9+wsuQALOC6mQCPa7dMU7FFdV95cQnhBUMQ7VuAMbi3dt+xNPcS5bgkkg3
         xbAtmGHnKIlxswcExHMOLtrBx36PhPcjrOF26vP3al2oOQPykvg6yY/I6PM8xIN6gE
         IiXvtcJ2oKi1MGEp10Vh58QUyaW9l6MrIMmPXvFY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH rdma-next v1] RDMA/device: Don't fire uevent before device is fully initialized
Date:   Sun,  5 May 2019 19:33:20 +0300
Message-Id: <20190505163320.9014-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
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
Changelog
 v0 -> v1
 * Fix comment as suggested by Parav.
---
 drivers/infiniband/core/device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8ec1ad7b5441..ca1dba5f9ec6 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1304,6 +1304,11 @@ int ib_register_device(struct ib_device *device, const char *name)

 	ib_device_register_rdmacg(device);

+	/*
+	 * Ensure that ADD uevent is not fired because it
+	 * is too early amd device is not initialized yet.
+	 */
+	dev_set_uevent_suppress(&device->dev, true);
 	ret = device_add(&device->dev);
 	if (ret)
 		goto cg_cleanup;
@@ -1322,6 +1327,9 @@ int ib_register_device(struct ib_device *device, const char *name)
 	}

 	ret = enable_device_and_get(device);
+	dev_set_uevent_suppress(&device->dev, false);
+	/* Mark for userspace that device is ready */
+	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 	if (ret) {
 		void (*dealloc_fn)(struct ib_device *);

@@ -1352,6 +1360,7 @@ int ib_register_device(struct ib_device *device, const char *name)
 dev_cleanup:
 	device_del(&device->dev);
 cg_cleanup:
+	dev_set_uevent_suppress(&device->dev, false);
 	ib_device_unregister_rdmacg(device);
 	ib_cache_cleanup_one(device);
 	return ret;
--
2.20.1

