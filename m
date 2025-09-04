Return-Path: <linux-rdma+bounces-13101-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E83B44840
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CAF17AE60
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35BC29E10F;
	Thu,  4 Sep 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hyzk1hC9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A329D281;
	Thu,  4 Sep 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020399; cv=none; b=A24LD03B7Z6G29UEYOlTsbg6pshuubdZGRafpfNySFvyMgKb4+SJ+zlbLxlRlQKXcX3jWBxVdg5EbBCrujs8ux++57mTMFmwzUrQowRtdWZCgUqlQP8YgjV1l3VChtbYDpdFUnu4CwyY9xvIttI3r56jk87QJk3S40qd3SkimgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020399; c=relaxed/simple;
	bh=PG+ib/nk6SWnN9J3aSk2bi5cGPIS3zNAw9Aj90ie2lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pE0B2n2YwG6hDaYfIwySkNAe4QQ5dFvhYZLSa+NR7i4ZM9l9ftvxJBP7IDXeq4bBfsdw4Mjyd5NO2Tq/q7vr8PKWN2ZUoi220vSZ1/dCVtTEzkbFegq4YqrSYAlQrH6hTL1e5A22Qm1ps2kZx2N1HHqxDXYvXWPm9TyyeEvOmQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hyzk1hC9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584ELORD009202;
	Thu, 4 Sep 2025 21:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8a6tHUF39FrptoQJQ
	e5qW45HCdImsqKMlWl9c5/fngo=; b=hyzk1hC90mkVJIxCW9WUcsuf0FgeanCdT
	2n1GEltzdPtLvuCYazucaA0JPs07xZ0s0eFaycGGsoFGBuXaomHfDsDbmaP2qtT/
	QW+XfIBlecKVwDT5gIuGHdgoGkNkjFE7aINkyZOf4a+lvqAZ8zMpg75bLQzfvYBS
	UQBc7RqjhK9fsze7V7cu21Lq81JKRXWwuc5UDQqyc2XgmWksTnHtHtD6dVgAOnQd
	7S1Ht9E6Tsa0WXfj8tMOp50hTiPx5te8AULyGR2bNNxQ4F8XbXTdCdLyodXIpMx3
	0YE7GfZluf4L26mS+z0d1GGusDXNKdxnoclTPBz78/Fcr3f3lW1aQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswdmqu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 21:13:09 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 584L9WGJ006319;
	Thu, 4 Sep 2025 21:13:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswdmqtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 21:13:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584Kr2GM014345;
	Thu, 4 Sep 2025 21:13:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3p51j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 21:13:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584LD48M51642834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 21:13:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2193120043;
	Thu,  4 Sep 2025 21:13:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF3E420040;
	Thu,  4 Sep 2025 21:13:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 21:13:03 +0000 (GMT)
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
Subject: [PATCH net-next 1/2] net/smc: make wr buffer count configurable
Date: Thu,  4 Sep 2025 23:12:52 +0200
Message-ID: <20250904211254.1057445-2-pasic@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68ba00e5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=bFSKpROA1of_4W3tK1kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX/3L2dsQq29D9
 GQnnGvUOexAE+hnMsZFjRYFrjQL1pg/+7tU317SsGWO5guyOY3sibJ7zGiVyRWT37J8ssrQLWdZ
 jqCPBblbrqAUsPSR2zZx6E8hwGMSLnHpxySzUN4HSaqH7Ybi9iqNZPaoATwANAt10pRiA0bUp3C
 F+6AUbpIYB1UB4n3kqY68vEbV/YW3Jg4ne5IqHLl+b0feJxtPJgbgWFzG4WgaPJvqVINaZIoLy8
 OqAPUmjre/skLiVscjblZ7pI31uN3NeDoPOYpZwXtFufKNVWY1LHlEpiASSc0iKvSg2KRD51Bi7
 UDS7ZMMn50z+vhS3tAh0jdk916LNN4pwpssH3YYaQFoJOraPZ79r+4B/Eg1P7Uv0YAbg8jnLPHl
 pdIJIWw+
X-Proofpoint-GUID: sWg36E1s0zG8R-QJlqtVrguB119In2Jv
X-Proofpoint-ORIG-GUID: D-Hn-qxd3qdk5Gd6EdcKPCV5-GwoDS4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
get replaced with lgr->max_send_wr and lgr->max_recv_wr respective.

