Return-Path: <linux-rdma+bounces-12669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B37ACB2084C
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 14:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B079C18C723E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A2F2D320B;
	Mon, 11 Aug 2025 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PoqalxfZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E271624C0;
	Mon, 11 Aug 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913849; cv=none; b=lpA9IMCbNoPpXou/FZcpyoJs3yj2epveGRsL3yJqAM5wc3owjFxkJXL+TGcJA6ribyMf5fHeN7vanY6kUyq7jUX5PFHRwHyrAWATgLOF74ELyuazBgybDo/tMyhpo8JAj1HNFOGHzsCH3R6iX1QUTZ8D8sOlSGdTxFhPbN0uVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913849; c=relaxed/simple;
	bh=lm+ouShfqBZyDuwu2KdrlGuXVTVGvV9mQhjXOtv8dK8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dn96ghIJuKCmXnC6h9e5Vj8rhqOtIk3fR5Ww048cvXV/7bpZRn9hhGW2AJTRBQPSpcs2j4e61uO7f96j8YjVSaFcXWj7np1n3mkylOaqNFQigOxePZrEmAXJdeo09jM17GE9KSGDDDhLIN50dCF4r8MjlhdQ/547rtJZv4qzDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PoqalxfZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B0FB4t022505;
	Mon, 11 Aug 2025 12:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wy4XGq
	VU9285DpdABIdNH1KfETiuPuhyzLvlJu9ehiw=; b=PoqalxfZuBICw9OH4zSchZ
	nXibV4c0PVzn96nOazUhsYZAf7oydgCTqnt0w3NBc+1l1ktnckm4x/wkdFoD1aSJ
	Pk4FBntFWmBjQnSciWqN1lF8BDp41cnse686yF0AIhuzwXHE3NfYUgc2GkHQ+zvM
	65yTN1Cyjwoc7hJ7O2jOjOTolG4nPdZ77s7bIqIM3iMSiv1gO9VkuttT14HjBtSr
	CoOnts80ICHsbMihtpTUbJXoakwp8kdCq0NEyfhMm6iIf9MM0k/fbfDUXY9IWcSB
	YGtzHdZ9xAVZpkpQo63HOOSWL09AzdDlZIJMRLnmotCJY3Dr13cw9yzGwRiMcz/w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duru14uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 12:03:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BC3xIl012736;
	Mon, 11 Aug 2025 12:03:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duru14ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 12:03:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BC0M7o017617;
	Mon, 11 Aug 2025 12:03:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3dcbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 12:03:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BC3sbs53412312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:03:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D2F92004B;
	Mon, 11 Aug 2025 12:03:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29FB420043;
	Mon, 11 Aug 2025 12:03:54 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 12:03:54 +0000 (GMT)
Message-ID: <96d21746-e374-4235-a567-2a7343060fe4@linux.ibm.com>
Date: Mon, 11 Aug 2025 14:03:53 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 04/17] net/smc: Decouple sf and attached send_buf
 in smc_loopback
From: Alexandra Winter <wintera@linux.ibm.com>
To: dust.li@linux.alibaba.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-5-wintera@linux.ibm.com>
 <aJimDiQupacKNR8M@linux.alibaba.com>
 <c0802092-ee94-471d-8f9c-9a0fa5f95476@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <c0802092-ee94-471d-8f9c-9a0fa5f95476@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1ONICqvB-BcwSD_v3iRgCBQgiyTgN2Rc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3OCBTYWx0ZWRfX9bnT183iKMb3
 dH+h6CxY5HczfzidZ6y0wR2CaUqQU+iwvhJk67HgmBUR5efp6Xz7ZKNwDmSDIcBTYJ/8F7AfH6j
 TXwMVtkNZhH1CdSRHvX+iDSYn6Aaom0em/DQiJJfKElibwIL5HYRlO5DoIKNfAzvNoe9b9522Kk
 5gViLKcNwUrbzK9Iic4tS8/4GhVUb0obutYltdZmnQWYrBW1BpxfY7xAqC3/suJrfxR+MCxlriW
 MCqatPfNmsIohpJOfTEDp574vOUiTOBVA53jtGOLBLzTFnJ9beqZ6mU8Czohm5SOJbTdBPoSJ3Q
 Hz2r9mTPIq/HvkBAI6AGe4Zy0cXLzK8ajjTICo6k+7SPobL8Qy8ID+3LmCx7WnZ7wulr+XSaPd1
 HDOSNuvpsF6IlStUH+g3sNUXheBnkH62G1neIBzv9RDCXGMOIGR1C/UBq189FZxM35lmmOgO
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=6899dc2f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=SRrdq9N9AAAA:8 a=SBu4e9Kr8Di_8VYdYKsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qF9wf0q5uyYcXbOG4Ygh5FRzpIo9twit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=747 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110078



On 11.08.25 13:35, Alexandra Winter wrote:
> 
> 
> On 10.08.25 16:00, Dust Li wrote:
>> On 2025-08-06 17:41:09, Alexandra Winter wrote:
> [...]
>>>
>>> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>>> index 48a1b1dcb576..fe5f48d14323 100644
>>> --- a/net/smc/smc_core.h
>>> +++ b/net/smc/smc_core.h
>>> @@ -13,6 +13,7 @@
>>> #define _SMC_CORE_H
>>>
>>> #include <linux/atomic.h>
>>> +#include <linux/types.h>
>>> #include <linux/smc.h>
>>> #include <linux/pci.h>
>>> #include <rdma/ib_verbs.h>
>>> @@ -221,12 +222,16 @@ struct smc_buf_desc {
>>> 					/* virtually contiguous */
>>> 		};
>>> 		struct { /* SMC-D */
>>> +			 /* SMC-D rx buffer: */
>>> 			unsigned short	sba_idx;
>>> 					/* SBA index number */
>>> 			u64		token;
>>> 					/* DMB token number */
>>> 			dma_addr_t	dma_addr;
>>> 					/* DMA address */
>>> +			/* SMC-D tx buffer */
>>> +			bool		is_attached;
>>> +					/* no need for explicit writes */
>>
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>>
>> A small sugguestion: there is a hole between sba_idx and token, we can
>> put is_attached in that hole.
>> Not a big deal because this is a union and SMC-R use a much large space.
>>
>> Best regards,
>> Dust
>>
> 
> Thank you very much for your throrough reviews of this series, Dust.
> 
> I put 'bool is_attached' in this place, so I could add the comments about which members
> are used for rx-buffers and which for tx-buffers.
> I find the struct smc_buf_desc a bit confusing and thought these comments would be helpful.
> Is it ok for you to leave it that way?


I hit send too fast. Obviously I can put it above sba_idx. That will reduce the hole  by 1 byte.
Changed for next version.

