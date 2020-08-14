Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4472244E26
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Aug 2020 19:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHNRhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Aug 2020 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHNRhp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Aug 2020 13:37:45 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF7C061384
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 10:37:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq25so10758760ejb.3
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qswH+zj0NhX5X+onMm7PqXWOr0DEm/VyLDA0NodNU/A=;
        b=QhWrh6+3tOZ/wvDMSh6xjrl1236NwuC3nEDFXFwGA4HF7Rkh89lZGBEVwTWcQp2kLf
         ujJmgfMlGiyBu/H+w9jSmUnWh2h1em3XIpsinfgII7lSYT6quDqLU4amGqeQfy5TqIKm
         znTKvevCak7IqDE7qlFfKJCP0CtqRml5MdksMrEPIPUALtMfy7MRrJUXJGec0svlGv6L
         rV5+/WEmz+1HLKhT2zuOx/fWApjGitH8VrDywMFFoFy5twUQC3MRoxwUEdqtZlpJNgQL
         B5ZkHw0JLTJRahzf4bh0SZdfWm3KG9fQl790rUGuupy+pMGdSyT+bAc3fIgarhbRxiMN
         bosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qswH+zj0NhX5X+onMm7PqXWOr0DEm/VyLDA0NodNU/A=;
        b=sy+wO6uTS8kqL6sQ2wBxB1DxP5teO6GMG3s7K/P16/WKQntt0laMf6LeGyA8ZfzmsC
         MRNWHgx1RI+xFAaCd3DmoD53ke750nuTFp9Jnw6rulR+brDL38H8C4NyunK7mPfkMIJr
         /BZpDg9gltsKbzo8k6lrjebwxkK4yi9T1oe9E8L+LhCRvwGc4g0DFqm3l8xt6I8y7tHN
         Nvq+pVgdZmomayec7a5Zjw6afDk8cHuA02aweewyAmaUwZ5DJKXpVMeSR55VRV8hBfWf
         exBsZ8dL2M2rRIo9WvtQjBPUPCnDe81zJ1fFn5Zg9Eo7IoS9OhvzI/ccOT34sxFGoakt
         DlDQ==
X-Gm-Message-State: AOAM531T0Jd7kthxvBGmpA04LBfHzjtxYPZzy6sZ9DUHNpzzFtsdYzzE
        SxJdasBdDHbXrNSmMtC3u8mwSw==
X-Google-Smtp-Source: ABdhPJzh1di+KA5THyr/IRDlqyjVR7jt3u2Mf2425+melW2ImNZ0mye0480jAwU5Hmd0HNdvuoar9Q==
X-Received: by 2002:a17:907:7255:: with SMTP id ds21mr3659982ejc.44.1597426662589;
        Fri, 14 Aug 2020 10:37:42 -0700 (PDT)
Received: from jupiter.home.aloni.org ([141.226.169.176])
        by smtp.gmail.com with ESMTPSA id a18sm7029042ejt.69.2020.08.14.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 10:37:41 -0700 (PDT)
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] xprtrdma: make sure MRs are unmapped before freeing them
Date:   Fri, 14 Aug 2020 20:37:34 +0300
Message-Id: <20200814173734.3271600-1-dan@kernelim.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It was observed that on disconnections, these unmaps don't occur. The
relevant path is rpcrdma_mrs_destroy(), being called from
rpcrdma_xprt_disconnect().

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 7f94c9a19fd3..3899a5310214 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -49,6 +49,19 @@
 # define RPCDBG_FACILITY	RPCDBG_TRANS
 #endif
 
+static void frwr_mr_unmap(struct rpcrdma_mr *mr)
+{
+	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
+
+	if (mr->mr_dir == DMA_NONE)
+		return;
+
+	trace_xprtrdma_mr_unmap(mr);
+	ib_dma_unmap_sg(r_xprt->rx_ep->re_id->device,
+			mr->mr_sg, mr->mr_nents, mr->mr_dir);
+	mr->mr_dir = DMA_NONE;
+}
+
 /**
  * frwr_release_mr - Destroy one MR
  * @mr: MR allocated by frwr_mr_init
@@ -58,6 +71,8 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
 {
 	int rc;
 
+	frwr_mr_unmap(mr);
+
 	rc = ib_dereg_mr(mr->frwr.fr_mr);
 	if (rc)
 		trace_xprtrdma_frwr_dereg(mr, rc);
@@ -71,12 +86,7 @@ static void frwr_mr_recycle(struct rpcrdma_mr *mr)
 
 	trace_xprtrdma_mr_recycle(mr);
 
-	if (mr->mr_dir != DMA_NONE) {
-		trace_xprtrdma_mr_unmap(mr);
-		ib_dma_unmap_sg(r_xprt->rx_ep->re_id->device,
-				mr->mr_sg, mr->mr_nents, mr->mr_dir);
-		mr->mr_dir = DMA_NONE;
-	}
+	frwr_mr_unmap(mr);
 
 	spin_lock(&r_xprt->rx_buf.rb_lock);
 	list_del(&mr->mr_all);
-- 
2.25.4

