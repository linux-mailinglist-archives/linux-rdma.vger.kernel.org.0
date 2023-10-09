Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99397BD43D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjJIHZd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjJIHZd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:25:33 -0400
Received: from out-196.mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4ABC5
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:25:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPwcpA7//dIbTt1g4Eq45TjqQVUmQdS+9/pDuCW7ADw=;
        b=ugbu8LWNi8MPNKnyDnmB+HWxTHcJswZ9x6I4XLBKjd1JrF0dd5FDzNaXFgcIUoVmGQRNkG
        qKRfE4FHkwB0cCNGqSdzF2Ie72J2jAdQpH4TQxposZ/nE1KGp5RU+SmG1fm+z5ztjyIcSQ
        Nlerj9dS8vvYravUVgx4AA/R4caTgIo=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 07/19] RDMA/siw: Also goto out_sem_up if pin_user_pages returns 0
Date:   Mon,  9 Oct 2023 15:17:49 +0800
Message-Id: <20231009071801.10210-8-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-1-guoqing.jiang@linux.dev>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
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

Since it is legitimate for pin_user_pages returns 0, which
means it might be dead loop here.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index c5f7f1669d09..92c5776a9eed 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -423,7 +423,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 		while (nents) {
 			rv = pin_user_pages(first_page_va, nents, foll_flags,
 					    plist);
-			if (rv < 0)
+			if (rv <= 0)
 				goto out_sem_up;
 
 			umem->num_pages += rv;
-- 
2.35.3

