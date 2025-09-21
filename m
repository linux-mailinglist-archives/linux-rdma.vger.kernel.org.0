Return-Path: <linux-rdma+bounces-13539-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD68AB8E6E0
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 23:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19D93A712B
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 21:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF702D660B;
	Sun, 21 Sep 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NNPy8AqA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E91BD01D;
	Sun, 21 Sep 2025 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491105; cv=none; b=n66Nt1dNbUEUGj4+Qip/ry4usWO4gAn8jGpSrnXhey3nLmBSNs8YCddBxJP5Gf8kUVAPaOMFbvZB5znzM3yszkjyEIiBhVCTrpkqBrw116N3o81IkMLUsYjq88dCcFCRMM8p0LykvgKIn33DMRxhI6NWofrbEy6GJ+2DbnnqNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491105; c=relaxed/simple;
	bh=bStTx+PS+bydWMK0XCCAFQcJr+IduyrBa2Bcq1EXTUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVuT9ZFMv9+9OD6IOjL9mowr3lXTzxMJXa8gDBTvB5i9F7UOrGEU4Sjqbj2E5TvyRgI1uOlnNH7V2I/VFFvdKJ8HOh1L/ft5khSro/euJYO9FJ+CigVYJgBtG5q6k3Y5ovpO63D6KUN6p2tKnr3RV03ZwshmknKSEZdMvsi/Meg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NNPy8AqA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LLUKe6015979;
	Sun, 21 Sep 2025 21:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XSiMtslDnuPKduMMT
	QmJwunn7OqI9AsFDs1tIG5wrJ0=; b=NNPy8AqA98Tr4pLQOgb6xUZiV7QP8Hw2Q
	7GEvmD+Oz3GcoQop5k9dh5Hut+yozzb1CXQBB8kdMAmzFDcMz3YegpohmUOAnOHa
	t3TRXvllXL8lL0AG4K0CV5riUmxN1798y9mVHCPO3Wmz8Tj4368YeKpwzxl0Y58j
	GDDn6pycgBbLxxq6DY1o0s8Av2KQqy5EZGO4txep0ZZfoNPJSKAQBkVq4N+3dUlb
	uO7AlN5ZRBTug+FLeEVkovf9GTpBPhvGiBET1NmlRJlttf2l2rGmLert24cxSKdr
	dXohQxwsGbtjkEDjo8TYjq4855EeTzOPB3RGT+cd5kQzNNhLY1oWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky5q4qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 21:44:52 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58LLiqt6009352;
	Sun, 21 Sep 2025 21:44:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky5q4qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 21:44:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58LHOt6T008311;
	Sun, 21 Sep 2025 21:44:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yxkaux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 21:44:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LLikv228705188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 21:44:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1A4B20043;
	Sun, 21 Sep 2025 21:44:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE0E20040;
	Sun, 21 Sep 2025 21:44:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 21:44:46 +0000 (GMT)
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
Subject: [PATCH net-next v3 1/2] net/smc: make wr buffer count configurable
Date: Sun, 21 Sep 2025 23:44:39 +0200
Message-ID: <20250921214440.325325-2-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250921214440.325325-1-pasic@linux.ibm.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h_H9pruIBawp2CKIwbP0k4HQ1WU6AODo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX/3OypmLm5KMw
 wS1PlywVBjoM26MMYOBwy59zUDwktFFLyBr9hpGCpbBf8byX7L5zTBFntbmsu+ZKjDbu9P9oOvv
 KhvuWYmh2kt/CK7aRYF8M8U555mvDYzQ0x+cRxBkjqX+DZKITNu/4v0DDye6Zlv9yu+WcRb5Xsj
 qNkkd+RtcXL8rbNlveXojdd4LYxWJslD8alnR/nNn2sWJMDcLh4YDG2df7L1S6TGJegpGrGdl0t
 Aqg0FHZxvTZ7p5s35lpfFLmy8WtM/9jvqjqKdulGQ+iFyNQJlTzyXk2dWG+E7M07eYLPlTaSSwD
 UVlta4hGiDp8s/JhcFCRotVEzB4Qv/0VSyj/8s9EoOmO0EZVILSxpoQ7F5VJPLMAWW9PSTObNz2
 ep4csnmC
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d071d4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=a6OFRn_g8X_OcWKUc2YA:9
X-Proofpoint-GUID: n-L3avVN_tEcZoF216J6RPBQK6iuoO_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_08,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
get replaced with lgr->max_send_wr and lgr->max_recv_wr respective.

