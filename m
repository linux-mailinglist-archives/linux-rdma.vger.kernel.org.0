Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7474A3C3CD8
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jul 2021 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhGKNe1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jul 2021 09:34:27 -0400
Received: from lpdvsmtp11.broadcom.com ([192.19.166.231]:55810 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231658AbhGKNe1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Jul 2021 09:34:27 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8ABC5EB;
        Sun, 11 Jul 2021 12:01:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8ABC5EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1626030101;
        bh=cqIoKerZeXEaESeKov0T0UlPGTrENI6cvsy0uqd6fG8=;
        h=From:To:Cc:Subject:Date:From;
        b=ejxpFO88M/6t8cySMkskyK93saIiuyK6H8KCpzsDF6FeIgWRjp4I8aZ3DXEikPQRc
         RpIV1hZ67SFAraG7WLMbAAxgXE35nXdPONNd94J7WfXa1LeJ9FGr4Z3XG5HufnB8Qf
         lncKHtlvl7yy7oHZYKz2wuDK8QzOunn2IsTQpu3A=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 rdma-rc] RDMA/bnxt_re: Fix stats counters
Date:   Sun, 11 Jul 2021 06:31:36 -0700
Message-Id: <1626010296-6076-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>

Stats counters are not incrementing in some adapter versions
with newer FW. This is due to the stats context length mismatch
between FW and driver. Since L2 driver updates the length correctly,
use the stats length from L2 driver while allocating the DMA'able
memory and creating the stats context.

Fixes: 9d6b648c3112 ("bnxt_en: Update firmware interface spec to 1.10.1.65.")
Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
v1 -> v2:
 Corrected the fixes tag

 drivers/infiniband/hw/bnxt_re/main.c      |  4 +++-
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 10 ++++------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 04621ba..1fadca8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -119,6 +119,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	if (!chip_ctx)
 		return -ENOMEM;
 	chip_ctx->chip_num = bp->chip_num;
+	chip_ctx->hw_stats_size = bp->hw_ring_stats_size;
 
 	rdev->chip_ctx = chip_ctx;
 	/* rest members to follow eventually */
@@ -507,6 +508,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 				       dma_addr_t dma_map,
 				       u32 *fw_stats_ctx_id)
 {
+	struct bnxt_qplib_chip_ctx *chip_ctx = rdev->chip_ctx;
 	struct hwrm_stat_ctx_alloc_output resp = {0};
 	struct hwrm_stat_ctx_alloc_input req = {0};
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
@@ -523,7 +525,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_ALLOC, -1, -1);
 	req.update_period_ms = cpu_to_le32(1000);
 	req.stats_dma_addr = cpu_to_le64(dma_map);
-	req.stats_dma_length = cpu_to_le16(sizeof(struct ctx_hw_stats_ext));
+	req.stats_dma_length = cpu_to_le16(chip_ctx->hw_stats_size);
 	req.stat_ctx_flags = STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE;
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
 			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index fa78783..72be4fb 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -56,6 +56,7 @@
 static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
 				      struct bnxt_qplib_stats *stats);
 static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
+				      struct bnxt_qplib_chip_ctx *cctx,
 				      struct bnxt_qplib_stats *stats);
 
 /* PBL */
@@ -559,7 +560,7 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 		goto fail;
 stats_alloc:
 	/* Stats */
-	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, &ctx->stats);
+	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, res->cctx, &ctx->stats);
 	if (rc)
 		goto fail;
 
@@ -888,15 +889,12 @@ static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
 }
 
 static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
+				      struct bnxt_qplib_chip_ctx *cctx,
 				      struct bnxt_qplib_stats *stats)
 {
 	memset(stats, 0, sizeof(*stats));
 	stats->fw_id = -1;
-	/* 128 byte aligned context memory is required only for 57500.
-	 * However making this unconditional, it does not harm previous
-	 * generation.
-	 */
-	stats->size = ALIGN(sizeof(struct ctx_hw_stats), 128);
+	stats->size = cctx->hw_stats_size;
 	stats->dma = dma_alloc_coherent(&pdev->dev, stats->size,
 					&stats->dma_map, GFP_KERNEL);
 	if (!stats->dma) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 7a1ab38..58bad6f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -60,6 +60,7 @@ struct bnxt_qplib_chip_ctx {
 	u16	chip_num;
 	u8	chip_rev;
 	u8	chip_metal;
+	u16	hw_stats_size;
 	struct bnxt_qplib_drv_modes modes;
 };
 
-- 
2.5.5

