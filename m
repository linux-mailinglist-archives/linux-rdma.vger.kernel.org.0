Return-Path: <linux-rdma+bounces-5768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07AE9BCEDA
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 15:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BE01C22793
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13191D89E2;
	Tue,  5 Nov 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hIvWYoW5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332B1D47B4;
	Tue,  5 Nov 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816080; cv=none; b=NrwIABKlQWe4LIQnmOWiRdP8SpSjWN0JZNg4GT1lbyO66DuRYxWSj9yPaeeG9R9t47pE8TepNpeIflCgbxSZ5nkNe/CrF+yn1vaetWroTR95Fr0oMenXk1LCp87qcdLb+0C7l7fkQppcflBb+K9uZXcxS2jsbINvzpEvcYKZGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816080; c=relaxed/simple;
	bh=Kqu5MOLI8UQuoin1nypQaOBI0itZlJgQwxy0qwbFpVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5RCi0abr/Y1UXZ6Zx2kcxaOozPAHEnMXzd32NOUdUasEUprhLACwli8Note6hLh/LFV329LzXaBn82ufjNuhQElIblOprFLPKTfl3x8MUsiLs8O80CjWw1dCCyba3pnhGZyG5hHwUFy9uSkFVOe3rPBeLshcTs4zXOAWlXRAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hIvWYoW5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5E9lhT006706;
	Tue, 5 Nov 2024 14:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T3RjPV
	UTXRxMDAOFEy6KMlwDz7siDIqeYD+LsmXyBWA=; b=hIvWYoW5QBYFJUQEF4PzpK
	7rsusloMuflEBtniD3TSNApOUvrfsTL3U3xKof3OT3Ymsjb/PvE61jyRciSPhxY4
	pB71Fzkigt33bbKdb6H5m3/ht9+UD6BU5Agn/l3CyD6YZ0/2ruylVj1Bhf+9eAEi
	PAEuPwkNQ3zop5cU0SO30E2D+1eqej007cnkLVvmWOo61YQH1GEHjAvB00AReCZ4
	YqQn3RLXzdaYgcJOOj37qRLHCiMNRQzYbiyjGACuCI8V3l+DgeljV1b6gsHHoson
	TAArV9kBuxXsihw2hc5pXuY1Yr4gTcCJDLqLA/Rt2jOcgvgCt445NiG2xMT9kGxw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qmvrr0pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 14:14:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A5EA54q007870;
	Tue, 5 Nov 2024 14:14:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qmvrr0pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 14:14:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5E1PVn008436;
	Tue, 5 Nov 2024 14:14:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywkgmhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 14:14:31 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A5EEUTC33817280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 14:14:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 382045805A;
	Tue,  5 Nov 2024 14:14:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 414D858061;
	Tue,  5 Nov 2024 14:14:27 +0000 (GMT)
Received: from [9.152.224.138] (unknown [9.152.224.138])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Nov 2024 14:14:27 +0000 (GMT)
Message-ID: <67fb5917-a30d-4b01-9659-72c76ce53c1a@linux.ibm.com>
Date: Tue, 5 Nov 2024 15:14:26 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
To: Leon Romanovsky <leon@kernel.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Nils Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
 <20241027201857.GA1615717@unreal>
 <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>
 <20241105112313.GE311159@unreal>
 <e88d6049-6be1-4967-b88d-94d437900c3d@linux.ibm.com>
 <20241105133955.GF311159@unreal>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241105133955.GF311159@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UV0FQkjNnGGEQGMGD7dIx9CopMdgqroq
X-Proofpoint-ORIG-GUID: 71e6u5L6PCfWnk76TGpzPDdKGw2wtzHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 mlxlogscore=934 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050109



