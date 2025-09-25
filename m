Return-Path: <linux-rdma+bounces-13660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90CDBA137F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 21:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB8C3A9BC9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46531CA5D;
	Thu, 25 Sep 2025 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBE5GJGa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2E2E8B8A
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829074; cv=none; b=fxi9eOfJIebUPkIyThv4Y+Cv8Des04fYEzy/9+lf9I8d9X782LrYXS493Jm4geleppQmYZYzLnK000FCxsE+n805SdaAyKDDaTU6LMaCRDVrF0zkzwwyDntLbMK4V4ISkYbT6JIf9TYQXZDmHhVHN2S7ME0LIxz7beKkvB+wazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829074; c=relaxed/simple;
	bh=70ZBbyiWkxW1T3x7VR16vWSCd+9K6UpnTlnQYJI5UQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHkDsLQEk12/zNMWFS3LfSOXQNH2wuXJq6H117Mv6n1LzG/VLFuATHWJd5kzWgLPXTJO7D2T67BvLKg+E0aYKK/mpN9TL+0amx+QUagseJ12v+8ZVLDdm7lhKyaWYMUwtjLzRKRSkbHVkx7IzKepFXg3q0RQRKtmME/d5O9YaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBE5GJGa; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4db0b56f6e7so8928851cf.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758829072; x=1759433872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2Q1cBc7LUQcu2cuJvD0/M3cFaWYJRZZW0Vz5p9Kpw4=;
        b=WBE5GJGabaGdSmJTtatnyD1dkpodYYc5bB4En6SBvgvbuMThHiMI5cFbDPevjR1jRe
         EZl8D8ABDN1ooeL1I5kAG+dSuxUOj2w4MTzZjoyRHrx/blw14Rs4l058LAbqnekIfxxI
         1Z+7T5iHy07XGGDodbru/RekFPuvIp0fxZ3pJfcEIpRnTq+JBnBd84aFv7WMNs/wuE0r
         cJnPcrjoRlCOvCdGWtcmeXIC2m76Wzxm3X0KNHcPegyiS1QAoFDRIIarwEvR4WdrKAK1
         QHYZMjwcI4G8WXe5A5SkUPw8YMhhPrWP/1uVWSpMRT5ZQ+d11GqfUrlX/ww8OOzEcHKP
         7hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829072; x=1759433872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2Q1cBc7LUQcu2cuJvD0/M3cFaWYJRZZW0Vz5p9Kpw4=;
        b=jdptRrXP5trog8KIkqn4ZfC9FFJODYFpnPg+rvFGMl3teMJt68mgzjLM/EdFOq8+8o
         CJZW23504UOWZoefove5W/BYy8zKWRNGKreSj1PKRlYr2DI1JEH2hbYAzkUmjmR0y5f/
         h+bdcTwYO28zV2WNZ8AGRfku3KW6y5Z6xBX7ee3aovAf2Ft4oec0i29G1Pjcjq4AI41y
         3tu0n85WOlU1GThnQycqr+W+OTbxG1UdYuKj6cHJ7goHC9dqneM1aMe3hEdXFjNb9H0U
         xtEyIlJdVj+XLQOSFLAGkFZ9pKdsAC54/slBmNDDp1hb1a/ltr7hFO9DMD2Kwnr9z4sL
         KFwA==
X-Forwarded-Encrypted: i=1; AJvYcCVtl9SoRjEnVfmAD28OrE4hKs7zUPCp96p3UYXS040dFmGxoJRnuvvd89hLGOSLrm2iHqw2ew5iZhby@vger.kernel.org
X-Gm-Message-State: AOJu0YwmXiUe6VlEP302iDHbTdZgAjZfM7kjI2ycpmhgZXYbzHdEcHXX
	A0rGV5sqAPzMhQuNyvODC1CJz9DpcB53Fgwnsr8DOSf3P6g7RaEO5fFOYcl2CZSpARxpV83cNaT
	YQDDxxgkXswHSB+RQ+lQgBgqXmHF0dGOrHF2j3byr
X-Gm-Gg: ASbGncskKKuO+0jnK3i/nf70Nm17x6BKaMHIeGS0drBEnIwHUx6zbZGusX90xQnguHL
	pRKqHwCt7Vzf+KX51c3SFJIV/jDKdypIeHb+cDUWwnBA+GOxmep6ogS9MSUFegtnL/xdD2AzJ3i
	qPhJ3f6FXXsK3HxZnfx8+Z5bQcBLwH/cmGT6E6vIOsPxOYFeLP6GyQUOaMs+CMqPLVb41bXAxqf
	XLXoRG0WAHMsxemU51MtixM
X-Google-Smtp-Source: AGHT+IHCvRuGt6NFVvOMpJCv91jV7RoFz9Wa0ZhVESXQsSNw9YJ/r7CF3agmA+c897IDwvF/1apFe92TOHo1/cNcVes=
X-Received: by 2002:a05:622a:4b:b0:4b0:6a6c:c8cf with SMTP id
 d75a77b69052e-4daca1f78f0mr45166161cf.15.1758829071156; Thu, 25 Sep 2025
 12:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121818.654011-1-wangliang74@huawei.com>
 <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
 <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com>
 <CANn89i+V847kRTTFW43ouZXXuaBs177fKv5_bqfbvRutpg+s6g@mail.gmail.com> <CAAVpQUBriJFUhq2MpfwFTBLkF0rJfaVp1gaJ3wdhZuD7NWOaXw@mail.gmail.com>
