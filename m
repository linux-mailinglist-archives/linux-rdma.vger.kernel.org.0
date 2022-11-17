Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AEB62D7E1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 11:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbiKQKUB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 05:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbiKQKUA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 05:20:00 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F4E4D5FA
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 02:19:59 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668680398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1PYAswUYGnFu0EfpEJNlAFC0ZWDpLicT0Vh8aslYXlk=;
        b=Yt7iDEpHXmArSwProgegeNTPNCBxVNCPAhHXXMS2+bvyLZnja6eSJUai+jaUgMNspJwt3j
        1P3FP8NXlBb34Nd7TXj6BlMYf4C+FLWVVnDH0uHVwSiTK1vohcJfnc7mVl+D9j+rwJAtKY
        dmR3VECbIqOUKDU8iYH2zXC351072Oc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 4/8] RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
Date:   Thu, 17 Nov 2022 18:19:41 +0800
Message-Id: <20221117101945.6317-5-guoqing.jiang@linux.dev>
In-Reply-To: <20221117101945.6317-1-guoqing.jiang@linux.dev>
References: <20221117101945.6317-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We should check with count, also the only successful case is that
all sg elements are mapped, so make it explicitly.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 8546b8816524..be7c8480f947 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1064,10 +1064,8 @@ static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
 
 	/* Align the MR to a 4K page size to match the block virt boundary */
 	nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
-	if (nr < 0)
-		return nr;
-	if (nr < req->sg_cnt)
-		return -EINVAL;
+	if (nr != count)
+		return nr < 0 ? nr : -EINVAL;
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
 
 	return nr;
-- 
2.31.1

