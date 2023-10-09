Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB477BD449
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjJIHZk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345397AbjJIHZh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:25:37 -0400
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55C1AC
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:25:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0V+DZiQHFyZD645yc0/sFcs6f7rSQ4Tdv1laGZthcI=;
        b=n7AVf1KywR6I4zAS7igt42T09zPvTZDjHfP7DD+qjs7xqxgsWav3k1aBIGUPqgGwcde/O5
        Wz7EHzcxripnPleROUrA4lfq40ODxCTJZ8HR3XpC1XLc7r9s27IGJI2qftO0FPUJj4V3m4
        L2Zzj5G8OH/R06DFomrdeWz3H988DmI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 12/19] RDMA/siw: Introduce siw_free_cm_id
Date:   Mon,  9 Oct 2023 15:17:54 +0800
Message-Id: <20231009071801.10210-13-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-1-guoqing.jiang@linux.dev>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Factor out a helper to simplify code.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 36 +++++++++++++-----------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 2f338bb3a24c..987084828786 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -364,6 +364,17 @@ static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 	return id->event_handler(id, &event);
 }
 
+void siw_free_cm_id(struct siw_cep *cep, bool put_cep)
+{
+	if (!cep->cm_id)
+		return;
+
+	cep->cm_id->rem_ref(cep->cm_id);
+	cep->cm_id = NULL;
+	if (put_cep)
+		siw_cep_put(cep);
+}
+
 /*
  * siw_qp_cm_drop()
  *
@@ -415,9 +426,7 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
 			default:
 				break;
 			}
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-			siw_cep_put(cep);
+			siw_free_cm_id(cep, true);
 		}
 		cep->state = SIW_EPSTATE_CLOSED;
 
@@ -1175,11 +1184,7 @@ static void siw_cm_work_handler(struct work_struct *w)
 			sock_release(cep->sock);
 			cep->sock = NULL;
 		}
-		if (cep->cm_id) {
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-			siw_cep_put(cep);
-		}
+		siw_free_cm_id(cep, true);
 	}
 	siw_cep_set_free(cep);
 	siw_put_work(work);
@@ -1702,10 +1707,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 	cep->state = SIW_EPSTATE_CLOSED;
 
-	if (cep->cm_id) {
-		cep->cm_id->rem_ref(id);
-		cep->cm_id = NULL;
-	}
+	siw_free_cm_id(cep, false);
 	if (qp->cep) {
 		siw_cep_put(cep);
 		qp->cep = NULL;
@@ -1880,10 +1882,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	if (cep) {
 		siw_cep_set_inuse(cep);
 
-		if (cep->cm_id) {
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-		}
+		siw_free_cm_id(cep, false);
 		cep->sock = NULL;
 		siw_socket_disassoc(s);
 		cep->state = SIW_EPSTATE_CLOSED;
@@ -1912,10 +1911,7 @@ static void siw_drop_listeners(struct iw_cm_id *id)
 
 		siw_cep_set_inuse(cep);
 
-		if (cep->cm_id) {
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-		}
+		siw_free_cm_id(cep, false);
 		if (cep->sock) {
 			siw_socket_disassoc(cep->sock);
 			sock_release(cep->sock);
-- 
2.35.3

