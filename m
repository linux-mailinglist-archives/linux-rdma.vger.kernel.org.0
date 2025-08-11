Return-Path: <linux-rdma+bounces-12667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F70B207E9
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168B218C4162
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707B2D29CA;
	Mon, 11 Aug 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DosoLwUw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC42D3221;
	Mon, 11 Aug 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911736; cv=none; b=ehqHG0CRSdNfvflLBhD2iIWU6KHyPYmXeIK51Ggn+Nyv6qbkZUuVrZaTNbhFycwKZRAS6wlDW5YQPEtf1tt8SmU4fBRNDoQkyD0iPyMSD9ZwTTi8+ezL9PfV9I7PMdOyQ34eP2v381h2lOACC2O/ey5W2TXCTCVS/2An3J+DLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911736; c=relaxed/simple;
	bh=fW0VvhJf4Iec8UuG9QGtVbjmK87c6Llrf5Yz4IdAv7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksPgNzlvmslJodsyItUYyG/RPg3h/HcH/yYWUGl4tu86u6NKKSf6a7GCgF8QYp/5lYDnMQLVXEZzUey4CIKyxZEm1YuFuMd5OUZC9STB1paKXJGLq4dkuY+jIh0yyjY56M3bYxlDfcWK/m34Vdh5KmC1cZwJ+h37aFf3oiAxTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DosoLwUw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B53sLi002897;
	Mon, 11 Aug 2025 11:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fGgOD1
	1FTbo+q5hNtNpmOJYetYgCfBeiUH3XysgW3vw=; b=DosoLwUwdp+2DjJnKDyi+I
	ZRLpR9MZJ/MJEeG63Ug4K7+iGuAqqW8UUOWjV2q3Fev0VKO2Qe6ILpvTTQpj+B8u
	h6rhkBMHX4wg0CjeMxAzU5Ti5QHOyDGtKYFjQyqc2oQuhjXu6tTj2C0axeEz82Ll
	FuCrt3zglmDBPvWnxm4OTZ6K+grx9B0bS8ITGKsmHsdg4018QwPfo6dWulLhNKou
	Jr3mSoUH+tYwAwAgjXtmCYIGFDlhTMosh/9EpJU+rJsNNk3Q2NqDXNm5b66+567p
	b1vnLOAL1a8T9nfUdj3kpcGjkDTzbbjkfYKQOxP4vFC2/wdNHEQPnwqNZyfYUQ+Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9w85f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 11:28:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BBRwVF025185;
	Mon, 11 Aug 2025 11:28:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9w85c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 11:28:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57B7Cr04017617;
	Mon, 11 Aug 2025 11:28:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3d8qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 11:28:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BBSdU160096902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 11:28:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D697A2004B;
	Mon, 11 Aug 2025 11:28:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80E122004D;
	Mon, 11 Aug 2025 11:28:39 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 11:28:39 +0000 (GMT)
Message-ID: <a92a4e51-5560-48ec-93f2-6d434b1abbb9@linux.ibm.com>
Date: Mon, 11 Aug 2025 13:28:39 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 03/17] net/smc: Remove error handling of
 unregister_dmb()
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
 <20250806154122.3413330-4-wintera@linux.ibm.com>
 <aJh8d2G9-veAynO1@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aJh8d2G9-veAynO1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=6899d3ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=iYOzEUFcZFceXDu_1icA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fUDQHkdiQu3SJZ1wi1QjNfHyy3lMg3xf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXwjtJj0KcKSGo
 xWp+xU8UmCgS81y5j3M7wC5BPe0tgQD0O0q8xkKyIYEyTm8TiGqGWFDF2tRzwG1KmWSfxEdIG5H
 e55OlttM1YoaKbW7XoyRVegWoRRR0CBbufVnq7XfoisficZWNBvf1Z1OOmQ0qxiDNw0zk4uycKz
 ThwVlaQQOvi836oDBATuq0wml/hEd+bETlr/fwGmlfxDnbT41asXJS5lGWtdIxZB7TD/uYlAgBP
 OZOnlWkVM8L/x3d1oMQl2+bfge3SlhQ6YWighDdwZo2hvGvsvX2Q5oYF25dUKWWIewdtRzFiezE
 JkGWZ3jR5ItQuulMJSstOr19rtSZfTBJut6yetNdeQbN1ZFuD9vOVK2syAGeSRwDRCplOZgOADO
 EHLGZ4KwvxE2Y/MdcZ2BWdo7yFIRNxzL0FrQshM1twUBq9isWMeD6Yy2/+r7f/Uhj/STJI9r
