Return-Path: <linux-rdma+bounces-6075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903179D61A4
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 16:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F5F282D72
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7F91DE2BD;
	Fri, 22 Nov 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XIlHG4uH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95B537171;
	Fri, 22 Nov 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291007; cv=none; b=rma75NXLPmXsxzXfDU12WPP1aPwASV41bxBDxVZTHRld7iSCfJAuX5zYtNcpPi7qXA+ffyf4YY5a7Z81hXIPECxI2xE+vH8JG0ZxSb3IL8dWpPvpXSQyUFTuMwu4cKZ3xq5GIpqyLf1Bhcdef4ekl6qo5/SEMlXZdRs16yuIhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291007; c=relaxed/simple;
	bh=EHw2G0Pd/UNxCwsZJdFz6NHtFdWg9CVQuLCqWmE2GXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=es78qCfeth/qC+473o8BG8auw/6L9AXd5HuCifwGbSgYFwInHoW6QKW+F4Z2EzxjZfPGMwtGZi7jkKtLpANokJqvg61yVZnhpaw2w5oWg3ihxX/DhtC0W82D+6lbubcdVh/Mfj/w6RPwVk6CWP3ABM5KyxYcpevUboXm96rwHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XIlHG4uH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCaj04009210;
	Fri, 22 Nov 2024 15:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c+e/lj
	WQvX8wgyFeG3f1oC7z8bgSGGRKYwRnjF3j/+0=; b=XIlHG4uH2xPgYRPNw/G+57
	vSbaIW1dlbUjsy7DVYKfmKc+OFacV4RJvuSuMxzNrdiBXrVGtMaZVNfU6FUiod3l
	6o00CqwLA8ep9+eXPZtUvYFJxAgNziakfmbihj2Q+qTLkvseIQ7UYVetKtFbCbCX
	XGpKvI1pFtbcl6lR7N/h8Puf7HZdeWb55WtjhPMvmUMcJw+gJydarNb0NMkB3eak
	O32SpL5VhVS1HRFwdwDIsbXHOdDIZjRvIZEjHlrKB2Ay0nCfAkJXSsc5NixZKThk
	m1XVoLncBmNNKdOKqoofOL0xwOB94aMtQQkWsyuvjCe0quz2/Tpjnyj8eHVT/SYg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 432fw24741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 15:56:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AMFlgID004804;
	Fri, 22 Nov 2024 15:56:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 432fw2473w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 15:56:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMAYsWV021792;
	Fri, 22 Nov 2024 15:56:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6qn3d5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 15:56:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AMFuckU50069890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 15:56:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCC4C58058;
	Fri, 22 Nov 2024 15:56:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6622E5805D;
	Fri, 22 Nov 2024 15:56:36 +0000 (GMT)
Received: from [9.171.76.132] (unknown [9.171.76.132])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 15:56:36 +0000 (GMT)
Message-ID: <4c65cb7a-fcf3-4f24-9aaf-f270033db5db@linux.ibm.com>
Date: Fri, 22 Nov 2024 16:56:35 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net/smc: fix LGR and link use-after-free issue
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
 <20241122071630.63707-3-guwen@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241122071630.63707-3-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nakpSv9eAlAYPGjUMpV2GXecUl_Ao7sn
X-Proofpoint-ORIG-GUID: -48pdM7AmCNb42iTpaXdxakSO8ajWG4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=989
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220130



On 22.11.24 08:16, Wen Gu wrote:
> We encountered a LGR/link use-after-free issue, which manifested as
> the LGR/link refcnt reaching 0 early and entering the clear process,
> making resource access unsafe.
>

How did you make sure that the refcount mentioned in the warning are the 
LGR/link refcnt, not &sk->sk_refcnt?

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
> smc_conn_free() is called repeatedly because some smc_conn_free() are not
> protected by sock lock.
> 
> Calls under socklock        | Calls not under socklock
> -------------------------------------------------------
> lock_sock(sk)               | smc_conn_abort
> smc_conn_free               | \- smc_conn_free
> \- smcr_link_put            |    \- smcr_link_put (duplicated)
> release_sock(sk)
> 
> So make sure smc_conn_free() is called under the sock lock.
> 

If I understand correctly, the fix could only solve a part of the 
problem, i.e. what the second call trace reported, right?

> Fixes: 8cf3f3e42374 ("net/smc: use helper smc_conn_abort() in listen processing")
> Co-developed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Co-developed-by: Kai <KaiShen@linux.alibaba.com>
> Signed-off-by: Kai <KaiShen@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/af_smc.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index ed6d4d520bc7..e0a7a0151b11 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -973,7 +973,8 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
>   	return smc_connect_fallback(smc, reason_code);
>   }
>   
> -static void smc_conn_abort(struct smc_sock *smc, int local_first)
> +static void __smc_conn_abort(struct smc_sock *smc, int local_first,
> +			     bool locked)
>   {
>   	struct smc_connection *conn = &smc->conn;
>   	struct smc_link_group *lgr = conn->lgr;
> @@ -982,11 +983,27 @@ static void smc_conn_abort(struct smc_sock *smc, int local_first)
>   	if (smc_conn_lgr_valid(conn))
>   		lgr_valid = true;
>   
> -	smc_conn_free(conn);
> +	if (!locked) {
> +		lock_sock(&smc->sk);
> +		smc_conn_free(conn);
> +		release_sock(&smc->sk);
> +	} else {
> +		smc_conn_free(conn);
> +	}
>   	if (local_first && lgr_valid)
>   		smc_lgr_cleanup_early(lgr);
>   }
>   
> +static void smc_conn_abort(struct smc_sock *smc, int local_first)
> +{
> +	__smc_conn_abort(smc, local_first, false);
> +}
> +
> +static void smc_conn_abort_locked(struct smc_sock *smc, int local_first)
> +{
> +	__smc_conn_abort(smc, local_first, true);
> +}
> +
>   /* check if there is a rdma device available for this connection. */
>   /* called for connect and listen */
>   static int smc_find_rdma_device(struct smc_sock *smc, struct smc_init_info *ini)
> @@ -1352,7 +1369,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
>   
>   	return 0;
>   connect_abort:
> -	smc_conn_abort(smc, ini->first_contact_local);
> +	smc_conn_abort_locked(smc, ini->first_contact_local);
>   	mutex_unlock(&smc_client_lgr_pending);
>   	smc->connect_nonblock = 0;
>   
> @@ -1454,7 +1471,7 @@ static int smc_connect_ism(struct smc_sock *smc,
>   
>   	return 0;
>   connect_abort:
> -	smc_conn_abort(smc, ini->first_contact_local);
> +	smc_conn_abort_locked(smc, ini->first_contact_local);
>   	mutex_unlock(&smc_server_lgr_pending);
>   	smc->connect_nonblock = 0;
>   

Why is smc_conn_abort_locked() only necessary for the smc_connect_work, 
not for the smc_listen_work?

Thanks,
Wenjia

