Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2601DDD1E
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 08:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJTGyo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 02:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfJTGyo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 02:54:44 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD4982190F;
        Sun, 20 Oct 2019 06:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571554483;
        bh=n2fHxg8y9i0IWGL3/wzldRrCMiOS5XqrHRJGQYQ0Ydc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzFGxmT7Q9Dfhc3gqgYNoJMEHG+j6yCQNunDoH99ZhvclTsOdP4hso5bXJCNwMec1
         cOD3ikFcjdMCtWLI+AxSzybBePWA3BZepaLBb6h7oAr3e/Xf2HGJuVaMsaqd34TDzD
         JzmC7VP/wfAgv2DiuplKvd6zVXqG0/XeMB80+drM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 3/3] IB/core: Do not notify GID change event of an unregistered device
Date:   Sun, 20 Oct 2019 09:54:27 +0300
Message-Id: <20191020065427.8772-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020065427.8772-1-leon@kernel.org>
References: <20191020065427.8772-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

When IB device is undergoing unregistration, GID cache is cleaned up
after all clients are unregistered in below flow.

__ib_unregister_device()
disable_device();
  ib_cache_cleanup_one()
    gid_table_cleanup_one()
      cleanup_gid_table_port()

There is no use of generating a GID change event at such stage, where
there is no active client of the device and device is unregistered
state.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cache.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index b626ca682004..53d8313e8309 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -818,22 +818,16 @@ static void cleanup_gid_table_port(struct ib_device *ib_dev, u8 port,
 				   struct ib_gid_table *table)
 {
 	int i;
-	bool deleted = false;

 	if (!table)
 		return;

 	mutex_lock(&table->lock);
 	for (i = 0; i < table->sz; ++i) {
-		if (is_gid_entry_valid(table->data_vec[i])) {
+		if (is_gid_entry_valid(table->data_vec[i]))
 			del_gid(ib_dev, port, table, i);
-			deleted = true;
-		}
 	}
 	mutex_unlock(&table->lock);
-
-	if (deleted)
-		dispatch_gid_change_event(ib_dev, port);
 }

 void ib_cache_gid_set_default_gid(struct ib_device *ib_dev, u8 port,
--
2.20.1

