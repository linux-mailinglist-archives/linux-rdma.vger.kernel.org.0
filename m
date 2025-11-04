Return-Path: <linux-rdma+bounces-14236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75786C300F3
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 09:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A408A34C993
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666027510B;
	Tue,  4 Nov 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SGp64tuA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927195D8F0;
	Tue,  4 Nov 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246288; cv=none; b=biVOlYDyZHca9WZXlW6GPVYw6i4VHtaHL/uGLB5k5Ou/JGZn1gt2UVJLfbtc73806TESoJlORkGsiz/3u48u/j+dZ3NfEioUf0X/W2y2QCn3okT2Av6jRAIw/aztOPWoa2nXvU1uCbY07ST90JZgDut3AgFWjtFPCbEoA2YE0Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246288; c=relaxed/simple;
	bh=fBOHBtTBNYAfORE7Ww0mntVd8j7j57lr5K25kuMAsLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYJQOylePxHuv9j2KwbKc9BX8V1gpyyNxD1Rd/u0C1JgQjaS4FP7YQIG5k94dxjaysNGmwORV/LHNkELNfndvuVPjEBm+MTs1Kj64CUkyuk5ukoCjN6tWPYkEOMlYIlMtes4JRK93Lqxz9B2EzK2PNkzuJIv9ozh/JeGVqSWn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SGp64tuA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A40wuxa025577;
	Tue, 4 Nov 2025 08:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cgPVl8
	07fg3HR0iyDkr5HA0gSFYzqz/O+8EjiXgNNuE=; b=SGp64tuAl1n1O75Y9MRPEy
	UNquXNDTe0hDeQ6J9/BBOK22Rub+Ke5EmjbJPAFnvSvTplAcaGw8hGCw94ygHqfU
	F3y4wpQAPRhMWLKQzKG2Ti5ScVw+yhbwdq77sNmHIGDTuAzH9yIGE05Is/jzzmUI
	TYb1o3Vgge87qKrEPJ4CWPOlkvfJ43gahlhlhzwBUgc0e7faO7oVcHVnQXPXvAas
	ooLlKQ4pjv6GR7ZyGplRRL5JbPm3DvqlShgLSino42g+fis/KOhzbT/zKPt2FQzk
	dwGLk0HYdDklh/lI8Vf1OhOemN8j8Moh7EKfptBcGVhJ85blSmdAxilKVoNiy8+g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuay4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A47xMiI020998;
	Tue, 4 Nov 2025 08:51:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuay4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A47o8DU012923;
	Tue, 4 Nov 2025 08:51:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y81swd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A48pAjU30015774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 08:51:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4429220049;
	Tue,  4 Nov 2025 08:51:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A2B92004D;
	Tue,  4 Nov 2025 08:51:10 +0000 (GMT)
Received: from [9.152.210.132] (unknown [9.152.210.132])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Nov 2025 08:51:09 +0000 (GMT)
Message-ID: <5f415b7e-3557-4fa0-a0f9-f5643c1c7528@linux.ibm.com>
Date: Tue, 4 Nov 2025 09:51:09 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix mismatch between CLC header and proposal
 extensions
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: mjambigi@linux.ibm.com, wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        pabeni@redhat.com, edumazet@google.com, sidraya@linux.ibm.com,
        jaka@linux.ibm.com
References: <20251031031828.111364-1-alibuda@linux.alibaba.com>
 <95bd9c85-8241-4040-bbd0-bcac3ffc78f7@linux.ibm.com>
 <20251104070828.GA36449@j66a10360.sqa.eu95>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20251104070828.GA36449@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kiLWufkC6oXRBzEx9o1-DtQDnyxGneYq
X-Proofpoint-GUID: KTNSXpGM43PnbJQfapaxT1egtmB2M6ju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX6lnAvCFoK+Aj
 som7tXlk2I4tqPoCodNem3UBqe9ooGFhxZtmcSrSDi74WHl6RJ0THrIZ8+dnn2VywqEiRLk/tYc
 /aEy+7tcjLnw7a9Vb6g995X3E6ePq+piRmioxncftvSgcIVEUdMb1BuDUeVe0PJKPZbK3rfjWw1
 z8dTyY9YTJLJkMEHZzyvXyh0pj2uy9U9qKyJ8++q9iGsnnoAFq2nG+Jn33Jf8hPhuG8fCa0Ubqt
 C7D8+VWUGzQQ/nP16iuiA0/6LbbOFhHTJWFfYJXqVcpmYLrGwSrQkRDLF6iIJIDlcoHYujAAvOo
 8sVnW6jIT+eu8nUnxV/ONGIPfpxjkV1V8C8dkwvLfczLhK/L/PuL5k/fADkMkWq+40YusL50rBc
 hyTKP2e6LDoi4h8Yr/lpzIFlHDMWfQ==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=6909be83 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LDwyJIfZ9AC3-zDn7cAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021



