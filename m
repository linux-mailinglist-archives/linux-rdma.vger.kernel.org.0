Return-Path: <linux-rdma+bounces-13274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E979CB52EDA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 12:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D88E5A208C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96A310631;
	Thu, 11 Sep 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RxLXsu3t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3C29A2;
	Thu, 11 Sep 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587452; cv=none; b=Arz7mSXG+Z/b67093mKmB9o8pbeqNmVvcTTVUFxD7YvCsAbXdraMDrKgR+xvg/Cz6yJcjBazLF+6VLmlbtFGlWmRyI18ajxXWEUUIyEOEjbgwLp0b8KzXTPf3UPRYtCudtFgtb9fF599mIla/fAQScfedVXdVmWj576RYQEO/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587452; c=relaxed/simple;
	bh=Swde+Hi+3ITyGRK9/AxWwHZwjrgVy8whbbKd2UeVfDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5n0VXYqy3/emmWsuGhUo2PVERY3irZvg5DVJefR0Ikq5GMaeZNmaPs9KyfxfrCoscScElfu6XENKzkywBV8rNRK9xeEqNWhQxwntLKfL+bnj4UmydQjuK9ISQefYm+s/dQKhy8Yq6QIaMdZtFNpcd5QZBIm0mph82Ueyv5vSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RxLXsu3t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2T5Xp009660;
	Thu, 11 Sep 2025 10:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ezv6MH
	CQJydzZELRFLwYdUjg0nfO+4KaY4T2Hx6OoZ4=; b=RxLXsu3tiaxmBbIXdC3ZXU
	/pyhEzgwpNWJjeTBduboorigbRnUMvjj0pEErlj/0qdOz0rO4o7Z5ZZr6dG6UXUG
	gTSYIW8VUksmELnvvqsRJMCWWDBPVGmFSCZ1ELTozpTjsYbaNNACmbyd6rzvabqq
	zJ7az461s1mqolEudi5gbTDInOt8RpP3Y3A2c7O7OJp8fYULIZzzglZEK2V441OV
	BqlxNf7FWNEHTOsfrgNnaYHOGKfhetJIxXT980r2xthrEsCJ17RTc4FJuoi4hk7p
	SNoiuyvENaHPj1icfqeYRYGXw+GN7Qd8M4Zd+WcyE6kJ9ntPZSHDg4bEqaVFq3JA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrbg8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 10:44:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BAdOu3030455;
	Thu, 11 Sep 2025 10:44:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrbg8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 10:44:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B84Tc1011428;
	Thu, 11 Sep 2025 10:44:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9unku0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 10:44:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BAhud252429068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 10:43:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA3620040;
	Thu, 11 Sep 2025 10:43:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D1C020043;
	Thu, 11 Sep 2025 10:43:56 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 10:43:56 +0000 (GMT)
Message-ID: <ee9c259b-1c32-4ba1-9bfa-cc21b2735290@linux.ibm.com>
Date: Thu, 11 Sep 2025 12:43:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/14] net/dibs: Create net/dibs
To: Julian Ruess <julianr@linux.ibm.com>, dust.li@linux.alibaba.com,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Aswin Karuvally <aswin@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
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
 <b2c1b2b9-ce28-4a20-bf48-a427b364a664@linux.ibm.com>
 <DCOY3FWT1W5E.3SSDEILQWSZOF@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <DCOY3FWT1W5E.3SSDEILQWSZOF@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t8NwpX26Nyd3L1CsslNreD9hiSbtlRID
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c2a7f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=c1AFN8GM_vvGFmY8fb4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8v43vAMjN1qyz7QI6JcZ2nXXMNCy8ido
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX5/aHh2zAO+bQ
 OPz1SRMhUuM8T+Fiv9t88lVgIRQJB8qUk87Q1pIbt2CXAuE/frcXAwIeHphoyPuuopXhrmjSyoH
 1/YLQZB8GTIsNIF4TQ3FegDop/SmmdScty7QIpEkZDGO4rOhysZR/Fqdml0cJqKJxbMZJ4+pL6A
 v5Ai/xAcjQyzgeoqCaZeEGyv3l+XUjpo/FjBQEEJsuDqr7ydU6uZKd8+IBEvpcnSQTViehItHOO
 OCPdqQ0tZf7SE7TBBNd5SwJdEL5JKL9u16DK5fr6xexqu7Q5/bD7zcQdCUlE1AK5jgmU1vhQww7
 siM9kwAcjxh0jfXCqifYmExSdwvm5j4QNA5zTLvRoPte1d/AbbCA1d6G71/N2urktmp1+iuzwi6
 ELZqclgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000



On 10.09.25 09:34, Julian Ruess wrote:
> On Tue Sep 9, 2025 at 9:36 AM CEST, Alexandra Winter wrote:
>>
>>
>> On 09.09.25 03:54, Dust Li wrote:
>>> On 2025-09-05 16:54:16, Alexandra Winter wrote:
>>>> Create an 'DIBS' shim layer that will provide generic functionality and
>>>> declarations for dibs device drivers and dibs clients.
>>>>
>>>> Following patches will add functionality.
>>>>
>>>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>>>> ---
>>>> MAINTAINERS          |  7 +++++++
>>>> include/linux/dibs.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>> net/Kconfig          |  1 +
>>>> net/Makefile         |  1 +
>>>> net/dibs/Kconfig     | 12 ++++++++++++
>>>> net/dibs/Makefile    |  7 +++++++
>>>> net/dibs/dibs_main.c | 37 +++++++++++++++++++++++++++++++++++++
>>>> 7 files changed, 107 insertions(+)
>>>> create mode 100644 include/linux/dibs.h
>>>> create mode 100644 net/dibs/Kconfig
>>>> create mode 100644 net/dibs/Makefile
>>>> create mode 100644 net/dibs/dibs_main.c
>>>
>>> I recall we previously discussed the issue of which directory to place
>>> it in, and I don't have any strong preference regarding this. However,
>>> I'm not sure whether we reached an agreement on this point. In my
>>> opinion, placing it under the drivers/ directory seems more reasonable.
>>> But if net/ is OK, that works for me too.
>>>
>>> Best regards,
>>> Dust
>>>
>>>
>>
>> You mean like drivers/infiniband that provides sys/class/infiniband?
>> I don't have any strong feelings about where to place the directory.
>> Are there any practical consequences?
>> Other opinions?
> 
> I agree with Dust. Since we are planning to also have non-networking use-cases,
> it would be better to place it in drivers/.


Moving to drivers/dibs/ in next version



