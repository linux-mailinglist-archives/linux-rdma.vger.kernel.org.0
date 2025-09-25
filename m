Return-Path: <linux-rdma+bounces-13657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1CDBA110E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 20:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157BA1C2202E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54232E1747;
	Thu, 25 Sep 2025 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWN9sZeP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0CF218ACC
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826002; cv=none; b=tBv7NKc40S2RjAVvSeAVCttrDs6Tw2vJTGR1nCB2m+2hYAJbEZYVXhspJmI/9v/rt9jureR/hS+M69Lx3velRLBwyu4dmQa0b8F44jfqNBNia6sAj7fFuhnzinafu0t02RSTMGWHEobGYDcZiJ4ZkC8qdmTAvIBUDTS70YHU+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826002; c=relaxed/simple;
	bh=lfgcz3m4LxsJc7fu9Gh6cquree6UlWdW+wi7FdecF+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8adXLvOIhQAPUdNSGX81/QfdyAdcnIz6Sh+3h7IsK9+NIgjMzmBpbhkfOrsP4nbiAxfqfg8UPeMKIiAXX27yWR+d/AVhOxt+7ApUUjEQ0sdMiYGFOWF9BE4ROCRraUgFSneNtbqjvvWOF0orcT8jczbrRscEm0elymmRj80o7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWN9sZeP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5506b28c98so919491a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758826000; x=1759430800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLdUuxsUyFeLw5VmYATasRsILS+Z5g1sPWduMjqAJtQ=;
        b=VWN9sZePBfN8PboPgWPiYarkSaQayMFmyL4dwSRNIbNagtH0EkrrbtlQHgrePovVAE
         njAMWChJ5eh2jR25v9pMJkaW+hB8zhRMWNRxf2/QW5aHTjayVyrcI2NL0eZ+Tmp5B0sq
         DBC9YZV5sfFeNFtN4pUj3C4CZO+3A8CxftmQFglqCMrENpNZOpDHgGK6Ay3JLXiY2rfW
         YpL9CnssC6D1ukSvVTNmyt/BnNyL/plYCUhuFP19vx8HpiSHSMOORIHCF8gF+QSb/4in
         5v3GPqIrd3/bdZG/b0/M8vTVk4Mkw3rNRPX59eZ6FLmqANaAjSR8iNSNVQxztCCWwQy2
         aMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758826000; x=1759430800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLdUuxsUyFeLw5VmYATasRsILS+Z5g1sPWduMjqAJtQ=;
        b=mytOh+R+8FtaKGstB+uL/7a3ED/y1sNwAfmoBF/0FKbQ0O+2Am+sxvePGUScnx10Vv
         LVVtH/tezPL6bd8tNbzGbLg13bXZjghQzmk9fMZUSyJCHBMNrNVhSHjjN1ODLmeHad3y
         TwsiFSVnJ+j7AxQoiHOiozLpKPZUMcBlJ12fOKH9G+KsA8ef3/BcEpW6Q32/oCcSoORG
         1WARSZAa4Ro6cFuuD9FetrwWhaD8KpYJInO+BA14ETrtZmm14IVggkGyCgVVzwqC6jrN
         RSMShKFjfg7fiTH97W7RPIRm5tOknaZpDoGbFZhCnVDezdCnTOhWMRXCpM69xH/xlZBu
         jfxg==
X-Forwarded-Encrypted: i=1; AJvYcCURwADjpo4uwNHNv2O7KG1woG/cy8PU3XC+rKjUFKRlz/xlacOFEyKw8f0IY90p9qJbyO77VFoglOXT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzck9K3mSgRVd0WXBVwAHbZKGCzEcEkFDmId2N3seDLQfq8MsZO
	6blyeVzdRuNqBuHt/YcNEp8LiV/dF8GEuNP4TMJfL/1UmV8JcmmvmQwnjg9Q1DsVZFwW7CTnQud
	I43LWDNnJC3DEo3hA9Fw9UPkCxAyGcORmUyrhkDyZ
X-Gm-Gg: ASbGnctPDQ0nIe7HeTPwyiKDMdCViLsbHNkFkTNlNfqp2b3FNkeFazGvTPjCvWt1uts
	qFBjDVizYC7k4JVMwjZ2+KGJVrORpbjllFrx46fLfU/OUmC+RE++Q+zRUJjaQq3rX4Iud9L2r3y
	0zkHk2pZgJ971d9aA6gE7KXt96yJvTkGwyt29hHHpcnvjXSb1vt43CiaCMDntlEOkDIKvv58z5O
	kAKZKTr5rbAVxsZ2ZOZHCoZfnjO0flWr2zaDi6jXjz6GF9dBbuc/UNTWw==
