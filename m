Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AE67D8D29
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 04:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjJ0CeD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 22:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345181AbjJ0CeC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 22:34:02 -0400
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC461B8
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 19:33:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698374037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTjTAX/2ceVf1pC6BUnUZu3MK3X1dDKElWYejN/GcRQ=;
        b=BjF6R7fP9PlEzki9N9bT/iUFWw2WVG8HHmE3Af+op+u92OM70xd5zAxRtjDnq4ADDUazL9
        YAZKfTHDfg2A+WOci723ap7ZfZLP6uRiPa+gA/uLcPddb0aSJunshIW+hEdfY3R/+cgwqy
        4DI6cWP/8Vb99pSniO+X4JTHGlLcrk0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V3 12/18] RDMA/siw: Introduce siw_free_cm_id
Date:   Fri, 27 Oct 2023 10:33:22 +0800
Message-Id: <20231027023328.30347-13-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-1-guoqing.jiang@linux.dev>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/infiniband/sw/siw/siw_cm.c | 34 +++++++++++++-----------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 2f338bb3a24c..1d2438fbf7c7 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -364,6 +364,15 @@ static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 	return id->event_handler(id, &event);
 }
 
+static void siw_free_cm_id(struct siw_cep *cep)
+{
+	if (!cep->cm_id)
+		return;
+
+	cep->cm_id->rem_ref(cep->cm_id);
+	cep->cm_id = NULL;
+}
+
 /*
  * siw_qp_cm_drop()
  *
@@ -415,8 +424,7 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
 			default:
 				break;
 			}
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
+			siw_free_cm_id(cep);
 			siw_cep_put(cep);
 		}
 		cep->state = SIW_EPSTATE_CLOSED;
@@ -1175,11 +1183,8 @@ static void siw_cm_work_handler(struct work_struct *w)
 			sock_release(cep->sock);
 			cep->sock = NULL;
 		}
-		if (cep->cm_id) {
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-			siw_cep_put(cep);
-		}
+		siw_free_cm_id(cep);
+		siw_cep_put(cep);
 	}
 	siw_cep_set_free(cep);
 	siw_put_work(work);
@@ -1702,10 +1707,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 	cep->state = SIW_EPSTATE_CLOSED;
 
-	if (cep->cm_id) {
-		cep->cm_id->rem_ref(id);
-		cep->cm_id = NULL;
-	}
+	siw_free_cm_id(cep);
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
+		siw_free_cm_id(cep);
 		cep->sock = NULL;
 		siw_socket_disassoc(s);
 		cep->state = SIW_EPSTATE_CLOSED;
@@ -1912,10 +1911,7 @@ static void siw_drop_listeners(struct iw_cm_id *id)
 
 		siw_cep_set_inuse(cep);
 
-		if (cep->cm_id) {
-			cep->cm_id->rem_ref(cep->cm_id);
-			cep->cm_id = NULL;
-		}
+		siw_free_cm_id(cep);
 		if (cep->sock) {
 			siw_socket_disassoc(cep->sock);
 			sock_release(cep->sock);
-- 
2.35.3

