Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F74BBA1D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiBRN3D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Feb 2022 08:29:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBRN3D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Feb 2022 08:29:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892AB296932
        for <linux-rdma@vger.kernel.org>; Fri, 18 Feb 2022 05:28:45 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238529355"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="238529355"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 05:28:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="489452675"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2022 05:28:43 -0800
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCH 1/3] RDMA/irdma: Use net_type to check network type
Date:   Sat, 19 Feb 2022 00:49:16 -0500
Message-Id: <20220219054918.3819830-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
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

The member variable net_type is to check the type of network.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 460e757d3fe6..b306c50d0f8e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1202,7 +1202,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		av->attrs = attr->ah_attr;
 		rdma_gid2ip((struct sockaddr *)&av->sgid_addr, &sgid_attr->gid);
 		rdma_gid2ip((struct sockaddr *)&av->dgid_addr, &attr->ah_attr.grh.dgid);
-		if (av->sgid_addr.saddr.sa_family == AF_INET6) {
+		if (av->net_type == RDMA_NETWORK_IPV6) {
 			__be32 *daddr =
 				av->dgid_addr.saddr_in6.sin6_addr.in6_u.u6_addr32;
 			__be32 *saddr =
@@ -1218,7 +1218,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 							    &local_ip[0],
 							    false, NULL,
 							    IRDMA_ARP_RESOLVE);
-		} else {
+		} else if (av->net_type == RDMA_NETWORK_IPV4) {
 			__be32 saddr = av->sgid_addr.saddr_in.sin_addr.s_addr;
 			__be32 daddr = av->dgid_addr.saddr_in.sin_addr.s_addr;
 
@@ -4179,8 +4179,6 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	rdma_gid2ip((struct sockaddr *)&dgid_addr, &ah_attr->grh.dgid);
 	ah->av.attrs = *ah_attr;
 	ah->av.net_type = rdma_gid_attr_network_type(sgid_attr);
-	ah->av.sgid_addr.saddr = sgid_addr.saddr;
-	ah->av.dgid_addr.saddr = dgid_addr.saddr;
 	ah_info = &sc_ah->ah_info;
 	ah_info->ah_idx = ah_id;
 	ah_info->pd_idx = pd->sc_pd.pd_id;
@@ -4191,7 +4189,7 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	}
 
 	ether_addr_copy(dmac, ah_attr->roce.dmac);
-	if (rdma_gid_attr_network_type(sgid_attr) == RDMA_NETWORK_IPV4) {
+	if (ah->av.net_type == RDMA_NETWORK_IPV4) {
 		ah_info->ipv4_valid = true;
 		ah_info->dest_ip_addr[0] =
 			ntohl(dgid_addr.saddr_in.sin_addr.s_addr);
-- 
2.27.0

