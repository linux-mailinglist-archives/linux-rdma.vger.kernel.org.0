Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE196BB6B8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjCOO4c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjCOO4N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 10:56:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178396B326
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892130; x=1710428130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lkdBCstfFbRE45DfVIDCBHkHVh9GbEDZOi+vASSKv4s=;
  b=H7tdqws1JVzy7p34EETGwgF0gJolOXAihLBFyz30pghr+b2mjJc16Br1
   S1PdjgVFIgDSAe2sW0L/KVCBMdm0WaqWiCQNxXzy2Q1PcxMZrpyyRZj1/
   3mw9T8xVqkRR8k3g6ymhpHAPmFbgHDAie+YbbMCC5/kSpk9EkKeDS9uAZ
   2p4hfkbDi06inYWq7gxUbJ2MbSPeqYThDcosKS/auYiML8UUOTg+nME4H
   vX5hsrAHWGruunmNcE7sDK+luShBa6ZRC3C/3Q3L/OBdPwjwR++Jx3vAE
   edufqMcbFEG7beTmI6AVbSJDEh/FqtdkUWTlh0CORl/6li4wutjo3wQmM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321561723"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321561723"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="743714351"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="743714351"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.35.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:31 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 2/4] RDMA/irdma: Remove a redundant irdma_arp_table() call
Date:   Wed, 15 Mar 2023 09:53:03 -0500
Message-Id: <20230315145305.955-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230315145305.955-1-shiraz.saleem@intel.com>
References: <20230315145305.955-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

Remove a redundant function call in irdma_modify_qp_roce, since
irdma_arp_table() with IRDMA_ARP_RESOLVE action is called after the if/else
ipv check as part of irdma_add_arp().

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index ec9f4df..d906f59 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1226,10 +1226,6 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			udp_info->ipv4 = false;
 			irdma_copy_ip_ntohl(local_ip, daddr);
 
-			udp_info->arp_idx = irdma_arp_table(iwdev->rf,
-							    &local_ip[0],
-							    false, NULL,
-							    IRDMA_ARP_RESOLVE);
 		} else if (av->net_type == RDMA_NETWORK_IPV4) {
 			__be32 saddr = av->sgid_addr.saddr_in.sin_addr.s_addr;
 			__be32 daddr = av->dgid_addr.saddr_in.sin_addr.s_addr;
-- 
1.8.3.1

