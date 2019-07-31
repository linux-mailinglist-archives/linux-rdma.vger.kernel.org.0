Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D667BB64
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 10:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGaISz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 04:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfGaISz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 04:18:55 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE798206A3;
        Wed, 31 Jul 2019 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564561134;
        bh=MNQZooFHctt3n22tCqkREDSYgnGabBlRNFm6lbQH684=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKAGtsmstmCFQpkl8Mab++m2pCu7Cg9zPhu/pGaN9P/3UHGZuL9BkyPnir6kSlXuA
         J9hhJgPHbi2bvXisEHZuU8z9Fpa/0u2T+f/qTIXZxQ4e2o1/bAZ8kIFe2Q/tYPP/by
         Vuy5rVimV+Gdlh8aEmyjHm8bi+NP5Lj3ntXGNcLU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH rdma-rc 2/2] RDMA/devices: Remove the lock around remove_client_context
Date:   Wed, 31 Jul 2019 11:18:41 +0300
Message-Id: <20190731081841.32345-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731081841.32345-1-leon@kernel.org>
References: <20190731081841.32345-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Due to the complexity of client->remove() callbacks it is desirable to not
hold any locks while calling them. Remove the last one by tracking only
the highest client ID and running backwards from there over the xarray.

Since the only purpose of that lock was to protect the linked list, we can
drop the lock.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c | 48 ++++++++++++++++++--------------
 include/rdma/ib_verbs.h          |  1 -
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d86fbabe48d6..ea8661a00651 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -94,7 +94,7 @@ static DEFINE_XARRAY_FLAGS(devices, XA_FLAGS_ALLOC);
 static DECLARE_RWSEM(devices_rwsem);
 #define DEVICE_REGISTERED XA_MARK_1
 
-static LIST_HEAD(client_list);
+static u32 highest_client_id;
 #define CLIENT_REGISTERED XA_MARK_1
 static DEFINE_XARRAY_FLAGS(clients, XA_FLAGS_ALLOC);
 static DECLARE_RWSEM(clients_rwsem);
@@ -1237,7 +1237,7 @@ static int setup_device(struct ib_device *device)
 
 static void disable_device(struct ib_device *device)
 {
-	struct ib_client *client;
+	u32 cid;
 
 	WARN_ON(!refcount_read(&device->refcount));
 
@@ -1245,10 +1245,19 @@ static void disable_device(struct ib_device *device)
 	xa_clear_mark(&devices, device->index, DEVICE_REGISTERED);
 	up_write(&devices_rwsem);
 
+	/*
+	 * Remove clients in LIFO order, see assign_client_id. This could be
+	 * more efficient if xarray learns to reverse iterate. Since no new
+	 * clients can be added to this ib_device past this point we only need
+	 * the maximum possible client_id value here.
+	 */
 	down_read(&clients_rwsem);
-	list_for_each_entry_reverse(client, &client_list, list)
-		remove_client_context(device, client->client_id);
+	cid = highest_client_id;
 	up_read(&clients_rwsem);
+	while (cid) {
+		cid--;
+		remove_client_context(device, cid);
+	}
 
 	/* Pairs with refcount_set in enable_device */
 	ib_device_put(device);
@@ -1675,30 +1684,31 @@ static int assign_client_id(struct ib_client *client)
 	/*
 	 * The add/remove callbacks must be called in FIFO/LIFO order. To
 	 * achieve this we assign client_ids so they are sorted in
-	 * registration order, and retain a linked list we can reverse iterate
-	 * to get the LIFO order. The extra linked list can go away if xarray
-	 * learns to reverse iterate.
+	 * registration order.
 	 */
-	if (list_empty(&client_list)) {
-		client->client_id = 0;
-	} else {
-		struct ib_client *last;
-
-		last = list_last_entry(&client_list, struct ib_client, list);
-		client->client_id = last->client_id + 1;
-	}
+	client->client_id = highest_client_id;
 	ret = xa_insert(&clients, client->client_id, client, GFP_KERNEL);
 	if (ret)
 		goto out;
 
+	highest_client_id++;
 	xa_set_mark(&clients, client->client_id, CLIENT_REGISTERED);
-	list_add_tail(&client->list, &client_list);
 
 out:
 	up_write(&clients_rwsem);
 	return ret;
 }
 
+static void remove_client_id(struct ib_client *client)
+{
+	down_write(&clients_rwsem);
+	xa_erase(&clients, client->client_id);
+	for (; highest_client_id; highest_client_id--)
+		if (xa_load(&clients, highest_client_id - 1))
+			break;
+	up_write(&clients_rwsem);
+}
+
 /**
  * ib_register_client - Register an IB client
  * @client:Client to register
@@ -1778,11 +1788,7 @@ void ib_unregister_client(struct ib_client *client)
 	 * removal is ongoing. Wait until all removals are completed.
 	 */
 	wait_for_completion(&client->uses_zero);
-
-	down_write(&clients_rwsem);
-	list_del(&client->list);
-	xa_erase(&clients, client->client_id);
-	up_write(&clients_rwsem);
+	remove_client_id(client);
 }
 EXPORT_SYMBOL(ib_unregister_client);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7b80ec822043..4f225175cb91 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2650,7 +2650,6 @@ struct ib_client {
 
 	refcount_t uses;
 	struct completion uses_zero;
-	struct list_head list;
 	u32 client_id;
 
 	/* kverbs are not required by the client */
-- 
2.20.1

