Return-Path: <linux-rdma+bounces-7624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DC4A2EAE7
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AA3162BBB
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4091B414F;
	Mon, 10 Feb 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mE9SnCYw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6A619CC33;
	Mon, 10 Feb 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186227; cv=none; b=oAF63MIB0avXJ3HO7SsJlXq2OArJnOtPCClEinYlmj9VG1csUCFdCdzH2heTvpr8w7xh7fc/AtTqhsWW7dATpG2pKDoKeQAobFH13Ce5mKlVL+lQSdn/JQuBzaIDY8pcLcTv+f7a7Ko6Xvc/nneBWsWFIipjlr32N+myAzHJidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186227; c=relaxed/simple;
	bh=mSkiGXTqHGYYLjplMNYod7sGEW6e2weQZ7cjuOsZaz4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f4emNCJ/lSaWLys9kpzF1upE2OyrSJmW1cTN/kIBJfVpYaoahp2sEB2Mvc9J1dfcKOTpm5WUwwxL8mv7egDDWNWvLIDpitiiOSCFrpJGimX0Uhlquw+l42ISRvuvZnFDqYd0q8KwymLen0ukCf8AeZOhECTsR/pLtSjlazR/aPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mE9SnCYw; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739186219; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=dmcnIETOkRmcLc2k59ZJrtg3E4RjzRzuJfuWKk05UZg=;
	b=mE9SnCYwJRHxiEBu9mJNa6oBcFz+IoIFaDRytYWlITj1aAxOLGj4+gfGs4TZVQkmazzO0Zxl0dQylqlJ0kYDJLGqmqGzloAR6Z9hoVPIGl4WquKb7zVyrbo48xRlZuvTS3AEhEFPlnZ6xyxo8LedbLkOqVsdx+w4hJ4GHXOoxpQ=
Received: from 30.221.98.157(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WPAl8CS_1739186218 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Feb 2025 19:16:59 +0800
Message-ID: <4339aaa1-f2aa-4454-b5b1-6ffb6415f484@linux.alibaba.com>
Date: Mon, 10 Feb 2025 19:16:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
 <1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
 <20250107203218.5787acb4.pasic@linux.ibm.com>
 <908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
 <20250109040429.350fdd60.pasic@linux.ibm.com>
 <b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
 <20250114130747.77a56d9a.pasic@linux.ibm.com>
 <3dc68650-904c-4a1d-adc4-172e771f640c@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <3dc68650-904c-4a1d-adc4-172e771f640c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/1/15 19:53, Guangguan Wang wrote:
> 
> 
> On 2025/1/14 20:07, Halil Pasic wrote:
>> On Fri, 10 Jan 2025 13:43:44 +0800
>> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
>>
>>>> I think I showed a valid and practical setup that would break with your
>>>> patch as is. Do you agree with that statement?  
>>> Did you mean
>>> "
>>> Now for something like a bond of two OSA
>>> interfaces, I would expect the two legs of the bond to probably have a
>>> "HW PNETID", but the netdev representing the bond itself won't have one
>>> unless the Linux admin defines a software PNETID, which is work, and
>>> can't have a HW PNETID because it is a software construct within Linux.
>>> Breaking for example an active-backup bond setup where the legs have
>>> HW PNETIDs and the admin did not bother to specify a PNETID for the bond
>>> is not acceptable.
>>> " ?
>>> If the legs have HW pnetids, add pnetid to bond netdev will fail as
>>> smc_pnet_add_eth will check whether the base_ndev already have HW pnetid.
>>>
>>> If the legs without HW pnetids, and admin add pnetids to legs through smc_pnet.
>>> Yes, my patch will break the setup. What Paolo suggests(both checking ndev and
>>> base_ndev, and replace || by && )can help compatible with the setup.
>>
>> I'm glad we agree on that part. Things are much more acceptable if we
>> are doing both base and ndev. 
> It is also acceptable for me.
> 
>> Nevertheless I would like to understand
>> your problem better, and talk about it to my team. I will also ask some
>> questions in another email.
> Questions are welcome.
> 
>>
>> That said having things work differently if there is a HW PNETID on
>> the base, and different if there is none is IMHO wonky and again
>> asymmetric.
>>
>> Imagine the following you have your nice little setup with a PNETID on
>> a non-leaf and a base_ndev that has no PNETID. Then your HW admin
>> configures a PNETID to your base_ndev, a different one. Suddenly
>> your ndev PNETID is ignored for reasons not obvious to you. Yes it is
>> similar to having a software PNETID on the base_ndev and getting it
>> overruled by a HW PNETID, but much less obvious IMHO. I am wondering if there are any scenarios that require setting different
> pnetids for different net devices in one netdev hierarchy. If no, maybe
> we should limit that only one pnetid can be set to one netdev hierarchy.
> 
>> I also think
>> a software PNETID of the base should probably take precedence over over
>> the software pnetid of ndev.
> Agree!
> 
> Thanks,
> Guangguan Wang
>>
>> Regards,
>> Halil

Hi Halil,

Are there any questions or further discussions about this patch? If no, I will
send a v2 patch, in which software pnetid will be searched in both base_ndev and ndev,
and base_ndev will take precedence over ndev.

Thanks,
Guangguan Wang


