Return-Path: <linux-rdma+bounces-13658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276C3BA1159
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 20:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337211C25184
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 18:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED931AF31;
	Thu, 25 Sep 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eczDmY82"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B4319877
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826451; cv=none; b=eMA8mi9eWrLJtelTHHvfOCHzzAeBT0NxmBlj1cQLyzrrM5lNQV4aCvH+EHNxmMhjFZblfQwkpEfnOKbvPSfLExe/E/3dqU3nm9v0v97KvFaommHUWoZa66FF9rJcsBTBjpGHKDex9CFnewq5W6oTi8+wzTUMFSrZ4y2+zVPTaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826451; c=relaxed/simple;
	bh=Yp1u8iALz7sgABTMbwglWX907cvWMrc8RZudxNFkNQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpLxn/b13yoTuizISeChQGEsgOn3lmUIz6aKDuhcadI8LK2wL8UTXF1/Kgi6Kk0JHLpcGXu2UaXxn5kqTSO7HrwDEoLeI1U4e5qn5zRj8dq1WxgCC9rkpPxQwYCCHxCenaJvBj6DSTGWZY/zesSltIgqQdeDn1daGGWd2YrtMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eczDmY82; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-816ac9f9507so241556785a.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758826449; x=1759431249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C79BnGNdqfA1WFmZDdOgQ1u/4DfiWGTxrbsuXwmR4Dw=;
        b=eczDmY82r6aPM8ryIxz2/2b7Mt6Q3mBH3xaE5TUuOHYv9r6WCbVF6Iq0ESaPZrk+N0
         tencNw1VNrgBoQCGScdhw4i/+XczYBcetleUoY0AtBL8c0geNPxNaaBlgs7yz+LfLjCa
         6E/F4eQ57ygJfqJ4Rro/QS86ouqYJ5MrcEejEZozZf+2zksjBC7bSqfVboiG0UTevZfj
         KJ518fT1c5R0PaqakVl2oTmdq3MC9d+/Czl77fdUGKnHwFQ5BiQ2TtHUHoyJeUKHa7Zf
         GR99I9vWSH7kx2ihL1aaChylgUJHLEhoZ+9AzgkhlGsV/opbvD37IZZkiK1eKNaPSPsf
         spxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758826449; x=1759431249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C79BnGNdqfA1WFmZDdOgQ1u/4DfiWGTxrbsuXwmR4Dw=;
        b=Qh311+hc6yzhxBD09lfXecMYHLhstxWEsqxfuZ+IEDPXeARXYpsPUT+VTcghnSqgZG
         NCEqbN5cWlFFrex2pLxYoiLXx5/UvW3GerkJIgj3BVat2uAWQim5tetOCeSIiY8nyZe5
         4w35Y2nPCENw2BItnZDGD0OMprTJezeQngoN6jSLQi9Uq9S9h15yyHs+1P0pplOzY0bd
         WelP9YfiO3DTxQr+x9y7nskv4R2fzgngsOrnXkl00G/O/jNQx0Nn/7SVJjDQ9AKb8QI7
         E8cWKQFfW005N7bo+BSgr+6Y5zQ0zLDexXlr33ORddYk3BBBnhQGN4LNE3B6QcAnLmiN
         0Vyg==
X-Forwarded-Encrypted: i=1; AJvYcCWVzStGRjaGQuTkYy/3FCaFvFf6FFFe2tXCowntoaaVxPiIMg0lMO5g5mkwspvODCz5VK2c2dyg4qVh@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDYI2D5/p726A0rVmrco5dr3Xdcoo09jT3Hlg2mo5KpzJB5Cf
	0igVDawy4y22LH3T5MxwRnlxRyJHRY6rTPQRn9cl+iH9t8cLj1311z6nMv2zt03TCqpn3dz3qc1
	ijpt2O/towfu6w1ioYQ5qwsAxIto8xmzdofSDEhFL
