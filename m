Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5477F25
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2019 13:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfG1LPT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Jul 2019 07:15:19 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47494 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbfG1LPT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Jul 2019 07:15:19 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6SBFGB1018429;
        Sun, 28 Jul 2019 04:15:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=e0ct45Q8gllBLoQ/O4fMryyfw3+LGAzSPQ4RgJPOX30=;
 b=SJek3UBLkvI1wbcKxaxVw04qreYJWgU5cHca53cOIYomPtNYthMx8drfMiTCwFp88kl2
 FGzTcRlQD0MHguB8c09THjwULcvtp8XnPDKV+7i7+Ao3zkBrBS1otjKde5nJ1a4wO5y4
 N/KB5T9gsuN36OV4QbedrMXDBU6g8pCC7iO234qAqO9G+6j3vDkXAolyi609BWObqIm1
 pA6JwP9MzMCiDFqKX1liLibtwp1wm/m6rCVwFyL4cXdEWCMXQFPQRrvtpqjNUTvBlmFy
 wemYla5QhPodisisk00i6qYW7Bi7Gzn/JnXRv4qnBxDMNiFX+jPFT0OCWKQ0OVqyljVz eg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2u0p4kuemh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 04:15:16 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 28 Jul
 2019 04:15:15 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Sun, 28 Jul 2019 04:15:15 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id EFC703F7048;
        Sun, 28 Jul 2019 04:15:13 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-rc] RDMA/qedr: Fix the hca_type and hca_rev returned in device attributes
Date:   Sun, 28 Jul 2019 14:13:38 +0300
Message-ID: <20190728111338.21930-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-28_06:2019-07-26,2019-07-28 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There was a place holder for hca_type and vendor was returned
in hca_rev. Fix the hca_rev to return the hw revision and fix
the hca_type to return an informative string representing the
hca.

Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 5ebf3c53b3fb..94063d743073 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -125,14 +125,20 @@ static ssize_t hw_rev_show(struct device *device, struct device_attribute *attr,
 	struct qedr_dev *dev =
 		rdma_device_to_drv_device(device, struct qedr_dev, ibdev);
 
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n", dev->pdev->vendor);
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", dev->attr.hw_ver);
 }
 static DEVICE_ATTR_RO(hw_rev);
 
 static ssize_t hca_type_show(struct device *device,
 			     struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%s\n", "HCA_TYPE_TO_SET");
+	struct qedr_dev *dev =
+		rdma_device_to_drv_device(device, struct qedr_dev, ibdev);
+
+	return scnprintf(buf, PAGE_SIZE, "FastLinQ QL%x %s\n",
+			 dev->pdev->device,
+			 rdma_protocol_iwarp(&dev->ibdev, 1) ?
+			 "iWARP" : "RoCE");
 }
 static DEVICE_ATTR_RO(hca_type);
 
-- 
2.14.5

