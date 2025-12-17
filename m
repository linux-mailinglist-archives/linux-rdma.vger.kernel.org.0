Return-Path: <linux-rdma+bounces-15052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 051ECCC880F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C19F30EE128
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426C434D385;
	Wed, 17 Dec 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wyGjkeW5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763634BA33;
	Wed, 17 Dec 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985153; cv=none; b=OuXw4pETCT6GYSMrfl76ta1MYxZ41Pn4+g8v1PEXGO1DjVb/TrE/CBOb1lKqZuyAd0o5pDdNLPrUMnvpi6U54mUWKhg6/A6oPfjbiE4j7vvHAMs6uCZjOqRd6a5+LRZxNvzkBqxcA/uTL8OoU0nfy0LZHd72R2iPzF+EiGyVBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985153; c=relaxed/simple;
	bh=JzAqeIxs9Y6eBR9vCupjOxU9CmPAR2zoqEEi7a1kSh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au6ahKQGkBZsjP6voMGpkQPrykaVl4u+niZalfFkaK0Q1C3WN95dtVk7aNVIX7vEjkOBBAgYR4yErT+58F04DU4rybdNpoGRRC0YfbNYM91fZNUsv/uDE8R0IbnS29Tb6qwwfUCG6ut2/z/N+kgkMUf8RPQ2Elt1ik2OuPENdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wyGjkeW5; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765985140; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=cSksazZjc+dILXEOFoB5Haajr6WS5BPannyIPcOlz1I=;
	b=wyGjkeW58YIAmWEsdkLAApd7R+aVzlCC9yeeur2y54vS/kztINU9Sa640530Bn3G6y2KT7wn+U0YW90ctUadnKS+ZRn5bizEY7NSHeKp0hrHUhwAUl4KBln8mBoo71gDHG1sBUQ23GUGErgk3oXhLJzaQ0Q1o0WDrx4ov+Ih49k=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wv4AG96_1765985139 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 23:25:39 +0800
Date: Wed, 17 Dec 2025 23:25:38 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net/smc: Initialize smc hashtables before
 registering users
Message-ID: <aULLcudhF10_sZO6@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20251217114819.2725882-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217114819.2725882-1-wintera@linux.ibm.com>

On 2025-12-17 12:48:19, Alexandra Winter wrote:
>During initialisation of the SMC module initialize smc_v4/6_hashinfo before
>calling smc_nl_init(), proto_register() or sock_register(), to avoid a race
>that can cause use of an uninitialised pointer in case an smc protocol is
>called before the module is done initialising.
>
>syzbot report:
>KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>Call Trace:
> <TASK>
> smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:236
> netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
> __netlink_dump_start+0x59f/0x780 net/netlink/af_netlink.c:2440
> netlink_dump_start include/linux/netlink.h:339 [inline]
> smc_diag_handler_dump+0x1ab/0x250 net/smc/smc_diag.c:251
> sock_diag_rcv_msg+0x3dc/0x5f0
> netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
> netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
> netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
> netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901


I don't think this is related to smc_nl_init().

Here the calltrace is smc_diag_dump(), which was registered in
sock_diag_register(&smc_diag_handler).

But smc_nl_init() is registering the general netlink in SMC,
which is unrelated to smc_diag_dump().

I think the root cause should be related to the initializing between
smc_diag.ko and smc_v4/6_hashinfo.ht.
The change in your previous patch 'dibs: Register smc as dibs_client'
may change the possiblity to this bug.

Best regards,
Dust

>
>Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
>Reported-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>---
> net/smc/af_smc.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index f97f77b041d9..b0f4405fb714 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -3524,6 +3524,9 @@ static int __init smc_init(void)
> 		goto out_pernet_subsys_stat;
> 	smc_clc_init();
> 
>+	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
>+	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
>+
> 	rc = smc_nl_init();
> 	if (rc)
> 		goto out_ism;
>@@ -3581,8 +3584,6 @@ static int __init smc_init(void)
> 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
> 		goto out_proto6;
> 	}
>-	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
>-	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
> 
> 	rc = smc_ib_register_client();
> 	if (rc) {
>-- 
>2.51.0

