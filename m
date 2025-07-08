Return-Path: <linux-rdma+bounces-11954-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C4CAFC28B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 08:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31097A7137
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDAB219A89;
	Tue,  8 Jul 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WrvdItYj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7ED1F5413;
	Tue,  8 Jul 2025 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955571; cv=none; b=CXQZC94euVf7SHzEf/22D3aXszeekdOp3hcI144B1lTcGbr5chQ/aevvS3TwrGBaqNvA/Tv2L9YG12z9qb2fiZgWNXcAR2T1IMjb4HUGxJkfBqYLZkveKhAgG9zTtOF5ZY6czFMNnIv3ien5yx3i/ibQSuQVUXvymzAN61TrcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955571; c=relaxed/simple;
	bh=a9VQ/OKuMQxNDls3x39RI94adWFSYdHXGaxMD5Plndw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lU+zil2BvpPrr1xV0CLqWksSBA1h1CJJGpC6WsD4bOmR0lmSBEfc9zFQ4SyjDAQ0gLbsYbLe2/oK2zDEPeCp/iF2dEYcUxtHMy4nWaKWMSygJBLsyaif7w/99Ave488FmS8JDS3PZtW58arfjKrCyO/tsVRq2wx9Tio1CObpj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WrvdItYj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5685BZBc006198;
	Tue, 8 Jul 2025 06:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ppMPP8
	ppoa84lSjqkTeweSkbyPG03QPa5F2neMbbDPU=; b=WrvdItYjSh2gjwq5iitiNW
	tVKMx7eXkAcalY1zBI8ARZOa1FCzWs3ycvzy9/XkPiqSTpgRxIkZvkQmZcS2KXeQ
	YxO+4zm9cbXkpXUIq2RzBq8hwjyfuH3uzvr73rf3csn/KZHa2xq0Y+S+BfgiqaTM
	AKCihfKNPL6YSLWvVe8/O7Yn2C/0ealGtAACoU+QrNaMpwSSUWiq/OBEv4YLswnQ
	XIOnfsqe1p0MhAGDtTZJPE3XDzFatjDVWrgmYQAS4Btzxn1A6u4t0CvfJ525e81/
	ZGtyb002mBRymIMPtt8waWS0QpqyW4xOs6z0CW1ugLEJcrR7kBRKGOamfy95e3hg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk3x2s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 06:19:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5686JMfo002363;
	Tue, 8 Jul 2025 06:19:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk3x2s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 06:19:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5683fohR024317;
	Tue, 8 Jul 2025 06:19:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh329aek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 06:19:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5686JJXR28443186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 06:19:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D6A558055;
	Tue,  8 Jul 2025 06:19:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F39958066;
	Tue,  8 Jul 2025 06:19:14 +0000 (GMT)
Received: from [9.109.246.12] (unknown [9.109.246.12])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Jul 2025 06:19:13 +0000 (GMT)
Message-ID: <88176330-73c3-45d0-ac14-d7ae0a14e80d@linux.ibm.com>
Date: Tue, 8 Jul 2025 11:49:12 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/smc: convert timeouts to
 secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi
 <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250707-netdev-secs-to-jiffies-part-2-v2-0-b7817036342f@linux.microsoft.com>
 <20250707-netdev-secs-to-jiffies-part-2-v2-1-b7817036342f@linux.microsoft.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20250707-netdev-secs-to-jiffies-part-2-v2-1-b7817036342f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0OSBTYWx0ZWRfXyNZsdDHEcY90 u8UzrjIR5EU86PYRkYCM6Mxcj3byRjGQs0m1CrL+IIt595tsB5oUlWCI8b93uXBhXxR21rRFxa5 EDuS29D1SIzO3b6lQRiCEJLCkRhL/RShrie4QW5+b/ktEjLb3sQa3eYa0yJwBt7WrsbV7AB53nY
 s59lh7HA3vVNtZEPqAkeG8wMCZKwfe92IH3UtiIDMYCrDpT58u5ZS7bxa0F9I0osqtAGsNTobn9 OfEnnu1SpNpy4tVOqsKDRGt94Mm5hDeEEVHKvVFeUVJSHr+0thHomgdDDYcZDSY5ehdCAaD6CHP oU4MEFs/iKib12OvqibScKv7O8UvYIgzEuGqkld33PONCMOQeOXz5Dyvsr4pf2jT7sxaIZL5S1i
 brtHtPLVDExzHqgw75Ki1xDsLXF+T4ogiSn+UpNQfILh96GZfcVMoXn9ujmjo4V+4I3S1w30
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686cb86b cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=Z_BCh-ONDyC5R4AT590A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RMisSh4tEMnFjdxfY2J90WO6jupJWmpj
X-Proofpoint-GUID: QFE95R7zLzfrV4WgjMEO0JngNJcfM5WB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080049



On 08/07/25 3:33 am, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   net/smc/af_smc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 8d56e4db63e041724f156aa3ab30bab745a15bad..bdbaad17f98012c10d0bbc721c80d4c5ae4fb220 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2735,8 +2735,7 @@ int smc_accept(struct socket *sock, struct socket *new_sock,
>   
>   	if (lsmc->sockopt_defer_accept && !(arg->flags & O_NONBLOCK)) {
>   		/* wait till data arrives on the socket */
> -		timeo = msecs_to_jiffies(lsmc->sockopt_defer_accept *
> -								MSEC_PER_SEC);
> +		timeo = secs_to_jiffies(lsmc->sockopt_defer_accept);
>   		if (smc_sk(nsk)->use_fallback) {
>   			struct sock *clcsk = smc_sk(nsk)->clcsock->sk;
>   
> 
﻿﻿﻿Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>



