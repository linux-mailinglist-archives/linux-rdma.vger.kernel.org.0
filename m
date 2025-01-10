Return-Path: <linux-rdma+bounces-6954-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966FA086BB
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 06:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD9A3A64E3
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 05:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219E2066CB;
	Fri, 10 Jan 2025 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mLRbtEG+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBC746E;
	Fri, 10 Jan 2025 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487840; cv=none; b=bmnUlTABkcX6opTIzJYeyulBAV0CDow+S5Zb1gOwSmT6T74K0C55CT0lBkvgAG7En6x8gc4x93FeIcNqJKBly5jagqIzbexOlCZNY8f8NKfHRjuXTUBaaxk/DtWybtENZcjJMaQGW2di+H9ow6OvbvVoI5vFPxQzFoPBmXIM318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487840; c=relaxed/simple;
	bh=9G/L1ZomCQwviZeWuRSudJqgRPVeuQmTot+azaFSyS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvIaAWo/qtsUptZ5F9op1ckfv7+0ZVDdSWEiJLwUTc5uGIuyZQovemy4ikt6EqWHN0ToWe6+DrLuyBrgg7gz8KAcxLdI2V2yPY+BmWqICOIHhIAlXXCjA2lP2ghlGdBhO/AKlkRYWSSXoa0kfu9ZFoMDyMoNhJ4kecUdOgNZZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mLRbtEG+; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736487827; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xAyuwYq8sl8JF7mbt/6XCIrVbtDcyq2uevTq8dLVNrk=;
	b=mLRbtEG+7GUMB5zKf6BaeRQCOP42HFvlOEnuOh4oW8nvF4qy52a74gP+z3CuRtwEqOO922pXF7xep5X8Kb5ZglJPDyvnGkthXSfEuoh68hkZQoTvy3bTwk/9hqUfVhR0xG4QkEdgbufUU7ZWq5atH7qjuGtS8Kpche+ffEcN7v4=
