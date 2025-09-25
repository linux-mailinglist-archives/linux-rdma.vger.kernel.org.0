Return-Path: <linux-rdma+bounces-13659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B873BA12B3
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 21:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A9E1BC68E8
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 19:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2944031BCAF;
	Thu, 25 Sep 2025 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWmbrlOf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2058831AF38
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828359; cv=none; b=JCgkfHbLb4MH4O6EdmpiNG8XKpAO8orzcefImxk4W0+TVqIpkI3oFd7uchQfGecdd5SLzEaf+TyoPOtaPTaEGrCSWnINUtkt+XjUCMiJeay6sQ3UC2Ny9P8Cd0RRpubqWBrN1c961HG4gJANZ4kmyljv88Es6zoWuZ6cLmJq6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828359; c=relaxed/simple;
	bh=+LGzKQfkIxBfEL7uanfWaTQi2NIBi71cSv2KDGt8AIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eworCxm4MaSBbV8mOOL8WxYk8l5Du9iIYs0Q9Bi03z0NC3aWD++tw2EQhsbMMfyaGY4eB5gC4RVopOFp78ZqGSTltDA0cGue3SIGIPMS6PiWzW8tflCDlo7VIDaf2aEZCqYeQdgD4zg1Ck1yX3+DOYdxz8fyrbu2CSEUgrivXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UWmbrlOf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27eceb38eb1so15785245ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758828357; x=1759433157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uxxej+A54UMxIPTRKqDdkxTeyPEcpC6j3CvIRkzYnRY=;
        b=UWmbrlOf8AJ3oZ57H4WtpjsxQfI97awRzHw4rFJvujcOQijcyP7Kw0+BGhtyrlauPd
         NwXgtpoP/1iG9zc62tWa7APAHubwIH/FE67aMJCxfZN/Ge4c7+bOrMB9xE6kn6GORHoQ
         KoHvMvZ0WKG4FKQ+C0hgOQ4IAHjPxJLkpQByyyFZudQT6hMo+5LQlKTnGx8976PrEtLT
         JASIsep/mjqqzDHsxlVq0X6aP20D7Lj3Gi2RMc7HMycbdPjmkwr38vvFqlJzrrmFZrWc
         OW69y9QwvlRLb4eJZorgcBRQcBADJQshKpntxNtUwO/JgIhozu63+pQhPUpRPgINbpRp
         olvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828357; x=1759433157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uxxej+A54UMxIPTRKqDdkxTeyPEcpC6j3CvIRkzYnRY=;
        b=rywKtvXSijIS2OXchYs/Is+gqfZAu4nmSJV8dDJQJ9LpznYd90O+JzlA1la4WZqYVn
         qmHtgvgmZjSBLaUeCppBeaJTxMq31UAWDlSksUvyPYsChT/k5xS4bs3PYaLxo/7EJltE
         StwZEEE3HPtlD1Du6M8UeeN0fUief8DBCQu/NY5fem3SIMVtJRc0RaSqFzpZTF3d5+MJ
         zzNWFsmlbAmW/QhgQeozulIFFzbQirOKrx24hb1kwR3rEpw2Kc9IW0j9s4rbP9B+QTaC
         +rjJz8enIP0iBS/H7Tj4+n2UEqAO8+JktEZCgBeoM2+w9az3Vu96z+I0C1Z0TxoQjPnS
         IXQg==
X-Forwarded-Encrypted: i=1; AJvYcCWP2uw8hfmNyL+2dNPVtNmy/LS7CvR0GFU16tprAaa+VxAOo9OdAGsBUtfHPS698+m9K7Tb/Xns8KWL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+fbyWwn8uuQxzFUySvyav5LSre7FEZ3gQyKI297i3ZIBOEAa
	Gh2yKJkcj3IXRYwPtigYU8KkH3b8Vt32cj6mx9g1zHtnVSRDwCfzly16veGTWazRgrPNS9z/q9G
	s7UwHyWHvr5PaJnFoFO+hF3o79lv40vsMu4pGNg8Z
X-Gm-Gg: ASbGnct8XonPGysvLW9qoNotrvtAZJozG6yg2Wqku9KJMcKob+RJRgu8uwDxkXZr2pc
	VfYoXTLwofVpwLcRx+WKfuK1ygO5yxCiATewye3pYOcDP67y6Mtatm2oHrWaMSSzVCVrl3mcF31
	TmCWDecW5ObpKQo1EL3E49kQHqgGMv1fgIyOMOMsHX785cMDQqt6DxF/nilOBs9zxcqPRs2bH1S
	/VzkySDNkAjMU0f9jYqP/j5hGEcNRvKLcmqHJcbKPk2Y3E=
