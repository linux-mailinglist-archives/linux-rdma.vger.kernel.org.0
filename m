Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463847562D
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 19:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403897AbfGYRth (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 13:49:37 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:23464 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbfGYRte (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 13:49:34 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x6PHnVia007752;
        Thu, 25 Jul 2019 10:49:31 -0700
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: [PATCH rdma-core 2/2] cxgb4: remove unused c4iw_match_device
Date:   Thu, 25 Jul 2019 23:19:28 +0530
Message-Id: <20190725174928.26863-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.18.0.232.gb7bd9486b055
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

match_device handler is no longer needed after latest device binding changes.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 providers/cxgb4/dev.c | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/providers/cxgb4/dev.c b/providers/cxgb4/dev.c
index 84711993ea32..b6f991529bdb 100644
--- a/providers/cxgb4/dev.c
+++ b/providers/cxgb4/dev.c
@@ -403,46 +403,6 @@ void dump_state(void)
  */
 int c4iw_abi_version = 1;
 
-static bool c4iw_device_match(struct verbs_sysfs_dev *sysfs_dev)
-{
-	char value[32], *cp;
-	unsigned int fw_maj, fw_min;
-
-	/* Rely on the core code to match PCI devices */
-	if (!sysfs_dev->match)
-		return false;
-
-	/*
-	 * Verify that the firmware major number matches.  Major number
-	 * mismatches are fatal.  Minor number mismatches are tolerated.
-	 */
-	if (ibv_get_fw_ver(value, sizeof(value), sysfs_dev))
-		return false;
-
-	cp = strtok(value+1, ".");
-	sscanf(cp, "%i", &fw_maj);
-	cp = strtok(NULL, ".");
-	sscanf(cp, "%i", &fw_min);
-
-	if ((signed int)fw_maj < FW_MAJ) {
-		fprintf(stderr, "libcxgb4: Fatal firmware version mismatch.  "
-			"Firmware major number is %u and libcxgb4 needs %u.\n",
-			fw_maj, FW_MAJ);
-		fflush(stderr);
-		return false;
-	}
-
-	DBGLOG("libcxgb4");
-
-	if ((signed int)fw_min < FW_MIN) {
-		PDBG("libcxgb4: non-fatal firmware version mismatch.  "
-			"Firmware minor number is %u and libcxgb4 needs %u.\n",
-			fw_min, FW_MIN);
-		fflush(stderr);
-	}
-	return true;
-}
-
 static struct verbs_device *c4iw_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
 {
 	struct c4iw_dev *dev;
@@ -498,7 +458,6 @@ static const struct verbs_device_ops c4iw_dev_ops = {
 	.match_min_abi_version = 0,
 	.match_max_abi_version = INT_MAX,
 	.match_table = hca_table,
-	.match_device = c4iw_device_match,
 	.alloc_device = c4iw_device_alloc,
 	.uninit_device = c4iw_uninit_device,
 	.alloc_context = c4iw_alloc_context,
-- 
2.18.0.232.gb7bd9486b055

