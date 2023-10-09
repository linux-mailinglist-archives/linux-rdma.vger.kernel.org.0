Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E87BD442
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbjJIHZg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345393AbjJIHZe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:25:34 -0400
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414ACC6
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:25:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qflpQaitBDlH+e6lWOqOg5FpkZbQjqOiPiAvj1dqDSo=;
        b=kTwGYyYhzGARfvhljddZRnvRrD9q0o0j8cpsyD0Cz8dvU+fxLwCiAIzjCkeB4Gh1VONtcL
        K//gGGJMnYdeL3tvQ2sBwplYZui6RA1Dz8HE4eB7OCyq+XjSdYK3v/lKa06eCncrA8PCvh
        PM5V8dAkX2CIa7EXJG35P80M1j3La7g=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 13/19] RDMA/siw: Simplify siw_qp_id2obj
Date:   Mon,  9 Oct 2023 15:17:55 +0800
Message-Id: <20231009071801.10210-14-guoqing.jiang@linux.dev>
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

Let's set qp and return it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 44684b74550f..e127ef493296 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -601,12 +601,10 @@ static inline struct siw_qp *siw_qp_id2obj(struct siw_device *sdev, int id)
 
 	rcu_read_lock();
 	qp = xa_load(&sdev->qp_xa, id);
-	if (likely(qp && kref_get_unless_zero(&qp->ref))) {
-		rcu_read_unlock();
-		return qp;
-	}
+	if (likely(qp && !kref_get_unless_zero(&qp->ref)))
+		qp = NULL;
 	rcu_read_unlock();
-	return NULL;
+	return qp;
 }
 
 static inline u32 qp_id(struct siw_qp *qp)
-- 
2.35.3