X-Proofpoint-GUID: a26-C3CnD40GwQNXFQ_yw-ie8QWcwsDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=713 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110075



On 10.08.25 13:03, Dust Li wrote:
> On 2025-08-06 17:41:08, Alexandra Winter wrote:
>> smcd_buf_free() calls smc_ism_unregister_dmb(lgr->smcd, buf_desc) and
>> then unconditionally frees buf_desc.
>>
>> Remove the cleaning up of fields of buf_desc in
>> smc_ism_unregister_dmb(), because it is not helpful.
>>
>> This removes the only usage of ISM_ERROR from the smc module. So move it
>> to drivers/s390/net/ism.h.
>>
>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>> Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>> ---
>> drivers/s390/net/ism.h |  1 +
>> include/net/smc.h      |  2 --
>> net/smc/smc_ism.c      | 14 +++++---------
>> net/smc/smc_ism.h      |  3 ++-
>> 4 files changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
>> index 047fa6101555..b5b03db52fce 100644
>> --- a/drivers/s390/net/ism.h
>> +++ b/drivers/s390/net/ism.h
>> @@ -10,6 +10,7 @@
>> #include <asm/pci_insn.h>
>>
>> #define UTIL_STR_LEN	16
>> +#define ISM_ERROR	0xFFFF
>>
>> /*
>>  * Do not use the first word of the DMB bits to ensure 8 byte aligned access.
>> diff --git a/include/net/smc.h b/include/net/smc.h
>> index db84e4e35080..a9c023dd1380 100644
>> --- a/include/net/smc.h
>> +++ b/include/net/smc.h
>> @@ -44,8 +44,6 @@ struct smcd_dmb {
>>
>> #define ISM_RESERVED_VLANID	0x1FFF
>>
>> -#define ISM_ERROR	0xFFFF
>> -
>> struct smcd_dev;
>>
>> struct smcd_gid {
>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>> index 84f98e18c7db..a94e1450d095 100644
>> --- a/net/smc/smc_ism.c
>> +++ b/net/smc/smc_ism.c
>> @@ -205,13 +205,13 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
>> 	return rc;
>> }
>>
>> -int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
>> +void smc_ism_unregister_dmb(struct smcd_dev *smcd,
>> +			    struct smc_buf_desc *dmb_desc)
>> {
>> 	struct smcd_dmb dmb;
>> -	int rc = 0;
>>
>> 	if (!dmb_desc->dma_addr)
>> -		return rc;
>> +		return;
>>
>> 	memset(&dmb, 0, sizeof(dmb));
>> 	dmb.dmb_tok = dmb_desc->token;
>> @@ -219,13 +219,9 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
>> 	dmb.cpu_addr = dmb_desc->cpu_addr;
>> 	dmb.dma_addr = dmb_desc->dma_addr;
>> 	dmb.dmb_len = dmb_desc->len;
>> -	rc = smcd->ops->unregister_dmb(smcd, &dmb);
>> -	if (!rc || rc == ISM_ERROR) {
>> -		dmb_desc->cpu_addr = NULL;
>> -		dmb_desc->dma_addr = 0;
>> -	}
>> +	smcd->ops->unregister_dmb(smcd, &dmb);
> 
> Hmm, I think the old way of handling error here is certainly not good.
> But completely ignoring error handling here would make bugs harder
> to detect.
> 
> What about adding a WARN_ON_ONCE(rc) ?
> 
> Also, I think we can just remove the rc == ISM_ERROR to remove
> the dependency of ISM_ERROR in smc.
> 
> Best regards,
> Dust
> 

As I wrote in the commit message, I removed rc, because it is ignored by the caller anyhow today.
If you want to I can add it back into this function and then you can think about how SMC should
handle such an error.

My thoughts on this are:
There is not really much smc can do about a problem in unregister_dmb.

I think it is Linux strategy to report and handle errors at the lowest level possible. I have some
patches on my harddisk to improve error handling and error reporting of the ism device diver. And
we are already discussing internally which errors should do a WARN_ON_ONCE in the ism device driver.

So I don't think there is much to do in the smc layer at the moment.
How does that sound to you?









