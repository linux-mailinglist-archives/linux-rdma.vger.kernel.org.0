Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393B36F1457
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Apr 2023 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjD1Jn0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Apr 2023 05:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345644AbjD1JnY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Apr 2023 05:43:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F0448C
        for <linux-rdma@vger.kernel.org>; Fri, 28 Apr 2023 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682675001; x=1714211001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Jiss2opuEmF2sKfIcyR9ilWI2ogXX++fIYhZo7uZFw=;
  b=D4bZviL79RDtCAbT4PxaT4RJTJB4HG+AWa/UI35PwJg5AgvG+O8fvxeW
   M3vVbwCJJoDj7P5841avFzBEvqObn8E3mFqUsdKqC/ee2FWR00eFw6fVf
   pCrve+zic4UWZFAV9DNTRYmQIqY7rm0jPPCV+RLIL6Kc4aUs3KzWE+pvc
   EIEH3uR+CrwdVzVSY5kILaiZxpqiL98GqdFGmkLKQTauD0IfsLl91wxxO
   HHMjVuIpvsaiV8kAucH58JRTDPQpZZu/X28FC+5gNatBoYoXFQyX2rYOK
   HK2DzUPTpUX0b7K9hvIj5oYlfGi4nacwvOCWmUnh0lTRAAyv1prTUP4gB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="328035215"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="328035215"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="764220486"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="764220486"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2023 02:43:19 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCHv5 for-rc1 v5 8/8] RDMA/rxe: Replace l_sk6 with sk6 in net namespace
Date:   Fri, 28 Apr 2023 17:39:14 +0800
Message-Id: <20230428093914.2121131-9-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230428093914.2121131-1-yanjun.zhu@intel.com>
References: <20230428093914.2121131-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index c297677bf06a..3260f598a7fb 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -75,7 +75,6 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 			rxe->ndev->dev_addr);
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
-	rxe->l_sk6				= NULL;
 }
 
 /* initialize port attributes */
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 8135876b11f6..ebcb86fa1e5e 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -50,24 +50,6 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 {
 	struct dst_entry *ndst;
 	struct flowi6 fl6 = { { 0 } };
-	struct rxe_dev *rdev;
-
-	rdev = rxe_get_dev_from_net(ndev);
-	if (!rdev->l_sk6) {
-		struct sock *sk;
-
-		rcu_read_lock();
-		sk = udp6_lib_lookup(dev_net(ndev), NULL, 0, &in6addr_any,
-				     htons(ROCE_V2_UDP_DPORT), 0);
-		rcu_read_unlock();
-		if (!sk) {
-			pr_info("file: %s +%d, error\n", __FILE__, __LINE__);
-			return (struct dst_entry *)sk;
-		}
-		__sock_put(sk);
-		rdev->l_sk6 = sk->sk_socket;
-	}
-
 
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_oif = ndev->ifindex;
@@ -76,7 +58,7 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 	fl6.flowi6_proto = IPPROTO_UDP;
 
 	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
-					       rdev->l_sk6->sk, &fl6,
+					       rxe_ns_pernet_sk6(dev_net(ndev)), &fl6,
 					       NULL);
 	if (IS_ERR(ndst)) {
 		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ac9bb55820a2..c269ae2a3224 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -396,7 +396,6 @@ struct rxe_dev {
 
 	struct rxe_port		port;
 	struct crypto_shash	*tfm;
-	struct socket		*l_sk6;
 };
 
 static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
-- 
2.27.0