Received: from 30.221.98.188(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WNJnBTV_1736487825 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jan 2025 13:43:46 +0800
Message-ID: <b1053a92-3a3f-4042-9be9-60b94b97747d@linux.alibaba.com>
Date: Fri, 10 Jan 2025 13:43:44 +0800
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
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250109040429.350fdd60.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/1/9 11:04, Halil Pasic wrote:
> On Wed, 8 Jan 2025 12:57:00 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>>> sorry for chiming in late. Wenjia is on vacation and Jan is out sick!
>>> After some reading and thinking I could not figure out how 890a2cb4a966
>>> ("net/smc: rework pnet table") is broken.  
>>
>> Before commit 890a2cb4a966:
>> smc_pnet_find_roce_resource
>>     smc_pnet_find_roce_by_pnetid(ndev, ...) /* lookup via hardware-defined pnetid */
>>         smc_pnetid_by_dev_port(base_ndev, ...)
>>     smc_pnet_find_roce_by_table(ndev, ...) /* lookup via SMC PNET table */
>>     {
>>         ...
>>         list_for_each_entry(pnetelem, &smc_pnettable.pnetlist, list) {
>>                 if (ndev == pnetelem->ndev) { /* notice here, it was ndev to matching pnetid element in pnet table */
>>         ...
>>     }
>>
>> After commit 890a2cb4a966:
>> smc_pnet_find_roce_resource
>>     smc_pnet_find_roce_by_pnetid
>>     {
>>         ...
>>         base_ndev = pnet_find_base_ndev(ndev); /* rename the variable name to base_ndev for better understanding */
>>         smc_pnetid_by_dev_port(base_ndev, ...)
>>         smc_pnet_find_ndev_pnetid_by_table(base_ndev, ...)
>>         {
>>                 ...
>>                 list_for_each_entry(pnetelem, &smc_pnettable.pnetlist, list) {
>>                 if (base_ndev == pnetelem->ndev) { /* notice here, it is base_ndev to matching pnetid element in pnet table */
>>                 ...
>>         }
>>
>>     }
>>
>> The commit 890a2cb4a966 has changed ndev to base_ndev when matching pnetid element in pnet table.
>> But in the function smc_pnet_add_eth, the pnetid is attached to the ndev itself, not the base_ndev.
>> smc_pnet_add_eth(...)
>> {
>>     ...
>>     ndev = dev_get_by_name(net, eth_name);
>>     ...
>>         if (new_netdev) {
>>             if (ndev) {
>>                 new_pe->ndev = ndev;
>>                 netdev_tracker_alloc(ndev, &new_pe->dev_tracker,
>>                     GFP_ATOMIC);
>>             }
>>             list_add_tail(&new_pe->list, &pnettable->pnetlist);
>>             mutex_unlock(&pnettable->lock);
>>         } else {
>>     ...
>> }
> 
> I still not understand why do you think that 890a2cb4a966~1 is better
> than 890a2cb4a966 even if things changed with 890a2cb4a966 which
> I did not verify for myself but am willing to assume.
> 
> Is there some particular setup that you think would benefit from
> you patch? I.e. going back to the 890a2cb4a966~1 behavior I suppose.
> 

We want to use SMC in container on cloud environment, and encounter problem
when using smc_pnet with commit 890a2cb4a966. In container, there have choices
of different container network, such as directly using host network, virtual
network IPVLAN, veth, etc. Different choices of container network have different
netdev hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1 in host
below is the netdev directly related to the physical device).
 _______________________________      ________________________________   
|   _________________           |     |   _________________           |  
|  |POD              |          |     |  |POD  __________  |          |  
|  |                 |          |     |  |    |upper_ndev| |          |  
|  | eth0_________   |          |     |  |eth0|__________| |          |  
|  |____|         |__|          |     |  |_______|_________|          |  
|       |         |             |     |          |lower netdev        |  
|       |         |             |     |        __|______              |  
|   eth1|base_ndev| eth0_______ |     |   eth1|         | eth0_______ |  
|       |         |    | RDMA  ||     |       |base_ndev|    | RDMA  ||  
| host  |_________|    |_______||     | host  |_________|    |_______||  
———————————————————————————————-      ———————————————————————————————-    
 netdev hierarchy if directly          netdev hierarchy if using IPVLAN    
   using host network
 _______________________________
|   _____________________       |
|  |POD        _________ |      |
|  |          |base_ndev||      |
|  |eth0(veth)|_________||      |
|  |____________|________|      |
|               |pairs          |
|        _______|_              |
|       |         | eth0_______ |
|   veth|base_ndev|    | RDMA  ||
|       |_________|    |_______||
|        _________              |
|   eth1|base_ndev|             |
| host  |_________|             |
 ———————————————————————————————
  netdev hierarchy if using veth

Due to some reasons, the eth1 in host is not RDMA attached netdevice, pnetid
is needed to map the eth1(in host) with RDMA device so that POD can do SMC-R.
Because the eth1(in host) is managed by CNI plugin(such as Terway, network
management plugin in container environment), and in cloud environment the
eth(in host) can dynamically be inserted by CNI when POD create and dynamically
be removed by CNI when POD destroy and no POD related to the eth(in host)
anymore. It is hard for us to config the pnetid to the eth1(in host). So we
config the pnetid to the netdevice which can be seen in POD. When do SMC-R, both
the container directly using host network and the container using veth network
can successfully match the RDMA device, because the configured pnetid netdev is a
base_ndev. But the container using IPVLAN can not successfully match the RDMA
device and 0x03030000 fallback happens, because the configured pnetid netdev is
not a base_ndev. Additionally, if config pnetid to the eth1(in host) also can not
work for matching RDMA device when using veth network and doing SMC-R in POD.

My patch can resolve the problem we encountered and also can unify the pnetid setup
of different network choices list above, assuming the pnetid is not limited to
config to the base_ndev directly related to the physical device(indeed, the current
implementation has not limited it yet).

> I think I showed a valid and practical setup that would break with your
> patch as is. Do you agree with that statement?
Did you mean
"
Now for something like a bond of two OSA
interfaces, I would expect the two legs of the bond to probably have a
"HW PNETID", but the netdev representing the bond itself won't have one
unless the Linux admin defines a software PNETID, which is work, and
can't have a HW PNETID because it is a software construct within Linux.
Breaking for example an active-backup bond setup where the legs have
HW PNETIDs and the admin did not bother to specify a PNETID for the bond
is not acceptable.
" ?
If the legs have HW pnetids, add pnetid to bond netdev will fail as
smc_pnet_add_eth will check whether the base_ndev already have HW pnetid.

If the legs without HW pnetids, and admin add pnetids to legs through smc_pnet.
Yes, my patch will break the setup. What Paolo suggests(both checking ndev and
base_ndev, and replace || by && )can help compatible with the setup.


Thanks,
Guangguan Wang
> 
> Regards,
> Halil

