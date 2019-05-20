Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF1223013
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfETJTf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 05:19:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60826 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729598AbfETJTf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 05:19:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4K9BMsg012817;
        Mon, 20 May 2019 02:19:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=xr69cf0+E0HNIA1RwiqIpWXoNhuOKwiIdQ32tKxogrQ=;
 b=Tlteet5skv0GyRz3HdDQkF6wUtlhIQ+GdCYopSDA0QsqOewTx9UxhcOY6CB4i143beoN
 qOS4HKJxFkB1v8+T81SdIakz4OwQZvQ6EdXC9WpVGwgn1YB5O2ng3heaUAlFz4QIJ8l9
 +7bc6Y/qgywv3GRPwj6WYppvUKxWlJEHLgIY4grs9ah9Q2s7yfHfL5qr8fL/AtJ5iKvV
 q5o4na2DvEz2fUuCwb8DDDRhg+VEqVZYKVliE/iDaeOMFRxh6arXh3zhskRA485uZLig
 sjU1f+HYiAPI7QphGaASGwkNU4kRLObn6UdqlSYCi/nY8fm0FhnQocjIcK6Q20AYuhCP Iw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sjhjjqfj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 02:19:33 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 20 May
 2019 02:19:31 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 20 May 2019 02:19:31 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 450563F703F;
        Mon, 20 May 2019 02:19:30 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <sagiv.ozeri@marvell.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma] RDMA/qedr: Fix incorrect device rate.
Date:   Mon, 20 May 2019 12:18:12 +0300
Message-ID: <20190520091812.3311-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_04:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sagiv Ozeri <sagiv.ozeri@marvell.com>

Use the correct enum value introduced in
commit 12113a35ada6 ("IB/core: Add HDR speed enum")
Prior to this change a 50Gbps port would show 40Gbps.

This patch also cleaned up the redundant redefiniton of ib speeds
for qedr.

Fixes: 12113a35ada6 ("IB/core: Add HDR speed enum")

Signed-off-by: Sagiv Ozeri <sagiv.ozeri@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index e52d8761d681..f940da2eb61e 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -159,54 +159,47 @@ int qedr_query_device(struct ib_device *ibdev,
 	return 0;
 }
 
-#define QEDR_SPEED_SDR		(1)
-#define QEDR_SPEED_DDR		(2)
-#define QEDR_SPEED_QDR		(4)
-#define QEDR_SPEED_FDR10	(8)
-#define QEDR_SPEED_FDR		(16)
-#define QEDR_SPEED_EDR		(32)
-
 static inline void get_link_speed_and_width(int speed, u8 *ib_speed,
 					    u8 *ib_width)
 {
 	switch (speed) {
 	case 1000:
-		*ib_speed = QEDR_SPEED_SDR;
+		*ib_speed = IB_SPEED_SDR;
 		*ib_width = IB_WIDTH_1X;
 		break;
 	case 10000:
-		*ib_speed = QEDR_SPEED_QDR;
+		*ib_speed = IB_SPEED_QDR;
 		*ib_width = IB_WIDTH_1X;
 		break;
 
 	case 20000:
-		*ib_speed = QEDR_SPEED_DDR;
+		*ib_speed = IB_SPEED_DDR;
 		*ib_width = IB_WIDTH_4X;
 		break;
 
 	case 25000:
-		*ib_speed = QEDR_SPEED_EDR;
+		*ib_speed = IB_SPEED_EDR;
 		*ib_width = IB_WIDTH_1X;
 		break;
 
 	case 40000:
-		*ib_speed = QEDR_SPEED_QDR;
+		*ib_speed = IB_SPEED_QDR;
 		*ib_width = IB_WIDTH_4X;
 		break;
 
 	case 50000:
-		*ib_speed = QEDR_SPEED_QDR;
-		*ib_width = IB_WIDTH_4X;
+		*ib_speed = IB_SPEED_HDR;
+		*ib_width = IB_WIDTH_1X;
 		break;
 
 	case 100000:
-		*ib_speed = QEDR_SPEED_EDR;
+		*ib_speed = IB_SPEED_EDR;
 		*ib_width = IB_WIDTH_4X;
 		break;
 
 	default:
 		/* Unsupported */
-		*ib_speed = QEDR_SPEED_SDR;
+		*ib_speed = IB_SPEED_SDR;
 		*ib_width = IB_WIDTH_1X;
 	}
 }
-- 
2.14.5

