Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC4C7BD448
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbjJIHZj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbjJIHZh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:25:37 -0400
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5871B6
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:25:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3uNxfrRzizGCqvo3Las43txP0OFGHj8bqkubf4PNLs=;
        b=qiUK6ExvyLucgpmWkoB9XLaO09hTYbRpAQJq8Q0Pjrz+clZQ9tkD/tFSqVCiYF2JInqnd7
        n9SfvTdjPDzmZHNz27YfK+4iL9ULUDo6CXA4bm+TXZToP9go9G7d/bMmvpsIRSwnUSCgTe
        riyTmE4swEQSU9Etc7mwSB5cyzf4MUA=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 16/19] RDMA/siw: Remove siw_sk_assign_cm_upcalls
Date:   Mon,  9 Oct 2023 15:17:58 +0800
Message-Id: <20231009071801.10210-17-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-1-guoqing.jiang@linux.dev>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
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

Let's move it into siw_sk_save_upcalls, then we only need to
get sk_callback_lock once. Also rename siw_sk_save_upcalls
to better align with the new code.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index c3aa5533e75d..6866ec80473c 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -39,17 +39,7 @@ static void siw_cm_llp_error_report(struct sock *s);
 static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 			 int status);
 
-static void siw_sk_assign_cm_upcalls(struct sock *sk)
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
+static void siw_sk_save_and_assign_upcalls(struct sock *sk)
 {
 	struct siw_cep *cep = sk_to_cep(sk);
 
@@ -58,6 +48,10 @@ static void siw_sk_save_upcalls(struct sock *sk)
 	cep->sk_data_ready = sk->sk_data_ready;
 	cep->sk_write_space = sk->sk_write_space;
 	cep->sk_error_report = sk->sk_error_report;
+	sk->sk_state_change = siw_cm_llp_state_change;
+	sk->sk_data_ready = siw_cm_llp_data_ready;
+	sk->sk_write_space = siw_cm_llp_write_space;
+	sk->sk_error_report = siw_cm_llp_error_report;
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -156,8 +150,7 @@ static void siw_cep_socket_assoc(struct siw_cep *cep, struct socket *s)
 	siw_cep_get(cep);
 	s->sk->sk_user_data = cep;
 
-	siw_sk_save_upcalls(s->sk);
-	siw_sk_assign_cm_upcalls(s->sk);
+	siw_sk_save_and_assign_upcalls(s->sk);
 }
 
 static struct siw_cep *siw_cep_alloc(struct siw_device *sdev)
-- 
2.35.3

