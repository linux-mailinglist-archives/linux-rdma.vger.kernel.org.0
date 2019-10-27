Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5048EE653C
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 21:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfJ0UHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 16:07:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:49832 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727624AbfJ0UHU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 16:07:20 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9RK5QqG011432;
        Sun, 27 Oct 2019 13:07:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=FrlTSif4HCyK40y/ytODEPuyWZ6b8h91SrxkazVz7DU=;
 b=FGjVMmUKtlCm+yZYhqkPvcQSR3uM+0OZ+lhv0GS+o9eUJTKdrvM2qlNGS813/pI5OIsj
 csqe2s+0BtW7kMx9EWdPhbluDdtEkvfeBOOg2xrwKt/Jch7efoUdq99J3d3NpJskHIR7
 7QPSgq23oKT9LCWMbab+Ki1TDCsSULDDp38av5q0DgQSsm4W5rprr5+55EjdRopPPR6x
 Z83BDJIPObZJ2xRea1L16BSPYMgh5XlR8/55zEtdwWZSc2RzUBeUQF05GS8unxxnzDja
 /s3GTVTiWRWTHxOJiiwWLHkwuAViNFVRzsCDic64uowq3B1WPPQSSAIqi7b4SDPxfGm0 lQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vvkgq3qc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 27 Oct 2019 13:07:18 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 27 Oct
 2019 13:07:17 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Sun, 27 Oct 2019 13:07:17 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id DB05F3F703F;
        Sun, 27 Oct 2019 13:07:15 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v4 rdma-next 1/4] RDMA/qedr: Fix srqs xarray initialization
Date:   Sun, 27 Oct 2019 22:04:48 +0200
Message-ID: <20191027200451.28187-2-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191027200451.28187-1-michal.kalderon@marvell.com>
References: <20191027200451.28187-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-27_08:2019-10-25,2019-10-27 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There was a missing initialization for the srqs xarray.
SRQs xarray can also be called from irq context when searching
for an element and uses the xa_XXX_irq apis, therefore should
be initialized with IRQ flags.

Fixes: 9fd15987ed27 ("qedr: Convert srqidr to XArray")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 5136b835e1ba..aa0bda428690 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -357,6 +357,7 @@ static int qedr_alloc_resources(struct qedr_dev *dev)
 		return -ENOMEM;
 
 	spin_lock_init(&dev->sgid_lock);
+	xa_init_flags(&dev->srqs, XA_FLAGS_LOCK_IRQ);
 
 	if (IS_IWARP(dev)) {
 		xa_init_flags(&dev->qps, XA_FLAGS_LOCK_IRQ);
-- 
2.14.5

