Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2638F45C
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfHOTUq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 15:20:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:27809 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfHOTUq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 15:20:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 12:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="376480183"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2019 12:20:43 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x7FJKelj038476;
        Thu, 15 Aug 2019 12:20:40 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x7FJKdvp106006;
        Thu, 15 Aug 2019 15:20:39 -0400
Subject: [PATCH for-rc 2/5] IB/hfi1: Unsafe PSN checking for TID RDMA READ
 Resp packet
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 15 Aug 2019 15:20:39 -0400
Message-ID: <20190815192039.105923.7852.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190815192013.105923.63792.stgit@awfm-01.aw.intel.com>
References: <20190815192013.105923.63792.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

When processing a TID RDMA READ RESP packet that causes KDETH EFLAGS
errors, the packet's IB PSN is checked against qp->s_last_psn and
qp->s_psn without the protection of qp->s_lock, which is not safe.

This patch fixes the issue by acquiring qp->s_lock first.

Fixes: 9905bf06e890 ("IB/hfi1: Add functions to receive TID RDMA READ response")
Cc: <stable@vger.kernel.org>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 9407014..01c8b02 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -2687,12 +2687,12 @@ static bool handle_read_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 	u32 fpsn;
 
 	lockdep_assert_held(&qp->r_lock);
+	spin_lock(&qp->s_lock);
 	/* If the psn is out of valid range, drop the packet */
 	if (cmp_psn(ibpsn, qp->s_last_psn) < 0 ||
 	    cmp_psn(ibpsn, qp->s_psn) > 0)
-		return ret;
+		goto s_unlock;
 
-	spin_lock(&qp->s_lock);
 	/*
 	 * Note that NAKs implicitly ACK outstanding SEND and RDMA write
 	 * requests and implicitly NAK RDMA read and atomic requests issued

