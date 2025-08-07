Return-Path: <linux-rdma+bounces-12623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AE5B1D2E4
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 09:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9103A5506
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 07:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E74227599;
	Thu,  7 Aug 2025 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J6MsBPLl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E11F0E34;
	Thu,  7 Aug 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550119; cv=none; b=ngyYvzUFhJWBKvejrL0+2Bl856IYFZEncA84jOmiRjdCkohdvGcICFy7jHmrtgQxxZOR+it/ZkdLu4EaVgAhwegIVsrI6+QN3o8EtH5gVG2GBv5xaswLeexnywFeQx+5QgPHfexd0dBzkgby6JAvYMDk+GM2DAn3FQDNUDTnxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550119; c=relaxed/simple;
	bh=RxgJWx/CRPO16SNAZNIMksl/YmJs/4TUq+ajDi59q1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoRfTgqBfZO5sKe7oomYFar+/nzS1DYBgo8G1eykj8pDbts6vhLfQBZ92E4IR2O8mjiPRFp4jPRwVJkxeALmY7tqgzEMzwBezPBqZxDQUISeeSBjSz5Q9rJovuIXDGP7yDwpJnY5oN9OIFb9Ku0fjPh1avngaKIsZXiqQWtFIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J6MsBPLl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57743JQG028175;
	Thu, 7 Aug 2025 07:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HYqzOl
	Zpv1tnyRF/96MpKpFlFZUSpL6fqTmJlP5wiVM=; b=J6MsBPLlIJIBnKgFnmefrR
	B/1g/Z6CGO047CS9k8OukAFFIKusislOgAgYQZgBjlNhDF+KrheSSTT0WKtAbR24
	zyvSl1ZvvFuj7z/iYlyFLiMf0UIRxD04OwulFULfq/3vXlz5mdZBz/g/bIDWeuJs
	F8QzDAjEKNvHib2whjGg9o4od3cnSI7XszmjxmuscwE6kFz3ZX9Ix83KNMlVBuHO
	AbiumTydd3rejA73lYciPu7OMicq56rgWjJoq6hfxJgDgciu7SUzHyDcskxcH869
	ohN6xjGBHUQJulTuUHtQLRb2gufGavV6fj7IerbfWQbL2KJ4KF4xZHCBnHjtbCrg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq610nuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:01:50 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5776tL5F032415;
	Thu, 7 Aug 2025 07:01:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq610nu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:01:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57754ksk020626;
	Thu, 7 Aug 2025 07:01:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwmycem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 07:01:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57771iQ715139074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 07:01:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6498E20043;
	Thu,  7 Aug 2025 07:01:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F61120040;
	Thu,  7 Aug 2025 07:01:44 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 07:01:44 +0000 (GMT)
Message-ID: <c1a8b08a-680b-4cd6-a0b2-c94388304fe1@linux.ibm.com>
Date: Thu, 7 Aug 2025 09:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 01/17] net/smc: Remove __init marker from
 smc_core_init()
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
 <20250806154122.3413330-2-wintera@linux.ibm.com>
 <aJQex0Ey-eaysumJ@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aJQex0Ey-eaysumJ@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lmR-3Ln4TZeURc2IHvscMh7bjqHpGojR
X-Proofpoint-ORIG-GUID: talQW7ZRVHpUpI4CcA4rvay4LQqHE8NU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA1MiBTYWx0ZWRfX46nwaotJnd07
 6NXUIDcmz3Apb++2dNmpu7A+vx5rk9aw357xhr+s+aRCYUewiM364tEMlldNA02f+AReZUg9GJ0
 lket/dWisf4ydY22roNQQOQP91JSFQqR0ApaaHYlxf4SNbsRdux48WGSbdK2OTXtduvA62WHsFH
 btmUlzaGT0rq2hfFDOPahsTPxGE4kB4S3rjdPYdxXz/Nr9ElonP0s9q7Gq6gGLKhYR5wJmPfGmD
 Sq/qTo1/+Uasdh1dAO/3TKgevuFGnAVmaENppEdu+duxPyjq/HeijIYXuLUvWnGdDfvX20H/+jM
 gF36KuV/irVAQxRSixJ8OVoeMBfmAIJqI7MLv7Q+4PrYPzvr9NY375ptOuDoq3mxsAHOXHqnPRe
 sGT3M5XVck42AsdYROzK2b+qcbIxAJYUggSE6n7KvxmmRGdnVWbOXk2Wg+JZzISXyc72fEYI
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=68944f5e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=rCoTjgMRcGilsMQW6BcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=670 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070052



On 07.08.25 05:34, Dust Li wrote:
> On 2025-08-06 17:41:06, Alexandra Winter wrote:
>> Remove the __init marker because smc_core_init() is not the
>> init function of the smc module and for consistency with
>> smc_core_exit() which neither has an __exit marker.
> Have you seen a real warning or error because of the __init marker ?
> 
> I think the __init marker is just to tell the kernel this function
> will only be called during initialization. So it doesn't need to
> be the module's init function.
> 
> Best regards,
> Dust

My bad. Thank you Dust, for pointing this out.
This patch will be removed from the series.

