Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE354C3BB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbiFOIld (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 04:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346460AbiFOIlN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 04:41:13 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1C4AE10
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 01:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=25p7925ITEYPPnsTBDZLySHrB0vJm02meGuExfPpW+M=; b=KIiPDFdUlcHRPeUQiijKcli1YV
        ZsOwLGjV7iibEb3OJRuy8e52zxHMECj8f25l9PLMiBYdA2SvtjUpoFsL5PhPXUu0hRB/tjNSj7A3x
        K06zwgruEb/2ZJUwudiuAglxns3RXU4H6kTSdAWf6d4VTGFLfY8YrgmU8PqYLyrDcWxfG9kCnWfyP
        t11UhKz3Hjbld2IoxQUKN7y/isT6p/hx+N4aF+pfd3lbGzHRtkJohYpcLBVEHIqLLo+WCG+iVTxXY
        pPzmk/BqS1yxQGQMGhJ9XJBo+GNWWiHlADLREcFdy1V7lCfo2JP59wq49yeVZEB0op6F/0ec8I1R4
        2by/d1pr2ZqJ3bYzcH21VSPsY54l+ydOe9XvMsfsLhxr/aNALMWe2GNWVWJV24qZ4Paouqpv6m89B
        mPavPWzC0ahShXAchjSbLLF9ggD7GO2SCNxkEnWfbDcOgFXv6MgbgHFZd+Fz1nbKc6L7Z50KVCzqn
        hDyk1DzdAzhGzmzoQnQm1htF;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1OaM-005p9H-Id; Wed, 15 Jun 2022 08:41:10 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 1/7] rdma/siw: make use of kernel_{bind,connect,listen}()
Date:   Wed, 15 Jun 2022 10:40:01 +0200
Message-Id: <883fa5d941c9fa7d131abe9b9424438076f05a9a.1655248086.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655248086.git.metze@samba.org>
References: <cover.1655248086.git.metze@samba.org>
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
index 17f34d584cd9..644c7d50e991 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1318,11 +1318,11 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
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
@@ -1788,8 +1788,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in));
 	} else {
 		struct sockaddr_in6 *laddr = &to_sockaddr_in6(id->local_addr);
 
@@ -1806,8 +1806,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv6_addr_any(&laddr->sin6_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in6));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in6));
 	}
 	if (rv) {
 		siw_dbg(id->device, "socket bind error: %d\n", rv);
@@ -1827,7 +1827,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
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

