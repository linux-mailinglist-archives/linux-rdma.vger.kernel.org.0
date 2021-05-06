Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB80A375D8B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhEFXjU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhEFXjQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:39:16 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9ACC061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=6H+QNgqu01dvYHmtu2P5PruSlj+5YpvlchBxB5d3SUk=; b=3aL4ydXXRVA+y2pIDNuW4kShFa
        ZET8mAGRbFqqGdqcDiuueo2l+SjLKpAI38C+r9Wo6uFkQ6N/QTQqik2GgjAcAxFEn831QIiBdNn8g
        L4LM2XNOVkRGXv+2L4cVWfgTC1TjoWfIvKzYHbL7a0pxGSf/7yqtpnkybSTcl3DR55s3Wdc9W0xRR
        MQZ2teQWpCBD0rUaQCLZePnAy8Qe+VPygLZ4AC3lUNfH/iqCfoNLQW9tEuHAxVdQsoQ1s1H3Ipl1U
        EcBuQY6LujkgMr/zI61PkspIjaEuxrtilR3V6GnhkMRuCk5hlAxxesniwG8MxbVUXqxLUI0zGeQsy
        JAj/UNkDBGPsduBldAxhPOqZaeOHpCISktj2owI92aa9fc9AJ6o1QzMt8aLLiI5lyTMXsVdr5ZQjo
        y7KkZB/qlUnsshIhlfPwJ3o80OuE8S4vurC9mGUyBglP7aDD1F6NPpxfryyvQYKzj+rHPvJjhIbP0
        3Ac3MuDIm48psGGU2WjU90Jo;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenZO-0004Ko-OD; Thu, 06 May 2021 23:38:14 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 12/31] rdma/siw: add some debugging of state and sk_state to the teardown process
Date:   Fri,  7 May 2021 01:36:18 +0200
Message-Id: <0f85e2dc8c8cdeb25a14113b279ec44441112867.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

That makes it easier to understanf where possible problems come from.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 3cc1d22fe232..ed33533ff9e6 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -111,6 +111,14 @@ static void __siw_cep_terminate_upcall(struct siw_cep *cep,
 				       int reply_status)
 {
 	bool suspended = false;
+	int sk_state_val = UINT_MAX;
+
+	if (cep->sock && cep->sock->sk)
+		sk_state_val = cep->sock->sk->sk_state;
+
+	siw_dbg_cep(cep, "[QP %u]: state: %d sk_state: %d\n",
+		    cep->qp ? qp_id(cep->qp) : UINT_MAX,
+		    cep->state, sk_state_val);
 
 	if (cep->qp) {
 		struct siw_qp *qp = cep->qp;
@@ -118,9 +126,14 @@ static void __siw_cep_terminate_upcall(struct siw_cep *cep,
 		if (qp->term_info.valid)
 			siw_send_terminate(qp);
 
+		siw_dbg_cep(cep,
+			    "with qp rx_suspend=%d tx_suspend=%d\n",
+			    qp->rx_stream.rx_suspend,
+			    qp->tx_ctx.tx_suspend);
 		if (qp->rx_stream.rx_suspend || qp->tx_ctx.tx_suspend)
 			suspended = true;
 	} else {
+		siw_dbg_cep(cep, "without qp\n");
 		suspended = true;
 	}
 
@@ -1307,7 +1320,7 @@ static void siw_cm_llp_state_change(struct sock *sk)
 	}
 	orig_state_change = cep->sk_state_change;
 
-	siw_dbg_cep(cep, "state: %d\n", cep->state);
+	siw_dbg_cep(cep, "state: %d sk_state: %d\n", cep->state, sk->sk_state);
 
 	switch (sk->sk_state) {
 	case TCP_ESTABLISHED:
-- 
2.25.1

