Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843607D8D22
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 04:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345160AbjJ0Cdz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 22:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbjJ0Cdy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 22:33:54 -0400
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366D89D
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 19:33:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698374029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rj9GWYbf0/xeL6NAtALOrhxpB+XXBxKjFjdVX9zOhAw=;
        b=UgPTeNBSqxEj991+EW6x8ioPzUbGFF2y87SdT8V12zJgCKomvsfk/tM9V2dZcrG0U3IONP
        TeCOXg8JmYdoCYflnO49FYWsb4ZPF2snQFb2VvUnwZV2S7k6s8dP3y4AHaNSdve/X0TUqz
        63c9NWv+WA7EBLL2BJn2fVXdqkbV2IM=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V3 05/18] RDMA/siw: Remove rcu from siw_qp
Date:   Fri, 27 Oct 2023 10:33:15 +0800
Message-Id: <20231027023328.30347-6-guoqing.jiang@linux.dev>
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

Remove it since it is not used.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index cec5cccd2e75..44684b74550f 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -466,7 +466,6 @@ struct siw_qp {
 	} term_info;
 	struct rdma_user_mmap_entry *sq_entry; /* mmap info for SQE array */
 	struct rdma_user_mmap_entry *rq_entry; /* mmap info for RQE array */
-	struct rcu_head rcu;
 };
 
 /* helper macros */
-- 
2.35.3

