Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDDB15A1F2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 08:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgBLH1P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 02:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgBLH1P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 02:27:15 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D539206DB;
        Wed, 12 Feb 2020 07:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581492431;
        bh=jnA8DwKRvQltC9PCtDAoFuHXa95rTqwxdV+8HpdkUvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x57VwTOKYDJ5RVTLD5103IsSGKFFjkghT14AABNb+q/JLWHSWoojXtjjbyzqvtkIR
         Iz/PYPbiFu24ZOoGCT/yY5lNwzgMmzwuqHQsS72ukFbEnTxKqBwc96ax0qWrvrm50a
         hl7NVJCPEB7n9fVqy0IBTnqCVYYEpIBXQPeC3148=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: [PATCH rdma-rc 3/9] Revert "RDMA/cma: Simplify rdma_resolve_addr() error flow"
Date:   Wed, 12 Feb 2020 09:26:29 +0200
Message-Id: <20200212072635.682689-4-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212072635.682689-1-leon@kernel.org>
References: <20200212072635.682689-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

This reverts commit 219d2e9dfda9431b808c28d5efc74b404b95b638.

Below flow requires cm_id_priv's destination address to be setup
before performing rdma_bind_addr().
Without which, source port allocation for existing bind list fails
when port range is small, resulting into rdma_resolve_addr()
failure.

rdma_resolve_addr()
  cma_bind_addr()
    rdma_bind_addr()
      cma_get_port()
        cma_alloc_any_port()
          cma_port_is_unique() <- compared with zero daddr

Fixes: 219d2e9dfda9 ("RDMA/cma: Simplify rdma_resolve_addr() error flow")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 72f032160c4b..2dec3a02ab9f 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3212,19 +3212,26 @@ int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
 	int ret;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
+	memcpy(cma_dst_addr(id_priv), dst_addr, rdma_addr_size(dst_addr));
 	if (id_priv->state == RDMA_CM_IDLE) {
 		ret = cma_bind_addr(id, src_addr, dst_addr);
-		if (ret)
+		if (ret) {
+			memset(cma_dst_addr(id_priv), 0,
+			       rdma_addr_size(dst_addr));
 			return ret;
+		}
 	}
 
-	if (cma_family(id_priv) != dst_addr->sa_family)
+	if (cma_family(id_priv) != dst_addr->sa_family) {
+		memset(cma_dst_addr(id_priv), 0, rdma_addr_size(dst_addr));
 		return -EINVAL;
+	}
 
-	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY))
+	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
+		memset(cma_dst_addr(id_priv), 0, rdma_addr_size(dst_addr));
 		return -EINVAL;
+	}
 
-	memcpy(cma_dst_addr(id_priv), dst_addr, rdma_addr_size(dst_addr));
 	if (cma_any_addr(dst_addr)) {
 		ret = cma_resolve_loopback(id_priv);
 	} else {
-- 
2.24.1

