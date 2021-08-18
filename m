Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651FC3F0D0A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 22:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhHRU6S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 16:58:18 -0400
Received: from lpdvsmtp10.broadcom.com ([192.19.11.229]:41452 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233338AbhHRU6R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 16:58:17 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 581C6E9;
        Wed, 18 Aug 2021 13:57:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 581C6E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1629320262;
        bh=eQLBe5vJS8MSATaxDvP5qfMSX3DMGNlo8R8QM/uumwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KT2C8Zmv8IoguM/NiqVuWFexMsO/bBi3Ddt87Ry5hKHyvGeRGhw35sDvpoI7dLMA+
         cCqciH9Vt20GYS6xoZ6+uCsJCwIi6FQpyMa536dbbG9T4bSUxFqEMa1jWxPLBSyn+E
         YGDiqtVCE0lVMXHLBeye76TQMgFZIb7DGskpNNUo=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 1/3] RDMA/bnxt_re: Disable atomic support on VFs
Date:   Wed, 18 Aug 2021 13:57:34 -0700
Message-Id: <1629320256-4034-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1629320256-4034-1-git-send-email-selvin.xavier@broadcom.com>
References: <1629320256-4034-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Atomics is not currently supported for VFs. Enabling only
for PFs.

Fixes: 35f5ace5dea4 ("RDMA/bnxt_re: Enable global atomic ops if platform supports")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a8688a9..f6d4c54 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -129,7 +129,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	rdev->rcfw.res = &rdev->qplib_res;
 
 	bnxt_re_set_drv_mode(rdev, wqe_mode);
-	if (bnxt_qplib_determine_atomics(en_dev->pdev))
+	if (!rdev->qplib_res.is_vf && bnxt_qplib_determine_atomics(en_dev->pdev))
 		ibdev_info(&rdev->ibdev,
 			   "platform doesn't support global atomics.");
 	return 0;
-- 
2.5.5

