Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065EE492062
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 08:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbiARHfT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 02:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbiARHfR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 02:35:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1E9C061574;
        Mon, 17 Jan 2022 23:35:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AF80CCE180A;
        Tue, 18 Jan 2022 07:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC0BC00446;
        Tue, 18 Jan 2022 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642491314;
        bh=QkC4jBGXfBwcQPRW5tf8X1NQ4ngdZpaUsK0z/L5pb18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7NjkWi/rNX9FeUQlQT1LZmoS5Ij8opuNrgdzBGx9IVe7u/B2iYoNcAicYSJaHCW2
         FjcRs4GTm2b5h3Gb4bCBcbpPZxJkt0NpAx11ISKHiVavQKACEsmVHhsPHnesTWxtOM
         cBc+Sl4tFgu5m/decYCvPvLU+pOMFZJjPDuYq66ugE50iViEy6HI/T483kICYjWjS4
         /Ee1W5c+WBFkUw61T5T84BxEkroVyVwG2FwyLKRuWDqK+lE0RMS+cKAwHp1ddSscVo
         +Z9qJZIn+YMLNfl6WtnHs64YcsjxT3yGBF5lvLvIYk3J6SVhln3pj8bSQGLRdVdjM9
         ENjB5uWAhcJPg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/3] RDMA/cma: Use correct address when leaving multicast group
Date:   Tue, 18 Jan 2022 09:35:00 +0200
Message-Id: <913bc6783fd7a95fe71ad9454e01653ee6fb4a9a.1642491047.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642491047.git.leonro@nvidia.com>
References: <cover.1642491047.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

In RoCE we should use cma_iboe_set_mgid and not cma_set_mgid to generate
the mgid, otherwise we will try to remove incorrect address.

Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 61 +++++++++++++++++------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 27a00ce2e101..69c9a12dd14e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1830,6 +1830,31 @@ static void cma_release_port(struct rdma_id_private *id_priv)
 	mutex_unlock(&lock);
 }
 
+static void cma_iboe_set_mgid(struct sockaddr *addr, union ib_gid *mgid,
+			      enum ib_gid_type gid_type)
+{
+	struct sockaddr_in *sin = (struct sockaddr_in *)addr;
+	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)addr;
+
+	if (!cma_any_addr(addr) && addr->sa_family == AF_INET6) {
+		memcpy(mgid, &sin6->sin6_addr, sizeof(*mgid));
+		return;
+	}
+
+	memset(mgid, 0, sizeof(*mgid));
+	if (cma_any_addr(addr))
+		return;
+
+	/* AF_INET4 */
+	if (gid_type != IB_GID_TYPE_ROCE_UDP_ENCAP) {
+		mgid->raw[0] = 0xff;
+		mgid->raw[1] = 0x0e;
+	}
+	mgid->raw[10] = 0xff;
+	mgid->raw[11] = 0xff;
+	*(__be32 *)(&mgid->raw[12]) = sin->sin_addr.s_addr;
+}
+
 static void destroy_mc(struct rdma_id_private *id_priv,
 		       struct cma_multicast *mc)
 {
@@ -1847,10 +1872,13 @@ static void destroy_mc(struct rdma_id_private *id_priv,
 			ndev = dev_get_by_index(dev_addr->net,
 						dev_addr->bound_dev_if);
 		if (ndev) {
+			enum ib_gid_type gid_type;
 			union ib_gid mgid;
 
-			cma_set_mgid(id_priv, (struct sockaddr *)&mc->addr,
-				     &mgid);
+			gid_type = cma_get_default_gid_type(
+				id_priv->cma_dev, id_priv->id.port_num);
+			cma_iboe_set_mgid((struct sockaddr *)&mc->addr, &mgid,
+					  gid_type);
 
 			if (!send_only)
 				cma_igmp_send(ndev, &mgid, false);
@@ -4702,35 +4730,6 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
 	return PTR_ERR_OR_ZERO(mc->sa_mc);
 }
 
-static void cma_iboe_set_mgid(struct sockaddr *addr, union ib_gid *mgid,
-			      enum ib_gid_type gid_type)
-{
-	struct sockaddr_in *sin = (struct sockaddr_in *)addr;
-	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)addr;
-
-	if (cma_any_addr(addr)) {
-		memset(mgid, 0, sizeof *mgid);
-	} else if (addr->sa_family == AF_INET6) {
-		memcpy(mgid, &sin6->sin6_addr, sizeof *mgid);
-	} else {
-		mgid->raw[0] =
-			(gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) ? 0 : 0xff;
-		mgid->raw[1] =
-			(gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) ? 0 : 0x0e;
-		mgid->raw[2] = 0;
-		mgid->raw[3] = 0;
-		mgid->raw[4] = 0;
-		mgid->raw[5] = 0;
-		mgid->raw[6] = 0;
-		mgid->raw[7] = 0;
-		mgid->raw[8] = 0;
-		mgid->raw[9] = 0;
-		mgid->raw[10] = 0xff;
-		mgid->raw[11] = 0xff;
-		*(__be32 *)(&mgid->raw[12]) = sin->sin_addr.s_addr;
-	}
-}
-
 static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 				   struct cma_multicast *mc)
 {
-- 
2.34.1

