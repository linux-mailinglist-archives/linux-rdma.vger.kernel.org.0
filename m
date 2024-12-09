Return-Path: <linux-rdma+bounces-6340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D839E987B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 15:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9856D161802
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86261B0400;
	Mon,  9 Dec 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ffAe0zv+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0D233157;
	Mon,  9 Dec 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753479; cv=none; b=hBR3qU7lD/K5LE6tyl71+oHFuoiHLTnDlnhSpX0ZKz91yieymp4Y4RvRBpg9+c/cttkUlmXfa23wL4dqpVDmdI9DMQ+T8y/ZcqqM41BCrIjjbD1HgEOXHi2uyqJ2+P++M4hun9TKQZZNDMjhkugd1u4D4kW5NMmgRWxoi4Pei9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753479; c=relaxed/simple;
	bh=0vgU4ssnE1WE7jqMAB3bzg5kwDLIj2VIEbOq/IIGnwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiNoCna6dM+GtjLXeGCgUZv72Zhe906U1JfXLBP2mguGYZEg+su+XXIxVeGslfO6FlWkwIU0nht0BM+kFSBuhW8ARuQM+pPsK7fhEnysj7CUXbd4Q2f1L3ACn09TdKxx6FVnDhliWTbjGZM5GvS9B/sjTeJFufaQBawG6RNiJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ffAe0zv+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B96lUiK001478;
	Mon, 9 Dec 2024 14:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fSsqjK
	VTcG0iqZUPgmZVVAKSbh2ltlzmXWTnnOKiYVg=; b=ffAe0zv+b/kVWFc6Q7N7XZ
	dUZb1DzyKI4XzuzVan02YXsrzZH4M9AzI3GaoYPIxUOUqtN5qrrL1O8yPfUkQZV1
	R7njAckM9mhHtQb2QtydU523pcfOq2KvOhiKwY6i1mCd7jTgHtjxTXeSPMVgKIDh
	mVyDuycF1/phKmM/Cv2SqkIJhYlnlGGx+3IuwZvK9jioHuAtx9636LKH+a650448
	7c0KXImFt4stToOjVgDUTiSLjTT6EPQOlXcMQZYRL56kVcE9XJQQK+ntN2QX67b6
	dIy1ER43qK/aQTKleYDGmBocR6ZLvqnBJoHZJhNgeQQnqS6dIIDMRC62UoLaU2Wg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq12ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 14:11:03 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9E8WjL003124;
	Mon, 9 Dec 2024 14:11:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq12uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 14:11:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9BgLki023062;
	Mon, 9 Dec 2024 14:11:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjppdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 14:11:02 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9EB0NL13632188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 14:11:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 749BE58054;
	Mon,  9 Dec 2024 14:11:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C00358045;
	Mon,  9 Dec 2024 14:10:57 +0000 (GMT)
Received: from [9.171.32.56] (unknown [9.171.32.56])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 14:10:57 +0000 (GMT)
Message-ID: <1fc33d2e-83c1-4651-b761-27188d22fba0@linux.ibm.com>
Date: Mon, 9 Dec 2024 15:10:56 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, pasic@linux.ibm.com,
        jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dust Li <dust.li@linux.alibaba.com>
References: <20241209130649.34591-1-guangguan.wang@linux.alibaba.com>
 <20241209130649.34591-3-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241209130649.34591-3-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: txrE6DO25qKPtJ-SsenbNYXCbNI5ApGE
X-Proofpoint-GUID: gsQt8RRbNuJhmkE1kw8re4K64poiDMF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090110



On 09.12.24 14:06, Guangguan Wang wrote:
> AF_INET6 is not supported for smc-r v2 client before, even if the
> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
> will fallback to tcp, especially for java applications running smc-r.
> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
> using real global ipv6 addr is still not supported yet.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>   net/smc/af_smc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 9d76e902fd77..c3f9c0457418 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1116,7 +1116,10 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
>   	ini->check_smcrv2 = true;
>   	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>   	if (!(ini->smcr_version & SMC_V2) ||
> -	    smc->clcsock->sk->sk_family != AF_INET ||
> +#if IS_ENABLED(CONFIG_IPV6)
> +	    (smc->clcsock->sk->sk_family == AF_INET6 &&
> +	     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
> +#endif
>   	    !smc_clc_ueid_count() ||
>   	    smc_find_rdma_device(smc, ini))
>   		ini->smcr_version &= ~SMC_V2;

@Guangguan, I think Halil's point is valid, and we need to verify if 
checking on saddr is sufficient before this patch is applied. i.e. what 
about one peer with ipv4 mapped ipv6 communicates with another peer with 
a real ipv6 address? Is it possible? If yes, would SMCRv2 be used? I 
still haven't thought much on this yet, but it is worth to verify. Maybe 
you already have the answer?

@Jakub, could you please give us some more time to verify the issue 
mentioned above?

Thanks,
Wenjia


