Return-Path: <linux-rdma+bounces-2497-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 585248C66A1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 14:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EF8B210E6
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8BF12A15B;
	Wed, 15 May 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="abbjIaF0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C412A14C;
	Wed, 15 May 2024 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777688; cv=none; b=ZPQs56phd+qaMw+rKkVlPQFs1GCisu04RiQTtWOeTpJM7mMNAxp+1pUKKRIuMh8kOtHFq/rclWBlgDfEt5Ebm/d/It3Rq+ojFnZ/miEIjHT+e0l0AbdvilwOP7/E5z7LA2vn/dTSDkat/aaMteoys+en5ENirdbtZND1GU4a/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777688; c=relaxed/simple;
	bh=BwJptKrYjAbKhxsaZQSlX4GaCMh473E6P/Oc3sa5jBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGukuESUSM/IQRhg6II/IENxMyn5nAajc7BCe2NIlC32Mz0KbgUofnm12zCnLW2kDqoPyszBHD6kElmA3r3HWl40xEcZXW6OX8ITc2YrOBb84qfVuMGAORlWXH5ZMS8F3r4MYw32w5LgUNs+rlLJRf+kED9cVdi4j+igO7xJFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=abbjIaF0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44F7nSqc020198;
	Wed, 15 May 2024 12:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=s0o7+CZvTIXe6mctHjZROAylxKEWHdEvfBwqKM9aQ9o=;
 b=abbjIaF0AwNIVU8KK/hiL64wblA/l9agjjV6C+0tS4HXrSL4j9ZCQ9KNzp0CkxGnStWY
 4ze8kyDLHTdTGBJoS4omt00OUHuH6EP/D3H7dzTpM3EdkJmj4JTul1DLpiBCzusrMfDX
 Vlk7CTCOBk11ZJN5E0Q+GXgGnUi6C6Gy0wGCqtTT56EfwSuGz3W4Fho1nZWe1OGurpBE
 TgSMh8GZ/umtuGjljh4PPDFVyKRsludETde96qiHo0woiJeZ7wf9Q8HgG2H7+/KH0a/w
 Y+Ei6JIwpj0KSz32mBq/+qGebYmzfxc403btMpNWZMuG+mxUHJS9G/rfQWS+E7oU26T5 /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7d68a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:54:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FCoUj7038301;
	Wed, 15 May 2024 12:54:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24pxgv26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 12:54:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FCmlrp038458;
	Wed, 15 May 2024 12:54:16 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y24pxgud9-7;
	Wed, 15 May 2024 12:54:15 +0000
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
Subject: [PATCH v2 6/6] net/mlx5: Brute force GFP_NOIO
Date: Wed, 15 May 2024 14:53:42 +0200
Message-Id: <20240515125342.1069999-7-haakon.bugge@oracle.com>
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
X-Proofpoint-ORIG-GUID: N-dzc11NI8Kv6kMPLKg5cydwUWlPdkj4
X-Proofpoint-GUID: N-dzc11NI8Kv6kMPLKg5cydwUWlPdkj4

In mlx5_core_init(), we call memalloc_noio_{save,restore} in a parenthetic
fashion when enabled by the module parameter force_noio.

This in order to conditionally enable mlx5_core to work aligned with
I/O devices. Any work queued later on work-queues created during
module initialization will inherit the PF_MEMALLOC_{NOIO,NOFS}
flag(s), due to commit ("workqueue: Inherit NOIO and NOFS alloc
flags").

We do this in order to enable ULPs using the RDMA stack and the
mlx5_core driver to be used as a network block I/O device. This to
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
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 331ce47f51a17..aa1bf8bb5d15c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -48,6 +48,7 @@
 #include <linux/mlx5/vport.h>
 #include <linux/version.h>
 #include <net/devlink.h>
+#include <linux/sched/mm.h>
 #include "mlx5_core.h"
 #include "lib/eq.h"
 #include "fs_core.h"
@@ -87,6 +88,10 @@ static unsigned int prof_sel = MLX5_DEFAULT_PROF;
 module_param_named(prof_sel, prof_sel, uint, 0444);
 MODULE_PARM_DESC(prof_sel, "profile selector. Valid range 0 - 2");
 
+static bool mlx5_core_force_noio;
+module_param_named(force_noio, mlx5_core_force_noio, bool, 0444);
+MODULE_PARM_DESC(force_noio, "Force the use of GFP_NOIO (Y/N)");
+
 static u32 sw_owner_id[4];
 #define MAX_SW_VHCA_ID (BIT(__mlx5_bit_sz(cmd_hca_cap_2, sw_vhca_id)) - 1)
 static DEFINE_IDA(sw_vhca_ida);
@@ -2312,8 +2317,12 @@ static void mlx5_core_verify_params(void)
 
 static int __init mlx5_init(void)
 {
+	unsigned int noio_flags;
 	int err;
 
+	if (mlx5_core_force_noio)
+		noio_flags = memalloc_noio_save();
+
 	WARN_ONCE(strcmp(MLX5_ADEV_NAME, KBUILD_MODNAME),
 		  "mlx5_core name not in sync with kernel module name");
 
@@ -2334,7 +2343,7 @@ static int __init mlx5_init(void)
 	if (err)
 		goto err_pci;
 
-	return 0;
+	goto out;
 
 err_pci:
 	mlx5_sf_driver_unregister();
@@ -2342,6 +2351,9 @@ static int __init mlx5_init(void)
 	mlx5e_cleanup();
 err_debug:
 	mlx5_unregister_debugfs();
+out:
+	if (mlx5_core_force_noio)
+		memalloc_noio_restore(noio_flags);
 	return err;
 }
 
-- 
2.45.0


