Return-Path: <linux-rdma+bounces-7627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEB4A2ED4A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 14:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1CC166173
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C12236E8;
	Mon, 10 Feb 2025 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g01tbHpz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A51B0F00;
	Mon, 10 Feb 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193250; cv=none; b=GfI/zSoQt1dMtS3UHTu0TWt6pvgDB2z6Mwu1sbxCUGgO251PPnTWE+4zBg9bh5cKAVJW2tXCKYDozx9ovDqfnHnFwo+raDMNFIC38k2672z41HSpWpTjNArdmLTb+Y16GrKU5rjj82qfh4f/4iWhJvAEO/wCgnbq7C+9RMPx9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193250; c=relaxed/simple;
	bh=dgELg2wiAZA+JF3sDD2KDCqfReF5gcMgG9A4PFTS5z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrJ0tWOMXQCe3YgVdvUDcvQbCcOeK8tPDYdOLzbGBne84ZPVoO0FOMc7Gf929CDwEeLtkwnb8B7/yUNnxi1zvX5zQDghDQkw1SnAK667qIG/0YR3HeK4+nEJlLWrsAR+YV40RsWiHxArRTH0taT6DaPdLUSrmWYENq7bX3JmiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g01tbHpz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AD7Cqf025053;
	Mon, 10 Feb 2025 13:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=liKZUk
	lKnfW7FSG+cP7kmEj5EI0edOcw73zB0BbhOAI=; b=g01tbHpzyd1ruka9vGzG1h
	r11GUKZA+zME2x87ySz9sqluhuP5a6o1cuLbbEFX34TSVuJ9dwWw3PxWJUau1/YS
	Qsqs9l2EJskpj6IxzS15iSnDUpIg9oKqa4VrHuWaNHnpxo33xBddlbCaB4qahbme
	9FUy6HzGKAp8sMisMbuBX4zWPOkOgJe8ur7Tr3dOUT5lMgyMTvfrE5P+y3yL7pl7
	DaAwvMdfr1BNrYKGBNcsJYhJrGiZ13A2fPFVCZdfbg1I84MI7bn09yeJXQn9ewNA
	n1wHjW8n/PL1AfY3YRycp7Csz1RJKwqUp83/SdkRbHAVEZzgXpQYPg20jO01PzXA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q7h9awrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:14:03 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51ADAckm023201;
	Mon, 10 Feb 2025 13:14:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q7h9awrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:14:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9s5Jc028716;
	Mon, 10 Feb 2025 13:14:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma1e1qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:14:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ADE08729557486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 13:14:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6135058052;
	Mon, 10 Feb 2025 13:14:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 119295805D;
	Mon, 10 Feb 2025 13:13:58 +0000 (GMT)
Received: from [9.171.86.231] (unknown [9.171.86.231])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 13:13:57 +0000 (GMT)
Message-ID: <08cd6e15-3f8c-47a0-8490-103d59abf910@linux.ibm.com>
Date: Mon, 10 Feb 2025 14:13:57 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
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
 <3dc68650-904c-4a1d-adc4-172e771f640c@linux.alibaba.com>
 <4339aaa1-f2aa-4454-b5b1-6ffb6415f484@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <4339aaa1-f2aa-4454-b5b1-6ffb6415f484@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 15FTV8EPZQmyyWbTChmRah1YMwx5izSU
X-Proofpoint-ORIG-GUID: -iSYw6egEIudQfx3bahwkPDXquKxr180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502100109



On 10.02.25 12:16, Guangguan Wang wrote:
> 
> 
> On 2025/1/15 19:53, Guangguan Wang wrote:
>>
>>
>> On 2025/1/14 20:07, Halil Pasic wrote:
>>> On Fri, 10 Jan 2025 13:43:44 +0800
>>> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
>>>
>>>>> I think I showed a valid and practical setup that would break with your
>>>>> patch as is. Do you agree with that statement?
>>>> Did you mean
>>>> "
>>>> Now for something like a bond of two OSA
>>>> interfaces, I would expect the two legs of the bond to probably have a
>>>> "HW PNETID", but the netdev representing the bond itself won't have one
>>>> unless the Linux admin defines a software PNETID, which is work, and
>>>> can't have a HW PNETID because it is a software construct within Linux.
>>>> Breaking for example an active-backup bond setup where the legs have
>>>> HW PNETIDs and the admin did not bother to specify a PNETID for the bond
>>>> is not acceptable.
>>>> " ?
>>>> If the legs have HW pnetids, add pnetid to bond netdev will fail as
>>>> smc_pnet_add_eth will check whether the base_ndev already have HW pnetid.
>>>>
>>>> If the legs without HW pnetids, and admin add pnetids to legs through smc_pnet.
>>>> Yes, my patch will break the setup. What Paolo suggests(both checking ndev and
>>>> base_ndev, and replace || by && )can help compatible with the setup.
>>>
>>> I'm glad we agree on that part. Things are much more acceptable if we
>>> are doing both base and ndev.
>> It is also acceptable for me.
>>
>>> Nevertheless I would like to understand
>>> your problem better, and talk about it to my team. I will also ask some
>>> questions in another email.
>> Questions are welcome.
>>
>>>
>>> That said having things work differently if there is a HW PNETID on
>>> the base, and different if there is none is IMHO wonky and again
>>> asymmetric.
>>>
>>> Imagine the following you have your nice little setup with a PNETID on
>>> a non-leaf and a base_ndev that has no PNETID. Then your HW admin
>>> configures a PNETID to your base_ndev, a different one. Suddenly
>>> your ndev PNETID is ignored for reasons not obvious to you. Yes it is
>>> similar to having a software PNETID on the base_ndev and getting it
>>> overruled by a HW PNETID, but much less obvious IMHO. I am wondering if there are any scenarios that require setting different
>> pnetids for different net devices in one netdev hierarchy. If no, maybe
>> we should limit that only one pnetid can be set to one netdev hierarchy.
>>
>>> I also think
>>> a software PNETID of the base should probably take precedence over over
>>> the software pnetid of ndev.
>> Agree!
>>
>> Thanks,
>> Guangguan Wang
>>>
>>> Regards,
>>> Halil
> 
> Hi Halil,
> 
> Are there any questions or further discussions about this patch? If no, I will
> send a v2 patch, in which software pnetid will be searched in both base_ndev and ndev,
> and base_ndev will take precedence over ndev.
> 
> Thanks,
> Guangguan Wang
> 
> 

Hi Guangguan,

Thank you for the detailed description and examples; I understand your 
situation better now. Paolo's suggestions (checking both ndev and 
base_ndev, and replacing || with &&) could indeed serve as a workaround 
for certain setups like yours. However, they might also introduce 
invalid topologies, one example is what Halil mentioned.

Therefore, neither suggestion is fully acceptable, whether from you or 
from Paolo. I agree that we should restrict it so that only one pnetid 
can be assigned to a single netdev hierarchy, based on the base ndev.

One preliminary idea I have is to enhance the smc_pnet -a -I <ethx> 
<pnetid> command to analyze the entire hierarchy first, ensuring that 
only one pnetid is assigned per netdev hierarchy.

Thanks,
Wenjia