On 04.11.25 08:08, D. Wythe wrote:
> On Mon, Nov 03, 2025 at 09:28:22AM +0100, Alexandra Winter wrote:
>>
>>
>> On 31.10.25 04:18, D. Wythe wrote:
>>> The current CLC proposal message construction uses a mix of
>>> `ini->smc_type_v1/v2` and `pclc_base->hdr.typev1/v2` to decide whether
>>> to include optional extensions (IPv6 prefix extension for v1, and v2
>>> extension). This leads to a critical inconsistency: when
>>> `smc_clc_prfx_set()` fails - for example, in IPv6-only environments with
>>> only link-local addresses, or when the local IP address and the outgoing
>>> interface’s network address are not in the same subnet.
>>>
>>> As a result, the proposal message is assembled using the stale
>>> `ini->smc_type_v1` value—causing the IPv6 prefix extension to be
>>> included even though the header indicates v1 is not supported.
>>> The peer then receives a malformed CLC proposal where the header type
>>> does not match the payload, and immediately resets the connection.
>>>
>>> Fix this by consistently using `pclc_base->hdr.typev1` and
>>> `pclc_base->hdr.typev2`—the authoritative fields that reflect the
>>> actual capabilities advertised in the CLC header—when deciding whether
>>> to include optional extensions, as required by the SMC-R v2
>>> specification ("V1 IP Subnet Extension and V2 Extension only present if
>>> applicable").
>>
>>
>> Just thinking out loud:
>> It seems to me that the 'ini' structure exists once per socket and is used
>> to pass information between many functions involved with the handshake.
>> Did you consider updating ini->smc_type_v1/v2 when `smc_clc_prfx_set()` fails,
>> and using ini as the authoritative source?
>> With your patch, it seems to me `ini->smc_type_v1` still contains a stale value,
>> which may lead to issues in other places or future code.
> 
> Based on my understanding, ini->smc_type_v1/v2 represents the local
> device's inherent hardware capabilities. This value is a static property
> and, from my perspective, should remain immutable, independent of
> transient network conditions such as invalid IPv6 prefixes or GID
> mismatches. Therefore, I believe modifying this field within
> smc_clc_send_proposal() might not be the most appropriate approach.


'ini' is allocated in __smc_connect() and in smc_listen_work().
So it seems to me the purpose of 'ini' is to store information about the
current connection, not device's inherent hardware capabilities.

Fields like ini->smc_type_v1/v2 and ini->smcd/r_version are adjusted in
multiple places during the handshake.
I must say that the usage of these fields is confusing and looks somehow
redundant to me.
But looking at pclc_base->hdr.typev1/v2, as yet another source of
information doesn't make things cleaner IMO.


> 
> In contrast, pclc_base->hdr.typev1/v2 reflects the actual capabilities
> negotiated for a specific connection—what we might term "soft
> capabilities." These can, and often do, dynamically adjust based on
> current network conditions (e.g., in the event of a prefix validation
> failure) and could potentially be restored if network conditions
> improve.

I don't understand.
The pclc block is freed at the end of smc_clc_send_proposal(). Its
only purpose is to be sent out as intitial proposal. How could you
restore it if network conditions improve?


> 
> Furthermore, once CLC negotiation is complete, the SMC protocol stack
> relies exclusively on these negotiated results for all subsequent
> operations. It no longer refers to the initial capability values stored
> in ini. 

Could you give an example where these negotiated results are referred?
Or do you mean within smc_clc_send_proposal()? The pclc block is freed
at the end of smc_clc_send_proposal(), so where is that result stored?


> Consequently, maintaining ini->smc_type_v1/v2 in its original,
> unaltered state appears to present no practical risks or functional
> issues.

Even if nobody reads these fields today after smc_clc_send_proposal(),
I don't think it is good design to leave stale values there and hope
future editors will understand that.
I understand your patch fixes the observed problem. I am just wondering,
whether it makes the code more maintainable or even more confusing than before.

