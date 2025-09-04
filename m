Return-Path: <linux-rdma+bounces-13100-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA2EB4483F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 23:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3869617CC08
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 21:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0CA29E10C;
	Thu,  4 Sep 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AcmhCGZs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742C29AB02;
	Thu,  4 Sep 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020399; cv=none; b=ApFCeVd7hYbsK47+NSe3ebUlGjoXihStzhwS1lCYFODdye4jjF6nn4yKuhipfBxtG/VreYFHJjzsRn/okx3EwP30Lt+uvi4s76rLvF+/HXLo92FgmoNrIc8jdRB6SsHMpcFCxnrHLTJY5cBs8J5wN/W/D/2CcLBQbx0qge2A4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020399; c=relaxed/simple;
	bh=hFC6Nms8C9ZkV5HnsMqil0Xb8sl6YFpXTCVKesSFKnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYn5PLDH1Jo2l5Zz605ciHtAmW6f7aGOGfLvro+eL0nlwxndzPsL1glGeERnApCH38Xmrg0mf99BbSjt7qEtLBkiS+PLq1XuVltU+8CqCCgQBSgZZJnvRHmEEXde89K6vUTkkjP8fonDAlBTQMjS/6ceSpWBoX/2Y2tFxqdFRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AcmhCGZs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584JislO021545;
	Thu, 4 Sep 2025 21:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q7bxqLDXoCV8WUS1V
	9DL3EafhTM2XLjsHohmB9OjoGE=; b=AcmhCGZsE+f3KacQIiFNRAta1I+vuAV2b
	LtAPXSMqMYTZTDeiwTfBKuN+oVt0YLXZC2oPFVluRWqKU+HetLwempkD+z8BbmXr
	nbfAb2ERVreSAyrX+bavglGKqZiT5USFi9sFg5vdzrQW84Hthvkxo9IG+kRhQUL6
	XJoP/2AMPERn8qDt+2nEripDQMOVRWcAqHSm5CYayU8ERkleCxQ75P5VHlvYJZQ6
	QcUcuLceixlo2egCn63VCmUH36sTBDkJMUPntLS1MWTo8mnQoYmqYLNJCPLvMhNV
	i9frgikcJaLj0Zsil/apY9FLcfhfjDk9j5fGsnWmKjh4Mk7sPPWDg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurcqn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 21:13:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 584Kubh5023452;
	Thu, 4 Sep 2025 21:13:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurcqn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 21:13:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584Ixlwx021184;
	Thu, 4 Sep 2025 21:13:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpxfnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 21:13:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584LD66b46334214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 21:13:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C491320043;
	Thu,  4 Sep 2025 21:13:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E54120040;
	Thu,  4 Sep 2025 21:13:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 21:13:06 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH net-next 2/2] net/smc: handle -ENOMEM from smc_wr_alloc_link_mem gracefully
Date: Thu,  4 Sep 2025 23:12:53 +0200
Message-ID: <20250904211254.1057445-3-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250904211254.1057445-1-pasic@linux.ibm.com>
References: <20250904211254.1057445-1-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX0bkxGRNwBPTM
 0+T/lgY0FxHe+qLbexriYhrHeeemslx8RNxsS/riuQMs0peoLeEnjaOnOdO0avozXri6szFkZ4S
 6HQ1cpl4dlCN9B6Om6I4/mxWBquByAxuU0nJXv/R7x0N5dLAnjAO07p6PelQmiH7SSjGPpL57b9
 FdDOd59xEkVhT2+r6qwG1R4i2QVTlxiRdoQGWW7JXOCtcGe9lZR7c8rKEGo24RYc+NgFq5C+qVH
 4yQw6XHGRjxXyzmNagaTO9MgxG90pbPjOElJTHMOnkGJ1qdt8shQhCAGIUkBE/6hlROFmIZWLSt
 7IWwDqqWtSYSNWQcKXrZXYjDI+rpvweiIj4xK36Ig1vM4BQejK5ghqpPri1UG23k945ZJruzivQ
 uhhUDgXj
X-Proofpoint-GUID: 1qU3_8re3h3iooajrEp7y9Iwnmn-pJka
X-Proofpoint-ORIG-GUID: 4bbmx_NnqJcWUh89kPKyVUrszrR6RGnQ
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68ba00e8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=7VMdMTDjWeNOirE0wYMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

Currently if a -ENOMEM from smc_wr_alloc_link_mem() is handled by
giving up and going the way of a TCP fallback. This was reasonable
before the sizes of the allocations there were compile time constants
and reasonably small. But now those are actually configurable.

