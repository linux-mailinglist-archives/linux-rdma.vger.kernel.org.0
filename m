Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F5774F793
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 19:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGKRyU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 13:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGKRyU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 13:54:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C8E77
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689098058; x=1720634058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XtLlra2UIPluggep982K7wV4npokUhWZAQamScwEf+A=;
  b=FIMA7Ts2biX6VOSQ9sFwDnDhuEB0XHVda7cuGJ4RCUYxvVXNiKvneEZj
   XoOzba6SlrHoQ/UL93bseWjLpQAy2QGI7+LErF6rUjq2i9s6OH7vSWAMx
   uuX5x1tYF/iAi9mqCM6+g2nBncD2ddXQST5tXuC/KkMhc1/vsYdA8kNPJ
   8gEJhAeBbFBcG28AAWSniaMdU/pUPf09QSERH+kqOJaVOQS5tDYQ6eBTF
   ShV4tMIOdU41PtOuRVMp/vnDJBbz8Ou7YMLF5q4aQJgxr1SIFAnRwk8NO
   QvIsOpMEyNPWSagAcFxR5MY/Svorg0NxD8S0nl2LQkRpDiJAAANxMVChS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363555795"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="363555795"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="845363525"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="845363525"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.33.5])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:54:08 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     phaddad@nvidia.com, jgg@nvidia.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc] Revert "RDMA/core: Refactor rdma_bind_addr"
Date:   Tue, 11 Jul 2023 12:53:58 -0500
Message-Id: <20230711175358.1313-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This reverts commit 8d037973d48c026224ab285e6a06985ccac6f7bf.

A regression is seen on irdma devices on certain tests which uses
rdma CM, such as cmtime.

No connections can be established with the MAD QP experiences a fatal
error on the client side.

The cma destination address is not updated with the dst_addr passed in
when ULP calls resolve address and id_priv state is 'bound' in
resolve_prepare_src. Therefore the dgid passed into irdma driver to
create an Address Handle AH) for the MAD QP is 0. The create AH descriptor
as well as the ARP cache entry is invalid and HW throws an asynchronous
events as result.

[ 1207.656888] resolve_prepare_src caller: ucma_resolve_addr+0xff/0x170 [rdma_ucm] daddr=200.0.4.28 id_priv->state=7
[....]
[ 1207.680362] ice 0000:07:00.1 rocep7s0f1: caller: irdma_create_ah+0x3e/0x70 [irdma] ah_id=0 arp_idx=0 dest_ip=0.0.0.0
destMAC=00:00:64:ca:b7:52 ipvalid=1 raw=0000:0000:0000:0000:0000:ffff:0000:0000
[ 1207.682077] ice 0000:07:00.1 rocep7s0f1: abnormal ae_id = 0x401 bool qp=1 qp_id = 1, ae_src=5
[ 1207.691657] infiniband rocep7s0f1: Fatal error (1) on MAD QP (1)

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/cma.c | 253 +++++++++++++++++-----------------
 1 file changed, 123 insertions(+), 130 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1ee87c3aaeab..d8d0e4f02704 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3549,6 +3549,121 @@ static int cma_resolve_ib_addr(struct rdma_id_private *id_priv)
 	return ret;
 }
 
+static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
+			 const struct sockaddr *dst_addr)
+{
+	struct sockaddr_storage zero_sock = {};
+
+	if (src_addr && src_addr->sa_family)
+		return rdma_bind_addr(id, src_addr);
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
+	return rdma_bind_addr(id, (struct sockaddr *)&zero_sock);
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
+	memcpy(cma_dst_addr(id_priv), dst_addr, rdma_addr_size(dst_addr));
+	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
+		/* For a well behaved ULP state will be RDMA_CM_IDLE */
+		ret = cma_bind_addr(&id_priv->id, src_addr, dst_addr);
+		if (ret)
+			goto err_dst;
+		if (WARN_ON(!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND,
+					   RDMA_CM_ADDR_QUERY))) {
+			ret = -EINVAL;
+			goto err_dst;
+		}
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
 int rdma_set_reuseaddr(struct rdma_cm_id *id, int reuse)
 {
 	struct rdma_id_private *id_priv;
@@ -3951,26 +4066,27 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 }
 EXPORT_SYMBOL(rdma_listen);
 
-static int rdma_bind_addr_dst(struct rdma_id_private *id_priv,
-			      struct sockaddr *addr, const struct sockaddr *daddr)
+int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 {
-	struct sockaddr *id_daddr;
+	struct rdma_id_private *id_priv;
 	int ret;
+	struct sockaddr  *daddr;
 
 	if (addr->sa_family != AF_INET && addr->sa_family != AF_INET6 &&
 	    addr->sa_family != AF_IB)
 		return -EAFNOSUPPORT;
 
+	id_priv = container_of(id, struct rdma_id_private, id);
 	if (!cma_comp_exch(id_priv, RDMA_CM_IDLE, RDMA_CM_ADDR_BOUND))
 		return -EINVAL;
 
-	ret = cma_check_linklocal(&id_priv->id.route.addr.dev_addr, addr);
+	ret = cma_check_linklocal(&id->route.addr.dev_addr, addr);
 	if (ret)
 		goto err1;
 
 	memcpy(cma_src_addr(id_priv), addr, rdma_addr_size(addr));
 	if (!cma_any_addr(addr)) {
-		ret = cma_translate_addr(addr, &id_priv->id.route.addr.dev_addr);
+		ret = cma_translate_addr(addr, &id->route.addr.dev_addr);
 		if (ret)
 			goto err1;
 
@@ -3990,10 +4106,8 @@ static int rdma_bind_addr_dst(struct rdma_id_private *id_priv,
 		}
 #endif
 	}
-	id_daddr = cma_dst_addr(id_priv);
-	if (daddr != id_daddr)
-		memcpy(id_daddr, daddr, rdma_addr_size(addr));
-	id_daddr->sa_family = addr->sa_family;
+	daddr = cma_dst_addr(id_priv);
+	daddr->sa_family = addr->sa_family;
 
 	ret = cma_get_port(id_priv);
 	if (ret)
@@ -4009,127 +4123,6 @@ static int rdma_bind_addr_dst(struct rdma_id_private *id_priv,
 	cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_IDLE);
 	return ret;
 }
-
-static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
-			 const struct sockaddr *dst_addr)
-{
-	struct rdma_id_private *id_priv =
-		container_of(id, struct rdma_id_private, id);
-	struct sockaddr_storage zero_sock = {};
-
-	if (src_addr && src_addr->sa_family)
-		return rdma_bind_addr_dst(id_priv, src_addr, dst_addr);
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
-	return rdma_bind_addr_dst(id_priv, (struct sockaddr *)&zero_sock, dst_addr);
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
-	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
-		/* For a well behaved ULP state will be RDMA_CM_IDLE */
-		ret = cma_bind_addr(&id_priv->id, src_addr, dst_addr);
-		if (ret)
-			return ret;
-		if (WARN_ON(!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND,
-					   RDMA_CM_ADDR_QUERY)))
-			return -EINVAL;
-
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
-int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
-{
-	struct rdma_id_private *id_priv =
-		container_of(id, struct rdma_id_private, id);
-
-	return rdma_bind_addr_dst(id_priv, addr, cma_dst_addr(id_priv));
-}
 EXPORT_SYMBOL(rdma_bind_addr);
 
 static int cma_format_hdr(void *hdr, struct rdma_id_private *id_priv)
-- 
2.31.1

