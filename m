Return-Path: <linux-rdma+bounces-3148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D9A90859B
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 10:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BE71F257DA
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4214D29B;
	Fri, 14 Jun 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVptile8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4881474CB;
	Fri, 14 Jun 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352116; cv=none; b=XLJiiaDk1NSDhVbsMovnfphzr6giHfwMladFLMlbLPbHVPCWDwDhu9kAD9GjrfuDfCIaQnyaIfE193A62OJhbNUaTIheG4n3htfRJuGPyjw5Hj+covB4xfO4jhHtr7iPxl2l70P2KgWVKOs7Fe2UU1EbaLl2p+iBSfkFYCdx2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352116; c=relaxed/simple;
	bh=AiE3BsoHl6nbAyEPcQt6QjvUqcm6iPgk/BkHE4KsWHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G5CYJkuWsyxTrhTjhq29Ffq/pu6aTlp/NANXCJdNrLD0fYKfqfNnzj8kV5nhR++ryhLykn/20jLYYdwuqQHLpT6CAdW9Mmu9ZnKUgZfjuf4y1xvZ3yoh1kHlMzYXVRC39yT7iO+xjg0Rj7ZPppqPe9FXA87nMvAwNIvVFVHbqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RVptile8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fRo7003155;
	Fri, 14 Jun 2024 08:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=gGCJMnhO+L8oNf
	IArlpsLOLy5wZxlT0LIbb7sFe1hZY=; b=RVptile8zcftjCfyE9QkpluaOTDmmd
	e/XcXEDP1vatdHrlCFpjfbxxOrf/l0Jh9ujaeEoG73bU+PA6Si9GKBW249DkY5gL
	Wr4S7p2bjb9gHKmJJOh06aCZiTJ1hZS1h1NLhFGvIwUc3tKpvnxjnECQCMB644U6
	BfFCv1e8YkjIfBX+WliquE9Yzaw+bTOmmH3QwZWRUmMjYl8fS9smekrpr7Moog1N
	a4UWzf61z6SoOd+Uuyai0wo1wduNnkkLmtRNcpj5ib4x+2GV7+j8jPZDkwYv9OYL
	lfE8Y7CH16ewV7ewBGnJpYdLdqYR/jhKJgJ6nVB2rL4jxBf5Yt6OdC9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhajb6tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 08:01:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E7FWfw020432;
	Fri, 14 Jun 2024 08:01:44 GMT
Received: from aakhoje-ol.in.oracle.com (dhcp-10-76-34-154.vpn.oracle.com [10.76.34.154])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yncaymbrm-1;
	Fri, 14 Jun 2024 08:01:42 +0000
From: Anand Khoje <anand.a.khoje@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, davem@davemloft.net
Subject: [PATCH v3] net/mlx5 : Reclaim max 50K pages at once
Date: Fri, 14 Jun 2024 13:31:35 +0530
Message-ID: <20240614080135.122656-1-anand.a.khoje@oracle.com>
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
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140054
X-Proofpoint-GUID: A8VZ0y80ZXnz0eB4BkEHfS2vhrAxgWIW
X-Proofpoint-ORIG-GUID: A8VZ0y80ZXnz0eB4BkEHfS2vhrAxgWIW

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
Changes in v3:
   - Shifted the logic to function req_pages_handler() as per
     Leon's suggestion.
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 1b38397..e7c2d36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -508,6 +508,7 @@ enum {
 	RELEASE_ALL_PAGES_MASK = 0x4000,
 };
 
+#define MAX_RECLAIM_NPAGES -50000
 static int req_pages_handler(struct notifier_block *nb,
 			     unsigned long type, void *data)
 {
@@ -539,9 +540,13 @@ static int req_pages_handler(struct notifier_block *nb,
 
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


