Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBA3DA754
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 17:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbhG2PSB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 11:18:01 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34072 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237314AbhG2PSA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 11:18:00 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TFA67X031357;
        Thu, 29 Jul 2021 08:17:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=xoUI3k7MrqxXf+gXKX9bVMUlWshWVjAuU0il6mMQcDk=;
 b=IXe1A7J0Qk/qRgskj9IJMUNXdbMzkCKXBmJ/V55O3J2uR3V4MqgIstLGFMU5gF5CKvkz
 QT72HXQR9cweCMSGFBFy91242jOe9u5c1Mhn9vpmFLAZAD3PG9tfbj2KOIgpYZIrgjFB
 3yxDVV37bdoQwK4MQU/xOiyxy1uFw3Nd7YzWkD+L5HmD29POj7f9/Czk4DiPj2uIgUX2
 wrSdsu+9rPgSluonxvZI8e5aD135Q1QFMpGntquxW+2DTrIgBT0pctyeFKWF3BeirEyn
 aIp86cUVk+i4UY16+0r6x/5Q+MU/ULvp5RyaGNirbNSP+xtBKu63Bv0bGiXUXfOJpzNe FA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3a3w5krj8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 08:17:45 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 29 Jul
 2021 08:17:44 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 29 Jul 2021 08:17:41 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <mkalderon@marvell.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH 2/2] qedr: Improve error logs for rdma_alloc_tid error return
Date:   Thu, 29 Jul 2021 18:17:32 +0300
Message-ID: <20210729151732.30995-2-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210729151732.30995-1-pkushwaha@marvell.com>
References: <20210729151732.30995-1-pkushwaha@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: oSgoGAnyewPlEshSsMikyWoIQuevYuFc
X-Proofpoint-ORIG-GUID: oSgoGAnyewPlEshSsMikyWoIQuevYuFc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use -EINVAL return type to identify whether error is returned
because of "Out of MR resources" or any other error types.

Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index fdc47ef7d861..b72ef24db657 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2996,7 +2996,11 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 
 	rc = dev->ops->rdma_alloc_tid(dev->rdma_ctx, &mr->hw_mr.itid);
 	if (rc) {
-		DP_ERR(dev, "roce alloc tid returned an error %d\n", rc);
+		if (rc == -EINVAL)
+			DP_ERR(dev, "Out of MR resources\n");
+		else
+			DP_ERR(dev, "roce alloc tid returned error %d\n", rc);
+
 		goto err1;
 	}
 
@@ -3091,7 +3095,11 @@ static struct qedr_mr *__qedr_alloc_mr(struct ib_pd *ibpd,
 
 	rc = dev->ops->rdma_alloc_tid(dev->rdma_ctx, &mr->hw_mr.itid);
 	if (rc) {
-		DP_ERR(dev, "roce alloc tid returned an error %d\n", rc);
+		if (rc == -EINVAL)
+			DP_ERR(dev, "Out of MR resources\n");
+		else
+			DP_ERR(dev, "roce alloc tid returned error %d\n", rc);
+
 		goto err0;
 	}
 
@@ -3221,7 +3229,11 @@ struct ib_mr *qedr_get_dma_mr(struct ib_pd *ibpd, int acc)
 
 	rc = dev->ops->rdma_alloc_tid(dev->rdma_ctx, &mr->hw_mr.itid);
 	if (rc) {
-		DP_ERR(dev, "roce alloc tid returned an error %d\n", rc);
+		if (rc == -EINVAL)
+			DP_ERR(dev, "Out of MR resources\n");
+		else
+			DP_ERR(dev, "roce alloc tid returned error %d\n", rc);
+
 		goto err1;
 	}
 
-- 
2.24.1

