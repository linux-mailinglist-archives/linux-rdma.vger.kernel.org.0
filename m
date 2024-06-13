Return-Path: <linux-rdma+bounces-3118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311B906F0B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 14:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C722D1F21767
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06772145FFB;
	Thu, 13 Jun 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQDMXgFw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4B145B14;
	Thu, 13 Jun 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280781; cv=none; b=cXH1Xto+wdrFoBJaO/K4XY7+E1pQDobsmuYfl2wu9Gil0jUEpdf98IJmE/h0o//R0ecAlKcmWlgXqFCjR74KmTx1v9Co1+f921hkR9cXmyJiKzcC5Wq+FGKdCOA7WgYfpSgmvHwVqLShDm70F979ZN6FHcwFjfnh6yhPqj3mSD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280781; c=relaxed/simple;
	bh=N7P+gU/s94nGXBEJRTvcdalH1eFK202F8UvHoBOWizI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gx5PjhfNyl07zdL0JL+Q3bAvdUauBILwZIFQn16b+HSWWaQd+T4NNYOcwtrENz1LeeKMhUlPr0PsHX4iwvAidr1H3S4L24WV7WQoNBW/JxTy4W1mrFRjtFToPfNQ4VWmM2ce3oyRsRsWhO62Y9m/t4sbLWLXecWaJ7qf7m9QjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQDMXgFw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DBtWjJ026221;
	Thu, 13 Jun 2024 12:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=Mv2EgAb/+V5uww
	BsfpmmMkCgcePGI7KBIXi9vy+7NC4=; b=cQDMXgFwEZ7CfpKwcJCPs6DYe/gAEg
	o7XoJO1txYo0NLSC7rh72GHnsp+ipj0pu9IQnk+8LoZinJYiP+jt5IzxArea/HP5
	Q8aGB3Mts/xwCJ4Bdz2WPmJD1t1hXob1MPq/YD+7EphtaIQLAWXfFyhyug36l0UB
	h4zWHgn/f5djvs4iFO9x6hexYGzHYN9RURHT1xZFDri9LkPyBgLx08NEvHiwNaGi
	dlm2BONMoBE8XEHaYoSL+SWlnB4gJ1T7hxQomdd94ZkNn6T8+Bul5o+6fl+c0Nko
	3rkx8vNMAu2b1UqKEhXpsz4Suew3cG7bsdslClRVY2nk8BTcBzCd6ojA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fs99f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 12:12:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DBDeYW027293;
	Thu, 13 Jun 2024 12:12:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdw4ymf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 12:12:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45DC3vvG023155;
	Thu, 13 Jun 2024 12:12:57 GMT
Received: from aakhoje-ol.in.oracle.com (dhcp-10-191-238-148.vpn.oracle.com [10.191.238.148])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yncdw4yj1-1;
	Thu, 13 Jun 2024 12:12:56 +0000
From: Anand Khoje <anand.a.khoje@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: anand.a.khoje@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com
Subject: [PATCH v2] RDMA/mlx5 : Reclaim max 50K pages at once
Date: Thu, 13 Jun 2024 17:42:52 +0530
Message-ID: <20240613121252.93315-1-anand.a.khoje@oracle.com>
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
 definitions=2024-06-13_04,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130088
X-Proofpoint-GUID: 7IGtM-HDp_eZ3waPK8O67jg24v2i6zYO
X-Proofpoint-ORIG-GUID: 7IGtM-HDp_eZ3waPK8O67jg24v2i6zYO

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
Changes in v2:
 - In v1, CPUs were yielded if more than 2 msec are spent in
   mlx5_free_cmd_msg(). The approach to limit the time spent is changed
   in this version.
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 1b38397..b1cf97d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -482,12 +482,16 @@ static int reclaim_pages(struct mlx5_core_dev *dev, u32 func_id, int npages,
 	return err;
 }
 
+#define MAX_RECLAIM_NPAGES -50000
 static void pages_work_handler(struct work_struct *work)
 {
 	struct mlx5_pages_req *req = container_of(work, struct mlx5_pages_req, work);
 	struct mlx5_core_dev *dev = req->dev;
 	int err = 0;
 
+	if (req->npages < MAX_RECLAIM_NPAGES)
+		req->npages = MAX_RECLAIM_NPAGES;
+
 	if (req->release_all)
 		release_all_pages(dev, req->func_id, req->ec_function);
 	else if (req->npages < 0)
-- 
1.8.3.1


