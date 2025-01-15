Return-Path: <linux-rdma+bounces-7026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FDA12348
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 12:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7E116CECE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B114241695;
	Wed, 15 Jan 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HW453Z1s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0846224AEF;
	Wed, 15 Jan 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942005; cv=none; b=cRi0t5KYwKvye2Jepk6SYJ+lyZwC+vYo1kbU6KHWo0cR6CdGY7H2jp8vknYfe2I3SC+9S5shmUNQ0danSEQ3MCYDGn/C3dZHnsKQ20KsoaxvtYDM861zTgznDNyzn+KoyH953DSSKtr22qbbtkdg5fkhYh1DAjQ5c+0DkT+qmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942005; c=relaxed/simple;
	bh=vom1M5y0t/2i6oRVZy3Twpq/IpbkTcdH5c9rb3WAZx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBEzqYfxk/lb8QNa8nCjSdmTOajlDb38CzER+Yb2Hp52p4xgnIqit9lrBrkcQZn/0kIhDYVL1fLqUKf/2gmddpLwVOm5qwbH9meiCQzImjyzOGg52J4lIMWVwiLYbNto3oUSSvVHtyuFCD3SIKmMfIc0Awm9eWxLBTf7emfeuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HW453Z1s; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736941997; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L1nv3aPuQLf0keVSQjzBMEcZo7dzqH6nOk+7lPFkYBQ=;
	b=HW453Z1s4Cb2JvJv8SgbS6cMHKZFZXFkxDuzbN+67torJ5+wnhHWuNFUKRojklrkOsqgKtk+MYvyhUpspVHNK87HNQnAdiBr06gEoEXzjPASHt1RjvG7jXmeCFpEH1pxcU/uz6JOwOAi6nTYqQgUCeP2N5lshdN0wWRMLhUgtl8=
Received: from 30.221.98.4(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WNiOY3G_1736941995 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 19:53:16 +0800
Message-ID: <3dc68650-904c-4a1d-adc4-172e771f640c@linux.alibaba.com>
Date: Wed, 15 Jan 2025 19:53:15 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
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
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250114130747.77a56d9a.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/1/14 20:07, Halil Pasic wrote:
> On Fri, 10 Jan 2025 13:43:44 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>>> I think I showed a valid and practical setup that would break with your
>>> patch as is. Do you agree with that statement?  
>> Did you mean
>> "
>> Now for something like a bond of two OSA
>> interfaces, I would expect the two legs of the bond to probably have a
>> "HW PNETID", but the netdev representing the bond itself won't have one
>> unless the Linux admin defines a software PNETID, which is work, and
>> can't have a HW PNETID because it is a software construct within Linux.
>> Breaking for example an active-backup bond setup where the legs have
>> HW PNETIDs and the admin did not bother to specify a PNETID for the bond
>> is not acceptable.
>> " ?
>> If the legs have HW pnetids, add pnetid to bond netdev will fail as
>> smc_pnet_add_eth will check whether the base_ndev already have HW pnetid.
>>
>> If the legs without HW pnetids, and admin add pnetids to legs through smc_pnet.
>> Yes, my patch will break the setup. What Paolo suggests(both checking ndev and
>> base_ndev, and replace || by && )can help compatible with the setup.
> 
> I'm glad we agree on that part. Things are much more acceptable if we
> are doing both base and ndev. 
It is also acceptable for me.

> Nevertheless I would like to understand
> your problem better, and talk about it to my team. I will also ask some
> questions in another email.
Questions are welcome.

> 
> That said having things work differently if there is a HW PNETID on
> the base, and different if there is none is IMHO wonky and again
> asymmetric.
> 
> Imagine the following you have your nice little setup with a PNETID on
> a non-leaf and a base_ndev that has no PNETID. Then your HW admin
> configures a PNETID to your base_ndev, a different one. Suddenly
> your ndev PNETID is ignored for reasons not obvious to you. Yes it is
> similar to having a software PNETID on the base_ndev and getting it
> overruled by a HW PNETID, but much less obvious IMHO. I am wondering if there are any scenarios that require setting different
pnetids for different net devices in one netdev hierarchy. If no, maybe
we should limit that only one pnetid can be set to one netdev hierarchy.

> I also think
> a software PNETID of the base should probably take precedence over over
> the software pnetid of ndev.
Agree!

Thanks,
Guangguan Wang
> 
> Regards,
> Halil

