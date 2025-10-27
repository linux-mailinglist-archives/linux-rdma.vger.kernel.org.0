Return-Path: <linux-rdma+bounces-14079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A3C11E93
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 23:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78E1580FB6
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179F2E7BAA;
	Mon, 27 Oct 2025 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M80LYF85"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8126A0AD;
	Mon, 27 Oct 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605355; cv=none; b=hkkzEu/Snv9vri3rfIiTIkrbYEuNyShCgcrgukEqpaIlEk61BMMRoA3Vc+HzlQ9PsL5b6kPeijCl+peutwW9gXJIKD9r50JM1QZyWUE+Jq+DHY2wwBW92C5VaFclQ0HK1ctXiZ7kPZpd/z2Y23HNutPhxPEE0lHNSyuqdfIYBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605355; c=relaxed/simple;
	bh=3vY8ghq/Ja5QnoG98iX2P5vjyQITlGFGrgyHRSU318s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/cGRU/Fw/OjOjPQOUvy1nEkKfbnylCypqxxbfV0c8vUFl/ziAsFDPM732b7GxHimU5YtL56Zn9iDfMVEJD1fmelb43ExDfaR22qpAED+108ImHZfGQcyjhmM0DMysbvx2zzF5Mi/4XTfqtqnFWRGn1oE9WC5+oNpYFFfdjwLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M80LYF85; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RBnCA4023535;
	Mon, 27 Oct 2025 22:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=faMxPjxST9CP1d5hz
	3PAMImoNygi7R43hazQAU8cC8Y=; b=M80LYF85BrC9Q8iu1rpWlljuy1ehizR1L
	v73l8kEsR16zptImTOj3pn+SGH0w5es9jeWl8VZOUW8XHD6ffwYtgZv+tsERPwRh
	LQ81Eawzlia579RxAWax4Nhy2GzUj/r2PUqrYq3sEJnMUYd23/sKTuFDv6oF4B1z
	kdO0+DzCqyIqAnYDAI5B9fzCph+1W5lqjU4sx++nO1RLfhkaPc+iRXPABXb9wMxs
	w4prJR2jrDA4KamRVghhvZGoSxXwV5U+rw5eleEZNyh1C4DzEwX41l5zcwDpwPuJ
	1CEMw74JEcypZMkT5JQ1uRW5cy3hRrtaiXhMkDnPhI9IelpqyDdbQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p720ymt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 22:49:06 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59RMar0R002886;
	Mon, 27 Oct 2025 22:49:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p720ymq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 22:49:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RMgMPE030191;
	Mon, 27 Oct 2025 22:49:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a19vmfxx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 22:49:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RMn0Ag57016824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 22:49:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8EB820043;
	Mon, 27 Oct 2025 22:49:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F56220040;
	Mon, 27 Oct 2025 22:49:00 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 22:49:00 +0000 (GMT)
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
Subject: [PATCH net-next v6 1/2] net/smc: make wr buffer count configurable
Date: Mon, 27 Oct 2025 23:48:55 +0100
Message-ID: <20251027224856.2970019-2-pasic@linux.ibm.com>
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
X-Proofpoint-GUID: 4ejc2jfyyqTFRBwCScyjyEEYZC9dXg4S
X-Proofpoint-ORIG-GUID: w49MxPa2is0NXcXrc5NfoLaKoERfwFz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfXzdJvQnaHX4aW
 WDICLcXKUaPaH5IcZnEX9dYTqKc5RMvhBYy/rF6iTgjNRd04FKChp66WPX+rRep3DDbIhVr4f0T
 IoBu3vm/o6YIM6oze28bgNBdM6rXYx0Hqs371Pj+vo3ALxqkZ3PimAOTOZl8RS3UpigHsiwqtqs
 F0MlbDkuV8VfSeJqk92TGmKftm5wiWQCiRiIBOmE76qnCI73/yTXqw3lw38XMfSXvfiJXBX9/m6
 OBiD4mQizF4EmwIYO8CF8bJzNkj+8mZ/epTPk2MCalY9ehHDKxC+nmw6tsCEZtmpT3nrf30h+ic
 Czbsr9lD5Pp2TNN1XHzlWt74vX7FkjZUf+0KrtmaHVMfCm5zsBUjmSe0FRnzAytoSikFgc3wX64
 ikjw73iZSNS73HaprIXhMh588E4gyQ==
