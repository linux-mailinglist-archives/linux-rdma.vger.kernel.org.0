Return-Path: <linux-rdma+bounces-4560-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CF95DD4F
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB69D281ADF
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38D15532E;
	Sat, 24 Aug 2024 10:04:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1604414F136;
	Sat, 24 Aug 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724493856; cv=none; b=TS8LDVdBSXGsM8IyOBSZQKvTt1Pz0QTe7dKbQA2tQjJHoC5rOJK/mcsxOiFtjTWZUe3luNnyS6041wTJHq9Z9rp4LnnwMPZ5i1HO/A3/AsW+kW1detyKuLjraSKGAWpO3rkll4Qewn9HsUnsYynj3+EkttRo066FyTbjh1vK1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724493856; c=relaxed/simple;
	bh=njeP+h34U6W3JE+KF+0905EF3iYY9Fomt6Loi15uMYM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Wd8EeCuXompJdibEN1w83mMbhJAEJCnnPDNDcjYsF2v6SrmuhH5M/cg/ttnoE0iF+bIqvpkiLRUOTSFx2sU9+RBG6C9lnwsnqNYu7j0QcdlNKB6xySJNg73QcztK6565I6H9ZVDyBqDyQiEvMKA5470+CfLbQQZowQug7FZmQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WrXZS2P0VzpVkN;
	Sat, 24 Aug 2024 18:03:28 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 75B711800F2;
	Sat, 24 Aug 2024 18:04:11 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 kwepemg200003.china.huawei.com (7.202.181.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 24 Aug 2024 18:04:10 +0800
Message-ID: <ab89629e-75ec-4750-a4e1-58ad287ce1bd@huawei.com>
Date: Sat, 24 Aug 2024 18:04:09 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "liujian (CE)" <liujian56@huawei.com>
Subject: Re: [PATCH net-next 0/4] Make SMC-R can work with rxe devices
To: <dust.li@linux.alibaba.com>, Jan Karcher <jaka@linux.ibm.com>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <zyjzyj2000@gmail.com>,
	<wenjia@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <0d5e2cec-dd0b-4920-99ff-9299e4df604f@linux.ibm.com>
 <20240821010324.GK103152@linux.alibaba.com>
In-Reply-To: <20240821010324.GK103152@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200003.china.huawei.com (7.202.181.30)



在 2024/8/21 9:03, Dust Li 写道:
> On 2024-08-20 15:16:57, Jan Karcher wrote:
>>
>>
>> On 09/08/2024 10:31, Liu Jian wrote:
>>> Make SMC-R can work with rxe devices. This allows us to easily test and
>>> learn the SMC-R protocol without relying on a physical RoCE NIC.
>>
>> Hi Liu,
>>
>> sorry for taking quite some time to answer.
>>
>> Looking into this i cannot accept this series at the given point of time.
>>
>> FWIU, RXE is mainly for testing and development and i agree that it would be
>> a nice thing to have for SMC-R.
>> The problem is that there is no clean layer for different RoCE devices
>> currently. Adding RXE to it works but isn't clean.
> 
> Hi jan,
> 
>> Also we have no way to do a "test" build which would have such a device
>> supported and a "prod" build which would not support it.
>  > I don't quite understand what you mean here, Maybe I missed something ?
> IIUC, we can control whether to use RXE by simpling insmod or rmmod rdma_rxe.ko
> 
Yes, in the "prod" environment, we can completely turn off CONFIG_RDMA_RXE.

> I believe having RXE support is beneficial for testing, especially in
> simple physical networking setups where many corner cases are unlikely
> to occur. By using RXE, we can easily configure unusual scenarios with
> the existing iptables/netfilter infrastructure to simulate real-world
> situations, such as packet dropping or network retransmission. This
> approach can be advantageous for finding hidden bugs.
> 
Yes, one of my main original intentions was to make testing smc-r 
easier. This change is relatively simple, mainly patch2 and patch4, and 
there are no logical changes.
> Best regards,
> Dust
> 
> 
>>
>> Please give us time to investigate how to solve this in a neat way without
>> building up to much technical debt.
>>
>> Thanks for your contribution and making us aware of this area of improvment.
>> - Jan
>>
>>>
>>> Liu Jian (4):
>>>     rdma/device: export ib_device_get_netdev()
>>>     net/smc: use ib_device_get_netdev() helper to get netdev info
>>>     net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()
>>>     RDMA/rxe: Set queue pair cur_qp_state when being queried
>>>
>>>    drivers/infiniband/core/core_priv.h   |  3 ---
>>>    drivers/infiniband/core/device.c      |  1 +
>>>    drivers/infiniband/sw/rxe/rxe_verbs.c |  2 ++
>>>    include/rdma/ib_verbs.h               |  2 ++
>>>    net/smc/smc_ib.c                      | 10 +++++-----
>>>    net/smc/smc_pnet.c                    |  6 +-----
>>>    6 files changed, 11 insertions(+), 13 deletions(-)
>>>

