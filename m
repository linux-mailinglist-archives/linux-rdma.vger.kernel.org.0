Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC011CC3F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfLLLam (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 06:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfLLLam (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 06:30:42 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A35C2464B;
        Thu, 12 Dec 2019 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576150241;
        bh=pLQN6momOox5+M0vfoycGQsbaYW4jWyijM0pJGJEp5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yppvUGlesyOeXaY5xdIsuro+4dwz+EcQoz7kye0mWKtzYiOx16coF4md6dikcjn0f
         U7gC25sd2n63zb8IUQB52qvcv4hkxau0PdBbB0XK86J77VKyUJfGe2B0icApR1ULBf
         U8w9+/QSWlSRYydPhjHevANrkhqFzWDgbkhhmWMM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v1 4/4] IB/core: Prefix qp to event_handler_lock
Date:   Thu, 12 Dec 2019 13:30:24 +0200
Message-Id: <20191212113024.336702-5-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212113024.336702-1-leon@kernel.org>
References: <20191212113024.336702-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Since event_handler_lock is accessed while executing QP's event handler,
prefix it with qp_ to avoid confusion with device's event_handler_list
and event_handler_rwsem.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c |  2 +-
 drivers/infiniband/core/verbs.c  | 12 ++++++------
 include/rdma/ib_verbs.h          |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c38b2b0b078a..90794238bae8 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -587,7 +587,7 @@ struct ib_device *_ib_alloc_device(size_t size)
 	rdma_init_coredev(&device->coredev, device, &init_net);

 	INIT_LIST_HEAD(&device->event_handler_list);
-	spin_lock_init(&device->event_handler_lock);
+	spin_lock_init(&device->qp_event_handler_lock);
 	init_rwsem(&device->event_handler_rwsem);
 	mutex_init(&device->unregistration_lock);
 	/*
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index dd765e176cdd..4606a5221ba5 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1053,11 +1053,11 @@ static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
 	struct ib_qp *qp = context;
 	unsigned long flags;

-	spin_lock_irqsave(&qp->device->event_handler_lock, flags);
+	spin_lock_irqsave(&qp->device->qp_event_handler_lock, flags);
 	list_for_each_entry(event->element.qp, &qp->open_list, open_list)
 		if (event->element.qp->event_handler)
 			event->element.qp->event_handler(event, event->element.qp->qp_context);
-	spin_unlock_irqrestore(&qp->device->event_handler_lock, flags);
+	spin_unlock_irqrestore(&qp->device->qp_event_handler_lock, flags);
 }

 static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct ib_qp *qp)
@@ -1094,9 +1094,9 @@ static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
 	qp->qp_num = real_qp->qp_num;
 	qp->qp_type = real_qp->qp_type;

-	spin_lock_irqsave(&real_qp->device->event_handler_lock, flags);
+	spin_lock_irqsave(&real_qp->device->qp_event_handler_lock, flags);
 	list_add(&qp->open_list, &real_qp->open_list);
-	spin_unlock_irqrestore(&real_qp->device->event_handler_lock, flags);
+	spin_unlock_irqrestore(&real_qp->device->qp_event_handler_lock, flags);

 	return qp;
 }
@@ -1824,9 +1824,9 @@ int ib_close_qp(struct ib_qp *qp)
 	if (real_qp == qp)
 		return -EINVAL;

-	spin_lock_irqsave(&real_qp->device->event_handler_lock, flags);
+	spin_lock_irqsave(&real_qp->device->qp_event_handler_lock, flags);
 	list_del(&qp->open_list);
-	spin_unlock_irqrestore(&real_qp->device->event_handler_lock, flags);
+	spin_unlock_irqrestore(&real_qp->device->qp_event_handler_lock, flags);

 	atomic_dec(&real_qp->usecnt);
 	if (qp->qp_sec)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index eaf9c948ff9b..e16a592e4536 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2626,7 +2626,7 @@ struct ib_device {
 	struct rw_semaphore event_handler_rwsem;

 	/* Protects QP's event_handler calls and open_qp list */
-	spinlock_t event_handler_lock;
+	spinlock_t qp_event_handler_lock;

 	struct rw_semaphore	      client_data_rwsem;
 	struct xarray                 client_data;
--
2.20.1

