Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EAB73B443
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjFWJ7D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjFWJ7A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 05:59:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDBE75
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687514337; x=1719050337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k6rNKO7P0g0cwzqXZF+L2T39+CBNTEATEb9gtwNbeuM=;
  b=ea8pqfxdbJX+sA3cuFw/UeYCzPNK0w1UzFrv7GUB9lKnCOZ9a5AUJnI1
   Kr/Yjbdy8s2WoqZJeJKhinOng2v8a0KeJFFGcELvNU0sRb7Ni+jdaitly
   mBT0IFptIWGfZNpmUqLc0x0Dimqq3UbjXLf2mkLBu2FdIPbFnYCKIT/iD
   uMJkBsknyq4fwj2U3DGPoaRoIQl7vtAvjTnKG/4XEiEzcp5C2npoy9oyG
   5jksCClDfEIogrjjpFch2pCt4I6JG3v0iYkbD+Bzm0HHIaURAXr2vyroL
   xIwkwuG4HtjOxVGXtLHzgw0SCekoHihLsMZ69Su1vt+qRLIMUeo3moWOf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="424411446"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="424411446"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 02:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715263062"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="715263062"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2023 02:58:48 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com,
        rpearsonhpe@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCH v6 8/8] RDMA/rxe: Replace l_sk6 with sk6 in net namespace
Date:   Fri, 23 Jun 2023 17:57:49 +0800
Message-Id: <20230623095749.485873-9-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230623095749.485873-1-yanjun.zhu@intel.com>
References: <20230623095749.485873-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The net namespace variable sk6 can be used. As such, l_sk6 can be
replaced with it.

Tested-by: Rain River <rain.1986.08.12@gmail.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c       |  1 -
 drivers/infiniband/sw/rxe/rxe_net.c   | 20 +-------------------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 96841c56ff3a..b1dfba2fdf15 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -75,7 +75,6 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 			rxe->ndev->dev_addr);
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
-	rxe->l_sk6				= NULL;
 }
 
 /* initialize port attributes */
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 57b8c5593e3c..1f4b8ccfdbb5 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -50,24 +50,6 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 {
 	struct dst_entry *ndst;
 	struct flowi6 fl6 = { { 0 } };
-	struct rxe_dev *rxe;
-
-	rxe = rxe_get_dev_from_net(ndev);
-	if (!rxe->l_sk6) {
-		struct sock *sk;
-
-		rcu_read_lock();
-		sk = udp6_lib_lookup(dev_net(ndev), NULL, 0, &in6addr_any,
-				     htons(ROCE_V2_UDP_DPORT), 0);
-		rcu_read_unlock();
-		if (!sk) {
-			rxe_dbg_qp(qp, "file: %s +%d, error\n", __FILE__, __LINE__);
-			return (struct dst_entry *)sk;
-		}
-		__sock_put(sk);
-		rxe->l_sk6 = sk->sk_socket;
-	}
-
 
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_oif = ndev->ifindex;
@@ -76,7 +58,7 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 	fl6.flowi6_proto = IPPROTO_UDP;
 
 	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
-					       rxe->l_sk6->sk, &fl6,
+					       rxe_ns_pernet_sk6(dev_net(ndev)), &fl6,
 					       NULL);
 	if (IS_ERR(ndst)) {
 		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 0aa3817770a5..26a20f088692 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -382,7 +382,6 @@ struct rxe_dev {
 
 	struct rxe_port		port;
 	struct crypto_shash	*tfm;
-	struct socket		*l_sk6;
 };
 
 static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
-- 
2.27.0