X-Google-Smtp-Source: AGHT+IFqxRshKGBvHaiDtYARmbc57qR195V71ZCUISbd+cEP9B0APoeNbfdgU15orpP/Wf293P73psfog6W4tFlVzHY=
X-Received: by 2002:a17:903:a8b:b0:27d:339c:4b0 with SMTP id
 d9443c01a7336-27ed4aa57f1mr1907665ad.35.1758828357289; Thu, 25 Sep 2025
 12:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121818.654011-1-wangliang74@huawei.com>
 <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
 <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com> <CANn89i+V847kRTTFW43ouZXXuaBs177fKv5_bqfbvRutpg+s6g@mail.gmail.com>
In-Reply-To: <CANn89i+V847kRTTFW43ouZXXuaBs177fKv5_bqfbvRutpg+s6g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 12:25:46 -0700
X-Gm-Features: AS18NWBzBs30Kpj0VoFjpDJLTRb2ZjM8uVopnfW0zH1RkFfGm4UpJjsXE_5WI18
Message-ID: <CAAVpQUBriJFUhq2MpfwFTBLkF0rJfaVp1gaJ3wdhZuD7NWOaXw@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
To: Eric Dumazet <edumazet@google.com>
Cc: Wang Liang <wangliang74@huawei.com>, alibuda@linux.alibaba.com, 
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:54=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Sep 25, 2025 at 11:46=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > Thanks Eric for CCing me.
> >
> > On Thu, Sep 25, 2025 at 7:32=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Sep 22, 2025 at 4:57=E2=80=AFAM Wang Liang <wangliang74@huawe=
i.com> wrote:
> > > >
> > > > The syzbot report a crash:
> > > >
> > > >   Oops: general protection fault, probably for non-canonical addres=
s 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> > > >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xde=
ad4ead0000001f]
> > > >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 =
PREEMPT(full)
> > > >   Hardware name: Google Google Compute Engine/Google Compute Engine=
, BIOS Google 08/18/2025
> > > >   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
> > > >   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_di=
ag.c:89
> > > >   Call Trace:
> > > >    <TASK>
> > > >    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
> > > >    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
> > > >    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
> > > >    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
> > > >    netlink_dump_start include/linux/netlink.h:341 [inline]
> > > >    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
> > > >    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
> > > >    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
> > > >    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
> > > >    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> > > >    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
> > > >    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
> > > >    sock_sendmsg_nosec net/socket.c:714 [inline]
> > > >    __sock_sendmsg net/socket.c:729 [inline]
> > > >    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
> > > >    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
> > > >    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
> > > >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
> > > >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >    </TASK>
> > > >
> > > > The process like this:
> > > >
> > > >                (CPU1)              |             (CPU2)
> > > >   ---------------------------------|-------------------------------
> > > >   inet_create()                    |
> > > >     // init clcsock to NULL        |
> > > >     sk =3D sk_alloc()                |
> > > >                                    |
> > > >     // unexpectedly change clcsock |
> > > >     inet_init_csk_locks()          |
> > > >                                    |
> > > >     // add sk to hash table        |
> > > >     smc_inet_init_sock()           |
> > > >       smc_sk_init()                |
> > > >         smc_hash_sk()              |
> > > >                                    | // traverse the hash table
> > > >                                    | smc_diag_dump_proto
> > > >                                    |   __smc_diag_dump()
> > > >                                    |     // visit wrong clcsock
> > > >                                    |     smc_diag_msg_common_fill()
> > > >     // alloc clcsock               |
> > > >     smc_create_clcsk               |
> > > >       sock_create_kern             |
> > > >
> > > > With CONFIG_DEBUG_LOCK_ALLOC=3Dy, the smc->clcsock is unexpectedly =
changed
> > > > in inet_init_csk_locks(), because the struct smc_sock does not have=
 struct
> > > > inet_connection_sock as the first member.
> > > >
> > > > Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_so=
ck type
> > > > confusion.") add inet_sock as the first member of smc_sock. For pro=
tocol
> > > > with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_so=
ck is
> > > > more appropriate.
> >
> > Why is INET_PROTOSW_ICSK necessary in the first place ?
> >
> > I don't see a clear reason because smc_clcsock_accept() allocates
> > a new sock by smc_sock_alloc() and does not use inet_accept().
> >
> > Or is there any other path where smc_sock is cast to
> > inet_connection_sock ?
>
> What I saw in this code was a missing protection.
>
> smc_diag_msg_common_fill() runs without socket lock being held.
>
> I was thinking of this fix, but apparently syzbot still got crashes.

