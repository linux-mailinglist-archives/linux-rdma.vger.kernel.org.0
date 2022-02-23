Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CB4BF5A8
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 11:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiBVKW5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 05:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiBVKWw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 05:22:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4809290FEE
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 02:22:27 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251423893"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251423893"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 02:22:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532172001"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2022 02:22:25 -0800
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCHv2 3/3] RDMA/irdma: Move union irdma_sockaddr to header file
Date:   Tue, 22 Feb 2022 21:42:52 -0500
Message-Id: <20220223024252.3873736-4-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220223024252.3873736-1-yanjun.zhu@linux.dev>
References: <20220223024252.3873736-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The union irdma_sockaddr is used frequently. So move it to the
header file.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 17 +++--------------
 drivers/infiniband/hw/irdma/verbs.h | 11 +++++++----
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 7e4d0cc9222f..93cf4ad0d2a6 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3932,11 +3932,7 @@ static int irdma_attach_mcast(struct ib_qp *ibqp, union ib_gid *ibgid, u16 lid)
 	int ret = 0;
 	bool ipv4;
 	u16 vlan_id;
-	union {
-		struct sockaddr saddr;
-		struct sockaddr_in saddr_in;
-		struct sockaddr_in6 saddr_in6;
-	} sgid_addr;
+	union irdma_sockaddr sgid_addr;
 	unsigned char dmac[ETH_ALEN];
 
 	rdma_gid2ip((struct sockaddr *)&sgid_addr, ibgid);
@@ -4072,11 +4068,7 @@ static int irdma_detach_mcast(struct ib_qp *ibqp, union ib_gid *ibgid, u16 lid)
 	struct irdma_mcast_grp_ctx_entry_info mcg_info = {};
 	int ret;
 	unsigned long flags;
-	union {
-		struct sockaddr saddr;
-		struct sockaddr_in saddr_in;
-		struct sockaddr_in6 saddr_in6;
-	} sgid_addr;
+	union irdma_sockaddr sgid_addr;
 
 	rdma_gid2ip((struct sockaddr *)&sgid_addr, ibgid);
 	if (!ipv6_addr_v4mapped((struct in6_addr *)ibgid))
@@ -4154,10 +4146,7 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	u32 ah_id = 0;
 	struct irdma_ah_info *ah_info;
 	struct irdma_create_ah_resp uresp;
-	union {
-		struct sockaddr_in saddr_in;
-		struct sockaddr_in6 saddr_in6;
-	} sgid_addr, dgid_addr;
+	union irdma_sockaddr sgid_addr, dgid_addr;
 	int err;
 	u8 dmac[ETH_ALEN];
 
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index d2d4a7e5f954..541105b728e3 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -25,13 +25,16 @@ struct irdma_pd {
 	struct irdma_sc_pd sc_pd;
 };
 
+union irdma_sockaddr {
+	struct sockaddr_in saddr_in;
+	struct sockaddr_in6 saddr_in6;
+};
+
 struct irdma_av {
 	u8 macaddr[16];
 	struct rdma_ah_attr attrs;
-	union {
-		struct sockaddr_in saddr_in;
-		struct sockaddr_in6 saddr_in6;
-	} sgid_addr, dgid_addr;
+	union irdma_sockaddr sgid_addr;
+	union irdma_sockaddr dgid_addr;
 	u8 net_type;
 };
 
-- 
2.27.0

