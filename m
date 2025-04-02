Return-Path: <linux-rdma+bounces-9111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E69A788C8
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 09:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADEC3AEC96
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B89231CAE;
	Wed,  2 Apr 2025 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JmJgOKNm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6B314C5B0;
	Wed,  2 Apr 2025 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578423; cv=none; b=GDHqGQpJsfZwLOtC42+v3SeES72WFF3vejRtdGZhdXQ0XCxxt2I15wgGXqNpC5ZP3ClT7BIvDC/5K4mb0KzV+R4fCxyQai25WZmq9hkAPtFwEYkP8Z5pit99wwMRkCUwVS1KByNsNf0bseQClq1sQ3eIPDOMIyuwohfFrjiRyGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578423; c=relaxed/simple;
	bh=FG+mAEEJfFXvvo/HA/Yd5WAZif8rMmBYXzAaraYQrSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYaSg0nyMxk81xzoFSNYk07Tl168ZaV8pyBiJjTZNaqOokeNCECo+rV7uyyNBLGal4gogXfOUSh0BL9dA1cjZOlCiSWntvD6NzuFGWxqRquCYDc8Dy4+HM0KQBOSPoJ5Jl0Eo8C+kryQt+ZOpJF9E/2i0WkAcHiJ3Wpn0V1YlzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JmJgOKNm; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743578411; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=o3ZsxU/eLRlIBgMdAFPcSQYxPGvBAI0bku7B/uSDh6M=;
	b=JmJgOKNmEAclSf4uui0i9mFSEDp57ahCauqzo1bZBx/fFggXBPYlf4unbwyz8Wgo7aOtLWcTTS3h2xj1iYyAOiFVGKjanmNVm5rWtnhITGJJzyPWX390gF8mhv5x3yuVCMWbuRV6Wf+hnkmkH65MTwVuqXOglURQcmziSFHBOl4=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WUHYYP._1743578410 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Apr 2025 15:20:10 +0800
Date: Wed, 2 Apr 2025 15:20:10 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Wang Liang <wangliang74@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	horms@kernel.org, ubraun@linux.vnet.ibm.com, yanjun.zhu@linux.dev,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
Message-ID: <20250402072010.GA110656@j66a10360.sqa.eu95>
References: <20250331081003.1503211-1-wangliang74@huawei.com>
 <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
 <99f284be-bf1d-4bc4-a629-77b268522fff@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99f284be-bf1d-4bc4-a629-77b268522fff@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Apr 02, 2025 at 10:37:24AM +0800, Wang Liang wrote:
> 
> 在 2025/4/1 19:01, Paolo Abeni 写道:
> >On 3/31/25 10:10 AM, Wang Liang wrote:
> >>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >>index 3e6cb35baf25..454801188514 100644
> >>--- a/net/smc/af_smc.c
> >>+++ b/net/smc/af_smc.c
> >>@@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
> >>  	sk->sk_protocol = protocol;
> >>  	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
> >>  	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
> >>+	smc->clcsock = NULL;
> >>  	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
> >>  	INIT_WORK(&smc->connect_work, smc_connect_work);
> >>  	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
> >The syzkaller report has a few reproducers, have you tested this? AFAICS
> >the smc socket is already zeroed on allocation by sk_alloc().
> 
> 
> Yes, I test it by the C repro:
> https://syzkaller.appspot.com/text?tag=ReproC&x=13d2dc98580000
> 
> The C repro is provided by the 2025/02/27 15:16 crash from
>   https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
> 
> After apply my patch, the crash no longer happens when running the C repro.
> 
> "the smc socket is already zeroed on allocation by sk_alloc()", That
> is right.
> However, smc->clcsock may be modified indirectly in inet6_create().
> The process like this:
> 
>   __sys_socket
>     __sys_socket_create
>       sock_create
>         __sock_create
>           # pf->create
>           inet6_create
>             // init smc->clcsock = 0
>             sk = sk_alloc()
> 
>             // set smc->clcsock to invalid address
>             inet = inet_sk(sk);
>             inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
>             inet6_set_bit(MC6_LOOP, sk);
>             inet6_set_bit(MC6_ALL, sk);
> 
>             smc_inet_init_sock
>               smc_sk_init
>                 // add sk to smc_hash
>                 smc_hash_sk
>                   sk_add_node(sk, head);
>               smc_create_clcsk
>                 // set smc->clcsock
>                 sock_create_kern(..., &smc->clcsock);)
> 
> So initialize smc->clcsock to NULL explicitly in smc_sk_init() can fix
> this crash scene. If the problem can be reproduced after this patch, I
> guess it is not the same reason, and fix it by another patch is more
> appropriate.
> 

This is actually because the current smc_sock is not an inet_sock,
leading to two modules simultaneously modifying the same offset in
memory but interpreting its structure differently. I previously proposed
embedding an inet(6)_sock at the beginning of smc_sock, but the
community had some objections...

I'm not sure on the community's current stance on this matter, but if a
fix is absolutely necessary, my recommendation would still be to embed
an inet(6)_sock within the smc_sock structure

D.

> >



> >/P
> >
> >

