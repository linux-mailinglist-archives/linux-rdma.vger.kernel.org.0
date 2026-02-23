Return-Path: <linux-rdma+bounces-17055-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAHIJ8dInGmODAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17055-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 13:32:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B81761F1
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 13:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4183030EA0
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728618C03E;
	Mon, 23 Feb 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l5a7SENS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B563EBF38;
	Mon, 23 Feb 2026 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849920; cv=none; b=EqEGa4qmsnwr1Bvc4OqBVhvEIegC2BRx/8TXj+5TQH/0PcVOcswswmTdsfrK3BVzUtGuhKQim1wFY0H3FlJoeY7FlPKDRCs5C/A2RMcQilw6ijeEVJdhcE8CA3ERlFF+QqzhJTFuYP4M7MjJaNBAeYPCI1sWicgIQDW8zOSgnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849920; c=relaxed/simple;
	bh=f5Toatjgql+iw8NvzNkifyXmv0Z/q8+dJD/yNpkBzLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6T02R98cERAajQSjdf7qleUMmWHS0dN+N3OYem2y4cgn2cRlpU5txEbD4Xo9f1JOTzUUj9cCbZ5AqgANr19vuGgrFxZLk9QbOj9J9B81tym5nLpbxel2y7SVuM2qGjvcaZ8SGaiBjpQe0a1hvTWl5+VxJHGYS6QMzUP5TXSlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l5a7SENS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N0dxrF2865358;
	Mon, 23 Feb 2026 12:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B9kt00
	I2y2I+aiMomMSERtgqbxZZa832KBdWqzOy108=; b=l5a7SENSbzdlXE/ZQsAEts
	HyN2eJZjTTnH3R7u1BiVdpYLUhaU+FFWskaRzKd/+CbC/JYrbhztkfFvroluEHEC
	D3nz5JifjAKtbJlHoMjRl9TG7YfTQ4+JCSwIJ7DypxnrWxUePFhTGvnsDsy9Q4Ml
	hEdteAmfiAmCyLHmyl/hlDCB7m0SJ9tPAwlgSFQNLQCB1kvzqgjfqRVIScESh6Bf
	YXUxuRE/Z81a3TBW8IqpvQnKmMWtmmtLs//O8wsQ9r9x23VNgTgF92HmTlqMcu1q
	GbA3UZdAPjLG0/dnqfEAJ4xciWrlKrq0VM/3K15G40tPY1pzrYQF035c+Z4ygsnA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqq230-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 12:31:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NAa0Uv030414;
	Mon, 23 Feb 2026 12:31:49 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhk4mfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 12:31:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NCVliv2229016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 12:31:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB7FC58065;
	Mon, 23 Feb 2026 12:31:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56D9558059;
	Mon, 23 Feb 2026 12:31:40 +0000 (GMT)
Received: from [9.39.25.143] (unknown [9.39.25.143])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Feb 2026 12:31:40 +0000 (GMT)
Message-ID: <c054ac11-d3b5-4918-9105-f682db9d3542@linux.ibm.com>
Date: Mon, 23 Feb 2026 18:01:38 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net/smc: transition to RDMA core CQ pooling
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dust Li
 <dust.li@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, oliver.yang@linux.alibaba.com,
        pasic@linux.ibm.com
References: <20260202094800.30373-1-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260202094800.30373-1-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: yHbYMqizorS7zSaNz3p5Tw3nflbrEVho
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwNCBTYWx0ZWRfX8AYXpH2SCHeD
 CEHsJjK4ea8vkgXIiaHNekKGRt4AqHzY2R1qVeDiTrbxlX/p/fusNRUc3XgxFkffWbGVMOkwYRq
 z3MsbflZ6VrIceTuOW8EE+ZtIGLg60qiZYeMTqQ7EcxIrzY4i/0GC6+iQm+lqQs1KgP3Pt+Vv6i
 02+QAO2QwjrKEI/Wzq8FIIm7Wya5nib7rFtrnu9cSfB6Wk/fkxMDqIqDafXlAMfcbBz8IicBQlm
 KYzPi+mDvQOuhU/nNmHNGspPAZR980Oj/sLZjxMhKLSYR13jYaDUndmyfnziwpR8LF6bnVrWo5F
 1pAp9MBGJs7UflcWKGCWNVYrYlE9nLdwXrpsNDhca7t3paGIcnLmOTLjFglZ5CiMmTG9c1yOyB+
 hS7DPRehPUxLoUS9lKNTdY+N8zPg6g9YmEGQ+f3K34XFD7Ckif764cBNXxVxkt9AKen4o3TytBG
 JtYEpml8m1gkB081Ikg==
X-Proofpoint-GUID: wtLsChfu6F9lQ03SrP1ZoexCG7plStKY
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699c48b7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=SRrdq9N9AAAA:8
 a=DBpE8uzNTN-84XK4-hoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-17055-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: F35B81761F1
X-Rspamd-Action: no action



