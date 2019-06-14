Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7908A46410
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfFNQ2h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:28:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:4203 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNQ2h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:28:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,373,1557212400"; 
   d="scan'208";a="185009332"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2019 09:28:37 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGSa8S060705;
        Fri, 14 Jun 2019 09:28:37 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGSZQr044873;
        Fri, 14 Jun 2019 12:28:35 -0400
Subject: [PATCH for-next 6/9] IB/hfi1: Add missing INVALIDATE opcodes for
 trace
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 14 Jun 2019 12:28:35 -0400
Message-ID: <20190614162835.44714.57483.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
References: <20190614162724.44714.22604.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

This was missed in the original implementation of the
memory management extensions.

Fixes: 0db3dfa03c08 ("IB/hfi1: Work request processing for fast register mr and invalidate")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/trace_ibhdrs.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/trace_ibhdrs.h b/drivers/infiniband/hw/hfi1/trace_ibhdrs.h
index d1372cc..2f84290 100644
--- a/drivers/infiniband/hw/hfi1/trace_ibhdrs.h
+++ b/drivers/infiniband/hw/hfi1/trace_ibhdrs.h
@@ -79,6 +79,8 @@
 	ib_opcode_name(RC_ATOMIC_ACKNOWLEDGE),             \
 	ib_opcode_name(RC_COMPARE_SWAP),                   \
 	ib_opcode_name(RC_FETCH_ADD),                      \
+	ib_opcode_name(RC_SEND_LAST_WITH_INVALIDATE),      \
+	ib_opcode_name(RC_SEND_ONLY_WITH_INVALIDATE),      \
 	ib_opcode_name(TID_RDMA_WRITE_REQ),	           \
 	ib_opcode_name(TID_RDMA_WRITE_RESP),	           \
 	ib_opcode_name(TID_RDMA_WRITE_DATA),	           \

