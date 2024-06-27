Return-Path: <linux-rdma+bounces-3554-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 194E391AEF8
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 20:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDEE1F23FE1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB18019AA62;
	Thu, 27 Jun 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5Dow/Q8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A43198838;
	Thu, 27 Jun 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512709; cv=none; b=SVsN3+2gA0fiFuDc9FJkHZUrrQMO9omkptHCv3Ody9ydUfrl/lIl0cXoAqjU8LYR6nSBX76X0oDevnzURWpisiRB3YqE26WoNQ/IF4vi9/9kqElzcJY1orhUlcvLll0aIMg51sCCR2ObTmzarjRb21JSqOc55qzZO6ifdsk84xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512709; c=relaxed/simple;
	bh=KeBGO9CRPaD0wSlNnklz3IGku9jngU6aEeR9XG3Lfh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OSl4ldNujFcoUwxnfeWKngnaT4BbJ8cW1H0YQQH+RCTMoHGSgi9HPYEeSOha+6LjtmQapfgDEsBWzLQ+iUAjJPVd5oSIXuf1fg6lkQnU9RmePNo31NGsEgcSvM/tJuqFr+9f1nFSLZunxXpUijsW6kuZgF4VYo7G3bEXejJKl/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5Dow/Q8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtWer012266;
	Thu, 27 Jun 2024 18:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=lWQliWfHdkYY0l
	iIKUPYYMRUdsUHPFcSTvSEg1ybQA0=; b=m5Dow/Q8S+22FvzT4Rs7+SJAbp1+ST
	u/H5R0Z6DrUN6NlbuAJ7pEvKf8MT/oYL4oB8aQpXjaJNSwCjRDPAEPeExU/ERwPM
	hLOyDGqwmOIItPWjYjxexOsvwGfhzQFeIcd7O2JK6+Pk2zGxULrV78LpI3qtG44N
	B1PyEvC9ZtNmeClw+iwfkeQ3ulNEQwzG+ayBfzTwF6iuc1ve+O/Dn/KpXb5MdXhP
	gMnZgdSPLN94sOcqBut452JzDfleE564LMkOkszqL1q4jbj5WB/IzvztN5jlhjW6
	30xNb+SxSmIKzth+6bJLJqwlN4Oi43ZfTPCB1BLHbAlfQT+WFDUIMUsw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t6sea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 18:24:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RHb7sO023397;
	Thu, 27 Jun 2024 18:24:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2hannt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 18:24:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RIOnP3007370;
	Thu, 27 Jun 2024 18:24:50 GMT
Received: from aakhoje-ol.in.oracle.com (dhcp-10-191-198-246.vpn.oracle.com [10.191.198.246])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2hane7-1;
	Thu, 27 Jun 2024 18:24:49 +0000
From: Anand Khoje <anand.a.khoje@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, tariqt@nvidia.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com
Subject: [PATCH v6] net/mlx5: Reclaim max 50K pages at once
Date: Thu, 27 Jun 2024 23:54:43 +0530
Message-ID: <20240627182443.19254-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.43.0
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
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270138
X-Proofpoint-GUID: mEh18h35oB4pCkI1VJxZBS92kp5H7oV9
X-Proofpoint-ORIG-GUID: mEh18h35oB4pCkI1VJxZBS92kp5H7oV9

In non FLR context, at times CX-5 requests release of ~8 million FW pages.
This needs humongous number of cmd mailboxes, which to be released once
the pages are reclaimed. Release of humongous number of cmd mailboxes is
consuming cpu time running into many seconds. Which with non preemptible
kernels is leading to critical process starving on that cpu’s RQ.
To alleviate this, this change restricts the total number of pages
a worker will try to reclaim maximum 50K pages in one go.
The limit 50K is aligned with the current firmware capacity/limit of
releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES + MLX5_PAGES_TAKE
device command.

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
---
Changes in v6
 - Added comments to explain usage os negative MAX_RECLAIM_NPAGES
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


