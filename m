Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB06375D9D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhEFXlB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhEFXlA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:41:00 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AF9C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=5mLw9W9vQl9uvRSm5A7okVmcJ4Ft1ZKQRuubBosggWI=; b=tNr143gG4CHO1I2bXys3Q2NclR
        WiZ2It72L8rFJRZRQK785+W9aEudTHLeASQW0x2Jbw5KtSXeqplnUesJzKYW5SZvFG8rdAvP2PfQX
        +kpOCeGt170sBBM5KpbCp2VR1+bfaTHHu3J3X//WEB57668qpUy8/joG4g1LjtjtQ/ngL/HQJzRPS
        IurkJThxii0t/8Zt9cd6ZgyEuYOk5iJlhUX7adll3cirlzEZDjtBz2dn6zrtvfs1F3p8KJJ4nvbxh
        vAg5ayNSm8QG8GKzWRYnN87RpjSL6i64S0jhOnHrI5l6zuiAOnoMb1ROCRdHXIS3PKfIv5Bwk0WN7
        yW6H8NaMLsZlIWZ4ku+IonNjiJZGmFdSvgz4YhmSzMqraMB8s726gvEmT3Ce6PEQUlB6MffT3UmG9
        tCwFlT472xPFtvkggyiAQPzY8w6AVht2jowZMMd0D4nsfEdN5t8nCC+6UeN9YPUb0I0lE/jGgKdUE
        xmAlHA5Nq8NMLKKHN6cZrqPv;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenb5-0004OZ-VB; Thu, 06 May 2021 23:40:00 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 28/31] rdma/siw: make use of __siw_cep_close() in siw_qp_cm_drop()
Date:   Fri,  7 May 2021 01:36:34 +0200
Message-Id: <728163975670504e4401f73dcd9d6d18b56d1ba0.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that the logic is identical we better use the common function
in order to avoid future problems.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 9f9750237e75..d2b1c62177ea 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -542,28 +542,7 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
 		siw_dbg_cep(cep, "immediate close, state %d\n", cep->state);
 
 		__siw_cep_terminate_upcall(cep, -EINVAL);
-
-		if (cep->cm_id) {
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-		}
-		cep->state = SIW_EPSTATE_CLOSED;
-
-		if (cep->sock) {
-			siw_socket_disassoc(cep->sock);
-			/*
-			 * Immediately close socket
-			 */
-			sock_release(cep->sock);
-			cep->sock = NULL;
-		}
-		if (cep->qp) {
-			BUG_ON(cep->qp->cep != cep);
-			cep->qp->cep = NULL;
-			siw_qp_put(cep->qp);
-			cep->qp = NULL;
-			siw_cep_put(cep);
-		}
+		__siw_cep_close(cep);
 out:
 		siw_cep_set_free(cep);
 	}
-- 
2.25.1