While at it let us also remove a confusing comment that is either not
about the context in which it resides (describing
qp_attr.cap.max_send_wr and qp_attr.cap.max_recv_wr) or not applicable
any more when these values become configurable .

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 Documentation/networking/smc-sysctl.rst | 37 +++++++++++++++++++++++++
 net/smc/smc.h                           |  2 ++
 net/smc/smc_core.h                      |  4 +++
 net/smc/smc_ib.c                        |  7 ++---
 net/smc/smc_llc.c                       |  2 ++
 net/smc/smc_sysctl.c                    | 22 +++++++++++++++
 net/smc/smc_wr.c                        | 32 +++++++++++----------
 net/smc/smc_wr.h                        |  2 --
 8 files changed, 86 insertions(+), 22 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index a874d007f2db..c687092329e3 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -71,3 +71,40 @@ smcr_max_conns_per_lgr - INTEGER
 	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
 
 	Default: 255
+
+smcr_max_send_wr - INTEGER
+	So called work request buffers are SMCR link (and RDMA queue pair) level
+	resources necessary for performing RDMA operations. Since up to 255
+	connections can share a link group and thus also a link and the number
+	of the work request buffers is decided when the link is allocated,
+	depending on the workload it can a bottleneck in a sense that threads
+	have to wait for work request buffers to become available. Before the
+	introduction of this control the maximal number of work request buffers
+	available on the send path used to be hard coded to 16. With this control
+	it becomes configurable. The acceptable range is between 2 and 2048.
+
+	Please be aware that all the buffers need to be allocated as a physically
+	continuous array in which each element is a single buffer and has the size
+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
+	like before having this control.
+	this control.
+
+	Default: 16
+
+smcr_max_recv_wr - INTEGER
+	So called work request buffers are SMCR link (and RDMA queue pair) level
+	resources necessary for performing RDMA operations. Since up to 255
+	connections can share a link group and thus also a link and the number
+	of the work request buffers is decided when the link is allocated,
+	depending on the workload it can a bottleneck in a sense that threads
+	have to wait for work request buffers to become available. Before the
+	introduction of this control the maximal number of work request buffers
+	available on the receive path used to be hard coded to 16. With this control
+	it becomes configurable. The acceptable range is between 2 and 2048.
+
+	Please be aware that all the buffers need to be allocated as a physically
+	continuous array in which each element is a single buffer and has the size
+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
+	like before having this control.
+
+	Default: 48
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 2c9084963739..ffe48253fa1f 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -33,6 +33,8 @@
 
 extern struct proto smc_proto;
 extern struct proto smc_proto6;
+extern unsigned int smc_ib_sysctl_max_send_wr;
+extern unsigned int smc_ib_sysctl_max_recv_wr;
 
 extern struct smc_hashinfo smc_v4_hashinfo;
 extern struct smc_hashinfo smc_v6_hashinfo;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 48a1b1dcb576..b883f43fc206 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -361,6 +361,10 @@ struct smc_link_group {
 						/* max conn can be assigned to lgr */
 			u8			max_links;
 						/* max links can be added in lgr */
+			u16			max_send_wr;
+						/* number of WR buffers on send */
+			u16			max_recv_wr;
+						/* number of WR buffers on recv */
 		};
 		struct { /* SMC-D */
 			struct smcd_gid		peer_gid;
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 0052f02756eb..e8d35c22c525 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -669,11 +669,6 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
 		.recv_cq = lnk->smcibdev->roce_cq_recv,
 		.srq = NULL,
 		.cap = {
-				/* include unsolicited rdma_writes as well,
-				 * there are max. 2 RDMA_WRITE per 1 WR_SEND
-				 */
-			.max_send_wr = SMC_WR_BUF_CNT * 3,
-			.max_recv_wr = SMC_WR_BUF_CNT * 3,
 			.max_send_sge = SMC_IB_MAX_SEND_SGE,
 			.max_recv_sge = lnk->wr_rx_sge_cnt,
 			.max_inline_data = 0,
@@ -683,6 +678,8 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
 	};
 	int rc;
 
+	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
+	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;
 	lnk->roce_qp = ib_create_qp(lnk->roce_pd, &qp_attr);
 	rc = PTR_ERR_OR_ZERO(lnk->roce_qp);
 	if (IS_ERR(lnk->roce_qp))
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index f865c58c3aa7..91c936bf7336 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -2157,6 +2157,8 @@ void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc)
 	init_waitqueue_head(&lgr->llc_msg_waiter);
 	init_rwsem(&lgr->llc_conf_mutex);
 	lgr->llc_testlink_time = READ_ONCE(net->smc.sysctl_smcr_testlink_time);
