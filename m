Return-Path: <linux-rdma+bounces-8641-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64770A5EDA7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 09:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8BF3A5246
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934F826036A;
	Thu, 13 Mar 2025 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jnrwk2jV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD691DF26F;
	Thu, 13 Mar 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853365; cv=none; b=IzI2JVtedTfKl/pP8vAB8VaYRnV6ItK648apfaJcIQZvIWR3oYJ7RfIq/Mc6V5kCf3dZP1djbvNdcI4FNCu5nJwPCo5FVBimTFYstmU5OrQyqs1iJ07dnJz75gFr3k0cdJbsqYqtw/hDZJlYr4FPDdbEjROB1i4UIWM7zWy5pms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853365; c=relaxed/simple;
	bh=5VlJyHScTjibeMz0sBT6ncPP2fJQN7NEPSfxw+Fd4rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwT2Bdq6WBVnQz8IucCPFOrBOiUrmj8D2gDbsTCBd8Q+5td0BaIGYt6cJqU4igHzAFDU1JHdXoTmhA4QdyfL9gbArC8n3+0iZdsYNSFRtujhJJjrrZ6XnL5duyINY2awZS4+1AY/aj80Tt703OWM58C/B9nLIU3HknXLWjsE6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jnrwk2jV; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741853352; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yp6Ine+XuVgYfgjHCWfVvyg97RJxN6sq0wiTCHzQ4go=;
	b=Jnrwk2jVhgkSy2Sij6enCkd0dkh9Go7TUtttiUSTzG1F1GMMPXbSVntBwJSpcmDuUy7lnpkTQ8JQ8P/jAiSYDzaDv8wj48h/ylvowMlJ/hVoaKOLdq1dHNj71f891gbfeFir9doPfnUdHLmAfagMpe7R92/BjOtSh0V59/upcNY=
Received: from 30.221.98.116(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WRG4IDE_1741853350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Mar 2025 16:09:11 +0800
Message-ID: <0720fd9f-e5b4-4706-8483-ace1ecb22c8b@linux.alibaba.com>
Date: Thu, 13 Mar 2025 16:09:01 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: use the correct ndev to find pnetid
 by pnetid table
To: Wenjia Zhang <wenjia@linux.ibm.com>, pasic@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, mjambigi@linux.ibm.com, sidraya@linux.ibm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
 <80afe99b-ca14-4b21-a200-1d695ed6ae63@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <80afe99b-ca14-4b21-a200-1d695ed6ae63@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/3/13 15:46, Wenjia Zhang wrote:
> 
> 
> On 04.03.25 13:43, Guangguan Wang wrote:
>> When using smc_pnet in SMC, it will only search the pnetid in the
>> base_ndev of the netdev hierarchy(both HW PNETID and User-defined
>> sw pnetid). This may not work for some scenarios when using SMC in
>> container on cloud environment.
>> In container, there have choices of different container network,
>> such as directly using host network, virtual network IPVLAN, veth,
>> etc. Different choices of container network have different netdev
>> hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1
>> in host below is the netdev directly related to the physical device).
>>              _______________________________
>>             |   _________________           |
>>             |  |POD              |          |
>>             |  |                 |          |
>>             |  | eth0_________   |          |
>>             |  |____|         |__|          |
>>             |       |         |             |
>>             |       |         |             |
>>             |   eth1|base_ndev| eth0_______ |
>>             |       |         |    | RDMA  ||
>>             | host  |_________|    |_______||
>>             ---------------------------------
>>       netdev hierarchy if directly using host network
>>             ________________________________
>>             |   _________________           |
>>             |  |POD  __________  |          |
>>             |  |    |upper_ndev| |          |
>>             |  |eth0|__________| |          |
>>             |  |_______|_________|          |
>>             |          |lower netdev        |
>>             |        __|______              |
>>             |   eth1|         | eth0_______ |
>>             |       |base_ndev|    | RDMA  ||
>>             | host  |_________|    |_______||
>>             ---------------------------------
>>              netdev hierarchy if using IPVLAN
>>              _______________________________
>>             |   _____________________       |
>>             |  |POD        _________ |      |
>>             |  |          |base_ndev||      |
>>             |  |eth0(veth)|_________||      |
>>             |  |____________|________|      |
>>             |               |pairs          |
>>             |        _______|_              |
>>             |       |         | eth0_______ |
>>             |   veth|base_ndev|    | RDMA  ||
>>             |       |_________|    |_______||
>>             |        _________              |
>>             |   eth1|base_ndev|             |
>>             | host  |_________|             |
>>             ---------------------------------
>>               netdev hierarchy if using veth
>> Due to some reasons, the eth1 in host is not RDMA attached netdevice,
>> pnetid is needed to map the eth1(in host) with RDMA device so that POD
>> can do SMC-R. Because the eth1(in host) is managed by CNI plugin(such
>> as Terway, network management plugin in container environment), and in
>> cloud environment the eth(in host) can dynamically be inserted by CNI
>> when POD create and dynamically be removed by CNI when POD destroy and
>> no POD related to the eth(in host) anymore. It is hard to config the
>> pnetid to the eth1(in host). But it is easy to config the pnetid to the
>> netdevice which can be seen in POD. When do SMC-R, both the container
>> directly using host network and the container using veth network can
>> successfully match the RDMA device, because the configured pnetid netdev
>> is a base_ndev. But the container using IPVLAN can not successfully
>> match the RDMA device and 0x03030000 fallback happens, because the
>> configured pnetid netdev is not a base_ndev. Additionally, if config
>> pnetid to the eth1(in host) also can not work for matching RDMA device
>> when using veth network and doing SMC-R in POD.
>>
>> To resolve the problems list above, this patch extends to search user
>> -defined sw pnetid in the clc handshake ndev when no pnetid can be found
>> in the base_ndev, and the base_ndev take precedence over ndev for backward
>> compatibility. This patch also can unify the pnetid setup of different
>> network choices list above in container(Config user-defined sw pnetid in
>> the netdevice can be seen in POD).
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> ---
>>   net/smc/smc_pnet.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>> index 716808f374a8..b391c2ef463f 100644
>> --- a/net/smc/smc_pnet.c
>> +++ b/net/smc/smc_pnet.c
>> @@ -1079,14 +1079,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
>>                        struct smc_init_info *ini)
>>   {
>>       u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
>> +    struct net_device *base_ndev;
>>       struct net *net;
>>   -    ndev = pnet_find_base_ndev(ndev);
>> +    base_ndev = pnet_find_base_ndev(ndev);
>>       net = dev_net(ndev);
>> -    if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
>> +    if (smc_pnetid_by_dev_port(base_ndev->dev.parent, base_ndev->dev_port,
>>                      ndev_pnetid) &&
>> +        smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
>>           smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
>> -        smc_pnet_find_rdma_dev(ndev, ini);
>> +        smc_pnet_find_rdma_dev(base_ndev, ini);
>>           return; /* pnetid could not be determined */
>>       }
>>       _smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);
> 
> Hi Guangguan,
> 
> sorry for the late answer! It looks good to me. Here is my R-b:
> 
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> 
Thanks, Wenjia.

> Btw. could you give Halil some time for the review? He also wants to have a look.
It is OK.

Regards,
Guangguan Wang
> 
> Thanks,
> Wenjia
> 


