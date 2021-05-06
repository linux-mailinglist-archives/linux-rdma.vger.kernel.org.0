Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BB375D90
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhEFXjt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhEFXjs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:39:48 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D24C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=wnPlEd2eniaz91RNeltIO2WRhr5HA/Lh6vheCzw/3zs=; b=m+x/79jiSheSey36LxoP+O2mCM
        Y+6+ht9RJGqSWJyj66ihwl+E14rSxPkJLzZwCyHzQyrQanaurK8/AZZVX97HNIH73LfcewZ0aqImx
        pO0RC9h4QZpCbjsz+F/IZ7R1dqUdn+qga5BoQ6yuCfam1lnCn1MN5rhxybQSz5EQzvPnhKvjSsN7S
        ouk/BU0L9sSSwqAJjh78XXJNihOKQqbeI/Ydz6MwKrcEZaG2pu2ps6h1aJovu0jnu1zoNOjXdtn96
        lUaCtwAUzOVHlJrvMOhPIIPIszfQQXstBYim03EYyE0QbTt1KUzhz5SYcxBBvcWIGPhoHoH1Dpy/U
        IqfDF0X5BCh8oTNRY/cPPvNgxBTHdvY2WJLS6r7QiSHCVQBBAgxkI+hWuSVfLihmzMBMkizLh/5Cb
        Ja6IFHo7jC6y2eI2uBr3ICD2Hx6Ljit1umXy9KwybV7vQ0ZgSf7KAjqULJ34Wx7DbrkVhD5ErQ6fh
        72LO+s/imzAxjpKJvJZX5qYM;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenZw-0004Lu-2H; Thu, 06 May 2021 23:38:48 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 17/31] rdma/siw: start mpa timer before calling siw_send_mpareqrep()
Date:   Fri,  7 May 2021 01:36:23 +0200
Message-Id: <c81a993594cc8dca834b0bf5de960fac68093250.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mpa timer will also span the non-blocking connect
in the final patch.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index ec6d5c26fe22..853b80fcb8b0 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1526,6 +1526,11 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	cep->mpa.hdr.params.pd_len = pd_len;
 
+	rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
+	if (rv != 0) {
+		goto error;
+	}
+
 	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
 
 	rv = siw_send_mpareqrep(cep, cep->mpa.pdata,
@@ -1543,11 +1548,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		goto error;
 	}
 
-	rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
-	if (rv != 0) {
-		goto error;
-	}
-
 	siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
 	siw_cep_set_free(cep);
 	return 0;
@@ -1556,6 +1556,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_dbg(id->device, "failed: %d\n", rv);
 
 	if (cep) {
+		siw_cancel_mpatimer(cep);
+
 		siw_socket_disassoc(s);
 		sock_release(s);
 		cep->sock = NULL;
-- 
2.25.1

