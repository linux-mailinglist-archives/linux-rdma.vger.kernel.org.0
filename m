Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D565CDF6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 09:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjADIBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 03:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjADIBs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 03:01:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF37AD60
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 00:01:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83BA1B81339
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 08:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993BFC433EF;
        Wed,  4 Jan 2023 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672819304;
        bh=73ISZgeRgj2mTmFEKm2zA2qhh54iG8q/R/52Ttf/F9k=;
        h=From:To:Cc:Subject:Date:From;
        b=KPK5zG4LY5O6CdoK2KpeMU2eCqZJX+RgnW6uwxNl+oRoxq7bu7zUpek6q5LBCvMPK
         xvSeIJ0uHjZhhYi4rUki6G9Q7Yu2qH/pg6YUxYn65NVyyJLua3OK3UQkyCiGO+qmds
         IO9vBiGtnnaYAOslZ45tPDq6+oB22QC/5GXPe7srrFryPcoRj41MIYaUTnTZ4HBpKF
         YIYrrHvhpUnN97do7AlaqvDdTyt+FMg/miMrHz46VXwWlefiG8geKH0p8qSTaPXZxU
         UdrrzCM3yMLYyC1OQj3cw9u6Amus5pUYAteck7Aa4qn+autlnyTheMYa1bHPjfWP/a
         01rLSYIdZJesg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH rdma-next] RDMA/core: Refactor rdma_bind_addr
Date:   Wed,  4 Jan 2023 10:01:38 +0200
Message-Id: <3d0e9a2fd62bc10ba02fed1c7c48a48638952320.1672819273.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Refactor rdma_bind_addr function so that it doesn't require that the
cma destination address be changed before calling it.

So now it will update the destination address internally only when it is
really needed and after passing all the required checks.

Which in turn results in a cleaner and more sensible call and error
handling flows for the functions that call it directly or indirectly.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reported-by: Wei Chen <harperchen1110@gmail.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 253 +++++++++++++++++-----------------
 1 file changed, 130 insertions(+), 123 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 68721ff10255..b9da636fe1fb 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3541,121 +3541,6 @@ static int cma_resolve_ib_addr(struct rdma_id_private *id_priv)
 	return ret;
 }
 
