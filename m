Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33FA2871FF
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgJHJwJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 05:52:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49078 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgJHJwJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 05:52:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kQSaj-0008Tm-3D; Thu, 08 Oct 2020 09:52:05 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/rdmavt: Fix sizeof mismatch
Date:   Thu,  8 Oct 2020 10:52:04 +0100
Message-Id: <20201008095204.82683-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An incorrect sizeof is being used, struct rvt_ibport ** is not correct,
it should be struct rvt_ibport *. Note that since ** is the same size as
* this is not causing any issues.  Improve this fix by using
sizeof(*rdi->ports) as this allows us to not even reference the type
of the pointer.  Also remove line breaks as the entire statement can
fit on one line.

Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
Fixes: ff6acd69518e ("IB/rdmavt: Add device structure allocation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/sw/rdmavt/vt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index f904bb34477a..2d534c450f3c 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -95,9 +95,7 @@ struct rvt_dev_info *rvt_alloc_device(size_t size, int nports)
 	if (!rdi)
 		return rdi;
 
-	rdi->ports = kcalloc(nports,
-			     sizeof(struct rvt_ibport **),
-			     GFP_KERNEL);
+	rdi->ports = kcalloc(nports, sizeof(*rdi->ports), GFP_KERNEL);
 	if (!rdi->ports)
 		ib_dealloc_device(&rdi->ibdev);
 
-- 
2.27.0

