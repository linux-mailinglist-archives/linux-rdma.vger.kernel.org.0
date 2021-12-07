Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D7469896
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbhLFOZf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 09:25:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:33561 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242034AbhLFOZe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 09:25:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237135070"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="237135070"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 06:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="514760279"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2021 06:21:53 -0800
From:   yanjun.zhu@linux.dev
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCH 1/1] RDMA/uverbs: remove the unnecessary assignment
Date:   Tue,  7 Dec 2021 01:46:07 -0500
Message-Id: <20211207064607.541695-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The struct member variable create_flags are assigned twice.
Remove the unnecessary assignment.

Fixes: ece9ca97ccdc8 ("RDMA/uverbs: Do not check the input length on create_cq/qp paths")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/uverbs_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d1345d76d9b1..6b6393176b3c 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1399,7 +1399,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	attr.sq_sig_type   = cmd->sq_sig_all ? IB_SIGNAL_ALL_WR :
 					      IB_SIGNAL_REQ_WR;
 	attr.qp_type       = cmd->qp_type;
-	attr.create_flags  = 0;
 
 	attr.cap.max_send_wr     = cmd->max_send_wr;
 	attr.cap.max_recv_wr     = cmd->max_recv_wr;
-- 
2.27.0

