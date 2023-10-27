Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0987D8D2B
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 04:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjJ0CeG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 22:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbjJ0CeE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 22:34:04 -0400
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E9D4D
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 19:34:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698374039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hr2GiOgEN6Dut7BppZV3lHHlcsVuO+UgdK4EHR8ie4=;
        b=BmvI4Vq4SkysNaBK9g9ico1VyNgl86zrTKiOXKJAP937e0mKeL2ZZ+14aDYjlLLhQGF0q/
        VoJ2iWvBSkS16c+rtl4W6UFKX0YIP4TYVvw1UvrbWWef794GX1Gf+O7ARlWXDxY9JByzg3
        KdrrReJTghXQw4IvxAjzT0dV6lOPMxs=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V3 14/18] RDMA/siw: Remove siw_sk_save_upcalls
Date:   Fri, 27 Oct 2023 10:33:24 +0800
Message-Id: <20231027023328.30347-15-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-1-guoqing.jiang@linux.dev>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Let's move the functionality of it into siw_sk_assign_cm_upcalls,
then we only need to get sk_callback_lock once.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index cff0fd7ceee6..4866b53b15c3 100644
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