In-Reply-To: <CAAVpQUBriJFUhq2MpfwFTBLkF0rJfaVp1gaJ3wdhZuD7NWOaXw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Sep 2025 12:37:39 -0700
X-Gm-Features: AS18NWBfb_5R9ookN-KFp8lqhGE_84Rt920qCX1G3bgXwF8E_8TZGmU8sJIuKgo
Message-ID: <CANn89i+Ntwzm2A=NSHbKdFuGVR6kar00AjrJE91Lu0e5BUsVow@mail.gmail.com>
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

On Thu, Sep 25, 2025 at 12:25=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Thu, Sep 25, 2025 at 11:54=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Thu, Sep 25, 2025 at 11:46=E2=80=AFAM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> > >
> > > Thanks Eric for CCing me.
> > >
> > > On Thu, Sep 25, 2025 at 7:32=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Mon, Sep 22, 2025 at 4:57=E2=80=AFAM Wang Liang <wangliang74@hua=
wei.com> wrote:
> > > > >
> > > > > The syzbot report a crash:
> > > > >
> > > > >   Oops: general protection fault, probably for non-canonical addr=
ess 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> > > > >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0x=
dead4ead0000001f]
> > > > >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #=
0 PREEMPT(full)
> > > > >   Hardware name: Google Google Compute Engine/Google Compute Engi=
ne, BIOS Google 08/18/2025
> > > > >   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inlin=
e]
> > > > >   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_=
diag.c:89
> > > > >   Call Trace:
> > > > >    <TASK>
> > > > >    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
> > > > >    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
> > > > >    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
> > > > >    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
> > > > >    netlink_dump_start include/linux/netlink.h:341 [inline]
> > > > >    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
> > > > >    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
> > > > >    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
> > > > >    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
> > > > >    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> > > > >    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
> > > > >    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
> > > > >    sock_sendmsg_nosec net/socket.c:714 [inline]
> > > > >    __sock_sendmsg net/socket.c:729 [inline]
> > > > >    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
> > > > >    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
> > > > >    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
> > > > >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > > >    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
> > > > >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > >    </TASK>
> > > > >
> > > > > The process like this:
> > > > >
> > > > >                (CPU1)              |             (CPU2)
> > > > >   ---------------------------------|-----------------------------=
--
> > > > >   inet_create()                    |
> > > > >     // init clcsock to NULL        |
> > > > >     sk =3D sk_alloc()                |
> > > > >                                    |
> > > > >     // unexpectedly change clcsock |
> > > > >     inet_init_csk_locks()          |
> > > > >                                    |
> > > > >     // add sk to hash table        |
> > > > >     smc_inet_init_sock()           |
> > > > >       smc_sk_init()                |
> > > > >         smc_hash_sk()              |
> > > > >                                    | // traverse the hash table
> > > > >                                    | smc_diag_dump_proto
> > > > >                                    |   __smc_diag_dump()
> > > > >                                    |     // visit wrong clcsock
> > > > >                                    |     smc_diag_msg_common_fill=
()
> > > > >     // alloc clcsock               |
> > > > >     smc_create_clcsk               |
> > > > >       sock_create_kern             |
> > > > >
> > > > > With CONFIG_DEBUG_LOCK_ALLOC=3Dy, the smc->clcsock is unexpectedl=
y changed
> > > > > in inet_init_csk_locks(), because the struct smc_sock does not ha=
ve struct
> > > > > inet_connection_sock as the first member.
> > > > >
> > > > > Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_=
sock type
> > > > > confusion.") add inet_sock as the first member of smc_sock. For p=
rotocol
> > > > > with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_=
sock is
> > > > > more appropriate.
> > >
> > > Why is INET_PROTOSW_ICSK necessary in the first place ?
> > >
> > > I don't see a clear reason because smc_clcsock_accept() allocates
> > > a new sock by smc_sock_alloc() and does not use inet_accept().
> > >
> > > Or is there any other path where smc_sock is cast to
> > > inet_connection_sock ?
> >
> > What I saw in this code was a missing protection.
> >
> > smc_diag_msg_common_fill() runs without socket lock being held.
> >
> > I was thinking of this fix, but apparently syzbot still got crashes.
>
> Looking at the test result,
>
> https://syzkaller.appspot.com/x/report.txt?x=3D15944c7c580000
> KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead00=
00001f]
>
> the top half of the address is SPINLOCK_MAGIC (0xdead4ead),
> so the type confusion mentioned in the commit message makes
> sense to me.
>
> $ pahole -C inet_connection_sock vmlinux
> struct inet_connection_sock {
> ...
>     struct request_sock_queue  icsk_accept_queue;    /*   992    80 */
>
> $ pahole -C smc_sock vmlinux
> struct smc_sock {
> ...
>     struct socket *            clcsock;              /*   992     8 */
>
> The option is 1) let inet_init_csk_locks() init inet_connection_sock
> or 2) avoid inet_init_csk_locks(), and I guess 2) could be better to
> avoid potential issues in IS_ICSK branches.
>

I definitely vote to remove INET_PROTOSW_ICSK from smc.

We want to reserve inet_connection_sock to TCP only, so that we can
move fields to better
cache friendly locations in tcp_sock hopefully for linux-6.19

