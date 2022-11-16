Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BBA62BB89
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 12:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiKPLYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 06:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiKPLYZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 06:24:25 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B9C7
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 03:14:25 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668597263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ib1XUo+wv5o4JplHHYKeiuftkEu3GWDRt+LR8ytKGrM=;
        b=UuTDupcDYjuhh6b9FYiyfT570nA293NYG0xuf5MDfQGFwvQaNYVGbWjrx9elYzxQlaC/ni
        0g8ITJIXXSYk3CiOixF60VnwNcyhWKt2F49aUQKB2B0kl2ESp2pH8NDOA/yRXvoM6WdYw1
        LBUC4zqxHE6lMTMO+YCBzy+cbRdmlcc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 3/8] RDMA/rtrs-srv: Correct the checking of ib_map_mr_sg
Date:   Wed, 16 Nov 2022 19:13:55 +0800
Message-Id: <20221116111400.7203-4-guoqing.jiang@linux.dev>
In-Reply-To: <20221116111400.7203-1-guoqing.jiang@linux.dev>
References: <20221116111400.7203-1-guoqing.jiang@linux.dev>
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

We should check with nr_sgt, also the only successful case is that
all sg elements are mapped, so make it explict.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index b877dd57b6b9..581c850e71d6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -622,7 +622,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 		}
 		nr = ib_map_mr_sg(mr, sgt->sgl, nr_sgt,
 				  NULL, max_chunk_size);
-		if (nr < 0 || nr < sgt->nents) {
+		if (nr != nr_sgt) {
 			err = nr < 0 ? nr : -EINVAL;
 			goto dereg_mr;
 		}
-- 
2.31.1

