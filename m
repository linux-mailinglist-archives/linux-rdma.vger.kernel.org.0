Return-Path: <linux-rdma+bounces-6897-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4975CA0526F
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 05:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11DF1889B55
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 04:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864F1A072C;
	Wed,  8 Jan 2025 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V0Y4hD3H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E526F19D88F;
	Wed,  8 Jan 2025 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736312237; cv=none; b=tb3IMtiZpYg+UUugXAT4cATgB3KutBK9Dv8thAdJ/PW1muqJCX3lQut9v8fke2sAr6q0s1nZWxjKjDEAZwVKnBHUwIJ8vTbU+e6H9b+tFAzTVtiqheoM0/D44zYLzDeUryQDaugIq2KQa0bBoCY0xVcOg6Eekyvn2Wico427/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736312237; c=relaxed/simple;
	bh=Wi4w1CZuHTsWa7Xz+0vg7iU1FtNI8yjQD7t7+K0lCJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mv7L7Km0Q2ajt3gTWKV5S2e3nIEzhimNUDqYyB4jGuRwMGkSdeog/XbCN6G+gDnHiNgE8NGepSpX5hme9eJAhy8i+8eXTfzlwMLUffVNrb8bPiyvXobLEIuU7rM8kthqoR8HREg9+g+hnkfg3A4VgTk1+M5RgJ2rR4UQtYqAd9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V0Y4hD3H; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736312224; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fCAm0QwYn+M/bP0Q8qp/lxXFwNaJPr2jpn5rRXSf4jY=;
	b=V0Y4hD3HpFw0hxHQuFtUjvEVGtWiAbnH+Yr/0exo2+ldoE6mm+AQB2sm6jBG7O1uHlXHQlJT7GU0gkpef8a493xZ16v3FEcq3L0rrCDHzmjkT6+jeS3zQtnz9csiLzqHbZKeuPJestC++QQkSUHqzR7YmPku1TmZvvFbG7883t8=
