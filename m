Return-Path: <linux-rdma+bounces-2586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F48CC2A3
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 15:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758C3281650
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838741482E2;
	Wed, 22 May 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OCZ3cQnV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E871420A2;
	Wed, 22 May 2024 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386140; cv=none; b=ZuaN4UGFGVXQTUF4jUCKw5KV+5M+qiNxBNucjbmJWdwacwjDIB/e3bQrU9GoKd1UtFLuxfDsCZZHxT/vpbtiZ+pu37N7jABRcXyctpd0JVztHMAqrNRYCrk96gysySfSdqbo4V2SWyF6EUlrNGO8R7hnwrb4TqaSh/Mu9xA3JhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386140; c=relaxed/simple;
	bh=LbTyLk9OwJkqvxmgn+6ZY6LFKU7EWl4UGi9PWLrNn7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckUehfPCWk/oaXyMv9xCHG3on6OESSrg9sTsDmyBvMsYDJy455KPmABoRVjH2+uGMoic8WFegWuppDEqXhkNpThovDj8bWobyq2inxaSvAlHShWdYIPELNydXOyd6nkwIl5C2R+k2DPBH9v/BX1ymF1QSF439+aSbOPMPOmrPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OCZ3cQnV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqkmT003018;
	Wed, 22 May 2024 13:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=GMAoVtYiZLoLVeIZtnneE3D8HNGcJZTFwILjLvpvR3Q=;
 b=OCZ3cQnValq6pt+QhSc/KNnI4n+M7lBlCSSIHIPEZ/M2H+b3JFFs5b8TD+n717tBHHxQ
 lPjmTgbeTlj9LU51DE6YVpydMd5s5OPKQAhPhVaRV5fS186LnDCnNpyAkRVCZvqwHXZY
 /XjKAyH7M+aYtxxaPLaWUfuto9I4LdejLbtg/wnAkeKGQJ6ovJgk/3sUzsdYQCA2+YD4
 mBVcO2VFUJOqnVXm80Sdn/cSSfk9vtqNjGGiLFABzyvZZJIF1iZzUIQKFIe6Rsxp7jh3
 vMBCbdrymX6l0RWc1hY3ZoulXZ7tsnEzbF2/NESL9NMDNlQ2Fp45WMJI56+Z0VBLDGyi Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b7h0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCIPwd019528;
	Wed, 22 May 2024 13:55:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js98thw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:23 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDsm3G016070;
	Wed, 22 May 2024 13:55:22 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js98su1-11;
	Wed, 22 May 2024 13:55:22 +0000
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
Subject: [PATCH v3 5/6] RDMA/mlx5: Brute force GFP_NOIO
Date: Wed, 22 May 2024 15:54:42 +0200
Message-Id: <20240522135444.1685642-11-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240522135444.1685642-1-haakon.bugge@oracle.com>
References: <20240522135444.1685642-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_07,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405220093
X-Proofpoint-ORIG-GUID: FG04WMcPX0Z_wfhlZlSwJW2V-VRH6ePq
X-Proofpoint-GUID: FG04WMcPX0Z_wfhlZlSwJW2V-VRH6ePq

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
index 2366c46eebc87..d47ef7d48f492 100644
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
@@ -4488,16 +4492,23 @@ static struct auxiliary_driver mlx5r_driver = {
 
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
@@ -4514,7 +4525,7 @@ static int __init mlx5_ib_init(void)
 	ret = auxiliary_driver_register(&mlx5r_driver);
 	if (ret)
 		goto drv_err;
-	return 0;
+	goto out;
 
 drv_err:
 	auxiliary_driver_unregister(&mlx5r_mp_driver);
@@ -4525,6 +4536,9 @@ static int __init mlx5_ib_init(void)
 qp_event_err:
 	destroy_workqueue(mlx5_ib_event_wq);
 	free_page((unsigned long)xlt_emergency_page);
+out:
+	if (mlx5_ib_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 }
 
-- 
2.31.1


