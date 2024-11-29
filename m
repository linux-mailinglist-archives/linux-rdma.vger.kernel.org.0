Return-Path: <linux-rdma+bounces-6162-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB629DE78B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 14:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0D9281750
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798EB19F495;
	Fri, 29 Nov 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="liXOh80t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4A19F424;
	Fri, 29 Nov 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886958; cv=none; b=Ve3WFjeNbrOHk4lPnFX3SBH3kyOo4+yeeJDhk6YSyML8QjoUZU/oUKl+WZr2UTU2gjt3svOzvA1tqrnPJ3Va4JCJbyp97LF4Ob0qcdSilgSQSZ73ri7sw5IvmcwVniS6o+HdWDnaPV5SNm5xPgyckO+4hlDofXjj+6/8wEJGnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886958; c=relaxed/simple;
	bh=hHSy2jje0m2fGnDElMDfUwXzsVlVbqnNaNhRx2jTiwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBEJZf8i3u+e0mKrGmAAnPmkb1lUquyrFyKiFt588jWu5byeB80IHR1wbYaYhEA8bZca/UfV6kdpLuf3bkhJS480SGG55QkMkZ5qFKvRtATysykJr9U7noqgdWq7Nl0OXNvip8HiBSNgP2gT8XelhuCL0feqtWi/AivSoL3pGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=liXOh80t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT5paRY030786;
	Fri, 29 Nov 2024 13:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P4TsIX
	xU1c6A7+T5dOldsD3Fa1gS0AfXfSrycHUdFlA=; b=liXOh80tIYXnJcvtnXwEGw
	VImgB3vdbUhGdqdkJIVI16WNA5CyhpiIrAZbcdwiwUbBdtUOwUG1Au6J4CcJsq3h
	6j+agmJZTG8c5sEkYwMWGp0JVPWspQzEo8g6cIeyHjkSAS/752S0wxdyVuFMQ1mq
	IcfVG3G3LuiT8BDD86dUijvP3yjV1JtTgG37eAN0uohCj2rEt3PiGYJSMmmJNxnY
	79KKnCj47JG25bE/7xgHsUYqC05RU6VZj/vdW/jTAnQChM74qze9aQLwRjN/fNIR
	Sw9afX3LgWh6GCbykiqr6b/i+km617+1mQgW39bMbmsoPwuhRZjcSg5SS59i7D3A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436upa4p6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 13:29:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ATDQJBk029268;
	Fri, 29 Nov 2024 13:29:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436upa4p42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 13:29:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT9rKVs020371;
	Fri, 29 Nov 2024 13:28:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43672gbw34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 13:28:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ATDSd0P47120764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 13:28:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDFB12004B;
	Fri, 29 Nov 2024 13:28:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FB7720043;
	Fri, 29 Nov 2024 13:28:39 +0000 (GMT)
Received: from [9.171.68.139] (unknown [9.171.68.139])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Nov 2024 13:28:38 +0000 (GMT)
Message-ID: <227ce73e-a4f9-4b97-a137-f3a6472bf07f@linux.ibm.com>
Date: Fri, 29 Nov 2024 14:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net/smc: fix LGR and link use-after-free issue
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
        kgraul@linux.ibm.com, hwippel@linux.ibm.com,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241127133014.100509-1-guwen@linux.alibaba.com>
 <20241127133014.100509-3-guwen@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20241127133014.100509-3-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M2cTUaHw4ohcglK7s_ECQuD1U814d6VV
X-Proofpoint-GUID: -352ikGp2Goil5r1crjjY8nSacc7TBNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 mlxlogscore=802 phishscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290110



On 27.11.24 14:30, Wen Gu wrote:
>  net/smc/af_smc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index ed6d4d520bc7..9e6c69d18581 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1900,6 +1900,7 @@ static void smc_listen_out(struct smc_sock *new_smc)
>  	if (tcp_sk(new_smc->clcsock->sk)->syn_smc)
>  		atomic_dec(&lsmc->queued_smc_hs);
>  
> +	release_sock(newsmcsk); /* lock in smc_listen_work() */
>  	if (lsmc->sk.sk_state == SMC_LISTEN) {
>  		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>  		smc_accept_enqueue(&lsmc->sk, newsmcsk);
> @@ -2421,6 +2422,7 @@ static void smc_listen_work(struct work_struct *work)
>  	u8 accept_version;
>  	int rc = 0;
>  
> +	lock_sock(&new_smc->sk); /* release in smc_listen_out() */
>  	if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
>  		return smc_listen_out_err(new_smc);
>  

As far as I can tell, this looks good to me.
Unfortunately I don't understand the dependencies between the different SMC sockets and TCP sockets
well enough to give an R-b.

