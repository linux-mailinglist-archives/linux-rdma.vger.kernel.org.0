Return-Path: <linux-rdma+bounces-14081-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00902C11E66
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 23:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE5504FE5D4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 22:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9192330309;
	Mon, 27 Oct 2025 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LF/lIUr1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D31D32E14D;
	Mon, 27 Oct 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605360; cv=none; b=blK43xX06c2cTSGtNdSrVUkbhqM45dMW1gU7WyPOVxLHSS6OhYnCYTMGzqg1QjIE9W2010O2Eplqj0m/6Cqw4PXKAqWm6qS4UwDWzoiQHsmCXuePnMY5ntvKjqvJ9EwoT5qZ77WLLhMJW8KQrYou5u/A17qs+C9ilwPlN63o0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605360; c=relaxed/simple;
	bh=+GEACyZCZS+HBvX9zYiAjJ67P762LUNPLIxfR60aqEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgEeW5USs2Pj2S8qB3VhUX0n6aEitl4GrW6TRVZ4F0XFD9RwgsNbFQCr7ZEOhWvsS+/Fhiml+rystJJJhtc4rDk8myrlhh2lpEqckfmuuREJGhF6LR++5bqVlI8qiv9Z3BPqspMnCZ4I7n306PixUJD6WbZxlB+UdgzqFOE1kJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LF/lIUr1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDLKtX026955;
	Mon, 27 Oct 2025 22:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vCE/W5S+kEZlj7fJc
	5Y3UNShKdRqrEEAXxsVBnSxIvE=; b=LF/lIUr1+RV+t79KPwbqsQrIOIOfZgPsn
	ocgN9dp9vcNdUGECK0fgjdqdF8J+LD3mYWVEI5KjmntPFWWuwEzOYaxckZk0dYhC
	+4DyL5DoVaYHMKUlBd7WGPYKM/eL0TOINpGt9TI8+0PQ49EsJQt4xEB9gNKzb5dZ
	gflYVLFk461XlY80y+HZSJsZzwVrnIzzzOBNPU6APNYxRpCJ0x91kPcRTLjRcUiF
	Jwc8XlUF4ZwnLMAfwlQuKrB88HM1ETnhEScRqUNf9HcYScDbq5MG9ehg1660oBJR
	cA+Gb/xMTrZ65ZfTdnJxKiXRopFuOMqZvhKt1uBeswEsfOPqLD0tA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p99153w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 22:49:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59RMk1i4017026;
	Mon, 27 Oct 2025 22:49:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p99153t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 22:49:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RMe62f030074;
	Mon, 27 Oct 2025 22:49:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a19vmfxx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 22:49:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RMn2aO29033160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 22:49:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BED42004B;
	Mon, 27 Oct 2025 22:49:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6CE920043;
	Mon, 27 Oct 2025 22:49:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 22:49:01 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v6 2/2] net/smc: handle -ENOMEM from smc_wr_alloc_link_mem gracefully
Date: Mon, 27 Oct 2025 23:48:56 +0100
Message-ID: <20251027224856.2970019-3-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027224856.2970019-1-pasic@linux.ibm.com>
References: <20251027224856.2970019-1-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=68fff6e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8
 a=gpm2FF-g8vmvhG6dL6YA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: pzQSG3u0NkBVm02HUJln8va1lGksVM1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX4eb2yPelVAKc
 wAkSAOKPpikag/vwVruBQbp6esJ+B5WipRxGlxoZB20S8lXker8dERgMiPi8K+F6w3koEPb8Lid
 V96UfG1m86nxg1VDA10EqASwjNqAB4NTiBSQBv6jwEhGAYpVfQdDaPJbh3apsAUAqIa+WLw3zgZ
 /xyCN4Yhqzkerbzhnl8qen/SGT64YZytwZCpFhE4d/a5OxsiJKlVzI5KogPAN75gxbGX3Ix7y4r
 1JVSJOJRxEeoziskHJvtYNtapoTTZfVLDeS6yWiTVTiQZEsHGOaAP2iZ/PQ0BWdsMUIv/k9nd0K
 HgU0sCf9UTo/vDZGUBe+L7I26j1MkRRC7S/4XXljDfKKTZ9JAadZNkmembhUOFlxyTs0nW7qbVT
 Wza+1OFTDkK4NAwRVGdo2W4VX/2MOQ==
