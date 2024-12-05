Return-Path: <linux-rdma+bounces-6271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9C9E51EC
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 11:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8EB18823A3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BBD1D5CE3;
	Thu,  5 Dec 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FYMXDpju"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882191DF978;
	Thu,  5 Dec 2024 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393800; cv=none; b=SFeg1u2V/N4fnk3lL/4LW95YmSEwOQgYLHlxrNNzET+XY9TcKx28ozsz80Qizm7pcUrqqRFxReR90PhCI28Mda9HtZrCuWa3i3gx8vPQuKeTGx8V/Ps8pRE4mYqUbUx4+qpDsJDZU4N0x0+489GKUsQgrWck0ecZZukJtFXrXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393800; c=relaxed/simple;
	bh=wC9F39bP9E/IxiveXkv6KlGdl0rMiFxlzZqfFDmCgMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkM4dsdytRYTXgkjcFeecKDDjRJgFvuNFtsxyHnG44s7RjKf6XfhIQ4vaX0BPCuz6DsBtLT4bPCfM/6/Z9MHQHsjmghnXmymbTcYSSxCf+7MYmoJ2cRgVx+ePDJFcXZrqduVMBx6bzcI3BiDSctZsazkv4GNfyE0faQ7UsWUrjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FYMXDpju; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B560M2G030933;
	Thu, 5 Dec 2024 10:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QKs+Qn
	LHuxwEtIzM5BEVHWjYZXhC7adgsN4wg51HcZI=; b=FYMXDpjuh/PUor4fHDn9MS
	3BWAMapSaWRz07jbNEsrlvJzDxAgYCwzM4D5iy9XbVkXORiQBgy/r4gSxEz5aUzD
	aSGeGdxaT3vBHb7egVZWFNWswzNskbmb3hL/yZ72uEWRZGtQkw0StlD6TjYynQlB
	ig7EfjS5Ue80Rbwsg4aCnUhkUoQGP6nFXyOAzVRqg5r7CQbx8cQXKwJkJw9HqcRL
	7hKEAmNuzgRDS0LGJ3fdBgicebLHi7Kp59r00hRJvnlUOF/jQurrYRiqvHjiL8QB
	iO3zcHAurjKN0VcrkbtjRyPi3D6JkfnQxKYZR3U9FVw6JRNgfXS1Rzx+JtmtrEEw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb15xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 10:16:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B5A4oFF017632;
	Thu, 5 Dec 2024 10:16:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb15x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 10:16:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B59fe5D005226;
	Thu, 5 Dec 2024 10:16:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxr2g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 10:16:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B5AGVkd15860244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 10:16:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D6A458063;
	Thu,  5 Dec 2024 10:16:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B14005806B;
	Thu,  5 Dec 2024 10:16:28 +0000 (GMT)
Received: from [9.152.224.33] (unknown [9.152.224.33])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Dec 2024 10:16:28 +0000 (GMT)
Message-ID: <894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
Date: Thu, 5 Dec 2024 11:16:27 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dust Li <dust.li@linux.alibaba.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
 <20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cS0wI3rwYu2q3GSM4Hzi_SBuKA_9w6HV
X-Proofpoint-GUID: BYDpJsiIgdIGgbkJiXMYvyxooeArGL7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=843 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050070



On 02.12.24 13:52, Guangguan Wang wrote:
> AF_INET6 is not supported for smc-r v2 client before, event if the
%s/event/even/g

> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
> will fallback to tcp, especially for java applications running smc-r.
> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
> using real global ipv6 addr is still not supported yet.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/af_smc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 9d76e902fd77..5b13dd759766 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
>   	ini->check_smcrv2 = true;
>   	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>   	if (!(ini->smcr_version & SMC_V2) ||
> +#if IS_ENABLED(CONFIG_IPV6)
> +	    (smc->clcsock->sk->sk_family != AF_INET &&
> +	     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
I think here you want to say !(smc->clcsock->sk->sk_family == AF_INET && 
ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)), right? If it 
is, the negativ form of the logical operation (a&&b) is (!a)||(!b), i.e. 
here should be:
（smc->clcsock->sk->sk_family != AF_INET）|| 
（!ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)）

> +#else
>   	    smc->clcsock->sk->sk_family != AF_INET ||
> +#endif
>   	    !smc_clc_ueid_count() ||
>   	    smc_find_rdma_device(smc, ini))
>   		ini->smcr_version &= ~SMC_V2;


