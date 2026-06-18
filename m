Return-Path: <linux-rdma+bounces-22347-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3uA3NkKPM2p4DQYAu9opvQ
	(envelope-from <linux-rdma+bounces-22347-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 08:25:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35869DD56
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 08:25:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=M9ESVOjq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22347-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22347-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28E3D302DA2D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A5331A48;
	Thu, 18 Jun 2026 06:24:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57A32E141;
	Thu, 18 Jun 2026 06:24:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763893; cv=none; b=Tp3mgwUSsBacikv1FUOra0xehc3CGE8RnHlriFY72W2wCnH9Jm0zdslb/dGjut6AEHH0UrgzOrQI5AgoDFHSANvR7kk8XmCYg7LfY6pIu6B+TZVM5qe0gGdEx2k7dFr6OCxV/NXgHQBTvDJgvLvF7in9oQM/mGpUbaWLpR6mH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763893; c=relaxed/simple;
	bh=fU92GMEy94puy6aftgC8ArZCNvwPYf2OXVYqyMr3tXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohhbM4r1Sl+Zxx0D7FrzLAVdBRu37kvgDwCc5SlCWX0BmuZysmHhf/v8W8VSL+s4rxA0f2xEFX0VEVQXctt6417wlg00iEi88c+rWv16iiC6OXAayUIOxZ0V7pQvCw6Rv+UnSPpZGKWVDsaKvCa6MI1b8VFxlRofSasNIwdqtK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M9ESVOjq; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmDQp1082472;
	Thu, 18 Jun 2026 06:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w5iCOT
	LeFlPziDmdzdpbGIsNU4Hrv3HjrGqIGTNX7SI=; b=M9ESVOjqAKXAp3JH2sJGzY
	xNmBvmECtC8el80aqjyxbVVxKRLOV+1kDJ/aM+aRJX5e7XUuExI/9rYMofrd9sJ0
	mAO1L1o17+MDNPL79gbSyU1M11twscVrsuyKWEPfSeTSjNNLg8RLYAVbvD6eEX6I
	qGQ99kj8fMEajr6wgdG2fP7ZYkm5sILC1sld7h0jVqInpQ98BW60WgyF4o+e9xr0
	HfQff2WwAbVbabdjeVJONb4ongP9dPma7xtPtNsOxgKYDVwtYQfMmhtJ6K1VX/rX
	tsuFC3y2st+B4Qce64vAPL4BBEBoGvUo7OCI8Bl8VGwTtRfaGb8uXdaXaGyX+zLQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvxnxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:24:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I64a7K019496;
	Thu, 18 Jun 2026 06:24:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722bjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:24:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I6OflB7078428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 06:24:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7631A58059;
	Thu, 18 Jun 2026 06:24:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E99B58055;
	Thu, 18 Jun 2026 06:24:35 +0000 (GMT)
Received: from [9.123.3.51] (unknown [9.123.3.51])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 06:24:34 +0000 (GMT)
Message-ID: <f7e36176-d00a-4471-94ed-d385e579b43d@linux.ibm.com>
Date: Thu, 18 Jun 2026 11:54:33 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: avoid recursive sk_callback_lock in listen
 data_ready
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
        "D. Wythe"
 <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Simon Horman <horms@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX2L2sHyTFkNXz
 cgPpmSml3WVnfQWmx4c6t969+S8JCdEqIDVcEgwOebr71VkfV0LfLZtaA4P2qjPt6M7AuTHXzSA
 kPIO9hQExNDjWjBe/Lb/nANpqlotuYg=
X-Proofpoint-GUID: liwEqstN0ZKnBz11G2-EcQm106fEI4_N
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a338f2c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=PYtvbb3SF9k8UUea3okA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: t97zkeMdGAsHZSG3QM5SYZQEAHZ7Pggh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX6Q7swimiwksD
 Yi62MZ4Zyv+WsZ8m+Il8ACg04+ric+8VjZ921Fc8JojWtRj1HSnQsFiapwHUxAvsGfoQo7UWw4J
 YGhSwnzErLM4sYl0nrcDVn72SNMvVnSw13+FdPech3XrbV6Pz5gLFBJ+X62OtOdkTybOk9I6QxV
 Tu5FIoepLKhw0HN7L/gLYBIelxOLd3/JUId5hv5GE3gcF14yLXC/zvXbE1kpW5neC8aWo3DN4Dd
 Ca4+JsrYL5EIkJVkq8pSl//f9PicWzFaIwKGPlWQNUI89+tgl/ZCtpzd6jARb6sxab3As+l9ENw
 hIO+g+jxSAVVMcOju7FoXWEJVM0knEVWn2hRExCjOUriTX/6lglSah3Pg84oH/KtePNmvvjeAWq
 uLMc0xFSTZ5uIQwSpha14pv/T+gaNFuF7MD+vRsGne0cciNTs/dqYiktdQdAXXhhmcJSo43FC/s
 1scEi/JCS9KEBMy6ESA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22347-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,seu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B35869DD56



On 17/06/26 8:58 pm, Runyu Xiao wrote:
> smc_listen() installs smc_clcsock_data_ready() as the underlying TCP
> listen socket's sk_data_ready callback.  smc_clcsock_data_ready() then
> immediately takes sk_callback_lock before looking up the SMC listener and
> queuing smc_tcp_listen_work().
> 
> That is unsafe once the TCP listen socket is leaving TCP_LISTEN.  The TCP
> close/flush path can run the installed sk_data_ready callback with
> sk_callback_lock already held, so entering smc_clcsock_data_ready() again
> tries to take the same rwlock recursively in the same thread.  The nvmet

Could you provide me the exact call stack showing recursive lock? Also
help me with the nvmet commit details.

> TCP listener had to make the same state check before taking
> sk_callback_lock for this reason.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> The grounded PoC kept the SMC listen callback installation path:
> 
>   smc_listen()
>   smc_clcsock_replace_cb()
>   sk_data_ready = smc_clcsock_data_ready()
> 
> It then modeled the close/flush carrier that invokes the installed
> sk_data_ready callback while sk_callback_lock is already held.  Lockdep
> reported the same-thread recursive acquisition:
> 
>   WARNING: possible recursive locking detected
>   smc_clcsock_data_ready+0xa/0x4d [vuln_msv]
>   smc_close_flush_work+0x1f/0x30 [vuln_msv]
>   *** DEADLOCK ***
> 
> Return before taking sk_callback_lock when the underlying TCP socket is no
> longer in TCP_LISTEN.  In that state there is no listen accept work to
> queue for SMC, and avoiding the callback lock mirrors the fix used by the
> TCP nvmet listener.
> 
> Fixes: 0558226cebee ("net/smc: Fix slab-out-of-bounds issue in fallback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  net/smc/af_smc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 6421c2e1c84d..1af4e3c333ff 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2631,6 +2631,9 @@ static void smc_clcsock_data_ready(struct sock *listen_clcsock)
>  {
>  	struct smc_sock *lsmc;
>  
> +	if (READ_ONCE(listen_clcsock->sk_state) != TCP_LISTEN)

Is *TCP_LISTEN* check sufficient? What about *TCP_SYN_RECV* or
*TCP_ESTABLISHED*?

> +		return;
> +
>  	read_lock_bh(&listen_clcsock->sk_callback_lock);
>  	lsmc = smc_clcsock_user_data(listen_clcsock);
>  	if (!lsmc)


