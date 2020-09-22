Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066D4273E36
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 11:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIVJL0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 05:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgIVJL0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 05:11:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8094020715;
        Tue, 22 Sep 2020 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600765886;
        bh=kyP33Z5JvCyQyC/hAIUmFk2LzIBLIaINSaGUvb7BQ/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PxVoVhPm+Xf7RmLWzpm7zKazlhimjcSYMTHtdBOVU8lHWOSgmsI/RDHoMivf7Cl4k
         xI5xF/4G6s+tO2Zq6hCHJjtXp7JBMti3+fQYxBDb2Rt2LRYemxfwoTTMx2vqMqIvXx
         hdhI5iDmxVNSC2M50tIwMpNohexhxwGe/bcWuR6w=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 1/5] RDMA/cma: Delete from restrack DB after successful destroy
Date:   Tue, 22 Sep 2020 12:11:02 +0300
Message-Id: <20200922091106.2152715-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922091106.2152715-1-leon@kernel.org>
References: <20200922091106.2152715-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Update the code to have similar destroy pattern like other IB objects.

This change create asymmetry to the rdma_id_private create flow to make
sure that memory is managed by restrack.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 22bd892c4aa8..22f0b7ccdd6c 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1804,7 +1804,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 {
 	cma_cancel_operation(id_priv, state);
 
-	rdma_restrack_del(&id_priv->res);
 	if (id_priv->cma_dev) {
 		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
 			if (id_priv->cm_id.ib)
@@ -1830,6 +1829,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
 
 	put_net(id_priv->id.route.addr.dev_addr.net);
+	rdma_restrack_del(&id_priv->res);
 	kfree(id_priv);
 }
 
@@ -3721,7 +3721,6 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 
 	return 0;
 err2:
-	rdma_restrack_del(&id_priv->res);
 	if (id_priv->cma_dev)
 		cma_release_dev(id_priv);
 err1:
-- 
2.26.2