X-Google-Smtp-Source: AGHT+IFHjpr/efSIGkSFc5aOwJwEJU/g3ib8aCrwbTfnR8LYDmx3PXaFp3wa4hoCDt63NVnjWqyIsHdEpL7XBgbkxZg=
X-Received: by 2002:a17:902:d490:b0:277:71e6:b04d with SMTP id
 d9443c01a7336-27ed4a29e5dmr46669715ad.3.1758825999931; Thu, 25 Sep 2025
 11:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121818.654011-1-wangliang74@huawei.com> <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
In-Reply-To: <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 11:46:28 -0700
X-Gm-Features: AS18NWCbS5gc66qTtEBpXFcEyjAbYBGY7oQ_xwB_xqs7eGxR4FmmvHj2dUmJMhQ
Message-ID: <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix general protection fault in __smc_diag_dump
To: Wang Liang <wangliang74@huawei.com>
Cc: Eric Dumazet <edumazet@google.com>, alibuda@linux.alibaba.com, 
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric for CCing me.

On Thu, Sep 25, 2025 at 7:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 22, 2025 at 4:57=E2=80=AFAM Wang Liang <wangliang74@huawei.co=
m> wrote:
> >
> > The syzbot report a crash:
> >
> >   Oops: general protection fault, probably for non-canonical address 0x=
fbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4e=
ad0000001f]
> >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREE=
MPT(full)
> >   Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 08/18/2025
> >   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
> >   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c=
:89
> >   Call Trace:
> >    <TASK>
> >    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
> >    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
> >    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
> >    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
> >    netlink_dump_start include/linux/netlink.h:341 [inline]
> >    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
> >    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
> >    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
> >    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
> >    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> >    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
> >    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
> >    sock_sendmsg_nosec net/socket.c:714 [inline]
> >    __sock_sendmsg net/socket.c:729 [inline]
> >    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
> >    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
> >    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
> >    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >    </TASK>
> >
> > The process like this:
> >
> >                (CPU1)              |             (CPU2)
> >   ---------------------------------|-------------------------------
> >   inet_create()                    |
> >     // init clcsock to NULL        |
> >     sk =3D sk_alloc()                |
> >                                    |
> >     // unexpectedly change clcsock |
> >     inet_init_csk_locks()          |
> >                                    |
> >     // add sk to hash table        |
> >     smc_inet_init_sock()           |
> >       smc_sk_init()                |
> >         smc_hash_sk()              |
> >                                    | // traverse the hash table
> >                                    | smc_diag_dump_proto
> >                                    |   __smc_diag_dump()
> >                                    |     // visit wrong clcsock
> >                                    |     smc_diag_msg_common_fill()
> >     // alloc clcsock               |
> >     smc_create_clcsk               |
> >       sock_create_kern             |
> >
> > With CONFIG_DEBUG_LOCK_ALLOC=3Dy, the smc->clcsock is unexpectedly chan=
ged
> > in inet_init_csk_locks(), because the struct smc_sock does not have str=
uct
> > inet_connection_sock as the first member.
> >
> > Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_sock t=
ype
> > confusion.") add inet_sock as the first member of smc_sock. For protoco=
l
> > with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_sock i=
s
> > more appropriate.

Why is INET_PROTOSW_ICSK necessary in the first place ?

I don't see a clear reason because smc_clcsock_accept() allocates
a new sock by smc_sock_alloc() and does not use inet_accept().

Or is there any other path where smc_sock is cast to
inet_connection_sock ?


> >
> > Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Df775be4458668f7d220e
> > Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>
> > ---
> >  net/smc/smc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 2c9084963739..1b20f0c927d3 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -285,7 +285,7 @@ struct smc_connection {
> >  struct smc_sock {                              /* smc sock container *=
/
> >         union {
> >                 struct sock             sk;
> > -               struct inet_sock        icsk_inet;
> > +               struct inet_connection_sock     inet_conn;
> >         };
> >         struct socket           *clcsock;       /* internal tcp socket =
*/
> >         void                    (*clcsk_state_change)(struct sock *sk);
> > --
> > 2.34.1
> >
>
> Kuniyuki, can you please review, I think you had a related fix recently.
>
> Thanks.
>
> commit 60ada4fe644edaa6c2da97364184b0425e8aeaf5
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> Date:   Fri Jul 11 06:07:52 2025 +0000
>
>     smc: Fix various oops due to inet_sock type confusion.

