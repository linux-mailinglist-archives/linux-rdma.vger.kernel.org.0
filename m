Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD85626D35
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiKMBIo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiKMBIn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:43 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4027FF10
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Z8HcS3vIAvBjetIAExa7JzZ0F7cUD0/OVS09XoyQLM=;
        b=XA7MlO0wtJ0YSJwnhiWVp3swXplIwkmpgYoYFO0UMtNJOv9rtWaORtD10CCwjy841qtez6
        mfI/wnivJj3wOwWE80HWkziGKYB48lgRnB/wbfMK7uSsNSmnlJWv5ET2pg74AgCr18iGqI
        tV0VJhALFiHIty9JU1d3rIAG4H9AJuQ=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 03/12] RDMA/rtrs-srv: Only close srv_path if it is just allocated
Date:   Sun, 13 Nov 2022 09:08:14 +0800
Message-Id: <20221113010823.6436-4-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-1-guoqing.jiang@linux.dev>
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RTRS creates several connections per nr_cpu_ids, it makes more sense
to only close the path when it just allocated.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 2cc8b423bcaa..063082d29fc6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1833,6 +1833,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	u16 version, con_num, cid;
 	u16 recon_cnt;
 	int err = -ECONNRESET;
+	bool alloc_path = false;
 
 	if (len < sizeof(*msg)) {
 		pr_err("Invalid RTRS connection request\n");
@@ -1906,6 +1907,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 			pr_err("RTRS server session allocation failed: %d\n", err);
 			goto reject_w_err;
 		}
+		alloc_path = true;
 	}
 	err = create_con(srv_path, cm_id, cid);
 	if (err) {
@@ -1940,7 +1942,8 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 
 close_and_return_err:
 	mutex_unlock(&srv->paths_mutex);
-	close_path(srv_path);
+	if (alloc_path)
+		close_path(srv_path);
 
 	return err;
 }
-- 
2.31.1

