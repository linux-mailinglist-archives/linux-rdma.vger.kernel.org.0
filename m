Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2E62BB8A
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 12:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiKPLYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 06:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbiKPLYZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 06:24:25 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57F6566
        for <linux-rdma@vger.kernel.org>; Wed, 16 Nov 2022 03:14:27 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668597265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5H/X2UQ0Gbme25pWm1XGMxyazyDyf9dS+RJ1xBFv0k=;
        b=WXRN/mL2IXDPj47gNPPVKsjlviCxhCsCKiYYeZTSZXz5cjXkaiWIe9aZy/iHYAENahigWq
        mKMne7DCaaJpEDRrsAArIYpnrae1i9VGqjP9ZjXs8RdK9EAwy17txBWrPugx2/vsAY7kD/
        J6HaNTA+B9p8zmluixS6VlRVdvAOxx0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 4/8] RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
Date:   Wed, 16 Nov 2022 19:13:56 +0800
Message-Id: <20221116111400.7203-5-guoqing.jiang@linux.dev>
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

We should check with count, also the only successful case is that
all sg elements are mapped, so make it explict.

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

