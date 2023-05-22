Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7605270C2DD
	for <lists+linux-rdma@lfdr.de>; Mon, 22 May 2023 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjEVP6z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 11:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjEVP6x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 11:58:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D1A109
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684771132; x=1716307132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y0VzENVr0Jr9edv6GJw8fEJl0ApeNVsziHXVjlIIJB4=;
  b=dac8EOWgqMbj/Jx5EYwlO9CqwlIdZKmnDF75E+uL0PqmDDLZleDwT+X8
   yeUExnCWZgBEoQCD3a9T9It05Gwk6J1EY6OPGhQ9rdAFomRWHizUtA8Fg
   8dBsn+tWmZIPuIqebhWnIcEdfo+w3G8c/BZ4WfsB8jg49o7M1rU/UC07k
   TNwTNNA5/G4YcCPdrmJDzjZ1NBKFgA9tNO/C/pUCaGGF+OXAX8Ja54rJc
   4RtqZ9JFxMNCvYJGjFcs+S44iE5mnd+52I3Tq0B/hCh02q71iQ687lqy3
   rPAn0t1DGE0bqJiSLfx3ozqIpIeNezRUxoyjxoISJKjmncxIdv9+A/vP7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="337546909"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="337546909"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="734312905"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="734312905"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.172.160])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:58:49 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 2/2] RDMA/irdma: Fix Local Invalidate fencing
Date:   Mon, 22 May 2023 10:56:54 -0500
Message-Id: <20230522155654.1309-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230522155654.1309-1-shiraz.saleem@intel.com>
References: <20230522155654.1309-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

If the local invalidate fence is indicated in the WR, only the read
fence is currently being set in WQE. Fix this to set both the read and
local fence in the WQE.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 6a1c266..996e1c9 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3316,6 +3316,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 			break;
 		case IB_WR_LOCAL_INV:
 			info.op_type = IRDMA_OP_TYPE_INV_STAG;
+			info.local_fence = info.read_fence;
 			info.op.inv_local_stag.target_stag = ib_wr->ex.invalidate_rkey;
 			err = irdma_uk_stag_local_invalidate(ukqp, &info, true);
 			break;
-- 
1.8.3.1

