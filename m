Return-Path: <linux-rdma+bounces-13630-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51426B9B0D0
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 19:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378FD19C55CA
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80DC314A73;
	Wed, 24 Sep 2025 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q01U2ock"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B742E54B3;
	Wed, 24 Sep 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734871; cv=none; b=i6140WfIkaIxvaA47KuSRkO2syDF0KShIUkFx2HX8nHujV1Ov2Nrqu6XrJFdMOsztt4FHAvB+QXuo6vdiRWI+dY/wYKUiFYShSYftpCxZ0hLMvkvmJZ47SbT9o45ECs47IJpqAAWQox3O2zKHlKaCxBhyuI/docmLnv1tCxk4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734871; c=relaxed/simple;
	bh=zFVL4llrc8nrT1FWIX5eY+OEXp+L+LBuP2KLt5nIa3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tTZFaqOr5vMhlTXDtBTYDobrlm8gDPQ0I85gzJSftBrh/gsmf3oLa8vrJdI9gl0O1byn098BOlWh4YRi8fSZKQuXH60S86nxpZSoeBNQqgXA70mFhhJ35e9CatK3VimjlHO4XhKdTfQVaMJkJNr6OtUBtjcNIJih3zfFCz3aXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q01U2ock; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODn2em030848;
	Wed, 24 Sep 2025 17:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t14QWy
	YSzjUQmtsbOHzWrSs4U99igN5AoQJ4gMDmPIY=; b=q01U2ock19/rqwhsjwMPHP
	uj/3JQ3Wk5qX+qYVROJi7vbPoC54aceokDL4FPt6lP9fY2xy7tORXrkzJE4TpzXw
	6PkNC0VQTc2jy8y1CC33wABarz6MtsoMuJpaAF1iSj7U0BZg1YAxsfCBUgvwWKBp
	DIZoVbY2o6LJHy4O7Ky9l7rf/1V7RETv3uL/EMovgUOFN4NGr4OUJrq/1IPeeKSQ
	TEV0pYvxihNgjLw/O+CF9nvdS4EKyeUwDPhekdVDfCcgw+4wxu461eTsp6tzF6E1
	LQaiD4j+6KGIvJ3HvPS4bBUGyK5qz7oW+MoKe/eYVBb+TQAk0wrrGXFxiiHnmkxg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyr7kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:27:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OHNBN5027610;
	Wed, 24 Sep 2025 17:27:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyr7kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:27:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OGK7Tj008826;
	Wed, 24 Sep 2025 17:27:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yy1x7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:27:42 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OHRfof24445480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 17:27:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C2A258056;
	Wed, 24 Sep 2025 17:27:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B00B58052;
	Wed, 24 Sep 2025 17:27:36 +0000 (GMT)
Received: from [9.124.221.141] (unknown [9.124.221.141])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 17:27:35 +0000 (GMT)
Message-ID: <0a2676f1-05a2-48f6-9477-d810443e4dde@linux.ibm.com>
Date: Wed, 24 Sep 2025 22:57:34 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/smc: make wr buffer count
 configurable
To: Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi
 <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-2-pasic@linux.ibm.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20250921214440.325325-2-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d42a0f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=eraeOUu6IO43jDh9kt4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BjjLohX9gvp4C5dnxtCos2hAMsIbFDkz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX6qA0M1I9RgWI
 DQgamg3b0PnU23sd/31PIdZ3S/heisarrE8hltQ4MR0R5F53zsw7RCZG4e8JmArDkyWE9Wav8BX
 FskzeMYhJNJ+R0LHi69W4WqB4l0vyT79b6CtkzJAS4/SVC5fuXTwcbeiwz9GbwA0wMBxMGEzILz
 IjL6MDv5jb8zVGZdXXSv9fW8UY9B7Trlq3ST15h6u6FaqpV/7EuqH/EdTGyJji2O/tgRonwchyt
 wrBakCWDLYr/IoHSi3FUM4+W7v9IqYB64asEKCFcTieuYxwkthni5P44tRBtz0LFiEWrARXWDfO
 E4V+V6x3PusV+AqkLok4O/oUWxvBidAio/vkmHZAjM+cU5sQ1vQ0x0EOiJqOFGb2i0y+yhDmBcx
 dS88Rcy1
X-Proofpoint-ORIG-GUID: L4JRBudGPFnR51nJDRn-xzvacVJ6jKm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015



