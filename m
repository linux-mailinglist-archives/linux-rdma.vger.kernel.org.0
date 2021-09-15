Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194D840C551
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 14:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhIOMeQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 08:34:16 -0400
Received: from lpdvacalvio01.broadcom.com ([192.19.166.228]:46842 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236893AbhIOMeP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 08:34:15 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EEEB722586;
        Wed, 15 Sep 2021 05:32:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EEEB722586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631709177;
        bh=3PRnwtbo7yG1PUZvgJf3Jg9K2oncGK5jcrOV/n6QJz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGeev+JjbMGxoDFE0EpjqLPzcK5neeRD7ncQQE1N2eNl4a1Yba5Re29ctoEFFQO/C
         GlujghnsDNoMSxiKHvqpe+nxM9XnofCyjbgbajCJetXIWVl2Am3hi83ixbh6a8Dmjf
         PW7iP1euyv54MO096ikfWfkuKLant0LjFzDKqxJU=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2 06/12] RDMA/bnxt_re: Suppress unwanted error messages
Date:   Wed, 15 Sep 2021 05:32:37 -0700
Message-Id: <1631709163-2287-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Terminal CQEs are expected during QP destroy. Avoid
the unwanted error messages.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index d0895e6..539b1a2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2854,6 +2854,7 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 	struct cq_base *hw_cqe;
 	u32 sw_cons, raw_cons;
 	int budget, rc = 0;
+	u8 type;
 
 	raw_cons = cq->hwq.cons;
 	budget = num_cqes;
@@ -2872,7 +2873,8 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 		 */
 		dma_rmb();
 		/* From the device's respective CQE format to qplib_wc*/
-		switch (hw_cqe->cqe_type_toggle & CQ_BASE_CQE_TYPE_MASK) {
+		type = hw_cqe->cqe_type_toggle & CQ_BASE_CQE_TYPE_MASK;
+		switch (type) {
 		case CQ_BASE_CQE_TYPE_REQ:
 			rc = bnxt_qplib_cq_process_req(cq,
 						       (struct cq_req *)hw_cqe,
@@ -2919,8 +2921,9 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 			/* Error while processing the CQE, just skip to the
 			 * next one
 			 */
-			dev_err(&cq->hwq.pdev->dev,
-				"process_cqe error rc = 0x%x\n", rc);
+			if (type != CQ_BASE_CQE_TYPE_TERMINAL)
+				dev_err(&cq->hwq.pdev->dev,
+					"process_cqe error rc = 0x%x\n", rc);
 		}
 		raw_cons++;
 	}
-- 
2.5.5

