Return-Path: <linux-rdma+bounces-12114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F5BB03832
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD7517A6FA
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07CC235076;
	Mon, 14 Jul 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B8Ty965x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7395944F;
	Mon, 14 Jul 2025 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478962; cv=none; b=lkiN/jOukb8Qm4HBg2Zsj/wd+ErYWvLkAVf7Fdcn0tYItB3CaSPt3/pvbJCgCkZI390mKm1XW4Udf5yfb5jFDuB0b0Y8jdzhzzjacNgxQ/ru0ksz/4G/PSVNrNLj2h9TTaKWBistZ9Fqb9U+hwsXRNSITufJWWPrdE2QNuDklk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478962; c=relaxed/simple;
	bh=ZF1jeh3v4Kpuj61NdE9nZko0By4zUsBpKwHOGKM7WmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhEq1Y31ofDJVEAZw5QUc4MpxonEYLqV6+JkIGHTW1xar+qIJ9mZQIVXulfEC1FLhii2JcwOMzYOJRKs+BALdOecbvudLhJA3kqjk16FX9+V1Nd7gTzgeTaT3AHMXY2BMpYbqOPcI36kL/9JU3zbTDs0VqAHYrMpglsrQgmxJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B8Ty965x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNKJLH005187;
	Mon, 14 Jul 2025 07:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KMpMO3
	WC3c6dEIr6KZ2/Jk/KIkc8TR3yo2VFXQvvN30=; b=B8Ty965x2dqCUwAYx4EH2g
	mdz9J2cMCa/Lec+vOLb75kymFGfH0G1u0CYbzjBYU0yAaKPZN2SzYPOLsLM4kpO8
	Anizyj2FPNgt41z+AAE+ojhOMgS7uNZVm3kal0OI+uOfomPyZD2HSRtSNzYdvWPf
	WrGQks0RnjrzUu2Rk6npDrs6R0hySR6Cvwo/WSkDMvN4gdIrTSR7Q+js/29nz2X5
	5/NNCWgaAthN6b2NjREk0OSFd/rEEOvplq/ZJfh+0IEIlchWi7BbPAwG0aanxCPh
	jrEULettYtmKKS6aJ464M+/d8jJmmu2uJDyCGnf5cWrYxVeguPxUp+VOq28BY70w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6r0r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 07:42:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56E7fgwD022785;
	Mon, 14 Jul 2025 07:42:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6r0qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 07:42:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56E5La9L008941;
	Mon, 14 Jul 2025 07:42:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmctk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 07:42:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56E7gO5R45875546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 07:42:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B4292004B;
	Mon, 14 Jul 2025 07:42:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6026520040;
	Mon, 14 Jul 2025 07:42:23 +0000 (GMT)
Received: from [9.111.31.253] (unknown [9.111.31.253])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 07:42:23 +0000 (GMT)
Message-ID: <965af724-c3b4-4e47-97d6-8591ca9790db@linux.ibm.com>
Date: Mon, 14 Jul 2025 09:42:22 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] smc: Fix various oops due to inet_sock type
 confusion.
To: Kuniyuki Iwashima <kuniyu@google.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Simon Horman <horms@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com,
        syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com,
        syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com
References: <20250711060808.2977529-1-kuniyu@google.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250711060808.2977529-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=6874b4e9 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=DmAWCvTl3qigKM0tJr8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA0MiBTYWx0ZWRfX32w6uTdbE3LV sB4ENNS6Wlaqo6gSxjXdGKCjnZr6utTLenLeo4k4IhJKZ0JMI7MrJxbqjq4BQ2g41QJ8SvH9sdI 0OjCZ9bg0PIz+D19+qRU3nt2pz8Fu1T3PzXnE2XpWW+Ana6rDxjjSJkiPiIluEZrs53sbqQ0y0k
 mszKBlpFUF+TqB/rPN6jx7ZpIplfAVWxsC/LZgHQXhaUU3EtmSw4jvj1zbeUmaEQxY39J1auj2d 8Fktk894iPSzoq4xZsqeGmQOpfAmPDQH/r1dB+pSMAkVf1GdSYjJgH6iRmFii2huxMQYi7pbv1I 8EcTbPdroDinuUsMWG+ALUkUH0TRBMUT7T9hnmU/4ZoBhs44cvkvRrvyW8FWLsefofQtaQ0VucH
 vq7A9iogOfdkLPILGC/kW6TanKaQXApiLDMkaPCQvlOw6ATn5uJuLKlLdblCp/fUTlBFN0q0
