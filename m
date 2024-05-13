Return-Path: <linux-rdma+bounces-2452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6678C411B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 14:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF961F229B0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137EA15218D;
	Mon, 13 May 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MbWUFJZn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6731509BD;
	Mon, 13 May 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604883; cv=none; b=sdR0I2SX9bLNMGuMWaW+FmD6cn3W1JruMz5NNv/6ZiqWwtbp2HXnJkEPAfFt9T7HJV/LBkDL8nnMDkBkZZ0Fvpf2ThcZh9Bmt2wXvWN8jkj6Y68Jq1UGvVddRl3+TS5WQmdpZIiEc8Ea277zTyxBmADntVUnMzbJyhyG5QCJ8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604883; c=relaxed/simple;
	bh=oxl1ym6mi/SyjSBKVlmVpnQ0uofCDWlg5sdaLw1dFIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHgYpuFpgAQ/sd9AYfMiCODB2Cu3hyzeBgoXBcjYQz1PQFo8DXFVNPvCy9rwwd9eZtpA+zj+ioHizw//3QfRCowM1M7a63AjpKZpF2WBQAm7lCBB+szZeC5lKnqBVIA+/vPZpdW5y44bR7MA+wrDKi6XuA30Y9UQfn5n1vkgNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MbWUFJZn; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DCpFdT029490;
	Mon, 13 May 2024 12:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=1pik2gCJFSSaZXqxNjqmXYOc3tAx749635UY+gY8Dck=;
 b=MbWUFJZnpI1iBoyQUkkO8xC1ESvhkftaSd8IagGQK6dR24euJKsY//p3+UEkoivcrPlu
 JR3dId2A353cWvzMzol4G4EDwI5L4J7eCLEpkbUFEWNlPwSFF1BUrms2SNttz400x2er
 I+y3iHXujQ8MbVwEBqZI+icKw2IxvADEBikcpWh4LuYMs7dGw5fqM0/Eo6SbpUoxyRG9
 jrgGYmfE9JvhKJv4WE2IFM+5w5lyKOB4QEJS0B2hNEMM0ll13qhvNcZFCp7v7JZevycP
 E836Z0kEK2Ok37emgV04u0EGGJwbwtEypI8ii3bxkFlXBjfcXKvymjd+D4rPewgGRzyb 2Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3h4vg82q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 12:54:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DBUHIJ018081;
	Mon, 13 May 2024 12:54:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4c13b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 12:54:27 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44DCq988001819;
	Mon, 13 May 2024 12:54:27 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y1y4c12sj-5;
	Mon, 13 May 2024 12:54:27 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH 4/6] RDMA/cm: Brute force GFP_NOIO
Date: Mon, 13 May 2024 14:53:44 +0200
Message-Id: <20240513125346.764076-5-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240513125346.764076-1-haakon.bugge@oracle.com>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_08,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130082
X-Proofpoint-GUID: WgP0Gbq6W0_dadF2J4IoTaCH58UaEYGa
X-Proofpoint-ORIG-GUID: WgP0Gbq6W0_dadF2J4IoTaCH58UaEYGa

In ib_cm_init(), we call memalloc_noio_{save,restore} in a parenthetic
fashion when enabled by the module parameter force_noio.

This in order to conditionally enable ib_cm to work aligned with block
I/O devices. Any work queued later on work-queues created during
module initialization will inherit the PF_MEMALLOC_{NOIO,NOFS}
flag(s), due to commit ("workqueue: Inherit NOIO and NOFS alloc
flags").

We do this in order to enable ULPs using the RDMA stack to be used as
a network block I/O device. This to support a filesystem on top of a
raw block device which uses said ULP(s) and the RDMA stack as the
network transport layer.

Under intense memory pressure, we get memory reclaims. Assume the
filesystem reclaims memory, goes to the raw block device, which calls
into the ULP in question, which calls the RDMA stack. Now, if regular
GFP_KERNEL allocations in ULP or the RDMA stack require reclaims to be
fulfilled, we end up in a circular dependency.

We break this circular dependency by:

1. Force all allocations in the ULP and the relevant RDMA stack to use
   GFP_NOIO, by means of a parenthetic use of
   memalloc_noio_{save,restore} on all relevant entry points.

2. Make sure work-queues inherits current->flags
   wrt. PF_MEMALLOC_{NOIO,NOFS}, such that work executed on the
   work-queue inherits the same flag(s).

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 07fb8d3c037f0..767eec38eb57d 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -22,6 +22,7 @@
 #include <linux/workqueue.h>
 #include <linux/kdev_t.h>
 #include <linux/etherdevice.h>
+#include <linux/sched/mm.h>
 
 #include <rdma/ib_cache.h>
 #include <rdma/ib_cm.h>
@@ -35,6 +36,11 @@ MODULE_DESCRIPTION("InfiniBand CM");
 MODULE_LICENSE("Dual BSD/GPL");
 
 #define CM_DESTROY_ID_WAIT_TIMEOUT 10000 /* msecs */
+
+static bool cm_force_noio;
+module_param_named(force_noio, cm_force_noio, bool, 0444);
+MODULE_PARM_DESC(force_noio, "Force the use of GFP_NOIO (Y/N)");
+
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
 	[IB_CM_REJ_NO_EEC]			= "no EEC",
@@ -4504,6 +4510,10 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 static int __init ib_cm_init(void)
 {
 	int ret;
+	unsigned int noio_flags;
+
+	if (cm_force_noio)
+		noio_flags = memalloc_noio_save();
 
 	INIT_LIST_HEAD(&cm.device_list);
 	rwlock_init(&cm.device_lock);
@@ -4527,10 +4537,13 @@ static int __init ib_cm_init(void)
 	if (ret)
 		goto error3;
 
-	return 0;
+	goto error2;
 error3:
 	destroy_workqueue(cm.wq);
 error2:
+	if (cm_force_noio)
+		memalloc_noio_restore(noio_flags);
+
 	return ret;
 }
 
-- 
2.39.3


