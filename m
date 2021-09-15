Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F302B40C554
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 14:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhIOMeV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 08:34:21 -0400
Received: from lpdvacalvio01.broadcom.com ([192.19.166.228]:46866 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236893AbhIOMeU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 08:34:20 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D17B04E160;
        Wed, 15 Sep 2021 05:33:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D17B04E160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631709181;
        bh=nVqJ/0xBOZQng9C/qCLAT8dwdx76wdR+bfk2DKp1ids=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSIaG/EpKnCZlv66JCfU2NDbFDivyPa6/j9m19lj6xB048vit9l0w80HCGuvxTl0q
         H29JUuOporknzKOnI5QztsLG+xGmbfz5c9zmJXe4RUZSqTtC7B7s8O+uo7snBiZ7P0
         F37uZGDwtIMd759sfo6E1rUL2dunsIfpvffzvT1g=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2 09/12] RDMA/bnxt_re: Use GFP_KERNEL in non atomic context
Date:   Wed, 15 Sep 2021 05:32:40 -0700
Message-Id: <1631709163-2287-10-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use GFP_KERNEL instead of GFP_ATOMIC while allocating
control path structures which will be only called from
non atomic context

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
v1->v2:
	Using GFP_KERNEL in bnxt_re_netdev_event also
 drivers/infiniband/hw/bnxt_re/main.c       | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4214674..488a160 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1731,7 +1731,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	}
 	if (sch_work) {
 		/* Allocate for the deferred task */
-		re_work = kzalloc(sizeof(*re_work), GFP_ATOMIC);
+		re_work = kzalloc(sizeof(*re_work), GFP_KERNEL);
 		if (re_work) {
 			get_device(&rdev->ibdev.dev);
 			re_work->rdev = rdev;
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

