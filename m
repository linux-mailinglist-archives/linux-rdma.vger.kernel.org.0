Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3B407F2F
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 20:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhILSQz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 14:16:55 -0400
Received: from saphodev.broadcom.com ([192.19.11.229]:34464 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233916AbhILSQw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 14:16:52 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1CDEB80F2;
        Sun, 12 Sep 2021 11:15:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1CDEB80F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631470538;
        bh=E3XCEESZgzKH29m0WvT24w6bj8bAAcepBaXOBiEJjEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOiQsibmTjGyKZlyXTJWq5TQnlLUZT1h5xMkiN+miO55kKbDGlRlpH76uPziLSi9M
         w9nhNcLCrq8VD0HXgEGAByuBzbmgtVj5QFHim9hyvMHFEGGeSu/QRvhdHoNQEUSYu9
         XO2JhApZqKcYldjYkgcLw2B/as7rar1JjgxA0hgg=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 05/12] RDMA/bnxt_re: Support multiple page sizes
Date:   Sun, 12 Sep 2021 11:15:19 -0700
Message-Id: <1631470526-22228-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HW can support multiple page sizes. Enable bits
for enabling sizes from 4k to 1G by reporting
page_size_cap.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 2 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 5b85620..39a5677 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -57,6 +57,8 @@
 #define BNXT_RE_PAGE_SIZE_8M		BIT(BNXT_RE_PAGE_SHIFT_8M)
 #define BNXT_RE_PAGE_SIZE_1G		BIT(BNXT_RE_PAGE_SHIFT_1G)
 
+#define BNXT_RE_PAGE_SIZE_SUPPORTED	0x7FFFF000 /* 4kb - 1G */
+
 #define BNXT_RE_MAX_MR_SIZE_LOW		BIT_ULL(BNXT_RE_PAGE_SHIFT_1G)
 #define BNXT_RE_MAX_MR_SIZE_HIGH	BIT_ULL(39)
 #define BNXT_RE_MAX_MR_SIZE		BNXT_RE_MAX_MR_SIZE_HIGH
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 22e3668..c4d7a9e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -133,7 +133,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	bnxt_qplib_get_guid(rdev->netdev->dev_addr,
 			    (u8 *)&ib_attr->sys_image_guid);
 	ib_attr->max_mr_size = BNXT_RE_MAX_MR_SIZE;
-	ib_attr->page_size_cap = BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M;
+	ib_attr->page_size_cap = BNXT_RE_PAGE_SIZE_SUPPORTED;
 
 	ib_attr->vendor_id = rdev->en_dev->pdev->vendor;
 	ib_attr->vendor_part_id = rdev->en_dev->pdev->device;
@@ -3807,7 +3807,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 
 	mr->qplib_mr.va = virt_addr;
 	page_size = ib_umem_find_best_pgsz(
-		umem, BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M, virt_addr);
+		umem, BNXT_RE_PAGE_SIZE_SUPPORTED, virt_addr);
 	if (!page_size) {
 		ibdev_err(&rdev->ibdev, "umem page size unsupported!");
 		rc = -EFAULT;
-- 
2.5.5

