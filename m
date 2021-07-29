Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503F73DAF7F
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhG2Wum (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbhG2Wum (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:42 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26429C0613C1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q6so10528820oiw.7
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6wHpWGD6A1k8KiqqsA/m24nLrS+4TZTb7Vekbr2fP0=;
        b=DtSrwiLEwZH3gy9nQE3gJpA9LRlKyL2m/5Jn1s0GJaEZViLu2iO9/4wO3+z7BAsuM/
         6s5cPYe++W55YmOhWYH6kgTJ+iaBCz3svvC4wdJ8LKKvNPXR8yQWsS9rm6g5aw+tM0i4
         xjwAY6k3u1bfAB5IqnLIVY+SJCNznVWludmhBK7tmdSgNuK9vG9kxtNG6AicPJo3E+Ce
         +dBQpXwQSAd9Wcifs4+81XkTvpRDfLcw++dhY9UWUrhiktw8dGWC2D5XSaAyheDnadY7
         dPVDrB73V6kK+xOhwQPjsLL17O8IZ8qB41QvPRq1d1IiHIhtxx+ywyxN2b/dTlmsMSnn
         prFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6wHpWGD6A1k8KiqqsA/m24nLrS+4TZTb7Vekbr2fP0=;
        b=gYUyZAm92EeUggqR+8Zk/Yp71SFAFp5cBs5rR+6oBqmxZ9oSmvzKUKnwuTEMJL0kmS
         ta6OXODi6PwR/pepSmFZFbzYmwf5Er7oWiqbe4Xi3dmeD0uneMYXcPADj7OfvQb4u8H9
         A/L24KqFs6TPIwNNyCslLX3Qo9m959eAhqIGf6cV5vGAvUZ1HTd1erdG4Fp+PtdZNOwy
         wKZFL24UlSPMMQ2d3KXI7altXE2IzoggILkapHMNJ4ef+uW5sFUzvmczugppFnTelJ5a
         hA4u3J5U2CAlA5i9qdaa8waa8hA7g6v8a6FfewUZCCHZHemx3VcSXCxN6Gv+cstXrjN7
         OUzQ==
X-Gm-Message-State: AOAM532AhZXSNhgEEJHo+fMQsFODU/i3zcZ0FzqrJHZrdah6kr/Ed8YJ
        IMOoWt0jhvzPo/NJ8A8gby0=
X-Google-Smtp-Source: ABdhPJyyPK0u3d9eunnxFFrhvR8py6122HF7TerBZYsuhl/rjAlXxRuiCAOOyAYha8I5LZmmYeBPyQ==
X-Received: by 2002:aca:aaca:: with SMTP id t193mr11247479oie.94.1627599037582;
        Thu, 29 Jul 2021 15:50:37 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id c2sm696805ooo.28.2021.07.29.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 05/13] RDMA/rxe: Add XRC ETH to rxe_hdr.h
Date:   Thu, 29 Jul 2021 17:49:08 -0500
Message-Id: <20210729224915.38986-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend rxe_hdr.h to support XRC ETH.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index d9d15c672f86..499807b11405 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -907,11 +907,47 @@ static inline void ieth_set_rkey(struct rxe_pkt_info *pkt, u32 rkey)
 		rxe_opcode[pkt->opcode].offset[RXE_IETH], rkey);
 }
 
+/******************************************************************************
+ * XRC Extended Transport Header
+ ******************************************************************************/
+struct rxe_xrceth {
+	__be32			rxrcsrq;
+};
+
+#define XRCETH_XRCSRQ_MASK	(0x00ffffff)
+
+static inline u32 __xrceth_xrcsrq(void *arg)
+{
+	struct rxe_xrceth *xrceth = arg;
+
+	return XRCETH_XRCSRQ_MASK & be32_to_cpu(xrceth->rxrcsrq);
+}
+
+static inline void __xrceth_set_xrcsrq(void *arg, u32 xrcsrq)
+{
+	struct rxe_xrceth *xrceth = arg;
+
+	xrceth->rxrcsrq = cpu_to_be32(XRCETH_XRCSRQ_MASK & xrcsrq);
+}
+
+static inline u32 xrceth_xrcsrq(struct rxe_pkt_info *pkt)
+{
+	return __xrceth_xrcsrq(pkt->hdr +
+		rxe_opcode[pkt->opcode].offset[RXE_XRCETH]);
+}
+
+static inline void xrceth_set_xrcsrq(struct rxe_pkt_info *pkt, u32 xrcsrq)
+{
+	__xrceth_set_xrcsrq(pkt->hdr +
+		rxe_opcode[pkt->opcode].offset[RXE_XRCETH], xrcsrq);
+}
+
 enum rxe_hdr_length {
 	RXE_BTH_BYTES		= sizeof(struct rxe_bth),
 	RXE_DETH_BYTES		= sizeof(struct rxe_deth),
 	RXE_IMMDT_BYTES		= sizeof(struct rxe_immdt),
 	RXE_RETH_BYTES		= sizeof(struct rxe_reth),
+	RXE_XRCETH_BYTES	= sizeof(struct rxe_xrceth),
 	RXE_AETH_BYTES		= sizeof(struct rxe_aeth),
 	RXE_ATMACK_BYTES	= sizeof(struct rxe_atmack),
 	RXE_ATMETH_BYTES	= sizeof(struct rxe_atmeth),
-- 
2.30.2

