Return-Path: <linux-rdma+bounces-14191-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F1C2A939
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 09:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC453A4796
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 08:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395952DCC03;
	Mon,  3 Nov 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J0Vw0PQV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787FE53363;
	Mon,  3 Nov 2025 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158522; cv=none; b=J/Ux7HLJUFxALfeAFJ9itZ6N2KNaKSu323qow5/RU4jwBWNpcWh5ioDfy2Rw7tLaG4UcFmxfkg44euj+/CnJaXulSMjiLMhQ0h37K+5htsHCPrKn0u2lX363Jmj5g72zVvZpaswmbdOnyiP0MR7odE9lwY6bthC9ADOHT/i7fSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158522; c=relaxed/simple;
	bh=eS7KrlMq6jo/GsXOFtImqbS4/OQyOCDYwKWHLlIHG7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9YmD9hHKgpl6EDhKJhiIGCG8/jPm6xHfwdHAQV+M8xCEQrxAWkTsBGEi8k+bBUgoZGJ1pUxLWrGYw990OGtO8XABvQMxV+8YIO2O8nmIpSkvcYXTrCo7Gy9AeXxkkWeNZ/zHnX6zO0YnRfFOONsp+Q/UEUla+ma2fUGrDUd980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J0Vw0PQV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2JFURo028252;
	Mon, 3 Nov 2025 08:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TmjDXj
	wR+nEddG/eZ6E1vM2d76S1OyWZE5K7xsFZokU=; b=J0Vw0PQViec67xL6kzKonQ
	CignmYL8cuWyh3ZHZbe/Gy9r3epPtK00GhHk5piYzJq1y6l00GHmQqdn7cXENXAz
	BVbGENVjL9PnRMgLbmqgq/DnbWG3myGobOYwgDYtKrbJXz3IdpIN1Be1sE4nKZtu
	KqQrDGrI+OuOTzjiB6rSjmI7+Lq5gJnCIIvF72rhTz9oyLlgD1PPNMAt2OBV6mj6
	U3apa4q8+McpgbGCt/XYP60aAtk5ADjq4T+sMT246bH5yd85VZ/J/t6nHrNhJfx5
	R22vtDeXs7EfknPA/lOxNZ30sy8o2u6vOU6Al7NwWgHkUbNOvQ1zYqF68ieWhy4A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q8nn0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 08:28:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A38SS3M012984;
	Mon, 3 Nov 2025 08:28:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q8nn0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 08:28:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A37TrId009831;
	Mon, 3 Nov 2025 08:28:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1k4jma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 08:28:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A38SMP649218022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 08:28:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0F422004B;
	Mon,  3 Nov 2025 08:28:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F90320043;
	Mon,  3 Nov 2025 08:28:22 +0000 (GMT)
Received: from [9.152.210.132] (unknown [9.152.210.132])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 08:28:22 +0000 (GMT)
Message-ID: <95bd9c85-8241-4040-bbd0-bcac3ffc78f7@linux.ibm.com>
Date: Mon, 3 Nov 2025 09:28:22 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix mismatch between CLC header and proposal
 extensions
To: "D. Wythe" <alibuda@linux.alibaba.com>, mjambigi@linux.ibm.com,
        wenjia@linux.ibm.com, dust.li@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        pabeni@redhat.com, edumazet@google.com, sidraya@linux.ibm.com,
        jaka@linux.ibm.com
References: <20251031031828.111364-1-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20251031031828.111364-1-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690867ac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gmV_aJJbElOwqUTrwFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: DdUd5zz7N1UApgn1B4dBUjwhjixTIswZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX6TtwDzpP1ttX
 iJbdKr0Vjhi+kghB4sNNl5ClAC13llATV+QMaSNj/XcUA9IHmABTRSIm0KMBn4L79SZn+x0wHFB
 LBWjWP94N7Kkeis3hvv+NWNJfOGbRkGDxxdm7Q1ZhcEhhtuQ6k555f0dme9g2g/F5mAE+KVDH1u
 kQ8BVIhNyq3k5/sIDKpls4NNXixZkvGFgpMYUwNCBzAB2ebptrofSguPVQVihFbNYqJZ7Ft/Hd/
 uPiiak7RnuSNtUwQyqD6tdzGGNak5mv249yOwxegCQaCwsmzXQZtolm+Pz6V2stbrCF5xSHqwZ5
 HrrYIu6IuKVY3Yhb1POOFCucSSF/P0Bx+a8GzDnTWZGJya5Uho3+Y2B1tHIyX+C66nEFk1u71yp
 5eTco38mTotQDSNOtpa1tLirIQ8YfQ==
X-Proofpoint-GUID: hkI_LvqfU-gGO66Imq9UIf0mGczWjBTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018



On 31.10.25 04:18, D. Wythe wrote:
> The current CLC proposal message construction uses a mix of
> `ini->smc_type_v1/v2` and `pclc_base->hdr.typev1/v2` to decide whether
> to include optional extensions (IPv6 prefix extension for v1, and v2
> extension). This leads to a critical inconsistency: when
> `smc_clc_prfx_set()` fails - for example, in IPv6-only environments with
> only link-local addresses, or when the local IP address and the outgoing
> interface’s network address are not in the same subnet.
> 
> As a result, the proposal message is assembled using the stale
> `ini->smc_type_v1` value—causing the IPv6 prefix extension to be
> included even though the header indicates v1 is not supported.
> The peer then receives a malformed CLC proposal where the header type
> does not match the payload, and immediately resets the connection.
> 
> Fix this by consistently using `pclc_base->hdr.typev1` and
> `pclc_base->hdr.typev2`—the authoritative fields that reflect the
> actual capabilities advertised in the CLC header—when deciding whether
> to include optional extensions, as required by the SMC-R v2
> specification ("V1 IP Subnet Extension and V2 Extension only present if
> applicable").


Just thinking out loud:
It seems to me that the 'ini' structure exists once per socket and is used
to pass information between many functions involved with the handshake.
Did you consider updating ini->smc_type_v1/v2 when `smc_clc_prfx_set()` fails,
and using ini as the authoritative source?
With your patch, it seems to me `ini->smc_type_v1` still contains a stale value,
which may lead to issues in other places or future code.

