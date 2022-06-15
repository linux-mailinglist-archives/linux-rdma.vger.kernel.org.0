Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA53354C3BF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 10:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbiFOIlt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 04:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346642AbiFOIls (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 04:41:48 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857034B1FE
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=YgADCWgD7M2HHL2ab+yTnWybxXOMGoyAlvlMkl4oa1s=; b=nvbW0FsPDSvJC3tZQIajrkprLA
        +ywA1rSFIeia7Wb4RaRD59b0dzR7HVt1qxngNnP9li9VLzKNo7B1AdLkD2Qj4YbqyAtdKB0OWvkYS
        q8o+Hr64nZpwQciI4CckTRi6BDwZzTrRYAKPAMohsAdbOeRN2RCupgtR90BPj2zt18elJzZgV/3dW
        QweEsvRBQunJD1LCJLZ0Tv7gLNJcr1UAlEveJZN08Chc5KflCa/h5vJ4g2T3A6qHzuQmpXN4vC9am
        Ux/HNfGAse+VVSvTGfOWAX+UcJz2t//fSgeio8o5q7mghJoM+d5ewPrWGVq8GGprE6JACTt6gGb5f
        kudysy8v/ZxldgIOjxHjzeeM6oSjjhPevIoRCM0xcF4yvunV0VKkBxUMDpA5vYn1GURUxKliEBBSK
        Pgamhfvhj7h/k9+IiYcz2NdYUa5Nui2b+e2/2kvvblD/I780PO4cr7WOtz1m0iAuTkT2dvCXY0dGl
        4fnme/yHI4NfQO7bl3zqgfEj;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Oav-005pAD-G9; Wed, 15 Jun 2022 08:41:45 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 6/7] rdma/siw: call the blocking kernel_bindconnect() just before siw_send_mpareqrep()
Date:   Wed, 15 Jun 2022 10:40:06 +0200
Message-Id: <8f97aa28bad93d95b12eb8393ede721340ea0ba2.1655248086.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655248086.git.metze@samba.org>
References: <cover.1655248086.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We should build all state before calling kernel_bindconnect().
This will allow us to go async in the final patch.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 3fee1d4ef252..9c5276d08538 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1373,18 +1373,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	if (rv < 0)
 		goto error;
 
-	/*
-	 * NOTE: For simplification, connect() is called in blocking
-	 * mode. Might be reconsidered for async connection setup at
-	 * TCP level.
-	 */
-	rv = kernel_bindconnect(s, laddr, raddr, id->afonly);
-	if (rv != 0) {
-		siw_dbg_qp(qp, "kernel_bindconnect: error %d\n", rv);
-		goto error;
-	}
-	if (siw_tcp_nagle == false)
-		tcp_sock_set_nodelay(s->sk);
 	cep = siw_cep_alloc(sdev);
 	if (!cep) {
 		rv = -ENOMEM;
@@ -1481,6 +1469,19 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		goto error;
 	}
 
+	/*
+	 * NOTE: For simplification, connect() is called in blocking
+	 * mode. Might be reconsidered for async connection setup at
+	 * TCP level.
+	 */
+	rv = kernel_bindconnect(s, laddr, raddr, id->afonly);
+	if (rv != 0) {
+		siw_dbg_qp(qp, "kernel_bindconnect: error %d\n", rv);
+		goto error;
+	}
+	if (siw_tcp_nagle == false)
+		tcp_sock_set_nodelay(s->sk);
+
 	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
 
 	rv = siw_send_mpareqrep(cep, cep->mpa.pdata,
-- 
2.34.1

