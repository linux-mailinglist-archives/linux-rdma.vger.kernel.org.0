Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBEB61A61C
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Nov 2022 00:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKDXuJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Nov 2022 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDXuI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Nov 2022 19:50:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4E32078
        for <linux-rdma@vger.kernel.org>; Fri,  4 Nov 2022 16:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667605808; x=1699141808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D1pM2CVSN3ErJS0HZAqBA0+8BXb1ffaW2hp33a90mx4=;
  b=KQ0qTHKh3SOwBjG0oOJdUtVqU6YXcTHPeTAjglT4Zic+3W7cAuMmxmjm
   yBpdndn8lY8xouaGXVeCKCt8G85Uj7/cbNxKMy3qGcZN5o+l6yHf6+CYD
   Ho4Rd+ML4mCAqJTiTjpDH4fh53GCrpmOpBZ4585EfLNqsQ9y9fVLm1KG5
   ejb0QsIVokrA80C7D/k3+4cSJlVk/+xxwzoRnETI04fd51mvlHaPc8iYZ
   /TiruALJdeEcX+z6wxXnGTdwGfN9HKzcoRMZQfsk/To0TUsH8yqcWPDVR
   9ocsUBYkOUb3e/zkeQ+jPaz0F3rQRgKKrb8tkp8fLjqGa49ZhOxYswfXV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="336807322"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="336807322"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 16:50:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="613244802"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="613244802"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.38.106])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 16:50:07 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] irdma: Report the correct link speed
Date:   Fri,  4 Nov 2022 18:49:57 -0500
Message-Id: <20221104234957.1135-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The active link speed is currently hard-coded in irdma_query_port due
to which the port rate in ibstatus does reflect the active link speed.

Call ib_get_eth_speed in irdma_query_port to get the active link speed.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Reported-by: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index bfa790c..21d1e3b 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -64,36 +64,6 @@ static int irdma_query_device(struct ib_device *ibdev,
 }
 
 /**
- * irdma_get_eth_speed_and_width - Get IB port speed and width from netdev speed
- * @link_speed: netdev phy link speed
- * @active_speed: IB port speed
- * @active_width: IB port width
- */
-static void irdma_get_eth_speed_and_width(u32 link_speed, u16 *active_speed,
-					  u8 *active_width)
-{
-	if (link_speed <= SPEED_1000) {
-		*active_width = IB_WIDTH_1X;
-		*active_speed = IB_SPEED_SDR;
-	} else if (link_speed <= SPEED_10000) {
-		*active_width = IB_WIDTH_1X;
-		*active_speed = IB_SPEED_FDR10;
-	} else if (link_speed <= SPEED_20000) {
-		*active_width = IB_WIDTH_4X;
-		*active_speed = IB_SPEED_DDR;
-	} else if (link_speed <= SPEED_25000) {
-		*active_width = IB_WIDTH_1X;
-		*active_speed = IB_SPEED_EDR;
-	} else if (link_speed <= SPEED_40000) {
-		*active_width = IB_WIDTH_4X;
-		*active_speed = IB_SPEED_FDR10;
-	} else {
-		*active_width = IB_WIDTH_4X;
-		*active_speed = IB_SPEED_EDR;
-	}
-}
-
-/**
  * irdma_query_port - get port attributes
  * @ibdev: device pointer from stack
  * @port: port number for query
@@ -120,8 +90,8 @@ static int irdma_query_port(struct ib_device *ibdev, u32 port,
 		props->state = IB_PORT_DOWN;
 		props->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 	}
-	irdma_get_eth_speed_and_width(SPEED_100000, &props->active_speed,
-				      &props->active_width);
+
+	ib_get_eth_speed(ibdev, port, &props->active_speed, &props->active_width);
 
 	if (rdma_protocol_roce(ibdev, 1)) {
 		props->gid_tbl_len = 32;
-- 
1.8.3.1

