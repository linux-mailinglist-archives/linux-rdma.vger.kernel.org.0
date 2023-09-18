Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BCB7A4E71
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjIRQSE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjIRQRz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 12:17:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D44724994
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053712; x=1726589712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZpMvMReyWpZ34t9yLSWCnm8q363yRNO2iVjm9jIOoos=;
  b=ByViEAILrgjr+bih3jarXzkW0U2lcz8JEVd3a0Sh0O+sDon893wzOeQI
   rHTWJyevQA0bW0SFSbkrTDQP2ERtn/nMrWGgVHcrTUG7dp0VQ1lFlnGkr
   /Zn9ppaPnDaYB8cNn5aFHlalpkQtDTInbttD+dWdQa0TIQpzJ39lWantq
   jzMoMbEdJq1xsT56y4trPJ0QoBEc5IoTmvz5zdT20EvlCrKAkIHs8Q6xt
   9dctgxCGbfyq/3zLkma1bEJu2kMVZtuQVb0rJ/7BX4CDsTjlLCrZxc31u
   A0EZbWW6pCjhCK7nQYIZ8zxkQSMUvpfzFfQnydgDqZO3t5NBbsUJW+IQA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379596215"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="379596215"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="816076926"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="816076926"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2023 08:37:05 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rtrs: Require holding rcu_read_lock explicitly
Date:   Mon, 18 Sep 2023 23:36:46 +0800
Message-Id: <20230918153646.338878-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

No functional change. The function get_next_path_rr needs to hold
rcu_read_lock. As such, if no rcu read lock, warnings will pop out.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b6ee801fd0ff..bc4b70318bf4 100644
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
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
 	clt = it->clt;
 
 	/*
-- 
2.40.1

