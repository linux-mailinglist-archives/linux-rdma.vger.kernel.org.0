Return-Path: <linux-rdma+bounces-12632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447C1B1EE6E
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 20:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1622A0571A
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A0201033;
	Fri,  8 Aug 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GfDYfQFa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31F1DA3D;
	Fri,  8 Aug 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754678317; cv=none; b=aQWVruAWaJliCFszjY5YPo7gSM1fMNmMgY03W4J3EIAg3hI3NfPs/7uhMoWQkp4Px0f0joUgkUqH/F/WNl2jgMd+rv4QMotSZKkD26J4w4DiO78LLOZTQaLv+ClpbqlCDQfrcKHkvO6rhWzFAyMu+nIqumzOhIK8VXKQ+v/YC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754678317; c=relaxed/simple;
	bh=gS1CfvAmAzoYzSl22BSTUD9SnpZMcygLfpvgMPsP7Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVqtt/O5aqZup05pgMvoY2tExhrPESzG05S+fsz8g6aiy5RNpvi6HSGCzFVm8aqsQLS83ZQ+vAeTn1i8p8Iu9BC9H5EgUTCKAqZo+wvziUOk6i37Qc+LWrB/T+FwWQh31yJUgfwcW1gBmSS22dljxAwnSesSixuvIrHe+H+D7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GfDYfQFa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578EgOwX017997;
	Fri, 8 Aug 2025 18:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=URUHTb
	3LndAM8gG5DzkOSpTTouK2xOMOfTYc5sMjNPQ=; b=GfDYfQFaTb9gXnY5xZygLX
	4uMOdsTKq/yGClbOIm3E0CSe4Orrfc+IkBvA+/QYbVS1a5KM95WVCYYxq/x7KooP
	yqRxPc5mJo5HZ6QgQOPIB3SKRIvIkyjvdTaeewB1WGlkp909P+ZH09FuuD6iHKhJ
	YwbMdxM7WwCE3pIfAGYnqqsOytcE+xLkQwtU6UXIMrGFFVguwqUSy4H/5ubJdwuy
	AJOsOHnoLi7CLZDU/KpGhLC5u2ZraXtZj+IYVWi1VPPxc+IUybkYqD3YTMI7726g
	UwklnP8Pf2BnkjVFPmR3QXfAnVINTn94vsM0/61wWm2NH7QZQCnijkipJ1DgFotg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63hqtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 18:38:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578IcRtF031693;
	Fri, 8 Aug 2025 18:38:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63hqt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 18:38:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578IbXnx007961;
	Fri, 8 Aug 2025 18:38:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn6x2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 18:38:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 578IcMlf18809230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 18:38:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0C1C20040;
	Fri,  8 Aug 2025 18:38:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F4820043;
	Fri,  8 Aug 2025 18:38:22 +0000 (GMT)
