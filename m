Return-Path: <linux-rdma+bounces-878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD4848650
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Feb 2024 13:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860C1286D05
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Feb 2024 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FDB5D919;
	Sat,  3 Feb 2024 12:49:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m603.netease.com (mail-m603.netease.com [210.79.60.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291A17C77;
	Sat,  3 Feb 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706964548; cv=none; b=D3dBvfPC/Pum2f9qZHWkYKRRFkDkQrr5Oma89vrk7HQMF3xglYJm1Fof/auUFMp/ItR6SBKsN5JUPVTzVP8PlgqrDJo3kcaYBiKll6a1g0eOawMoKejg+VOQMhjPoRvetX7ZWTSS724ZG4LOoq/uJw4/YwieC7sppC0LC1YU788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706964548; c=relaxed/simple;
	bh=XRj6ASeP5ukkKJj1qJw3G49h4JawUD81xDI2HwCZ1tA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MqCCVhEvuC3QP2EMXHMTld9Ha18eYSx4vJrz/LNSUXPAebZv3tnJV89O0Sb9v1zmjzv/gJdQXsY9Um1pzxRwe6nIMsH7JKln62pelhhWWzesAWdeTNK5v9DQ1x6/gKXyoMSQqkVpKZpwh8zWCQVfAZC3fdlMjpGUuvIWm/g680c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=210.79.60.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from ubuntu.localdomain (unknown [36.36.46.39])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 3D7EE46015D;
	Sat,  3 Feb 2024 11:53:38 +0800 (CST)
From: Shifeng Li <lishifeng@sangfor.com.cn>
To: jgg@ziepe.ca,
	leon@kernel.org,
	wenglianfa@huawei.com,
	gustavoars@kernel.org,
	lishifeng@sangfor.com.cn
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ding Hui <dinghui@sangfor.com.cn>,
	Shifeng Li <lishifeng1992@126.com>
Subject: [PATCH v2] RDMA/device: Fix a race between mad_client and cm_client init
Date: Fri,  2 Feb 2024 19:53:13 -0800
Message-Id: <20240203035313.98991-1-lishifeng@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0NNVkNNHh8ZHR1ISh1KGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUhNVUhNVU9NVUhCWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg++
X-HM-Tid: 0a8d6d19b7dd03aekunm3d7ee46015d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQw6Aio6MDMJCzgNOhEWSiNI
	VjUaCxxVSlVKTEtNQkhJT0pDQ0JNVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
	C1lBWUhNVUhNVU9NVUhCWVdZCAFZQU9DSUw3Bg++

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

Fix it by using down_write(&devices_rwsem) in ib_register_client().

Fixes: d0899892edd0 ("RDMA/device: Provide APIs from the core code to help unregistration")
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ding Hui <dinghui@sangfor.com.cn>
Cc: Shifeng Li <lishifeng1992@126.com>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
---
 drivers/infiniband/core/device.c | 33 +++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

---
v1->v2: Use down_write(&devices_rwsem) in ib_register_client().

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 67bcea7a153c..ff08a665524a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1730,7 +1730,7 @@ static int assign_client_id(struct ib_client *client)
 {
 	int ret;
 
-	down_write(&clients_rwsem);
+	lockdep_assert_held(&clients_rwsem);
 	/*
 	 * The add/remove callbacks must be called in FIFO/LIFO order. To
 	 * achieve this we assign client_ids so they are sorted in
@@ -1739,14 +1739,11 @@ static int assign_client_id(struct ib_client *client)
 	client->client_id = highest_client_id;
 	ret = xa_insert(&clients, client->client_id, client, GFP_KERNEL);
 	if (ret)
-		goto out;
+		return ret;
 
 	highest_client_id++;
 	xa_set_mark(&clients, client->client_id, CLIENT_REGISTERED);
-
-out:
-	up_write(&clients_rwsem);
-	return ret;
+	return 0;
 }
 
 static void remove_client_id(struct ib_client *client)
@@ -1776,25 +1773,31 @@ int ib_register_client(struct ib_client *client)
 {
 	struct ib_device *device;
 	unsigned long index;
+	bool need_unreg = false;
 	int ret;
 
 	refcount_set(&client->uses, 1);
 	init_completion(&client->uses_zero);
+
+	down_write(&devices_rwsem);
+	down_write(&clients_rwsem);
 	ret = assign_client_id(client);
 	if (ret)
-		return ret;
+		goto out;
 
-	down_read(&devices_rwsem);
+	need_unreg = true;
 	xa_for_each_marked (&devices, index, device, DEVICE_REGISTERED) {
 		ret = add_client_context(device, client);
-		if (ret) {
-			up_read(&devices_rwsem);
-			ib_unregister_client(client);
-			return ret;
-		}
+		if (ret)
+			goto out;
 	}
-	up_read(&devices_rwsem);
-	return 0;
+	ret = 0;
+out:
+	up_write(&clients_rwsem);
+	up_write(&devices_rwsem);
+	if (need_unreg && ret)
+		ib_unregister_client(client);
+	return ret;
 }
 EXPORT_SYMBOL(ib_register_client);
 
-- 
2.25.1


