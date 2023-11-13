Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065C67E9B9C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjKML6A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjKML57 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:57:59 -0500
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD9D6C
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:52 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyQMZkmHWLThtwbli9PEmJeAMVMA21BJSdagk5Rr6q8=;
        b=k+1zBzBBt5zk5q2vZ7vzlB+4WRlnXV0r2K76aUMUiaugPot6a9IbYSm0zbUHwOjCResS8+
        TrMb+lplb0rjjWtmybKym2wLNTyIxg92rzMULvXDltT8s9jBSQtIEm3ILWfCKt67NJinkd
        OXbRl08eGmQBXT6YlV67Zg9L9V/57BA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 13/17] RDMA/siw: Remove siw_sk_save_upcalls
Date:   Mon, 13 Nov 2023 19:57:22 +0800
Message-Id: <20231113115726.12762-14-guoqing.jiang@linux.dev>
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

Let's move it into siw_sk_assign_cm_upcalls, then we only
need to get sk_callback_lock once.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 5e9a591eec58..5c0f9f8bf3db 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -40,16 +40,6 @@ static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 			 int status);
 
 static void siw_sk_assign_cm_upcalls(struct sock *sk)
-{
-	write_lock_bh(&sk->sk_callback_lock);
-	sk->sk_state_change = siw_cm_llp_state_change;
-	sk->sk_data_ready = siw_cm_llp_data_ready;
-	sk->sk_write_space = siw_cm_llp_write_space;
-	sk->sk_error_report = siw_cm_llp_error_report;
-	write_unlock_bh(&sk->sk_callback_lock);
-}
-
-static void siw_sk_save_upcalls(struct sock *sk)
 {
 	struct siw_cep *cep = sk_to_cep(sk);
 
@@ -58,6 +48,11 @@ static void siw_sk_save_upcalls(struct sock *sk)
 	cep->sk_data_ready = sk->sk_data_ready;
 	cep->sk_write_space = sk->sk_write_space;
 	cep->sk_error_report = sk->sk_error_report;
+
+	sk->sk_state_change = siw_cm_llp_state_change;
+	sk->sk_data_ready = siw_cm_llp_data_ready;
+	sk->sk_write_space = siw_cm_llp_write_space;
+	sk->sk_error_report = siw_cm_llp_error_report;
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -156,7 +151,6 @@ static void siw_cep_socket_assoc(struct siw_cep *cep, struct socket *s)
 	siw_cep_get(cep);
 	s->sk->sk_user_data = cep;
 
-	siw_sk_save_upcalls(s->sk);
 	siw_sk_assign_cm_upcalls(s->sk);
 }
 
-- 
2.35.3

