Return-Path: <linux-rdma+bounces-13179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCCB4A3F5
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 09:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEAA3A5D88
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 07:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CE13081DE;
	Tue,  9 Sep 2025 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VqfekS3L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BF3054CB;
	Tue,  9 Sep 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403398; cv=none; b=JqGf7lKT9UX+FgXBWXsWJva+OUbPJ77zJkLcd8b2GPTqk6W1/0GAXD7WPXTia02275xoz26kGG0599j/JMrfEKuGCYnEIEVa1h8FfHRo/sspMJYMMAGLLvLzsyaWocVBtdNO98o88zR602k7dFYn1CtNZ92uaUePCaYP865zTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403398; c=relaxed/simple;
	bh=GKTJ9zwWjCqTdKx2Z4c0O6s6gAqAGyE2tNuuwrbnrFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yy9xKSz06st/aIIdttae2lqyAIU72DNljpDoZpPVKIy5FgMIIWxnULsQlzsEKEPNw0MMU7Ru6baQnqxx3RYphGk/G7UF12vDMUlQtVT/cSAAflj0SndyMjY2f/gQ/NRggfrG0Go8DfE/sjID4ONJ3GZYuIxeaGH/a85G8ONNUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VqfekS3L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588ISPjv004056;
	Tue, 9 Sep 2025 07:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fLqLiy
	90xPT5ezP6wcKtVEJhNJSIHQ8CucawHoBny+Q=; b=VqfekS3LrlsVWFCtEK2Ss8
	bXc1pAopPNxvNVmlTx5EXax7GVNoWRwXTC80IDjUJFGk2bJUnjTJRnQG+ODosIB+
	LzNyiQ8BjnXsznuUtk5GpfZTGz61qc25VcMqt3f74sm02SRsY1YkG4MXlp8THHxA
	xINyhQZkmmTt7EUtJ9NwBjGju5+NCcDV7tMQsrbjP1iHqSxgjznputmXGOhewnkB
	T3v8AzwRXm1w+xys8RYH+kOq9NUAIz9BnwrIrFGbhCETkwS2oo1VSzxHKzjYNQ61
	b42JAAdPevkNZ9PnZ3q0SNuB1ixoT10f9iEmntQytRPzsKLGgGpdcMSB/MaaAI3Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff68sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:36:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5897WYS1021657;
	Tue, 9 Sep 2025 07:36:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff68sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:36:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5896t4KR010594;
	Tue, 9 Sep 2025 07:36:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smsw0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:36:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5897aOsw34407116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 07:36:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAB562004B;
	Tue,  9 Sep 2025 07:36:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B09A20043;
	Tue,  9 Sep 2025 07:36:23 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 07:36:23 +0000 (GMT)
Message-ID: <b2c1b2b9-ce28-4a20-bf48-a427b364a664@linux.ibm.com>
Date: Tue, 9 Sep 2025 09:36:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/14] net/dibs: Create net/dibs
To: dust.li@linux.alibaba.com, "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250905145428.1962105-1-wintera@linux.ibm.com>
 <20250905145428.1962105-4-wintera@linux.ibm.com>
 <aL-IwWQN7ZUNdjky@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aL-IwWQN7ZUNdjky@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XIpSC8Rjib3zC30Ue_TsZMTkBcTCTq8t
X-Proofpoint-GUID: zZcQcV2Gw4fgq1Lv3_XhkLw6u79bajUp
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68bfd8fd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=0wItxlQjZ1fOYUEzXWQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX1LFft8DgMuwG
 D6g53JpjwvxRzvLF4wKMaw/D0vBFi5L78fW1NqYyc+j4tlrjspp7ZXxQlMyOEVaztp+XSlMuGZh
 qpKeHVWzVOR7TWw1QVDTa0j4d41DgobCHUgYH0JALIxGNhmPCULcfwmkb8xFJN5qS6+b4DJhV/8
 PDkgkz7PxK5gY8X5j1IBwiI0DCYePdq8eQ0ashfZpAahYzVxWuGS5wNaNwpgkwZK1VNFYxUjid2
 zUGMcFI7wkXvAH9EBqzycCKByB+Rw2VP2xXpwGwbB6/k3DMSmR5b/aDTzfQ41loN4vbKVWQGx2Y
 8MY0mZNJhH8iOUlZFZ8c8nbxiThKMpuXDmgnRAzY2aOGDR2julPhTMnSYfuYMImHqZ8mm4pTixV
 6gYOCGJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 09.09.25 03:54, Dust Li wrote:
> On 2025-09-05 16:54:16, Alexandra Winter wrote:
>> Create an 'DIBS' shim layer that will provide generic functionality and
>> declarations for dibs device drivers and dibs clients.
>>
>> Following patches will add functionality.
>>
>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>> ---
>> MAINTAINERS          |  7 +++++++
>> include/linux/dibs.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>> net/Kconfig          |  1 +
>> net/Makefile         |  1 +
>> net/dibs/Kconfig     | 12 ++++++++++++
>> net/dibs/Makefile    |  7 +++++++
>> net/dibs/dibs_main.c | 37 +++++++++++++++++++++++++++++++++++++
>> 7 files changed, 107 insertions(+)
>> create mode 100644 include/linux/dibs.h
>> create mode 100644 net/dibs/Kconfig
>> create mode 100644 net/dibs/Makefile
>> create mode 100644 net/dibs/dibs_main.c
> 
> I recall we previously discussed the issue of which directory to place
> it in, and I don't have any strong preference regarding this. However,
> I'm not sure whether we reached an agreement on this point. In my
> opinion, placing it under the drivers/ directory seems more reasonable.
> But if net/ is OK, that works for me too.
> 
> Best regards,
> Dust
> 
> 

You mean like drivers/infiniband that provides sys/class/infiniband?
I don't have any strong feelings about where to place the directory.
Are there any practical consequences?
Other opinions?