X-Authority-Analysis: v=2.4 cv=G/gR0tk5 c=1 sm=1 tr=0 ts=68fff6e2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8
 a=a6OFRn_g8X_OcWKUc2YA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
get replaced with lgr->max_send_wr and lgr->max_recv_wr respective.

Please note that although with the default sysctl values
qp_attr.cap.max_send_wr ==  qp_attr.cap.max_recv_wr is maintained but
can not be assumed to be generally true any more. I see no downside to
that, but my confidence level is rather modest.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
 Documentation/networking/smc-sysctl.rst | 36 +++++++++++++++++++++++++
 include/net/netns/smc.h                 |  2 ++
 net/smc/smc_core.h                      |  6 +++++
 net/smc/smc_ib.c                        | 10 +++----
 net/smc/smc_llc.c                       |  2 ++
 net/smc/smc_sysctl.c                    | 22 +++++++++++++++
 net/smc/smc_sysctl.h                    |  2 ++
 net/smc/smc_wr.c                        | 31 ++++++++++-----------
 net/smc/smc_wr.h                        |  2 --
 9 files changed, 91 insertions(+), 22 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index a874d007f2db..337ac2be167e 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -71,3 +71,39 @@ smcr_max_conns_per_lgr - INTEGER
 	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
 
 	Default: 255
+
+smcr_max_send_wr - INTEGER
+	So-called work request buffers are SMCR link (and RDMA queue pair) level
+	resources necessary for performing RDMA operations. Since up to 255
+	connections can share a link group and thus also a link and the number
+	of the work request buffers is decided when the link is allocated,
+	depending on the workload it can be a bottleneck in a sense that threads
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
+	So-called work request buffers are SMCR link (and RDMA queue pair) level
+	resources necessary for performing RDMA operations. Since up to 255
+	connections can share a link group and thus also a link and the number
+	of the work request buffers is decided when the link is allocated,
+	depending on the workload it can be a bottleneck in a sense that threads
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
index a5a78cbff341..8d06c8bb14e9 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -34,6 +34,8 @@
 					 * distributions may modify it to a value between
 					 * 16-255 as needed.
 					 */
+#define SMCR_MAX_SEND_WR_DEF	16	/* Default number of work requests per send queue */
+#define SMCR_MAX_RECV_WR_DEF	48	/* Default number of work requests per recv queue */
 
 struct smc_lgr_list {			/* list of link group definition */
 	struct list_head	list;
@@ -366,6 +368,10 @@ struct smc_link_group {
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
index 0052f02756eb..1154907c5c05 100644
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
@@ -683,6 +678,11 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
 	};
 	int rc;
 
+	/* include unsolicited rdma_writes as well,
+	 * there are max. 2 RDMA_WRITE per 1 WR_SEND
+	 */
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
index b04a21b8c511..883fb0f1ce43 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -547,9 +547,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
 		    IB_QP_DEST_QPN,
 		    &init_attr);
 
-	lnk->wr_tx_cnt = min_t(size_t, SMC_WR_BUF_CNT,
+	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->max_send_wr,
 			       lnk->qp_attr.cap.max_send_wr);
-	lnk->wr_rx_cnt = min_t(size_t, SMC_WR_BUF_CNT * 3,
+	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->max_recv_wr,
 			       lnk->qp_attr.cap.max_recv_wr);
 }
 
@@ -741,50 +741,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
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
@@ -905,7 +906,7 @@ int smc_wr_create_link(struct smc_link *lnk)
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


