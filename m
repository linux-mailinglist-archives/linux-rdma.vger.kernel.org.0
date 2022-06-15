Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F054CCF6
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351186AbiFOP3m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356483AbiFOP2w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:52 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488726CB
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=bIGeRwzwO/EQ7FL6FpVkOJbT4Nin7T0rDTCXLOwdI0c=; b=dJf7fbFiVnof5igGhiwdp/mHoA
        oaPfoBhjGR6Fu84twgI0kURIYlBjTd/jamqP0sf7sC19qwCrSc8txiXLNplbApXOJXzIvToCsRRXu
        ZBwBs06GB0RRgl6SQRfyhzfy5DIhB+DlRIt2SXsXsydVzz8OFZNyaDpzwuMoeq0fr/tAy1qoRLXre
        x0vYaCK2XaDOY8tCH7ZnuHaf12iBIA2yCJyJeNtTyyO8OMJD4WfdsBf+a1elQTz2v2IKI3MrE7P3f
        hfhVNIftiktq250+EJIdGhzCfb/V8+7uAqkxsDp5SlfgLnVa73EJfpKFhU+BkxWCjL9lpiZUCRUo0
        AqyIXQh1GddbcB3rRnB4hI1PrzszgrYlonyPCgxroEdqxfOH636dZJr/5cT4ugGRWHWu+SIPhKT0E
        a7tp7nI0frVJe6j7LnpZmRSypRGSHfiULE2frO3L4QcrdC1l0SKlv3Mun8gY29Tn8I1Ujpi4gFXkJ
        BRY24lCA/2Ujr1p01BBpSiEV;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1UwZ-005rwD-Lg; Wed, 15 Jun 2022 15:28:31 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 13/14] rdma/siw: call the blocking kernel_bindconnect() just before siw_send_mpareqrep()
Date:   Wed, 15 Jun 2022 17:26:51 +0200
Message-Id: <95af035f1608d23f0221c39f5d6278646555e809.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655305567.git.metze@samba.org>
References: <cover.1655305567.git.metze@samba.org>
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
index 279f5acf84d1..74ed2a5a8f47 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1386,18 +1386,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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
@@ -1494,6 +1482,19 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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

