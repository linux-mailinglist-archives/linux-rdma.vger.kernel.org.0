Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147267C7B6D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjJMCB2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjJMCB0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:26 -0400
Received: from out-191.mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B297DD
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxTSYvATVZM8BGsXk1l7sBdTmVawlVnq5eMHpoR3P5g=;
        b=M4e5rClgK7HkvdgomVB9et4MBYEHLdO/bR/aU21u3+iIW/TEhoHcK/HIsBWasbovt14okA
        zmk5ZNkbJDiGWHM6n6eyybBhjPP3R75MAKWe7FjcIt4MFlXYyIQmbJSTAkp8oGEOup4GRi
        w6lH3upNIu/UI9bBU3TeTFi91Ae+GUo=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 16/20] RDMA/siw: Remove siw_sk_assign_cm_upcalls
Date:   Fri, 13 Oct 2023 10:00:49 +0800
Message-Id: <20231013020053.2120-17-guoqing.jiang@linux.dev>
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

Let's move it into siw_sk_save_upcalls, then we only need to
get sk_callback_lock once. Also rename siw_sk_save_upcalls
to better fitting the new code.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 4dbdcae46a78..be0d09d18a4f 100644
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

