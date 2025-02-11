Return-Path: <linux-rdma+bounces-7650-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5DA3024A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 04:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E1C3A35F5
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 03:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404F1D5CF9;
	Tue, 11 Feb 2025 03:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UpgJHSV7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87826BD9A;
	Tue, 11 Feb 2025 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739245490; cv=none; b=QyGEYBStcNuhzHPK5WF/NMjU05Hb8SFM30hdPBq6kheMWcZiIbi+JzgounOTJoQJAFNXAGkSmWT011azLEoosfGwTxks55xr04SFJA5naHCkx2kIckFdpOjKR6omW1dUM5wCGf3otCC/D3xdLtjGhTVXgTAabbxc7wOhNurQ5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739245490; c=relaxed/simple;
	bh=cbZeyB2v5CBXKmD5Rwhbq7GfwJEO4Dq3/ysp8Gv1D+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABYWy5gZ1yEQOSGV2vxvAfTORCAzyZqaQ/UruqhopVFDXCBVGydGVZpWYQCScGP95hKwlr5hTWXxi9Ig08XL43gneHuqvL/fbZDsz8PZSXyXm9Z4vL4mHe5wf39uikHMT2usqPUbiOla+FTvHqn1qtzfyhw9L1CXHpnPCuUMv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UpgJHSV7; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739245475; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vms42idQU2sl94ZqBjF5MJvW0dhT/Zg7Gq/ZK3nF0vk=;
	b=UpgJHSV7gnVmMwkQZh/jbV12dCPzwx6IDespgfvE8Fi1YL+vK78A99ANBH9O8hYeqgmGEgzStXQWHcr+3SgLtNNQiLebpgQGvSOYM28SgMfBOXaCm9r64XIl53b+yeXYVsDV8lKOOarT0BHnoYOrBp4pEeJewrGrsiOhnX0mVtg=
Received: from 30.221.99.7(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WPFLNSe_1739245472 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 11:44:33 +0800
Message-ID: <4eb38707-1a93-4c5c-aa65-14adfd595d14@linux.alibaba.com>
Date: Tue, 11 Feb 2025 11:44:32 +0800
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
 <20250210145255.793e6639.pasic@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250210145255.793e6639.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/2/10 21:52, Halil Pasic wrote:
> On Fri, 10 Jan 2025 13:43:44 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>> We want to use SMC in container on cloud environment, and encounter problem
>> when using smc_pnet with commit 890a2cb4a966. In container, there have choices
>> of different container network, such as directly using host network, virtual
>> network IPVLAN, veth, etc. Different choices of container network have different
>> netdev hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1 in host
>> below is the netdev directly related to the physical device).
>>  _______________________________      ________________________________   
>> |   _________________           |     |   _________________           |  
>> |  |POD              |          |     |  |POD  __________  |          |  
>> |  |                 |          |     |  |    |upper_ndev| |          |  
>> |  | eth0_________   |          |     |  |eth0|__________| |          |  
>> |  |____|         |__|          |     |  |_______|_________|          |  
>> |       |         |             |     |          |lower netdev        |  
>> |       |         |             |     |        __|______              |  
>> |   eth1|base_ndev| eth0_______ |     |   eth1|         | eth0_______ |  
>> |       |         |    | RDMA  ||     |       |base_ndev|    | RDMA  ||  
>> | host  |_________|    |_______||     | host  |_________|    |_______||  
>> ———————————————————————————————-      ———————————————————————————————-    
>>  netdev hierarchy if directly          netdev hierarchy if using IPVLAN    
>>    using host network
>>  _______________________________
>> |   _____________________       |
>> |  |POD        _________ |      |
>> |  |          |base_ndev||      |
>> |  |eth0(veth)|_________||      |
>> |  |____________|________|      |
>> |               |pairs          |
>> |        _______|_              |
>> |       |         | eth0_______ |
>> |   veth|base_ndev|    | RDMA  ||
>> |       |_________|    |_______||
>> |        _________              |
>> |   eth1|base_ndev|             |
>> | host  |_________|             |
>>  ———————————————————————————————
>>   netdev hierarchy if using veth
>>
>> Due to some reasons, the eth1 in host is not RDMA attached netdevice, pnetid
>> is needed to map the eth1(in host) with RDMA device so that POD can do SMC-R.
>> Because the eth1(in host) is managed by CNI plugin(such as Terway, network
>> management plugin in container environment), and in cloud environment the
>> eth(in host) can dynamically be inserted by CNI when POD create and dynamically
>> be removed by CNI when POD destroy and no POD related to the eth(in host)
>> anymore.
> 
> I'm pretty clueless when it comes to the details of CNI but I think
> I'm barely able to follow. Nevertheless if you have the feeling that
> my extrapolations are wrong, please do point it out.
> 
>> It is hard for us to config the pnetid to the eth1(in host). So we
>> config the pnetid to the netdevice which can be seen in POD.
> 
> Hm, this sounds like you could set PNETID on eth1 (in host) for each of
> the cases and everything would be cool (and would work), but because CNI
> and the environment do not support it, or supports it in a very
> inconvenient way, you are looking for a workaround where PNETID is set
> in the POD. Is that right? Or did I get something wrong?

