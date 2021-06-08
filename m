Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB03E39EE11
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 07:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFHFZy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 01:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhFHFZx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 01:25:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 825CB6023E;
        Tue,  8 Jun 2021 05:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623129841;
        bh=vmPy9qQ76N9fa08r7q9z1d4jWLhEmNm4iqen1DXlowg=;
        h=From:To:Cc:Subject:Date:From;
        b=cmwoTKffEgSK2C9dzNjDeM7Qj4xHb+SeXl0Rh4/5L/2+i17W07bu9wzBcYRDKnIkl
         ZlNt5Row3y3b960fFQj2mLZfKhKDkwesu0tOwSAck1uTA8c7q/6+yEW9CVnYeMPQGY
         pBawojXRDgPS+Iv3PuwxAF+ONP/OTZdMcnWarFb6vyl9ESoMuY5xA6A13pnwn3IRaY
         rU00Xy4DLgCXLaXtsHh6++qodTK7AL2lRRtweLYkmp3FY6VFl1exaZ7/DybP7xFoWx
         X/c31JXzZo52gcXaJm32rzjBn9FeSVakP23P6Vllimy44Z8ADvIbVsWhLqsntKcYiZ
         F2ABVd+oBhl7g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc v2] RDMA/core: Simplify addition of restrack object
Date:   Tue,  8 Jun 2021 08:23:48 +0300
Message-Id: <e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Change location of rdma_restrack_add() callers to be near attachment
to device logic. Such improvement fixes the bug where task_struct was
acquired but not released, causing to resource leak.

  ucma_create_id() {
    ucma_alloc_ctx();
    rdma_create_user_id() {
      rdma_restrack_new();
      rdma_restrack_set_name() {
        rdma_restrack_attach_task.part.0(); <--- task_struct was gotten
      }
    }
    ucma_destroy_private_ctx() {
      ucma_put_ctx();
      rdma_destroy_id() {
        _destroy_id()                       <--- id_priv was freed
      }
    }
  }

Fixes: cb5cd0ea4eb3 ("RDMA/core: Add CM to restrack after successful attachment to a device")
Reported-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog
v2:
 * Added bug report analysis
v1: https://lore.kernel.org/linux-rdma/f72e27d5c82cd9beec7670141afa62786836c569.1622956637.git.leonro@nvidia.com/T/#u
---
 drivers/infiniband/core/cma.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index ab148a696c0c..e6b81cd4775a 100644
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
@@ -1852,6 +1849,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 {
 	cma_cancel_operation(id_priv, state);
 
+	rdma_restrack_del(&id_priv->res);
 	if (id_priv->cma_dev) {
 		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
 			if (id_priv->cm_id.ib)
@@ -1861,7 +1859,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 				iw_destroy_cm_id(id_priv->cm_id.iw);
 		}
 		cma_leave_mc_groups(id_priv);
-		rdma_restrack_del(&id_priv->res);
 		cma_release_dev(id_priv);
 	}
 
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