+	lgr->max_send_wr = (u16)(READ_ONCE(smc_ib_sysctl_max_send_wr));
+	lgr->max_recv_wr = (u16)(READ_ONCE(smc_ib_sysctl_max_recv_wr));
 }
 
 /* called after lgr was removed from lgr_list */
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 2fab6456f765..01da1297e150 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -29,6 +29,10 @@ static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
 static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
 static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
 static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
+unsigned int smc_ib_sysctl_max_send_wr = 16;
+unsigned int smc_ib_sysctl_max_recv_wr = 48;
+static unsigned int smc_ib_sysctl_max_wr_min = 2;
+static unsigned int smc_ib_sysctl_max_wr_max = 2048;
 
 static struct ctl_table smc_table[] = {
 	{
@@ -99,6 +103,24 @@ static struct ctl_table smc_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname       = "smcr_max_send_wr",
+		.data		= &smc_ib_sysctl_max_send_wr,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1		= &smc_ib_sysctl_max_wr_min,
+		.extra2		= &smc_ib_sysctl_max_wr_max,
+	},
+	{
+		.procname       = "smcr_max_recv_wr",
+		.data		= &smc_ib_sysctl_max_recv_wr,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1		= &smc_ib_sysctl_max_wr_min,
+		.extra2		= &smc_ib_sysctl_max_wr_max,
+	},
 };
 
 int __net_init smc_sysctl_net_init(struct net *net)
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index b04a21b8c511..85ebc65f1546 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -34,6 +34,7 @@
 #define SMC_WR_MAX_POLL_CQE 10	/* max. # of compl. queue elements in 1 poll */
 
 #define SMC_WR_RX_HASH_BITS 4
+
 static DEFINE_HASHTABLE(smc_wr_rx_hash, SMC_WR_RX_HASH_BITS);
 static DEFINE_SPINLOCK(smc_wr_rx_hash_lock);
 
@@ -547,9 +548,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
 		    IB_QP_DEST_QPN,
 		    &init_attr);
 
-	lnk->wr_tx_cnt = min_t(size_t, SMC_WR_BUF_CNT,
+	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->max_send_wr,
 			       lnk->qp_attr.cap.max_send_wr);
-	lnk->wr_rx_cnt = min_t(size_t, SMC_WR_BUF_CNT * 3,
+	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->max_recv_wr,
 			       lnk->qp_attr.cap.max_recv_wr);
 }
 
