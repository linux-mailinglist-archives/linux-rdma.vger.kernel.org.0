Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15C2C615F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 10:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgK0JJM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 04:09:12 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38408 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbgK0JJL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Nov 2020 04:09:11 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AR90riE013660;
        Fri, 27 Nov 2020 01:09:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=KBJ8saTS4DVFd3+vhSIw78hK4zyk2IrRwvg+G2pFTvo=;
 b=A3FgAB0HZppPAXFxYwQwFmthhqU/Luk4HV/T4duLoxQZwfk0B8LGIiWLAwpy/j/Cj87w
 XAhlV+SUrfCkKMWTzttfNd6GYC0G5099QrK6maBUYvZyasicncsP/xFFFUNIhoFFttNl
 9TSZZCXjy+A2wl/JmrzDulzW974aa25gKYQ659XTuWaoJqWk4RmapTZk+zHoJB6oED8S
 D+B3QkcU2Sgr6UV+Rwvfxeq7K1MDfldFDoM3WFDcDqWfQOXUuxiMhBBfTeGqCZ6u332b
 5WFgdDZXxRlHSP6EWySbwM0WcmkhaaocdnDdIGm93fY3xA8DJqZeku6VhfpDkd4wpSyE LQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 34y39rmjcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 01:09:01 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Nov
 2020 01:08:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 01:08:59 -0800
Received: from alpha-dell-r720.punelab.qlogic.com032qlogic.org032qlogic.com032mv.qlogic.com032av.na032marvell.com (unknown [10.30.45.91])
        by maili.marvell.com (Postfix) with ESMTP id 64A623F7041;
        Fri, 27 Nov 2020 01:08:56 -0800 (PST)
From:   Alok Prasad <palok@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>
CC:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <linux-rdma@vger.kernel.org>, Alok Prasad <palok@marvell.com>,
        "Michal Kalderon" <mkalderon@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>
Subject: [PATCH for-rc] RDMA/qedr: iWARP invalid(zero) doorbell address fix.
Date:   Fri, 27 Nov 2020 09:08:32 +0000
Message-ID: <20201127090832.11191-1-palok@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_05:2020-11-26,2020-11-27 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch fixes issue introduced by a previous commit
where iWARP doorbell address wasn't initialized, causing
call trace when any RDMA application wants to use this
interface.

Fixes: 06e8d1df46ed ("RDMA/qedr: Add support for user mode XRC-SRQ's")
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 019642ff24a7..511c95bb3d01 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1936,6 +1936,15 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	}
 
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
+		qp->urq.db_rec_db2_addr = ctx->dpi_addr + uresp.rq_db2_offset;
+
+		/* calculate the db_rec_db2 data since it is constant so no
+		 * need to reflect from user
+		 */
+		qp->urq.db_rec_db2_data.data.icid = cpu_to_le16(qp->icid);
+		qp->urq.db_rec_db2_data.data.value =
+			cpu_to_le16(DQ_TCM_IWARP_POST_RQ_CF_CMD);
+
 		rc = qedr_db_recovery_add(dev, qp->urq.db_rec_db2_addr,
 					  &qp->urq.db_rec_db2_data,
 					  DB_REC_WIDTH_32B,
-- 
2.27.0

