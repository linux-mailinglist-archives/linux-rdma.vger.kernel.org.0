Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424ED7A5B3A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjISHiB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 03:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjISHhz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 03:37:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656311F
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695109069; x=1726645069;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1hFOHOesRL6U2PlMb2ZYvfBkyMbnNF8vkDsAkmHId5U=;
  b=DyqmNL8Z390F06kzvegu9FYQyOOCYURerAQG/kASs54fRmnwcKF93Z9O
   qaD/tUO5rNOe7BxWh9bbNDdzx3/9+hKKkNGO8kgpGiEO8qGNYhpknvgEl
   EU9BeYA4WmDLf2KdeWv0O6mfKZkLgKYmmtVXR1fYR2uOruhgvF3vuKDLG
   Iui4Dgt5gJuu5dAVHeMcrvHGIYDTZWCOxkrwcbcpnia10o9pKwk6jejyU
   nTJJanZ4yicSkG95FjJKaF+pUDy2UmSA2sqC7WI5j6rgWgE+HEB9vQGw4
   f/CWddZwLKQdqajOKE8JpmYDQwaE2rMJiRyD5y6cLCCAo+V3qEoIvXSNm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383696897"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="383696897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 00:37:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="869874613"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="869874613"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga004.jf.intel.com with ESMTP; 19 Sep 2023 00:37:46 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v2 1/1] RDMA/rtrs: Require holding rcu_read_lock explicitly
Date:   Tue, 19 Sep 2023 15:37:27 +0800
Message-Id: <20230919073727.540207-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
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

From: Zhu Yanjun <yanjun.zhu@linux.dev>

No functional change. The function get_next_path_rr needs to hold
rcu_read_lock. As such, if no rcu read lock, warnings will pop out.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1->V2: Replace WARN_ON_ONCE with RCU_LOCKDEP_WARN
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b6ee801fd0ff..07261523c554 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -775,7 +775,7 @@ rtrs_clt_get_next_path_or_null(struct list_head *head, struct rtrs_clt_path *clt
  * Related to @MP_POLICY_RR
  *
  * Locks:
- *    rcu_read_lock() must be hold.
+ *    rcu_read_lock() must be held.
  */
 static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
 {
@@ -783,6 +783,11 @@ static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
 	struct rtrs_clt_path *path;
 	struct rtrs_clt_sess *clt;
 
+	/*
+	 * Assert that rcu lock must be held
+	 */
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
+
 	clt = it->clt;
 
 	/*
-- 
2.27.0

