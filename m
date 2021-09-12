Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5A407F33
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhILSRA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 14:17:00 -0400
Received: from saphodev.broadcom.com ([192.19.11.229]:34482 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234680AbhILSQ7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 14:16:59 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BA19B80FA;
        Sun, 12 Sep 2021 11:15:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BA19B80FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631470544;
        bh=ievnOljB7B54peq+oLofpM5Dq9T+jQunXI3AgrjCqEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMhQmy5Q5VkfOi5zfbKHuesIKoaQbYe1VGQ2toG6TNVp7vW9pCHBQ/hUNTjlR/Dv3
         s/BPgh58Kh7Zgit7tU/3TpXFEUMisrsaBP0j/VJKXAYveh+jBnKR7X+No2zP1APiG1
         X7Wn7II6yL6JQYucOM7JDfAkf/Aiti4NuWUgp3IU=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 09/12] RDMA/bnxt_re: Use GFP_KERNEL in non atomic context
Date:   Sun, 12 Sep 2021 11:15:23 -0700
Message-Id: <1631470526-22228-10-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use GFP_KERNEL instead of GFP_ATOMIC while allocating
control path structures which will be only called from
non atomic context

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 947e8c5..3de8547 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -848,13 +848,13 @@ struct bnxt_qplib_rcfw_sbuf *bnxt_qplib_rcfw_alloc_sbuf(
 {
 	struct bnxt_qplib_rcfw_sbuf *sbuf;
 
-	sbuf = kzalloc(sizeof(*sbuf), GFP_ATOMIC);
+	sbuf = kzalloc(sizeof(*sbuf), GFP_KERNEL);
 	if (!sbuf)
 		return NULL;
 
 	sbuf->size = size;
 	sbuf->sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf->size,
-				      &sbuf->dma_addr, GFP_ATOMIC);
+				      &sbuf->dma_addr, GFP_KERNEL);
 	if (!sbuf->sb)
 		goto bail;
 
-- 
2.5.5

