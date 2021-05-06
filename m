Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737ED375D96
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhEFXkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhEFXkP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:40:15 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC81C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=5BOyOcbxbJ4md9sXdLKC7g15MuupL/qOC5xr1Vkt/pk=; b=fK32m8dXu4MQkksWxWmOr8bqdg
        v57Q7uK9z4zQ4NsL0B2qOV6/PunLVcMlzpyo66BvO8g9oaCSaBhGFnv5fePI74D+hyv+ZhrksAgg9
        HOcpmq/lKfxgy+BfM/V/PacI17kAramvQr9LukodZ6bPTT4+TwomUSjhus4VP0XOWb7TbcsH68sHJ
        z8jeFT+azWrH5aWKow3bndpHzISStJM+Dau7r4TD+LwtY5SZE+8/I8RaXoLPTj937fueTG0R0ao3E
        pGErIMDArF/eswGc0mShYhNz9RgyJ6iKve7kQVWl+WtTuXtLcoEcyz1M37DfJH/GTl/9bQEhNfszE
        Q/OG+0Z2Xz8rk0jXeZ6EMfrHfLDUpec95FXzY6aNt/9mtZrJJqIkWqDNKjmcMIys7qrrAvb38z9UR
        oYoT6Yiw6IQal/qP09uXMefO4CgFQjQJwR3CF6ErIS8Oh33sd99unZfTTbeCxKfhA8hJvUHSyJ9cr
        eYEcGcW6xUrLTtyV+oE7rt8L;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenaM-0004Mk-5b; Thu, 06 May 2021 23:39:14 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 21/31] rdma/siw: let siw_listen_address() call siw_cep_alloc() first
Date:   Fri,  7 May 2021 01:36:27 +0200
Message-Id: <66ef71c4c9cd6767746e0d48c75423487e59834a.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This simplifies the cleanup path and makes the following
changes easier to review.

Check with "git show -w".

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 39 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 9a550f040678..fe6f7bb4d615 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1916,9 +1916,16 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	if (addr_family != AF_INET && addr_family != AF_INET6)
 		return -EAFNOSUPPORT;
 
+	cep = siw_cep_alloc(sdev);
+	if (!cep)
+		return -ENOMEM;
+
 	rv = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
-	if (rv < 0)
-		return rv;
+	if (rv < 0) {
+		siw_dbg(id->device, "sock_create error: %d\n", rv);
+		goto error;
+	}
+	siw_cep_socket_assoc(cep, s);
 
 	/*
 	 * Allow binding local port when still in TIME_WAIT from last close.
@@ -1957,12 +1964,6 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		siw_dbg(id->device, "socket bind error: %d\n", rv);
 		goto error;
 	}
-	cep = siw_cep_alloc(sdev);
-	if (!cep) {
-		rv = -ENOMEM;
-		goto error;
-	}
-	siw_cep_socket_assoc(cep, s);
 
 	rv = siw_cm_alloc_work(cep, backlog);
 	if (rv) {
@@ -2018,20 +2019,18 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 error:
 	siw_dbg(id->device, "failed: %d\n", rv);
 
-	if (cep) {
-		siw_cep_set_inuse(cep);
-
-		if (cep->cm_id) {
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-		}
-		cep->sock = NULL;
-		siw_socket_disassoc(s);
-		cep->state = SIW_EPSTATE_CLOSED;
+	siw_cep_set_inuse(cep);
 
-		siw_cep_set_free(cep);
-		siw_cep_put(cep);
+	if (cep->cm_id) {
+		cep->cm_id->rem_ref(cep->cm_id);
+		cep->cm_id = NULL;
 	}
+	cep->sock = NULL;
+	siw_socket_disassoc(s);
+	cep->state = SIW_EPSTATE_CLOSED;
+
+	siw_cep_set_free(cep);
+	siw_cep_put(cep);
 	sock_release(s);
 
 	return rv;
-- 
2.25.1