Received: from [9.111.169.241] (unknown [9.111.169.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Aug 2025 18:38:22 +0000 (GMT)
Message-ID: <1e7ae264-5d45-49a4-af8d-be64aa58f68b@linux.ibm.com>
Date: Fri, 8 Aug 2025 20:38:22 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 10/17] net/dibs: Define dibs_client_ops and
 dibs_dev_ops
To: Simon Horman <horms@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-11-wintera@linux.ibm.com>
 <20250807194715.GP61519@horms.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250807194715.GP61519@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE0OSBTYWx0ZWRfX1ibIXXWov5yd
 mwPjB2O7q/NhdtCaweB4xX7x7pkIIrN9eWs6xagpux86KB/r9jBpEJk3P54mlqh2NLaWx1tKXbV
 t5KflLFZOWa/kbM+9iRIqcu0ra5cnObdO6ujex8dqDenmvQFjgs9eg3AYQLMMb/LCRIgDqn8NLN
 y0/HTdq+gX6Ygm1Kv4awV3CsglxsrV7wGbEh43CbwhtmjXkAxC9uOQPiJLVVYa/ZLfdw7qdExIb
 LUVn79WTy7hVb3utKU2oromTMfbn+AN7dBWjH4xNdT0Q2WnvTmlsnMLfsNL2aqbcffIR1nQumHc
 Z5nsnHvx+NruUBfeMoZSOpe+fHInkVPPu6im+wprNTwIZKi6DfyavO+Ng6tPgrAbL3VYVo+aKBm
 WLP2H7ZLMhwY8g479CFI8hWvTapCd3gmvMpYiN7MT2vBaUxila3K1c0PB7nwTzQ7Pn6bDyEd
X-Proofpoint-GUID: UpaSF8k-Z7Gg0pKZ07rCJBIRcXOKYvDK
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=68964424 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=JQlgXwjdnbstuWfQuRAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: D1VkQz0-jV9GjjBfZgkntIJwIDcRkPWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080149



On 07.08.25 21:47, Simon Horman wrote:
> On Wed, Aug 06, 2025 at 05:41:15PM +0200, Alexandra Winter wrote:
> 
> ...
> 
>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> 
> ...
> 
>> -static void smcd_register_dev(struct ism_dev *ism)
>> +static void smcd_register_dev(struct dibs_dev *dibs)
>>  {
>> -	const struct smcd_ops *ops = ism_get_smcd_ops();
>>  	struct smcd_dev *smcd, *fentry;
>> +	const struct smcd_ops *ops;
>> +	struct smc_lo_dev *smc_lo;
>> +	struct ism_dev *ism;
>>  
>> -	if (!ops)
>> -		return;
>> +	if (smc_ism_is_loopback(dibs)) {
>> +		if (smc_loopback_init(&smc_lo))
>> +			return;
>> +	}
>>  
>> -	smcd = smcd_alloc_dev(&ism->pdev->dev, dev_name(&ism->pdev->dev), ops,
>> -			      ISM_NR_DMBS);
>> +	if (smc_ism_is_loopback(dibs)) {
>> +		ops = smc_lo_get_smcd_ops();
>> +		smcd = smcd_alloc_dev(dev_name(&smc_lo->dev), ops,
>> +				      SMC_LO_MAX_DMBS);
>> +	} else {
>> +		ism = dibs->drv_priv;
>> +		ops = ism_get_smcd_ops();
>> +		smcd = smcd_alloc_dev(dev_name(&ism->pdev->dev), ops,
>> +				      ISM_NR_DMBS);
>> +	}
> 
> Hi Alexandra,
> 
> ism is initialised conditionally here.
> 
> But towards the end of this function the following dereferences
> ism unconditionally. And it's not clear to me this won't occur
> even if ism wasn't initialised above.
> 

No idea, how this could escape my testing.
Thx, fixed in next version.

>         if (smc_pnet_is_pnetid_set(smcd->pnetid))
>                 pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
>                                     dev_name(&ism->dev), smcd->pnetid,
>                                     smcd->pnetid_by_user ?
>                                         " (user defined)" :
>                                         "");
>         else
>                 pr_warn_ratelimited("smc: adding smcd device %s without pnetid\n",
>                                     dev_name(&ism->dev));
> 
> 
>>  	if (!smcd)
>>  		return;
>> -	smcd->priv = ism;
>> +
>> +	smcd->dibs = dibs;
>> +	dibs_set_priv(dibs, &smc_dibs_client, smcd);
>> +
>> +	if (smc_ism_is_loopback(dibs)) {
>> +		smcd->priv = smc_lo;
>> +		smc_lo->smcd = smcd;
>> +	} else {
>> +		smcd->priv = ism;
>> +		ism_set_priv(ism, &smc_ism_client, smcd);
> 
> This function is now compiled even if CONFIG_ISM is not enabled.
> But smc_ism_client is only defined if CONFIG_ISM is enabled.
> 
> I think this code is removed by later patches. But nonetheless
> I also think this leads to a build error and it's best
> to avoid transient build errors as they break bisection.
> 

Fixed in next version.
I'll make sure, all patches build without ISM.
Great catch, thank you Simon.


>> +		if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
>> +			smc_pnetid_by_table_smcd(smcd);
>> +	}
>> +
>>  	smcd->client = &smc_ism_client;
> 
> Ditto.
> 
>> -	ism_set_priv(ism, &smc_ism_client, smcd);
>> -	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
>> -		smc_pnetid_by_table_smcd(smcd);
>>  
>>  	if (smcd->ops->supports_v2())
>>  		smc_ism_set_v2_capable();
> 
> ...


