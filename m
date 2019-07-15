Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40F169954
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfGOQpz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 12:45:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:8920 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbfGOQpz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 12:45:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 09:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="365921954"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2019 09:45:54 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x6FGjsJ3033166;
        Mon, 15 Jul 2019 09:45:54 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x6FGjqdi074306;
        Mon, 15 Jul 2019 12:45:52 -0400
Subject: [PATCH 6/6] IB/hfi1: Remove unused define
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 15 Jul 2019 12:45:52 -0400
Message-ID: <20190715164552.74174.99396.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
References: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The patch noted in Fixes missed deleting the define it obsoleted.

Delete it here.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Fixes: da9de5f8527f ("IB/hfi1: Close PSM sdma_progress sleep window")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
---
 drivers/infiniband/hw/hfi1/user_sdma.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index 4d8510b0..9972e0e 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -110,12 +110,6 @@ enum pkt_q_sdma_state {
 	SDMA_PKT_Q_DEFERRED,
 };
 
-/*
- * Maximum retry attempts to submit a TX request
- * before putting the process to sleep.
- */
-#define MAX_DEFER_RETRY_COUNT 1
-
 #define SDMA_IOWAIT_TIMEOUT 1000 /* in milliseconds */
 
 #define SDMA_DBG(req, fmt, ...)				     \

