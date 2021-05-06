Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3777C375D98
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhEFXk3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhEFXk2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:40:28 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BCC061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=ztncEAoT1eKkq9inquNni1Xp2rvapRlijUDB6jPhC34=; b=YP3qQKRw366C1mfxnoCRyayj4H
        lEBbDT1pc1GiCUEKLsq65XhuNOpOvXODeG58Ps8H+Lc07b0a63PLOPNwK1cMXWdNhJOcCh926KHIS
        dbJ3UlqIKv/70ZMcE1yaBxdutMH982ynLmihbYmAWnBOZdH/frxN2an4/v2wVrA8hUtOwYyjjo1B+
        w5/14gR5zxfwe8JZOEfvm1NEMR6v8KoDq4Ex0uwIqRMVN/hJWpiD9lfqVGa79Jkt24xkeE2EOytlh
        bLNe+UNAZ/j8lc4mREL/z5P2CNJIryBPte8q8kDGhDxt41orj82Y4PTPpsWw0bhlt8rkm1rRc6Afu
        sBfIU2iw0M+xKx8mrSrANryDnAobm1h8hhTcjU3EhK7W8GgNqEHYsYN41CtwwVIeSiOoHTiheTb0n
        HqpGpZ1QfGCVyQoB0IVBUba38TayorIKSp1MBpTirKNIpipBJobcvdGnqlOiIjDDwxVFFCNUB2CF3
        0HsksG29SRgKoCrJN0NYT79j;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenaZ-0004ND-UC; Thu, 06 May 2021 23:39:27 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 23/31] rdma/siw: make use of __siw_cep_close() in siw_accept()
Date:   Fri,  7 May 2021 01:36:29 +0200
Message-Id: <bf2e457f30108e0872f517e7ac585bb956a291a7.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is basically the same just that the code in
__siw_cep_close() common, it skips elements which
are still NULL. Before it was really hard to prove
that we don't deference NULL pointers.

While developing my smbdirect driver, I hit so much
crashes and deadlocks, so we better have code that's
understandable.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 09ae7f7ca82a..7fd67499f1d3 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1833,23 +1833,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 	return 0;
 error:
-	siw_socket_disassoc(cep->sock);
-	sock_release(cep->sock);
-	cep->sock = NULL;
-
-	cep->state = SIW_EPSTATE_CLOSED;
-
-	if (cep->cm_id) {
-		cep->cm_id->rem_ref(id);
-		cep->cm_id = NULL;
-	}
-	if (qp->cep) {
-		siw_cep_put(cep);
-		qp->cep = NULL;
-	}
-	cep->qp = NULL;
-	siw_qp_put(qp);
-
+	__siw_cep_close(cep);
 	siw_cep_set_free(cep);
 	siw_cep_put(cep);
 
-- 
2.25.1

