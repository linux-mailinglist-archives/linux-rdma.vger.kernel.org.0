Return-Path: <linux-rdma+bounces-13397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E67B590E3
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 10:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F46C486D78
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686E27FB2F;
	Tue, 16 Sep 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lM5JFafl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8915B0FE;
	Tue, 16 Sep 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011864; cv=none; b=ne41t0cpUxLXd8/iNqdebwEsiz1UA0WaFJDTKXoiqq3Mj3kT1sl+JYv6jBFNF41lpUR/gkJGTclcnXKTzuBc1Td1/Ne+/giLBtiqdPXsjBgR/PLzkBnQy3B20/FSGtoeGGszMrb/yxMyp0SMAn4R7OybyFwH7vj6UnZHGdoqalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011864; c=relaxed/simple;
	bh=R3OtJIm1acbCvb0ycUYTqKNh2AG8E4utZW4+zDRdC0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBSzV/dQnzTHKv98WTizmsBIzOqRLSUChRq0d46NYI6B/s2aaHu5hOU1pfEYaLkZLvR7boSVnIlvkJFv5Jt7rZyR7Ps8MOVMJIVRcG7XASFg/2PMGlffbUYyeS41M0j8KpLB2htpWRhfJBP7/7kb0hj5mNDRX8LR3BMbvoGp9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lM5JFafl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G5QHpt018817;
	Tue, 16 Sep 2025 08:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ahBnTK
	8zMkC3+g9xPOJXAMa9qkUgYwpW3Uh8DBbLQuE=; b=lM5JFaflON58Rn5zz9ATo+
	megSLX4JAwE+LL3BIVrLhqCX8CgqRw588dcE44hS9ubwjo7USEI0eF9E/G6jph8M
	ImnmDjc5QyyF7s0VPA2mLlkz0pX37CHgBygCP0yiKbKuVWm0AaIMo6QJeetH4eMv
	uRuB20Sgcjrw2Mtrtfa9kDhfvpQ7JcAHT3jPcxYi2NV3Jmxin4cwteuIUrhhP27X
	QQ/xMfqwN27RV5SnGZhluJ6RJCB4utghJPWZtMZR1e5PG6arjbUCbg798y4RnQa4
	HAbyzzTEaAKHssvC9G5j14b0X1vD2zurrzhBvw3i7r6mP42vKxR7Na+zvRHDWPwQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat6bdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 08:37:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58G8XCWm008337;
	Tue, 16 Sep 2025 08:37:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat6bdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 08:37:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58G7XgYx018629;
	Tue, 16 Sep 2025 08:37:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mas6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 08:37:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58G8bLgd53608858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 08:37:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8E2220043;
	Tue, 16 Sep 2025 08:37:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B4C120040;
	Tue, 16 Sep 2025 08:37:21 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 08:37:21 +0000 (GMT)
Message-ID: <f785ff05-acfd-4544-84b8-39f0c2d8e5ee@linux.ibm.com>
Date: Tue, 16 Sep 2025 10:37:21 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/14] dibs: Register smc as dibs_client
To: Paolo Abeni <pabeni@redhat.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
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
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
 <20250911194827.844125-5-wintera@linux.ibm.com>
 <eda2c052-a917-4d02-becf-2608242d1644@redhat.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <eda2c052-a917-4d02-becf-2608242d1644@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BKWzrEQG c=1 sm=1 tr=0 ts=68c921c7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=T1PN338ZtHlUWDigjuoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Vf6J9y7SKg2WpjRt2_qg4go6h37zrt4V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX5c06qAb5E/Yf
 ogGq8k1yuvQgzH2iG0auw24H/TFLgtv6I0pI1akLxI2Wwx+k84bKPezzVnjoZmZQ6xlqQR0bpyB
 vS4n8eeHM+BSSDYDt1tO1GHNTpK0BFiaJMfCLErQnn5TkdNEDKEVuEGRmHEtMpW83xVvOdFgZYH
 fC5W1pSEMdJTnm8YfM1W7n6xMDPy6Mg69b39Uj7BFwHQpQ7eDjj/ZCRHQkvNRsmvUHCT7iLlhiT
 CPGd85mCF8mUmXJGyGwW8OlAPoksWN4qOZOr3AJqKg5/nGrNfsYNlEfd/OYE8crIHW68SjDzmeB
 j8oP0NfBtuXUmpG4QRffBBalnbchmRXTnXK/ULl+56b3r9n1b0oYgkTF9Ps85dC7RkpTfZa8Hu9
 CjW+Ocsd
X-Proofpoint-ORIG-GUID: KHL8bkc2_3AR0d1FyHnYLQ4LlV6FvN2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086



On 16.09.25 09:40, Paolo Abeni wrote:
> On 9/11/25 9:48 PM, Alexandra Winter wrote:
>> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
>> index ba5e6a2dd2fd..40dd60c1d23f 100644
>> --- a/net/smc/Kconfig
>> +++ b/net/smc/Kconfig
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  config SMC
>>  	tristate "SMC socket protocol family"
>> -	depends on INET && INFINIBAND
>> +	depends on INET && INFINIBAND && DIBS
>>  	depends on m || ISM != m
>>  	help
>>  	  SMC-R provides a "sockets over RDMA" solution making use of
> 
> DIBS is tristate, and it looks like SMC build will fail with SMC=y and
> DIBS=m. I *think* you additionally need something alike:
> 
> 	depends on m || DIBS != m
> 	
> /P
> 


My understanding of 'SMC depends on DIBS' is that DIBS has to have
a higher or equal state than SMC (with y > m > n).

When I do 'make menuconfig' and set DIBS=m, it will only offer SMC: m|n

When I manually set DIBS=m and SMC=y, 'make oldconfig' will change that to
DIBS=m and SMC=m.

So I my understanding is: it is ok like it is. Am I missing something?

Ugly constructs like  'SMC depends on m || ISM != m' are only required for scenarios,
where SMC=y ISM=n is allowed, but SMC=y ISM=m is not allowed.
Link: https://lore.kernel.org/netdev/20231006125847.1517840-1-gbayer@linux.ibm.com/

This was actually my initial motivation for the DIBS shim layer: to get rid of the
dependencies and IFCONFIGS between ISM and SMC.



