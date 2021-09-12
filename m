Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F41407F32
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhILSQ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 14:16:59 -0400
Received: from lpdvsmtp10.broadcom.com ([192.19.11.229]:34494 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235206AbhILSQ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 14:16:58 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 141AF80F0;
        Sun, 12 Sep 2021 11:15:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 141AF80F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631470543;
        bh=er4yw3hikk1giKGvDE9AP/Uz/0Rwlwja+8X9FFi/X8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfBQxiJO5BE7tpaiXRmKsROQZ6WF6Rf+vwErofD50ly5GguzSro/xzQTigU0BBGdN
         s+QEfkxX/E/GVi54cYNYpdvK3iklny7YfMvympfVQ/TsHrB6xjT/FSqUpoo7jTzckD
         NMfx9yZMMyAkLZvpGYtqpbgu3sP7g51MbNvw5oCc=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 08/12] RDMA/bnxt_re: Fix FRMR issue with single page MR allocation
Date:   Sun, 12 Sep 2021 11:15:22 -0700
Message-Id: <1631470526-22228-9-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When the FRMR is allocated with single page, driver is
attempting to create a level 0 HWQ and not allocating any page
because the nopte field is set. This causes the crash during post_send
as the pbl is not populated.

To avoid this crash, check for the nopte bit during HWQ
creation with single page and create a level 1 page table
and populate the pbl address correctly.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 44282a8..bf49363 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -228,15 +228,16 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 				npages++;
 	}
 
-	if (npages == MAX_PBL_LVL_0_PGS) {
+	if (npages == MAX_PBL_LVL_0_PGS && !hwq_attr->sginfo->nopte) {
 		/* This request is Level 0, map PTE */
 		rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], hwq_attr->sginfo);
 		if (rc)
 			goto fail;
 		hwq->level = PBL_LVL_0;
+		goto done;
 	}
 
-	if (npages > MAX_PBL_LVL_0_PGS) {
+	if (npages >= MAX_PBL_LVL_0_PGS) {
 		if (npages > MAX_PBL_LVL_1_PGS) {
 			u32 flag = (hwq_attr->type == HWQ_TYPE_L2_CMPL) ?
 				    0 : PTU_PTE_VALID;
-- 
2.5.5

