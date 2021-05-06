Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9AB375D84
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhEFXi3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhEFXi3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:38:29 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74023C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=g/v6Hu7Oi75FF+jmhYv0O9TT5+vFAPxZiZNDiqqWYqs=; b=asWRxJxlvmxTwIRENB4sYDv7JD
        1+o1DDZPAf7riXnfPEuI757Vlm8BPh4eGyYnLcTxrIlOGreykcSFlQvZ1hgfq12PvuCsR+cx4NnD0
        8uTTOl5+Yfe19NHZJrC8Xvox8+HrQdLcyWy6fBMZXjKjF2QhKY3NkC9AY+z6x0wfDvArB8J7nvRWq
        awkcfKsn466f0Y2V4BoorkG9MZQrjJHOK5XQMFttRf8h6qo+JkSy4mMjS2VNtHduU2fdIyCAKGyq2
        i+eORklyXVsuKCdgip8FQotTPnq2juLap1JO08jWlNS+W47cYltQD0wYmUgMcsoAkF2iYZDcDJeDk
        +d/1jH8gFc1F2eJj186WntAvw+F9g+k6oNAPHnX7MN+jdBa/tYH4RtXE4ySjpFZy2gLTkpa0Da8Mb
        odzENG4JfWgsIuIx6L1WYxEDiaEvqLqasL/X3kFP8aRfD2L+Ou3kxGu4chy5sgigMAbu6HwKhDtkX
        udi2cTtoktvCYGiyKL7lnLN7;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenYe-0004JB-Ii; Thu, 06 May 2021 23:37:28 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 05/31] rdma/siw: make use of kernel_{bind,connect,listen}()
Date:   Fri,  7 May 2021 01:36:11 +0200
Message-Id: <cb0c051ce8001ec125c74148e172bfba2be831be.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 145ab6e4e0ed..e21cde84306e 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1319,11 +1319,11 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
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
@@ -1787,8 +1787,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in));
 	} else {
 		struct sockaddr_in6 *laddr = &to_sockaddr_in6(id->local_addr);
 
@@ -1805,8 +1805,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv6_addr_any(&laddr->sin6_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in6));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in6));
 	}
 	if (rv) {
 		siw_dbg(id->device, "socket bind error: %d\n", rv);
@@ -1826,7 +1826,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 			rv, backlog);
 		goto error;
 	}
-	rv = s->ops->listen(s, backlog);
+	rv = kernel_listen(s, backlog);
 	if (rv) {
 		siw_dbg(id->device, "listen error %d\n", rv);
 		goto error;
-- 
2.25.1

