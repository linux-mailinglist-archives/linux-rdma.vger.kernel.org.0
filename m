Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7157BD42F
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjJIHTj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjJIHTg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:19:36 -0400
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 00:19:34 PDT
Received: from out-203.mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C97DAB
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:19:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wujTffIEecs1ht0iu1YMc8xbjSYOZ3awSnCr40P5Be4=;
        b=fbtXtPMMnZ7yVS/3nqy48IT1FbCzGJlEdSPcYgrAUiRmCj02rUPw3JKQPDlv6dJ/MqdL1a
        HgDjKYma/uqze1JZLuRNQWtHl5SyeVGzG6MJnX3Qhe06Op10rWnXZ3AYEU6xOaijC/CPyU
        sE/HwpHqflSMo8IfZoXWdPnORV9oaCc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 06/19] RDMA/siw: No need to check term_info.valid before call siw_send_terminate
Date:   Mon,  9 Oct 2023 15:17:48 +0800
Message-Id: <20231009071801.10210-7-guoqing.jiang@linux.dev>
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

Remove the redundate checking since siw_send_terminate check it inside.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 0a1525d76ba1..c8a9118677d7 100644
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
@@ -1060,7 +1059,7 @@ static void siw_cm_work_handler(struct work_struct *w)
 		/*
 		 * QP scheduled LLP close
 		 */
-		if (cep->qp && cep->qp->term_info.valid)
+		if (cep->qp)
 			siw_send_terminate(cep->qp);
 
 		if (cep->cm_id)
-- 
2.35.3