Looking at the test result,

https://syzkaller.appspot.com/x/report.txt?x=3D15944c7c580000
KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000=
001f]

the top half of the address is SPINLOCK_MAGIC (0xdead4ead),
so the type confusion mentioned in the commit message makes
sense to me.

$ pahole -C inet_connection_sock vmlinux
struct inet_connection_sock {
...
    struct request_sock_queue  icsk_accept_queue;    /*   992    80 */

$ pahole -C smc_sock vmlinux
struct smc_sock {
...
    struct socket *            clcsock;              /*   992     8 */

The option is 1) let inet_init_csk_locks() init inet_connection_sock
or 2) avoid inet_init_csk_locks(), and I guess 2) could be better to
avoid potential issues in IS_ICSK branches.


>
> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
> index 10219f55aad14d795dabe4331458bd1b73c22789..b6abd0efea22c0c9726090b5d=
e60e648b86e09a0
> 100644
> --- a/net/smc/smc_close.c
> +++ b/net/smc/smc_close.c
> @@ -30,7 +30,8 @@ void smc_clcsock_release(struct smc_sock *smc)
>         mutex_lock(&smc->clcsock_release_lock);
>         if (smc->clcsock) {
>                 tcp =3D smc->clcsock;
> -               smc->clcsock =3D NULL;
> +               WRITE_ONCE(smc->clcsock, NULL);
> +               synchronize_rcu();
>                 sock_release(tcp);
>         }
>         mutex_unlock(&smc->clcsock_release_lock);
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index bf0beaa23bdb63edfe0c37515aa17a04bb648c08..069607c1db9aff76d1d4f23b4=
7dfeb5177c433d8
> 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -35,26 +35,32 @@ static struct smc_diag_dump_ctx
> *smc_dump_context(struct netlink_callback *cb)
>  static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock=
 *sk)
>  {
>         struct smc_sock *smc =3D smc_sk(sk);
> +       struct socket *clcsock;
>
>         memset(r, 0, sizeof(*r));
>         r->diag_family =3D sk->sk_family;
>         sock_diag_save_cookie(sk, r->id.idiag_cookie);
> -       if (!smc->clcsock)
> -               return;
> -       r->id.idiag_sport =3D htons(smc->clcsock->sk->sk_num);
> -       r->id.idiag_dport =3D smc->clcsock->sk->sk_dport;
> -       r->id.idiag_if =3D smc->clcsock->sk->sk_bound_dev_if;
> +
> +       rcu_read_lock();
> +       clcsock =3D READ_ONCE(smc->clcsock);
> +       if (!clcsock)
> +               goto unlock;
> +       r->id.idiag_sport =3D htons(clcsock->sk->sk_num);
> +       r->id.idiag_dport =3D clcsock->sk->sk_dport;
> +       r->id.idiag_if =3D clcsock->sk->sk_bound_dev_if;
>         if (sk->sk_protocol =3D=3D SMCPROTO_SMC) {
> -               r->id.idiag_src[0] =3D smc->clcsock->sk->sk_rcv_saddr;
> -               r->id.idiag_dst[0] =3D smc->clcsock->sk->sk_daddr;
> +               r->id.idiag_src[0] =3D clcsock->sk->sk_rcv_saddr;
> +               r->id.idiag_dst[0] =3D clcsock->sk->sk_daddr;
>  #if IS_ENABLED(CONFIG_IPV6)
>         } else if (sk->sk_protocol =3D=3D SMCPROTO_SMC6) {
> -               memcpy(&r->id.idiag_src, &smc->clcsock->sk->sk_v6_rcv_sad=
dr,
> -                      sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
> -               memcpy(&r->id.idiag_dst, &smc->clcsock->sk->sk_v6_daddr,
> -                      sizeof(smc->clcsock->sk->sk_v6_daddr));
> +               memcpy(&r->id.idiag_src, &clcsock->sk->sk_v6_rcv_saddr,
> +                      sizeof(clcsock->sk->sk_v6_rcv_saddr));
> +               memcpy(&r->id.idiag_dst, &clcsock->sk->sk_v6_daddr,
> +                      sizeof(clcsock->sk->sk_v6_daddr));
>  #endif
>         }
> +unlock:
> +       rcu_read_unlock();
>  }

