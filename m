Return-Path: <linux-rdma+bounces-13919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE1BE6F7D
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 09:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10DB94F222F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 07:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016123AB88;
	Fri, 17 Oct 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="U9rPqERF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C571A316C;
	Fri, 17 Oct 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686819; cv=none; b=e+F2UEX1+unyzJ6e+y6NEypfkoRArfg8k+iJ4UPm4ehaHhvRsBdfCIRjyAOIkVa+gHYqOTCORnL37NKmA3WgI5KdFSiF0sZAxkPFHlowA8LvCarzXgdn/RIhnK9rzx0v5h+6c8A84vwF9E0Dio0prSgOUUEWvGImK2Yl3Oyk4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686819; c=relaxed/simple;
	bh=OI/9YTWRPQ3D3kcnzcU/QsYUJbdBXCeyMSiNZugxufs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=pU+pRzRC24Owxo2JYTWBe32TGRHlNRBsCrID5sTiNxe1Vty0QDXe/vsSb0w2Hru3VDeWOvoyTjf0uKLfts3rNP+E6r8MRtaBDXML/pOuziGntm4O3Vb6EurHswS1lFsjcIN28DgDLRlNpeBk65YMe/ggt9NX2X4RM15/Uyf4z8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=U9rPqERF; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=P9+/eI7A+ZVCFlg1SNVuoMx6QePw0f4EAfUQmVzNBw8=;
	b=U9rPqERFM1DhDFePmNOed35hSJKuImZ0VhOHWQI3JcBmv0TDKxo0XaX2+/SsO6HC3fP030Bu0
	Lpj4z/U4Ub22EESn0Yi6L0ValRQ+UoSnf1x6uZ+h6Biu74ygsAwQbXIjfcToVYg8k4X3l60pbyw
	+QqUQvS7V5vIbjK8ePEdz4o=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cnxXw250bznTVF;
	Fri, 17 Oct 2025 15:39:28 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 51F7C140120;
	Fri, 17 Oct 2025 15:40:12 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 15:40:11 +0800
Message-ID: <b76f348d-61d3-404b-81c6-57621a14046b@huawei.com>
Date: Fri, 17 Oct 2025 15:40:10 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: Wang Liang <wangliang74@huawei.com>
To: <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
References: <20251017064823.1639083-1-wangliang74@huawei.com>
In-Reply-To: <20251017064823.1639083-1-wangliang74@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


Sorry, this is an incorrect email, please ignore it.


在 2025/10/17 14:48, Wang Liang 写道:
> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> index a944e7dcb8b9..a94084b4a498 100644
> --- a/net/smc/smc_inet.c
> +++ b/net/smc/smc_inet.c
> @@ -56,7 +56,6 @@ static struct inet_protosw smc_inet_protosw = {
>   	.protocol	= IPPROTO_SMC,
>   	.prot		= &smc_inet_prot,
>   	.ops		= &smc_inet_stream_ops,
> -	.flags		= INET_PROTOSW_ICSK,
>   };
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> @@ -104,27 +103,15 @@ static struct inet_protosw smc_inet6_protosw = {
>   	.protocol	= IPPROTO_SMC,
>   	.prot		= &smc_inet6_prot,
>   	.ops		= &smc_inet6_stream_ops,
> -	.flags		= INET_PROTOSW_ICSK,
>   };
>   #endif /* CONFIG_IPV6 */
>   
> -static unsigned int smc_sync_mss(struct sock *sk, u32 pmtu)
> -{
> -	/* No need pass it through to clcsock, mss can always be set by
> -	 * sock_create_kern or smc_setsockopt.
> -	 */
> -	return 0;
> -}
> -
>   static int smc_inet_init_sock(struct sock *sk)
>   {
>   	struct net *net = sock_net(sk);
>   
>   	/* init common smc sock */
>   	smc_sk_init(net, sk, IPPROTO_SMC);
> -
> -	inet_csk(sk)->icsk_sync_mss = smc_sync_mss;
> -
>   	/* create clcsock */
>   	return smc_create_clcsk(net, sk, sk->sk_family);
>   }

