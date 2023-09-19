Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9F97A573C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 04:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjISCIc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 22:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjISCIb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 22:08:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7425210D
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695089306; x=1726625306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oh8DRvrWLIX3+LXUWExSTre4yU4ohIVH0zsRdDuAlN4=;
  b=EgqWlDnt/SEcp+cLYbYhfcCm7BwapZH5aVe0i05cWCri76pnJkW5/UW+
   83fdvsYtaRcTkoCnfmTqI54ExB3qI3OaY/KcT9CqYFL1RjYQTqiN2USr5
   v6I+AGmbJaDMQ9Jr0WYd/ffZtf2p6f7LtRKFAvu+VlvLaQi55mO46h3Jh
   g17++45E5km+2AHPViHLzbRSj/r1bIxQ+3cwNy44ydUejdEZ35FdhZdSs
   fPZkAzyXIvtMNDYI1164kVBd0wG3zSCJTz/DVXYuoyPPz8LAvH5nbeq40
   YBdYONJZ43shQlXel83Z6wVXLll2bYtylSR48DD4IMcNXU+NZWnjhO5xd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="360085989"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="360085989"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 19:08:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722694157"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="722694157"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga006.jf.intel.com with ESMTP; 18 Sep 2023 19:08:23 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not initialized fully
Date:   Tue, 19 Sep 2023 10:08:06 +0800
Message-Id: <20230919020806.534183-1-yanjun.zhu@intel.com>
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

No functionality change. The variable which is not initialized fully
will introduce potential risks.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 3696f367ff51..d80edfffd2e4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -255,7 +255,7 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
 static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
 		     u32 max_send_wr, u32 max_recv_wr, u32 max_sge)
 {
-	struct ib_qp_init_attr init_attr = {NULL};
+	struct ib_qp_init_attr init_attr = {};
 	struct rdma_cm_id *cm_id = con->cm_id;
 	int ret;
 
-- 
2.40.1

