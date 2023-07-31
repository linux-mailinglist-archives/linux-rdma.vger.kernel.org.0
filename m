Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804A576919A
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjGaJYG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 05:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjGaJXp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 05:23:45 -0400
Received: from out-72.mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82D30CD
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 02:21:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690795273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LIKn10Fhh31erLFzLf1Y1vpjnOwJeXZwC2wmBOwr+xY=;
        b=t5B4WFP2AT83+AgFkzVgH671ejXa6aNhrA1qzOXnQfhFvUi9dFYjgiU83BTIVX5uJUUgl8
        LJyPcefE3R1ullOCmSoyrJka+FeunUlV2hKgDVQLt4daj+g0ErhQ6SXAndr9PijA3AR4CC
        PsoP2Dcq/JVyMuPZ7hx15FShHgKCLbg=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bharat@chelsio.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/cxgb4: Set sq_sig_type correctly
Date:   Mon, 31 Jul 2023 17:21:06 +0800
Message-Id: <20230731092106.10396-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace '0' with IB_SIGNAL_REQ_WR given the sq_sig_type is either
IB_SIGNAL_ALL_WR or IB_SIGNAL_REQ_WR per the below.

enum ib_sig_type {
	IB_SIGNAL_ALL_WR,
	IB_SIGNAL_REQ_WR
};

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/hw/cxgb4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index ffbd9a89981e..d16d8eaa1415 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2466,7 +2466,7 @@ int c4iw_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	init_attr->cap.max_send_sge = qhp->attr.sq_max_sges;
 	init_attr->cap.max_recv_sge = qhp->attr.rq_max_sges;
 	init_attr->cap.max_inline_data = T4_MAX_SEND_INLINE;
-	init_attr->sq_sig_type = qhp->sq_sig_all ? IB_SIGNAL_ALL_WR : 0;
+	init_attr->sq_sig_type = qhp->sq_sig_all ? IB_SIGNAL_ALL_WR : IB_SIGNAL_REQ_WR;
 	return 0;
 }
 
-- 
2.34.1