X-Gm-Gg: ASbGncv00aa+ZzqAJiF9DxaEro+CjSX3Cie43ysCoCRLCPb2AZVNb0q3+gGeh8SVNbd
	nj8b53AC2B6jaHZqeFAZfkmWxXh+Oor5zptSjgeiuT6FnMfryLeA1JqVU0NPRe4tJNpTWsb9JaX
	/FPyZuk8V7NuuwSG+8kgOVzh/J/HfyWlGNoOmlERJV0/XVxRhf5jsBSZGw/Ph94TKaQyUd6nEYb
	KcfIXMqwuWZlnl9AkvDobV+
X-Google-Smtp-Source: AGHT+IH1X6h5C3xlWpGoKkj10vK3Dwz9ecUbJIlaxhcqy2DB4Z5TSfe9YirXsmbh2jkAFRB2d2osgAI0nwWKORuft7I=
X-Received: by 2002:a05:620a:711b:b0:852:b230:220e with SMTP id
 af79cd13be357-85bc193e658mr434859985a.2.1758826448329; Thu, 25 Sep 2025
 11:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121818.654011-1-wangliang74@huawei.com>
 <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com> <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com>
In-Reply-To: <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Sep 2025 11:53:56 -0700
X-Gm-Features: AS18NWBwxub5p7eNitiTZnu8uGg9aM-Gp-udVPszRrM6yAsoUpaHXcy8NJ6T7JI
Message-ID: <CANn89i+V847kRTTFW43ouZXXuaBs177fKv5_bqfbvRutpg+s6g@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Wang Liang <wangliang74@huawei.com>, alibuda@linux.alibaba.com, 
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:46=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> Thanks Eric for CCing me.
>
> On Thu, Sep 25, 2025 at 7:32=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Sep 22, 2025 at 4:57=E2=80=AFAM Wang Liang <wangliang74@huawei.=
com> wrote:
> > >
> > > The syzbot report a crash:
> > >
> > >   Oops: general protection fault, probably for non-canonical address =
0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> > >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead=
4ead0000001f]
> > >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PR=
EEMPT(full)
> > >   Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 08/18/2025
> > >   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
> > >   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag=
.c:89
> > >   Call Trace:
> > >    <TASK>
> > >    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
> > >    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
> > >    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
> > >    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
> > >    netlink_dump_start include/linux/netlink.h:341 [inline]
> > >    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
> > >    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
> > >    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
> > >    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
> > >    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> > >    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
> > >    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
> > >    sock_sendmsg_nosec net/socket.c:714 [inline]
> > >    __sock_sendmsg net/socket.c:729 [inline]
> > >    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
> > >    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
> > >    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
> > >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
> > >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >    </TASK>
> > >
> > > The process like this:
> > >
> > >                (CPU1)              |             (CPU2)
> > >   ---------------------------------|-------------------------------
> > >   inet_create()                    |
> > >     // init clcsock to NULL        |
> > >     sk =3D sk_alloc()                |
> > >                                    |
> > >     // unexpectedly change clcsock |
> > >     inet_init_csk_locks()          |
> > >                                    |
> > >     // add sk to hash table        |
> > >     smc_inet_init_sock()           |
> > >       smc_sk_init()                |
> > >         smc_hash_sk()              |
> > >                                    | // traverse the hash table
> > >                                    | smc_diag_dump_proto
> > >                                    |   __smc_diag_dump()
> > >                                    |     // visit wrong clcsock
> > >                                    |     smc_diag_msg_common_fill()
> > >     // alloc clcsock               |
> > >     smc_create_clcsk               |
> > >       sock_create_kern             |
> > >
> > > With CONFIG_DEBUG_LOCK_ALLOC=3Dy, the smc->clcsock is unexpectedly ch=
anged
> > > in inet_init_csk_locks(), because the struct smc_sock does not have s=
truct
> > > inet_connection_sock as the first member.
> > >
> > > Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_sock=
 type