On 05.11.24 14:39, Leon Romanovsky wrote:
> On Tue, Nov 05, 2024 at 01:30:24PM +0100, Wenjia Zhang wrote:
>>
>>
>> On 05.11.24 12:23, Leon Romanovsky wrote:
>>> On Tue, Nov 05, 2024 at 10:50:45AM +0100, Wenjia Zhang wrote:
>>>>
>>>>
>>>> On 27.10.24 21:18, Leon Romanovsky wrote:
>>>>> On Fri, Oct 25, 2024 at 09:23:55AM +0200, Wenjia Zhang wrote:
>>>>>> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
>>>>>> alternative to get_netdev") introduced an API ib_device_get_netdev.
>>>>>> The SMC-R variant of the SMC protocol continued to use the old API
>>>>>> ib_device_ops.get_netdev() to lookup netdev.
>>>>>
>>>>> I would say that calls to ibdev ops from ULPs was never been right
>>>>> thing to do. The ib_device_set_netdev() was introduced for the drivers.
>>>>>
>>>>> So the whole commit message is not accurate and better to be rewritten.
>>>>>
>>>>>> As this commit 8d159eb2117b
>>>>>> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
>>>>>> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
>>>>>> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
>>>>>> device driver.
>>>>>
>>>>> It is not a correct statement too. All modern drivers (for last 5 years)
>>>>> don't have that .get_netdev() ops, so it is not mlx5 specific, but another
>>>>> justification to say that SMC-R was doing it wrong.
>>>>>
>>>>>> Thus, using ib_device_set_netdev() now became mandatory.
>>>>>
>>>>> ib_device_set_netdev() is mandatory for the drivers, it is nothing to do
>>>>> with ULPs.
>>>>>
>>>>>>
>>>>>> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
>>>>>
>>>>> It is too late for me to do proper review for today, but I would say
>>>>> that it is worth to pay attention to multiple dev_put() calls in the
>>>>> functions around the ib_device_get_netdev().
>>>>>
>>>>>>
>>>>>> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
>>>>>> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
>>>>>
>>>>> It is not related to this change Fixes line.
>>>>>
>>>>
>>>> Hi Leon,
>>>>
>>>> Thank you for the review! I agree that SMC could do better. However, we
>>>> should fix it and give enough information and reference on the changes,
>>>> since the code has already existed and didn't work with the old way.
>>>
>>> The code which you change worked by chance and was wrong from day one.
>>>
>>>> I can rewrite the commit message.
>>>>
>>>> What about:
>>>> "
>>>> The SMC-R variant of the SMC protocol still called
>>>> ib_device_ops.get_netdev() to lookup netdev. As we used mlx5 device driver
>>>> to run SMC-R, it failed to find a device, because in mlx5_ib the internal
>>>> net device management for retrieving net devices was replaced by a common
>>>> interface ib_device_get_netdev() in commit 8d159eb2117b ("RDMA/mlx5: Use IB
>>>> set_netdev and get_netdev functions"). Thus, replace
>>>> ib_device_ops.get_netdev() with ib_device_get_netdev() in SMC.
>>>> "
>>>
>>>    The SMC-R variant of the SMC protocol used direct call to ib_device_ops.get_netdev()
>>>    function to lookup netdev. Such direct accesses are not correct for any
>>>    usage outside of RDMA core code.
>>>
>> Is such an absolute statement documented somewhere? If not, I don't think
>> it's convenient that I use it. Maybe you guys as RDMA core maintainer can,
>> not I.
> 
> You can too as it is very clear. All functions which can be used have
> EXPORT_SYMBOL near them, ops.get_netdev() has nothing like that.
> 
>>>    RDMA subsystem provides ib_device_get_netdev() function that works on
>>>    all RDMA drivers returns valid netdev with proper locking an reference
>>>    counting. The commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev
>>>    functions") exposed that SMC-R didn't use that function.
>>>
>>>    So update the SMC-R to use proper API,
>>>
>>> Thanks
>>>
>> mhhh, I'd like to stick to my version, which sounds more neutral IMO. I
>> think the purpose is the same.
> 
> I don't want to argue about the words, my point is that get_netdev() was
> never been the right interface.
> 
> Thanks
> 
Ok, I got you. I'll send v2 with a proper commit message.

Thanks,
Wenjia


