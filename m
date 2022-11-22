Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D345F633183
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 01:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKVAog (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Nov 2022 19:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKVAog (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Nov 2022 19:44:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD2E09F
        for <linux-rdma@vger.kernel.org>; Mon, 21 Nov 2022 16:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669077875; x=1700613875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1uOxMnh9wKwgt1sZW5g8XnAaYuRGbXRkJM0I/Uw5pJA=;
  b=VcZU3NBCuKErv9+2DMppioD/bUDloLh/J9IXGGLtrOtFjNrRo0+fQ97a
   lu0Kr57bIE4GFAb5n7MNF50FS3Tv0tixiZHdJub37Z7T+gTuBOS54eL+2
   43j8BCj20x8y7pZyI1i+XLzOwJA6tMziTjZzOSln16bj4Y0vBADG3/TH0
   GhqX8UplhVEpDujLJ5f0OCHq2isNxtQR40gIj32qNMfMBoHpT1pwH7QMQ
   yp5V/53/xJCyIAEp9M1jM+vZzCr7Ri87zOeff8y6nVG598845vxITtQsz
   9vlmaCPb1DlwCZXxh+rDoDo/Oeb/OUxixdBbKeyKUwBy8nJu3KQpAM6tC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="294086300"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="294086300"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:44:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672297079"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="672297079"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.96.246])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:44:34 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc] RDMA/irdma: Initialize net_type before checking it
Date:   Mon, 21 Nov 2022 18:44:10 -0600
Message-Id: <20221122004410.1471-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

The av->net_type is not initialized before it is checked in
irdma_modify_qp_roce. This leads to an incorrect update to the ARP cache
and QP context. RoCEv2 connections might fail as result.

Set the net_type using rdma_gid_attr_network_type.

Fixes: 80005c43d4c8 ("RDMA/irdma: Use net_type to check network type")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index a22afbb..4da5d6f 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1242,6 +1242,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		av->attrs = attr->ah_attr;
 		rdma_gid2ip((struct sockaddr *)&av->sgid_addr, &sgid_attr->gid);
 		rdma_gid2ip((struct sockaddr *)&av->dgid_addr, &attr->ah_attr.grh.dgid);
+		av->net_type = rdma_gid_attr_network_type(sgid_attr);
 		if (av->net_type == RDMA_NETWORK_IPV6) {
 			__be32 *daddr =
 				av->dgid_addr.saddr_in6.sin6_addr.in6_u.u6_addr32;
-- 
1.8.3.1

