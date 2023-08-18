Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FB778070F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Aug 2023 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358555AbjHRIXs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Aug 2023 04:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358565AbjHRIXe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Aug 2023 04:23:34 -0400
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458BF123
        for <linux-rdma@vger.kernel.org>; Fri, 18 Aug 2023 01:23:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692347011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5M4QXE5ozUxDPBFnbphCS0MPQSlJU0iFr+8QwMweGyU=;
        b=HDsb0ny8Ox3uS0yhY/Im96B4Ow3MwtplvcjLKLM4M9TFkK6ItwPgER3toX0pZ7C5btt0a5
        RFGQw21vlLSkzlPjofIbXKM99uHzmk/ez37LbsDuXAwr4jUc4rEbk4zhnxmrsyzrVtd7qr
        mCvzbL3w6Snias93VIpwnfaP7BE6+TQ=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 2/3] RDMA/siw: Correct wrong debug message
Date:   Fri, 18 Aug 2023 16:23:17 +0800
Message-Id: <20230818082318.17489-3-guoqing.jiang@linux.dev>
In-Reply-To: <20230818082318.17489-1-guoqing.jiang@linux.dev>
References: <20230818082318.17489-1-guoqing.jiang@linux.dev>
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

We need to print num_sle first then pbl->max_buf per the condition.
Also replace mem->pbl with pbl while at it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index fadfa70853f3..fdbef3254e30 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1494,7 +1494,7 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 
 	if (pbl->max_buf < num_sle) {
 		siw_dbg_mem(mem, "too many SGE's: %d > %d\n",
-			    mem->pbl->max_buf, num_sle);
+			    num_sle, pbl->max_buf);
 		return -ENOMEM;
 	}
 	for_each_sg(sl, slp, num_sle, i) {
-- 
2.35.3

