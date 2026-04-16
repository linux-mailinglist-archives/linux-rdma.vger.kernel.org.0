Return-Path: <linux-rdma+bounces-19389-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EQmAB/L4GkdmAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19389-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 13:42:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B640D94C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEA443028C6D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082A63AEF43;
	Thu, 16 Apr 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gDlOJn14"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A03AE6FA;
	Thu, 16 Apr 2026 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339731; cv=none; b=EdhcxxfSZD8cmKqrSgKcAfkP2f3RqSaU21kE6by9gk6pnmegZwlbSbKtLQ4SLSwCrkapitrKU8SYP7DM4Zi3lBJ5Wyv3rmEWaHVGz2KX30Ic3q5dNzIEs8Qd/yAzNoonuFU16XxKuzKFXFkI9DDqNuS32X+/mOjie0KXPnIRaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339731; c=relaxed/simple;
	bh=GFCIAhqS5evT6pdD6RWPdagyiVaJ545dotNJEVtQo18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixHXYdk0UxGvzhVFZDRANTRcmU43P3YPK6EKpya52COAklmnCTiq+9gjHNN79HghfkAUsOtd57YRtbOsLcKLfs5+7Pwf9bzsKYf3/l0NTcRCU5TU4BbrORCCi88WiIWCkOzWXPhfLryW7jdGzt8sxjySboxqi+cBFi5Qr6uKnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gDlOJn14; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6YbSX1832977;
	Thu, 16 Apr 2026 11:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lX78on
	UGvU/teIvOkEAPHtT2D94PNV/PXQ4rl5oCGdk=; b=gDlOJn149WhMv8hlfow995
	9+5VvvSNf1RW7/aqw4Htfh+3ZzIK35+gVnqcyNXbyNtBfiYOnRzfVOfAPPYCtmV+
	QBPRkZnwKluQl73Fv2wJtAlv07bqdbxZOupcxHt/5gWC8VgIdGIN4LPgGig6QbG7
	r250CPgmC9vq5KhQYTfJxZhJozN5w+1ASRBeUoGG8CWRQksb4TssQZxAGounY/7t
	n1ifTAGbc8DTbgAabjoppy2Fbq020T6IFWq08Sdw8eLxIY1c69dR+1gmeD4+RmMQ
	2DaxVAO6Js0JCd6fCmE8r+jYvDZdbrmmiW+fDdkXx/lbh4vvgW/T2uz/B8dUSsZw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rn5b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 11:41:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GA7Sdo015158;
	Thu, 16 Apr 2026 11:41:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mstuk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 11:41:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GBfs9i46530908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 11:41:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ECB020043;
	Thu, 16 Apr 2026 11:41:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6176420040;
	Thu, 16 Apr 2026 11:41:29 +0000 (GMT)
Received: from [9.124.217.54] (unknown [9.124.217.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 11:41:29 +0000 (GMT)
Message-ID: <7ef51e89-25c1-4a77-ba94-b50550794caf@linux.ibm.com>
Date: Thu, 16 Apr 2026 17:11:27 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: cap allocation order for SMC-R
 physically contiguous buffers
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dust Li
 <dust.li@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>, Simon Horman
 <horms@kernel.org>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        oliver.yang@linux.alibaba.com, pasic@linux.ibm.com
References: <20260407124337.88128-1-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20260407124337.88128-1-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEwNyBTYWx0ZWRfX8x0eGXZv6PQ2
 N8zDpzcRs5IWDJR9CM9coVhXpeUsN/3YrWzFt4hpgGWHKQnjPWoS8EOx4YzFFRlJ9zGCyG51dRE
 xPdim5Ndeox66cKgvd/7837Yy8sehauk0j3jG6rvEU0VLJq2KeXX2qsT2HB921trcPlPQkc49hR
 Qe+VhKQjQgK2gRh9ShfnCJ2YZGAtBiBZbAnU12F1S8tUu48lyyQ/Ep8VRV+KIKZyvG1DdU8ZUDq
 RLeHn3WxVAiJPGby4xJCvToJll80YpOuvZSAT3KbKG2gYdh/mzApUPAW4aLT6f4ocj9anI/Vhj3
 lk1ciJ3NuaUmqfEuopDc+X1mMGueOwmKDJq5fgizhTAUl3f8YcycK4M/FywelsXcymtkUwTLBAW
 GZZk3onmRd7ziijtGdeNOOsFlPR9QA8AU/+mewAhxpfOGRGH/R0l/eN05e+fwlFThEfwjK1wi2a
 OMnHwAPhU8J0rALryxA==
X-Proofpoint-ORIG-GUID: ssQXe45jGByViQJvwAu5KWLlSx6QYBKf
X-Proofpoint-GUID: f4xXQOKTW5UaryjFMYNdUl6sVneEUs6x
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e0cb07 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=qxvEQBEN2lSPpFVz31sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160107
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-19389-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sidraya@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9B1B640D94C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 07/04/26 6:13 pm, D. Wythe wrote:
> The alloc_pages() cannot satisfy requests exceeding MAX_PAGE_ORDER,
> and attempting such allocations will lead to guaranteed failures
> and potential kernel warnings.
> 
> For SMCR_PHYS_CONT_BUFS, cap the allocation order to MAX_PAGE_ORDER.
> This ensures the attempts to allocate the largest possible physically
> contiguous chunk succeed, instead of failing with an invalid order.
> This also avoids redundant "try-fail-degrade" cycles in
> __smc_buf_create().
> 
> For SMCR_MIXED_BUFS, no cap is needed: if the order exceeds
> MAX_PAGE_ORDER, alloc_pages() will silently fail (__GFP_NOWARN)
> and automatically fall back to virtual memory.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> ---
> Changes v1 -> v2:
> https://lore.kernel.org/netdev/20260312082154.36971-1-alibuda@linux.alibaba.com/
> 
> - Move the bufsize cap from smcr_new_buf_create() up to
>   __smc_buf_create(), which is simpler and avoids touching
>   the allocation logic itself.
> ---
>  net/smc/smc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index e2d083daeb7e..cdd881746e21 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -2440,6 +2440,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
>  		/* use socket send buffer size (w/o overhead) as start value */
>  		bufsize = smc->sk.sk_sndbuf / 2;
>  
> +	/* limit bufsize for physically contiguous buffers */
> +	if (!is_smcd && lgr->buf_type == SMCR_PHYS_CONT_BUFS)
> +		bufsize = min_t(int, bufsize, (PAGE_SIZE << MAX_PAGE_ORDER));
> +
>  	for (bufsize_comp = smc_compress_bufsize(bufsize, is_smcd, is_rmb);
>  	     bufsize_comp >= 0; bufsize_comp--) {
>  		if (is_rmb) {

Code changes looks good to me.
Thanks
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>

