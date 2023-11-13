Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44E7E9B91
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjKML5n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKML5n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:57:43 -0500
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6802BD79
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:39 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OzGtPrR6FL3yUKSZua/Zfto5Gdp/8vu/y/QIMgZJ2M=;
        b=ZjFQ/MVzUJJCErq4z9qcUthIpF9GewlexFWcf9pBdyqQ9s9dXokZqeCp/7GBmMItrTsYB9
        m0DgaptMK1+3/CQRj+efyPWYHy55gJSbqZGLpbqMPOCZueDPcLnOUTOYwBXW1dRxl1C2WQ
        neBtDUNOlmrwF1B33rxXgqBgCIukZdA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 03/17] RDMA/siw: Use iov.iov_len in kernel_sendmsg
Date:   Mon, 13 Nov 2023 19:57:12 +0800
Message-Id: <20231113115726.12762-4-guoqing.jiang@linux.dev>
In-Reply-To: <20231113115726.12762-1-guoqing.jiang@linux.dev>
References: <20231113115726.12762-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 86186cd3cca4..838123c621e2 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -292,8 +292,7 @@ static int siw_tx_ctrl(struct siw_iwarp_tx *c_tx, struct socket *s,
 				    (char *)&c_tx->pkt.ctrl + c_tx->ctrl_sent,
 			    .iov_len = c_tx->ctrl_len - c_tx->ctrl_sent };
 
-	int rv = kernel_sendmsg(s, &msg, &iov, 1,
-				c_tx->ctrl_len - c_tx->ctrl_sent);
+	int rv = kernel_sendmsg(s, &msg, &iov, 1, iov.iov_len);
 
 	if (rv >= 0) {
 		c_tx->ctrl_sent += rv;
-- 
2.35.3