So instead of giving up, keep retrying with half of the requested
size unless we dip below the old static sizes -- then give up!

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 Documentation/networking/smc-sysctl.rst |  9 ++++---
 net/smc/smc_core.c                      | 34 +++++++++++++++++--------
 net/smc/smc_core.h                      |  2 ++
 net/smc/smc_wr.c                        | 28 ++++++++++----------
 4 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index c687092329e3..c8dbe7ac8bdf 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -85,9 +85,10 @@ smcr_max_send_wr - INTEGER
 
 	Please be aware that all the buffers need to be allocated as a physically
 	continuous array in which each element is a single buffer and has the size
-	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
+	with half of the buffer count until it is ether successful or (unlikely)
+	we dip below the old hard coded value which is 16 where we give up much
 	like before having this control.
-	this control.
 
 	Default: 16
 
@@ -104,7 +105,9 @@ smcr_max_recv_wr - INTEGER
 
 	Please be aware that all the buffers need to be allocated as a physically
 	continuous array in which each element is a single buffer and has the size
-	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
+	with half of the buffer count until it is ether successful or (unlikely)
+	we dip below the old hard coded value which is 16 where we give up much
 	like before having this control.
 
 	Default: 48
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 262746e304dd..da2bde99ebc6 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -810,6 +810,8 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->clearing = 0;
 	lnk->path_mtu = lnk->smcibdev->pattr[lnk->ibport - 1].active_mtu;
 	lnk->link_id = smcr_next_link_id(lgr);
+	lnk->max_send_wr = lgr->max_send_wr;
+	lnk->max_recv_wr = lgr->max_recv_wr;
 	lnk->lgr = lgr;
 	smc_lgr_hold(lgr); /* lgr_put in smcr_link_clear() */
 	lnk->link_idx = link_idx;
@@ -836,27 +838,39 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	rc = smc_llc_link_init(lnk);
 	if (rc)
 		goto out;
-	rc = smc_wr_alloc_link_mem(lnk);
-	if (rc)
-		goto clear_llc_lnk;
 	rc = smc_ib_create_protection_domain(lnk);
 	if (rc)
-		goto free_link_mem;
-	rc = smc_ib_create_queue_pair(lnk);
-	if (rc)
-		goto dealloc_pd;
+		goto clear_llc_lnk;
+	do {
+		rc = smc_ib_create_queue_pair(lnk);
+		if (rc)
+			goto dealloc_pd;
+		rc = smc_wr_alloc_link_mem(lnk);
+		if (!rc)
+			break;
+		else if (rc != -ENOMEM) /* give up */
+			goto destroy_qp;
+		/* retry with smaller ... */
+		lnk->max_send_wr /= 2;
+		lnk->max_recv_wr /= 2;
+		/* ... unless droping below old SMC_WR_BUF_SIZE */
+		if (lnk->max_send_wr < 16 || lnk->max_recv_wr < 48)
+			goto destroy_qp;
+		smc_ib_destroy_queue_pair(lnk);
+	} while (1);
+
 	rc = smc_wr_create_link(lnk);
 	if (rc)
-		goto destroy_qp;
+		goto free_link_mem;
 	lnk->state = SMC_LNK_ACTIVATING;
 	return 0;
 
+free_link_mem:
+	smc_wr_free_link_mem(lnk);
 destroy_qp:
 	smc_ib_destroy_queue_pair(lnk);
 dealloc_pd:
 	smc_ib_dealloc_protection_domain(lnk);
-free_link_mem:
-	smc_wr_free_link_mem(lnk);
 clear_llc_lnk:
 	smc_llc_link_clear(lnk, false);
 out:
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index b883f43fc206..92d70c57d23d 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -172,6 +172,8 @@ struct smc_link {
 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
 	int			llc_testlink_time; /* testlink interval */
 	atomic_t		conn_cnt; /* connections on this link */
+	u16			max_send_wr;
+	u16			max_recv_wr;
 };
 
 /* For now we just allow one parallel link per link group. The SMC protocol
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 85ebc65f1546..4759041d3b02 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -548,9 +548,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
 		    IB_QP_DEST_QPN,
 		    &init_attr);
 
-	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->max_send_wr,
+	lnk->wr_tx_cnt = min_t(size_t, lnk->max_send_wr,
 			       lnk->qp_attr.cap.max_send_wr);
-	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->max_recv_wr,
+	lnk->wr_rx_cnt = min_t(size_t, lnk->max_recv_wr,
 			       lnk->qp_attr.cap.max_recv_wr);
 }
 
@@ -742,51 +742,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
 int smc_wr_alloc_link_mem(struct smc_link *link)
 {
 	/* allocate link related memory */
