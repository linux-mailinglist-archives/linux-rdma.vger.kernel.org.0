Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2529B6A
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389663AbfEXPpB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 11:45:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:60933 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389583AbfEXPpB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 11:45:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 08:45:00 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2019 08:45:00 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x4OFixl0006148;
        Fri, 24 May 2019 08:45:00 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x4OFiw6R010697;
        Fri, 24 May 2019 11:44:58 -0400
Subject: [PATCH for-rc 4/5] IB/hfi1: Fix checkpatch single line if
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 24 May 2019 11:44:58 -0400
Message-ID: <20190524154458.10588.47711.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190524154320.10588.44693.stgit@awfm-01.aw.intel.com>
References: <20190524154320.10588.44693.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Recent patch to hfi1 left behind a checkpatch error. Fix it.

Fixes: fb24ea52f78e ("drivers: Remove explicit invocations of mmiowb()")
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/pio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index 16ba9d5..9190086 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -1577,9 +1577,8 @@ void hfi1_sc_wantpiobuf_intr(struct send_context *sc, u32 needint)
 	else
 		sc_del_credit_return_intr(sc);
 	trace_hfi1_wantpiointr(sc, needint, sc->credit_ctrl);
-	if (needint) {
+	if (needint)
 		sc_return_credits(sc);
-	}
 }
 
 /**

