Return-Path: <linux-rdma+bounces-6955-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93D9A08876
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 07:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F78A168847
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 06:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C371CEAB4;
	Fri, 10 Jan 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pbxKeEfI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8871BBBC6;
	Fri, 10 Jan 2025 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736491150; cv=none; b=bYslp91qANshRxN07JIs94jYxz6nDX4/+Ha4XHkDWqC45Sx9whotdkWMMU9mt8LEbXvlbV/QksUe5WV1eLrQuJZyx8/T6s4vicoqV3Qka5aNZrObOQIK3aOEItBXqQq2/bLGq6Oh1gcVN0r0g6mg9PB7Sq2QKk7Ge40l6P4XeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736491150; c=relaxed/simple;
	bh=EAURZ915LUw+9iVCgXVB81RyfoDoYX39XGHPrinOQU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdTErpHJRZDpfHTDhzmzWdXsdb7mfxAKvHFFgTEIGGGUdhUjtQxygfpYrgtogW5R7b3qdYxkzKEE5pFNxKSII7bVHs3/UlXpvQ5HUf8ycQixChYmDbMOrPjje9YzG51FCkalD4poTITQ71x+E68EY0xev3eiv0VNNJkZFYrr5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pbxKeEfI; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736491144; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P3Kme5wyWvVbMf89j3h+B/6o3qNPbeDLksHsUKPMeP0=;
	b=pbxKeEfITy7c20tf8lGDtGndRiW+9nVX1odPLhmzIxY74sETTSx0mmFE3eTQkDIlUYcIFwhOTgr34UltZ2iOb1bANLKURHzvWJzd1V5q6S8M4+g/Ouql+dLMgYBKN4jHHYFONzEU8FV/3m1kqaSonKWj7bPsGIekvcttkLo5NVA=
Received: from 30.221.98.188(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WNK8Rrq_1736491142 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jan 2025 14:39:03 +0800
Message-ID: <68059840-3aed-44e5-ac6e-9b1cabca392d@linux.alibaba.com>
Date: Fri, 10 Jan 2025 14:39:01 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
To: Alexandra Winter <wintera@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, PASIC@de.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
 <1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
 <20250107203218.5787acb4.pasic@linux.ibm.com>
 <3ff078e0-150d-41ba-b705-a8e0365f0370@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <3ff078e0-150d-41ba-b705-a8e0365f0370@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/1/9 00:00, Alexandra Winter wrote:
> 
> 
> On 07.01.25 20:32, Halil Pasic wrote:
>> On Tue, 7 Jan 2025 09:44:30 +0100
>> Paolo Abeni <pabeni@redhat.com> wrote:
>>
>>> On 12/27/24 5:04 AM, Guangguan Wang wrote:
> ...
>>>> The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
>>>> to the pnetid table and will attach the <pnetid> to net device
>>>> whose name is <ethx>. But When do SMCR by <ethx>, in function
>>>> smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
>>>> pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
>>>> use of the pnetid seems weird. Sometimes it is difficult to know
>>>> the hierarchy of net device what may make it difficult to configure
>>>> the pnetid and to use the pnetid. Looking into the history of
>>>> commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
>>>> that changes the ndev from the <ethx> to the <ethx>'s base ndev
>>>> when finding pnetid by pnetid table. It seems a mistake.
>>>>
>>>> This patch changes the ndev back to the <ethx> when finding pnetid
>>>> by pnetid table.
>>>>
>>>> Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
>>>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>  
>>>
>>> If I read correctly, this will break existing applications using the
>>> lookup schema introduced by the blamed commit - which is not very
>>> recent.
> 
> 
> I agree that this patch may break existing applications or existing
> configuration automation scripts.
> 
> ...
>> PNETID stands for "Physical Network Identifier" and the idea is that iff
>> two ports are connected to the same physical network then they should
>> have the same PNETID. And on s390 PNETID can come and often is comming
>> "from the hardware". 
> ...
> 
> 
> HW pnetids (smc_pnetid_by_dev_port()) are only visible at the base netdevice.
> It seems that the pnetid table, managed by the smc_pnet tool, tries to mimick
> that behaviour, and the concept (recommendation?) would be to set the 
> user-defined pnetid also for the base netdevice and then use the upper
> level netdevices for the tcp connection. Which makes some sense, 
> all upper level devices have the same connectivity as the base device.
> 
> So this patch would break a setup that follows this concept and only sets the 
> pnetid at the base netdevice.
>
Hi Alexandra,

See the examples of using smc-r in container on cloud environment here
https://lore.kernel.org/linux-s390/3ff078e0-150d-41ba-b705-a8e0365f0370@linux.ibm.com/T/#t.

Especially the example of using veth in container, it can not successfully match the expected
RDMA device when do SMC-R in POD, if follow the concept of the HW pnetid and only sets the
pnetid at the base netdevice.

Maybe it is time to extend the concept and usage of pnetid table?

> 
> Optionally you can set a user-defined pnetid on upper level devices (maybe for
> usability??), but as Guangguan noticed, that has no practical impact.
> In the documentation I see examples where the same pnetid is set for upper
> and base device. 
> You cannot set a user-defined pnetid on a upper level device, if the base
> device has a HW pnetid (smc_pnet_add_eth()) which makes some sense,
> not even the same pnetid (makes less sense IMO).

> However you can set different user-defined pnetids on the upper netdevices
> and the base device, which makes no sense to me.
> 
>>>
>>> Perhaps for a net patch would be better to support both lookup schemas
>>> i.e.
>>>
>>> 	(smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid) ||
>>> 	 smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid))
>>>
>>> ?
> 
> This may yield undesirable results, if base pnetid and upper pnetid differ..
> But then maybe GIGO?
> 
> 
> ... 
>> BTW to implement the logic proposed by you Paolo, as understood by me,
>> we would have to use "&&" instead of "||". 
> +1
> 
> 
> Another idea may be to change the setting of a user-defined pnetid
> on an upper level netdevice to
> - fail if the base netdevice has a different pnetid
> - set the pnetid of the base device , if it is currently unset.
> 
In the example of veth, the base ndev found through the upper level ndev in POD
is not the real "base device" describe here.
And I wonder whether it is confused if set a user-defined pnetid to one netdevice,
but list another netdevice when smc_pnet show. For example set pnetid ABC to eth1,
whose base netdev is eth0, but when smc_pnet show, only can find eth0 with pnetid
ABC.

Thanks,
Guangguan Wang


