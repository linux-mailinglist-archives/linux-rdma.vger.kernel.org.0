Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32014BF5AA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 11:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiBVKWy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 05:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiBVKWu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 05:22:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87DB811BC
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 02:22:25 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251423890"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251423890"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 02:22:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532171983"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2022 02:22:23 -0800
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCHv2 2/3] RDMA/irdma: Remove the unnecessary variable saddr
Date:   Tue, 22 Feb 2022 21:42:51 -0500
Message-Id: <20220223024252.3873736-3-yanjun.zhu@linux.dev>
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

Firstly the variable saddr was to check the type of a network. Now the
variable net_type is used to do the same work. So it is removed.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 -
 drivers/infiniband/hw/irdma/verbs.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b306c50d0f8e..7e4d0cc9222f 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4155,7 +4155,6 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	struct irdma_ah_info *ah_info;
 	struct irdma_create_ah_resp uresp;
 	union {
-		struct sockaddr saddr;
 		struct sockaddr_in saddr_in;
 		struct sockaddr_in6 saddr_in6;
 	} sgid_addr, dgid_addr;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index d0fdef8d09ea..d2d4a7e5f954 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -29,7 +29,6 @@ struct irdma_av {
 	u8 macaddr[16];
 	struct rdma_ah_attr attrs;
 	union {
-		struct sockaddr saddr;
 		struct sockaddr_in saddr_in;
 		struct sockaddr_in6 saddr_in6;
 	} sgid_addr, dgid_addr;
-- 
2.27.0

