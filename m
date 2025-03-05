Return-Path: <linux-rdma+bounces-8358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C49A4FE38
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 13:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0C53AC51B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CDF242903;
	Wed,  5 Mar 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PLerP03o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76A221F25;
	Wed,  5 Mar 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176383; cv=none; b=JSw/7g1uBOUbbAsOXCeA+ii9PUnpa/89mhLL4oBWJiMdw6fpuSFmYOvCXEoY/uh2MFuXhtCNjlheIZRsj0S6tcLMp+WId0xT4OK0yzBWwR1SGSgbuxKvnH/79lTl+FchU3C24PVw8DQiqYWcy6xxduMENwtJ+4btGmoy8E+1pbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176383; c=relaxed/simple;
	bh=kq3NQERkvZbq7ob8h+qD3Nv/BfUilziEi+favHqPlD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIIVIk3SVhRKQLiAzmqg+Lz4rrRF51F+kUz/VqF1WCil2hLaOtB3vmrok5TUqtLnQY0d2z5h5wKnKDBL5YiV52HXzJmf0kWf+k5wAf9qgixGGVgN3gouNSFPrgnIl2jbqfQRk8WdKlHBPDPt77Ua5PlNTs1/1Ykfex+7c2cgwGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PLerP03o; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741176376; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=TxAozyocArmyukQfRT8jyP8q7tVZxorcO31U7ngbLRg=;
	b=PLerP03obm7Rx0WzY285Y6ToYNtZ/YNjGLpiFRt4WFfhl5OtSGmf+fncsaAo3CnSDNNcGXdNiw4evQvUAp5HXB6KzN3jp0mGGPfKMMH3TQDFYXyvyPxEX3EFUDsSrx6Znnffu1eaVtHc0OtgByP61untPBg4dBrhTkI22jzyiF8=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WQlTfPQ_1741176375 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Mar 2025 20:06:15 +0800
Date: Wed, 5 Mar 2025 20:06:15 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: ffhgfv <744439878@qq.com>
Cc: wenjia <wenjia@linux.ibm.com>, jaka <jaka@linux.ibm.com>,
	alibuda <alibuda@linux.alibaba.com>,
	tonylu <tonylu@linux.alibaba.com>, guwen <guwen@linux.alibaba.com>,
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>,
	horms <horms@kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel bug found and suggestions for fixing it
Message-ID: <20250305120615.GA99596@j66a10360.sqa.eu95>
References: <tencent_CE572E29B79ABD1AB33F1980363ADE182606@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CE572E29B79ABD1AB33F1980363ADE182606@qq.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Mar 04, 2025 at 02:31:37AM -0500, ffhgfv wrote:
> Hello, I found a bug titled "KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock" with modified syzkaller in the lasted upstream related to bcachefs file system.
> If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gmail.com>, Zhizhuo Tang <strforexctzzchange@foxmail.com>
> 
> ------------[ cut here ]------------
> TITLE: KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
> BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
> BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock+0xa7/0x4c0 net/smc/af_smc.c:131
> Read of size 4 at addr 0000000000000a04 by task syz.7.21/12319
> 
> CPU: 1 UID: 0 PID: 12319 Comm: syz.7.21 Not tainted 6.14.0-rc5-dirty #2
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -128,6 +128,8 @@
>  	struct sock *child;
>  
>  	smc = smc_clcsock_user_data(sk);
> +	if (!smc)
> +		goto drop;  // Ensure that the smc pointer is valid before accessing its members

Hi ffhgfv,

Thanks for your report and solution.

The bigger issue here is that smc_clcsock_user_data currently requires
lock protection, which means we need to acquire the sk_callback_lock here.
But the sk in this context is const, which violates the expected interface.

In fact, we have been planning to replace sk_callback_lock with RCU, which should
provide a better solution to this issue. However, there is still a
significant backlog of tasks related to SMC, and we haven't had the
bandwidth to address this yet. 

Anyway, we sincerely appreciate your report, and we will fix
this issue in the future.

Best wishes,
D. Wythe

>  
>  	if (READ_ONCE(sk-&gt;sk_ack_backlog) + atomic_read(&amp;smc-&gt;queued_smc_hs) &gt;
>  	    sk-&gt;sk_max_ack_backlog)
> 
> =========================================================================
> I hope it helps.
> Best regards
> Jianzhou Zhao
> xingwei lee
> Zhizhuo Tang</strforexctzzchange@foxmail.com></xrivendell7@gmail.com></xnxc22xnxc22@qq.com>

