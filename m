Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC3140C54F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhIOMeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 08:34:13 -0400
Received: from lpdvacalvio01.broadcom.com ([192.19.166.228]:46830 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237157AbhIOMeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 08:34:12 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BF0364E15B;
        Wed, 15 Sep 2021 05:32:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BF0364E15B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631709173;
        bh=OwS/8O7XUKTUcT2unuMO5jCQ12yrVCb0B2dsJZp2IfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDrlekARZkyHwn2h4XFaj8E0Zpu94hzoGzjCWqD5UeeMhIe8N8p3Rcgsm3Mr62cp1
         f68YGyHkpM9LaDcndFyhM8xxybnxKfvTgerXyS9qWoEFBFTR4AbXbYgZ/oMV0FDRqf
         MQiiP1XqQT4z3//PHGEoAUmors44xqCeaOwyXqd8=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2 04/12] RDMA/bnxt_re: Reduce the delay in polling for hwrm command completion
Date:   Wed, 15 Sep 2021 05:32:35 -0700
Message-Id: <1631709163-2287-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Driver has 1ms delay between the polling for atomic command completion.
Polling immediately after issuing command usually doesn't report
any completions. So all commands in the blocking path needs two
iterations. So effectively 1ms spend on each command. HW requires
much lesser time for each command. So reduce the delay to 1us
and increase the iteration count to wait for the same time.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 5d384de..947e8c5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -78,7 +78,7 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 	if (!test_bit(cbit, cmdq->cmdq_bitmap))
 		goto done;
 	do {
-		mdelay(1); /* 1m sec */
+		udelay(1);
 		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
 	} while (test_bit(cbit, cmdq->cmdq_bitmap) && --count);
 done:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 9474c00..82faa4e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -96,7 +96,7 @@ static inline void bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 
 #define RCFW_MAX_COOKIE_VALUE		0x7FFF
 #define RCFW_CMD_IS_BLOCKING		0x8000
-#define RCFW_BLOCKED_CMD_WAIT_COUNT	0x4E20
+#define RCFW_BLOCKED_CMD_WAIT_COUNT	20000000UL /* 20 sec */
 
 #define HWRM_VERSION_RCFW_CMDQ_DEPTH_CHECK 0x1000900020011ULL
 
-- 
2.5.5

