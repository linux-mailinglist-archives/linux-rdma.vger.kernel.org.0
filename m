Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DA525FA93
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgIGMew (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 08:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbgIGMWQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 08:22:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2177C2166E;
        Mon,  7 Sep 2020 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599481335;
        bh=eqKtiql4QqSpZgJjNUxy/wuR8Hak72HepxadOKqnbZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROdnujXR2iAyWpoNkwhoV1zukxh2ibwcuGkS2mzFMz9Xscvp0ik67UxqzYdQdwehH
         60o/sA3cokFXKNIxQ0Ma70et28lwMmCYfr5vtbJlABdccWeB4+UECpstKJO9lxFbEu
         gQYqo8DNFXdJ+W5cbYJoONmMbhhlnCH5f1ij0/ak=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 01/14] RDMA/cma: Delete from restrack DB after successful destroy
Date:   Mon,  7 Sep 2020 15:21:43 +0300
Message-Id: <20200907122156.478360-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907122156.478360-1-leon@kernel.org>
References: <20200907122156.478360-1-leon@kernel.org>
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
 drivers/infiniband/core/cma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index f9ff8b7f05e7..24e09416de4f 100644
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
 
@@ -3729,7 +3729,6 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 
 	return 0;
 err2:
-	rdma_restrack_del(&id_priv->res);
 	if (id_priv->cma_dev)
 		cma_release_dev(id_priv);
 err1:
-- 
2.26.2

