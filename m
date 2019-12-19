Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC34126FA2
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 22:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLSVTo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 16:19:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:28912 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfLSVTo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 16:19:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 13:19:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; 
   d="scan'208";a="228380996"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga002.jf.intel.com with ESMTP; 19 Dec 2019 13:19:43 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xBJLJhBh002717;
        Thu, 19 Dec 2019 14:19:43 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xBJLJf7s058668;
        Thu, 19 Dec 2019 16:19:41 -0500
Subject: [PATCH for-rc 4/4] IB/hfi1: Don't cancel unused work item
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Thu, 19 Dec 2019 16:19:41 -0500
Message-ID: <20191219211941.58387.39883.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191219211609.58387.86077.stgit@awfm-01.aw.intel.com>
References: <20191219211609.58387.86077.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

In iowait structure, two iowait_work entries were included to queue
a given object: one for normal IB operations, and the other for TID
RDMA operations. For non-TID RDMA operations, the iowait_work structure
for TID RDMA is initialized to contain a NULL function (not used).
When the QP is reset, the function iowait_cancel_work will be called
to cancel any pending work. The problem is that this function will
call cancel_work_sync for both iowait_work entries, even though the
one for TID RDMA is not used at all. Eventually, the call cascades to
__flush_work, wherein a WARN_ON will be triggered due to the fact that
work->func is NULL.

The WARN_ON was introduced in the following commit:
commit 4d43d395fed1 ("workqueue: Try to catch flush_work() without INIT_WORK().")

This patch fixes the issue by making sure that a work function is
present for TID RDMA before calling cancel_work_sync in
iowait_cancel_work.

Fixes: 5da0fc9dbf89 ("IB/hfi1: Prepare resource waits for dual leg")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/iowait.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/iowait.c b/drivers/infiniband/hw/hfi1/iowait.c
index adb4a1b..5836fe7 100644
--- a/drivers/infiniband/hw/hfi1/iowait.c
+++ b/drivers/infiniband/hw/hfi1/iowait.c
@@ -81,7 +81,9 @@ void iowait_init(struct iowait *wait, u32 tx_limit,
 void iowait_cancel_work(struct iowait *w)
 {
 	cancel_work_sync(&iowait_get_ib_work(w)->iowork);
-	cancel_work_sync(&iowait_get_tid_work(w)->iowork);
+	/* Make sure that the iowork for TID RDMA is used */
+	if (iowait_get_tid_work(w)->iowork.func)
+		cancel_work_sync(&iowait_get_tid_work(w)->iowork);
 }
 
 /**

