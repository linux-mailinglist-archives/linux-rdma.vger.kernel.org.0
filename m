Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBC264670A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 03:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLHCgx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 21:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHCgv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 21:36:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3272C900DF
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 18:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670467010; x=1702003010;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FmEf7GNphPcuvnC8ABq5wmE9xX0DS/VrYkCn3FP8vbM=;
  b=hsSVPLpZMYlfi+aimFCeXVrdPR7fAsaVpci1s1sCAzVjAGw/8YmDb8DY
   0vxqJrIHpWjIITEeH/4VDHOBOrLQy9/h6DGc43OobtxVlbaObHaeq3+bh
   GS5CvOT9dPAQQDpU6RLWDXZ2Xf8lONSTN0hbP/9/o9VmkWUzkzUvPjTeL
   LtAlzn5SIX3XjY9yH5PGm1nv7PHD35O23Q+1tCYAxxhAa+9lezEbb4pX4
   knm1DjIFpAHAUDtgt+x9s4dLhGwXcaGrxo8GxRC4JOnP/ns6jyJ0YpHlO
   ukXdgQvbIQn6XPS0zHfVbJJta16Y2PxvsIApE7/9m+sj6/Kcf38hN4MRn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315773642"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="315773642"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 18:36:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="648965676"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="648965676"
Received: from unknown (HELO intel-52-85.bj.intel.com) ([10.238.154.85])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2022 18:36:40 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/mlx5: Mlx5 does not support IB_FLOW_SPEC_IB
Date:   Thu,  8 Dec 2022 05:19:54 -0500
Message-Id: <20221208101954.687960-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

IB_FLOW_SPEC_IB is not supported in MLX5. As such, LAST_IB_FIELD need
not be checked.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/mlx5/fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 490ec308e309..3008632a6c20 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -127,7 +127,6 @@ static int check_mpls_supp_fields(u32 field_support, const __be32 *set_mask)
 }
 
 #define LAST_ETH_FIELD vlan_tag
-#define LAST_IB_FIELD sl
 #define LAST_IPV4_FIELD tos
 #define LAST_IPV6_FIELD traffic_class
 #define LAST_TCP_UDP_FIELD src_port
-- 
2.27.0