Received: from 30.221.99.192(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WNCbklj_1736312223 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 12:57:04 +0800
Message-ID: <908be351-b4f8-4c25-9171-4f033e11ffc4@linux.alibaba.com>
Date: Wed, 8 Jan 2025 12:57:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
To: Halil Pasic <pasic@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandra Winter <wintera@linux.ibm.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
 <1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
 <20250107203218.5787acb4.pasic@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250107203218.5787acb4.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/1/8 03:32, Halil Pasic wrote:
> On Tue, 7 Jan 2025 09:44:30 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
>> On 12/27/24 5:04 AM, Guangguan Wang wrote:
> 
> @Guangguan Wang: please use my linux.ibm.com address
> in the future.
Get it.

> 
>>> The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
>>> to the pnetid table and will attach the <pnetid> to net device
>>> whose name is <ethx>. But When do SMCR by <ethx>, in function
>>> smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
>>> pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
>>> use of the pnetid seems weird. Sometimes it is difficult to know
>>> the hierarchy of net device what may make it difficult to configure
>>> the pnetid and to use the pnetid. Looking into the history of
>>> commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
>>> that changes the ndev from the <ethx> to the <ethx>'s base ndev
>>> when finding pnetid by pnetid table. It seems a mistake.
>>>
>>> This patch changes the ndev back to the <ethx> when finding pnetid
>>> by pnetid table.
>>>
>>> Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
>>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>  
>>
>> If I read correctly, this will break existing applications using the
>> lookup schema introduced by the blamed commit - which is not very
>> recent.
> 
> Hi Paolo,
> 
> sorry for chiming in late. Wenjia is on vacation and Jan is out sick!
> After some reading and thinking I could not figure out how 890a2cb4a966
> ("net/smc: rework pnet table") is broken.

Before commit 890a2cb4a966:
smc_pnet_find_roce_resource
    smc_pnet_find_roce_by_pnetid(ndev, ...) /* lookup via hardware-defined pnetid */
        smc_pnetid_by_dev_port(base_ndev, ...)
    smc_pnet_find_roce_by_table(ndev, ...) /* lookup via SMC PNET table */
    {
        ...
        list_for_each_entry(pnetelem, &smc_pnettable.pnetlist, list) {
                if (ndev == pnetelem->ndev) { /* notice here, it was ndev to matching pnetid element in pnet table */
        ...
    }

After commit 890a2cb4a966:
smc_pnet_find_roce_resource
    smc_pnet_find_roce_by_pnetid
    {
        ...
        base_ndev = pnet_find_base_ndev(ndev); /* rename the variable name to base_ndev for better understanding */
        smc_pnetid_by_dev_port(base_ndev, ...)
        smc_pnet_find_ndev_pnetid_by_table(base_ndev, ...)
        {
                ...
                list_for_each_entry(pnetelem, &smc_pnettable.pnetlist, list) {
                if (base_ndev == pnetelem->ndev) { /* notice here, it is base_ndev to matching pnetid element in pnet table */
                ...
        }

    }

The commit 890a2cb4a966 has changed ndev to base_ndev when matching pnetid element in pnet table.
But in the function smc_pnet_add_eth, the pnetid is attached to the ndev itself, not the base_ndev.
smc_pnet_add_eth(...)
{
    ...
    ndev = dev_get_by_name(net, eth_name);
    ...
        if (new_netdev) {
            if (ndev) {
                new_pe->ndev = ndev;
                netdev_tracker_alloc(ndev, &new_pe->dev_tracker,
                    GFP_ATOMIC);
            }
            list_add_tail(&new_pe->list, &pnettable->pnetlist);
            mutex_unlock(&pnettable->lock);
        } else {
    ...
}

> 
> Admittedly I'm not really a net guy,and I'm mostly guessing what that
> lower and upper device stuff is, so please bear with me. All that said, I
> do think that going to the lowest netdev in the hierarchy is a sane
> thing to do here.  I assume  that lower and upper devices are applicable
> to stuff like bonding. 
> 
> PNETID stands for "Physical Network Identifier" and the idea is that iff
> two ports are connected to the same physical network then they should
> have the same PNETID. And on s390 PNETID can come and often is comming
> "from the hardware". Now for something like a bond of two OSA
> interfaces, I would expect the two legs of the bond to probably have a
> "HW PNETID", but the netdev representing the bond itself won't have one
> unless the Linux admin defines a software PNETID, which is work, and
> can't have a HW PNETID because it is a software construct within Linux.
> Breaking for example an active-backup bond setup where the legs have
> HW PNETIDs and the admin did not bother to specify a PNETID for the bond
> is not acceptable.
> 
> Let me also note that if ndev is a leaf (i.e. there is no lower device to
> it) then ndev == base_ndev, and the whole discussion does not matter for
> that case.
> 
> Again I have to emphasize that my domain knowledge is very limited, but
> I really don't feel comfortable going forward with this without Jan or
> Wenjia weighing in on the matter.
> 
> Paolo thanks for bringing this up!
> 
>>
>> Perhaps for a net patch would be better to support both lookup schemas
>> i.e.
>>
>> 	(smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid) ||
>> 	 smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid))
>>
>> ?
>>
> 
> Hm, I guess the idea here is that if ndev has a PNETID then it should
> take precedence, but if not we should try to obtain the PNETID of its
> "base_ndev". I'm not sure this would make things better compared to the
> original idea of caring about the leaf. Which makes me question my
> understanding of the problem statement from the commit message.
> 
> BTW to implement the logic proposed by you Paolo, as understood by me,
> we would have to use "&&" instead of "||". The whole expression is
> supposed
> to evaluate to false if a pnetid is found and to true if no pnet_id is
> found. smc_pnet_find_ndev_pnetid_by_table(ndev) returns false if a pnetid
> is found. I.e. if not found we would just short circuit to true and not
> call smc_pnet_find_ndev_pnetid_by_table(base_ndev), which is not what I
> believe you wanted to propose.

Yes, it should be
        (smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid) &&
 	 smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid))
if for the consideration of application's compatible usage of smc_pnet.

Thanks,
Guangguan Wang

> 
> To sum it up, please let us wait until Wenjia or Jan chime in. Copying
> Alexandra as well: she is more of a net person than I am, and maybe she
> has a more informed opinion.
> 
> Regards,
> Halil
> [...]
> 

