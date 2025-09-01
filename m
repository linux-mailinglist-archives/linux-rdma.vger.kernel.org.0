Return-Path: <linux-rdma+bounces-13014-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065AB3D9A9
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 08:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9843189A324
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 06:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E072505AF;
	Mon,  1 Sep 2025 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fcjr+P7B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C8248F5C;
	Mon,  1 Sep 2025 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707184; cv=none; b=jjggaravbrBiAtxC0op2s0Ayf5KIeJZ+lILUQatsvfyKOWsnJuEHr4ZjRwCmQBTdg7FArP0LWOpu6kY736bygNPToIP6L+yaL4t1wHAR9XQkoyfun9AZ5Z0Oe4W4QLEZI/a0KcWtTvzQWD7BV89NyB/rnfqqRXmFZg2O5ePMWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707184; c=relaxed/simple;
	bh=EyK1bT+mD7QqA4C8Ly35wKowNy38n2wAvW7UnVG7R+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elBmOviVoDu/xEwjliOnnRCM7myXcysW+22+5qVG0o4TXPM8LeoKmexGfkNVxHj5SFj0mcl3iIwXs5NLGWnXhq5tPHL5RNguRwt4LE6cMbqIIV/0HtvofodDCtgBY4yWS0N9Mt4SnU8FH220eBB2DhGnjxMx37pjhj/a46Fgqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fcjr+P7B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VHeBXu017937;
	Mon, 1 Sep 2025 06:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jNIpxH
	qNy+03Qh0iAc58609OkLAG2uxslj/3KXqMdZ0=; b=fcjr+P7Bb7jM0fkaR3MxDm
	4OEme6f8DG7I+R3ME0jIago7Mak7QAwr7HbDNyg+zQVQitGyYdzcD5wmIqGJD5dI
	GX6a+OZyiVKN6qW7XCQidqMTvZTNzn/efWou4QPQ4DYHMhp9O4CD+XZjUItxQoPR
	QEz5itcxne0mJrEHv+JNFpmkphRYJrgB9cuwAmp8RlnCwZpGyrtGhgpDCb/Fgbpw
	w2HLgVqa7rqF79hmWgN7Sdjvjo3Jnm+Y+6YD6UUf/nkK+9lrfgcNe7mimzOa9DuR
	jrm1NJUTH2stCbEk2j0ikQbukXK986b9HX+84IItgYw16ARAJeoT0tP22FxiY8NA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuqq7g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 06:12:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5815ugol028220;
	Mon, 1 Sep 2025 06:12:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuqq7fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 06:12:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5815Jw3c021191;
	Mon, 1 Sep 2025 06:12:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpch87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 06:12:46 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5816Cj3E20054598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 06:12:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 499BF5805D;
	Mon,  1 Sep 2025 06:12:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2186558059;
	Mon,  1 Sep 2025 06:12:40 +0000 (GMT)
Received: from [9.39.27.54] (unknown [9.39.27.54])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Sep 2025 06:12:39 +0000 (GMT)
Message-ID: <57c2976e-8b6c-4cee-803f-ca5b0636f30b@linux.ibm.com>
Date: Mon, 1 Sep 2025 11:42:38 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Remove validation of reserved bits in CLC
 Decline message
To: dust.li@linux.alibaba.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alibuda@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>
References: <20250829102626.3271637-1-mjambigi@linux.ibm.com>
 <aLHAAy-S_1_Ud7l-@linux.alibaba.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <aLHAAy-S_1_Ud7l-@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfXx9SSJ6arYZfv
 ruSP7JB4eBGBRSV3Lia6GzO1GIZvE49Fl9hlkSueGF4mcZ2rBrELD1mzj3y/KpLHcYC6jCoaeeD
 heeTTVEpoDEOrhbg8HAS2SZCg/y7IQjmdiQAklGlU1R+p3+nmekqngO9HipSt2LO+1jhrjzEQsn
 3873l2jcDU0kN1ZmVUJgggWlisECDEpmsFAIHZG8MmyqqYxzDgRhZsswb82yWbO4/XnQeGM/oYl
 1ydM4rhO7+lrB0LjUadzJx8pR950FcYpt7dYGGW9dUG4yWlkwEJL50hbAnTBtsJbqZ28eG17xdd
 vSavgMw4vx0SpBRaR6joWgx+O31weaqPcCYFU7aucoQzJGx5ePdYeNwmiO7ZFo5dnTW400Iteqm
 sdsJtBOL
X-Proofpoint-GUID: 5rFtGuwiZUjpsOH3REx7kx-heydPPQes
X-Proofpoint-ORIG-GUID: a_8F3YUUV6fYQj9kKPBg5gPUWY6h7mUg
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b53960 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=48vgC7mUAAAA:8 a=VnNF1IyMAAAA:8
 a=K1W8qsRnxZmegyINkbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030



On 29/08/25 8:28 pm, Dust Li wrote:
>>
>> Fixes: 8ade200(net/smc: add v2 format of CLC decline message)
>>
>> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>> Reference-ID: LTC214332
> 
> I think this is your internal ID ? It's better not to leave that
> in the upstream patches.

Oops, I missed to remove it. Sure, I'll remove it.

> 
>> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
>> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
>>
>> ---
>> net/smc/smc_clc.c | 2 --
>> 1 file changed, 2 deletions(-)
>>
>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>> index 5a4db151fe95..08be56dfb3f2 100644
>> --- a/net/smc/smc_clc.c
>> +++ b/net/smc/smc_clc.c
>> @@ -426,8 +426,6 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
>> {
>> 	struct smc_clc_msg_hdr *hdr = &dclc->hdr;
>>
>> -	if (hdr->typev1 != SMC_TYPE_R && hdr->typev1 != SMC_TYPE_D)
>> -		return false;
> 
> Here it's checking the typev1 in smc_clc_msg_hdr, but your commit message
> says it's validating the reserved bits:
> 
>    Currently SMC code is validating the reserved bits while parsing the incoming
>    CLC decline message & when this validation fails, its treated as a protocol
>    error.
> 
> Did I miss something ?

If you refer to struct *smc_clc_msg_hdr* in smc_clc.h file, typev1 
member represents bits 4 & 5 at offset 7. If we compare it with the CLC 
Decline message header, it represents one of the reserved(5-7 bits) at 
offset 7. You can refer to below link for reserved bits.

https://datatracker.ietf.org/doc/html/rfc7609#page-105

> 
> Best regards,
> Dust


