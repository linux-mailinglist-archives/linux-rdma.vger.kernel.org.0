Return-Path: <linux-rdma+bounces-2398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B9F8C21FD
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833191C20C4E
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD62168AF0;
	Fri, 10 May 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RCWRYoNy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93136130E39;
	Fri, 10 May 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336583; cv=none; b=G+v5aowAMSngyu4OIfraVF26aSqy8titwf3EUn59dOLXMf09Qk/vcKD8M+cRqTFepMaD+ucI/rgPKJw1OOiB+48XNLrFI3OZ0XNA4Vjvlx79ODH4dlP+ApvckHo6uZpfHw5Xh3Td1H8khMIqE8R2CBM037V+q2VoKDs+EWjVCA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336583; c=relaxed/simple;
	bh=oJTSAfBvuIycIoXTlRrSClNVDYbN32w4IpQTqf56fco=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F3SJGPfa5g1/KMO1okXOjCKZb9an+iNcrKoZUuqBcBt5RUd/2x1JrgUxpojuuV133xB8tAkAZj6tJkRORucYdn1/2QwXS41SglgtXYmjyjFwVRWt7k6R8lZfDGLxIwbErVj/AG2XqkvHmPT9SLI/VfmOcYZjLjDvs2aIk224RVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RCWRYoNy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A9Cqx8022386;
	Fri, 10 May 2024 10:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MG5ZYsRiODRe4ubGtFf8H3gDEjjOmPzap7ojKtBzCzc=;
 b=RCWRYoNyivhryOSfXnxpR0dknta7AKjeVlGRD8GqnqHGNishCuQLYpUeRbBx8i7w59Iw
 SbikzDl+fPAPXkCbc9qpsxTaPOyDYAVHpeAQ3GeUbQ03vd9XDI8ypHUi4Qa4OSqk5YLw
 gJ6qV5siXlAk8EO1GDnHFlOv3kLtMFwthDhjN8qbDKrC/aqnpNm1q81tQc70yxLF4Hzy
 H/SCdH8RhsNRv4qVcTgKkpWIULZSwT+Ep2SzgKy6D8QMpbZ/XAT0mFkvI9n0EYfhCXz5
 A+YQUjxYQo266+vj6Fs3f0YPkkOKG0MLq2PJeKeHR5ZQSttOI/cW4ZlviHstCWnVacTV /A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y1grdr50k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 10:22:54 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44AAMrmK029219;
	Fri, 10 May 2024 10:22:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y1grdr50f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 10:22:53 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44A7Ower017582;
	Fri, 10 May 2024 10:22:52 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xysht8kw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 10:22:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44AAMmIq45482446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:22:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7C1458059;
	Fri, 10 May 2024 10:22:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0CDA58057;
	Fri, 10 May 2024 10:22:46 +0000 (GMT)
Received: from [9.171.7.235] (unknown [9.171.7.235])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2024 10:22:46 +0000 (GMT)
Message-ID: <310155d9-591a-428f-ad81-d317615faa90@linux.ibm.com>
Date: Fri, 10 May 2024 12:22:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Introduce IPPROTO_SMC
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l2kbX6APCCV0-1pkzDdruf7P-z99Nzgf
X-Proofpoint-GUID: K9ygItOsGcJw_nv5XM2sXt1N1yDIsgTG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_06,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405100073



On 10.05.24 06:12, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
> 
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> 
> /* create v6 smc sock */
> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> 
> There are several reasons why we believe it is appropriate here:
> 
> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
> address. There is no AF_SMC address at all.
> 
> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
> Otherwise, smc have to implement it again in AF_SMC path. Such as:
>    1. Replace IPPROTO_TCP with IPPROTO_SMC in the socket() syscall
>       initiated by the user, without the use of LD-PRELOAD.
>    2. Select whether immediate fallback is required based on peer's port/ip
>       before connect().
> 
> A very significant result is that we can now use eBPF to implement smc_run
> instead of LD_PRELOAD, who is completely ineffective in scenarios of static
> linking.
> 

> Another potential value is that we are attempting to optimize the performance of
> fallback socks, where merging socks is an important part, and it relies on the
> creation of SMC sockets under the AF_INET path. (More information :
> https://lore.kernel.org/netdev/1699442703-25015-1-git-send-email-alibuda@linux.alibaba.com/T/)
> 
> D. Wythe (2):
>    net/smc: refatoring initialization of smc sock
>    net/smc: Introduce IPPROTO_SMC
> 
>   include/uapi/linux/in.h |   2 +
>   net/smc/af_smc.c        | 222 +++++++++++++++++++++++++++++++++++++++---------
>   net/smc/inet_smc.h      |  32 +++++++
>   3 files changed, 214 insertions(+), 42 deletions(-)
>   create mode 100644 net/smc/inet_smc.h
> 
Replacing the preload library is indeed a good reason for this method. 
And that could be a new era for smc. However, there are still some 
details we need to take care of. Thus, I'd like to ask for more time to 
review and test these patches.

Thank you,
Wenjia

