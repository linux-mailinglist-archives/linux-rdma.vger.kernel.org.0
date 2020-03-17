Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D70F188600
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 14:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgCQNkh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 09:40:37 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41444 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726084AbgCQNkg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 09:40:36 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 17 Mar 2020 15:40:31 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02HDeUhf028750;
        Tue, 17 Mar 2020 15:40:30 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 4/5] IB/core: cache the CQ completion vector
Date:   Tue, 17 Mar 2020 15:40:29 +0200
Message-Id: <20200317134030.152833-5-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317134030.152833-1-maxg@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In some cases, e.g. when using ib_alloc_cq_any, one would like to know
the completion vector that eventually assigned to the CQ. Cache this
value during CQ creation.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/cq.c | 1 +
 include/rdma/ib_verbs.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 4f25b24..a7cbf52 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -217,6 +217,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	cq->device = dev;
 	cq->cq_context = private;
 	cq->poll_ctx = poll_ctx;
+	cq->comp_vector = comp_vector;
 	atomic_set(&cq->usecnt, 0);
 
 	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index fc8207d..0d61772 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1558,6 +1558,7 @@ struct ib_cq {
 	struct ib_device       *device;
 	struct ib_ucq_object   *uobject;
 	ib_comp_handler   	comp_handler;
+	u32			comp_vector;
 	void                  (*event_handler)(struct ib_event *, void *);
 	void                   *cq_context;
 	int               	cqe;
-- 
1.8.3.1