While at it let us also remove a confusing comment that is either not
about the context in which it resides (describing
qp_attr.cap.max_send_wr and qp_attr.cap.max_recv_wr) or not applicable
any more when these values become configurable.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 Documentation/networking/smc-sysctl.rst | 36 +++++++++++++++++++++++++
 include/net/netns/smc.h                 |  2 ++
 net/smc/smc_core.h                      |  6 +++++
 net/smc/smc_ib.c                        |  7 ++---
 net/smc/smc_llc.c                       |  2 ++
 net/smc/smc_sysctl.c                    | 22 +++++++++++++++
 net/smc/smc_sysctl.h                    |  2 ++
 net/smc/smc_wr.c                        | 32 +++++++++++-----------
 net/smc/smc_wr.h                        |  2 --
 9 files changed, 89 insertions(+), 22 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index a874d007f2db..c94d750c7c84 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -71,3 +71,39 @@ smcr_max_conns_per_lgr - INTEGER
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
diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
index fc752a50f91b..6ceb12baec24 100644
--- a/include/net/netns/smc.h
+++ b/include/net/netns/smc.h
@@ -24,5 +24,7 @@ struct netns_smc {
 	int				sysctl_rmem;
 	int				sysctl_max_links_per_lgr;
 	int				sysctl_max_conns_per_lgr;
+	unsigned int			sysctl_smcr_max_send_wr;
+	unsigned int			sysctl_smcr_max_recv_wr;
 };
 #endif
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 48a1b1dcb576..ab2d15929cb2 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -33,6 +33,8 @@
 					 * distributions may modify it to a value between
 					 * 16-255 as needed.
 					 */
+#define SMCR_MAX_SEND_WR_DEF	16	/* Default number of work requests per send queue */
+#define SMCR_MAX_RECV_WR_DEF	48	/* Default number of work requests per recv queue */
 
 struct smc_lgr_list {			/* list of link group definition */
 	struct list_head	list;
@@ -361,6 +363,10 @@ struct smc_link_group {
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
index f865c58c3aa7..f5d5eb617526 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -2157,6 +2157,8 @@ void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc)
 	init_waitqueue_head(&lgr->llc_msg_waiter);
 	init_rwsem(&lgr->llc_conf_mutex);
 	lgr->llc_testlink_time = READ_ONCE(net->smc.sysctl_smcr_testlink_time);
+	lgr->max_send_wr = (u16)(READ_ONCE(net->smc.sysctl_smcr_max_send_wr));
+	lgr->max_recv_wr = (u16)(READ_ONCE(net->smc.sysctl_smcr_max_recv_wr));
 }
 
 /* called after lgr was removed from lgr_list */
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 2fab6456f765..7b2471904d04 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -29,6 +29,8 @@ static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
 static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
 static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
 static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
+static unsigned int smcr_max_wr_min = 2;
+static unsigned int smcr_max_wr_max = 2048;
 
 static struct ctl_table smc_table[] = {
 	{
@@ -99,6 +101,24 @@ static struct ctl_table smc_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "smcr_max_send_wr",
+		.data		= &init_net.smc.sysctl_smcr_max_send_wr,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &smcr_max_wr_min,
+		.extra2		= &smcr_max_wr_max,
+	},
+	{
+		.procname	= "smcr_max_recv_wr",
+		.data		= &init_net.smc.sysctl_smcr_max_recv_wr,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &smcr_max_wr_min,
+		.extra2		= &smcr_max_wr_max,
+	},
 };
 
 int __net_init smc_sysctl_net_init(struct net *net)
@@ -130,6 +150,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
 	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
 	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
 	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
+	net->smc.sysctl_smcr_max_send_wr = SMCR_MAX_SEND_WR_DEF;
+	net->smc.sysctl_smcr_max_recv_wr = SMCR_MAX_RECV_WR_DEF;
 	/* disable handshake limitation by default */
 	net->smc.limit_smc_hs = 0;
 
diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
index eb2465ae1e15..8538915af7af 100644
--- a/net/smc/smc_sysctl.h
+++ b/net/smc/smc_sysctl.h
@@ -25,6 +25,8 @@ static inline int smc_sysctl_net_init(struct net *net)
 	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
 	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
 	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
+	net->smc.sysctl_smcr_max_send_wr = SMCR_MAX_SEND_WR_DEF;
+	net->smc.sysctl_smcr_max_recv_wr = SMCR_MAX_RECV_WR_DEF;
 	return 0;
 }
 
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index b04a21b8c511..f5b2772414fd 100644
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
+	link->wr_rx_bufs = kcalloc(link->lgr->max_recv_wr, link->wr_rx_buflen,
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


