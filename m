Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A37054CCDC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347511AbiFOP27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355903AbiFOP2n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:43 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E35377C1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=UW2Q4DKap7dbdm1xz+2zCR+DEnfL3DGRO96gvyc4UDg=; b=2fVIMFsDxBrV9xGhue/cDm27kL
        s+EnNzaeqTtcdmOOXnpFYknqGCVEBzDW9k1pzC6+r2nmTLA9n8XNSF1b8OtXJjKmXWGoRmBobDT0J
        50SQvX07jCDfLwS0xql6lVlko+MFo8qIjRGS5jM7MHJZbebLzs7nx4dWnhcqbXBaHWVYVGLovqgxd
        lL28EL0PRxby/xAxVxOQSPT9R/H13ZiStUaBJgNeG0WC0UoUTNQBpRvTcuHy/wi1NkG4g2lpTLDEz
        FDTTgy/Ve7M+kyki9bwMKHwU4A8pq7+jdu1wbYOl/exdsbhVC6+mfCDx6Sui+E0UVGUS/2aX44Sx8
        CtWDcqxf3r76IJtKPG+ae4WqHG3OXMVH673P6oReep92SBrR/dG5lpSDhuIzkAFOQnG1rEdqhAlBg
        J94X6KlRTebJ+l5F4yhTXG4sXTCUL8BC2T8ecIGb+xHuo4hVAmugAoQSzNfZvvxRERRVrGVNd28Av
        WuO9dORdt5oPErauP8CiDkBY;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Uw1-005rvT-9s; Wed, 15 Jun 2022 15:27:57 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 08/14] rdma/siw: make use of kernel_{bind,connect,listen}()
Date:   Wed, 15 Jun 2022 17:26:46 +0200
Message-Id: <c839621e4871f12991d943a1270271f6cf5ff53c.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655305567.git.metze@samba.org>
References: <cover.1655305567.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

That's nicer than dereferencing socket structures.

This prepares making rdma_connect()/siw_connect() non-blocking
in order to avoid deadlocks in the callers.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 80e1d5b274e7..e8e29ce609b4 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1331,11 +1331,11 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 			return rv;
 	}
 
-	rv = s->ops->bind(s, laddr, size);
+	rv = kernel_bind(s, laddr, size);
 	if (rv < 0)
 		return rv;
 
-	rv = s->ops->connect(s, raddr, size, flags);
+	rv = kernel_connect(s, raddr, size, flags);
 
 	return rv < 0 ? rv : 0;
 }
@@ -1800,8 +1800,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in));
 	} else {
 		struct sockaddr_in6 *laddr = &to_sockaddr_in6(id->local_addr);
 
@@ -1818,8 +1818,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv6_addr_any(&laddr->sin6_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in6));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in6));
 	}
 	if (rv) {
 		siw_dbg(id->device, "socket bind error: %d\n", rv);
@@ -1839,7 +1839,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 			rv, backlog);
 		goto error;
 	}
-	rv = s->ops->listen(s, backlog);
+	rv = kernel_listen(s, backlog);
 	if (rv) {
 		siw_dbg(id->device, "listen error %d\n", rv);
 		goto error;
-- 
2.34.1

