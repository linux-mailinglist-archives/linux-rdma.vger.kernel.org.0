Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2211578D4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgBJNKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:10:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:55385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbgBJNKb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:10:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:10:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="431595858"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2020 05:10:29 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADATnF007521;
        Mon, 10 Feb 2020 06:10:29 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADAQ0Z087642;
        Mon, 10 Feb 2020 08:10:27 -0500
Subject: [PATCH for-rc 1/3] IB/hfi1: Acquire lock to release TID entries
 when user file is closed
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 10 Feb 2020 08:10:26 -0500
Message-ID: <20200210131026.87408.86853.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200210130712.87408.34564.stgit@awfm-01.aw.intel.com>
References: <20200210130712.87408.34564.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

Each user context is allocated a certain number of RcvArray (TID)
entries and these entries are managed through TID groups. These groups
are put into one of three lists in each user context: tid_group_list,
tid_used_list, and tid_full_list, depending on the number of used TID
entries within each group. When TID packets are expected, one or more
TID groups will be allocated. After the packets are received, the TID
groups will be freed. Since multiple user threads may access the TID
groups simultaneously, a mutex exp_mutex is used to synchronize the
access. However, when the user file is closed, it tries to release
all TID groups without acquiring the mutex first, which risks a race
condition with another thread that may be releasing its TID groups,
leading to data corruption.

This patch addresses the issue by acquiring the mutex first before
releasing the TID groups when the file is closed.

Fixes: 3abb33ac6521 ("staging/hfi1: Add TID cache receive init and free funcs")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index f05742a..2443423 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -142,10 +142,12 @@ void hfi1_user_exp_rcv_free(struct hfi1_filedata *fd)
 {
 	struct hfi1_ctxtdata *uctxt = fd->uctxt;
 
+	mutex_lock(&uctxt->exp_mutex);
 	if (!EXP_TID_SET_EMPTY(uctxt->tid_full_list))
 		unlock_exp_tids(uctxt, &uctxt->tid_full_list, fd);
 	if (!EXP_TID_SET_EMPTY(uctxt->tid_used_list))
 		unlock_exp_tids(uctxt, &uctxt->tid_used_list, fd);
+	mutex_unlock(&uctxt->exp_mutex);
 
 	kfree(fd->invalid_tids);
 	fd->invalid_tids = NULL;

