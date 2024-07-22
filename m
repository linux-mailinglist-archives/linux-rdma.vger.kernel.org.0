Return-Path: <linux-rdma+bounces-3929-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99EB939019
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 15:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13229B20BDE
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7814E16CD05;
	Mon, 22 Jul 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODrcMYI9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AFB1EB26;
	Mon, 22 Jul 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656016; cv=none; b=Ape177V1x7Gt/MKZTN2M+yfq4xHt+SKIsCmPyLSF3J2wEwC/QzCNFWu08CIh0y24tkUD7TPrLH8aVXQ05upmhF0UruptO75sNXH18gOQW8CWp2JKfUwSoYQX/f62DW3P1Q0hIAWd7YHQMhqWO9aK0lkeIHefBQq7gu/pSef+S6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656016; c=relaxed/simple;
	bh=oa+Afng6R5K3QmPktSUjt9b3d3Diz8j19/vzUfAKm6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ohUd5G9ozwgGGSMqNYGsO6YfBO7dqIwBuMHf+jI2lJXXmuFWDL71ZSWZF4S4/KTVkx9Rf3uQ2SG9t9k46Upepglel1SxbSJyxu1TltaSyCnizu5qDr2SEjhW3Rv0ENEdpDc95pDF5XJ3q6xlT3b4rI86h7yf1hQ8s0yUhdvdiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ODrcMYI9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MCBalR003253;
	Mon, 22 Jul 2024 13:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=vRACKsqsmtS90X
	/En0V7eGmEXSmI+PyodfcrJK7YG7k=; b=ODrcMYI9OjjypmQDf5Sj5wZSqM/fhP
	LEU/OPucRmMpZrhnWc1PxYuKkObnML5Rt/mumvqgyoWN7jBt/DnfRdzWfvjRnsjd
	q+bXcCOjZSmuFRFtcv8JdG+hqFPdIRGOGeZaKI9GvDDfr4Ha0lpfXWICCRcRrwAL
	2vAE9av7D/+KdtA9jzLNVJYX7vNnD3yW9g+1Lx9/vxcBcpIKXByc99PRP87NoKcA
	DQyUizFsnrU0d1amUHqrmKzRJutJsIfsj4wPXkH9PQjD5CU0Cm+1QrkKAK7hdeD+
	ovOgAyaPILvgS98Wkf+cbRtMIDrXQklxv/JwLudb1f4leUsPX37l7zyw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft09x4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 13:46:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MCkdmD018975;
	Mon, 22 Jul 2024 13:46:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27x6yqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 13:46:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46MDkgf5011412;
	Mon, 22 Jul 2024 13:46:42 GMT
Received: from aakhoje-ol.in.oracle.com (dhcp-10-166-167-232.vpn.oracle.com [10.166.167.232])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40h27x6ync-1;
	Mon, 22 Jul 2024 13:46:41 +0000
From: Anand Khoje <anand.a.khoje@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, tariqt@nvidia.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com
Subject: [PATCH net-next v7] net/mlx5: Reclaim max 50K pages at once
Date: Mon, 22 Jul 2024 19:16:33 +0530
Message-ID: <20240722134633.90620-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_09,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407220103
X-Proofpoint-GUID: mykSe0Z5kRZ8HislHmQiIsl_D6QacvAx
X-Proofpoint-ORIG-GUID: mykSe0Z5kRZ8HislHmQiIsl_D6QacvAx

In non FLR context, at times CX-5 requests release of ~8 million FW pages.
This needs humongous number of cmd mailboxes, which to be released once
the pages are reclaimed. Release of humongous number of cmd mailboxes is
consuming cpu time running into many seconds. Which with non preemptible
kernels is leading to critical process starving on that cpu’s RQ.
On top of it, the FW does not use all the mailbox messages as it has a
limit of releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES +
MLX5_PAGES_TAKE device command. Hence, the allocation of these many
mailboxes is extra and adds unnecessary overhead.
To alleviate this, this change restricts the total number of pages
a worker will try to reclaim to maximum 50K pages in one go.

Our tests have shown significant benefit of this change in terms of
time consumed by dma_pool_free().
During a test where an event was raised by HCA
to release 1.3 Million pages, following observations were made:

- Without this change:
Number of mailbox messages allocated was around 20K, to accommodate
the DMA addresses of 1.3 million pages.
The average time spent by dma_pool_free() to free the DMA pool is between
16 usec to 32 usec.
           value  ------------- Distribution ------------- count
             256 |                                         0
             512 |@                                        287
            1024 |@@@                                      1332
            2048 |@                                        656
            4096 |@@@@@                                    2599
            8192 |@@@@@@@@@@                               4755
           16384 |@@@@@@@@@@@@@@@                          7545
           32768 |@@@@@                                    2501
           65536 |                                         0

- With this change:
Number of mailbox messages allocated was around 800; this was to
accommodate DMA addresses of only 50K pages.
The average time spent by dma_pool_free() to free the DMA pool in this case
lies between 1 usec to 2 usec.
           value  ------------- Distribution ------------- count
             256 |                                         0
             512 |@@@@@@@@@@@@@@@@@@                       346
            1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
            2048 |                                         0
            4096 |                                         0
            8192 |                                         1
           16384 |                                         0

Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Acked-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index d894a88..972e8e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -608,6 +608,11 @@ enum {
 	RELEASE_ALL_PAGES_MASK = 0x4000,
 };
 
+/* This limit is based on the capability of the firmware as it cannot release
+ * more than 50000 back to the host in one go.
+ */
+#define MAX_RECLAIM_NPAGES (-50000)
+
 static int req_pages_handler(struct notifier_block *nb,
 			     unsigned long type, void *data)
 {
@@ -639,7 +644,16 @@ static int req_pages_handler(struct notifier_block *nb,
 
 	req->dev = dev;
 	req->func_id = func_id;
-	req->npages = npages;
+
+	/* npages > 0 means HCA asking host to allocate/give pages,
+	 * npages < 0 means HCA asking host to reclaim back the pages allocated.
+	 * Here we are restricting the maximum number of pages that can be
+	 * reclaimed to be MAX_RECLAIM_NPAGES. Note that MAX_RECLAIM_NPAGES is
+	 * a negative value.
+	 * Since MAX_RECLAIM is negative, we are using max() to restrict
+	 * req->npages (and not min ()).
+	 */
+	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
 	req->ec_function = ec_function;
 	req->release_all = release_all;
 	INIT_WORK(&req->work, pages_work_handler);
-- 
1.8.3.1


