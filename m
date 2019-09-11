Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2DAAF8E1
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 11:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfIKJ27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 05:28:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48118 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKJ27 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Sep 2019 05:28:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i7yvo-0005JO-Do; Wed, 11 Sep 2019 09:28:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/bnxt_re: fix spelling mistake "missin_resp" -> "missing_resp"
Date:   Wed, 11 Sep 2019 10:28:56 +0100
Message-Id: <20190911092856.11146-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a literal string, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 604b71875f5f..3421a0b15983 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -74,7 +74,7 @@ static const char * const bnxt_re_stat_name[] = {
 	[BNXT_RE_SEQ_ERR_NAKS_RCVD]     = "seq_err_naks_rcvd",
 	[BNXT_RE_MAX_RETRY_EXCEEDED]    = "max_retry_exceeded",
 	[BNXT_RE_RNR_NAKS_RCVD]         = "rnr_naks_rcvd",
-	[BNXT_RE_MISSING_RESP]          = "missin_resp",
+	[BNXT_RE_MISSING_RESP]          = "missing_resp",
 	[BNXT_RE_UNRECOVERABLE_ERR]     = "unrecoverable_err",
 	[BNXT_RE_BAD_RESP_ERR]          = "bad_resp_err",
 	[BNXT_RE_LOCAL_QP_OP_ERR]       = "local_qp_op_err",
-- 
2.20.1

