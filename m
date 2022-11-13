Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670E5626D38
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiKMBIw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiKMBIu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:50 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C86AF10
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:49 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4DtlP1JN+qdU0xxBuwRmh7eGTK3TyecdbhgMfnjsW9Q=;
        b=uvyQnqkp+19DCKWCE7gO2R52mMYRWCsCJ0/zgO/q70R7MiI957h+biMvLNapHqA/EJ5sDs
        +fhAWFXm/6tchqIAhLVbPKFiUawBxFzREmIR2/ft045+8EBL5MFJH1FUfbuNchjrht1NH9
        wCFSYgoHstSOzwVGLeHh+XPQOWWf6rA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 06/12] RDMA/rtrs-clt: Correct the checking of ib_map_mr_sg
Date:   Sun, 13 Nov 2022 09:08:17 +0800
Message-Id: <20221113010823.6436-7-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-1-guoqing.jiang@linux.dev>
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
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
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 8546b8816524..5ffc170dae8c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1064,9 +1064,7 @@ static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
 
 	/* Align the MR to a 4K page size to match the block virt boundary */
 	nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
-	if (nr < 0)
-		return nr;
-	if (nr < req->sg_cnt)
+	if (nr != count)
 		return -EINVAL;
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
 
-- 
2.31.1

