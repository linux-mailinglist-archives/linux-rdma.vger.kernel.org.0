Return-Path: <linux-rdma+bounces-12668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F66B207FA
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 13:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A38E18C4512
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2FE2D0C85;
	Mon, 11 Aug 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fNHH0/5d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1F145A05;
	Mon, 11 Aug 2025 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912161; cv=none; b=FIPbbYWoz6XuqhqOIR/NwgbzwLYHbWdQ3S0xBkiEw1g5iCHlp7vIyPzwozvHMHTm0EdqwtIY5X/0WbD7Mn30Qz+e1oz3J1mcIxNGfNFk34AkmqcoaO1cT5zz6irQjkl1FdJ+cbN9nX43y8LIV2LXD29ogRBJdYc40JcaISZD8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912161; c=relaxed/simple;
	bh=kk2jUZtbpRJA7kgQrIrlawD64s2yJu90M/gS8hO+X28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESU39WBdX4rC93/s/++vMcgN12zrzQayuvapARRI5hijlaRMtA56xe9H2PZAlr9XCjHEY0HzEh5IzZPfwg+G8aE2wHDfWOfTOZcEYzJDqyN2rwFwIvHWM0R+jpCbYI6LhzF3BGQcfHP2nExtgQccsreZi78gTQf4CY+GVFJwkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fNHH0/5d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BAYr2p028932;
	Mon, 11 Aug 2025 11:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tezKjs
	op462stJIzIYjynELhPCJfpl4j6bup6XcQ2pM=; b=fNHH0/5d3OUc+5fdfAlK3O
	4KbwpiWRdxw16DchRFLEPRKSMsyMqhbyel66cHx3cVTnDZ1hmE48EXEGxK6AkYIy
	F5ZdvAtuBp8LObIBi/C9Fh9eyhHBatbKdYMLjZydATNeuVEDbMnYl/qhgSQsHDuR
	qXToJFdo/6ZAoKMp6A+mIVk/RUPGebZgT+KAY9ODMQKM8a988JOebxfhmCje4DU6
	QN6pLWzhBW7864boCi9bveR1eYKSUnCKi9rj/SVHDaRqNy41da49uE3I5ZtLaJpV
	Kccm4jQrDdnqMsYax6z2elDecwvf25J65L3GAXeiCGSlYBbRMRQDaqmaBTuiYs9A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cry54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 11:35:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BBX11V026540;
	Mon, 11 Aug 2025 11:35:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cry51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 11:35:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BBEoKf025713;
	Mon, 11 Aug 2025 11:35:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvm5cqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 11:35:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BBZkUZ62718426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 11:35:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C8C120043;
	Mon, 11 Aug 2025 11:35:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D0E820040;
	Mon, 11 Aug 2025 11:35:46 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 11:35:46 +0000 (GMT)
Message-ID: <c0802092-ee94-471d-8f9c-9a0fa5f95476@linux.ibm.com>
Date: Mon, 11 Aug 2025 13:35:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 04/17] net/smc: Decouple sf and attached send_buf
 in smc_loopback
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
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aJimDiQupacKNR8M@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX2b0hh6JKtg1H
 FKHMxkt4LxpUOFbqck6PKE+k9t/83EMSEOImlI0e7CdgRcHct9bUC1kiDgy4e3gEAZyl6dTiKTi
 rMlkJx4VPlxYB8Ruy0LFSfaYOEeoZYsnwSNP9z0Haqilvvt7pOlAaCKFs0EXonv4/Awu1mgK4uZ
 ODZW4vA0qyLm9E37NFREXGbBgFEAs+9rOlHkTj7npJK7RkuEN4/KhGZxRl5076XVEhB6D/Du3D9
 j6c3Pm0rKwE7XnCriJMPTwgD1PGrqoQ+fX4+lp8J1nzPA3vCe01ovi0RHTOEs0BtGa7d2wWNMJh
 TxDJZhZMNTPQ1cA0j6M8b0vfOlUUPzBCattQHgKQLPhqSp3vk9eUWVbfXizryU5+xxBo36k0N4O
 eVmAKWCneyO1SLVOQgCcNzStxxVLOsxwELmTF1ZJkXlEkLTbwhmLVyCkS9uH+p+fMMyjfcys
X-Proofpoint-GUID: pmG4TemG8mMaYgqYIM5MSGD7CpvrRcBR
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=6899d598 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=SRrdq9N9AAAA:8 a=AIof7kV_9tTG47cDTB0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: g79wIlizR1NVRmFb46EUI1XK3tMfRZx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=588 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110075



On 10.08.25 16:00, Dust Li wrote:
> On 2025-08-06 17:41:09, Alexandra Winter wrote:
[...]
>>
>> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>> index 48a1b1dcb576..fe5f48d14323 100644
>> --- a/net/smc/smc_core.h
>> +++ b/net/smc/smc_core.h
>> @@ -13,6 +13,7 @@
>> #define _SMC_CORE_H
>>
>> #include <linux/atomic.h>
>> +#include <linux/types.h>
>> #include <linux/smc.h>
>> #include <linux/pci.h>
>> #include <rdma/ib_verbs.h>
>> @@ -221,12 +222,16 @@ struct smc_buf_desc {
>> 					/* virtually contiguous */
>> 		};
>> 		struct { /* SMC-D */
>> +			 /* SMC-D rx buffer: */
>> 			unsigned short	sba_idx;
>> 					/* SBA index number */
>> 			u64		token;
>> 					/* DMB token number */
>> 			dma_addr_t	dma_addr;
>> 					/* DMA address */
>> +			/* SMC-D tx buffer */
>> +			bool		is_attached;
>> +					/* no need for explicit writes */
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> 
> A small sugguestion: there is a hole between sba_idx and token, we can
> put is_attached in that hole.
> Not a big deal because this is a union and SMC-R use a much large space.
> 
> Best regards,
> Dust
> 

Thank you very much for your throrough reviews of this series, Dust.

I put 'bool is_attached' in this place, so I could add the comments about which members
are used for rx-buffers and which for tx-buffers.
I find the struct smc_buf_desc a bit confusing and thought these comments would be helpful.
Is it ok for you to leave it that way?

