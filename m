Return-Path: <linux-rdma+bounces-3323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E5D90EE79
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90F21C24A8C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7714B970;
	Wed, 19 Jun 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n6rxkgXi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F45146016;
	Wed, 19 Jun 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803729; cv=none; b=SX8ufe3bZN8cE8LGkO2jDNoo1HnnBBcR5gV2L5jVZoeJv46HPopZfqybqRoMujF5nZSzxAhwSmKmxloxZA84a9e7cxHskeJh7DXqmVO2YAeLBRnL/bLTEjZaHx5j9EV90lOMr/Nu2DM0GKktfswhPCPPK+qFqSI36WvwOQVLLlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803729; c=relaxed/simple;
	bh=IbU9H+DWKuJetppSWilqM1RixdWQASTCpKWygS68koc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gl8VyiaViVhDQ0Pbq0/7AbQPAl1vdYz6jAAdjwjcHbTLXy1GxNm/61fg8iTAIUtpsjp7CBrT2b7a1dXHjgEwi96hh+RxgKILqZtn5S6/9N61YzpEzjzerTsnUfTvM/BQULz2Vl5g7LxxLU1wGzDSKwWApZJlGBi7LGKw2WZmMpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n6rxkgXi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J1tRoI009538;
	Wed, 19 Jun 2024 13:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=XqDJjEiAlVyJHw
	kCLkG1pOnpC+qIkFOEq7vg5dbf2KI=; b=n6rxkgXipv/rLIUTrS8e7bxvz+rc51
	rIUx/H0BEsaMOGOtFI3AtT77IC4h2lsf8xOf75Kk4AMvB+pZJy2wbWTa8P60Gm9e
	Stu1m6PVndUSLvqeVsMsMOrZJDmWM2I+gKbo3cTSGix2C9HCAiCAmRsKcfGfOTDY
	QrgAf4Y8RCilShs02Y9ul70/h4bVFoyElTjb+hLwIxnDTDgcUrWfwqgBVqIe6vI1
	QgHI4vieJ3M0UOcyTw33ToucxAQleTb5V6Z8/LgqLZGPtK5e/veVHlSKyhhLlMPq
	mP68KNYYuKhc/aDLqJktPIEju18vlKcIJ6yRh9GD60bbtQILChWwgaCA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuja0h8ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 13:28:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JCPXv7034789;
	Wed, 19 Jun 2024 13:28:35 GMT
Received: from aakhoje-ol.in.oracle.com (dhcp-10-191-198-68.vpn.oracle.com [10.191.198.68])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1d9jejw-1;
	Wed, 19 Jun 2024 13:28:34 +0000
From: Anand Khoje <anand.a.khoje@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, tariqt@nvidia.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net
Subject: [PATCH v4] net/mlx5: Reclaim max 50K pages at once
Date: Wed, 19 Jun 2024 18:58:27 +0530
Message-ID: <20240619132827.51306-1-anand.a.khoje@oracle.com>
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
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406190101
X-Proofpoint-ORIG-GUID: 5eObyzq1y0ZJDWpVf6dAqeL73j464ly0
X-Proofpoint-GUID: 5eObyzq1y0ZJDWpVf6dAqeL73j464ly0

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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
Changes in v4:
  - Fixed a nit in patch subject.
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index dcf58ef..06eee3a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -608,6 +608,7 @@ enum {
 	RELEASE_ALL_PAGES_MASK = 0x4000,
 };
 
+#define MAX_RECLAIM_NPAGES -50000
 static int req_pages_handler(struct notifier_block *nb,
 			     unsigned long type, void *data)
 {
@@ -639,9 +640,13 @@ static int req_pages_handler(struct notifier_block *nb,
 
 	req->dev = dev;
 	req->func_id = func_id;
-	req->npages = npages;
 	req->ec_function = ec_function;
 	req->release_all = release_all;
+	if (npages < MAX_RECLAIM_NPAGES)
+		req->npages = MAX_RECLAIM_NPAGES;
+	else
+		req->npages = npages;
+
 	INIT_WORK(&req->work, pages_work_handler);
 	queue_work(dev->priv.pg_wq, &req->work);
 	return NOTIFY_OK;
-- 
1.8.3.1


