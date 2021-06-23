Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E733B1F43
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFWROY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 13:14:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37939 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWROX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Jun 2021 13:14:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lw6Pz-0008Oj-69; Wed, 23 Jun 2021 17:12:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/bnxt_re: Fix uninitialized struct bit field rsvd1
Date:   Wed, 23 Jun 2021 18:12:02 +0100
Message-Id: <20210623171202.161107-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The bit field rsvd1 in resp is not being initialized and garbage data
is being copied from the stack back to userspace via the ib_copy_to_udata
call. Fix this by setting rsvd1 to zero. Also remove some whitespace.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 879740517dab ("RDMA/bnxt_re: Update ABI to pass wqe-mode to user space")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5955713234cb..45398f1777aa 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3880,7 +3880,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	resp.pg_size = PAGE_SIZE;
 	resp.cqe_sz = sizeof(struct cq_base);
 	resp.max_cqd = dev_attr->max_cq_wqes;
-	resp.rsvd    = 0;
+	resp.rsvd = 0;
+	resp.rsvd1 = 0;
 
 	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
 	resp.mode = rdev->chip_ctx->modes.wqe_mode;
-- 
2.31.1

