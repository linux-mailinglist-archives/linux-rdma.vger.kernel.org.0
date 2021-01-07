Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209152ECD54
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 10:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbhAGJwV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 04:52:21 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:46316 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727905AbhAGJwU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jan 2021 04:52:20 -0500
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2021 04:52:20 EST
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-76.dhcp.broadcom.net [10.123.156.76])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7E8877DC5;
        Thu,  7 Jan 2021 01:43:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7E8877DC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1610012617;
        bh=r6eq53L0u6h64YiuotFZFYv0RJNrAkWbddVU07Wax/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeKXNP0tiIpjD+OkWKllTOe/xL03rZFEhVRF/4qltWqj1BbTzAYV7c5AKJcf8KcKA
         k/4gqDYjo2zV+PgztUmQ8RH7/BVq7Qb+BFAbivzX54ziHWNgKv/vuyQIvK3aZ4Wpv0
         VeckGcyhduQ3NlFgKmOmxnct6f6C2tI/PwlLazPk=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-next v2 2/2] RDMA/bnxt_re: Allow bigger MR creation
Date:   Thu,  7 Jan 2021 01:43:28 -0800
Message-Id: <1610012608-14528-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1610012608-14528-1-git-send-email-selvin.xavier@broadcom.com>
References: <1610012608-14528-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allow users to create bigger MRs. Remove the check that
prevented creating MRs with number of pages more than 512.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  8 --------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 14 ++------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 00d2a5a..ba515ef 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3829,14 +3829,6 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	}
 	mr->qplib_mr.total_size = length;
 
-	if (page_size == BNXT_RE_PAGE_SIZE_4K &&
-	    length > BNXT_RE_MAX_MR_SIZE_LOW) {
-		ibdev_err(&rdev->ibdev, "Requested MR Sz:%llu Max sup:%llu",
-			  length, (u64)BNXT_RE_MAX_MR_SIZE_LOW);
-		rc = -EINVAL;
-		goto free_umem;
-	}
-
 	umem_pgs = ib_umem_num_dma_blocks(umem, page_size);
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, umem,
 			       umem_pgs, page_size);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 22cb46a..049b357 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -658,24 +658,14 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	struct creq_register_mr_resp resp;
 	struct cmdq_register_mr req;
 	u16 cmd_flags = 0, level;
-	int pages, rc, pg_ptrs;
+	int pages, rc;
 	u32 pg_size;
 
 	if (num_pbls) {
+		pages = roundup_pow_of_two(num_pbls);
 		/* Allocate memory for the non-leaf pages to store buf ptrs.
 		 * Non-leaf pages always uses system PAGE_SIZE
 		 */
-		pg_ptrs = roundup_pow_of_two(num_pbls);
-		pages = pg_ptrs >> MAX_PBL_LVL_1_PGS_SHIFT;
-		if (!pages)
-			pages++;
-
-		if (pages > MAX_PBL_LVL_1_PGS) {
-			dev_err(&res->pdev->dev,
-				"SP: Reg MR: pages requested (0x%x) exceeded max (0x%x)\n",
-				pages, MAX_PBL_LVL_1_PGS);
-			return -ENOMEM;
-		}
 		/* Free the hwq if it already exist, must be a rereg */
 		if (mr->hwq.max_elements)
 			bnxt_qplib_free_hwq(res, &mr->hwq);
-- 
2.5.5

