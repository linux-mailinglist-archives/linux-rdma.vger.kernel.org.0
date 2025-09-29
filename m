Return-Path: <linux-rdma+bounces-13721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A1BA79BA
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 02:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02783B8BCB
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 00:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0130328469D;
	Mon, 29 Sep 2025 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WUHk0bXp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E32264B8;
	Mon, 29 Sep 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759104032; cv=none; b=aiyFZ0bqTu2av8FZ3gtEHT+XXBd6Y4DAUX9EwccFhk9TA32+PO9UFa2X76psRzBrCw9Uo+3XPUXYmpdIo3dbnHUl45C7cExTZjY8rhRdONPladLW4b75o3Hr0/VIff2isB9VXzstgQpiZ2lH2eV9oHZ8tYnwnF5KVve2AGXohEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759104032; c=relaxed/simple;
	bh=3ZjaENvPvkc3PjfXmgFcCoN0f+WjfkGRRCox+aiVeoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9f7mDfq1eRbxJdzcDiAxScx8g9PDGsK1O/CCzKf7SpbrAC61fv+K52NJkywsBNs1jqHDERs9WIJ0fLet/U0jOUxalqCeBfvjkfOB2uyB5ueNnTZDpowfJ7L6cJYEqrMtKWxx2ugxnlGPS5gAFn4yovupChXiKcODo+zeT1dIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WUHk0bXp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SNQeIP030485;
	Mon, 29 Sep 2025 00:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DBcEuMQa5aTd9wOqO
	qyprCOwEM//nF2OvO2RBmUWfqs=; b=WUHk0bXpgb5dOKj1aUJqdmFOaGRGspv8j
	5YFD/y1NBE9PhcGPv0G6Ld57JXe4ioRieFAgVUL7AE9cX+3t31ZcLCUI1anOTFsM
	MEQCBAJGtReAVq6Gv9i7otJoiJ/tpr5q/IYTKynNYKppbyPFllfihNgvIsEuVqCb
	0sXsTMO2cTYhC77VWwc7IyPx78UsSkrhyvAoUFrJB/kXFC/jUwAer9wYdiqJeZCu
	srLMe3lKH/nNJ9HBF24pBmJjLTJ4ImG/eM1LUk5fOto7c3LNcwHao0aMZN6pELS/
	h+0G3Plig5A6VZbEZN7TMKlf4ISQbseOupkyhaoIN2fBqv1DbOVhw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh7bfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 00:00:12 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58T00BaT023170;
	Mon, 29 Sep 2025 00:00:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh7bfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 00:00:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SIZDDK007292;
	Mon, 29 Sep 2025 00:00:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurjkfsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 00:00:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58T006k118285002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 00:00:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C35D220043;
	Mon, 29 Sep 2025 00:00:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61B5E20040;
	Mon, 29 Sep 2025 00:00:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Sep 2025 00:00:06 +0000 (GMT)
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
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH net-next v5 2/2] net/smc: handle -ENOMEM from smc_wr_alloc_link_mem gracefully
Date: Mon, 29 Sep 2025 02:00:01 +0200
Message-ID: <20250929000001.1752206-3-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929000001.1752206-1-pasic@linux.ibm.com>
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d9cc0c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=gpm2FF-g8vmvhG6dL6YA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX2XQAOfbkgyAj
 APAWgYC1hMrqsQmS96XN1Gxb3HreqPCz6Gmmv+xiicoIKMfWhM6sZ1mLsBLMOlAAc3+qFo8CW5V
 CdZRtf+Uof1lorzYC6Ar8NG5yvliaXUhX1s50OGlfaeqcjcHABG+DoyDkPKEzebuechNUn/2x4i
 eRSGTHH/3Z6cKgMupwAZeB9ikDUl/k9AnmInvWkxzxFWOg9uMLTuX0uipGLjyLwHjtvsizJ/BL2
 W0M9LxodaHR10PLp/k1hwqiT1xhmfqrrh60Q/UOgvV5UrV1rN+Q09aN5XgVlpYekXWiYtGzfmCz
 V2643WFVQc+p9IheM4Ieds3L2tMMmiOeXKE2qOEgvEXA3foKyBHV0RIIy2J3glgNf3cVEZ02vB3
 2pDSAchKyHaUiHgSbWCcohNem1at7A==
X-Proofpoint-GUID: AVZVb7A9MVBfog6JIzm7BG4keC9sGTvT
X-Proofpoint-ORIG-GUID: Wc4el4PKZWQun37qkuiHqCoQ9T5d1EVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_10,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010

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
---
 Documentation/networking/smc-sysctl.rst |  8 ++++--
 net/smc/smc_core.c                      | 34 +++++++++++++++++--------
 net/smc/smc_core.h                      |  2 ++
 net/smc/smc_wr.c                        | 28 ++++++++++----------
 4 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index 5de4893ef3e7..4a5b4c89bc97 100644
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