On 22/09/25 3:14 am, Halil Pasic wrote:
> Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
> SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
> get replaced with lgr->max_send_wr and lgr->max_recv_wr respective.
> 
> While at it let us also remove a confusing comment that is either not
> about the context in which it resides (describing
> qp_attr.cap.max_send_wr and qp_attr.cap.max_recv_wr) or not applicable
> any more when these values become configurable.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  Documentation/networking/smc-sysctl.rst | 36 +++++++++++++++++++++++++
>  include/net/netns/smc.h                 |  2 ++
>  net/smc/smc_core.h                      |  6 +++++
>  net/smc/smc_ib.c                        |  7 ++---
>  net/smc/smc_llc.c                       |  2 ++
>  net/smc/smc_sysctl.c                    | 22 +++++++++++++++
>  net/smc/smc_sysctl.h                    |  2 ++
>  net/smc/smc_wr.c                        | 32 +++++++++++-----------
>  net/smc/smc_wr.h                        |  2 --
>  9 files changed, 89 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
> index a874d007f2db..c94d750c7c84 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -71,3 +71,39 @@ smcr_max_conns_per_lgr - INTEGER
>  	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
>  
>  	Default: 255
> +
> +smcr_max_send_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the send path used to be hard coded to 16. With this control
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physically
> +	continuous array in which each element is a single buffer and has the size
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 16
> +
> +smcr_max_recv_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the receive path used to be hard coded to 16. With this control
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physically
> +	continuous array in which each element is a single buffer and has the size
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 48

Tuning default WR BUF count and max_conns per lgr together makes sense,
otherwise either memory is wasted or WRs queue up on a QP.
That exercise, however, can be done separately from this patchset.

> diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
> index fc752a50f91b..6ceb12baec24 100644
> --- a/include/net/netns/smc.h
> +++ b/include/net/netns/smc.h
> @@ -24,5 +24,7 @@ struct netns_smc {
>  	int				sysctl_rmem;
>  	int				sysctl_max_links_per_lgr;
>  	int				sysctl_max_conns_per_lgr;
> +	unsigned int			sysctl_smcr_max_send_wr;
> +	unsigned int			sysctl_smcr_max_recv_wr;
>  };
>  #endif
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 48a1b1dcb576..ab2d15929cb2 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -33,6 +33,8 @@
>  					 * distributions may modify it to a value between
>  					 * 16-255 as needed.
>  					 */
> +#define SMCR_MAX_SEND_WR_DEF	16	/* Default number of work requests per send queue */
> +#define SMCR_MAX_RECV_WR_DEF	48	/* Default number of work requests per recv queue */
>  
>  struct smc_lgr_list {			/* list of link group definition */
>  	struct list_head	list;
> @@ -361,6 +363,10 @@ struct smc_link_group {
>  						/* max conn can be assigned to lgr */
>  			u8			max_links;
>  						/* max links can be added in lgr */
> +			u16			max_send_wr;
> +						/* number of WR buffers on send */
> +			u16			max_recv_wr;
> +						/* number of WR buffers on recv */
>  		};
>  		struct { /* SMC-D */
>  			struct smcd_gid		peer_gid;
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 0052f02756eb..e8d35c22c525 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -669,11 +669,6 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
>  		.recv_cq = lnk->smcibdev->roce_cq_recv,
>  		.srq = NULL,
>  		.cap = {
> -				/* include unsolicited rdma_writes as well,
> -				 * there are max. 2 RDMA_WRITE per 1 WR_SEND
> -				 */
> -			.max_send_wr = SMC_WR_BUF_CNT * 3,
> -			.max_recv_wr = SMC_WR_BUF_CNT * 3,
>  			.max_send_sge = SMC_IB_MAX_SEND_SGE,
>  			.max_recv_sge = lnk->wr_rx_sge_cnt,
>  			.max_inline_data = 0,
> @@ -683,6 +678,8 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
>  	};
>  	int rc;
>  
> +	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
> +	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;
>  	lnk->roce_qp = ib_create_qp(lnk->roce_pd, &qp_attr);
>  	rc = PTR_ERR_OR_ZERO(lnk->roce_qp);
>  	if (IS_ERR(lnk->roce_qp))
> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index f865c58c3aa7..f5d5eb617526 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -2157,6 +2157,8 @@ void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc)
>  	init_waitqueue_head(&lgr->llc_msg_waiter);
>  	init_rwsem(&lgr->llc_conf_mutex);
>  	lgr->llc_testlink_time = READ_ONCE(net->smc.sysctl_smcr_testlink_time);
> +	lgr->max_send_wr = (u16)(READ_ONCE(net->smc.sysctl_smcr_max_send_wr));
> +	lgr->max_recv_wr = (u16)(READ_ONCE(net->smc.sysctl_smcr_max_recv_wr));
>  }
>  
>  /* called after lgr was removed from lgr_list */
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index 2fab6456f765..7b2471904d04 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -29,6 +29,8 @@ static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
>  static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
>  static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
>  static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
> +static unsigned int smcr_max_wr_min = 2;
> +static unsigned int smcr_max_wr_max = 2048;
>  
>  static struct ctl_table smc_table[] = {
>  	{
> @@ -99,6 +101,24 @@ static struct ctl_table smc_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "smcr_max_send_wr",
> +		.data		= &init_net.smc.sysctl_smcr_max_send_wr,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &smcr_max_wr_min,
> +		.extra2		= &smcr_max_wr_max,
> +	},
> +	{
> +		.procname	= "smcr_max_recv_wr",
> +		.data		= &init_net.smc.sysctl_smcr_max_recv_wr,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &smcr_max_wr_min,
> +		.extra2		= &smcr_max_wr_max,
> +	},
>  };
>  
>  int __net_init smc_sysctl_net_init(struct net *net)
> @@ -130,6 +150,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
>  	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>  	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>  	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
> +	net->smc.sysctl_smcr_max_send_wr = SMCR_MAX_SEND_WR_DEF;
> +	net->smc.sysctl_smcr_max_recv_wr = SMCR_MAX_RECV_WR_DEF;
>  	/* disable handshake limitation by default */
>  	net->smc.limit_smc_hs = 0;
>  
> diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
> index eb2465ae1e15..8538915af7af 100644
> --- a/net/smc/smc_sysctl.h
> +++ b/net/smc/smc_sysctl.h
> @@ -25,6 +25,8 @@ static inline int smc_sysctl_net_init(struct net *net)
>  	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>  	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>  	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
> +	net->smc.sysctl_smcr_max_send_wr = SMCR_MAX_SEND_WR_DEF;
> +	net->smc.sysctl_smcr_max_recv_wr = SMCR_MAX_RECV_WR_DEF;
>  	return 0;
>  }
>  
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index b04a21b8c511..f5b2772414fd 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -34,6 +34,7 @@
>  #define SMC_WR_MAX_POLL_CQE 10	/* max. # of compl. queue elements in 1 poll */
>  
>  #define SMC_WR_RX_HASH_BITS 4
> +
>  static DEFINE_HASHTABLE(smc_wr_rx_hash, SMC_WR_RX_HASH_BITS);
>  static DEFINE_SPINLOCK(smc_wr_rx_hash_lock);
>  
> @@ -547,9 +548,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
>  		    IB_QP_DEST_QPN,
>  		    &init_attr);
>  
> -	lnk->wr_tx_cnt = min_t(size_t, SMC_WR_BUF_CNT,
> +	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->max_send_wr,
>  			       lnk->qp_attr.cap.max_send_wr);
> -	lnk->wr_rx_cnt = min_t(size_t, SMC_WR_BUF_CNT * 3,
> +	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->max_recv_wr,
>  			       lnk->qp_attr.cap.max_recv_wr);
>  }
>  
> @@ -741,50 +742,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
>  int smc_wr_alloc_link_mem(struct smc_link *link)
>  {
>  	/* allocate link related memory */
> -	link->wr_tx_bufs = kcalloc(SMC_WR_BUF_CNT, SMC_WR_BUF_SIZE, GFP_KERNEL);
> +	link->wr_tx_bufs = kcalloc(link->lgr->max_send_wr,
> +				   SMC_WR_BUF_SIZE, GFP_KERNEL);
>  	if (!link->wr_tx_bufs)
>  		goto no_mem;
> -	link->wr_rx_bufs = kcalloc(SMC_WR_BUF_CNT * 3, link->wr_rx_buflen,
> +	link->wr_rx_bufs = kcalloc(link->lgr->max_recv_wr, link->wr_rx_buflen,
>  				   GFP_KERNEL);
>  	if (!link->wr_rx_bufs)
>  		goto no_mem_wr_tx_bufs;
> -	link->wr_tx_ibs = kcalloc(SMC_WR_BUF_CNT, sizeof(link->wr_tx_ibs[0]),
> -				  GFP_KERNEL);
> +	link->wr_tx_ibs = kcalloc(link->lgr->max_send_wr,
> +				  sizeof(link->wr_tx_ibs[0]), GFP_KERNEL);
>  	if (!link->wr_tx_ibs)
>  		goto no_mem_wr_rx_bufs;
> -	link->wr_rx_ibs = kcalloc(SMC_WR_BUF_CNT * 3,
> +	link->wr_rx_ibs = kcalloc(link->lgr->max_recv_wr,
>  				  sizeof(link->wr_rx_ibs[0]),
>  				  GFP_KERNEL);
>  	if (!link->wr_rx_ibs)
>  		goto no_mem_wr_tx_ibs;
> -	link->wr_tx_rdmas = kcalloc(SMC_WR_BUF_CNT,
> +	link->wr_tx_rdmas = kcalloc(link->lgr->max_send_wr,
>  				    sizeof(link->wr_tx_rdmas[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_rdmas)
>  		goto no_mem_wr_rx_ibs;
> -	link->wr_tx_rdma_sges = kcalloc(SMC_WR_BUF_CNT,
> +	link->wr_tx_rdma_sges = kcalloc(link->lgr->max_send_wr,
>  					sizeof(link->wr_tx_rdma_sges[0]),
>  					GFP_KERNEL);
>  	if (!link->wr_tx_rdma_sges)
>  		goto no_mem_wr_tx_rdmas;
> -	link->wr_tx_sges = kcalloc(SMC_WR_BUF_CNT, sizeof(link->wr_tx_sges[0]),
> +	link->wr_tx_sges = kcalloc(link->lgr->max_send_wr, sizeof(link->wr_tx_sges[0]),
>  				   GFP_KERNEL);
>  	if (!link->wr_tx_sges)
>  		goto no_mem_wr_tx_rdma_sges;
> -	link->wr_rx_sges = kcalloc(SMC_WR_BUF_CNT * 3,
> +	link->wr_rx_sges = kcalloc(link->lgr->max_recv_wr,
>  				   sizeof(link->wr_rx_sges[0]) * link->wr_rx_sge_cnt,
>  				   GFP_KERNEL);
>  	if (!link->wr_rx_sges)
>  		goto no_mem_wr_tx_sges;
> -	link->wr_tx_mask = bitmap_zalloc(SMC_WR_BUF_CNT, GFP_KERNEL);
> +	link->wr_tx_mask = bitmap_zalloc(link->lgr->max_send_wr, GFP_KERNEL);
>  	if (!link->wr_tx_mask)
>  		goto no_mem_wr_rx_sges;
> -	link->wr_tx_pends = kcalloc(SMC_WR_BUF_CNT,
> +	link->wr_tx_pends = kcalloc(link->lgr->max_send_wr,
>  				    sizeof(link->wr_tx_pends[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_pends)
>  		goto no_mem_wr_tx_mask;
> -	link->wr_tx_compl = kcalloc(SMC_WR_BUF_CNT,
> +	link->wr_tx_compl = kcalloc(link->lgr->max_send_wr,
>  				    sizeof(link->wr_tx_compl[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_compl)
> @@ -905,7 +907,7 @@ int smc_wr_create_link(struct smc_link *lnk)
>  		goto dma_unmap;
>  	}
>  	smc_wr_init_sge(lnk);
> -	bitmap_zero(lnk->wr_tx_mask, SMC_WR_BUF_CNT);
> +	bitmap_zero(lnk->wr_tx_mask, lnk->lgr->max_send_wr);
>  	init_waitqueue_head(&lnk->wr_tx_wait);
>  	rc = percpu_ref_init(&lnk->wr_tx_refs, smcr_wr_tx_refs_free, 0, GFP_KERNEL);
>  	if (rc)
> diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
> index f3008dda222a..aa4533af9122 100644
> --- a/net/smc/smc_wr.h
> +++ b/net/smc/smc_wr.h
> @@ -19,8 +19,6 @@
>  #include "smc.h"
>  #include "smc_core.h"
>  
> -#define SMC_WR_BUF_CNT 16	/* # of ctrl buffers per link */
> -
>  #define SMC_WR_TX_WAIT_FREE_SLOT_TIME	(10 * HZ)
>  
>  #define SMC_WR_TX_SIZE 44 /* actual size of wr_send data (<=SMC_WR_BUF_SIZE) */

Code changes looks good to me.
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>


