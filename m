Return-Path: <linux-rdma+bounces-2454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72E8C4122
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 14:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9793286AA0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE586153514;
	Mon, 13 May 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yl3R02V8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103B15250C;
	Mon, 13 May 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604893; cv=none; b=IqFYZg4DxpSZTFu2g2FK8n6egkD6VplSq2B7qtlnF3jpUB215hVq+7xcfP3pzc34VtQKzJT86aGlFl5kmUt1vZehUnqgPHZ34mdfWXUUY49nGiOYLcdtJe2HNfxK52S3ZJatZii3m9GG60XAI0hG7wC0KPEmMe+BDz2CdL5OSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604893; c=relaxed/simple;
	bh=mvPUkRlvYkKtnqceobvk3BXcI/ukth5ROALE8449Ngw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZGQ/gQyqbwXEnJNEPwI21b1Z1Xohnw9eCNqyI06t85F4H4B1kMr9FZdOGpjbEVybtiORhauY5Ds/Cb/7jrSzMEpyKNF6Pagvb+MHcQKaPf/ui15ht0fJNKghjJH892CDH3GtOMffEi7+DrxG0O2wepi8jKrnXy40J8IGZJGAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yl3R02V8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DCTNwi017758;
	Mon, 13 May 2024 12:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=vJiIjia/kpxGmfNrH05MDPooUGdw6eSpU+kDSwI1DeA=;
 b=Yl3R02V8CSoN2x5Wgz0a+akFxMF3ueZnJFqiK8PDhACwnNToMzRrJf0mV/74zkQlMKZE
 pE9Fn2JcDPY8+RVSEXk4oind6vpLylLr3qVofWZQkqqbZdm3pEDAMiNYsW/yBAS7Qn/q
 SjCDCsqDIT0YJGMj9r5Cm9Xk3h6/cu8nVLn+Wl30gvSt1ctLCcRaWxF+HcSRz2BgvhYN
 GHz4/LK/Mwy0X12+rNymH1apXYoIRF1+24h6OcWZzNqIrJH7uPf0nLO4VslfOMRznhxA
 eFRDB1KvDxO4+Ske9G0WAVYCJNDL3Csy23acei0KF6voYSaOyUIZ1NQFj34CCDFVW0XR 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3dyx0s2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 12:54:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DB9Dvp018068;
	Mon, 13 May 2024 12:54:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4c13e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 12:54:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44DCq98E001819;
	Mon, 13 May 2024 12:54:34 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y1y4c12sj-7;
	Mon, 13 May 2024 12:54:34 +0000
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
Subject: [PATCH 6/6] net/mlx5: Brute force GFP_NOIO
Date: Mon, 13 May 2024 14:53:46 +0200
Message-Id: <20240513125346.764076-7-haakon.bugge@oracle.com>
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
X-Proofpoint-GUID: OPHdSHh1CF9xlBESd7cU_Sv3QGKIqKna
X-Proofpoint-ORIG-GUID: OPHdSHh1CF9xlBESd7cU_Sv3QGKIqKna

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
2.39.3


