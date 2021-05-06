Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B101375D97
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhEFXkW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhEFXkV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:40:21 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27FC061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=W72aT2pJurjmDhoaXNR3tpgcPeJrLVH2bDU1/lqUAbw=; b=XJulgsrtTcc4HXt5U1b8ohZ0bB
        dmNtw+yXFWw7hkMbmEB2Bz7lsaG96slRD81IyM1eAxKLX2qN825wOmtYlMZhY8+CHpprnnS+vj7bp
        7ZKDj78pQbD4VhZl0XmKfHy4Cf+2tEqODfi8+6clpDy5h+YPYsBmQnJKhbCqOgIW8leJGv6LeWx3b
        a5HAob7yGZBwwcY3IoU4800z2jnWlxFUIr+cp1pgSy+yRAzTss15s6OqdTbOkd4qDA6m7rQa6Odge
        msdKxna/B0hNRiqYQliZpAco6qSdFY805QBZoX+80YaIRBvTMrP93BrLh+ajpradNzup7+UV4K48F
        lrqliwKmISDs0MwOAQEfvQ69QB/HzpmQpgoJvFKzI5GDRadIJAv8Xa4nOlO87SaMA1xiF4QYtJfkU
        ATWpI/auf9ndFlXYY56gtMo9ZJc7eWtDnyaiVDsQ5TdqZsu23DPXAerDsupTtgb4RrgoWbCebZMkL
        6Hu7aIZmU2GLcMDBrCsPNEXJ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenaS-0004Mw-LG; Thu, 06 May 2021 23:39:20 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 22/31] rdma/siw: let siw_listen_address() call siw_cep_set_inuse() early
Date:   Fri,  7 May 2021 01:36:28 +0200
Message-Id: <33abff2233b36a51e468d691cb4327d0294d2734.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We should protect the whole section after siw_cep_alloc().

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index fe6f7bb4d615..09ae7f7ca82a 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1920,6 +1920,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	if (!cep)
 		return -ENOMEM;
 
+	siw_cep_set_inuse(cep);
+
 	rv = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (rv < 0) {
 		siw_dbg(id->device, "sock_create error: %d\n", rv);
@@ -2014,13 +2016,12 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 
 	siw_dbg(id->device, "Listen at laddr %pISp\n", &id->local_addr);
 
+	siw_cep_set_free(cep);
 	return 0;
 
 error:
 	siw_dbg(id->device, "failed: %d\n", rv);
 
-	siw_cep_set_inuse(cep);
-
 	if (cep->cm_id) {
 		cep->cm_id->rem_ref(cep->cm_id);
 		cep->cm_id = NULL;
-- 
2.25.1

