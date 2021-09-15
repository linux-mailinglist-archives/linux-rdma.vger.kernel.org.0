Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3258640C54E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbhIOMeL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 08:34:11 -0400
Received: from lpdvsmtp09.broadcom.com ([192.19.166.228]:46824 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237746AbhIOMeL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 08:34:11 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2A1C04E14B;
        Wed, 15 Sep 2021 05:32:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2A1C04E14B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631709172;
        bh=7z2JRqlvnJAMM03fCjG1X+CEjJxRdMq0j8cyXx0PzWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiFSBs/EWli0xpP3yGn8vmibmcyjBn/FSqKOjpXhtom4au+iCz5CmTuHIv+FIzcAv
         nMbc/Z7P0uYfmO1IvNilEtomCdRnsmSyBXdxxzHFQmofAKznmEl87lfGehFCe71u93
         3EsK7UdaWq1nmeKObaq2rBTAZaLP5GLlzFDZLz2I=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2 03/12] RDMA/bnxt_re: Use separate response buffer for stat_ctx_free
Date:   Wed, 15 Sep 2021 05:32:34 -0700
Message-Id: <1631709163-2287-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edwin Peer <edwin.peer@broadcom.com>

Use separate buffers for the request and response data. Eventhough
the response data is not used, providing the correct length is
appropriate.

Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index e4f39d8..4214674 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -525,7 +525,8 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 				      u32 fw_stats_ctx_id)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
-	struct hwrm_stat_ctx_free_input req = {0};
+	struct hwrm_stat_ctx_free_input req = {};
+	struct hwrm_stat_ctx_free_output resp = {};
 	struct bnxt_fw_msg fw_msg;
 	int rc = -EINVAL;
 
@@ -539,8 +540,8 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 
 	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_FREE, -1, -1);
 	req.stat_ctx_id = cpu_to_le32(fw_stats_ctx_id);
-	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&req,
-			    sizeof(req), DFLT_HWRM_CMD_TIMEOUT);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
 	rc = en_dev->en_ops->bnxt_send_fw_msg(en_dev, BNXT_ROCE_ULP, &fw_msg);
 	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to free HW stats context %#x",
-- 
2.5.5