-static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
-			 const struct sockaddr *dst_addr)
-{
-	struct sockaddr_storage zero_sock = {};
-
-	if (src_addr && src_addr->sa_family)
-		return rdma_bind_addr(id, src_addr);
-
-	/*
-	 * When the src_addr is not specified, automatically supply an any addr
-	 */
-	zero_sock.ss_family = dst_addr->sa_family;
-	if (IS_ENABLED(CONFIG_IPV6) && dst_addr->sa_family == AF_INET6) {
-		struct sockaddr_in6 *src_addr6 =
-			(struct sockaddr_in6 *)&zero_sock;
-		struct sockaddr_in6 *dst_addr6 =
-			(struct sockaddr_in6 *)dst_addr;
-
-		src_addr6->sin6_scope_id = dst_addr6->sin6_scope_id;
-		if (ipv6_addr_type(&dst_addr6->sin6_addr) & IPV6_ADDR_LINKLOCAL)
-			id->route.addr.dev_addr.bound_dev_if =
-				dst_addr6->sin6_scope_id;
-	} else if (dst_addr->sa_family == AF_IB) {
-		((struct sockaddr_ib *)&zero_sock)->sib_pkey =
-			((struct sockaddr_ib *)dst_addr)->sib_pkey;
-	}
-	return rdma_bind_addr(id, (struct sockaddr *)&zero_sock);
-}
-
-/*
- * If required, resolve the source address for bind and leave the id_priv in
- * state RDMA_CM_ADDR_BOUND. This oddly uses the state to determine the prior
- * calls made by ULP, a previously bound ID will not be re-bound and src_addr is
- * ignored.
- */
-static int resolve_prepare_src(struct rdma_id_private *id_priv,
-			       struct sockaddr *src_addr,
-			       const struct sockaddr *dst_addr)
-{
-	int ret;
-
-	memcpy(cma_dst_addr(id_priv), dst_addr, rdma_addr_size(dst_addr));
-	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
-		/* For a well behaved ULP state will be RDMA_CM_IDLE */
-		ret = cma_bind_addr(&id_priv->id, src_addr, dst_addr);
-		if (ret)
-			goto err_dst;
-		if (WARN_ON(!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND,
-					   RDMA_CM_ADDR_QUERY))) {
-			ret = -EINVAL;
-			goto err_dst;
-		}
-	}
-
-	if (cma_family(id_priv) != dst_addr->sa_family) {
-		ret = -EINVAL;
-		goto err_state;
-	}
-	return 0;
-
-err_state:
-	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
-err_dst:
-	memset(cma_dst_addr(id_priv), 0, rdma_addr_size(dst_addr));
-	return ret;
-}
-
-int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
-		      const struct sockaddr *dst_addr, unsigned long timeout_ms)
-{
-	struct rdma_id_private *id_priv =
-		container_of(id, struct rdma_id_private, id);
-	int ret;
-
-	ret = resolve_prepare_src(id_priv, src_addr, dst_addr);
-	if (ret)
-		return ret;
-
-	if (cma_any_addr(dst_addr)) {
-		ret = cma_resolve_loopback(id_priv);
-	} else {
-		if (dst_addr->sa_family == AF_IB) {
-			ret = cma_resolve_ib_addr(id_priv);
-		} else {
-			/*
-			 * The FSM can return back to RDMA_CM_ADDR_BOUND after
-			 * rdma_resolve_ip() is called, eg through the error
-			 * path in addr_handler(). If this happens the existing
-			 * request must be canceled before issuing a new one.
-			 * Since canceling a request is a bit slow and this
-			 * oddball path is rare, keep track once a request has
-			 * been issued. The track turns out to be a permanent
-			 * state since this is the only cancel as it is
-			 * immediately before rdma_resolve_ip().
-			 */
-			if (id_priv->used_resolve_ip)
-				rdma_addr_cancel(&id->route.addr.dev_addr);
-			else
-				id_priv->used_resolve_ip = 1;
-			ret = rdma_resolve_ip(cma_src_addr(id_priv), dst_addr,
-					      &id->route.addr.dev_addr,
-					      timeout_ms, addr_handler,
-					      false, id_priv);
-		}
-	}
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
-	return ret;
-}
-EXPORT_SYMBOL(rdma_resolve_addr);
-
 int rdma_set_reuseaddr(struct rdma_cm_id *id, int reuse)
 {
 	struct rdma_id_private *id_priv;
@@ -4058,27 +3943,26 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 }
 EXPORT_SYMBOL(rdma_listen);
 
-int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
+static int rdma_bind_addr_dst(struct rdma_id_private *id_priv,
+			      struct sockaddr *addr, const struct sockaddr *daddr)
 {
-	struct rdma_id_private *id_priv;
+	struct sockaddr *id_daddr;
 	int ret;
-	struct sockaddr  *daddr;
 
 	if (addr->sa_family != AF_INET && addr->sa_family != AF_INET6 &&
 	    addr->sa_family != AF_IB)
 		return -EAFNOSUPPORT;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
 	if (!cma_comp_exch(id_priv, RDMA_CM_IDLE, RDMA_CM_ADDR_BOUND))
 		return -EINVAL;
 
-	ret = cma_check_linklocal(&id->route.addr.dev_addr, addr);
+	ret = cma_check_linklocal(&id_priv->id.route.addr.dev_addr, addr);
 	if (ret)
 		goto err1;
 
 	memcpy(cma_src_addr(id_priv), addr, rdma_addr_size(addr));
 	if (!cma_any_addr(addr)) {
-		ret = cma_translate_addr(addr, &id->route.addr.dev_addr);
+		ret = cma_translate_addr(addr, &id_priv->id.route.addr.dev_addr);
 		if (ret)
 			goto err1;
 
@@ -4098,8 +3982,10 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 		}
 #endif
 	}
-	daddr = cma_dst_addr(id_priv);
-	daddr->sa_family = addr->sa_family;
+	id_daddr = cma_dst_addr(id_priv);
+	if (daddr != id_daddr)
+		memcpy(id_daddr, daddr, rdma_addr_size(addr));
+	id_daddr->sa_family = addr->sa_family;
 
 	ret = cma_get_port(id_priv);
 	if (ret)
