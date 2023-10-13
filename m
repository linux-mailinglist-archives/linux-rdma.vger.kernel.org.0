Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC447C7B67
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjJMCB0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJMCBW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:22 -0400
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8FFDE
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qflpQaitBDlH+e6lWOqOg5FpkZbQjqOiPiAvj1dqDSo=;
        b=P2sq5VP/3PVToYIkt3p7okPqA7fW1SlmucmMz2CCb8u4QBxlqYuotYef983tXDPL8Mx3Sr
        r3V20lNk1lDzOzmGKUYQIVIwaYkOJo8iSfAAwop39D2qGQuDSjC7+ofb5XzDJlD2NHYhvq
        UpyxQbXMAlif0x9OAAg7Q2+U3eF9c/Y=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 13/20] RDMA/siw: Simplify siw_qp_id2obj
Date:   Fri, 13 Oct 2023 10:00:46 +0800
Message-Id: <20231013020053.2120-14-guoqing.jiang@linux.dev>
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

