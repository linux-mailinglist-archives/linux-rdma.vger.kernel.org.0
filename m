Return-Path: <linux-rdma+bounces-512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DA58216C0
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 04:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D30BB2106D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 03:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779AEC8;
	Tue,  2 Jan 2024 03:53:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m118196.ym.163.com (mail-m118196.ym.163.com [115.236.118.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CDA20F8;
	Tue,  2 Jan 2024 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from ubuntu.localdomain (unknown [111.222.250.119])
	by mail-m12750.qiye.163.com (Hmail) with ESMTPA id 2C2E2F2038A;
	Tue,  2 Jan 2024 11:43:57 +0800 (CST)
From: Shifeng Li <lishifeng@sangfor.com.cn>
To: jgg@ziepe.ca,
	leon@kernel.org,
	wenglianfa@huawei.com,
	gustavoars@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shifeng Li <lishifeng@sangfor.com.cn>,
	Shifeng Li <lishifeng1992@126.com>
Subject: [PATCH] RDMA/device: Fix a race between mad_client and cm_client init
Date: Mon,  1 Jan 2024 19:43:35 -0800
Message-Id: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTx9CVkpKH0NDHkNJGhhNS1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSlVJSUlVSU5LVUpKQllXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8cc8455a43b21dkuuu2c2e2f2038a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6Vio5NDw8FUkqMD81TTgT
	LRcKCi1VSlVKTEtPSk1MS0hDS0hNVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
	C1lBWUpKSlVJSUlVSU5LVUpKQllXWQgBWUFITUlPNwY+

The mad_client will be initialized in enable_device_and_get(), while the
devices_rwsem will be downgraded to a read semaphore. There is a window
that leads to the failed initialization for cm_client, since it can not
get matched mad port from ib_mad_port_list, and the matched mad port will
be added to the list after that.

    mad_client    |                       cm_client
------------------|--------------------------------------------------------
ib_register_device|
enable_device_and_get
down_write(&devices_rwsem)
xa_set_mark(&devices, DEVICE_REGISTERED)
downgrade_write(&devices_rwsem)
                  |
                  |ib_cm_init
                  |ib_register_client(&cm_client)
                  |down_read(&devices_rwsem)
                  |xa_for_each_marked (&devices, DEVICE_REGISTERED)
                  |add_client_context
                  |cm_add_one
                  |ib_register_mad_agent
                  |ib_get_mad_port
                  |__ib_get_mad_port
                  |list_for_each_entry(entry, &ib_mad_port_list, port_list)
                  |return NULL
                  |up_read(&devices_rwsem)
                  |
add_client_context|
ib_mad_init_device|
ib_mad_port_open  |
list_add_tail(&port_priv->port_list, &ib_mad_port_list)
up_read(&devices_rwsem)
                  |

Fix it by using the devices_rwsem write semaphore to protect the mad_client
init flow in enable_device_and_get().

Fixes: d0899892edd0 ("RDMA/device: Provide APIs from the core code to help unregistration")
Cc: Shifeng Li <lishifeng1992@126.com>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
---
 drivers/infiniband/core/device.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 67bcea7a153c..85782786993d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1315,12 +1315,6 @@ static int enable_device_and_get(struct ib_device *device)
 	down_write(&devices_rwsem);
 	xa_set_mark(&devices, device->index, DEVICE_REGISTERED);
 
-	/*
-	 * By using downgrade_write() we ensure that no other thread can clear
-	 * DEVICE_REGISTERED while we are completing the client setup.
-	 */
-	downgrade_write(&devices_rwsem);
-
 	if (device->ops.enable_driver) {
 		ret = device->ops.enable_driver(device);
 		if (ret)
@@ -1337,7 +1331,7 @@ static int enable_device_and_get(struct ib_device *device)
 	if (!ret)
 		ret = add_compat_devs(device);
 out:
-	up_read(&devices_rwsem);
+	up_write(&devices_rwsem);
 	return ret;
 }
 
-- 
2.25.1