Right.

> 
>> When do SMC-R, both
>> the container directly using host network and the container using veth network
>> can successfully match the RDMA device, because the configured pnetid netdev is a
>> base_ndev. But the container using IPVLAN can not successfully match the RDMA
>> device and 0x03030000 fallback happens, because the configured pnetid netdev is
>> not a base_ndev. Additionally, if config pnetid to the eth1(in host) also can not
>> work for matching RDMA device when using veth network and doing SMC-R in POD.
> 
> That I guess answers my question from the first paragraph. Setting
> PNETID on eth1 (host) would not be sufficient for veth. Right?

Right. It is also one of the reasons for setting PNETID in POD.

> 
> Another silly question: is making the PNETID basically a part of the Pod
> definition shifting PNETID from the realm of infrastructure (i.e.
> configured by the cloud provider) to the ream of an application (i.e.
> configured by the tenant)?

No, application do not need to know the PNETID configuration. We have a plugin in
Kubernetes. When deploying a POD, the plugin will automatically add an initContainer
to the POD and automatically configure the PNETID in initContainer.

> 
> AFAIU veth (host) is bridged (or similar) to eth1 (host) and that is in
> the host, and this is where we make sure that the requirements for SMC-R
> are satisfied.
> 
> But veth (host) could be attached to eth3 which is on a network not
> reachable via eth0 (host) or eth1 (host). In that case the pod could
> still set PNETID on veth (POD). Or?
> 

Sorry, I forget to add a precondition, it is a single-tenant scenario, and all of the
ethX in host are in the same VPC(A term in Cloud, can be simply understood as a private
network domain). The ethX in the same VPC means they have the same network reachability.
Therefore, in this scenario, we will not encounter the situation you mentioned.

>>
>> My patch can resolve the problem we encountered and also can unify the pnetid setup
>> of different network choices list above, assuming the pnetid is not limited to
>> config to the base_ndev directly related to the physical device(indeed, the current
>> implementation has not limited it yet).
> 
> I see some problems here, but I'm afraid we see different problems. For
> me not being able to set eth0 (veth/POD)'s PNEDID from the host is a
> problem. Please notice that with the current implementation users can
> only control the PNETID if infrastructure does not do so in the first
> place.
> 
> 
> Can you please help me reason about this? I'm unfortunately lacking
> Kubernetes skills here, and it is difficult for me to think along.

Yes, it is also a problem that not being able to set eth0 (veth/POD)'s PNEDID from the host.
Even if the eth1(host) have hardware PNETID, the eth0 (veth/POD) can not search the hardware
PNETID. Because the eth0 (veth/POD) and eth1(host) are not in one netdev hierarchy.
But the two netdev hierarchies have relationship. Maybe search PNETID in all related netdev
hierarchies can help resolve this. For example when finding the base_ndev, if the base_ndev
is a netdev has relationship with other netdev(veth .etc) then jump to the related netdev
hierarchy through the relationship to iteratively find the base_ndev.
It is an idea now. I have not do any research about it yet and I am not sure if it is feasible.

Thanks,
Guangguan Wang

> 
> Regards,
> Halil


