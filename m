Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAC375D93
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhEFXkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhEFXkC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:40:02 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B74C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=Po4bU4uuYArp5nFCWjbgEB6uuMZCMypdxRuVdxaTI5k=; b=Cq7J6FVwA6CuB3h5KE2Di+hCgh
        3ENjvlltdjau180+gSKYq/479ovZ0C0QDBS43oGeM67M6eWWJWcGZZ4t6eTgmY4RMbqib74GcyQCV
        nQfMv65Lznke64sGwAYoUmFtQGgpf0TDm4vdRE57RgMB+t/ocGtIsUa4lhXrCfBqttnGgMNeq7eyY
        ezYZqIC8rflS98qkZ4IOoosTA+NebutfhdgTQD6Ht5OCOxybi4frHd5p2snxO267uWfJDFuucPYWM
        8jIeh5IB5y/XPonCPwuKPWCsPK84ohkt7u4XpuH5Kt83HZFX1Kp5Dhr7XuADMQi4B0P5EwZTteL/A
        je930C9A6aWEcd3++2WLnGOZ+XWO2hZjrDD1W3wfAL/N8EppvS125YdWoVFe2v7+GbxbodJ8P4ksi
        momuA67RTRHtFUuFx1I7otpXnBrUJPNfsV8At5t5v1dRixKC88v87hEnxUW0QBCxdNNW8NVf6Xnof
        K8msrkOZMoaV1AsfLt1ldYR9;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lena9-0004MJ-BS; Thu, 06 May 2021 23:39:01 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 19/31] rdma/siw: split out a __siw_cep_close() function
Date:   Fri,  7 May 2021 01:36:25 +0200
Message-Id: <8f68ab650c2ecac55075d07a4256eff7b1735324.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This can be used in a lot of other places too.
And can be the code path that we can easily adjust
without forgetting other places.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 48 ++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 009a0afe6669..cf0f881c6793 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -220,6 +220,34 @@ static void __siw_cep_terminate_upcall(struct siw_cep *cep,
 	}
 }
 
+/*
+ * The caller needs to deal with siw_cep_set_inuse()
+ * and siw_cep_set_free()
+ */
+static void __siw_cep_close(struct siw_cep *cep)
+{
+	cep->state = SIW_EPSTATE_CLOSED;
+
+	if (cep->sock) {
+		siw_socket_disassoc(cep->sock);
+		sock_release(cep->sock);
+		cep->sock = NULL;
+	}
+
+	if (cep->cm_id) {
+		cep->cm_id->rem_ref(cep->cm_id);
+		cep->cm_id = NULL;
+	}
+
+	if (cep->qp) {
+		BUG_ON(cep->qp->cep != cep);
+		cep->qp->cep = NULL;
+		siw_qp_put(cep->qp);
+		cep->qp = NULL;
+		siw_cep_put(cep);
+	}
+}
+
 static void siw_rtr_data_ready(struct sock *sk)
 {
 	struct siw_cep *cep;
@@ -1559,27 +1587,17 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	if (cep) {
 		siw_cancel_mpatimer(cep);
 
-		siw_socket_disassoc(s);
-		sock_release(s);
-		cep->sock = NULL;
-
-		cep->qp = NULL;
+		s = NULL;
+		qp = NULL;
 
-		cep->cm_id = NULL;
-		id->rem_ref(id);
-
-		qp->cep = NULL;
-		siw_cep_put(cep);
-
-		cep->state = SIW_EPSTATE_CLOSED;
+		__siw_cep_close(cep);
 
 		siw_cep_set_free(cep);
 
 		siw_cep_put(cep);
-
-	} else if (s) {
-		sock_release(s);
 	}
+	if (s)
+		sock_release(s);
 	if (qp)
 		siw_qp_put(qp);
 
-- 
2.25.1

