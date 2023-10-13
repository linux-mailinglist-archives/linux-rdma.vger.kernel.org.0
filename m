Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA37C7B6F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjJMCBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJMCBW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:22 -0400
Received: from out-195.mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533DCC
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRxoBBa6JHgn47LY0wQmmJn0aLTvNXOdqcRyXTPiNvU=;
        b=Oxz/3PBJl7/6f7Tyrm0gvebY/1B6hh8wkjxpXvjq0zx8WJ58zQvIq4i8lzehhCgJagsQJM
        6mOtFfyyIgow1CkL02Qox/XCALC0XFzCdGeXuTDiRSWD6JF/QTgJqUfI/CANIFOc8+6Yj2
        v4Cty6NGFds9jxUtWUAlvOfF4oBB1+M=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 12/20] RDMA/siw: Introduce siw_free_cm_id
Date:   Fri, 13 Oct 2023 10:00:45 +0800
Message-Id: <20231013020053.2120-13-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-1-guoqing.jiang@linux.dev>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Factor out a helper to simplify code.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310091656.JlrmcNXB-lkp@intel.com/
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 36 +++++++++++++-----------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 2f338bb3a24c..21303bad1281 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -364,6 +364,17 @@ static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 	return id->event_handler(id, &event);
 }
 
+static void siw_free_cm_id(struct siw_cep *cep, bool put_cep)
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

