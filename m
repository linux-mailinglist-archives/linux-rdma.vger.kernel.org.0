Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86756379F4F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 07:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEKFtw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 01:49:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKFtv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 01:49:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80DCF61924;
        Tue, 11 May 2021 05:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620712126;
        bh=tKbXSst6ZqfsFnEkcvQIzLrwZXwZ9OxW61g4Q2jGVYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUouTdmEhn9f50Ix+ocs7u7Zwrcnc3dxMvWEza9PnKDgsiH92lfKWERL7KgKJEITt
         8edzcsL1RBTqC8yJ20y765YvU8bikk1vsXqJMZ88a7A/3dZBg5AR5TmoyugUaJaTUh
         1MPsBz4DYQ6scIE5yduigajPA4ME50/TiQAND6dFz48bRONf7eYhniw1OWf2AQYVsQ
         kyvWT2IG0w7YU4ziyNoSfkGAbVw9CgyQEWObHn4X9SEzWad+wzkIxfYf/akFTdF+tA
         rjxtxdxTtbvB9cxxpq7BvYQgn+Tqkq5LWjmI7Rgiv2gyGiHuc0Ji3svyT7uPbRX5fN
         bkN2LtJgUP1VQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-rc 4/5] RDMA/core: Simplify addition of restrack object
Date:   Tue, 11 May 2021 08:48:30 +0300
Message-Id: <36cde3a62adc5d6aeb895456574c988cff7e42ac.1620711734.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620711734.git.leonro@nvidia.com>
References: <cover.1620711734.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Change location of rdma_restrack_add() callers to be near attachment
to device logic.

Fixes: cb5cd0ea4eb3 ("RDMA/core: Add CM to restrack after successful attachment to a device")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index ab148a696c0c..bdc645f9c692 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -462,6 +462,7 @@ static void cma_attach_to_dev(struct rdma_id_private *id_priv,
 			      struct cma_device *cma_dev)
 {
 	_cma_attach_to_dev(id_priv, cma_dev);
+	rdma_restrack_add(&id_priv->res);
 	id_priv->gid_type =
 		cma_dev->default_gid_type[id_priv->id.port_num -
 					  rdma_start_port(cma_dev->device)];
@@ -691,7 +692,6 @@ static int cma_ib_acquire_dev(struct rdma_id_private *id_priv,
 	mutex_lock(&lock);
 	cma_attach_to_dev(id_priv, listen_id_priv->cma_dev);
 	mutex_unlock(&lock);
-	rdma_restrack_add(&id_priv->res);
 	return 0;
 }
 
@@ -746,10 +746,8 @@ static int cma_iw_acquire_dev(struct rdma_id_private *id_priv,
 	}
 
 out:
-	if (!ret) {
+	if (!ret)
 		cma_attach_to_dev(id_priv, cma_dev);
-		rdma_restrack_add(&id_priv->res);
-	}
 
 	mutex_unlock(&lock);
 	return ret;
@@ -810,7 +808,6 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 
 found:
 	cma_attach_to_dev(id_priv, cma_dev);
-	rdma_restrack_add(&id_priv->res);
 	mutex_unlock(&lock);
 	addr = (struct sockaddr_ib *)cma_src_addr(id_priv);
 	memcpy(&addr->sib_addr, &sgid, sizeof(sgid));
@@ -3208,7 +3205,6 @@ static int cma_bind_loopback(struct rdma_id_private *id_priv)
 	ib_addr_set_pkey(&id_priv->id.route.addr.dev_addr, pkey);
 	id_priv->id.port_num = p;
 	cma_attach_to_dev(id_priv, cma_dev);
-	rdma_restrack_add(&id_priv->res);
 	cma_set_loopback(cma_src_addr(id_priv));
 out:
 	mutex_unlock(&lock);
@@ -3241,7 +3237,6 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 		if (status)
 			pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to acquire device. status %d\n",
 					     status);
-		rdma_restrack_add(&id_priv->res);
 	} else if (status) {
 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to resolve IP. status %d\n", status);
 	}
@@ -3853,12 +3848,12 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 	if (ret)
 		goto err2;
 
-	if (!cma_any_addr(addr))
-		rdma_restrack_add(&id_priv->res);
 	return 0;
 err2:
 	if (id_priv->cma_dev)
 		cma_release_dev(id_priv);
+	if (!cma_any_addr(addr))
+		rdma_restrack_del(&id_priv->res);
 err1:
 	cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_IDLE);
 	return ret;
-- 
2.31.1

