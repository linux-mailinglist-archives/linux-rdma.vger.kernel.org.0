Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96F7E9B95
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjKML5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjKML5q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:57:46 -0500
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE74D76
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwAmrtgBbD8ru74vckt+dlu6o/S/c4UhLaaOEdqZ8Gw=;
        b=Ku/aY5rTICapogYl4hpRXcPKG2yGOzp23AEDjcv1uETgzE+gDpC5fUH1tAM721ad2jB3Xp
        BjeRZbzduRfG2g5TKXNP45UO8G5Q5GieVYjXLH/lOZZN5fPZGDYRx4CrpYRQeQ3ZMHIrgx
        GhbTReqEQnfHQHLTwprlSkRQQU8J+LE=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 06/17] RDMA/siw: No need to check term_info.valid before call siw_send_terminate
Date:   Mon, 13 Nov 2023 19:57:15 +0800
Message-Id: <20231113115726.12762-7-guoqing.jiang@linux.dev>
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

Remove the redundate checking since siw_send_terminate check it inside.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 7de651cb44e8..5e6e57153611 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -393,8 +393,7 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
 		}
 		siw_dbg_cep(cep, "immediate close, state %d\n", cep->state);
 
-		if (qp->term_info.valid)
-			siw_send_terminate(qp);
+		siw_send_terminate(qp);
 
 		if (cep->cm_id) {
 			switch (cep->state) {
@@ -1061,7 +1060,7 @@ static void siw_cm_work_handler(struct work_struct *w)
 		/*
 		 * QP scheduled LLP close
 		 */
-		if (cep->qp && cep->qp->term_info.valid)
+		if (cep->qp)
 			siw_send_terminate(cep->qp);
 
 		if (cep->cm_id)
-- 
2.35.3

