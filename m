Return-Path: <linux-rdma+bounces-13166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 432C8B49CAB
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 00:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BE91B26E03
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B02EB878;
	Mon,  8 Sep 2025 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l8t2XxIA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A042E0B48;
	Mon,  8 Sep 2025 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368937; cv=none; b=UJDMvIvbXuGQbSM0gGyST9ZVQlJtyqP20WwloEL3AfEDmMWPIPxuGsATI6GTE7+ZFgChL2icleZPeWof/ztBVvbpUTrjq/togZ3YxOPZv/DABFp7lLmtnz6Y5TikbjcNYPSZpmfWhAhpzpgSuKJpiYHIWHbzUxxduOzEqurY/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368937; c=relaxed/simple;
	bh=7NY4au+FVcHrL1Ppuem7gZipZUMhri1geaZszZwCD5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVGii+z+82oz3Z/InTQVGKXRpGNP/Je3X8lDJKAbA3Jv3RI/T92O/b+Ai9KOWnxb0k+y4W3ZvNcKvhY0QXOMvYpRu0Wcmi2gIjf0xP+1N62JEwVkiTW7mXvFwlEQdsDtxcLeQe437s4HVSE3pP0N2YF1L7ewTq5AEIaADIz7MKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l8t2XxIA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588FD4SO027077;
	Mon, 8 Sep 2025 22:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I7eqHUoxoVp4Ft9D7
	njwXRV3GwVh95kt1h9dSGvY0zI=; b=l8t2XxIAOHM3HQQg6AbzbM7g1n0gTXLkK
	jkVxb5FWtINjMyVeresqQMjm5TUU6Qjg9PsSNhkX+mxIRjqGbpe6tSWKh0lGtIOj
	Bd7qGhKBBZUnHyx3WwwvyMWqWlprK5DFYV1TER3fWuuVoHAryPOGcvhjy+sCamD1
	zTlr5J46gnkH1YP7rFz0UMmkLvLF+AXpu32zyo7EwxMSUrcU8uLTQAYfXb3FzXVz
	s3+G2WF8k7d6qxYrTag8E9C+nUBl6mbhAYXHf9yYZDHfaUDRrZ/MgPCXfoa0q79+
	uSBJdPmVpquEuE5mt17wBBSu2mehctefCcVJD2TACGyImAM/MxKGQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycs1x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 22:02:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588M2BFd027898;
	Mon, 8 Sep 2025 22:02:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycs1x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 22:02:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588M0ZhA017188;
	Mon, 8 Sep 2025 22:02:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gm7wn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 22:02:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588M26O331851136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 22:02:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 758F620040;
	Mon,  8 Sep 2025 22:02:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30CD42004B;
	Mon,  8 Sep 2025 22:02:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 22:02:06 +0000 (GMT)
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
Subject: [PATCH net-next v2 2/2] net/smc: handle -ENOMEM from smc_wr_alloc_link_mem gracefully
Date: Tue,  9 Sep 2025 00:01:50 +0200
Message-ID: <20250908220150.3329433-3-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250908220150.3329433-1-pasic@linux.ibm.com>
References: <20250908220150.3329433-1-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pe98gGZTqXxbY0TJr6moTRohHPiMPIsN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX/BuYjfEd5uyz
 EklwP5h/e+wSM2RXbqwOb3b03HstKMHfnuc932avFcsWKL6JwE3m8XUxsnqfWjMufnZJ5SvEpWI
 W2qJMVgxMlj2wyjdq2e6+sOGQM/YMhkrBWcyKHkQt7Ux/KNT8WCocXNYjXrjcwzhW8pUH8YmKVZ
 rqr1ThuQPolJb5HX2aHPa066mFYwYA7HRdx4hbBwslwztYNtb80CYmg97kdMNpNTbEpBYrlMFxY
 cHJFEdZ2/CmiVPrz9Sxnr5nPIrgFEF39Ywl9QWV4k+uu5To+fRjZgK72PJtM4id2Lw17CqfQKX1
 Pd9d5G2qBGdXffAtDYEti6iY4I+x9HkRoW/GYtXLy5OCkgdxSJal5wLvtb7DNheyQBRrUBM4k/c
 RMvcYUzt
