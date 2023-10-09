Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7427BD43F
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbjJIHZf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbjJIHZe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:25:34 -0400
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EE7AB
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:25:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gl5qHTuqLDGYWhAyLHNhoJmJKVBxFumuNjO3PoAIdw8=;
        b=K1FGed9FKjvGJOVPhRJ7VIQHg1I2ncoqD6OrN+Jw49r+giOb0JvBmVjPfmspOqynYc8gnk
        7GT9oKeZUmE58oCRtBaOHdsRSUxTvZp3J25bL5lH/5bib7iHqBqALLDwwBlPvk29HcNtJ9
        csncC8Y7kQySmscl5LPhzNn8mi2UNlY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 11/19] RDMA/siw: Introduce siw_cep_set_free_and_put
Date:   Mon,  9 Oct 2023 15:17:53 +0800
Message-Id: <20231009071801.10210-12-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-1-guoqing.jiang@linux.dev>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
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

Add the helper which can be used in some places.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 31 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index c8a9118677d7..2f338bb3a24c 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -444,6 +444,12 @@ void siw_cep_put(struct siw_cep *cep)
 	kref_put(&cep->ref, __siw_cep_dealloc);
 }
 
+static void siw_cep_set_free_and_put(struct siw_cep *cep)
+{
+	siw_cep_set_free(cep);
+	siw_cep_put(cep);
+}
+
 void siw_cep_get(struct siw_cep *cep)
 {
 	kref_get(&cep->ref);
@@ -1506,9 +1512,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		cep->state = SIW_EPSTATE_CLOSED;
 
-		siw_cep_set_free(cep);
-
-		siw_cep_put(cep);
+		siw_cep_set_free_and_put(cep);
 
 	} else if (s) {
 		sock_release(s);
@@ -1556,16 +1560,14 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	if (cep->state != SIW_EPSTATE_RECVD_MPAREQ) {
 		siw_dbg_cep(cep, "out of state\n");
 
-		siw_cep_set_free(cep);
-		siw_cep_put(cep);
+		siw_cep_set_free_and_put(cep);
 
 		return -ECONNRESET;
 	}
 	qp = siw_qp_id2obj(sdev, params->qpn);
 	if (!qp) {
 		WARN(1, "[QP %d] does not exist\n", params->qpn);
-		siw_cep_set_free(cep);
-		siw_cep_put(cep);
+		siw_cep_set_free_and_put(cep);
 
 		return -EINVAL;
 	}
@@ -1711,8 +1713,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	cep->qp = NULL;
 	siw_qp_put(qp);
 
-	siw_cep_set_free(cep);
-	siw_cep_put(cep);
+	siw_cep_set_free_and_put(cep);
 
 	return rv;
 }
@@ -1735,8 +1736,7 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
 	if (cep->state != SIW_EPSTATE_RECVD_MPAREQ) {
 		siw_dbg_cep(cep, "out of state\n");
 
-		siw_cep_set_free(cep);
-		siw_cep_put(cep); /* put last reference */
+		siw_cep_set_free_and_put(cep); /* put last reference */
 
 		return -ECONNRESET;
 	}
@@ -1753,8 +1753,7 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
 
 	cep->state = SIW_EPSTATE_CLOSED;
 
-	siw_cep_set_free(cep);
-	siw_cep_put(cep);
+	siw_cep_set_free_and_put(cep);
 
 	return 0;
 }
@@ -1889,8 +1888,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		siw_socket_disassoc(s);
 		cep->state = SIW_EPSTATE_CLOSED;
 
-		siw_cep_set_free(cep);
-		siw_cep_put(cep);
+		siw_cep_set_free_and_put(cep);
 	}
 	sock_release(s);
 
@@ -1924,8 +1922,7 @@ static void siw_drop_listeners(struct iw_cm_id *id)
 			cep->sock = NULL;
 		}
 		cep->state = SIW_EPSTATE_CLOSED;
-		siw_cep_set_free(cep);
-		siw_cep_put(cep);
+		siw_cep_set_free_and_put(cep);
 	}
 }
 
-- 
2.35.3

