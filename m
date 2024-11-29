Return-Path: <linux-rdma+bounces-6163-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE89DEB64
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 18:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F52163365
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31C3155325;
	Fri, 29 Nov 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L5OCGWnu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AEF3224;
	Fri, 29 Nov 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899657; cv=none; b=rxNRZX70HLwPFrWrsaN3Swcq9czCJqMM8TDYn1YbKRV+tF0+CRtlSAcISVe6zxTLiRYmV0YM4T9ZyXMIr25g6zvqqUC6TD01jsgKmnIM0BxHRUT5ZrXFoNs6x1yeU+oae3tPCjsMurA/Ez027VpFDU57LMRZxs+KJblL8F0vcPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899657; c=relaxed/simple;
	bh=ZmvivWaCYAoHDICvb1YhX1qC/jOvPZlP0Lm+cWTHvv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXPf+4JIgwJK4i5k8p1RnENDjIF7cvNhBTbAtYbhR9/3mxsGQzMjtbLN5gn0xnmCYGrW+iFS0khxzqXpwuSacGqbMQP2W6l1Nt6lMqZwod64Y1HTiVnJBvEIZDFmRFQGGYZhblwS0Hl95267iv5ooPA/MuqRGsYn4N5J1fsduPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L5OCGWnu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATGwVw3030776;
	Fri, 29 Nov 2024 17:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MnxY28
	/1YNNvqOk/vkgPgYqjE6DiQ34K7ujp0qJySF4=; b=L5OCGWnugkRJ8H2riKO+uT
	8NeQjuy7qlowsXZ4ZI6ptQHPOh7aE1ngFdZPKXAy4QE6kwgIuQ/Mw/iGCIyiLhNX
	k5r+doQ2VPsQG83bCcZrLLh63B9waobUCRiWbwKFAxuIVkoff6yLVI8np4mFEhOn
	nuePSAH9aeplHr05UhEHIlOKTljyNx0mh4d41r68m+Gs5dvOPoEid/rW81OSLM/x
	EWaVCtWSYwgC8J1vfynax9N2Q/7iwsdcaPN0GB/aZUaDEdlv8jVI3pAE5rTKY+oK
	JyAfpTjsy8RpcxcUOJGBP+LabjXzo1zCAGtGHdyDksVWLvWPVtWbIa7EdtBKbuCg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436upa5hc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 17:00:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ATGtlH1011203;
	Fri, 29 Nov 2024 17:00:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436upa5hbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 17:00:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATH0dDD011922;
	Fri, 29 Nov 2024 17:00:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43672gxs8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 17:00:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ATH0lMl19792512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 17:00:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C672E58054;
	Fri, 29 Nov 2024 17:00:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24ADE5805A;
	Fri, 29 Nov 2024 17:00:45 +0000 (GMT)
Received: from [9.171.48.56] (unknown [9.171.48.56])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Nov 2024 17:00:44 +0000 (GMT)
Message-ID: <ce432637-e4ca-4f0c-b123-4699c0c062a0@linux.ibm.com>
Date: Fri, 29 Nov 2024 18:00:44 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net/smc: fix LGR and link use-after-free issue
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
        kgraul@linux.ibm.com, hwippel@linux.ibm.com,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241127133014.100509-1-guwen@linux.alibaba.com>
 <20241127133014.100509-3-guwen@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241127133014.100509-3-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wp0mHL2wzUO8NdNf_LYsgVKVQVHQD2q1
X-Proofpoint-GUID: 9qQzr8Igid_U2NwibEu-uBdemqq0NOEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 mlxlogscore=809 phishscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290137



On 27.11.24 14:30, Wen Gu wrote:
> We encountered a LGR/link use-after-free issue, which manifested as
> the LGR/link refcnt reaching 0 early and entering the clear process,
> making resource access unsafe.
> 
>   refcount_t: addition on 0; use-after-free.
>   WARNING: CPU: 14 PID: 107447 at lib/refcount.c:25 refcount_warn_saturate+0x9c/0x140
>   Workqueue: events smc_lgr_terminate_work [smc]
>   Call trace:
>    refcount_warn_saturate+0x9c/0x140
>    __smc_lgr_terminate.part.45+0x2a8/0x370 [smc]
>    smc_lgr_terminate_work+0x28/0x30 [smc]
>    process_one_work+0x1b8/0x420
>    worker_thread+0x158/0x510
>    kthread+0x114/0x118
> 
> or
> 
>   refcount_t: underflow; use-after-free.
>   WARNING: CPU: 6 PID: 93140 at lib/refcount.c:28 refcount_warn_saturate+0xf0/0x140
>   Workqueue: smc_hs_wq smc_listen_work [smc]
>   Call trace:
>    refcount_warn_saturate+0xf0/0x140
>    smcr_link_put+0x1cc/0x1d8 [smc]
>    smc_conn_free+0x110/0x1b0 [smc]
>    smc_conn_abort+0x50/0x60 [smc]
>    smc_listen_find_device+0x75c/0x790 [smc]
>    smc_listen_work+0x368/0x8a0 [smc]
>    process_one_work+0x1b8/0x420
>    worker_thread+0x158/0x510
>    kthread+0x114/0x118
> 
> It is caused by repeated release of LGR/link refcnt. One suspect is that
> smc_conn_free() is called repeatedly because some smc_conn_free() from
> server listening path are not protected by sock lock.
> 
> e.g.
> 
> Calls under socklock        | smc_listen_work
> -------------------------------------------------------
> lock_sock(sk)               | smc_conn_abort
> smc_conn_free               | \- smc_conn_free
> \- smcr_link_put            |    \- smcr_link_put (duplicated)
> release_sock(sk)
> 
> So here add sock lock protection in smc_listen_work() path, making it
> exclusive with other connection operations.
> 
> Fixes: 3b2dec2603d5 ("net/smc: restructure client and server code in af_smc")
> Co-developed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Co-developed-by: Kai <KaiShen@linux.alibaba.com>
> Signed-off-by: Kai <KaiShen@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/af_smc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index ed6d4d520bc7..9e6c69d18581 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1900,6 +1900,7 @@ static void smc_listen_out(struct smc_sock *new_smc)
>   	if (tcp_sk(new_smc->clcsock->sk)->syn_smc)
>   		atomic_dec(&lsmc->queued_smc_hs);
>   
> +	release_sock(newsmcsk); /* lock in smc_listen_work() */
>   	if (lsmc->sk.sk_state == SMC_LISTEN) {
>   		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>   		smc_accept_enqueue(&lsmc->sk, newsmcsk);
> @@ -2421,6 +2422,7 @@ static void smc_listen_work(struct work_struct *work)
>   	u8 accept_version;
>   	int rc = 0;
>   
> +	lock_sock(&new_smc->sk); /* release in smc_listen_out() */
>   	if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
>   		return smc_listen_out_err(new_smc);
>   

It looked much clearer than the last version to me! Thank you for fixing it!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia

