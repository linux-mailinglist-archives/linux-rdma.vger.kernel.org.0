Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319BA375D91
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhEFXj4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhEFXjz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:39:55 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F16C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=yHn+dA+pHBHLIY/pMgk8wOiWS4xrPuG6UitQ/WoamtQ=; b=UCYzIronO6SwXndZZxa+gcWGJH
        Ag+A7EiROSs5ONRrvFHAmWDFr7284W9nzEHtJW3KiOqPVHfSLPrWA4sDU6ZNJgvRvlZPSKYPqiOY3
        owCfSprpnB932dS0o1ojvwyd1T3vnf+XURDfRH7Z4k/sqhZ8AQoinDTLYh4F19DGtWhxr4RSvhR48
        wfd3XPZtPJjoCHR7Bl/mAfiiRj/WoZ2WoM9Dqwo0kq+jXIgu0+Rt2mdliaVgbSeDFxxI3sLiZR3Zy
        N07DlWc/4tCpBbcJagqx1NqrS/uBJJp2w1fAaKzPHQS1gk44pBZsHOxMpgdSyB9okgdFDlxuLotHh
        v0TpHsdULBaHDAziYh2ka0vm8MT8DlUB3J92LZTa/Iyx3aZUPx2VlMkcY4KpWJxNQr+Jbo7Z7AMet
        D2PQ6q0fG28/H0/UAEFK8+j1vUtfJB22LS5+MtZMhQDJ9az0D6jPP+FFvgobJypd5ZBrJRXZbdbLX
        oW0kkI0DpWG923oFztlDraLg;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lena2-0004M7-OE; Thu, 06 May 2021 23:38:54 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 18/31] rdma/siw: call the blocking kernel_bindconnect() just before siw_send_mpareqrep()
Date:   Fri,  7 May 2021 01:36:24 +0200
Message-Id: <8d9e1879a8b13516a4aae5ae3d3b1741c78b7d1d.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 853b80fcb8b0..009a0afe6669 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1425,18 +1425,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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
@@ -1531,6 +1519,19 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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
2.25.1

