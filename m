Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D900D7825C8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjHUIsk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 04:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjHUIsk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 04:48:40 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [IPv6:2001:41d0:1004:224b::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A76BE
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 01:48:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692607716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NyFZ1sD2iTdYpLArvdepAyLloMroG5RsWMxq3EsbDSM=;
        b=RJGdIaiOAw+UB2hQYfVrVqd0AVqzbPctNxj7viDx+HW4HniYCA3hloOVPpmH26VA6hiuct
        LSadiSxRlhx8DgVgELyJ496ie4z98wecsE2cD0kXts+azw5GshITjgo48msReSi2AbzSqt
        Y5Cn3Ga0CS8NNTWNhkgtYni6jW8crDs=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 3/3] RDMA/siw: Call llist_reverse_order in siw_run_sq
Date:   Mon, 21 Aug 2023 16:47:43 +0800
Message-Id: <20230821084743.6489-4-guoqing.jiang@linux.dev>
In-Reply-To: <20230821084743.6489-1-guoqing.jiang@linux.dev>
References: <20230821084743.6489-1-guoqing.jiang@linux.dev>
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
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 4b292e0504f1..eb3d438828e2 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1229,17 +1229,7 @@ int siw_run_sq(void *data)
 			break;
 
 		active = llist_del_all(&tx_task->active);
-		/*
-		 * llist_del_all returns a list with newest entry first.
-		 * Re-order list for fairness among QP's.
-		 */
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