-	link->wr_tx_bufs = kcalloc(link->lgr->max_send_wr,
+	link->wr_tx_bufs = kcalloc(link->max_send_wr,
 				   SMC_WR_BUF_SIZE, GFP_KERNEL);
 	if (!link->wr_tx_bufs)
 		goto no_mem;
-	link->wr_rx_bufs = kcalloc(link->lgr->max_recv_wr, SMC_WR_BUF_SIZE,
+	link->wr_rx_bufs = kcalloc(link->max_recv_wr, SMC_WR_BUF_SIZE,
 				   GFP_KERNEL);
 	if (!link->wr_rx_bufs)
 		goto no_mem_wr_tx_bufs;
-	link->wr_tx_ibs = kcalloc(link->lgr->max_send_wr,
+	link->wr_tx_ibs = kcalloc(link->max_send_wr,
 				  sizeof(link->wr_tx_ibs[0]), GFP_KERNEL);
 	if (!link->wr_tx_ibs)
 		goto no_mem_wr_rx_bufs;
-	link->wr_rx_ibs = kcalloc(link->lgr->max_recv_wr,
+	link->wr_rx_ibs = kcalloc(link->max_recv_wr,
 				  sizeof(link->wr_rx_ibs[0]),
 				  GFP_KERNEL);
 	if (!link->wr_rx_ibs)
 		goto no_mem_wr_tx_ibs;
-	link->wr_tx_rdmas = kcalloc(link->lgr->max_send_wr,
+	link->wr_tx_rdmas = kcalloc(link->max_send_wr,
 				    sizeof(link->wr_tx_rdmas[0]),
 				    GFP_KERNEL);
 	if (!link->wr_tx_rdmas)
 		goto no_mem_wr_rx_ibs;
-	link->wr_tx_rdma_sges = kcalloc(link->lgr->max_send_wr,
+	link->wr_tx_rdma_sges = kcalloc(link->max_send_wr,
 					sizeof(link->wr_tx_rdma_sges[0]),
 					GFP_KERNEL);
 	if (!link->wr_tx_rdma_sges)
 		goto no_mem_wr_tx_rdmas;
-	link->wr_tx_sges = kcalloc(link->lgr->max_send_wr, sizeof(link->wr_tx_sges[0]),
+	link->wr_tx_sges = kcalloc(link->max_send_wr, sizeof(link->wr_tx_sges[0]),
 				   GFP_KERNEL);
 	if (!link->wr_tx_sges)
 		goto no_mem_wr_tx_rdma_sges;
-	link->wr_rx_sges = kcalloc(link->lgr->max_recv_wr,
+	link->wr_rx_sges = kcalloc(link->max_recv_wr,
 				   sizeof(link->wr_rx_sges[0]) * link->wr_rx_sge_cnt,
 				   GFP_KERNEL);
 	if (!link->wr_rx_sges)
 		goto no_mem_wr_tx_sges;
-	link->wr_tx_mask = bitmap_zalloc(link->lgr->max_send_wr, GFP_KERNEL);
+	link->wr_tx_mask = bitmap_zalloc(link->max_send_wr, GFP_KERNEL);
 	if (!link->wr_tx_mask)
 		goto no_mem_wr_rx_sges;
-	link->wr_tx_pends = kcalloc(link->lgr->max_send_wr,
+	link->wr_tx_pends = kcalloc(link->max_send_wr,
 				    sizeof(link->wr_tx_pends[0]),
 				    GFP_KERNEL);
 	if (!link->wr_tx_pends)
 		goto no_mem_wr_tx_mask;
-	link->wr_tx_compl = kcalloc(link->lgr->max_send_wr,
+	link->wr_tx_compl = kcalloc(link->max_send_wr,
 				    sizeof(link->wr_tx_compl[0]),
 				    GFP_KERNEL);
 	if (!link->wr_tx_compl)
@@ -907,7 +907,7 @@ int smc_wr_create_link(struct smc_link *lnk)
 		goto dma_unmap;
 	}
 	smc_wr_init_sge(lnk);
-	bitmap_zero(lnk->wr_tx_mask, lnk->lgr->max_send_wr);
+	bitmap_zero(lnk->wr_tx_mask, lnk->max_send_wr);
 	init_waitqueue_head(&lnk->wr_tx_wait);
 	rc = percpu_ref_init(&lnk->wr_tx_refs, smcr_wr_tx_refs_free, 0, GFP_KERNEL);
 	if (rc)
-- 
2.48.1


