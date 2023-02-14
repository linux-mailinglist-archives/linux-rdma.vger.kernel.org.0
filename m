Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2F26958D3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 07:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjBNGIn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 01:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjBNGId (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 01:08:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596C61C333
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 22:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676354907; x=1707890907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RFiAlG11ksNqASYlfPi1eSLt+WBeB4yuI/HUB6je8QU=;
  b=KQqLQJ5zC4BEF1x6OglTkBqnl+jAy0I6y7pKp9tk8jPLEaHUgzo0RCcg
   zLliTVoLpoiTplHLuPFh9movETJSLiJXgmWiZQn4e1K5UmcRCHYX14p+P
   lIZRHfJQ+6H9DWNAWitCANiGu5koUgzjwt10QZWOWgbELnt4zy5+kj6Dy
   Lf8G32fLIZIr1exwDaQgMoANXAPfo57qVfw537fvYw7bSW1TkWkRAV5Tz
   cvQwCizBzHzE13egAcEvomJTb8rAzu8DmClAFFo1qyt4lRYugXDioqAIN
   K6hyNUI4tQHNa87TyEcj3gqgeB2ACYGKN5HE9TSaxueLbmjIzlLU4FhW/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332400625"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="332400625"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="618924893"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="618924893"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 22:08:17 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, parav@nvidia.com, yanjun.zhu@intel.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv3 8/8] RDMA/rxe: Replace l_sk6 with sk6 in net namespace
Date:   Tue, 14 Feb 2023 14:06:34 +0800
Message-Id: <20230214060634.427162-9-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230214060634.427162-1-yanjun.zhu@intel.com>
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The net namespace variable sk6 can be used. As such, l_sk6 can be
replaced with it.

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
index 52c4ef4d0305..19ddfa890480 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -408,7 +408,6 @@ struct rxe_dev {
 
 	struct rxe_port		port;
 	struct crypto_shash	*tfm;
-	struct socket		*l_sk6;
 };
 
 static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
-- 
2.34.1

