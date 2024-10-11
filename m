Return-Path: <linux-rdma+bounces-5386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8608899AEF5
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Oct 2024 00:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6AF1F272E4
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 22:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D31E0B6D;
	Fri, 11 Oct 2024 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BecgcCiw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C771974EA;
	Fri, 11 Oct 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687539; cv=none; b=JmSv5jvum3xS/M5CAQ+iw0qNkyTuId8fOWO4J9xQAMRICyRdL2e9G+XUXiZMMhvupTgjTXz+j/USM74I8uZGQOcN8lyYBoe9idDEMR0xs3bTQfedv+5TfVUNczLTT1d+I4rVpa9/KDNwBGMTk3o5bnvJHJ7XAGEN9sHHrb1qA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687539; c=relaxed/simple;
	bh=dyvYrXMnl/7fmCe8wEUQbdaR72+Bt8WD6Lv8zTl5gPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l7A7OZp3sHGi76ZZk8YagyxckhXzWpRhpv4IUL1nnHNNm9zd0KeOOArRPOsWYAKPFF0Lyj976XOAu4+Cy4NQ1L+2DTaqpRaJN2JrUftY/FSLmtTVuGCSKZIMo2/4YEWxv2yzP2yQFeB7pUPN8R2dxM3CBeFAsjFyqa3wP8NKryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BecgcCiw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJJVM0029745;
	Fri, 11 Oct 2024 22:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=tEQw/28X70aYEuY8Q7gZLBCtsQy4n
	INcRrw63rY97Vg=; b=BecgcCiwCS6Exatt2uopZLI035JSLlj96fAPMSkWrMMJ/
	GBLUgXlhsT1lXrKw0AAcRTfP7OZHqYMRaPhQu5NABzhPUPDpggmUmgpIyHrsTFfO
	s725x1pN6k0xL8EyBiCQvIx/tr/C6AmpRt5WVloDtRw3G6MNT9Fj1Hts0Oe9PbAZ
	vN9fyrcVXTNvJq+WjDuHJEI1k/N8lkFFa4XPB+tr1G5PewSwZMRflNF7SlMf4WP8
	IugSWdXxvA4aBw0S0UtyGXc8vrpSg+vYF5Q8p8z385Tg7bAIAEXe7tcQuRquRpso
	GWt2sN/Hw4pbH+YJWIXrXjEeLQ/pNar8JHYNWV4yg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dwxkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 22:58:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKZZUY033518;
	Fri, 11 Oct 2024 22:58:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbt584-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 22:58:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49BMwj3U019358;
	Fri, 11 Oct 2024 22:58:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422uwbt57c-1;
	Fri, 11 Oct 2024 22:58:45 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org
Cc: zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        monis@mellanox.com, andrew.boyer@dell.com, leon@kernel.org,
        yonatanc@mellanox.com, linux-rdma@vger.kernel.org,
        sherry.yang@oracle.com
Subject: [PATCH 5.15.y 5.10.y 5.4.y] RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
Date: Fri, 11 Oct 2024 15:58:43 -0700
Message-ID: <20241011225843.1775390-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_20,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110160
X-Proofpoint-ORIG-GUID: H2aDCU9JY5YrCgQ7KCypyMWga4l2yeA8
X-Proofpoint-GUID: H2aDCU9JY5YrCgQ7KCypyMWga4l2yeA8

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit 2b23b6097303ed0ba5f4bc036a1c07b6027af5c6 ]

In rxe_comp_queue_pkt() an incoming response packet skb is enqueued to the
resp_pkts queue and then a decision is made whether to run the completer
task inline or schedule it. Finally the skb is dereferenced to bump a 'hw'
performance counter. This is wrong because if the completer task is
already running in a separate thread it may have already processed the skb
and freed it which can cause a seg fault.  This has been observed
infrequently in testing at high scale.

This patch fixes this by changing the order of enqueuing the packet until
after the counter is accessed.

Link: https://lore.kernel.org/r/20240329145513.35381-4-rpearsonhpe@gmail.com
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Fixes: 0b1e5b99a48b ("IB/rxe: Add port protocol stats")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Sherry: bp to fix CVE-2024-38544. Fix conflict due to missing commit:
dccb23f6c312 ("RDMA/rxe: Split rxe_run_task() into two subroutines")
which is not necessary to backport]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 48a3864ada29..250494306932 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -124,12 +124,12 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
 	int must_sched;
 
-	skb_queue_tail(&qp->resp_pkts, skb);
-
-	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
+	must_sched = skb_queue_len(&qp->resp_pkts) > 0;
 	if (must_sched != 0)
 		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
 
+	skb_queue_tail(&qp->resp_pkts, skb);
+
 	rxe_run_task(&qp->comp.task, must_sched);
 }
 
-- 
2.46.0


