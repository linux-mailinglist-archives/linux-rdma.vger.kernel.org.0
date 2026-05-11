Return-Path: <linux-rdma+bounces-20352-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG7+LPBjAWrQXgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20352-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:06:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B5507F5F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24668300DF50
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAE3570DF;
	Mon, 11 May 2026 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ex1rDnAZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECC194C96;
	Mon, 11 May 2026 05:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476010; cv=none; b=WNYAv/tkrfmNgGXbXVvH4ISy1lo+3dcpQP8h/yQ11pkB73R92S4S3UMk7RSfq0bqMIcu7JMGr4Dn+99YuXfQx+6mp2DxBJGSpYZM8pYHiSB9Gv10sYKw9vDq7WCHq+AFYff8ISGJ3waBqtYpf/XKwHqvauy5xfOoSC5O/9oEo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476010; c=relaxed/simple;
	bh=rXSD0fvdynYiCLT4eg+7mt9T9vNIATYsNTdjSgi4k+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LH/Kyx1EBKYQ+7O1EU5HvkojB93OguX8g001aY5+MGsiBzqcLITnlz9LMp753DlDzmqJ90iWGfXQU3kPuXo5EdSLjp65F6jnGcGj1YC0RlFMFtBBqvo9ECaMuh3fe+3/1A+zye/a9CKqqk3mlzbDtYjisnC9ElkYyAH5wYJRRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ex1rDnAZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ANPBjK4107090;
	Mon, 11 May 2026 05:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B+jxpM
	lReJQFMIHgQeZrD7D1fxNpSKN6r/vmsRKQ1IY=; b=Ex1rDnAZa34R0B8UZiB+N1
	DUVvzRvUNSCGtuHzd5F2Mzcz40qSXdyhKJti3pELUZefC0IEfYth5qu+/y6e9MDG
	CIGnU3DqZhXwRGv6ethtEymllFKW1kTIYq04XhUTNGRBGcYy7hBSCSZY13b3U2BU
	XMWw4ZHv1IJXo/wUwcz6Vw4Ksn5+N0+woGEjK8Cq6YaA30piNFzQYJ8/MzReM35s
	LE4xlq6TiHtCg2PTxaD7pxNndWASIFPXGy45/yDobg3AL6Ob+7c9KqbhwcuiQIe5
	JNU8I5tnLbcSd0kF1QALZrCOIiq9tXjPkbKXu0keOLSmR+isXYMwCVFAreA3efWg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4pmqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 05:06:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B4sf6D024107;
	Mon, 11 May 2026 05:06:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvuw0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 05:06:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B56iT732833910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 05:06:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5799820043;
	Mon, 11 May 2026 05:06:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACEC920040;
	Mon, 11 May 2026 05:06:42 +0000 (GMT)
Received: from [9.123.5.222] (unknown [9.123.5.222])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 05:06:42 +0000 (GMT)
Message-ID: <990d92d9-40ed-47bc-866f-51d386adcb41@linux.ibm.com>
Date: Mon, 11 May 2026 10:36:41 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: avoid NULL deref of conn->lnk in
 smc_msg_event tracepoint
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, wenjia@linux.ibm.com,
        tonylu@linux.alibaba.com, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, bestswngs@gmail.com
References: <20260510222640.1230720-1-xmei5@asu.edu>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20260510222640.1230720-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a0163e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=1CYBFmbjrI-9FY8DL4EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA1MyBTYWx0ZWRfX41oWdKmQhcSe
 OMy0byv7g2teWGX94oSjpfMuv8XN7HhUeG4Xoxgj+Dy9r+x0+n+ZF4uRu4bb+lfU7oWB83mDSIe
 FhEnAkegD/gJ4DhNyQONF5m8nBHz7hlv5ZTicJLaXBUQDuMC+jNR5f/cfHPKa2iVwOPrZrhQgMR
 nJNArNNoF+rbun8MwR4zhFeZYeTYbGyuP6+N8Mz45ScWl5xM3YwX+UnJHO1mDK7OmSGGONh9sRb
 1t6cztmTEAGQLjIJ3EPGVaPyDrPV+M9iwSDAOPU3oReRzYf0fzpMp1cUinO+pcQNmjyZjiu+fuz
 Z0fn8ii72CvF5mtJHnAKYjYmUGKbmM+MfAhmwMR7fZnfzkJkM2tJNuOz9sVVHs/RhEAIAP2SEv6
 ILMLqP8VGooh73xk+nyw944iqPT977KXyx1ZvONhBSxq6HyslnVSeY46SXrw3zmLpZjyIoF6Dgl
 2aKXw4Wl/r9X8qX/Wig==
X-Proofpoint-GUID: G6QOa6yLXqsTUl76NowNFZE_wz0_kJGa
X-Proofpoint-ORIG-GUID: OlUUaAHVRY7LzhNC12llpUP8PaUaXwF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110053
X-Rspamd-Queue-Id: 479B5507F5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,none];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20352-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[ibm.com:s=pp1];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sidraya@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.960];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 11/05/26 3:56 am, Xiang Mei wrote:
> The smc_msg_event tracepoint class, shared by smc_tx_sendmsg and
> smc_rx_recvmsg, unconditionally dereferences smc->conn.lnk:
> 
> 	__string(name, smc->conn.lnk->ibname)
> 
> conn->lnk is only set for SMC-R; for SMC-D it is NULL. Other code on
> these paths already handles this (e.g. !conn->lnk in
> SMC_STAT_RMB_TX_SIZE_SMALL()). With the tracepoint enabled, the first
> sendmsg()/recvmsg() on an SMC-D socket crashes:
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [...]
>   RIP: 0010:strlen+0x1e/0xa0
>   Call Trace:
>    trace_event_raw_event_smc_msg_event (net/smc/smc_tracepoint.h:44)
>    smc_rx_recvmsg (net/smc/smc_rx.c:515)
>    smc_recvmsg (net/smc/af_smc.c:2859)
>    __sys_recvfrom (net/socket.c:2315)
>    __x64_sys_recvfrom (net/socket.c:2326)
>    do_syscall_64
> 
> The faulting address 0x3e0 is offsetof(struct smc_link, ibname),
> confirming the NULL ->lnk deref. Enabling the tracepoint requires
> root, but the trigger itself is unprivileged: socket(AF_SMC, ...) has
> no capability check, and SMC-D negotiation needs no admin step on
> s390 or on x86 with the loopback ISM device loaded.
> 
> Log an empty device name for SMC-D instead of dereferencing NULL.
> 
> Fixes: aff3083f10bf ("net/smc: Introduce tracepoints for tx and rx msg")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/smc/smc_tracepoint.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_tracepoint.h b/net/smc/smc_tracepoint.h
> index a9a6e3c1113a..53da84f57fd6 100644
> --- a/net/smc/smc_tracepoint.h
> +++ b/net/smc/smc_tracepoint.h
> @@ -51,7 +51,7 @@ DECLARE_EVENT_CLASS(smc_msg_event,
>  				     __field(const void *, smc)
>  				     __field(u64, net_cookie)
>  				     __field(size_t, len)
> -				     __string(name, smc->conn.lnk->ibname)
> +				     __string(name, smc->conn.lnk ? smc->conn.lnk->ibname : "")
>  		    ),
>  
>  		    TP_fast_assign(
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>

