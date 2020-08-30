Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195F8256D43
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Aug 2020 12:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgH3KOv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Aug 2020 06:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgH3KOq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Aug 2020 06:14:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E64FF207DA;
        Sun, 30 Aug 2020 10:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598782485;
        bh=YlS5oONg7VJySL6XACMHJkvvxr+bdpQDzuKPjsg0HdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jabs3DZ6ZAeXrjDBxGVvhYHmEFnAeqRqr3Q48d2vPLRshBQI9hGNwa5Bndy8aQiLQ
         YYTwTZ+6NC/zCogaZsJN5Fvc0spM3pZsraPMGosrct5T0ly+MGwEoxlUWraxL8mkDo
         6lVfdyb8tfkz3987t2MZbncRWGfFphgtzcZb77pI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 01/13] RDMA/cma: Delete from restrack DB after successful destroy
Date:   Sun, 30 Aug 2020 13:14:24 +0300
Message-Id: <20200830101436.108487-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200830101436.108487-1-leon@kernel.org>
References: <20200830101436.108487-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Update the code to have similar destroy pattern like other IB objects.

This change create asymmetry to the rdma_id_private create flow to make
sure that memory is managed by restrack.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c      | 3 +--
 drivers/infiniband/core/restrack.c | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 78641858abe2..5d6b70ae7a57 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1821,7 +1821,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 {
 	cma_cancel_operation(id_priv, state);
 
-	rdma_restrack_del(&id_priv->res);
 	if (id_priv->cma_dev) {
 		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
 			if (id_priv->cm_id.ib)
@@ -1847,6 +1846,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
 
 	put_net(id_priv->id.route.addr.dev_addr.net);
+	rdma_restrack_del(&id_priv->res);
 	kfree(id_priv);
 }
 
@@ -3728,7 +3728,6 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 
 	return 0;
 err2:
-	rdma_restrack_del(&id_priv->res);
 	if (id_priv->cma_dev)
 		cma_release_dev(id_priv);
 err1:
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 62fbb0ae9cb4..90fc74106620 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -330,6 +330,9 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	rt = &dev->res[res->type];
 
 	old = xa_erase(&rt->xa, res->id);
+	if (!old &&
+	    (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP))
+		return;
 	WARN_ON(old != res);
 	res->valid = false;
 
-- 
2.26.2

