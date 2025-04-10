Return-Path: <linux-rdma+bounces-9330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5BA8432E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 14:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BED18A5C14
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F08C2853E7;
	Thu, 10 Apr 2025 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2VSPOg0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB6283691
	for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288366; cv=none; b=ap5ozeaiJwxGpPCE5cIwe7KM2H6Xz7vTpQd165XfCn6ZM87oND5Z1aUxjmlzusB9c3iNrgjS6iuhoJTBD50TryQHHASPaoG0HpjDpNGSy7F4abYDiMQMm8gi5D3mHxN6UmTbdtUGZM6f873taa9tyRkVcT6Fo+DLEJZgYrMh4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288366; c=relaxed/simple;
	bh=vn+S0DlM3LoeSR2IQBkHTU5k38XnHOL5q7D0h2qkn4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDcynT6++wyzfSfTwhdUS1zSafovFxjzLQp0xfXr5DAeWAmY8RhWqVAEVC2SIvVdTG+poqtZO994xEfckC06Cq+YUxHddOZ6zBpPEdlHLajO/DT9NYnngBVmYc2HbTvtjplX2OWJiQ3SX2+xdnOJuvQeIzdROniRdrPK48T5+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2VSPOg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EDCC4CEE8;
	Thu, 10 Apr 2025 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744288366;
	bh=vn+S0DlM3LoeSR2IQBkHTU5k38XnHOL5q7D0h2qkn4s=;
	h=From:To:Cc:Subject:Date:From;
	b=c2VSPOg061/WuXHmE4t1oDhe3jkwdc52A6kv054ZCAwb83ISlFTgmpHDJDxwyUEPq
	 FxPqYkuVmzCIOUzYZ2lugygzMyG0fmIP/0sBMrTvgB88kQj5gq/cvEFshlFU3BccYh
	 iCnptz+X4MNeeaLb4y5uT0yPp6kg+9YdEa62Zs55E7g9twOyv8tBfx5awsBz9pow8i
	 W9c1hD6eFhA6h2TQmFQhIyQYKRY7mGgJcWYaZMLok3bDxQM6sXR3QL7Pd9A02wPONQ
	 f1XUmMzA4qNu47bZA+DxEl9TJBhnpKnIElTtuLH4hDqsP2vZRcVX9+oEW+kjTZjXQt
	 I3HcxJMfLV0sw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	kernel test robot <lkp@intel.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc] RDMA/bnxt_re: Remove unusable nq variable
Date: Thu, 10 Apr 2025 15:32:20 +0300
Message-ID: <8a4343e217d7d1c0a5a786b785c4ac57cb72a2a0.1744288299.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Remove nq variable from bnxt_re_create_srq() and bnxt_re_destroy_srq()
as it generates the following compilation warnings:

>> drivers/infiniband/hw/bnxt_re/ib_verbs.c:1777:24: warning: variable
'nq' set but not used [-Wunused-but-set-variable]
    1777 |         struct bnxt_qplib_nq *nq = NULL;
         |                               ^
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:1828:24: warning: variable
'nq' set but not used [-Wunused-but-set-variable]
    1828 |         struct bnxt_qplib_nq *nq = NULL;
         |                               ^
   2 warnings generated.

Fixes: 6b395d31146a ("RDMA/bnxt_re: Fix budget handling of notification queue")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504091055.CzgXnk4C-lkp@intel.com/
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e14b05cd089a..063801384b2b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1774,10 +1774,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 					       ib_srq);
 	struct bnxt_re_dev *rdev = srq->rdev;
 	struct bnxt_qplib_srq *qplib_srq = &srq->qplib_srq;
-	struct bnxt_qplib_nq *nq = NULL;
 
-	if (qplib_srq->cq)
-		nq = qplib_srq->cq->nq;
 	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
 		free_page((unsigned long)srq->uctx_srq_page);
 		hash_del(&srq->hash_entry);
@@ -1825,7 +1822,6 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 		       struct ib_udata *udata)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
-	struct bnxt_qplib_nq *nq = NULL;
 	struct bnxt_re_ucontext *uctx;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_srq *srq;
@@ -1871,7 +1867,6 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	srq->qplib_srq.eventq_hw_ring_id = rdev->nqr->nq[0].ring_id;
 	srq->qplib_srq.sg_info.pgsize = PAGE_SIZE;
 	srq->qplib_srq.sg_info.pgshft = PAGE_SHIFT;
-	nq = &rdev->nqr->nq[0];
 
 	if (udata) {
 		rc = bnxt_re_init_user_srq(rdev, pd, srq, udata);
-- 
2.49.0


