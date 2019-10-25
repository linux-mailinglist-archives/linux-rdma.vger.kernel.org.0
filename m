Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2BE4A8C
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfJYL41 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 07:56:27 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:31710 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388266AbfJYL41 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 07:56:27 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x9PAv65W012246;
        Fri, 25 Oct 2019 03:57:08 -0700
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: [PATCH for-rc] iw_cxgb4: report correct port speed/width
Date:   Fri, 25 Oct 2019 16:27:02 +0530
Message-Id: <1572001022-4533-1-git-send-email-bharat@chelsio.com>
X-Mailer: git-send-email 2.3.9
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

query speed/width from corresponding netdev.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/provider.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index d373ac0fe2cb..ba83d942997c 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -305,7 +305,10 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 static int c4iw_query_port(struct ib_device *ibdev, u8 port,
 			   struct ib_port_attr *props)
 {
+	int ret = 0;
 	pr_debug("ibdev %p\n", ibdev);
+	ret = ib_get_eth_speed(ibdev, port, &props->active_speed,
+			       &props->active_width);
 
 	props->port_cap_flags =
 	    IB_PORT_CM_SUP |
@@ -315,11 +318,9 @@ static int c4iw_query_port(struct ib_device *ibdev, u8 port,
 	    IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
 	props->gid_tbl_len = 1;
 	props->pkey_tbl_len = 1;
-	props->active_width = 2;
-	props->active_speed = IB_SPEED_DDR;
 	props->max_msg_sz = -1;
 
-	return 0;
+	return ret;
 }
 
 static ssize_t hw_rev_show(struct device *dev,
-- 
2.3.9

