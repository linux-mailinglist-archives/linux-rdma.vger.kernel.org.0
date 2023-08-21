Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A14782A93
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 15:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjHUNdT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbjHUNdT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 09:33:19 -0400
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1025CCE
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 06:33:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692624794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vyFPohoQXUX2vZlzeGQ6mOJ9HmEY3YCtTyh1Sl2Ejrc=;
        b=kmYmRkzhNocFohK1d73rYRMKnaSRZy6BMDDowcD5lo2yDVSNoPns/MciNdIv/kJEcj9PNu
        zCT7OIWR6StFpehEQl5skHQ3u1ypRFWHRNoVMl5n5vuTNYAl73v28uef2EasnauRd+wBpS
        ZL5fGHOeSo3R3lXY1zzGHohFF+QkHVI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V3 3/3] RDMA/siw: Call llist_reverse_order in siw_run_sq
Date:   Mon, 21 Aug 2023 21:32:55 +0800
Message-Id: <20230821133255.31111-4-guoqing.jiang@linux.dev>
In-Reply-To: <20230821133255.31111-1-guoqing.jiang@linux.dev>
References: <20230821133255.31111-1-guoqing.jiang@linux.dev>
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

We can call the function to get fifo list.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 3ff339eceec3..60b6a4135961 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1271,13 +1271,7 @@ int siw_run_sq(void *data)
 		 * llist_del_all returns a list with newest entry first.
 		 * Re-order list for fairness among QP's.
 		 */
-		while (active) {
-			struct llist_node *tmp = active;
-
-			active = llist_next(active);
-			tmp->next = fifo_list;
-			fifo_list = tmp;
-		}
+		fifo_list = llist_reverse_order(active);
 		while (fifo_list) {
 			qp = container_of(fifo_list, struct siw_qp, tx_list);
 			fifo_list = llist_next(fifo_list);
-- 
2.35.3