X-Proofpoint-GUID: 8APDllAdHVL77cDITuVXnJbKh-3j4E4p
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68bf5263 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=uE9bR6y1tBfQdXGO-kEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

Currently if a -ENOMEM from smc_wr_alloc_link_mem() is handled by
giving up and going the way of a TCP fallback. This was reasonable
before the sizes of the allocations there were compile time constants
and reasonably small. But now those are actually configurable.

So instead of giving up, keep retrying with half of the requested
size unless we dip below the old static sizes -- then give up!

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 Documentation/networking/smc-sysctl.rst |  9 ++++---
 net/smc/smc_core.c                      | 34 +++++++++++++++++--------
 net/smc/smc_core.h                      |  2 ++
 net/smc/smc_wr.c                        | 28 ++++++++++----------
 4 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index d533830df28f..846fdea87c84 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -85,9 +85,10 @@ smcr_pref_send_wr - INTEGER
 
 	Please be aware that all the buffers need to be allocated as a physically
 	continuous array in which each element is a single buffer and has the size
-	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
+	with half of the buffer count until it is ether successful or (unlikely)
+	we dip below the old hard coded value which is 16 where we give up much
 	like before having this control.
-	this control.
 
 	Default: 16
 
@@ -104,7 +105,9 @@ smcr_pref_recv_wr - INTEGER
 
 	Please be aware that all the buffers need to be allocated as a physically
 	continuous array in which each element is a single buffer and has the size
-	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
+	with half of the buffer count until it is ether successful or (unlikely)
+	we dip below the old hard coded value which is 16 where we give up much
 	like before having this control.
 
 	Default: 48
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 262746e304dd..d55511d79cc2 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -810,6 +810,8 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->clearing = 0;
 	lnk->path_mtu = lnk->smcibdev->pattr[lnk->ibport - 1].active_mtu;
 	lnk->link_id = smcr_next_link_id(lgr);
+	lnk->pref_send_wr = lgr->pref_send_wr;
+	lnk->pref_recv_wr = lgr->pref_recv_wr;
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
+		lnk->pref_send_wr /= 2;
+		lnk->pref_recv_wr /= 2;
+		/* ... unless droping below old SMC_WR_BUF_SIZE */
+		if (lnk->pref_send_wr < 16 || lnk->pref_recv_wr < 48)
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
index 78d5bcefa1b8..18ba0364ff52 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -174,6 +174,8 @@ struct smc_link {
 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
 	int			llc_testlink_time; /* testlink interval */
 	atomic_t		conn_cnt; /* connections on this link */
+	u16			pref_send_wr;
+	u16			pref_recv_wr;
 };
 
 /* For now we just allow one parallel link per link group. The SMC protocol
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 606fe0bec4ef..632d095599ed 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -548,9 +548,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
 		    IB_QP_DEST_QPN,
 		    &init_attr);
 
-	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->pref_send_wr,
+	lnk->wr_tx_cnt = min_t(size_t, lnk->pref_send_wr,
 			       lnk->qp_attr.cap.max_send_wr);
-	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->pref_recv_wr,
+	lnk->wr_rx_cnt = min_t(size_t, lnk->pref_recv_wr,
 			       lnk->qp_attr.cap.max_recv_wr);
 }
 
@@ -742,51 +742,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
 int smc_wr_alloc_link_mem(struct smc_link *link)
 {
 	/* allocate link related memory */