@@ -4115,6 +4001,127 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 	cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_IDLE);
 	return ret;
 }
+
+static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
+			 const struct sockaddr *dst_addr)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+	struct sockaddr_storage zero_sock = {};
+
+	if (src_addr && src_addr->sa_family)
+		return rdma_bind_addr_dst(id_priv, src_addr, dst_addr);
+
+	/*
+	 * When the src_addr is not specified, automatically supply an any addr
+	 */
+	zero_sock.ss_family = dst_addr->sa_family;
+	if (IS_ENABLED(CONFIG_IPV6) && dst_addr->sa_family == AF_INET6) {
+		struct sockaddr_in6 *src_addr6 =
+			(struct sockaddr_in6 *)&zero_sock;
+		struct sockaddr_in6 *dst_addr6 =
+			(struct sockaddr_in6 *)dst_addr;
+
+		src_addr6->sin6_scope_id = dst_addr6->sin6_scope_id;
+		if (ipv6_addr_type(&dst_addr6->sin6_addr) & IPV6_ADDR_LINKLOCAL)
+			id->route.addr.dev_addr.bound_dev_if =
+				dst_addr6->sin6_scope_id;
+	} else if (dst_addr->sa_family == AF_IB) {
+		((struct sockaddr_ib *)&zero_sock)->sib_pkey =
+			((struct sockaddr_ib *)dst_addr)->sib_pkey;
+	}
+	return rdma_bind_addr_dst(id_priv, (struct sockaddr *)&zero_sock, dst_addr);
+}
+
+/*
+ * If required, resolve the source address for bind and leave the id_priv in
+ * state RDMA_CM_ADDR_BOUND. This oddly uses the state to determine the prior
+ * calls made by ULP, a previously bound ID will not be re-bound and src_addr is
+ * ignored.
+ */
+static int resolve_prepare_src(struct rdma_id_private *id_priv,
+			       struct sockaddr *src_addr,
+			       const struct sockaddr *dst_addr)
+{
+	int ret;
+
+	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
+		/* For a well behaved ULP state will be RDMA_CM_IDLE */
+		ret = cma_bind_addr(&id_priv->id, src_addr, dst_addr);
+		if (ret)
+			return ret;
+		if (WARN_ON(!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND,
+					   RDMA_CM_ADDR_QUERY)))
+			return -EINVAL;
+
+	}
+
+	if (cma_family(id_priv) != dst_addr->sa_family) {
+		ret = -EINVAL;
+		goto err_state;
+	}
+	return 0;
+
+err_state:
+	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
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
+
+	if (cma_any_addr(dst_addr)) {
+		ret = cma_resolve_loopback(id_priv);
+	} else {
+		if (dst_addr->sa_family == AF_IB) {
+			ret = cma_resolve_ib_addr(id_priv);
+		} else {
+			/*
+			 * The FSM can return back to RDMA_CM_ADDR_BOUND after
+			 * rdma_resolve_ip() is called, eg through the error
+			 * path in addr_handler(). If this happens the existing
+			 * request must be canceled before issuing a new one.
+			 * Since canceling a request is a bit slow and this
+			 * oddball path is rare, keep track once a request has
+			 * been issued. The track turns out to be a permanent
+			 * state since this is the only cancel as it is
+			 * immediately before rdma_resolve_ip().
+			 */
+			if (id_priv->used_resolve_ip)
+				rdma_addr_cancel(&id->route.addr.dev_addr);
+			else
+				id_priv->used_resolve_ip = 1;
+			ret = rdma_resolve_ip(cma_src_addr(id_priv), dst_addr,
+					      &id->route.addr.dev_addr,
+					      timeout_ms, addr_handler,
+					      false, id_priv);
+		}
+	}
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_resolve_addr);
+
+int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+
+	return rdma_bind_addr_dst(id_priv, addr, cma_dst_addr(id_priv));
+}
 EXPORT_SYMBOL(rdma_bind_addr);
 
 static int cma_format_hdr(void *hdr, struct rdma_id_private *id_priv)
-- 
2.38.1

