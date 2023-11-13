Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE67E9B9F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjKML6D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjKML6C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:58:02 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854BD6C
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:57 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFFHMQnrThnc9KPsWFMpuMTID5pqFyjGybju6Mywwt0=;
        b=iW3HaR41/5ZorICz89nekyfQptBs0ynIlBr0qlbISDb8jfyg63gQ5bf6wgm7aFq3qUygNM
        XJDiXAaYX0ADVEVnorW7QFmYpiYGbtcjb1fyaZdlUd0RfftJvulwYSYf7/PQeztOkaSeXQ
        B736QGLJ8el4ldNpLX35fM0htk3YiCI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 17/17] RDMA/siw: Update comments for siw_qp_sq_process
Date:   Mon, 13 Nov 2023 19:57:26 +0800
Message-Id: <20231113115726.12762-18-guoqing.jiang@linux.dev>
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

There is no siw_sq_work_handler in code, change it with siw_tx_thread
since siw_run_sq -> siw_sq_resume -> siw_qp_sq_process.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 838123c621e2..64ad9e0895bd 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -997,13 +997,12 @@ static int siw_qp_sq_proc_local(struct siw_qp *qp, struct siw_wqe *wqe)
  * MPA FPDUs, each containing a DDP segment.
  *
  * SQ processing may occur in user context as a result of posting
- * new WQE's or from siw_sq_work_handler() context. Processing in
+ * new WQE's or from siw_tx_thread context. Processing in
  * user context is limited to non-kernel verbs users.
  *
  * SQ processing may get paused anytime, possibly in the middle of a WR
  * or FPDU, if insufficient send space is available. SQ processing
- * gets resumed from siw_sq_work_handler(), if send space becomes
- * available again.
+ * gets resumed from siw_tx_thread, if send space becomes available again.
  *
  * Must be called with the QP state read-locked.
  *
-- 
2.35.3