-	link->wr_tx_bufs = kcalloc(link->lgr->pref_send_wr,
+	link->wr_tx_bufs = kcalloc(link->pref_send_wr,
 				   SMC_WR_BUF_SIZE, GFP_KERNEL);
 	if (!link->wr_tx_bufs)
 		goto no_mem;
-	link->wr_rx_bufs = kcalloc(link->lgr->pref_recv_wr, SMC_WR_BUF_SIZE,
+	link->wr_rx_bufs = kcalloc(link->pref_recv_wr, SMC_WR_BUF_SIZE,
 				   GFP_KERNEL);
 	if (!link->wr_rx_bufs)
 		goto no_mem_wr_tx_bufs;
-	link->wr_tx_ibs = kcalloc(link->lgr->pref_send_wr,
+	link->wr_tx_ibs = kcalloc(link->pref_send_wr,
 				  sizeof(link->wr_tx_ibs[0]), GFP_KERNEL);
 	if (!link->wr_tx_ibs)
 		goto no_mem_wr_rx_bufs;
-	link->wr_rx_ibs = kcalloc(link->lgr->pref_recv_wr,
+	link->wr_rx_ibs = kcalloc(link->pref_recv_wr,
 				  sizeof(link->wr_rx_ibs[0]),
 				  GFP_KERNEL);
 	if (!link->wr_rx_ibs)
 		goto no_mem_wr_tx_ibs;
-	link->wr_tx_rdmas = kcalloc(link->lgr->pref_send_wr,
+	link->wr_tx_rdmas = kcalloc(link->pref_send_wr,
 				    sizeof(link->wr_tx_rdmas[0]),
 				    GFP_KERNEL);
 	if (!link->wr_tx_rdmas)
 		goto no_mem_wr_rx_ibs;
-	link->wr_tx_rdma_sges = kcalloc(link->lgr->pref_send_wr,
+	link->wr_tx_rdma_sges = kcalloc(link->pref_send_wr,
 					sizeof(link->wr_tx_rdma_sges[0]),
 					GFP_KERNEL);
 	if (!link->wr_tx_rdma_sges)
 		goto no_mem_wr_tx_rdmas;
-	link->wr_tx_sges = kcalloc(link->lgr->pref_send_wr, sizeof(link->wr_tx_sges[0]),
+	link->wr_tx_sges = kcalloc(link->pref_send_wr, sizeof(link->wr_tx_sges[0]),
 				   GFP_KERNEL);
 	if (!link->wr_tx_sges)
 		goto no_mem_wr_tx_rdma_sges;
-	link->wr_rx_sges = kcalloc(link->lgr->pref_recv_wr,
+	link->wr_rx_sges = kcalloc(link->pref_recv_wr,
 				   sizeof(link->wr_rx_sges[0]) * link->wr_rx_sge_cnt,
 				   GFP_KERNEL);
 	if (!link->wr_rx_sges)
 		goto no_mem_wr_tx_sges;
-	link->wr_tx_mask = bitmap_zalloc(link->lgr->pref_send_wr, GFP_KERNEL);
+	link->wr_tx_mask = bitmap_zalloc(link->pref_send_wr, GFP_KERNEL);
 	if (!link->wr_tx_mask)
 		goto no_mem_wr_rx_sges;
-	link->wr_tx_pends = kcalloc(link->lgr->pref_send_wr,
+	link->wr_tx_pends = kcalloc(link->pref_send_wr,
 				    sizeof(link->wr_tx_pends[0]),
 				    GFP_KERNEL);
 	if (!link->wr_tx_pends)
 		goto no_mem_wr_tx_mask;
-	link->wr_tx_compl = kcalloc(link->lgr->pref_send_wr,
+	link->wr_tx_compl = kcalloc(link->pref_send_wr,
 				    sizeof(link->wr_tx_compl[0]),
 				    GFP_KERNEL);
 	if (!link->wr_tx_compl)
@@ -907,7 +907,7 @@ int smc_wr_create_link(struct smc_link *lnk)
 		goto dma_unmap;
 	}
 	smc_wr_init_sge(lnk);
-	bitmap_zero(lnk->wr_tx_mask, lnk->lgr->pref_send_wr);
+	bitmap_zero(lnk->wr_tx_mask, lnk->pref_send_wr);
 	init_waitqueue_head(&lnk->wr_tx_wait);
 	rc = percpu_ref_init(&lnk->wr_tx_refs, smcr_wr_tx_refs_free, 0, GFP_KERNEL);
 	if (rc)
-- 
2.48.1


