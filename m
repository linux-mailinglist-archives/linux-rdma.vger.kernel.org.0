Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B424BBA1F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiBRN3H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Feb 2022 08:29:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBRN3F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Feb 2022 08:29:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A03296932
        for <linux-rdma@vger.kernel.org>; Fri, 18 Feb 2022 05:28:49 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238529359"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="238529359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 05:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="489452733"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2022 05:28:47 -0800
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCH 3/3] RDMA/irdma: Move union irdma_sockaddr to header file
Date:   Sat, 19 Feb 2022 00:49:18 -0500
Message-Id: <20220219054918.3819830-3-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220219054918.3819830-1-yanjun.zhu@linux.dev>
References: <20220219054918.3819830-1-yanjun.zhu@linux.dev>
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

