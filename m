Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 373D823076
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfETJfo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 05:35:44 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35132 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727720AbfETJfn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 05:35:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4K9ZetD032347;
        Mon, 20 May 2019 02:35:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=nOMDGy8n7M+fOMEYbiJ56sg1YsPvYthLqQSlLW8NhiI=;
 b=eI0NW8kQ0hMBsRQZbWwwHv+ruyLyv8rd7ZWMs+VU0m7iFyL/3BOcSXAOzvloKeMEOZe+
 jc+DQw2bkTWNQNviByD9dMyWWHXXLINJTYpsRIiKsERMPy37ZJBx6gLAAruhVmI/7xPb
 bmeUr9SxoI8xaDkV0Wn0K2KO/i7aNhZf8cBa8oT1xGZZCaE4woac0msCM6fPHG3mMyoA
 5ErI+8mZo4d77f1BRinIiCyVs84npZX5sRmUhsVMbuuQ7pZr/yKAbaGDuQAWG124DB6B
 +mQiwn1DhZcnX+1i0TCi6zLB+i8RMGYuvVfafdm9DbIzyfE/ls5eLBo9DIdFQiQAD6ha 4A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sjhjjqh4n-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 20 May 2019 02:35:42 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 20 May
 2019 02:34:12 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 20 May 2019 02:34:12 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 551C93F703F;
        Mon, 20 May 2019 02:34:11 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <sagiv.ozeri@marvell.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v2 rdma] RDMA/qedr: Fix incorrect device rate.
Date:   Mon, 20 May 2019 12:33:20 +0300
Message-ID: <20190520093320.3831-1-michal.kalderon@marvell.com>
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
v1 --> v2
Removed empty line after "Fixes"

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

