Return-Path: <linux-rdma+bounces-2578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A58CC286
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 15:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD961F23ADB
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889F91411E0;
	Wed, 22 May 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tr/pdOM2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AC1411C1;
	Wed, 22 May 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386126; cv=none; b=qvtpCsGwzVqx86/mWnhBToqMaTqdnMD/bNzIubBwc5zh6gA7CUlQWu3+Z5sVdtOJfrEyvzBqTRfTjDBopMYv5FLENwoHTSMKq8/LGRRGizhocGYNS8YEPuSFk2EA5YbjKU21o1/gcS6qhy18wMzrD4o0C1xfAfJrPA7DS1pVwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386126; c=relaxed/simple;
	bh=x+YRy/ThdkD01EFNyKjA9UeYpsvcSONGSu4lbSQxQow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn6Q2DSxl0HSC4CUjoeVAzYezcuJg/CawCd5IYe/pyY0XcF6u9JbY/Cs/5s96q1pB73MpUUzc/l+vMMfvfMEvIJPqOJKEKtvDJlQy1Gjj1NGd23hPK+bsqU3UP9VV4Guli808Ogg9AEAwAJQ9i/vhDf32FjmeksvSSy6GmqE2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tr/pdOM2; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCqdw8013783;
	Wed, 22 May 2024 13:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=R3mG6Szp+rz+nLnvrLG6Q59rBqnQhSrkmf7l+8vA1YU=;
 b=Tr/pdOM2gDcwkeBgq+dC+/8/4gQUA7awtrNFNnm/26FGbz2TXfe3QlpxfC7p0S+95A6n
 HksE2kHO9YVSMUHcj/XRoOjI+ksENUVZFwvCAnKizixhjH7BBx9iCdPrfKMVDK0t5Dvm
 7TzYXneyQu8dmUvyeGCT4lZhQ1p8rN2grzzh7+6PdsaSJksu49OYatvzdTohNgfhYZIx
 zBAfSYLP8crcZ1A8GKGQgimz6RIQsRVgWHhY+mht3Dj5BVEooEuTrGjhQM9By1aP0myk
 pFNQM6kf+tA4kJZAGmp2Iwhm7uDHg7s0UNTu0bVJASyqiAoX8cBxqeOBSFFLnE768GUd KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mcdyt60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCuWYm019512;
	Wed, 22 May 2024 13:55:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js98t81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:55:09 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDsm34016070;
	Wed, 22 May 2024 13:55:08 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js98su1-7;
	Wed, 22 May 2024 13:55:08 +0000
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
Subject: [PATCH v3 3/6] RDMA/cma: Brute force GFP_NOIO
Date: Wed, 22 May 2024 15:54:38 +0200
Message-Id: <20240522135444.1685642-7-haakon.bugge@oracle.com>
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
X-Proofpoint-ORIG-GUID: 5UH2sQqlIU1_ZWsukQVNPZex9ll28i-I
X-Proofpoint-GUID: 5UH2sQqlIU1_ZWsukQVNPZex9ll28i-I

In cma_init(), we call memalloc_noio_{save,restore} in a parenthetic
fashion when enabled by the module parameter force_noio.

This in order to conditionally enable rdma_cm to work aligned with
block I/O devices. Any work queued later on work-queues created during
module initialization will inherit the PF_MEMALLOC_{NOIO,NOFS}
flag(s), due to commit ("workqueue: Inherit NOIO and NOFS alloc
flags").

We do this in order to enable ULPs using the RDMA stack to be used as
a network block I/O device. This to support a filesystem on top of a
raw block device which uses said ULP(s) and the RDMA stack as the
network transport layer.

Under intense memory pressure, we get memory reclaims. Assume the
filesystem reclaims memory, goes to the raw block device, which calls
into the ULP in question, which calls the RDMA stack. Now, if
regular GFP_KERNEL allocations in the ULP or the RDMA stack require
reclaims to be fulfilled, we end up in a circular dependency.

We break this circular dependency by:

1. Force all allocations in the ULP and the relevant RDMA stack to use
   GFP_NOIO, by means of a parenthetic use of
   memalloc_noio_{save,restore} on all relevant entry points.

2. Make sure work-queues inherits current->flags
   wrt. PF_MEMALLOC_{NOIO,NOFS}, such that work executed on the
   work-queue inherits the same flag(s).

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cma.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 64ace0b968f07..6e82c18aeebb8 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -50,6 +50,10 @@ MODULE_LICENSE("Dual BSD/GPL");
 #define CMA_IBOE_PACKET_LIFETIME 16
 #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
 
+static bool cma_force_noio;
+module_param_named(force_noio, cma_force_noio, bool, 0444);
+MODULE_PARM_DESC(force_noio, "Force the use of GFP_NOIO (Y/N)");
+
 static const char * const cma_events[] = {
 	[RDMA_CM_EVENT_ADDR_RESOLVED]	 = "address resolved",
 	[RDMA_CM_EVENT_ADDR_ERROR]	 = "address error",
@@ -5426,6 +5430,10 @@ static struct pernet_operations cma_pernet_operations = {
 static int __init cma_init(void)
 {
 	int ret;
+	unsigned int noio_flags;
+
+	if (cma_force_noio)
+		noio_flags = memalloc_noio_save();
 
 	/*
 	 * There is a rare lock ordering dependency in cma_netdev_callback()
@@ -5441,8 +5449,10 @@ static int __init cma_init(void)
 	}
 
 	cma_wq = alloc_ordered_workqueue("rdma_cm", WQ_MEM_RECLAIM);
-	if (!cma_wq)
-		return -ENOMEM;
+	if (!cma_wq) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	ret = register_pernet_subsys(&cma_pernet_operations);
 	if (ret)
@@ -5460,7 +5470,8 @@ static int __init cma_init(void)
 	if (ret)
 		goto err_ib;
 
-	return 0;
+	ret = 0;
+	goto out;
 
 err_ib:
 	ib_unregister_client(&cma_client);
@@ -5471,6 +5482,9 @@ static int __init cma_init(void)
 	unregister_pernet_subsys(&cma_pernet_operations);
 err_wq:
 	destroy_workqueue(cma_wq);
+out:
+	if (cma_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return ret;
 }
 
-- 
2.31.1


