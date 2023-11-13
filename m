Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D429E7E9BA0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjKML6D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjKML6C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:58:02 -0500
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [IPv6:2001:41d0:203:375::ba])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E6F10D8
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=093OfUVDdBBTiCgvA/nFAiOloFLH2LiE4+GRE+ZYc1Y=;
        b=q9vohHMYauAPyICkusmrb4u76BbAt197viVew3cslWO4kvRtW8t3oR4TMEUE+MQuatlC2A
        0CLslRhIeEsukI1KL0g2lcWM+eYoX44nSLy0sOxufBw1y/U6JEYDXIvRyDAQhorHPUu52k
        MtfsV3lRxDwyWX2tcz9aL8PaEtYyNw4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 16/17] RDMA/siw: Introduce siw_destroy_cep_sock
Date:   Mon, 13 Nov 2023 19:57:25 +0800
Message-Id: <20231113115726.12762-17-guoqing.jiang@linux.dev>
In-Reply-To: <20231113115726.12762-1-guoqing.jiang@linux.dev>
References: <20231113115726.12762-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add one helper to simplify code a bit.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310091735.oG7bTvLR-lkp@intel.com/`
Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 5c0f9f8bf3db..86323918a570 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -367,6 +367,15 @@ static void siw_free_cm_id(struct siw_cep *cep)
 	cep->cm_id = NULL;
 }
 
+static void siw_destroy_cep_sock(struct siw_cep *cep)
+{
+	if (cep->sock) {
+		siw_socket_disassoc(cep->sock);
+		sock_release(cep->sock);
+		cep->sock = NULL;
+	}
+}
+
 /*
  * siw_qp_cm_drop()
  *
@@ -423,14 +432,7 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
 		}
 		cep->state = SIW_EPSTATE_CLOSED;
 
-		if (cep->sock) {
-			siw_socket_disassoc(cep->sock);
-			/*
-			 * Immediately close socket
-			 */
-			sock_release(cep->sock);
-			cep->sock = NULL;
-		}
+		siw_destroy_cep_sock(cep);
 		if (cep->qp) {
 			cep->qp = NULL;
 			siw_qp_put(qp);
@@ -1693,9 +1695,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 error_unlock:
 	up_write(&qp->state_lock);
 error:
-	siw_socket_disassoc(cep->sock);
-	sock_release(cep->sock);
-	cep->sock = NULL;
+	siw_destroy_cep_sock(cep);
 
 	cep->state = SIW_EPSTATE_CLOSED;
 
@@ -1740,9 +1740,7 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
 		cep->mpa.hdr.params.bits |= MPA_RR_FLAG_REJECT; /* reject */
 		siw_send_mpareqrep(cep, pdata, pd_len);
 	}
-	siw_socket_disassoc(cep->sock);
-	sock_release(cep->sock);
-	cep->sock = NULL;
+	siw_destroy_cep_sock(cep);
 
 	cep->state = SIW_EPSTATE_CLOSED;
 
-- 
2.35.3

