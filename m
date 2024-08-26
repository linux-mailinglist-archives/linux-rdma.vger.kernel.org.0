Return-Path: <linux-rdma+bounces-4575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7E95F97C
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 21:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353E7281985
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 19:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC3E1991CD;
	Mon, 26 Aug 2024 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CTH8YCb1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB2194138;
	Mon, 26 Aug 2024 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699689; cv=none; b=EJfmZiAy/R09UGwXmDJW5p7ZF9S8dEYpSaah+umHiW0wGUbDfPWvpwQuD1fiK5O/izKyqhd90RkjozZCkprcleWf18DzNkYV52avbi0WytxFyi2GgJ0B24OGTCcaUd9BBegYvLR+xtGwMre19r+I9Rt0AGVeVwxOFhAQqTAE48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699689; c=relaxed/simple;
	bh=KVRMcmwnX8djX0JysOwFBlfFTwFz8k+1tcH52mTbkJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AnHScC76IdIplCCpZT5fygPA/8ckrd0QvJ6lZAXCVA5w16Obfur/jz8jAlI6bWD2ckx207Oprfk3hTBVxDnilby6hcM2UcMnvCXjqn+/eygNKX68TGiKGC4Wm++SgrjVkSR2wM3/b/uH/WRGXuJ9Ls1Y5LqG1Clc0TBJ+7vWG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CTH8YCb1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QGAeJx024068;
	Mon, 26 Aug 2024 19:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	scGo/ReMtVA2P+UMCPVIplR5e4FSO0emnbV3UVR0J+g=; b=CTH8YCb1o/UqSNkM
	l8G4Dig8BUKceKdgWD0JLGb1UVpdh+NCjpXniN96JdbZTp9TA2eiiif5os+RCFTk
	vw8yrHjB6KS8qzcqKev9mYpO5AJFCEKBYirskePDuWkyMFu1ABQOpS6auSRkl4Wd
	y3RseIacW7bArX6/nX5cfNjQLbRoeLFGBEsfJYJAwwM3z5g/Cxa3yUwl09Pxt5JT
	Tf4axSz1mLgTy9UkMg4qf/bYcfdNCziEf7oujhwQSLVqeG+fYEn7C1VAkxlTO9PJ
	hi4TMFPi0eRvTgkHMNzN45snPse6v09pT6UVDFL1QYF3uGO4DOgTLXBIa9K6s6Hg
	WRuJ3Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417g51gce0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 19:14:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47QJEfXT008862;
	Mon, 26 Aug 2024 19:14:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417g51gcdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 19:14:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47QGPK84021761;
	Mon, 26 Aug 2024 19:14:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 417suu7pgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 19:14:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47QJEauk47972820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 19:14:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91D4520043;
	Mon, 26 Aug 2024 19:14:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7D7920040;
	Mon, 26 Aug 2024 19:14:35 +0000 (GMT)
Received: from [9.171.82.113] (unknown [9.171.82.113])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Aug 2024 19:14:35 +0000 (GMT)
Message-ID: <8a829adf-2833-4b4d-a690-5fff52967e35@linux.ibm.com>
Date: Mon, 26 Aug 2024 21:14:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: add sysctl for smc_limit_hs
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
 <abd79f44-aed2-4e01-a7f8-7d806f5bc755@linux.ibm.com>
 <905874a4-c000-4845-8fac-3fc4b79f43fd@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <905874a4-c000-4845-8fac-3fc4b79f43fd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fjyb7kQaI7tcJxiVYSI0ZImx0Wf_9Ygm
X-Proofpoint-GUID: TQ_Or8n-UL1faEBG-rlgFh8V9Qmgy8k4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_14,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408260145



On 26/08/2024 05:02, D. Wythe wrote:
> 
> 
> On 8/21/24 4:03 PM, Jan Karcher wrote:
>>
>>
>> On 21/08/2024 04:36, D. Wythe wrote:
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake 
>>> workqueue congested"),
>>> we introduce a mechanism to put constraint on SMC connections visit
>>> according to the pressure of SMC handshake process.
>>>
>>> At that time, we believed that controlling the feature through netlink
>>> was sufficient. However, most people have realized now that netlink is
>>> not convenient in container scenarios, and sysctl is a more suitable
>>> approach.
>>
>> Hi D.
>>
>> thanks for your contribution.
>> What i wonder is should we prefer the use of netlink > sysctl or not?
>> To the upstream maintainers: Is there a prefernce for the net tree?
>>
>> My impression from past discussions is that netlink should be chosen 
>> over sysctl.
>> If so, why is it inconvenient to use netlink in containers?
>> Can this be changed?
>>
>> Other then the general discussion the changhes look good to me.
>>
>> Reviewed-by: Jan Karcher <jaka@linux.ibm.com>
>>
> 
> Hi Jan,
> 
> I noticed that there have been relevant discussions before, perhaps this 
> will be helpful to you.
> 
> Link: 
> https://lore.kernel.org/netdev/20220224020253.GF5443@linux.alibaba.com

Hi D.,

thanks for the pointer! If i understood Jakub correct it should be 
possible to add a yaml definition for the SMC netlink anbd modify it vie 
a small program.

That said I'm not to familia with the use of them in containers. So if 
you say this is the better solution and everyone is fine with yet 
another sysctl it is fine by me.

Thanks
- Jan

> 
> 
> Best wishes,
> D. Wythe
> 
> 
>>
>>>
>>> In addition, since commit 462791bbfa35 ("net/smc: add sysctl 
>>> interface for SMC")
>>> had introcuded smc_sysctl_net_init(), it is reasonable for us to
>>> initialize limit_smc_hs in it instead of initializing it in
>>> smc_pnet_net_int().
>>>
>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>> ---
>>> v1 -> v2:
>>>
>>> Modified the description in the commit and removed the incorrect
>>> spelling.
>>>
>>>   net/smc/smc_pnet.c   |  3 ---
>>>   net/smc/smc_sysctl.c | 11 +++++++++++
>>>   2 files changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>>> index 2adb92b..1dd3623 100644
>>> --- a/net/smc/smc_pnet.c
>>> +++ b/net/smc/smc_pnet.c
>>> @@ -887,9 +887,6 @@ int smc_pnet_net_init(struct net *net)
>>>         smc_pnet_create_pnetids_list(net);
>>>   -    /* disable handshake limitation by default */
>>> -    net->smc.limit_smc_hs = 0;
>>> -
>>>       return 0;
>>>   }
>>>   diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
>>> index 13f2bc0..2fab645 100644
>>> --- a/net/smc/smc_sysctl.c
>>> +++ b/net/smc/smc_sysctl.c
>>> @@ -90,6 +90,15 @@
>>>           .extra1        = &conns_per_lgr_min,
>>>           .extra2        = &conns_per_lgr_max,
>>>       },
>>> +    {
>>> +        .procname    = "limit_smc_hs",
>>> +        .data        = &init_net.smc.limit_smc_hs,
>>> +        .maxlen        = sizeof(int),
>>> +        .mode        = 0644,
>>> +        .proc_handler    = proc_dointvec_minmax,
>>> +        .extra1        = SYSCTL_ZERO,
>>> +        .extra2        = SYSCTL_ONE,
>>> +    },
>>>   };
>>>     int __net_init smc_sysctl_net_init(struct net *net)
>>> @@ -121,6 +130,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
>>>       WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>>>       net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>>>       net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
>>> +    /* disable handshake limitation by default */
>>> +    net->smc.limit_smc_hs = 0;
>>>         return 0;
> 

