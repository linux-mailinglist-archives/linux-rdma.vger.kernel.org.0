Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDEB3B2042
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFWS1L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 14:27:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39813 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFWS07 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Jun 2021 14:26:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lw7YD-0008WV-J8; Wed, 23 Jun 2021 18:24:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] RDMA/bnxt_re: Fix uninitialized struct bit field rsvd1
Date:   Wed, 23 Jun 2021 19:24:37 +0100
Message-Id: <20210623182437.163801-1-colin.king@canonical.com>
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
call. Fix this by setting the entire struct resp to zero; this will ensure
that further new bit fields in the future will be zero'd too.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 879740517dab ("RDMA/bnxt_re: Update ABI to pass wqe-mode to user space")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: set entire struct resp to zero rather than the new field. Thanks to
    Jason Gunthorpe for suggesting this improved fix.

---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5955713234cb..6d4508794342 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3844,7 +3844,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		container_of(ctx, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
-	struct bnxt_re_uctx_resp resp;
+	struct bnxt_re_uctx_resp resp = {};
 	u32 chip_met_rev_num = 0;
 	int rc;
 
-- 
2.31.1

