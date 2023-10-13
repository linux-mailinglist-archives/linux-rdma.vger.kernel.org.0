Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801CC7C7B71
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjJMCBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjJMCBc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:32 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [IPv6:2001:41d0:1004:224b::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A66102
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:26 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKQa+R1REIKipzTiLjI8SnNBLzjN30yxHvVwRNoZgRc=;
        b=H5yWbR1lKGnesz7smJPE8hAWP++G1q6xtriV4Ns+W507YS2qClTK2eTGZ5cNTZfnknAXzP
        0gGR12PMUrDdNQbPOIAIB2oyq9mdMYVK9Vd19Bs12J/qIPypPoMhuny+fkSwWXW9zKRJ7Y
        pTfIkiyPdoqj/Fon87kG4CcrFtruxxM=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 19/20] RDMA/siw: Introduce siw_destroy_cep_sock
Date:   Fri, 13 Oct 2023 10:00:52 +0800
Message-Id: <20231013020053.2120-20-guoqing.jiang@linux.dev>
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

Add one helper to simplify code a bit.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310091735.oG7bTvLR-lkp@intel.com/`
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index be0d09d18a4f..4b3fde6ca9ca 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -368,6 +368,15 @@ static void siw_free_cm_id(struct siw_cep *cep, bool put_cep)
 		siw_cep_put(cep);
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
@@ -1682,9 +1684,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 error_unlock:
 	up_write(&qp->state_lock);
 error:
-	siw_socket_disassoc(cep->sock);
-	sock_release(cep->sock);
-	cep->sock = NULL;
+	siw_destroy_cep_sock(cep);
 
 	cep->state = SIW_EPSTATE_CLOSED;
 
@@ -1729,9 +1729,7 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
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

