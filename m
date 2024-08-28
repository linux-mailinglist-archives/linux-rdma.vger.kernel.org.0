Return-Path: <linux-rdma+bounces-4612-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6069624EF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 12:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B641F24C49
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DED16B3BD;
	Wed, 28 Aug 2024 10:29:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45E15B122;
	Wed, 28 Aug 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840996; cv=none; b=P/yZ3B5h4NXrE8WMoH6QePT2BXyn/mxOZYZGq1KmL5+w0k6zQ4+P2XXdSUDz7zY7zxQCrUWh8xliViRrZHpEtRjochWz7GgOlF9USULJF8lHOECJAcqnlu69oag1YBe1q7JmwZ7NoN5n3Yq+lxWBxECUjaJexP2x0hK36Yf1loc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840996; c=relaxed/simple;
	bh=O4MXgpCagL+uFlh51r7eztf0GwKPpdu1twc3rJq1/Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tm7+3pxqnczZJgluT2eQfaYbwPrKLwo4NHvB8jtdVIpsS4RWOj3x+QEV+Vjha3CkXKSV9q3+OEoSYL2/qEfdi3ICA/uHIF9wOGYk3ngNerRKNcVs6vmUP4L2aEpDTTGUW9QU3X9nXCXFkEUB4pOZnwzQHRcCE22W+PGARKlKLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wv0y564mjz16PXv;
	Wed, 28 Aug 2024 18:29:01 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 02D6B180106;
	Wed, 28 Aug 2024 18:29:50 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 kwepemg200003.china.huawei.com (7.202.181.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Aug 2024 18:29:48 +0800
Message-ID: <1bb22ebe-3e54-465f-b076-229e999476a7@huawei.com>
Date: Wed, 28 Aug 2024 18:29:48 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Make SMC-R can work with rxe devices
To: Jan Karcher <jaka@linux.ibm.com>, <dust.li@linux.alibaba.com>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <zyjzyj2000@gmail.com>,
	<wenjia@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <0d5e2cec-dd0b-4920-99ff-9299e4df604f@linux.ibm.com>
 <20240821010324.GK103152@linux.alibaba.com>
 <ab89629e-75ec-4750-a4e1-58ad287ce1bd@huawei.com>
 <c841a647-6f5e-4bc2-b637-ef08b9a851a6@linux.ibm.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <c841a647-6f5e-4bc2-b637-ef08b9a851a6@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200003.china.huawei.com (7.202.181.30)



在 2024/8/27 3:04, Jan Karcher 写道:
> 
> 
> On 24/08/2024 12:04, liujian (CE) wrote:
>>
>>
>> 在 2024/8/21 9:03, Dust Li 写道:
>>> On 2024-08-20 15:16:57, Jan Karcher wrote:
>>>>
>>>>
>>>> On 09/08/2024 10:31, Liu Jian wrote:
>>>>> Make SMC-R can work with rxe devices. This allows us to easily test 
>>>>> and
>>>>> learn the SMC-R protocol without relying on a physical RoCE NIC.
>>>>
>>>> Hi Liu,
>>>>
>>>> sorry for taking quite some time to answer.
>>>>
>>>> Looking into this i cannot accept this series at the given point of 
>>>> time.
>>>>
>>>> FWIU, RXE is mainly for testing and development and i agree that it 
>>>> would be
>>>> a nice thing to have for SMC-R.
>>>> The problem is that there is no clean layer for different RoCE devices
>>>> currently. Adding RXE to it works but isn't clean.
>>>
>>> Hi jan,
>>>
>>>> Also we have no way to do a "test" build which would have such a device
>>>> supported and a "prod" build which would not support it.
>>>  > I don't quite understand what you mean here, Maybe I missed 
>>> something ?
>>> IIUC, we can control whether to use RXE by simpling insmod or rmmod 
>>> rdma_rxe.ko
> 
> Hi,
> 
> Yes that enables RXE in general, but not the use of RXE in SMC.
> >>>
>> Yes, in the "prod" environment, we can completely turn off 
>> CONFIG_RDMA_RXE.
> 
> Same as above + this is a compile time switch that is enabled for 
> distros like rh. Simply disabling it won't work here.
> 
Got it, I misunderstood what you meant above. Thank you.
>>
>>> I believe having RXE support is beneficial for testing, especially in
>>> simple physical networking setups where many corner cases are unlikely
>>> to occur. By using RXE, we can easily configure unusual scenarios with
>>> the existing iptables/netfilter infrastructure to simulate real-world
>>> situations, such as packet dropping or network retransmission. This
>>> approach can be advantageous for finding hidden bugs.
>>>
>> Yes, one of my main original intentions was to make testing smc-r 
>> easier. This change is relatively simple, mainly patch2 and patch4, 
>> and there are no logical changes.
> 
> I agree with you. It would be beneficial for testing.
> This is not a never, this is a not right now.
> 
> If you want to push this forward as something you need now, feel free to 
> encapsulate it and introduce a vendor specific experimental option as 
> defined in the v2.1 protocol version [1] for it. This would be 
> compromise for me at the current time.
> 
Got it, thanks.
> Thanks
> - Jan
> 
> [1] 
> https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202.1%20Emulated-ISM_0.pdf
> >>> Best regards,
>>> Dust
>>>
>>>
>>>>
>>>> Please give us time to investigate how to solve this in a neat way 
>>>> without
>>>> building up to much technical debt.
>>>>
>>>> Thanks for your contribution and making us aware of this area of 
>>>> improvment.
>>>> - Jan
>>>>
>>>>>
>>>>> Liu Jian (4):
>>>>>     rdma/device: export ib_device_get_netdev()
>>>>>     net/smc: use ib_device_get_netdev() helper to get netdev info
>>>>>     net/smc: fix one NULL pointer dereference in 
>>>>> smc_ib_is_sg_need_sync()
>>>>>     RDMA/rxe: Set queue pair cur_qp_state when being queried
>>>>>
>>>>>    drivers/infiniband/core/core_priv.h   |  3 ---
>>>>>    drivers/infiniband/core/device.c      |  1 +
>>>>>    drivers/infiniband/sw/rxe/rxe_verbs.c |  2 ++
>>>>>    include/rdma/ib_verbs.h               |  2 ++
>>>>>    net/smc/smc_ib.c                      | 10 +++++-----
>>>>>    net/smc/smc_pnet.c                    |  6 +-----
>>>>>    6 files changed, 11 insertions(+), 13 deletions(-)
>>>>>

