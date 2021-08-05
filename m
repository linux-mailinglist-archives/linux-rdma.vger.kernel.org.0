Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3FF3E1943
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhHEQNw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 12:13:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:39946 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHEQNw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Aug 2021 12:13:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="211087610"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="211087610"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 09:12:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="419877075"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.212.48.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 09:12:24 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-core] irdma: Restore full memory barrier for doorbell optimization
Date:   Thu,  5 Aug 2021 11:11:34 -0500
Message-Id: <20210805161134.1234-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

During the irdma library upstream submission we agreed to
replace atomic_thread_fence(memory_order_seq_cst) in the irdma
doorbell optimization algorithm with udma_to_device_barrier().
However, further regression testing uncovered cases where in
absence of a full memory barrier, the algorithm incorrectly
skips ringing the doorbell.

There has been a discussion about the necessity of a full
memory barrier for the doorbell optimization in the past:
https://lore.kernel.org/linux-rdma/20170301172920.GA11340@ssaleem-MOBL4.amr.corp.intel.com/

The algorithm decides whether to ring the doorbell based on input
from the shadow memory (hw_tail). If the hw_tail is behind the sq_head,
then the algorithm doesn't ring the doorbell, because it assumes that
the HW is still actively processing WQEs.

The shadow area indicates the last WQE processed by the HW and it is
okay if the shadow area value isn't the most current. However there
can't be a window of time between reading the shadow area and setting
the valid bit for the last WQE posted, because the HW may go idle and
the algorithm won't detect this.

The following two cases illustrate this issue and are identical,
except for ops ordering. The first case is an example of how
the wrong order results in not ringing the doorbell when the
HW has gone idle.

Case 1. Failing case without a full memory barrier

Write a WQE#3

Read shadow (hw tail)

hw tail = WQE#1 (i.e. WQE#1 has been processed),
then the algorithm doesn't ring the doorbell. However, in the window
of time between reading the shadow area and setting the valid bit,
the HW goes idle after processing WQE#2
(the valid bit for WQE#3 was clear when we read the shadow area).

Set valid bit for WQE#3

----------------------------------------------------------------------

Case 2. Passing case with a full memory barrier

Write a WQE#3

Set valid bit for WQE#3

Read shadow (hw tail)

hw tail = WQE#1 (i.e. WQE#1 has been processed),
then the algorithm doesn't ring the doorbell. The HW is active
and is expected to see and process WQE#3 before going idle.

----------------------------------------------------------------------

This patch restores the full memory barrier required for the doorbell
optimization.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 providers/irdma/uk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/providers/irdma/uk.c b/providers/irdma/uk.c
index c7053c52..d63996db 100644
--- a/providers/irdma/uk.c
+++ b/providers/irdma/uk.c
@@ -118,7 +118,7 @@ void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp)
 	__u32 sw_sq_head;
 
 	/* valid bit is written and loads completed before reading shadow */
-	udma_to_device_barrier();
+	atomic_thread_fence(memory_order_seq_cst);
 
 	/* read the doorbell shadow area */
 	get_64bit_val(qp->shadow_area, 0, &temp);
-- 
2.27.0

