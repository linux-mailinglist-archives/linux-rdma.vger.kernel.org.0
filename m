Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6479A25A770
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgIBILh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIBILf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:11:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DB820826;
        Wed,  2 Sep 2020 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034294;
        bh=pu7BqtrRV3xB3IGB0NLz9sjE0SzpYaVLQiInsAAskDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLLSDaX4Eyx2qN5KuxWyWSVkPYtoRSzQGXOs+KT17Upbk0Qs1tMOj4FG0Nw8nC9+O
         gVESGXRQ1LeXgc8YUjiXsqIIZu32Ljc6JXioQbNbqkV45HzcaBLeW1fNtFcBPcpYvn
         WqaQkgSKpFKT7FeOzdzrafCgVYtvjHb+Sap6nKhw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/8] RDMA/cma: Make the locking for automatic state transition more clear
Date:   Wed,  2 Sep 2020 11:11:16 +0300
Message-Id: <20200902081122.745412-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902081122.745412-1-leon@kernel.org>
References: <20200902081122.745412-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Re-organize things so the state variable is not read unlocked. The first
attempt to go directly from ADDR_BOUND immediately tells us if the ID is
already bound, if we can't do that then the attempt inside
rdma_bind_addr() to go from IDLE to ADDR_BOUND confirms the ID needs
binding.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 67 +++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 7ac9306ab5b3..901d1bd35603 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3278,32 +3278,54 @@ static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
 	return rdma_bind_addr(id, src_addr);
 }
 
-int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
-		      const struct sockaddr *dst_addr, unsigned long timeout_ms)
+/*
+ * If required, resolve the source address for bind and leave the id_priv in
+ * state RDMA_CM_ADDR_BOUND. This oddly uses the state to determine the prior
+ * calls made by ULP, a previously bound ID will not be re-bound and src_addr is
+ * ignored.
+ */
+static int resolve_prepare_src(struct rdma_id_private *id_priv,
+			       struct sockaddr *src_addr,
+			       const struct sockaddr *dst_addr)
 {
-	struct rdma_id_private *id_priv;
 	int ret;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
 	memcpy(cma_dst_addr(id_priv), dst_addr, rdma_addr_size(dst_addr));
-	if (id_priv->state == RDMA_CM_IDLE) {
-		ret = cma_bind_addr(id, src_addr, dst_addr);
-		if (ret) {
-			memset(cma_dst_addr(id_priv), 0,
-			       rdma_addr_size(dst_addr));
-			return ret;
+	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
+		/* For a well behaved ULP state will be RDMA_CM_IDLE */
+		ret = cma_bind_addr(&id_priv->id, src_addr, dst_addr);
+		if (ret)
+			goto err_dst;
+		if (WARN_ON(!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND,
+					   RDMA_CM_ADDR_QUERY))) {
+			ret = -EINVAL;
+			goto err_dst;
 		}
 	}
 
 	if (cma_family(id_priv) != dst_addr->sa_family) {
-		memset(cma_dst_addr(id_priv), 0, rdma_addr_size(dst_addr));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_state;
 	}
+	return 0;
 
-	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
-		memset(cma_dst_addr(id_priv), 0, rdma_addr_size(dst_addr));
-		return -EINVAL;
-	}
+err_state:
+	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
+err_dst:
+	memset(cma_dst_addr(id_priv), 0, rdma_addr_size(dst_addr));
+	return ret;
+}
+
+int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
+		      const struct sockaddr *dst_addr, unsigned long timeout_ms)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+	int ret;
+
+	ret = resolve_prepare_src(id_priv, src_addr, dst_addr);
+	if (ret)
+		return ret;
 
 	if (cma_any_addr(dst_addr)) {
 		ret = cma_resolve_loopback(id_priv);
@@ -3676,20 +3698,21 @@ static int cma_check_linklocal(struct rdma_dev_addr *dev_addr,
 
 int rdma_listen(struct rdma_cm_id *id, int backlog)
 {
-	struct rdma_id_private *id_priv;
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
 	int ret;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
-	if (id_priv->state == RDMA_CM_IDLE) {
+	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_LISTEN)) {
+		/* For a well behaved ULP state will be RDMA_CM_IDLE */
 		id->route.addr.src_addr.ss_family = AF_INET;
 		ret = rdma_bind_addr(id, cma_src_addr(id_priv));
 		if (ret)
 			return ret;
+		if (WARN_ON(!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND,
+					   RDMA_CM_LISTEN)))
+			return -EINVAL;
 	}
 
-	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_LISTEN))
-		return -EINVAL;
-
 	if (id_priv->reuseaddr) {
 		ret = cma_bind_listen(id_priv);
 		if (ret)
-- 
2.26.2

