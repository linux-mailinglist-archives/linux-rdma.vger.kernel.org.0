Return-Path: <linux-rdma+bounces-2496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D68C669E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D832C28269E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A05129E8E;
	Wed, 15 May 2024 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Stl2WT2D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2612D1EB;
	Wed, 15 May 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777670; cv=none; b=lEbgAakJs7jUrJ1NJ6r98N0AyH1iFMquqm4LWNDHB0rohz/jMRA6VHN+xImAEAPq20Ye0td838tyRyyU89NGby6XKYkwgiArSwQoieaanvJI3Jd0qMrBZb8/AY6MLAOPdkhw5YhuBcn69bG8Twkj3Ydfq3rP8NJZCWZhIylsHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777670; c=relaxed/simple;
	bh=WDczq20XbWRkd6erlw7nKOvVwrFt2POHObD/O5KkuIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJnMUNALiIaJnEaTdqX/I10PiFAM5dd9BbbF7o28ll5JriT5faSVJ4y/SHRiKGT7BILXy8+sq+i940lf2fuBTgBhpb3x5/rwoB1AFUagg6XZpmAbXHfz9xO0aZi9TNKgSDgPL13exincqgNsvkH1tBkWFhs+evtmJXY8B4nKeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Stl2WT2D; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44F7nmhU007983;
	Wed, 15 May 2024 12:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=Oul7kiaHhrfZm4+kHLzEtR9tfTF72t6p8eV981BEwMs=;
 b=Stl2WT2D3dUP3PdsN7iX9vIfmcdXi13jHmxVEn1gCFzFXFsMHDbVezfv3ahd3GzWYpxH
 Orcvt54dz4gkROZSox0YWAKms0v6sxJZvUoW66MLUpnaza6KzRxbnNRVTsGKaoKlO4Rl
 PG04pkr6+zKkOgNm3XR8+7/4Myop1IpYG46uc5F8XnQ3ImYuwx9l8YMxOHifNWnkzj1J
 ot/uGeB2Pp3d9dSXxq0yCJXh02jx5mnjW8Ab8ldwZowvArPxiLk3Q4jNUpYOLWo23ve0
 PDKeBaoiYJUhlQ7SU91D3N9ihXVkLUFzqoUfDw3RGBtfuazaqOhtjR7y1JqG/+aeSt8E qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3txc2xy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:54:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FCoUj4038301;
	Wed, 15 May 2024 12:54:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24pxguyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:54:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FCmlrm038458;
	Wed, 15 May 2024 12:54:11 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y24pxgud9-6;
	Wed, 15 May 2024 12:54:11 +0000
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
Subject: [PATCH v2 5/6] RDMA/mlx5: Brute force GFP_NOIO
Date: Wed, 15 May 2024 14:53:41 +0200
Message-Id: <20240515125342.1069999-6-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515125342.1069999-1-haakon.bugge@oracle.com>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
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
 definitions=2024-05-15_06,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150090
X-Proofpoint-GUID: uqAvpFv5BDNlq6wgEzrgXWF0NFwsdt3m
X-Proofpoint-ORIG-GUID: uqAvpFv5BDNlq6wgEzrgXWF0NFwsdt3m

In mlx5_ib_init(), we call memalloc_noio_{save,restore} in a parenthetic
fashion when enabled by the module parameter force_noio.

This in order to conditionally enable mlx5_ib to work aligned with
I/O devices. Any work queued later on work-queues created during
module initialization will inherit the PF_MEMALLOC_{NOIO,NOFS}
flag(s), due to commit ("workqueue: Inherit NOIO and NOFS alloc
flags").

We do this in order to enable ULPs using the RDMA stack and the
mlx5_ib driver to be used as a network block I/O device. This to
support a filesystem on top of a raw block device which uses said
ULP(s) and the RDMA stack as the network transport layer.

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
 drivers/infiniband/hw/mlx5/main.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c2b557e642906..a424d518538ed 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -56,6 +56,10 @@ MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) IB driver");
 MODULE_LICENSE("Dual BSD/GPL");
 
+static bool mlx5_ib_force_noio;
+module_param_named(force_noio, mlx5_ib_force_noio, bool, 0444);
+MODULE_PARM_DESC(force_noio, "Force the use of GFP_NOIO (Y/N)");
+
 struct mlx5_ib_event_work {
 	struct work_struct	work;
 	union {
@@ -4489,16 +4493,23 @@ static struct auxiliary_driver mlx5r_driver = {
 
 static int __init mlx5_ib_init(void)
 {
+	unsigned int noio_flags;
 	int ret;
 
+	if (mlx5_ib_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	xlt_emergency_page = (void *)__get_free_page(GFP_KERNEL);
-	if (!xlt_emergency_page)
-		return -ENOMEM;
+	if (!xlt_emergency_page) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	mlx5_ib_event_wq = alloc_ordered_workqueue("mlx5_ib_event_wq", 0);
 	if (!mlx5_ib_event_wq) {
 		free_page((unsigned long)xlt_emergency_page);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	ret = mlx5_ib_qp_event_init();
@@ -4515,7 +4526,7 @@ static int __init mlx5_ib_init(void)
 	ret = auxiliary_driver_register(&mlx5r_driver);
 	if (ret)
 		goto drv_err;
-	return 0;
+	goto out;
 
 drv_err:
 	auxiliary_driver_unregister(&mlx5r_mp_driver);
@@ -4526,6 +4537,9 @@ static int __init mlx5_ib_init(void)
 qp_event_err:
 	destroy_workqueue(mlx5_ib_event_wq);
 	free_page((unsigned long)xlt_emergency_page);
+out:
+	if (mlx5_ib_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 }
 
-- 
2.45.0


