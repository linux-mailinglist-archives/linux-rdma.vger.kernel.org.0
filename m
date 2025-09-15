Return-Path: <linux-rdma+bounces-13353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADBFB570B3
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 08:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98E93A0721
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 06:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A832C11EC;
	Mon, 15 Sep 2025 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lezOvOnO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625E2C0292;
	Mon, 15 Sep 2025 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919276; cv=none; b=RqylXRoHDDEQE20EPSzv924usQHxje+pqgdr2VfEqTqyb9zK9Ljz3oY57I7zPuqWz2tRRech/fcCCmPr1l26n+tEdXZ7UlHFZhGHX8txJB/3bgy8O1yFIWr72zTVHiTpZEZdIYxsJSeYwztYQup1osJR/i3cj/y7v/Fk28R2r30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919276; c=relaxed/simple;
	bh=OMLJ/ZFVeR1gLezarNQ5OBojq/UZy6AcuS5aa48/Ycs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuBH/pMJw7z+bzP25CAQb8jhGp/H7ENntNY6xbAKeH9G565IUCE6OsMRn1zLn6U4gBRbnlm/Dr43bI6WANjKnqOtHuDngO7mKt2xp6sGi7VNqTU8wbTiC2V1ZP7p4Fb7z/rcWHuCg/jzgteO3UljaRzRAMCx5Bu+HUC0ZXgf7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lezOvOnO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EHfpb3017258;
	Mon, 15 Sep 2025 06:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vEj5al
	LflW09tPN3ZyNcdQe0I3TVk9mFaQmKSpib4T4=; b=lezOvOnOlUmnymoOlzGXde
	TXb8dEcZmvfTAO7lbHpdcLIoJxyexX7G2MlrCsmDw9bSmBvfRx/r0nyWylolXxvk
	WAe6hQhC/SIvOvdjACmBwMIwr8OXsbO7rnlAGVO9gEmBLW3VJFEdfzzln6/cF99M
	oHPPgdI1UxaFG60xeEmYcjAbCVCn26Ep5nfo9Fh89yJV9jwwoEBVZuHug3nHWQCV
	FZudVJonOv4ZRYOK8DIapujIVM37UMIuYUUuGc8vbrz94CZJ4dmfEhiYtEGdiVVA
	PH9MdnVJmCYy3/OJ1P1MZZuNQlU2o7Vq5xBHNQ5NSyoPAIiBMT1+lU7A43qm45IQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49504b0xrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 06:54:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58F6iHMl020195;
	Mon, 15 Sep 2025 06:54:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49504b0xre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 06:54:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58F4SJiM018625;
	Mon, 15 Sep 2025 06:54:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5m4ux0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 06:54:26 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58F6sPXZ26411538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 06:54:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDFCD58063;
	Mon, 15 Sep 2025 06:54:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13B2A5805D;
	Mon, 15 Sep 2025 06:54:18 +0000 (GMT)
Received: from [9.109.249.37] (unknown [9.109.249.37])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 06:54:17 +0000 (GMT)
Message-ID: <947756ad-f9aa-479f-b463-4c97ff23a936@linux.ibm.com>
Date: Mon, 15 Sep 2025 12:24:16 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/smc: replace strncpy with strscpy for ib_name
To: Leon Romanovsky <leon@kernel.org>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20250908180913.356632-1-kriish.sharma2006@gmail.com>
 <20250910100100.GM341237@unreal>
 <24ced585-1b7f-4577-9cb5-8d6e60ecb363@linux.ibm.com>
 <20250912090713.GV341237@unreal>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20250912090713.GV341237@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMCBTYWx0ZWRfX0sdSJ71fpUby
 0ibdThPTyCKdd4t55OvEAHa5gFmOpbKZi8NBNCE7lg+Fg6OEVfn5ZKAAj06bZ0mluSmXxkBhZsG
 ZuEBGYp99Sv9PUbEf3P9xdHbOQTOHxGp9oDlA0yWdkE5zcZ6HpbhtWjW7JEOs6Se4/HRIgeDWPl
 W0Uv4nbKHYikznVfRsehW0TN7Rf4L65y7/b6f4ZOd1mkrhspn7KX0oeE4HG8agM768to8lEThZy
 iKINernQlPEDnEof0T6hnbvugoXVNZ/Q4agbWrj8PCFQVIPFFAZGaNafnZvJ0DgS5L9yq0KPTLA
 WJa70KS+C4toReim18gizBkSElTMKdf7NmeynPly0oDM//LcMKnAiZqiz5vN9kAyUXZCZL/DKwi
 4L8Q3jMH
X-Proofpoint-ORIG-GUID: 98MEKJqvXtHcWaEUBIhwix6ZJl7Ui-1B
X-Authority-Analysis: v=2.4 cv=dt/bC0g4 c=1 sm=1 tr=0 ts=68c7b824 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=fb0p5f3yy6WXCT3W6uYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ntakgdyemlx5g5foZQmcm0hfHM21whH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130020

On 12/09/25 2:37 pm, Leon Romanovsky wrote:
> On Fri, Sep 12, 2025 at 01:18:52PM +0530, Mahanta Jambigi wrote:
>> On 10/09/25 3:31 pm, Leon Romanovsky wrote:
>>>> --- a/net/smc/smc_pnet.c
>>>> +++ b/net/smc/smc_pnet.c
>>>> @@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>>>>  		return -ENOMEM;
>>>>  	new_pe->type = SMC_PNET_IB;
>>>>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
>>>> -	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
>>>> +	strscpy(new_pe->ib_name, ib_name);
>>>
>>> It is worth to mention that caching ib_name is wrong as IB/core provides
>>> IB device rename functionality.
>>
>> In our case we hit this code path where we pass *PCI_ID*
>> as the *ib_name* using *smc_pnet* tool(smc_pnet -a <pnet_name> -D
>> <PCI_ID>). I believe PCI_ID will not change, so caching it here is fine.
> 
> If I remember, you are reporting that cached ib_name through netlink much later.
> 
> The caching itself is not an issue, but incorrect reported name can be seen as
> a wrong thing to do.

In what case we can see this incorrect reported name, could you please
elaborate.

