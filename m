Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A35187471
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 22:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbgCPVE5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 17:04:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:62409 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbgCPVE5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 17:04:57 -0400
IronPort-SDR: +teh1Cyis9qlO8bIQq0fCnDst9QymCeQl9QydaP+mUt++xn42CYhOdP74ov7IAqZkI2Eo6rEWo
 CEndGi7nTC8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 14:04:56 -0700
IronPort-SDR: XQANXr5HrDV0astfXVj0W1gQlOcbI0kekkSkx71+sA5FHH+piURGaQTeV1O1CgXbpyuWB70ha2
 NMhXDvC/QIrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="445264524"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2020 14:04:56 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02GL4tcO017716;
        Mon, 16 Mar 2020 14:04:56 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02GL4sk2007923;
        Mon, 16 Mar 2020 17:04:54 -0400
Subject: [PATCH for-next 1/3] IB/rdmavt: Delete unused routine
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 16 Mar 2020 17:04:54 -0400
Message-ID: <20200316210454.7753.94689.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

This routine was obsoleted by the patch below.

Delete it.

Fixes: a2a074ef396f ("RDMA: Handle ucontext allocations by IB/core")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/sw/rdmavt/vt.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 986265a..72b031a 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -284,12 +284,6 @@ static int rvt_query_gid(struct ib_device *ibdev, u8 port_num,
 					 &gid->global.interface_id);
 }
 
-static inline struct rvt_ucontext *to_iucontext(struct ib_ucontext
-						*ibucontext)
-{
-	return container_of(ibucontext, struct rvt_ucontext, ibucontext);
-}
-
 /**
  * rvt_alloc_ucontext - Allocate a user context
  * @uctx: Verbs context

