Return-Path: <linux-rdma+bounces-4574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368195F95F
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 21:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A96D283DF5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 19:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EDF191473;
	Mon, 26 Aug 2024 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZupSfwJu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDC80027;
	Mon, 26 Aug 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699100; cv=none; b=ql3sawwMFz8sx0K9iPQi0HPfkejQzXDUahBms+AGSuZJZxhXuUt1EmKlubiUWjric2SMipQd1jz9dBwJqaq9HVbT+xXU2iA4RJ9oIx7KDc2qYoW5U+QCXxdnO/935K6XSe3xboA1Ej6MRnaPsQXbLGMzbALIdczuM4UVS2sf/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699100; c=relaxed/simple;
	bh=koiNfTIn4U0/8vi4PdZ2K2+ASxUGNBj5PULefhJADMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SRU5EuzWEKObTl2yon2tPOOhFSKVfRpeRUCE/mscORLXCOEFqMQ4XrembeNP6rMWmEGjJ965L/RROKh3T3NhsIYb63dUO7WYxxlWVCDWbVQTssDeWdfyJVtxdYW4dtS6ZLVK+P8gBKXFgcRAe66nfFlOqsZqOOcC7QzOw/NgoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZupSfwJu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QGAdGR023902;
	Mon, 26 Aug 2024 19:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	1QAL+iCibHhle5hn0PIEt3woSyuVhCTJWNv3nZI4aI4=; b=ZupSfwJu0kDZQfeW
	nM9Nw1yjZYGv2IlJyp3kVUE6Bewy3WzGvM3OOUlNoOh7jlEPioaFZGni3TRH/PVW
	FAn2pXpq5/hQylibqKAeWa8u7BW8HxMWKOvTOaG8nzgytUqmIfZoa2Zw6NHYHyXq
	d2WTPXE4+5NEyEc+oft1nkOUwPLtXq83CtSAbG0jINcdyiIediT5K0LRV8R+Qx6i
	k7akDm0EUAShfBoAqkD6M4YB0gZ7dkjinUj7z4H8k4itjnwbLPvBj0mQRTsdP0ff
	Yqokrq6OVQ/enkNnC9Jfbt/u4WeRIG7CxlYq6fJRni/2Gjstne/UxcFSxci4jEbE
	hNx6aw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417g9n825a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 19:04:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47QJ4g6C015902;
	Mon, 26 Aug 2024 19:04:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417g9n8255-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 19:04:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47QHM5AL003137;
	Mon, 26 Aug 2024 19:04:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417tupqda2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 19:04:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47QJ4dnc52625884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 19:04:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BEE220043;
	Mon, 26 Aug 2024 19:04:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5757A2004B;
	Mon, 26 Aug 2024 19:04:38 +0000 (GMT)
Received: from [9.171.82.113] (unknown [9.171.82.113])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Aug 2024 19:04:38 +0000 (GMT)
Message-ID: <c841a647-6f5e-4bc2-b637-ef08b9a851a6@linux.ibm.com>
Date: Mon, 26 Aug 2024 21:04:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Make SMC-R can work with rxe devices
To: "liujian (CE)" <liujian56@huawei.com>, dust.li@linux.alibaba.com,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com, wenjia@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <0d5e2cec-dd0b-4920-99ff-9299e4df604f@linux.ibm.com>
 <20240821010324.GK103152@linux.alibaba.com>
 <ab89629e-75ec-4750-a4e1-58ad287ce1bd@huawei.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <ab89629e-75ec-4750-a4e1-58ad287ce1bd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f0-hDKoi1y0DeC_MgOM7pgDtHQO5n31c
X-Proofpoint-ORIG-GUID: BZ-xp8NYPaGTVCirMt-T7rKKWNCcI-CQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_14,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=815 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408260145



On 24/08/2024 12:04, liujian (CE) wrote:
> 
> 
> 在 2024/8/21 9:03, Dust Li 写道:
>> On 2024-08-20 15:16:57, Jan Karcher wrote:
>>>
>>>
>>> On 09/08/2024 10:31, Liu Jian wrote:
>>>> Make SMC-R can work with rxe devices. This allows us to easily test and
>>>> learn the SMC-R protocol without relying on a physical RoCE NIC.
>>>
>>> Hi Liu,
>>>
>>> sorry for taking quite some time to answer.
>>>
>>> Looking into this i cannot accept this series at the given point of 
>>> time.
>>>
>>> FWIU, RXE is mainly for testing and development and i agree that it 
>>> would be
>>> a nice thing to have for SMC-R.
>>> The problem is that there is no clean layer for different RoCE devices
>>> currently. Adding RXE to it works but isn't clean.
>>
>> Hi jan,
>>
>>> Also we have no way to do a "test" build which would have such a device
>>> supported and a "prod" build which would not support it.
>>  > I don't quite understand what you mean here, Maybe I missed 
>> something ?
>> IIUC, we can control whether to use RXE by simpling insmod or rmmod 
>> rdma_rxe.ko

Hi,

Yes that enables RXE in general, but not the use of RXE in SMC.

>>
> Yes, in the "prod" environment, we can completely turn off CONFIG_RDMA_RXE.

Same as above + this is a compile time switch that is enabled for 
distros like rh. Simply disabling it won't work here.

> 
>> I believe having RXE support is beneficial for testing, especially in
>> simple physical networking setups where many corner cases are unlikely
>> to occur. By using RXE, we can easily configure unusual scenarios with
>> the existing iptables/netfilter infrastructure to simulate real-world
>> situations, such as packet dropping or network retransmission. This
>> approach can be advantageous for finding hidden bugs.
>>
> Yes, one of my main original intentions was to make testing smc-r 
> easier. This change is relatively simple, mainly patch2 and patch4, and 
> there are no logical changes.

I agree with you. It would be beneficial for testing.
This is not a never, this is a not right now.

If you want to push this forward as something you need now, feel free to 
encapsulate it and introduce a vendor specific experimental option as 
defined in the v2.1 protocol version [1] for it. This would be 
compromise for me at the current time.

Thanks
- Jan

[1] 
https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202.1%20Emulated-ISM_0.pdf

>> Best regards,
>> Dust
>>
>>
>>>
>>> Please give us time to investigate how to solve this in a neat way 
>>> without
>>> building up to much technical debt.
>>>
>>> Thanks for your contribution and making us aware of this area of 
>>> improvment.
>>> - Jan
>>>
>>>>
>>>> Liu Jian (4):
>>>>     rdma/device: export ib_device_get_netdev()
>>>>     net/smc: use ib_device_get_netdev() helper to get netdev info
>>>>     net/smc: fix one NULL pointer dereference in 
>>>> smc_ib_is_sg_need_sync()
>>>>     RDMA/rxe: Set queue pair cur_qp_state when being queried
>>>>
>>>>    drivers/infiniband/core/core_priv.h   |  3 ---
>>>>    drivers/infiniband/core/device.c      |  1 +
>>>>    drivers/infiniband/sw/rxe/rxe_verbs.c |  2 ++
>>>>    include/rdma/ib_verbs.h               |  2 ++
>>>>    net/smc/smc_ib.c                      | 10 +++++-----
>>>>    net/smc/smc_pnet.c                    |  6 +-----
>>>>    6 files changed, 11 insertions(+), 13 deletions(-)
>>>>

