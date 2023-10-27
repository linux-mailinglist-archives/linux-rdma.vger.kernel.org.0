Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060927D99C9
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345943AbjJ0N1f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbjJ0N1c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 09:27:32 -0400
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB5E1B1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 06:27:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698413249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28RatEj15pC9OKwOkgMrqOKV7rukYceLBZqh8TknWH4=;
        b=BdeDujQq98L5uRxE3GWfE/Uv12ZsppqNA9vSrgGy0zRLCACArpA64qu7rHSy1kISG0CT7H
        0jDASanxS9BXuFHU2aZT1Ljx9Rf0F47lGwMlJGhGxkfUr15f3en0vc1nfie0s8liZ4xS9Z
        Vy6wTKNyJciw+Lgr7yTmSCHTBte+JF8=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V4 18/18] RDMA/siw: Update comments for siw_qp_sq_process
Date:   Fri, 27 Oct 2023 21:26:44 +0800
Message-Id: <20231027132644.29347-19-guoqing.jiang@linux.dev>
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

There is no siw_sq_work_handler in code, change it with siw_tx_thread
since siw_run_sq -> siw_sq_resume -> siw_qp_sq_process.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
Change since last version.
1. change the patch header a little.

 drivers/infiniband/sw/siw/siw_qp_tx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 2e055b6dcd42..553d85cb6dbb 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1001,13 +1001,12 @@ static int siw_qp_sq_proc_local(struct siw_qp *qp, struct siw_wqe *wqe)
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