On 02/02/26 3:18 pm, D. Wythe wrote:
> The current SMC-R implementation relies on global per-device CQs
> and manual polling within tasklets, which introduces severe
> scalability bottlenecks due to global lock contention and tasklet
> scheduling overhead, resulting in poor performance as concurrency
> increases.
> 
> Refactor the completion handling to utilize the ib_cqe API and
> standard RDMA core CQ pooling. This transition provides several key
> advantages:
> 
> 1. Multi-CQ: Shift from a single shared per-device CQ to multiple
> link-specific CQs via the CQ pool. This allows completion processing
> to be parallelized across multiple CPU cores, effectively eliminating
> the global CQ bottleneck.
> 
> 2. Leverage DIM: Utilizing the standard CQ pool with IB_POLL_SOFTIRQ
> enables Dynamic Interrupt Moderation from the RDMA core, optimizing
> interrupt frequency and reducing CPU load under high pressure.
> 
> 3. O(1) Context Retrieval: Replaces the expensive wr_id based lookup
> logic (e.g., smc_wr_tx_find_pending_index) with direct context retrieval
> using container_of() on the embedded ib_cqe.
> 
> 4. Code Simplification: This refactoring results in a reduction of
> ~150 lines of code. It removes redundant sequence tracking, complex lookup
> helpers, and manual CQ management, significantly improving maintainability.
> 
> Performance Test: redis-benchmark with max 32 connections per QP
> Data format: Requests Per Second (RPS), Percentage in brackets
> represents the gain/loss compared to TCP.
> 
> | Clients | TCP      | SMC (original)      | SMC (cq_pool)       |
> |---------|----------|---------------------|---------------------|
> | c = 1   | 24449    | 31172  (+27%)       | 34039  (+39%)       |
> | c = 2   | 46420    | 53216  (+14%)       | 64391  (+38%)       |
> | c = 16  | 159673   | 83668  (-48%)  <--  | 216947 (+36%)       |
> | c = 32  | 164956   | 97631  (-41%)  <--  | 249376 (+51%)       |
> | c = 64  | 166322   | 118192 (-29%)  <--  | 249488 (+50%)       |
> | c = 128 | 167700   | 121497 (-27%)  <--  | 249480 (+48%)       |
> | c = 256 | 175021   | 146109 (-16%)  <--  | 240384 (+37%)       |
> | c = 512 | 168987   | 101479 (-40%)  <--  | 226634 (+34%)       |
> 
> The results demonstrate that this optimization effectively resolves the
> scalability bottleneck, with RPS increasing by over 110% at c=64
> compared to the original implementation.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  net/smc/smc_core.c |   8 +-
>  net/smc/smc_core.h |  16 ++-
>  net/smc/smc_ib.c   | 114 ++++++-------------
>  net/smc/smc_ib.h   |   5 -
>  net/smc/smc_tx.c   |   1 -
>  net/smc/smc_wr.c   | 267 ++++++++++++++++-----------------------------
>  net/smc/smc_wr.h   |  38 ++-----
>  7 files changed, 150 insertions(+), 299 deletions(-)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 8aca5dc54be7..9590c8aed3dd 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -815,17 +815,11 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>  	lnk->lgr = lgr;
>  	smc_lgr_hold(lgr); /* lgr_put in smcr_link_clear() */
>  	lnk->link_idx = link_idx;
> -	lnk->wr_rx_id_compl = 0;
>  	smc_ibdev_cnt_inc(lnk);
>  	smcr_copy_dev_info_to_link(lnk);
>  	atomic_set(&lnk->conn_cnt, 0);
>  	smc_llc_link_set_uid(lnk);
>  	INIT_WORK(&lnk->link_down_wrk, smc_link_down_work);
> -	if (!lnk->smcibdev->initialized) {
> -		rc = (int)smc_ib_setup_per_ibdev(lnk->smcibdev);
> -		if (rc)
> -			goto out;
> -	}
>  	get_random_bytes(rndvec, sizeof(rndvec));
>  	lnk->psn_initial = rndvec[0] + (rndvec[1] << 8) +
>  		(rndvec[2] << 16);
> @@ -1373,7 +1367,7 @@ void smcr_link_clear(struct smc_link *lnk, bool log)
>  	smc_llc_link_clear(lnk, log);
>  	smcr_buf_unmap_lgr(lnk);
>  	smcr_rtoken_clear_link(lnk);
> -	smc_ib_modify_qp_error(lnk);
> +	smc_wr_drain_qp(lnk);
>  	smc_wr_free_link(lnk);
>  	smc_ib_destroy_queue_pair(lnk);
>  	smc_ib_dealloc_protection_domain(lnk);
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 5c18f08a4c8a..00468b7a279f 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -92,6 +92,12 @@ struct smc_rdma_wr {				/* work requests per message
>  	struct ib_rdma_wr	wr_tx_rdma[SMC_MAX_RDMA_WRITES];
>  };
>  
> +struct smc_ib_recv_wr {
> +	struct ib_cqe		cqe;
> +	struct ib_recv_wr	wr;
> +	int index;
> +};
> +

This new struct is used for recv only. May I know if we need to have the
same for send(struct smc_ib_send_wr)? e.g struct smc_ib_send_wr
*wr_tx_ibs member in struct smc_link?

>  #define SMC_LGR_ID_SIZE		4
>  
>  struct smc_link {
> @@ -100,6 +106,8 @@ struct smc_link {
>  	struct ib_pd		*roce_pd;	/* IB protection domain,
>  						 * unique for every RoCE QP
>  						 */
> +	int			nr_cqe;

This should be an unsigned int, as seen in ib_cq_pool_put(2nd arg).

> +	struct ib_cq		*ib_cq;

My suggestion would be to have a comment next to these 2 new members as
we have the same for other members in this structure.

>  	struct ib_qp		*roce_qp;	/* IB queue pair */
>  	struct ib_qp_attr	qp_attr;	/* IB queue pair attributes */
>  
> @@ -107,6 +115,7 @@ struct smc_link {
>  	struct ib_send_wr	*wr_tx_ibs;	/* WR send meta data */
>  	struct ib_sge		*wr_tx_sges;	/* WR send gather meta data */
>  	struct smc_rdma_sges	*wr_tx_rdma_sges;/*RDMA WRITE gather meta data*/
> +	struct ib_cqe		tx_rdma_cqe;	/* CQE RDMA WRITE */
>  	struct smc_rdma_wr	*wr_tx_rdmas;	/* WR RDMA WRITE */
>  	struct smc_wr_tx_pend	*wr_tx_pends;	/* WR send waiting for CQE */
>  	struct completion	*wr_tx_compl;	/* WR send CQE completion */
> @@ -116,7 +125,6 @@ struct smc_link {
>  	struct smc_wr_tx_pend	*wr_tx_v2_pend;	/* WR send v2 waiting for CQE */
>  	dma_addr_t		wr_tx_dma_addr;	/* DMA address of wr_tx_bufs */
>  	dma_addr_t		wr_tx_v2_dma_addr; /* DMA address of v2 tx buf*/
> -	atomic_long_t		wr_tx_id;	/* seq # of last sent WR */
>  	unsigned long		*wr_tx_mask;	/* bit mask of used indexes */
>  	u32			wr_tx_cnt;	/* number of WR send buffers */
>  	wait_queue_head_t	wr_tx_wait;	/* wait for free WR send buf */
> @@ -126,7 +134,7 @@ struct smc_link {
>  	struct completion	tx_ref_comp;
>  
>  	u8			*wr_rx_bufs;	/* WR recv payload buffers */
> -	struct ib_recv_wr	*wr_rx_ibs;	/* WR recv meta data */
> +	struct smc_ib_recv_wr	*wr_rx_ibs;	/* WR recv meta data */
>  	struct ib_sge		*wr_rx_sges;	/* WR recv scatter meta data */
>  	/* above three vectors have wr_rx_cnt elements and use the same index */
>  	int			wr_rx_sge_cnt; /* rx sge, V1 is 1, V2 is either 2 or 1 */
> @@ -135,13 +143,11 @@ struct smc_link {
>  						 */
>  	dma_addr_t		wr_rx_dma_addr;	/* DMA address of wr_rx_bufs */
>  	dma_addr_t		wr_rx_v2_dma_addr; /* DMA address of v2 rx buf*/
> -	u64			wr_rx_id;	/* seq # of last recv WR */
> -	u64			wr_rx_id_compl; /* seq # of last completed WR */
>  	u32			wr_rx_cnt;	/* number of WR recv buffers */
>  	unsigned long		wr_rx_tstamp;	/* jiffies when last buf rx */
> -	wait_queue_head_t       wr_rx_empty_wait; /* wait for RQ empty */
>  
>  	struct ib_reg_wr	wr_reg;		/* WR register memory region */
> +	struct ib_cqe		wr_reg_cqe;
>  	wait_queue_head_t	wr_reg_wait;	/* wait for wr_reg result */
>  	struct {
>  		struct percpu_ref	wr_reg_refs;
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 67211d44a1db..77047ad7d452 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -112,15 +112,6 @@ int smc_ib_modify_qp_rts(struct smc_link *lnk)
>  			    IB_QP_MAX_QP_RD_ATOMIC);
>  }
>  
> -int smc_ib_modify_qp_error(struct smc_link *lnk)
> -{
> -	struct ib_qp_attr qp_attr;
> -
> -	memset(&qp_attr, 0, sizeof(qp_attr));
> -	qp_attr.qp_state = IB_QPS_ERR;
> -	return ib_modify_qp(lnk->roce_qp, &qp_attr, IB_QP_STATE);
> -}
> -
>  int smc_ib_ready_link(struct smc_link *lnk)
>  {
>  	struct smc_link_group *lgr = smc_get_lgr(lnk);
> @@ -134,10 +125,7 @@ int smc_ib_ready_link(struct smc_link *lnk)
>  	if (rc)
>  		goto out;
>  	smc_wr_remember_qp_attr(lnk);
> -	rc = ib_req_notify_cq(lnk->smcibdev->roce_cq_recv,
> -			      IB_CQ_SOLICITED_MASK);
> -	if (rc)
> -		goto out;
> +
>  	rc = smc_wr_rx_post_init(lnk);
>  	if (rc)
>  		goto out;
> @@ -658,38 +646,60 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk)
>  	if (lnk->roce_qp)
>  		ib_destroy_qp(lnk->roce_qp);
>  	lnk->roce_qp = NULL;
> +	if (lnk->ib_cq) {
> +		ib_cq_pool_put(lnk->ib_cq, lnk->nr_cqe);
> +		lnk->ib_cq = NULL;
> +	}
>  }
>  
>  /* create a queue pair within the protection domain for a link */
>  int smc_ib_create_queue_pair(struct smc_link *lnk)
>  {
> +	int max_send_wr, max_recv_wr, rc;
> +	struct ib_cq *cq;
> +
> +	/* include unsolicited rdma_writes as well,
> +	 * there are max. 2 RDMA_WRITE per 1 WR_SEND.
> +	 * +1 for ib_drain_qp()
> +	 */
> +	max_send_wr = 3 * lnk->lgr->max_send_wr + 1;
> +	max_recv_wr = lnk->lgr->max_recv_wr + 1;
> +
> +	cq = ib_cq_pool_get(lnk->smcibdev->ibdev, max_send_wr + max_recv_wr, -1,
> +			    IB_POLL_SOFTIRQ);

Should we make the 3rd arg(completion vector hint) as sysctl tunable
variable? In case if at all any customer wants to use it for CPU
locality(high performance networking). This way they have that option to
tweak it. Same logic for 'cq polling context' by using *IB_POLL_DIRECT*.
Just a thought, I don't have a strong opinion on this. I am fine with
the current values also(-1 & IB_POLL_SOFTIRQ).

> +
> +	if (IS_ERR(cq)) {
> +		rc = PTR_ERR(cq);
> +		return rc;
> +	}
> +
>  	struct ib_qp_init_attr qp_attr = {
>  		.event_handler = smc_ib_qp_event_handler,
>  		.qp_context = lnk,
> -		.send_cq = lnk->smcibdev->roce_cq_send,
> -		.recv_cq = lnk->smcibdev->roce_cq_recv,
> +		.send_cq = cq,
> +		.recv_cq = cq,
>  		.srq = NULL,
>  		.cap = {
>  			.max_send_sge = SMC_IB_MAX_SEND_SGE,
>  			.max_recv_sge = lnk->wr_rx_sge_cnt,
> +			.max_send_wr = max_send_wr,
> +			.max_recv_wr = max_recv_wr,
>  			.max_inline_data = 0,
>  		},
>  		.sq_sig_type = IB_SIGNAL_REQ_WR,
>  		.qp_type = IB_QPT_RC,
>  	};
> -	int rc;
>  
> -	/* include unsolicited rdma_writes as well,
> -	 * there are max. 2 RDMA_WRITE per 1 WR_SEND
> -	 */
> -	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
> -	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;
>  	lnk->roce_qp = ib_create_qp(lnk->roce_pd, &qp_attr);
>  	rc = PTR_ERR_OR_ZERO(lnk->roce_qp);
> -	if (IS_ERR(lnk->roce_qp))
> +	if (IS_ERR(lnk->roce_qp)) {
>  		lnk->roce_qp = NULL;
> -	else
> +		ib_cq_pool_put(cq, max_send_wr + max_recv_wr);
> +	} else {
>  		smc_wr_remember_qp_attr(lnk);
> +		lnk->nr_cqe = max_send_wr + max_recv_wr;
> +		lnk->ib_cq = cq;
> +	}
>  	return rc;
>  }
>  
> @@ -855,62 +865,6 @@ void smc_ib_buf_unmap_sg(struct smc_link *lnk,
>  	buf_slot->sgt[lnk->link_idx].sgl->dma_address = 0;
>  }
>  
> -long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev)
> -{
> -	struct ib_cq_init_attr cqattr =	{
> -		.cqe = SMC_MAX_CQE, .comp_vector = 0 };
> -	int cqe_size_order, smc_order;
> -	long rc;
> -
> -	mutex_lock(&smcibdev->mutex);
> -	rc = 0;
> -	if (smcibdev->initialized)
> -		goto out;
> -	/* the calculated number of cq entries fits to mlx5 cq allocation */
> -	cqe_size_order = cache_line_size() == 128 ? 7 : 6;
> -	smc_order = MAX_PAGE_ORDER - cqe_size_order;
> -	if (SMC_MAX_CQE + 2 > (0x00000001 << smc_order) * PAGE_SIZE)
> -		cqattr.cqe = (0x00000001 << smc_order) * PAGE_SIZE - 2;
> -	smcibdev->roce_cq_send = ib_create_cq(smcibdev->ibdev,
> -					      smc_wr_tx_cq_handler, NULL,
> -					      smcibdev, &cqattr);
> -	rc = PTR_ERR_OR_ZERO(smcibdev->roce_cq_send);
> -	if (IS_ERR(smcibdev->roce_cq_send)) {
> -		smcibdev->roce_cq_send = NULL;
> -		goto out;
> -	}
> -	smcibdev->roce_cq_recv = ib_create_cq(smcibdev->ibdev,
> -					      smc_wr_rx_cq_handler, NULL,
> -					      smcibdev, &cqattr);
> -	rc = PTR_ERR_OR_ZERO(smcibdev->roce_cq_recv);
> -	if (IS_ERR(smcibdev->roce_cq_recv)) {
> -		smcibdev->roce_cq_recv = NULL;
> -		goto err;
> -	}
> -	smc_wr_add_dev(smcibdev);
> -	smcibdev->initialized = 1;
> -	goto out;
> -
> -err:
> -	ib_destroy_cq(smcibdev->roce_cq_send);
> -out:
> -	mutex_unlock(&smcibdev->mutex);
> -	return rc;
> -}
> -
> -static void smc_ib_cleanup_per_ibdev(struct smc_ib_device *smcibdev)
> -{
> -	mutex_lock(&smcibdev->mutex);
> -	if (!smcibdev->initialized)
> -		goto out;
> -	smcibdev->initialized = 0;
> -	ib_destroy_cq(smcibdev->roce_cq_recv);
> -	ib_destroy_cq(smcibdev->roce_cq_send);
> -	smc_wr_remove_dev(smcibdev);
> -out:
> -	mutex_unlock(&smcibdev->mutex);
> -}
> -
>  static struct ib_client smc_ib_client;
>  
>  static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
> @@ -969,7 +923,6 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
>  	INIT_WORK(&smcibdev->port_event_work, smc_ib_port_event_work);
>  	atomic_set(&smcibdev->lnk_cnt, 0);
>  	init_waitqueue_head(&smcibdev->lnks_deleted);
> -	mutex_init(&smcibdev->mutex);
>  	mutex_lock(&smc_ib_devices.mutex);
>  	list_add_tail(&smcibdev->list, &smc_ib_devices.list);
>  	mutex_unlock(&smc_ib_devices.mutex);
> @@ -1018,7 +971,6 @@ static void smc_ib_remove_dev(struct ib_device *ibdev, void *client_data)
>  	pr_warn_ratelimited("smc: removing ib device %s\n",
>  			    smcibdev->ibdev->name);
>  	smc_smcr_terminate_all(smcibdev);
> -	smc_ib_cleanup_per_ibdev(smcibdev);
>  	ib_unregister_event_handler(&smcibdev->event_handler);
>  	cancel_work_sync(&smcibdev->port_event_work);
>  	kfree(smcibdev);
> diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
> index ef8ac2b7546d..c5a0d773b73f 100644
> --- a/net/smc/smc_ib.h
> +++ b/net/smc/smc_ib.h
> @@ -37,10 +37,6 @@ struct smc_ib_device {				/* ib-device infos for smc */
>  	struct ib_device	*ibdev;
>  	struct ib_port_attr	pattr[SMC_MAX_PORTS];	/* ib dev. port attrs */
>  	struct ib_event_handler	event_handler;	/* global ib_event handler */
> -	struct ib_cq		*roce_cq_send;	/* send completion queue */
> -	struct ib_cq		*roce_cq_recv;	/* recv completion queue */
> -	struct tasklet_struct	send_tasklet;	/* called by send cq handler */
> -	struct tasklet_struct	recv_tasklet;	/* called by recv cq handler */
>  	char			mac[SMC_MAX_PORTS][ETH_ALEN];
>  						/* mac address per port*/
>  	u8			pnetid[SMC_MAX_PORTS][SMC_MAX_PNETID_LEN];
> @@ -96,7 +92,6 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk);
>  int smc_ib_create_queue_pair(struct smc_link *lnk);
>  int smc_ib_ready_link(struct smc_link *lnk);
>  int smc_ib_modify_qp_rts(struct smc_link *lnk);
> -int smc_ib_modify_qp_error(struct smc_link *lnk);
>  long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev);

This declaration is not required any-more as both defination &
invocation of this function are removed by your patch.

>  int smc_ib_get_memory_region(struct ib_pd *pd, int access_flags,
>  			     struct smc_buf_desc *buf_slot, u8 link_idx);
> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
> index 3144b4b1fe29..d301df9ed58b 100644
> --- a/net/smc/smc_tx.c
> +++ b/net/smc/smc_tx.c
> @@ -321,7 +321,6 @@ static int smc_tx_rdma_write(struct smc_connection *conn, int peer_rmbe_offset,
>  	struct smc_link *link = conn->lnk;
>  	int rc;
>  
> -	rdma_wr->wr.wr_id = smc_wr_tx_get_next_wr_id(link);
>  	rdma_wr->wr.num_sge = num_sges;
>  	rdma_wr->remote_addr =
>  		lgr->rtokens[conn->rtoken_idx][link->link_idx].dma_addr +
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 5feafa98ab1a..3a361aa020ab 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -38,7 +38,7 @@ static DEFINE_HASHTABLE(smc_wr_rx_hash, SMC_WR_RX_HASH_BITS);
>  static DEFINE_SPINLOCK(smc_wr_rx_hash_lock);
>  
>  struct smc_wr_tx_pend {	/* control data for a pending send request */
> -	u64			wr_id;		/* work request id sent */
> +	struct ib_cqe		cqe;
>  	smc_wr_tx_handler	handler;
>  	enum ib_wc_status	wc_status;	/* CQE status */
>  	struct smc_link		*link;
> @@ -63,62 +63,51 @@ void smc_wr_tx_wait_no_pending_sends(struct smc_link *link)
>  	wait_event(link->wr_tx_wait, !smc_wr_is_tx_pend(link));
>  }
>  
> -static inline int smc_wr_tx_find_pending_index(struct smc_link *link, u64 wr_id)
> +static void smc_wr_tx_rdma_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	u32 i;
> +	struct smc_link *link = wc->qp->qp_context;
>  
> -	for (i = 0; i < link->wr_tx_cnt; i++) {
> -		if (link->wr_tx_pends[i].wr_id == wr_id)
> -			return i;
> -	}
> -	return link->wr_tx_cnt;
> +	/* terminate link */
> +	if (unlikely(wc->status))
> +		smcr_link_down_cond_sched(link);
> +}
> +
> +static void smc_wr_reg_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
> +{
> +	struct smc_link *link = wc->qp->qp_context;
> +
> +	if (wc->status)
> +		link->wr_reg_state = FAILED;
> +	else
> +		link->wr_reg_state = CONFIRMED;
> +	smc_wr_wakeup_reg_wait(link);
>  }
>  
> -static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
> +static void smc_wr_tx_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct smc_wr_tx_pend pnd_snd;
> +	struct smc_wr_tx_pend *tx_pend, pnd_snd;
>  	struct smc_link *link;
>  	u32 pnd_snd_idx;
>  
>  	link = wc->qp->qp_context;
>  
> -	if (wc->opcode == IB_WC_REG_MR) {
> -		if (wc->status)
> -			link->wr_reg_state = FAILED;
> -		else
> -			link->wr_reg_state = CONFIRMED;
> -		smc_wr_wakeup_reg_wait(link);
> -		return;
> -	}
> +	tx_pend = container_of(wc->wr_cqe, struct smc_wr_tx_pend, cqe);
> +	pnd_snd_idx = tx_pend->idx;
> +
> +	tx_pend->wc_status = wc->status;
> +	memcpy(&pnd_snd, tx_pend, sizeof(pnd_snd));
>  
> -	pnd_snd_idx = smc_wr_tx_find_pending_index(link, wc->wr_id);
>  	if (pnd_snd_idx == link->wr_tx_cnt) {
> -		if (link->lgr->smc_version != SMC_V2 ||
> -		    link->wr_tx_v2_pend->wr_id != wc->wr_id)
> -			return;
> -		link->wr_tx_v2_pend->wc_status = wc->status;
> -		memcpy(&pnd_snd, link->wr_tx_v2_pend, sizeof(pnd_snd));
> -		/* clear the full struct smc_wr_tx_pend including .priv */
> -		memset(link->wr_tx_v2_pend, 0,
> -		       sizeof(*link->wr_tx_v2_pend));
> -		memset(link->lgr->wr_tx_buf_v2, 0,
> -		       sizeof(*link->lgr->wr_tx_buf_v2));
> +		memset(link->lgr->wr_tx_buf_v2, 0, sizeof(*link->lgr->wr_tx_buf_v2));
>  	} else {
> -		link->wr_tx_pends[pnd_snd_idx].wc_status = wc->status;
> -		if (link->wr_tx_pends[pnd_snd_idx].compl_requested)
> +		if (tx_pend->compl_requested)
>  			complete(&link->wr_tx_compl[pnd_snd_idx]);
> -		memcpy(&pnd_snd, &link->wr_tx_pends[pnd_snd_idx],
> -		       sizeof(pnd_snd));
> -		/* clear the full struct smc_wr_tx_pend including .priv */
> -		memset(&link->wr_tx_pends[pnd_snd_idx], 0,
> -		       sizeof(link->wr_tx_pends[pnd_snd_idx]));
> -		memset(&link->wr_tx_bufs[pnd_snd_idx], 0,
> -		       sizeof(link->wr_tx_bufs[pnd_snd_idx]));
> +		memset(&link->wr_tx_bufs[tx_pend->idx], 0, sizeof(link->wr_tx_bufs[tx_pend->idx]));
>  		if (!test_and_clear_bit(pnd_snd_idx, link->wr_tx_mask))
>  			return;
>  	}
>  
> -	if (wc->status) {
> +	if (unlikely(wc->status)) {
>  		if (link->lgr->smc_version == SMC_V2) {
>  			memset(link->wr_tx_v2_pend, 0,
>  			       sizeof(*link->wr_tx_v2_pend));
> @@ -128,44 +117,12 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
>  		/* terminate link */
>  		smcr_link_down_cond_sched(link);
>  	}
> +
>  	if (pnd_snd.handler)
>  		pnd_snd.handler(&pnd_snd.priv, link, wc->status);
>  	wake_up(&link->wr_tx_wait);
>  }
>  
> -static void smc_wr_tx_tasklet_fn(struct tasklet_struct *t)
> -{
> -	struct smc_ib_device *dev = from_tasklet(dev, t, send_tasklet);
> -	struct ib_wc wc[SMC_WR_MAX_POLL_CQE];
> -	int i = 0, rc;
> -	int polled = 0;
> -
> -again:
> -	polled++;
> -	do {
> -		memset(&wc, 0, sizeof(wc));
> -		rc = ib_poll_cq(dev->roce_cq_send, SMC_WR_MAX_POLL_CQE, wc);
> -		if (polled == 1) {
> -			ib_req_notify_cq(dev->roce_cq_send,
> -					 IB_CQ_NEXT_COMP |
> -					 IB_CQ_REPORT_MISSED_EVENTS);
> -		}
> -		if (!rc)
> -			break;
> -		for (i = 0; i < rc; i++)
> -			smc_wr_tx_process_cqe(&wc[i]);
> -	} while (rc > 0);
> -	if (polled == 1)
> -		goto again;
> -}
> -
> -void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
> -{
> -	struct smc_ib_device *dev = (struct smc_ib_device *)cq_context;
> -
> -	tasklet_schedule(&dev->send_tasklet);
> -}
> -
>  /*---------------------------- request submission ---------------------------*/
>  
>  static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
> @@ -202,7 +159,6 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
>  	struct smc_wr_tx_pend *wr_pend;
>  	u32 idx = link->wr_tx_cnt;
>  	struct ib_send_wr *wr_ib;
> -	u64 wr_id;
>  	int rc;
>  
>  	*wr_buf = NULL;
> @@ -226,14 +182,13 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
>  		if (idx == link->wr_tx_cnt)
>  			return -EPIPE;
>  	}
> -	wr_id = smc_wr_tx_get_next_wr_id(link);
> +
>  	wr_pend = &link->wr_tx_pends[idx];
> -	wr_pend->wr_id = wr_id;
>  	wr_pend->handler = handler;
>  	wr_pend->link = link;
>  	wr_pend->idx = idx;
>  	wr_ib = &link->wr_tx_ibs[idx];
> -	wr_ib->wr_id = wr_id;
> +	wr_ib->wr_cqe = &wr_pend->cqe;
>  	*wr_buf = &link->wr_tx_bufs[idx];
>  	if (wr_rdma_buf)
>  		*wr_rdma_buf = &link->wr_tx_rdmas[idx];
> @@ -248,21 +203,18 @@ int smc_wr_tx_get_v2_slot(struct smc_link *link,
>  {
>  	struct smc_wr_tx_pend *wr_pend;
>  	struct ib_send_wr *wr_ib;
> -	u64 wr_id;
>  
>  	if (link->wr_tx_v2_pend->idx == link->wr_tx_cnt)
>  		return -EBUSY;
>  
>  	*wr_buf = NULL;
>  	*wr_pend_priv = NULL;
> -	wr_id = smc_wr_tx_get_next_wr_id(link);
>  	wr_pend = link->wr_tx_v2_pend;
> -	wr_pend->wr_id = wr_id;
>  	wr_pend->handler = handler;
>  	wr_pend->link = link;
>  	wr_pend->idx = link->wr_tx_cnt;
>  	wr_ib = link->wr_tx_v2_ib;
> -	wr_ib->wr_id = wr_id;
> +	wr_ib->wr_cqe = &wr_pend->cqe;
>  	*wr_buf = link->lgr->wr_tx_buf_v2;
>  	*wr_pend_priv = &wr_pend->priv;
>  	return 0;
> @@ -306,8 +258,6 @@ int smc_wr_tx_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv)
>  	struct smc_wr_tx_pend *pend;
>  	int rc;
>  
> -	ib_req_notify_cq(link->smcibdev->roce_cq_send,
> -			 IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS);
>  	pend = container_of(priv, struct smc_wr_tx_pend, priv);
>  	rc = ib_post_send(link->roce_qp, &link->wr_tx_ibs[pend->idx], NULL);
>  	if (rc) {
> @@ -323,8 +273,6 @@ int smc_wr_tx_v2_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv,
>  	int rc;
>  
>  	link->wr_tx_v2_ib->sg_list[0].length = len;
> -	ib_req_notify_cq(link->smcibdev->roce_cq_send,
> -			 IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS);
>  	rc = ib_post_send(link->roce_qp, link->wr_tx_v2_ib, NULL);
>  	if (rc) {
>  		smc_wr_tx_put_slot(link, priv);
> @@ -367,10 +315,7 @@ int smc_wr_reg_send(struct smc_link *link, struct ib_mr *mr)
>  {
>  	int rc;
>  
> -	ib_req_notify_cq(link->smcibdev->roce_cq_send,
> -			 IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS);
>  	link->wr_reg_state = POSTED;
> -	link->wr_reg.wr.wr_id = (u64)(uintptr_t)mr;
>  	link->wr_reg.mr = mr;
>  	link->wr_reg.key = mr->rkey;
>  	rc = ib_post_send(link->roce_qp, &link->wr_reg.wr, NULL);
> @@ -431,94 +376,76 @@ static inline void smc_wr_rx_demultiplex(struct ib_wc *wc)
>  {
>  	struct smc_link *link = (struct smc_link *)wc->qp->qp_context;
>  	struct smc_wr_rx_handler *handler;
> +	struct smc_ib_recv_wr *recv_wr;
>  	struct smc_wr_rx_hdr *wr_rx;
> -	u64 temp_wr_id;
> -	u32 index;
>  
>  	if (wc->byte_len < sizeof(*wr_rx))
>  		return; /* short message */
> -	temp_wr_id = wc->wr_id;
> -	index = do_div(temp_wr_id, link->wr_rx_cnt);
> -	wr_rx = (struct smc_wr_rx_hdr *)(link->wr_rx_bufs + index * link->wr_rx_buflen);
> +
> +	recv_wr = container_of(wc->wr_cqe, struct smc_ib_recv_wr, cqe);
> +
> +	wr_rx = (struct smc_wr_rx_hdr *)(link->wr_rx_bufs + recv_wr->index * link->wr_rx_buflen);
>  	hash_for_each_possible(smc_wr_rx_hash, handler, list, wr_rx->type) {
>  		if (handler->type == wr_rx->type)
>  			handler->handler(wc, wr_rx);
>  	}
>  }
>  
> -static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
> +static void smc_wr_rx_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct smc_link *link;
> -	int i;
> -
> -	for (i = 0; i < num; i++) {
> -		link = wc[i].qp->qp_context;
> -		link->wr_rx_id_compl = wc[i].wr_id;
> -		if (wc[i].status == IB_WC_SUCCESS) {
> -			link->wr_rx_tstamp = jiffies;
> -			smc_wr_rx_demultiplex(&wc[i]);
> -			smc_wr_rx_post(link); /* refill WR RX */
> -		} else {
> -			/* handle status errors */
> -			switch (wc[i].status) {
> -			case IB_WC_RETRY_EXC_ERR:
> -			case IB_WC_RNR_RETRY_EXC_ERR:
> -			case IB_WC_WR_FLUSH_ERR:
> -				smcr_link_down_cond_sched(link);
> -				if (link->wr_rx_id_compl == link->wr_rx_id)
> -					wake_up(&link->wr_rx_empty_wait);
> -				break;
> -			default:
> -				smc_wr_rx_post(link); /* refill WR RX */
> -				break;
> -			}
> +	struct smc_link *link = wc->qp->qp_context;
> +
> +	if (wc->status == IB_WC_SUCCESS) {
> +		link->wr_rx_tstamp = jiffies;
> +		smc_wr_rx_demultiplex(wc);
> +		smc_wr_rx_post(link, wc->wr_cqe); /* refill WR RX */
> +	} else {
> +		/* handle status errors */
> +		switch (wc->status) {
> +		case IB_WC_RETRY_EXC_ERR:
> +		case IB_WC_RNR_RETRY_EXC_ERR:
> +		case IB_WC_WR_FLUSH_ERR:
> +			smcr_link_down_cond_sched(link);
> +			break;
> +		default:
> +			smc_wr_rx_post(link, wc->wr_cqe); /* refill WR RX */
> +			break;
>  		}
>  	}
>  }
>  
> -static void smc_wr_rx_tasklet_fn(struct tasklet_struct *t)
> +int smc_wr_rx_post_init(struct smc_link *link)
>  {
> -	struct smc_ib_device *dev = from_tasklet(dev, t, recv_tasklet);
> -	struct ib_wc wc[SMC_WR_MAX_POLL_CQE];
> -	int polled = 0;
> -	int rc;
> +	u32 i;
> +	int rc = 0;
>  
> -again:
> -	polled++;
> -	do {
> -		memset(&wc, 0, sizeof(wc));
> -		rc = ib_poll_cq(dev->roce_cq_recv, SMC_WR_MAX_POLL_CQE, wc);
> -		if (polled == 1) {
> -			ib_req_notify_cq(dev->roce_cq_recv,
> -					 IB_CQ_SOLICITED_MASK
> -					 | IB_CQ_REPORT_MISSED_EVENTS);
> -		}
> -		if (!rc)
> -			break;
> -		smc_wr_rx_process_cqes(&wc[0], rc);
> -	} while (rc > 0);
> -	if (polled == 1)
> -		goto again;
> +	for (i = 0; i < link->wr_rx_cnt; i++)
> +		rc = smc_wr_rx_post(link, &link->wr_rx_ibs[i].cqe);
> +	return rc;
>  }
>  
> -void smc_wr_rx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
> -{
> -	struct smc_ib_device *dev = (struct smc_ib_device *)cq_context;
> +/***************************** init, exit, misc ******************************/
> +
>  
> -	tasklet_schedule(&dev->recv_tasklet);
> +static inline void smc_wr_reg_init_cqe(struct ib_cqe *cqe)
> +{
> +	cqe->done = smc_wr_reg_process_cqe;
>  }
>  
> -int smc_wr_rx_post_init(struct smc_link *link)
> +static inline void smc_wr_tx_init_cqe(struct ib_cqe *cqe)
>  {
> -	u32 i;
> -	int rc = 0;
> +	cqe->done = smc_wr_tx_process_cqe;
> +}
>  
> -	for (i = 0; i < link->wr_rx_cnt; i++)
> -		rc = smc_wr_rx_post(link);
> -	return rc;
> +static inline void smc_wr_rx_init_cqe(struct ib_cqe *cqe)
> +{
> +	cqe->done = smc_wr_rx_process_cqe;
>  }
>  
> -/***************************** init, exit, misc ******************************/
> +static inline void smc_wr_tx_rdma_init_cqe(struct ib_cqe *cqe)
> +{
> +	cqe->done = smc_wr_tx_rdma_process_cqe;
> +}
>  
>  void smc_wr_remember_qp_attr(struct smc_link *lnk)
>  {
> @@ -548,9 +475,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
>  		    &init_attr);
>  
>  	lnk->wr_tx_cnt = min_t(size_t, lnk->max_send_wr,
> -			       lnk->qp_attr.cap.max_send_wr);
> +			       lnk->qp_attr.cap.max_send_wr - 1);
>  	lnk->wr_rx_cnt = min_t(size_t, lnk->max_recv_wr,
> -			       lnk->qp_attr.cap.max_recv_wr);
> +			       lnk->qp_attr.cap.max_recv_wr - 1);
>  }
>  
>  static void smc_wr_init_sge(struct smc_link *lnk)
> @@ -585,6 +512,8 @@ static void smc_wr_init_sge(struct smc_link *lnk)
>  			lnk->wr_tx_rdma_sges[i].tx_rdma_sge[0].wr_tx_rdma_sge;
>  		lnk->wr_tx_rdmas[i].wr_tx_rdma[1].wr.sg_list =
>  			lnk->wr_tx_rdma_sges[i].tx_rdma_sge[1].wr_tx_rdma_sge;
> +		lnk->wr_tx_rdmas[i].wr_tx_rdma[0].wr.wr_cqe = &lnk->tx_rdma_cqe;
> +		lnk->wr_tx_rdmas[i].wr_tx_rdma[1].wr.wr_cqe = &lnk->tx_rdma_cqe;
>  	}
>  
>  	if (lnk->lgr->smc_version == SMC_V2) {
> @@ -622,10 +551,13 @@ static void smc_wr_init_sge(struct smc_link *lnk)
>  			lnk->wr_rx_sges[x + 1].lkey =
>  					lnk->roce_pd->local_dma_lkey;
>  		}
> -		lnk->wr_rx_ibs[i].next = NULL;
> -		lnk->wr_rx_ibs[i].sg_list = &lnk->wr_rx_sges[x];
> -		lnk->wr_rx_ibs[i].num_sge = lnk->wr_rx_sge_cnt;
> +		lnk->wr_rx_ibs[i].wr.next = NULL;
> +		lnk->wr_rx_ibs[i].wr.sg_list = &lnk->wr_rx_sges[x];
> +		lnk->wr_rx_ibs[i].wr.num_sge = lnk->wr_rx_sge_cnt;
>  	}
> +
> +	smc_wr_reg_init_cqe(&lnk->wr_reg_cqe);
> +	lnk->wr_reg.wr.wr_cqe = &lnk->wr_reg_cqe;
>  	lnk->wr_reg.wr.next = NULL;
>  	lnk->wr_reg.wr.num_sge = 0;
>  	lnk->wr_reg.wr.send_flags = IB_SEND_SIGNALED;
> @@ -641,7 +573,6 @@ void smc_wr_free_link(struct smc_link *lnk)
>  		return;
>  	ibdev = lnk->smcibdev->ibdev;
>  
> -	smc_wr_drain_cq(lnk);
>  	smc_wr_wakeup_reg_wait(lnk);
>  	smc_wr_wakeup_tx_wait(lnk);
>  
> @@ -758,11 +689,19 @@ int smc_wr_alloc_link_mem(struct smc_link *link)
>  				  GFP_KERNEL);
>  	if (!link->wr_rx_ibs)
>  		goto no_mem_wr_tx_ibs;
> +	/* init wr_rx_ibs cqe */

Should you do the same init for link->wr_tx_ibs also?

> +	for (int i = 0; i < link->max_recv_wr; i++) {
> +		smc_wr_rx_init_cqe(&link->wr_rx_ibs[i].cqe);
> +		link->wr_rx_ibs[i].wr.wr_cqe = &link->wr_rx_ibs[i].cqe;
> +		link->wr_rx_ibs[i].index = i;
> +	}
>  	link->wr_tx_rdmas = kcalloc(link->max_send_wr,
>  				    sizeof(link->wr_tx_rdmas[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_rdmas)
>  		goto no_mem_wr_rx_ibs;
> +
> +	smc_wr_tx_rdma_init_cqe(&link->tx_rdma_cqe);
>  	link->wr_tx_rdma_sges = kcalloc(link->max_send_wr,
>  					sizeof(link->wr_tx_rdma_sges[0]),
>  					GFP_KERNEL);
> @@ -785,6 +724,8 @@ int smc_wr_alloc_link_mem(struct smc_link *link)
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_pends)
>  		goto no_mem_wr_tx_mask;
> +	for (int i = 0; i < link->max_send_wr; i++)
> +		smc_wr_tx_init_cqe(&link->wr_tx_pends[i].cqe);
>  	link->wr_tx_compl = kcalloc(link->max_send_wr,
>  				    sizeof(link->wr_tx_compl[0]),
>  				    GFP_KERNEL);
> @@ -804,6 +745,7 @@ int smc_wr_alloc_link_mem(struct smc_link *link)
>  					      GFP_KERNEL);
>  		if (!link->wr_tx_v2_pend)
>  			goto no_mem_v2_sge;
> +		smc_wr_tx_init_cqe(&link->wr_tx_v2_pend->cqe);
>  	}
>  	return 0;
>  
> @@ -837,18 +779,6 @@ int smc_wr_alloc_link_mem(struct smc_link *link)
>  	return -ENOMEM;
>  }
>  
> -void smc_wr_remove_dev(struct smc_ib_device *smcibdev)
> -{
> -	tasklet_kill(&smcibdev->recv_tasklet);
> -	tasklet_kill(&smcibdev->send_tasklet);
> -}
> -
> -void smc_wr_add_dev(struct smc_ib_device *smcibdev)
> -{
> -	tasklet_setup(&smcibdev->recv_tasklet, smc_wr_rx_tasklet_fn);
> -	tasklet_setup(&smcibdev->send_tasklet, smc_wr_tx_tasklet_fn);
> -}
> -
>  static void smcr_wr_tx_refs_free(struct percpu_ref *ref)
>  {
>  	struct smc_link *lnk = container_of(ref, struct smc_link, wr_tx_refs);
> @@ -868,8 +798,6 @@ int smc_wr_create_link(struct smc_link *lnk)
>  	struct ib_device *ibdev = lnk->smcibdev->ibdev;
>  	int rc = 0;
>  
> -	smc_wr_tx_set_wr_id(&lnk->wr_tx_id, 0);
> -	lnk->wr_rx_id = 0;
>  	lnk->wr_rx_dma_addr = ib_dma_map_single(
>  		ibdev, lnk->wr_rx_bufs,	lnk->wr_rx_buflen * lnk->wr_rx_cnt,
>  		DMA_FROM_DEVICE);
> @@ -917,7 +845,6 @@ int smc_wr_create_link(struct smc_link *lnk)
>  	if (rc)
>  		goto cancel_ref;
>  	init_completion(&lnk->reg_ref_comp);
> -	init_waitqueue_head(&lnk->wr_rx_empty_wait);
>  	return rc;
>  
>  cancel_ref:
> diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
> index aa4533af9122..4268dfcd84d3 100644
> --- a/net/smc/smc_wr.h
> +++ b/net/smc/smc_wr.h
> @@ -44,19 +44,6 @@ struct smc_wr_rx_handler {
>  	u8			type;
>  };
>  
> -/* Only used by RDMA write WRs.
> - * All other WRs (CDC/LLC) use smc_wr_tx_send handling WR_ID implicitly
> - */
> -static inline long smc_wr_tx_get_next_wr_id(struct smc_link *link)
> -{
> -	return atomic_long_inc_return(&link->wr_tx_id);
> -}
> -
> -static inline void smc_wr_tx_set_wr_id(atomic_long_t *wr_tx_id, long val)
> -{
> -	atomic_long_set(wr_tx_id, val);
> -}
> -
>  static inline bool smc_wr_tx_link_hold(struct smc_link *link)
>  {
>  	if (!smc_link_sendable(link))
> @@ -70,9 +57,10 @@ static inline void smc_wr_tx_link_put(struct smc_link *link)
>  	percpu_ref_put(&link->wr_tx_refs);
>  }
>  
> -static inline void smc_wr_drain_cq(struct smc_link *lnk)
> +static inline void smc_wr_drain_qp(struct smc_link *lnk)
>  {
> -	wait_event(lnk->wr_rx_empty_wait, lnk->wr_rx_id_compl == lnk->wr_rx_id);
> +	if (lnk->qp_attr.cur_qp_state != IB_QPS_RESET)

Should you call *ib_drain_qp* only for IB_QPS_RTS(Ready to Send) &
IB_QPS_SQD(Send Queue Draining) ib_qp_state?

> +		ib_drain_qp(lnk->roce_qp);
>  }
Did you enable dynamic_debug for drivers/infiniband/core/cq.c and SMC to
confirm CQ polling paths are active and no WARNs on teardown?

I followed below steps but I couldn't see the relevent logs in dmesg.
Not sure if I missed something.

# Mount debugfs if not already mounted
mount -t debugfs none /sys/kernel/debug

# Enable debug for InfiniBand CQ handling (cq.c)
echo "file drivers/infiniband/core/cq.c +p" >
/sys/kernel/debug/dynamic_debug/control

# Enable debug for SMC (Sockets over RDMA)
echo "module smc +p" > /sys/kernel/debug/dynamic_debug/control

# Increase loglevel to ensure debug messages show on console
echo 8 > /proc/sys/kernel/printk

# Monitor dmesg for CQ related logs
dmesg -w | grep -iE "cq|ib_core|smc" ----> I didn't see relevent logs
while I ran continuous SMC-R traffic


