Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A139B7D99C8
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 15:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345939AbjJ0N1e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 09:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345959AbjJ0N1c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 09:27:32 -0400
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3271FD4F
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 06:27:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698413247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xCg/5jSoczTVwvo6IYS0olL8TesflugLQXSWq7cYsU=;
        b=aMa03M2tscTdFkdhzWe7FL3sP19JjbYcdjTjMYshjnscAA1iDkerTWT1QR4PXpTtyYctlF
        wvbRtPg8sp57jt9J7saT/H7GKuJkkYs3rg5w9gntETHILR9jcj/8R6EAlujRdEfOVNOvBo
        raHcn7HVrIeXToh6cnWRy754+wEbD7g=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V4 17/18] RDMA/siw: Introduce siw_destroy_cep_sock
Date:   Fri, 27 Oct 2023 21:26:43 +0800
Message-Id: <20231027132644.29347-18-guoqing.jiang@linux.dev>
In-Reply-To: <20231027132644.29347-1-guoqing.jiang@linux.dev>
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 84882a8c75d1..e94d1a1f8edf 100644
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
@@ -1685,9 +1687,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 error_unlock:
 	up_write(&qp->state_lock);
 error:
-	siw_socket_disassoc(cep->sock);
-	sock_release(cep->sock);
-	cep->sock = NULL;
+	siw_destroy_cep_sock(cep);
 
 	cep->state = SIW_EPSTATE_CLOSED;
 
@@ -1732,9 +1732,7 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
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

