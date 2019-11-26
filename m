Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20285109FFF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2019 15:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfKZONM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 09:13:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:45598 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbfKZONM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Nov 2019 09:13:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 06:13:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="409989575"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga006.fm.intel.com with ESMTP; 26 Nov 2019 06:13:11 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xAQEDBh4042075;
        Tue, 26 Nov 2019 07:13:11 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xAQED9xk059158;
        Tue, 26 Nov 2019 09:13:10 -0500
Subject: [PATCH for-next v2 10/11] IB/rdmavt: Correct comments in
 rdmavt_qp.h header
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Tue, 26 Nov 2019 09:13:09 -0500
Message-ID: <20191126141309.58836.66443.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
References: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

Comments need to be with the definition of rvt_restart_sge().

Other comments were duplicated in sw/rdmavt/rc.c and were
removed.

Fixes: 385156c5f2a6 ("IB/hfi: Move RC functions into a header file")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/sw/rdmavt/rc.c |    9 ++++++++-
 include/rdma/rdmavt_qp.h          |   22 +---------------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/rc.c b/drivers/infiniband/sw/rdmavt/rc.c
index 890d7b7..977906c 100644
--- a/drivers/infiniband/sw/rdmavt/rc.c
+++ b/drivers/infiniband/sw/rdmavt/rc.c
@@ -195,7 +195,14 @@ void rvt_get_credit(struct rvt_qp *qp, u32 aeth)
 }
 EXPORT_SYMBOL(rvt_get_credit);
 
-/* rvt_restart_sge - rewind the sge state for a wqe */
+/**
+ * rvt_restart_sge - rewind the sge state for a wqe
+ * @ss: the sge state pointer
+ * @wqe: the wqe to rewind
+ * @len: the data length from the start of the wqe in bytes
+ *
+ * Returns the remaining data length.
+ */
 u32 rvt_restart_sge(struct rvt_sge_state *ss, struct rvt_swqe *wqe, u32 len)
 {
 	ss->sge = wqe->sg_list[0];
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index b550ae8..0d5c70e 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -640,34 +640,14 @@ static inline int rvt_cmp_msn(u32 a, u32 b)
 	return (((int)a) - ((int)b)) << 8;
 }
 
-/**
- * rvt_compute_aeth - compute the AETH (syndrome + MSN)
- * @qp: the queue pair to compute the AETH for
- *
- * Returns the AETH.
- */
 __be32 rvt_compute_aeth(struct rvt_qp *qp);
 
-/**
- * rvt_get_credit - flush the send work queue of a QP
- * @qp: the qp who's send work queue to flush
- * @aeth: the Acknowledge Extended Transport Header
- *
- * The QP s_lock should be held.
- */
 void rvt_get_credit(struct rvt_qp *qp, u32 aeth);
 
-/**
- * rvt_restart_sge - rewind the sge state for a wqe
- * @ss: the sge state pointer
- * @wqe: the wqe to rewind
- * @len: the data length from the start of the wqe in bytes
- *
- * Returns the remaining data length.
- */
 u32 rvt_restart_sge(struct rvt_sge_state *ss, struct rvt_swqe *wqe, u32 len);
 
 /**
+ * rvt_div_round_up_mtu - round up divide
  * @qp - the qp pair
  * @len - the length
  *

