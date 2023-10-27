Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA57D99B8
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345892AbjJ0N1K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345871AbjJ0N1J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 09:27:09 -0400
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE6018A
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 06:27:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698413225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fS2SgGtzS/q8vEZnIMkkXViqG9Rs1/e3TL6GH2Jg6FQ=;
        b=E2Vp0nX9PxloSVts8Sdw2H17OVbEzxm2lhn8o0LBwpXnBlPRHWzXFQm9+ndsO9gEjcSejT
        bvRjLYtTsl6ijDObDC923Xz8VTSPHNJOahNNT5/sUVba7NoL7cV/jhgRiYSE0hh1hc4wdf
        mvegid0yg/b3TFiU87+6A41rxZdAvWY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V4 03/18] RDMA/siw: Use iov.iov_len in kernel_sendmsg
Date:   Fri, 27 Oct 2023 21:26:29 +0800
Message-Id: <20231027132644.29347-4-guoqing.jiang@linux.dev>
In-Reply-To: <20231027132644.29347-1-guoqing.jiang@linux.dev>
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We can pass iov.iov_len here.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 6a24e08356e9..2e055b6dcd42 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -296,8 +296,7 @@ static int siw_tx_ctrl(struct siw_iwarp_tx *c_tx, struct socket *s,
 				    (char *)&c_tx->pkt.ctrl + c_tx->ctrl_sent,
 			    .iov_len = c_tx->ctrl_len - c_tx->ctrl_sent };
 
-	int rv = kernel_sendmsg(s, &msg, &iov, 1,
-				c_tx->ctrl_len - c_tx->ctrl_sent);
+	int rv = kernel_sendmsg(s, &msg, &iov, 1, iov.iov_len);
 
 	if (rv >= 0) {
 		c_tx->ctrl_sent += rv;
-- 
2.35.3

