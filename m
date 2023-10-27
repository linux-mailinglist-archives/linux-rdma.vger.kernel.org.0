Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534347D8D2C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjJ0CeK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 22:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbjJ0CeJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 22:34:09 -0400
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87EFD57
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 19:34:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698374041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqzVk0g8Y9DUsu/VIvpsvRUP/n+3u1R+XtNNJGrn9B8=;
        b=EFj6VN74vygLXDUVPQZtlokHnuesWuqCmiPMqBjuGIwgtjorR2quF4SZyXa/MyKsa9YbTI
        K4IS/dR4jblv+9zACyuraOy7hHeMaxN7obIdajChEqc4A0h8e1+WtvQhlL6LFSGDtqT508
        zwrYFrpLMAwR/d7krY96BFLkszgEOyI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V3 15/18] RDMA/siw: Fix typo
Date:   Fri, 27 Oct 2023 10:33:25 +0800
Message-Id: <20231027023328.30347-16-guoqing.jiang@linux.dev>
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

Replace ORRQ with ORQ.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 26e3904d2f41..da92cfa2073d 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1183,7 +1183,7 @@ int siw_rqe_complete(struct siw_qp *qp, struct siw_rqe *rqe, u32 bytes,
 /*
  * siw_sq_flush()
  *
- * Flush SQ and ORRQ entries to CQ.
+ * Flush SQ and ORQ entries to CQ.
  *
  * Must be called with QP state write lock held.
  * Therefore, SQ and ORQ lock must not be taken.
-- 
2.35.3

