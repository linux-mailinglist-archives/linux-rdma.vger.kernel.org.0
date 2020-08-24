Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F35524FBC3
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgHXKo2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgHXKoZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:44:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A65DA206B5;
        Mon, 24 Aug 2020 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265864;
        bh=SIgjiKJyRKs9Mt0J85LNwRcpqauOM8dwuuDZY9aLfvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCImpFCepOj+ThhXIrGDcQj1gav7w+OKakJuuMt/7FKGcbdtACI9yQLrENsgiG4B2
         9FvKZPnsL9CDN+viYzghckG2ASPrtKEUn/k3YY20WRXH3So5YgSDc0zWEm9VFGE5k1
         /EYJL6hHwtIVZdZ93QkjC7LKeDiejfLPR0b2xzWY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 02/14] RDMA/cma: Delete from restrack DB after successful destroy
Date:   Mon, 24 Aug 2020 13:44:03 +0300
Message-Id: <20200824104415.1090901-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824104415.1090901-1-leon@kernel.org>
References: <20200824104415.1090901-1-leon@kernel.org>
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
 drivers/infiniband/core/cma.c      | 2 +-
 drivers/infiniband/core/restrack.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 78641858abe2..882669a014b2 100644
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

