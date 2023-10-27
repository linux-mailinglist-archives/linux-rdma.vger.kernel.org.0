Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9767D8D2D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 04:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbjJ0CeM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 22:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345183AbjJ0CeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 22:34:12 -0400
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [IPv6:2001:41d0:203:375::ba])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E11D6A
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 19:34:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698374042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODcLlWj1fvF2UtTDHuFH4QAZbt0O2LRobAg9Cfb2evk=;
        b=G4K61N9bOdpZqBK9d2PBtpQCzqnrQlmFeqKDbWNsmNGabbcCO0sH50l5PMPCYqNwaal3zA
        n+30zI8IQQtql/c5gjwX/8Tr4w0FujdcUms3/PR5oJ3ov3S0LcffnZFhw1tA3KxDZ9q+uv
        lrsCBUgzq3kBQ7J/7Jy5syRtAYO6BK4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V3 16/18] RDMA/siw: Only check attrs->cap.max_send_wr in siw_create_qp
Date:   Fri, 27 Oct 2023 10:33:26 +0800
Message-Id: <20231027023328.30347-17-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-1-guoqing.jiang@linux.dev>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
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

We can just check max_send_wr here given both max_send_wr and
max_recv_wr are defined as u32 type, and we also need to ensure
num_sqe (derived from max_send_wr) shouldn't be zero.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index dcd69fc01176..ef149ed98946 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -333,11 +333,10 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		goto err_atomic;
 	}
 	/*
-	 * NOTE: we allow for zero element SQ and RQ WQE's SGL's
-	 * but not for a QP unable to hold any WQE (SQ + RQ)
+	 * NOTE: we don't allow for a QP unable to hold any SQ WQE
 	 */
-	if (attrs->cap.max_send_wr + attrs->cap.max_recv_wr == 0) {
-		siw_dbg(base_dev, "QP must have send or receive queue\n");
+	if (attrs->cap.max_send_wr == 0) {
+		siw_dbg(base_dev, "QP must have send queue\n");
 		rv = -EINVAL;
 		goto err_atomic;
 	}
@@ -357,21 +356,14 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	if (rv)
 		goto err_atomic;
 
-	num_sqe = attrs->cap.max_send_wr;
-	num_rqe = attrs->cap.max_recv_wr;
 
 	/* All queue indices are derived from modulo operations
 	 * on a free running 'get' (consumer) and 'put' (producer)
 	 * unsigned counter. Having queue sizes at power of two
 	 * avoids handling counter wrap around.
 	 */
-	if (num_sqe)
-		num_sqe = roundup_pow_of_two(num_sqe);
-	else {
-		/* Zero sized SQ is not supported */
-		rv = -EINVAL;
-		goto err_out_xa;
-	}
+	num_sqe = roundup_pow_of_two(attrs->cap.max_send_wr);
+	num_rqe = attrs->cap.max_recv_wr;
 	if (num_rqe)
 		num_rqe = roundup_pow_of_two(num_rqe);
 
-- 
2.35.3