X-Proofpoint-ORIG-GUID: GCCtVFaB8B9r8Q-8GGHwx9Fvam9BlnbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019

Currently if a -ENOMEM from smc_wr_alloc_link_mem() is handled by
giving up and going the way of a TCP fallback. This was reasonable
before the sizes of the allocations there were compile time constants
and reasonably small. But now those are actually configurable.

So instead of giving up, keep retrying with half of the requested size
unless we dip below the old static sizes -- then give up! In terms of
numbers that means we give up when it is certain that we at best would
end up allocating less than 16 send WR buffers or less than 48 recv WR
buffers. This is to avoid regressions due to having fewer buffers
compared the static values of the past.

Please note that SMC-R is supposed to be an optimisation over TCP, and
falling back to TCP is superior to establishing an SMC connection that
is going to perform worse. If the memory allocation fails (and we
propagate -ENOMEM), we fall back to TCP.

Preserve (modulo truncation) the ratio of send/recv WR buffer counts.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
 Documentation/networking/smc-sysctl.rst |  8 ++++--
 net/smc/smc_core.c                      | 34 +++++++++++++++++--------
 net/smc/smc_core.h                      |  2 ++
 net/smc/smc_wr.c                        | 28 ++++++++++----------
 4 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index 337ac2be167e..904a910f198e 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -85,7 +85,9 @@ smcr_max_send_wr - INTEGER
 
 	Please be aware that all the buffers need to be allocated as a physically
 	continuous array in which each element is a single buffer and has the size
-	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
+	with half of the buffer count until it is ether successful or (unlikely)
+	we dip below the old hard coded value which is 16 where we give up much
 	like before having this control.
 
 	Default: 16
@@ -103,7 +105,9 @@ smcr_max_recv_wr - INTEGER
 
 	Please be aware that all the buffers need to be allocated as a physically
 	continuous array in which each element is a single buffer and has the size
-	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
+	with half of the buffer count until it is ether successful or (unlikely)
+	we dip below the old hard coded value which is 16 where we give up much
 	like before having this control.
 
 	Default: 48
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index be0c2da83d2b..e4eabc83719e 100644
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
index 8d06c8bb14e9..5c18f08a4c8a 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -175,6 +175,8 @@ struct smc_link {
 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
 	int			llc_testlink_time; /* testlink interval */
 	atomic_t		conn_cnt; /* connections on this link */
+	u16			max_send_wr;
+	u16			max_recv_wr;
 };
 
 /* For now we just allow one parallel link per link group. The SMC protocol
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 883fb0f1ce43..5feafa98ab1a 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -547,9 +547,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
 		    IB_QP_DEST_QPN,
 		    &init_attr);
 
-	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->max_send_wr,
+	lnk->wr_tx_cnt = min_t(size_t, lnk->max_send_wr,
 			       lnk->qp_attr.cap.max_send_wr);
-	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->max_recv_wr,
+	lnk->wr_rx_cnt = min_t(size_t, lnk->max_recv_wr,
 			       lnk->qp_attr.cap.max_recv_wr);
 }
 
@@ -741,51 +741,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
 int smc_wr_alloc_link_mem(struct smc_link *link)
 {
 	/* allocate link related memory */
-	link->wr_tx_bufs = kcalloc(link->lgr->max_send_wr,
+	link->wr_tx_bufs = kcalloc(link->max_send_wr,
 				   SMC_WR_BUF_SIZE, GFP_KERNEL);
 	if (!link->wr_tx_bufs)
 		goto no_mem;
-	link->wr_rx_bufs = kcalloc(link->lgr->max_recv_wr, link->wr_rx_buflen,
+	link->wr_rx_bufs = kcalloc(link->max_recv_wr, link->wr_rx_buflen,
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
@@ -906,7 +906,7 @@ int smc_wr_create_link(struct smc_link *lnk)
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