> > > confusion.") add inet_sock as the first member of smc_sock. For proto=
col
> > > with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_sock=
 is
> > > more appropriate.
>
> Why is INET_PROTOSW_ICSK necessary in the first place ?
>
> I don't see a clear reason because smc_clcsock_accept() allocates
> a new sock by smc_sock_alloc() and does not use inet_accept().
>
> Or is there any other path where smc_sock is cast to
> inet_connection_sock ?

What I saw in this code was a missing protection.

smc_diag_msg_common_fill() runs without socket lock being held.

I was thinking of this fix, but apparently syzbot still got crashes.

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 10219f55aad14d795dabe4331458bd1b73c22789..b6abd0efea22c0c9726090b5de6=
0e648b86e09a0
100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -30,7 +30,8 @@ void smc_clcsock_release(struct smc_sock *smc)
        mutex_lock(&smc->clcsock_release_lock);
        if (smc->clcsock) {
                tcp =3D smc->clcsock;
-               smc->clcsock =3D NULL;
+               WRITE_ONCE(smc->clcsock, NULL);
+               synchronize_rcu();
                sock_release(tcp);
        }
        mutex_unlock(&smc->clcsock_release_lock);
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index bf0beaa23bdb63edfe0c37515aa17a04bb648c08..069607c1db9aff76d1d4f23b47d=
feb5177c433d8
100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -35,26 +35,32 @@ static struct smc_diag_dump_ctx
*smc_dump_context(struct netlink_callback *cb)
 static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *=
sk)
 {
        struct smc_sock *smc =3D smc_sk(sk);
+       struct socket *clcsock;

        memset(r, 0, sizeof(*r));
        r->diag_family =3D sk->sk_family;
        sock_diag_save_cookie(sk, r->id.idiag_cookie);
-       if (!smc->clcsock)
-               return;
-       r->id.idiag_sport =3D htons(smc->clcsock->sk->sk_num);
-       r->id.idiag_dport =3D smc->clcsock->sk->sk_dport;
-       r->id.idiag_if =3D smc->clcsock->sk->sk_bound_dev_if;
+
+       rcu_read_lock();
+       clcsock =3D READ_ONCE(smc->clcsock);
+       if (!clcsock)
+               goto unlock;
+       r->id.idiag_sport =3D htons(clcsock->sk->sk_num);
+       r->id.idiag_dport =3D clcsock->sk->sk_dport;
+       r->id.idiag_if =3D clcsock->sk->sk_bound_dev_if;
        if (sk->sk_protocol =3D=3D SMCPROTO_SMC) {
-               r->id.idiag_src[0] =3D smc->clcsock->sk->sk_rcv_saddr;
-               r->id.idiag_dst[0] =3D smc->clcsock->sk->sk_daddr;
+               r->id.idiag_src[0] =3D clcsock->sk->sk_rcv_saddr;
+               r->id.idiag_dst[0] =3D clcsock->sk->sk_daddr;
 #if IS_ENABLED(CONFIG_IPV6)
        } else if (sk->sk_protocol =3D=3D SMCPROTO_SMC6) {
-               memcpy(&r->id.idiag_src, &smc->clcsock->sk->sk_v6_rcv_saddr=
,
-                      sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
-               memcpy(&r->id.idiag_dst, &smc->clcsock->sk->sk_v6_daddr,
-                      sizeof(smc->clcsock->sk->sk_v6_daddr));
+               memcpy(&r->id.idiag_src, &clcsock->sk->sk_v6_rcv_saddr,
+                      sizeof(clcsock->sk->sk_v6_rcv_saddr));
+               memcpy(&r->id.idiag_dst, &clcsock->sk->sk_v6_daddr,
+                      sizeof(clcsock->sk->sk_v6_daddr));
 #endif
        }
+unlock:
+       rcu_read_unlock();
 }