X-Proofpoint-GUID: DDg8N3W8N5qFlTM-XGlBgLDiYHQXI0iz
X-Proofpoint-ORIG-GUID: OVuP7ziXTHj6jCOuUkePD3nfC8YpG7T8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140042



On 11.07.25 08:07, Kuniyuki Iwashima wrote:
> syzbot reported weird splats [0][1] in cipso_v4_sock_setattr() while
> freeing inet_sk(sk)->inet_opt.
> 
> The address was freed multiple times even though it was read-only memory.
> 
> cipso_v4_sock_setattr() did nothing wrong, and the root cause was type
> confusion.
> 
> The cited commit made it possible to create smc_sock as an INET socket.
> 
> The issue is that struct smc_sock does not have struct inet_sock as the
> first member but hijacks AF_INET and AF_INET6 sk_family, which confuses
> various places.
> 
> In this case, inet_sock.inet_opt was actually smc_sock.clcsk_data_ready(),
> which is an address of a function in the text segment.
> 
>   $ pahole -C inet_sock vmlinux
>   struct inet_sock {
>   ...
>           struct ip_options_rcu *    inet_opt;             /*   784     8 */
> 
>   $ pahole -C smc_sock vmlinux
>   struct smc_sock {
>   ...
>           void                       (*clcsk_data_ready)(struct sock *); /*   784     8 */
> 
> The same issue for another field was reported before. [2][3]
> 
> At that time, an ugly hack was suggested [4], but it makes both INET
> and SMC code error-prone and hard to change.
> 
> Also, yet another variant was fixed by a hacky commit 98d4435efcbf3
> ("net/smc: prevent NULL pointer dereference in txopt_get").
> 
> Instead of papering over the root cause by such hacks, we should not
> allow non-INET socket to reuse the INET infra.
> 
> Let's add inet_sock as the first member of smc_sock.
> 
[...]
>  
>  static struct lock_class_key smc_key;
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 78ae10d06ed2e..2c90849637398 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -283,10 +283,10 @@ struct smc_connection {
>  };
>  
>  struct smc_sock {				/* smc sock container */
> -	struct sock		sk;
> -#if IS_ENABLED(CONFIG_IPV6)
> -	struct ipv6_pinfo	*pinet6;
> -#endif
> +	union {
> +		struct sock		sk;
> +		struct inet_sock	icsk_inet;
> +	};
>  	struct socket		*clcsock;	/* internal tcp socket */
>  	void			(*clcsk_state_change)(struct sock *sk);
>  						/* original stat_change fct. */

I would like to remind us of the discussions August 2024 around a patchset
called "net/smc: prevent NULL pointer dereference in txopt_get".
That discussion eventually ended up in the reduced (?)
commit 98d4435efcbf ("net/smc: prevent NULL pointer dereference in txopt_get")
without a union.

I still think this union looks dangerous, but don't understand the code well enough to
propose an alternative.

Maybe incorporate inet_sock in smc_sock? Like Paoplo suggested in
https://lore.kernel.org/lkml/20240815043714.38772-1-aha310510@gmail.com/T/#maf6ee926f782736cb6accd2ba162dea0a34e02f9

He also asked for at least some explanatory comments in the union. Which would help me as well.

Kind regards
Alexandra