@@ -741,50 +742,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
 int smc_wr_alloc_link_mem(struct smc_link *link)
 {
 	/* allocate link related memory */
-	link->wr_tx_bufs = kcalloc(SMC_WR_BUF_CNT, SMC_WR_BUF_SIZE, GFP_KERNEL);
+	link->wr_tx_bufs = kcalloc(link->lgr->max_send_wr,
+				   SMC_WR_BUF_SIZE, GFP_KERNEL);
 	if (!link->wr_tx_bufs)
 		goto no_mem;
-	link->wr_rx_bufs = kcalloc(SMC_WR_BUF_CNT * 3, link->wr_rx_buflen,
+	link->wr_rx_bufs = kcalloc(link->lgr->max_recv_wr, SMC_WR_BUF_SIZE,
 				   GFP_KERNEL);
 	if (!link->wr_rx_bufs)
 		goto no_mem_wr_tx_bufs;
-	link->wr_tx_ibs = kcalloc(SMC_WR_BUF_CNT, sizeof(link->wr_tx_ibs[0]),
-				  GFP_KERNEL);
+	link->wr_tx_ibs = kcalloc(link->lgr->max_send_wr,
+				  sizeof(link->wr_tx_ibs[0]), GFP_KERNEL);
 	if (!link->wr_tx_ibs)
 		goto no_mem_wr_rx_bufs;
-	link->wr_rx_ibs = kcalloc(SMC_WR_BUF_CNT * 3,
+	link->wr_rx_ibs = kcalloc(link->lgr->max_recv_wr,
 				  sizeof(link->wr_rx_ibs[0]),
 				  GFP_KERNEL);
 	if (!link->wr_rx_ibs)
 		goto no_mem_wr_tx_ibs;
-	link->wr_tx_rdmas = kcalloc(SMC_WR_BUF_CNT,
+	link->wr_tx_rdmas = kcalloc(link->lgr->max_send_wr,
 				    sizeof(link->wr_tx_rdmas[0]),
 				    GFP_KERNEL);
 	if (!link->wr_tx_rdmas)
 		goto no_mem_wr_rx_ibs;
-	link->wr_tx_rdma_sges = kcalloc(SMC_WR_BUF_CNT,
+	link->wr_tx_rdma_sges = kcalloc(link->lgr->max_send_wr,
 					sizeof(link->wr_tx_rdma_sges[0]),
 					GFP_KERNEL);
 	if (!link->wr_tx_rdma_sges)
 		goto no_mem_wr_tx_rdmas;
-	link->wr_tx_sges = kcalloc(SMC_WR_BUF_CNT, sizeof(link->wr_tx_sges[0]),
+	link->wr_tx_sges = kcalloc(link->lgr->max_send_wr, sizeof(link->wr_tx_sges[0]),
 				   GFP_KERNEL);
 	if (!link->wr_tx_sges)
 		goto no_mem_wr_tx_rdma_sges;
-	link->wr_rx_sges = kcalloc(SMC_WR_BUF_CNT * 3,
+	link->wr_rx_sges = kcalloc(link->lgr->max_recv_wr,
 				   sizeof(link->wr_rx_sges[0]) * link->wr_rx_sge_cnt,
 				   GFP_KERNEL);
 	if (!link->wr_rx_sges)
 		goto no_mem_wr_tx_sges;
-	link->wr_tx_mask = bitmap_zalloc(SMC_WR_BUF_CNT, GFP_KERNEL);
+	link->wr_tx_mask = bitmap_zalloc(link->lgr->max_send_wr, GFP_KERNEL);
 	if (!link->wr_tx_mask)
 		goto no_mem_wr_rx_sges;
-	link->wr_tx_pends = kcalloc(SMC_WR_BUF_CNT,
+	link->wr_tx_pends = kcalloc(link->lgr->max_send_wr,
 				    sizeof(link->wr_tx_pends[0]),
 				    GFP_KERNEL);
 	if (!link->wr_tx_pends)
 		goto no_mem_wr_tx_mask;
-	link->wr_tx_compl = kcalloc(SMC_WR_BUF_CNT,
+	link->wr_tx_compl = kcalloc(link->lgr->max_send_wr,
 				    sizeof(link->wr_tx_compl[0]),
 				    GFP_KERNEL);
 	if (!link->wr_tx_compl)
@@ -905,7 +907,7 @@ int smc_wr_create_link(struct smc_link *lnk)
 		goto dma_unmap;
 	}
 	smc_wr_init_sge(lnk);
-	bitmap_zero(lnk->wr_tx_mask, SMC_WR_BUF_CNT);
+	bitmap_zero(lnk->wr_tx_mask, lnk->lgr->max_send_wr);
 	init_waitqueue_head(&lnk->wr_tx_wait);
 	rc = percpu_ref_init(&lnk->wr_tx_refs, smcr_wr_tx_refs_free, 0, GFP_KERNEL);
 	if (rc)
diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
index f3008dda222a..aa4533af9122 100644
--- a/net/smc/smc_wr.h
+++ b/net/smc/smc_wr.h
@@ -19,8 +19,6 @@
 #include "smc.h"
 #include "smc_core.h"
 
-#define SMC_WR_BUF_CNT 16	/* # of ctrl buffers per link */
-
 #define SMC_WR_TX_WAIT_FREE_SLOT_TIME	(10 * HZ)
 
 #define SMC_WR_TX_SIZE 44 /* actual size of wr_send data (<=SMC_WR_BUF_SIZE) */
-- 
2.48.1


