Return-Path: <linux-rdma+bounces-4981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD19197B96B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B77282D1B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738291741F0;
	Wed, 18 Sep 2024 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EfOAsC7y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484A78276;
	Wed, 18 Sep 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648571; cv=none; b=C5WOG7WvZfNYi6hnTn6ansDjo+wLS7mAjs5fVSElbTiExeXT8e8SPHgG6zbqwID7cFykTQU86I4pDr+Mc8ro5tbmGZ4U1DI6XhTU+6GT1P0/DJS0xvE0LDsaIGHJfTcyY/2ws1plAY/LNPKoyOO+aB27WblhmgVNBZ+YBi3ewNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648571; c=relaxed/simple;
	bh=azTz4oKYtBbwKjhXuZO6bye0svRN1gTi51SYvZZgnpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHRuAnPIYZLVDxG6J2yBvt2QgHmjTWK4BbKgMvYRH5wrVzX3TIrKKKVcm8mtm6S62QliZ7sS31vAez7Eh6dhHdpv7t2Y4MSdizlfSS1Ns/NVjWkY8Q9/KXbPlU5URf5SKhxKDDhH//S/k46vDCDVJXDhNybTjk/4Vaj4b2tQvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EfOAsC7y; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7twYd031866;
	Wed, 18 Sep 2024 08:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	corp-2023-11-20; bh=SMpGMSK5QiT+EAP4hBegW4Vj7pusBqETJivS3nKKK+w=; b=
	EfOAsC7y1J9egTsrljq2jCn9iS25HP3l/HwOeNdXg9rjwXADtnzJ4sz1J1igVG40
	Q36Q4DOuc/56o4gWgEYWvpF9U8YsP6JznIltE6adOhu8EvrVmfKdbBaEpH+HSF8I
	WmYx/N0YZKf1Aaq/XRs3cUFrmcpSfawVxbqnV+OEQGsfBdrPcTG+IpI++916tllm
	2VihA7zhCnsBcv+dNasy633ThqSzRAjzc4rVfc/2YKa1ZygBrqdMRDYSRSBzB+0a
	D0Ptg7cT/9c0X2Q1/4q6dt4B+YaBEg36QHhw7QAp9SMYiMHRJQydKgQZ0ml2AGBv
	CH1xYlCKEwmww5gcUCIRaA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3gnhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 08:36:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7U5Sc010493;
	Wed, 18 Sep 2024 08:36:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb7yt21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 08:35:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48I8Zu48022467;
	Wed, 18 Sep 2024 08:35:59 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nyb7ystx-2;
	Wed, 18 Sep 2024 08:35:59 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com
Subject: [MAINLINE 1/2] RDMA/core: Enable legacy ULPs to use RDMA DIM
Date: Wed, 18 Sep 2024 10:35:51 +0200
Message-ID: <20240918083552.77531-2-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240918083552.77531-1-haakon.bugge@oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_06,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180053
X-Proofpoint-GUID: hOZummPjxIhAd6BLYkzUxpcIZZLKIdmo
X-Proofpoint-ORIG-GUID: hOZummPjxIhAd6BLYkzUxpcIZZLKIdmo

The RDMA DIM mechanism is not available for legacy ULPs using
ib_create_cq(). Hence, enable it in ib_create_cq_user() if
IB_CQ_MODERATE is set in cq_attr.flags.

This way, legacy ULPs can take advantage of RDMA DIM.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cq.c    |  7 +++++--
 drivers/infiniband/core/cq.h    | 16 ++++++++++++++++
 drivers/infiniband/core/verbs.c |  6 ++++++
 3 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/core/cq.h

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index a70876a0a2312..8e582eca6987f 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -7,6 +7,7 @@
 #include <rdma/ib_verbs.h>
 
 #include "core_priv.h"
+#include "cq.h"
 
 #include <trace/events/rdma_core.h>
 /* Max size for shared CQ, may require tuning */
@@ -50,7 +51,7 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
 	cq->device->ops.modify_cq(cq, comps, usec);
 }
 
-static void rdma_dim_init(struct ib_cq *cq)
+void rdma_dim_init(struct ib_cq *cq)
 {
 	struct dim *dim;
 
@@ -70,8 +71,9 @@ static void rdma_dim_init(struct ib_cq *cq)
 
 	INIT_WORK(&dim->work, ib_cq_rdma_dim_work);
 }
+EXPORT_SYMBOL(rdma_dim_init);
 
-static void rdma_dim_destroy(struct ib_cq *cq)
+void rdma_dim_destroy(struct ib_cq *cq)
 {
 	if (!cq->dim)
 		return;
@@ -79,6 +81,7 @@ static void rdma_dim_destroy(struct ib_cq *cq)
 	cancel_work_sync(&cq->dim->work);
 	kfree(cq->dim);
 }
+EXPORT_SYMBOL(rdma_dim_destroy);
 
 static int __poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
 {
diff --git a/drivers/infiniband/core/cq.h b/drivers/infiniband/core/cq.h
new file mode 100644
index 0000000000000..c55f7d3f1cbf4
--- /dev/null
+++ b/drivers/infiniband/core/cq.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Let other files use rdma_dim_{init,destroy}
+ *
+ * Author: Håkon Bugge <haakon.bugge@oracle.com>
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ */
+
+#ifndef CQ_H
+#define CQ_H
+
+void rdma_dim_init(struct ib_cq *cq);
+void rdma_dim_destroy(struct ib_cq *cq);
+
+#endif
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 473ee0831307c..60a64ea77ae25 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -53,6 +53,7 @@
 #include <rdma/lag.h>
 
 #include "core_priv.h"
+#include "cq.h"
 #include <trace/events/rdma_core.h>
 
 static int ib_resolve_eth_dmac(struct ib_device *device,
@@ -2161,6 +2162,9 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 		return ERR_PTR(ret);
 	}
 
+	if (cq_attr->flags & IB_CQ_MODERATE)
+		rdma_dim_init(cq);
+
 	rdma_restrack_add(&cq->res);
 	return cq;
 }
@@ -2187,6 +2191,8 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (atomic_read(&cq->usecnt))
 		return -EBUSY;
 
+	rdma_dim_destroy(cq);
+
 	ret = cq->device->ops.destroy_cq(cq, udata);
 	if (ret)
 		return ret;
-- 
2.43.5


