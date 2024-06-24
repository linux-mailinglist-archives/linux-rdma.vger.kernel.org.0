Return-Path: <linux-rdma+bounces-3442-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B074691528D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 17:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC4B1C22EF8
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2A19D895;
	Mon, 24 Jun 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BSIL4hQE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E819CD0B;
	Mon, 24 Jun 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243233; cv=none; b=Gqs5Dg9sQOEx2LJ0F9jJrI07JC03qvCtZ4/3Okv8ZlsFf7tpoHt0wpS8z5O5bMVHicVosFh489cywsqrWQRUntY8xDVmZ7CSG43GZ63EmaVWbu5zee2xrSdUDUNHXSO2YVbilSObhhrRLQSAKMIM8FNET0wME6bW7Pm8iWiuqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243233; c=relaxed/simple;
	bh=UTq25U8EovFIHY7zUXQYzBJ2OaikaCJHOw7txbFc8ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rFX3+PluhGh+dMARjz/g0O55j8QKSnZv7fYHkse9V4VgXWW+iHjTu4nfwC1mDOo7Vm4mwtYHn9C/tR5dwVSNd3RBjLqGS2zucSqYv80y0x2z/VRaU3fTYuJ3EXzWebjG9QtyrHoaLfysmnILGPlZi/6pEche2E2S0mhYt1BbRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BSIL4hQE; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEtPKj014510;
	Mon, 24 Jun 2024 15:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=LjwTv1x14K+YU+
	i4bv9l/35xuqtm0L02zqCA66eU4EE=; b=BSIL4hQE0BFqR1g9372u8H9iMKdxix
	/8gMrqJAC1Hjo7Mq+DaqP5UHUefb0Q+5ZkzLnrRODHu9es1YlzUmbZzMR5an9J0w
	jgPT9IlSBFcqwVeZKlQWTl9ubBv7eq2xlDpq1TMyry/I+oHAYDC1vCqsTuRlVnTh
	EVgB6sYiqN1gqYl4TQ5B6AeUEf4YJrp0w4SyWp7hsxI9b3Q4XOwaQNOICxFEM6/q
	uDlsFkPz/Dd94R+VkQgcQvFKKv8lOscjnrtuWwoUqF2IyJhVOkMQGeG31+M/U5i4
	5oQn9DLIot5KSlBiN+ca2t/9Z8byx4CKTiZdo57l7sXhWg6Cs+9ZbKfg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7saw6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:33:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OF61wk010772;
	Mon, 24 Jun 2024 15:33:40 GMT
Received: from aakhoje-ol.in.oracle.com (dhcp-10-76-47-230.vpn.oracle.com [10.76.47.230])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2ckr8e-1;
	Mon, 24 Jun 2024 15:33:39 +0000
From: Anand Khoje <anand.a.khoje@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, tariqt@nvidia.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net
Subject: [PATCH v5] net/mlx5: Reclaim max 50K pages at once
Date: Mon, 24 Jun 2024 21:03:21 +0530
Message-ID: <20240624153321.29834-1-anand.a.khoje@oracle.com>
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
 definitions=2024-06-24_12,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406240125
X-Proofpoint-GUID: iF7jeR9rpyYUWUuIT3ZtspPVrNHaJmbH
X-Proofpoint-ORIG-GUID: iF7jeR9rpyYUWUuIT3ZtspPVrNHaJmbH

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
Changes in v5:
  - Made changes as per a suggestion from Leon.
---

 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index d894a88..1fc583b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -608,6 +608,7 @@ enum {
 	RELEASE_ALL_PAGES_MASK = 0x4000,
 };
 
+#define MAX_RECLAIM_NPAGES -50000
 static int req_pages_handler(struct notifier_block *nb,
 			     unsigned long type, void *data)
 {
@@ -639,7 +640,7 @@ static int req_pages_handler(struct notifier_block *nb,
 
 	req->dev = dev;
 	req->func_id = func_id;
-	req->npages = npages;
+	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
 	req->ec_function = ec_function;
 	req->release_all = release_all;
 	INIT_WORK(&req->work, pages_work_handler);
-- 
1.8.3.1


