Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C757C7B6E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjJMCBc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjJMCB3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:29 -0400
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [91.218.175.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E71E8
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LK7F9P5+OmxBsPvOJN5BisChQG9BHSV1YJu1gEVwmX4=;
        b=k2dpQiSbmFfW92oOcHj+1GB789mO/NVqYRGlsqqpUgktOtzltShKC8EWQo8uSu9Bm7UMiA
        fDb+6HnjAjQZnrx1wH5Bzr5pMNtELYSapI246Ic7GVsd8IRqbnmgpLy1nzKMUSshKY4byc
        vOv4MqRWUH40pvzYyWAchzqJk+ZowwY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 17/20] RDMA/siw: Fix typo
Date:   Fri, 13 Oct 2023 10:00:50 +0800
Message-Id: <20231013020053.2120-18-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-1-guoqing.jiang@linux.dev>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace ORRQ with ORQ.

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

