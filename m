Return-Path: <linux-rdma+bounces-4311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F594E4A2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 04:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35252281C90
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 02:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4896F45C0B;
	Mon, 12 Aug 2024 02:07:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A31114;
	Mon, 12 Aug 2024 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723428471; cv=none; b=jG+CW/aOL3FSsHA4JpHk/tH9JA8f5x1o13Db7fddJgO9m1R4R78BEgFNUqlpWUkfgm76NWXk56ipmiRRzo31KHjtCVBOQX/5jNOgQwXeCo4zbJ9U5J2BmRPcEnilWYJbX0hg/0pKZY5tulMKJmCq1XU7s9Z0G94I66BkF8SRM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723428471; c=relaxed/simple;
	bh=85cbc3bz0HrUrVRZ83+dua4N21aRTFoKrriCf38iyiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G08xWPPlbqXawKTJF+FxF2sXZcze4u9sYGT9SUQ+X9EJpMGIVJopr+pvCpVHmtVe1gnqhZLao8iX8wI6Bz+tIAOoxPPjsOI1L5GikUaFUgzesj153Rd9tSAjdBPaxAsSjWgVGBAOs6hNWD71yKBjF1+y3ltIUH5KM+3lkEfqS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WhyZY6rS8zyPD3;
	Mon, 12 Aug 2024 10:07:17 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id D5BBE180064;
	Mon, 12 Aug 2024 10:07:44 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 kwepemg200003.china.huawei.com (7.202.181.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Aug 2024 10:07:43 +0800
Message-ID: <28f3582f-0394-458f-81d1-aeb872edcafa@huawei.com>
Date: Mon, 12 Aug 2024 10:07:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net/smc: use ib_device_get_netdev() helper
 to get netdev info
To: <dust.li@linux.alibaba.com>, <linux-rdma@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <zyjzyj2000@gmail.com>,
	<wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <20240809083148.1989912-3-liujian56@huawei.com>
 <20240809145917.GB103152@linux.alibaba.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <20240809145917.GB103152@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200003.china.huawei.com (7.202.181.30)



在 2024/8/9 22:59, Dust Li 写道:
> On 2024-08-09 16:31:46, Liu Jian wrote:
>> Currently, in the SMC protocol, network devices are obtained by calling
>> ib_device_ops.get_netdev(). But for some drivers, this callback function
>> is not implemented separately. Therefore, here I modified to use
>> ib_device_get_netdev() to get net_device.
>>
>> For rdma devices that do not implement ib_device_ops.get_netdev(), one of
>> the issues addressed is as follows:
>> before:
>> smcr device
>> Net-Dev         IB-Dev   IB-P  IB-State  Type        Crit  #Links  PNET-ID
>>                 rxee        1    ACTIVE  0               No       0
>>
>> after:
>> smcr device
>> Net-Dev         IB-Dev   IB-P  IB-State  Type        Crit  #Links  PNET-ID
>> enp1s0f1        rxee        1    ACTIVE  0               No       0
>>
>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>> ---
>> net/smc/smc_ib.c   | 8 +++-----
>> net/smc/smc_pnet.c | 6 +-----
>> 2 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>> index 9297dc20bfe2..382351ac9434 100644
>> --- a/net/smc/smc_ib.c
>> +++ b/net/smc/smc_ib.c
>> @@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
>> 	struct ib_device *ibdev = smcibdev->ibdev;
>> 	struct net_device *ndev;
>>
>> -	if (!ibdev->ops.get_netdev)
>> -		return;
>> -	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
>> +	ndev = ib_device_get_netdev(ibdev, port + 1);
>> 	if (ndev) {
>> 		smcibdev->ndev_ifidx[port] = ndev->ifindex;
>> 		dev_put(ndev);
>> @@ -921,9 +919,9 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
>> 		port_cnt = smcibdev->ibdev->phys_port_cnt;
>> 		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
>> 			libdev = smcibdev->ibdev;
>> -			if (!libdev->ops.get_netdev)
>> +			lndev = ib_device_get_netdev(libdev, i + 1);
>> +			if (!lndev)
>> 				continue;
>> -			lndev = libdev->ops.get_netdev(libdev, i + 1);
>> 			dev_put(lndev);
>> 			if (lndev != ndev)
>> 				continue;
>> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>> index 2adb92b8c469..a55a697a48de 100644
>> --- a/net/smc/smc_pnet.c
>> +++ b/net/smc/smc_pnet.c
>> @@ -1055,11 +1055,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
>> 			continue;
>>
>> 		for (i = 1; i <= SMC_MAX_PORTS; i++) {
>> -			if (!rdma_is_port_valid(ibdev->ibdev, i))
>> -				continue;
> 
> Why remove this check ?
> 
Hi, Dust,
The same check is already in ib_device_get_netdev().
> Best regard,
> Dust
> 
> 
>> -			if (!ibdev->ibdev->ops.get_netdev)
>> -				continue;
>> -			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
>> +			ndev = ib_device_get_netdev(ibdev->ibdev, i);
>> 			if (!ndev)
>> 				continue;
>> 			dev_put(ndev);
>> -- 
>> 2.34.1
>>

