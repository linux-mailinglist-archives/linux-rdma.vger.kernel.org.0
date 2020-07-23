Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F022A956
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 09:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgGWHHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jul 2020 03:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGWHHT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Jul 2020 03:07:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB84206E3;
        Thu, 23 Jul 2020 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595488039;
        bh=zc4+qE6T4KVtI5Cfww+UM8J6ijLvA3Aa4ebKVBB2SDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcwEH9Qw6sDfpv6W94D9tHiTPmG0CfHtJh8RKT9ZVmJ7+VdV2K4UI6GWXHsNhpWuD
         RS9Y+2iIb9dfDyzasbtYF96rlpmCv81aITTQUyvwzBIRw+xR09gzmafHGjbfaqDjoP
         2NvtFfxMWfJb6hhssS+KDStvGf4grr2VjukkVWt4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/4] RDMA/cma: Simplify DEVICE_REMOVAL for internal_id
Date:   Thu, 23 Jul 2020 10:07:04 +0300
Message-Id: <20200723070707.1771101-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723070707.1771101-1-leon@kernel.org>
References: <20200723070707.1771101-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

cma_process_remove() triggers an unconditional rdma_destroy_id() for
internal_id's and skips the event deliver and transition through
RDMA_CM_DEVICE_REMOVAL.

This is confusing and unnecessary. internal_id always has
cma_listen_handler() as the handler, have it catch the
RDMA_CM_DEVICE_REMOVAL event and directly consume it and signal removal.

This way the FSM sequence never skips the DEVICE_REMOVAL case and the
logic in this hard to test area is simplified.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c30cf5307ce3..537eeebde5f4 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2482,6 +2482,10 @@ static int cma_listen_handler(struct rdma_cm_id *id,
 {
 	struct rdma_id_private *id_priv = id->context;
 
+	/* Listening IDs are always destroyed on removal */
+	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL)
+		return -1;
+
 	id->context = id_priv->id.context;
 	id->event_handler = id_priv->id.event_handler;
 	trace_cm_event_handler(id_priv, event);
@@ -4829,7 +4833,7 @@ static void cma_process_remove(struct cma_device *cma_dev)
 		cma_id_get(id_priv);
 		mutex_unlock(&lock);
 
-		ret = id_priv->internal_id ? 1 : cma_remove_id_dev(id_priv);
+		ret = cma_remove_id_dev(id_priv);
 		cma_id_put(id_priv);
 		if (ret)
 			rdma_destroy_id(&id_priv->id);
-- 
2.26.2

