Return-Path: <linux-rdma+bounces-4450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A117B9596AA
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 10:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F53B20B66
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE2519ABAF;
	Wed, 21 Aug 2024 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aU3WO78p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21951199FD4;
	Wed, 21 Aug 2024 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227450; cv=none; b=qTW7vgR7wAEi4VPteCA2StbcRr00qNk7zgtNfash9to6KpJw9YM9ixnfyVpO8/TgVEK1zpzOfAddqI6A+ZznD/9ZcK4DJuQ+thqJyXAm9KjgupsRxbhc6Y9Yj6O8bGhH8iAO5ThwzpacJMGND9I+rgSUje9h4ojjiAOis+0iUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227450; c=relaxed/simple;
	bh=qgW83UIoQ7pWyW15PTf3qHwr2FjmRlWXMov5IjtgcRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u14MOOJahI77UZEmCE7lLVFcnuXEbTeXN+UDrZSv6zLclXhRk6H/8dcwMHe2YFcXKM+b3iBdLVDGt7DOEmIJ5ttwNOKGJYK0ToSL3Ddms/y6ariXreCnNKjH6qre8quqCcUq1pYmzOExyHN38TnXGFjDB3CrF+1Sm59SMgWGPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aU3WO78p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L46X44005334;
	Wed, 21 Aug 2024 08:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=F
	aPU/c4SEBSQEsYQziRQKRtVbtDPX4blFqUGQiqdOJo=; b=aU3WO78pe2tRDeRCj
	7i5LKER2623OaRIs+r9d4zvndOH4DFvFORTwno0nb49Ejq5/Lvjmkjzi/B4ES9IX
	bEjaKE+NluXoU96AgqSa+N/nm7CLhZR8w3klgE3F5TaJEjjpEdVQLeTzTXXs84Q5
	E8+RX3AGfeA/NYnxlE0bsGPHITa0pvZkSOigeeBj6/MrnS0v+3JDftIu3glQOnaH
	WWkGuVCgE1V1XaDF0fIZ7tcXV3On1K0bTQaDQJ2fhkReNvXaVZMmBl+UFNgJBqx+
	9hUmU7N79c+yS3d5kbtPhqOwnFG4nIpc0IWSMkWWQSCykcV7YM6qEoSX/JxcdY9g
	YSDJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5snqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 08:04:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L842OU006252;
	Wed, 21 Aug 2024 08:04:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5snpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 08:04:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4UREm019105;
	Wed, 21 Aug 2024 08:03:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376pxsnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 08:03:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L83pwV51970446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 08:03:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 696ED20079;
	Wed, 21 Aug 2024 08:03:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E252007A;
	Wed, 21 Aug 2024 08:03:50 +0000 (GMT)
Received: from [9.179.3.132] (unknown [9.179.3.132])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 08:03:50 +0000 (GMT)
Message-ID: <abd79f44-aed2-4e01-a7f8-7d806f5bc755@linux.ibm.com>
Date: Wed, 21 Aug 2024 10:03:49 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: add sysctl for smc_limit_hs
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LnusoTT6XFEOP9ueUBXVua-2Pf7ntffU
X-Proofpoint-GUID: OAUrfRP1cDb1kkq_nu-U63WpPDVtuNjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210057



On 21/08/2024 04:36, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake workqueue congested"),
> we introduce a mechanism to put constraint on SMC connections visit
> according to the pressure of SMC handshake process.
> 
> At that time, we believed that controlling the feature through netlink
> was sufficient. However, most people have realized now that netlink is
> not convenient in container scenarios, and sysctl is a more suitable
> approach.

Hi D.

thanks for your contribution.
What i wonder is should we prefer the use of netlink > sysctl or not?
To the upstream maintainers: Is there a prefernce for the net tree?

My impression from past discussions is that netlink should be chosen 
over sysctl.
If so, why is it inconvenient to use netlink in containers?
Can this be changed?

Other then the general discussion the changhes look good to me.

Reviewed-by: Jan Karcher <jaka@linux.ibm.com>


> 
> In addition, since commit 462791bbfa35 ("net/smc: add sysctl interface for SMC")
> had introcuded smc_sysctl_net_init(), it is reasonable for us to
> initialize limit_smc_hs in it instead of initializing it in
> smc_pnet_net_int().
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
> v1 -> v2:
> 
> Modified the description in the commit and removed the incorrect
> spelling.
> 
>   net/smc/smc_pnet.c   |  3 ---
>   net/smc/smc_sysctl.c | 11 +++++++++++
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 2adb92b..1dd3623 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -887,9 +887,6 @@ int smc_pnet_net_init(struct net *net)
>   
>   	smc_pnet_create_pnetids_list(net);
>   
> -	/* disable handshake limitation by default */
> -	net->smc.limit_smc_hs = 0;
> -
>   	return 0;
>   }
>   
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index 13f2bc0..2fab645 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -90,6 +90,15 @@
>   		.extra1		= &conns_per_lgr_min,
>   		.extra2		= &conns_per_lgr_max,
>   	},
> +	{
> +		.procname	= "limit_smc_hs",
> +		.data		= &init_net.smc.limit_smc_hs,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>   };
>   
>   int __net_init smc_sysctl_net_init(struct net *net)
> @@ -121,6 +130,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
>   	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>   	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>   	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
> +	/* disable handshake limitation by default */
> +	net->smc.limit_smc_hs = 0;
>   
>   	return 0;
>   

