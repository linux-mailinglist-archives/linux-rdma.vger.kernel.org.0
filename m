Return-Path: <linux-rdma+bounces-12633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC11B1EE72
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 20:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D141A05F8D
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C0A274668;
	Fri,  8 Aug 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LgemeNHu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B51DA3D;
	Fri,  8 Aug 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754678321; cv=none; b=Q/tstCdsLPqM57GirzdS39kflpIlUPltegF4nlM+qjGQnXLdYEp9GHd9wGKL+7j6JUaZ6bYNFNAmkUf9q1XSJSUzObXi6UhFoOfO+UJR52L/k6zNLE0zhJm/0iiiOXr+SWo/v98BDabHGxwDh8BjRJh+HWBgXeyCywNXmo03FKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754678321; c=relaxed/simple;
	bh=MRK1NlO4ena0nSoXtM7SEXTYlBYIZPK75P8eiLXGIY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUAPkEPu71/Zg6fSbtycsQp+Cx/kQi/ZlkdhkUbMF2EHJkP2Rot5EHcdgQXreM9p49cuwrHuTrQTF/EDbeH9HhOWZ6uKB7kgTKsBuHe4XXk/URH1NT6uj3urT+r2fx1lJViD57pB4w7nE85oP81r3tOunPTiiBqSDFh782bACHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LgemeNHu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578GZRBJ019393;
	Fri, 8 Aug 2025 18:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0SBqKm
	EWYt6DqSDPuA85eMWEvk9krUa3R1E4kn9iHkI=; b=LgemeNHusCjjvTwxDBY8yA
	oqN3BfmVpb3YrpI4TIbAGQ9EwCEZnniE4+eQChMVi0r6MshJjlFIjDyO5ZHmyYZb
	zfMPThVxyjPLvhz0pQNcGqmwUxoZ/QbUAUXdTGyaalILWYtEt1sE5XEQE0icQ7mW
	+cFF10xyapDVfYiUoisbzZI8BLuJbX6jyv1GpkJfnStDZk0OQLARF70866M9xwEc
	M4YIcmur+LvngwVs0HIA0/UOTuJAx7dA9cOeNML8mRR2KyImvxW/CMV5YoF181ZE
	hWGUgGmkEPEa9LeUa1ggxvk+BjVuEuBvTgZPN8WE8WC8G3yJZLB+fEX632iy33aw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u7gq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 18:38:32 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578IXBR7027005;
	Fri, 8 Aug 2025 18:38:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u7gq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 18:38:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578FTn7C031315;
	Fri, 8 Aug 2025 18:38:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwnpwgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 18:38:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 578IcQ4Z48562446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 18:38:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45BAF20043;
	Fri,  8 Aug 2025 18:38:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3C8B20040;
	Fri,  8 Aug 2025 18:38:25 +0000 (GMT)
Received: from [9.111.169.241] (unknown [9.111.169.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Aug 2025 18:38:25 +0000 (GMT)
Message-ID: <0e559dd2-f0e2-42e1-92f8-28434817000b@linux.ibm.com>
Date: Fri, 8 Aug 2025 20:38:25 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 16/17] net/dibs: Move data path to dibs layer
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
 <20250806154122.3413330-17-wintera@linux.ibm.com>
 <20250807203438.GR61519@horms.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250807203438.GR61519@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2UEx3-TNWlgDmjF4KAV83TWm5X2DHkKG
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=68964428 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=YGhG2mWU0OJ6GEo5n6wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 52G0KEBbPp1g6K6b7qiUXqQF21aejOv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE0OSBTYWx0ZWRfX94druy/c1663
 kZa5wlwzXA0sA9YY2/a1Aq/PP544jchwBWU8FZU0PDu3A2CycOphEvYNaA/bk33hKV7SoS0gJi6
 B6i7FJmJ+im2t57A6z9ki+6JiTa6kIbdCR3KkGvTP+uPkwpO3kotMb6CpNNrEq8WWB7DDjcx88B
 Jj/AHiTeupG+KrWUlLymbtZ1+tse6lxvrt4wLOZpb0CjNPMMHb6d5zhnvOxsY4Jc/N9VOEhDxy3
 KUQMJ6m+Z+rKr4DdTlRk2hA7rKf7WJOANB459QwQmXJ8MV5h22A6+HoGz0geTPhMg/S4yyn9YDU
 Utm6ExH5DN9BCAeOTruqi5XuRn6MR20t8r7DIRY7QtUQb908DVi/CDsndg91O46kguyEPf4y+EE
 HeNkN1EbwLp5Uu/gGq8bqSwCKNmYQqQWy/M5cZ5Jba8tMN4LXz9HH1AP44XxKCZbpUz8PCQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080149



On 07.08.25 22:34, Simon Horman wrote:
> On Wed, Aug 06, 2025 at 05:41:21PM +0200, Alexandra Winter wrote:
> 
> ...
> 
>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> 
> ...
> 
>> @@ -33,18 +32,18 @@ static void smcd_register_dev(struct dibs_dev *dibs);
>>  static void smcd_unregister_dev(struct dibs_dev *dibs);
>>  #if IS_ENABLED(CONFIG_ISM)
>>  static void smcd_handle_event(struct ism_dev *ism, struct ism_event *event);
>> -static void smcd_handle_irq(struct ism_dev *ism, unsigned int dmbno,
>> +static void smcd_handle_irq(struct dibs_dev *dibs, unsigned int dmbno,
>>  			    u16 dmbemask);
> 
> Hi Alexandria,
> 
> smcd_handle_irq is only declared (and defined) if CONFIG_ISM is enabled.
> 
>>  
>>  static struct ism_client smc_ism_client = {
>>  	.name = "SMC-D",
>>  	.handle_event = smcd_handle_event,
>> -	.handle_irq = smcd_handle_irq,
>>  };
>>  #endif
>>  static struct dibs_client_ops smc_client_ops = {
>>  	.add_dev = smcd_register_dev,
>>  	.del_dev = smcd_unregister_dev,
>> +	.handle_irq = smcd_handle_irq,
> 
> But here smcd_handle_irq is used regardless of if CONFIG_ISM is enabled.
> 
> I believe this is addressed by the following patch in this series.
> However, this does result ina transient build failure.
> And they should be avoided as they break bisection.
> 
>>  };
>>  
>>  static struct dibs_client smc_dibs_client = {
> 
> ...

Fixed in next version.
I'll make sure, all patches build without ISM.
Thank you Simon.


