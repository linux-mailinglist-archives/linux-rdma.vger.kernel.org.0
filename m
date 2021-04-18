Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F45C3635C4
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhDRN4e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhDRN4e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:56:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CE8661278;
        Sun, 18 Apr 2021 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618754166;
        bh=xTQVU23vv4vFVH8b5sqfOmXOSliZQPjEFMVWz/T3f6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcWioemJV1yHD+l77bhts+A8GxjjoorbaXhXE+CjdtzhSlcZwIxVWwodWP+l9N0n9
         Gsub3QILeOjG0zKypwFdqnwopbTZhJjWsGGTXoYFmoDIEEXxEOJ/sSkRXX0XKqhMDB
         zLMQmYqKYh4v4jMDh5GracXfBZ9Z7vlVI0F0bjvUef4xhnx7JGS5I8yRhSx9xE6ZPp
         Rb2+HsQRxeFm1VB/5WMkx7zCBcvZ4afwrO0pxFGiR/wgVpvuHspcUTS05K8HA/bXgm
         a2ug6d1ZAbLp3G5h24tFsUm8H26SaN1jV/u73RtwrHeZWKXvwMty4F3/hK9EoqyZ3y
         +ueGdGXk3JGFQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/3] RDMA/core: Add CM to restrack after successful attachment to a device
Date:   Sun, 18 Apr 2021 16:55:54 +0300
Message-Id: <ab93e56ba831eac65c322b3256796fa1589ec0bb.1618753862.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618753862.git.leonro@nvidia.com>
References: <cover.1618753862.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

The device attach triggers addition of CM_ID to the restrack DB.
However, when error occurs, we releasing this device, but defer CM_ID
release. This causes to the situation where restrack sees CM_ID that
is not valid anymore.

As a solution, add the CM_ID to the resource tracking DB only after
the attachment is finished.

Found by syzcaller:
infiniband syz0: added syz_tun
rdma_rxe: ignoring netdev event = 10 for syz_tun
infiniband syz0: set down
infiniband syz0: ib_query_port failed (-19)
restrack: ------------[ cut here    ]------------
infiniband syz0: BUG: RESTRACK detected leak of resources
restrack: User CM_ID object allocated by syz-executor716 is not freed
restrack: ------------[ cut here    ]------------

Fixes: b09c4d701220 ("RDMA/restrack: Improve readability in task name management")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index cc990adaf2b5..1db2279cff18 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -454,7 +454,6 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 	id_priv->id.route.addr.dev_addr.transport =
 		rdma_node_get_transport(cma_dev->device->node_type);
 	list_add_tail(&id_priv->list, &cma_dev->id_list);
-	rdma_restrack_add(&id_priv->res);
 
 	trace_cm_id_attach(id_priv, cma_dev->device);
 }
@@ -691,6 +690,7 @@ static int cma_ib_acquire_dev(struct rdma_id_private *id_priv,
 	mutex_lock(&lock);
 	cma_attach_to_dev(id_priv, listen_id_priv->cma_dev);
 	mutex_unlock(&lock);
+	rdma_restrack_add(&id_priv->res);
 	return 0;
 }
 
@@ -745,8 +745,10 @@ static int cma_iw_acquire_dev(struct rdma_id_private *id_priv,
 	}
 
 out:
-	if (!ret)
+	if (!ret) {
 		cma_attach_to_dev(id_priv, cma_dev);
+		rdma_restrack_add(&id_priv->res);
+	}
 
 	mutex_unlock(&lock);
 	return ret;
@@ -807,6 +809,7 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 
 found:
 	cma_attach_to_dev(id_priv, cma_dev);
+	rdma_restrack_add(&id_priv->res);
 	mutex_unlock(&lock);
 	addr = (struct sockaddr_ib *)cma_src_addr(id_priv);
 	memcpy(&addr->sib_addr, &sgid, sizeof(sgid));
@@ -2526,6 +2529,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	       rdma_addr_size(cma_src_addr(id_priv)));
 
 	_cma_attach_to_dev(dev_id_priv, cma_dev);
+	rdma_restrack_add(&dev_id_priv->res);
 	cma_id_get(id_priv);
 	dev_id_priv->internal_id = 1;
 	dev_id_priv->afonly = id_priv->afonly;
@@ -3203,6 +3207,7 @@ static int cma_bind_loopback(struct rdma_id_private *id_priv)
 	ib_addr_set_pkey(&id_priv->id.route.addr.dev_addr, pkey);
 	id_priv->id.port_num = p;
 	cma_attach_to_dev(id_priv, cma_dev);
+	rdma_restrack_add(&id_priv->res);
 	cma_set_loopback(cma_src_addr(id_priv));
 out:
 	mutex_unlock(&lock);
@@ -3235,6 +3240,7 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 		if (status)
 			pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to acquire device. status %d\n",
 					     status);
+		rdma_restrack_add(&id_priv->res);
 	} else if (status) {
 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to resolve IP. status %d\n", status);
 	}
@@ -3846,6 +3852,8 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 	if (ret)
 		goto err2;
 
+	if (!cma_any_addr(addr))
+		rdma_restrack_add(&id_priv->res);
 	return 0;
 err2:
 	if (id_priv->cma_dev)
-- 
2.30.2

