Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BEC7C7B5D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjJMCBM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJMCBM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:12 -0400
Received: from out-202.mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65643C0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCr0tmkbfi1hM9xNQ7B7tOi9VlxCjnKf9yMtZlBIgy0=;
        b=VgVEo6rhczaB+Df/FeeZdBTru+w0zmu0Fr/Ckj0TAu1xa1rBaenI9qisZJ4fwYChmsbC0C
        0dDTg/0H6cBui1He5bEOt/vLhdG6QDXJ7u12mvT4BwW+2sEgXHcDdFQSh5hp/7gOUY3Mae
        0zdv2M0FUMI5ZUF9oxxu3uXnC4Acn1U=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 03/20] RDMA/siw: Use iov.iov_len in kernel_sendmsg
Date:   Fri, 13 Oct 2023 10:00:36 +0800
Message-Id: <20231013020053.2120-4-guoqing.jiang@linux.dev>
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

We can pass iov.iov_len here.

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

