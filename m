Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD7149B0C
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgAZO1K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:27:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387401AbgAZO1K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:27:10 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07E1220708;
        Sun, 26 Jan 2020 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580048829;
        bh=hkEzVIDNhPaDMZe0s+LhEP+uEoazk1z54GRsqqQIIjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/c6pik9MNJdeRHOGdoyGBiKKNi6+vuXjkb8nFZHB6Q5Lg7bmQOhXaJYTsKG6kywB
         ljM+dp/UZEbufica0hewTY+imVBTtmSXnA4ktsIPMgAtHbOz0lFD4ofh4R7BFOBC2G
         ldv/I8kah7+wslrCHkZ8lL4+Xi3ytmzth+Gpzquk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 1/7] RDMA/cma: Fix unbalanced cm_id reference count during address resolve
Date:   Sun, 26 Jan 2020 16:26:46 +0200
Message-Id: <20200126142652.104803-2-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200126142652.104803-1-leon@kernel.org>
References: <20200126142652.104803-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Below cited commit missed to consider AF_IB and loopback code flow in
rdma_resolve_addr().
This leads to unbalanced cm_id refcount in cma_work_handler() which
puts the refcount which was not incremented in rdma_resolve_addr().

A call trace is observed with such code flow.

BUG: unable to handle kernel NULL pointer dereference at (null)
[<ffffffff96b67e16>] __mutex_lock_slowpath+0x166/0x1d0
[<ffffffff96b6715f>] mutex_lock+0x1f/0x2f
[<ffffffffc0beabb5>] cma_work_handler+0x25/0xa0
[<ffffffff964b9ebf>] process_one_work+0x17f/0x440
[<ffffffff964baf56>] worker_thread+0x126/0x3c0

Hence, hold the cm_id reference when scheduling resolve work item.

Fixes: 722c7b2bfead ("RDMA/{cma, core}: Avoid callback on rdma_addr_cancel()")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 55a9afacfedd..72f032160c4b 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3148,6 +3148,7 @@ static int cma_resolve_loopback(struct rdma_id_private *id_priv)
 	rdma_addr_get_sgid(&id_priv->id.route.addr.dev_addr, &gid);
 	rdma_addr_set_dgid(&id_priv->id.route.addr.dev_addr, &gid);
 
+	atomic_inc(&id_priv->refcount);
 	cma_init_resolve_addr_work(work, id_priv);
 	queue_work(cma_wq, &work->work);
 	return 0;
@@ -3174,6 +3175,7 @@ static int cma_resolve_ib_addr(struct rdma_id_private *id_priv)
 	rdma_addr_set_dgid(&id_priv->id.route.addr.dev_addr, (union ib_gid *)
 		&(((struct sockaddr_ib *) &id_priv->id.route.addr.dst_addr)->sib_addr));
 
+	atomic_inc(&id_priv->refcount);
 	cma_init_resolve_addr_work(work, id_priv);
 	queue_work(cma_wq, &work->work);
 	return 0;
-- 
2.24.1

