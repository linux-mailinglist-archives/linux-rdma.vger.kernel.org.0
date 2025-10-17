Return-Path: <linux-rdma+bounces-13915-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BEABE6802
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 07:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9871A650D1
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 05:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3269830DEBF;
	Fri, 17 Oct 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVYPJ5xJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A94400
	for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680487; cv=none; b=VtDAyRYp40uLNykO4CIJSac9avVX0oe0k4uFewL+KQecXh3qDSd4Cu4rm7NLoynN+6Pm1uRY7Ru0qZrgFNbel6cmr1fYq/IkwUgP2VZzrpqr65tugCWKUP4TjSrYN8/Z6W6Cxk3QSATzGqhZ/BIz9TweiNCPUzrLy2ruvE4GOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680487; c=relaxed/simple;
	bh=AzoQ4i/srN8FpTZFrJJz4zAfUAY4stVL58foSLnf8aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmfDNLp+/ztzHIT86urXTV42A6rrM0vjtgfMJDtT3SYrjNzux59agkWmkZpH4pnwLGfHzm/rwaXADU97ikqVlFe6wOgoCCVpX1Iy5jzJwp5HWI278j28hoZ21RaZmDvgk2gvwiBZaWhKcGbSAKM4RsTZXQ5GKQaYKekONtUo9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVYPJ5xJ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7836853a0d6so18428497b3.1
        for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 22:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760680484; x=1761285284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26UkdI1wBp0Xi61UmFjaGlIQEnXQ+0LgrUBcqpJYfDU=;
        b=YVYPJ5xJz5DjfRTUt3IakV/uIpcmUTe7xVV7l7vG5DOcHtbm9OySV/oHs/DWg4HOIM
         J3CH+kYYKmNG1EcZyUXb7r8vB8PzwWfRXIeoXmj5htH/5EOTTUDhwLRfV3NOAWjW1CVS
         N/1jFj64F7cZLt7FElmAj18gb5dDqhi3Jz7x0+a6Ja09KRIi8L9nUjN1UUwWbrGYBwKz
         YRigM97U3KHj4NJp9jlFV8YS/5QiqVXIPY26mabJyHemtxZK5DLJ+auAhHmKaxqxv7Ht
         4qR0U4HOgJ8ojOqfHEb/6itYvVfF1DAIWNtY0dQqHB+jOwV1gP86JcvRsUQHyqk0FZbE
         VrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760680484; x=1761285284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26UkdI1wBp0Xi61UmFjaGlIQEnXQ+0LgrUBcqpJYfDU=;
        b=JrLx6hNY6o2O98YMMxFgHtG9WlLEBC2PxiUXspTIKmY6f3LnQQz3yQNTT1Q4cbTs2Q
         dX4bO1KsAih+0/0sVpAAbHEgPLevckwKk/5gEFf6b18k2yzmiCfipmD4u22ppXuZoVua
         nTD2wmVAlICjHPoZsYBnQwD55zfWSxxrBJNgp0dqScihD9OntIQYSbxdLMZGSlmERt5L
         v2EO9qyL1cEI0obAqgmMQf/Boc8aOy9PSOTGKRY5XyItf5qHhVp3k7yh/itZg3WPG9I/
         B0IlRVGK9+Nx0cZvJhnae/q0kaqhZRlqQQplXGleNRFwTMVrFPZNFWGmOyaaKed6cBMs
         teoA==
X-Forwarded-Encrypted: i=1; AJvYcCWWgmQEKZIJ6W7b2J/62Bq3O9IoMHrT2PHlqK1LpdEEwdSLESdwN23n46d0/QXpYaWLQU1j9E0W7+r6@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6JD3TTdYQ/e/bD1myZjXD417jMEMq8RMsQS+Sq51AzNvzCB0
	OG9zZgG+5IxUQ85IIOHyX8JOIVCEJ1ys87bc+gTU9UDtIupXW6NWM6NrjAv8LZR75s49lPvsn4H
	r3xrCl7KwwVY+7kwEBrXx+Xoz4cqXD6oG2Lmds4xD
X-Gm-Gg: ASbGncuI4s8n6ACZQ3d076v0+17HiGJtityIUXOHnYulVruAnY30fXElOWLQtykWBjF
	DcfBe8a1XmeCeTFOa81u5w2H2ww6jx8pZDfrZcy6aXFry3J/8DHrmpk0/ymlBw2HUEwYtqpYfZ7
	hhrUqC/6MiVul8dueu4zajlf9EPNr6mfakf0XmyT3i/L142hyu6StnAl06B/9mP1Ca5+plkRsC9
	ZLfmopKQw7nLIlGxHz1nCSsR/UcziqGH33VaLpyyoYOasj6s+YYZgGlE5c=
X-Google-Smtp-Source: AGHT+IHsN8XKGFc1pmq1dLy5gZIAu/2/L7IYb6L12Ta0DohYp6BNuhOBNV89pr4e5xJtcC1TCmMzZcpB8Bt4srH6t4M=
X-Received: by 2002:a05:690e:168b:b0:63e:1113:bde2 with SMTP id
 956f58d0204a3-63e1113c469mr2815324d50.20.1760680483191; Thu, 16 Oct 2025
 22:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017024827.3137512-1-wangliang74@huawei.com> <20251017055106.3603987-1-kuniyu@google.com>
In-Reply-To: <20251017055106.3603987-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 22:54:31 -0700
X-Gm-Features: AS18NWCfR7jSXBSalgtHDaSKYVywq8UEZkUHYIuFi4bvybirdzcP5DjBZY6mcTU
Message-ID: <CANn89iKXU71cZYefVSQDa-1rc0oGs0vjFUkL=oPyG93c-ezP1A@mail.gmail.com>
Subject: Re: [PATCH net v2] net/smc: fix general protection fault in __smc_diag_dump
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: wangliang74@huawei.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	dust.li@linux.alibaba.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:51=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> From: Wang Liang <wangliang74@huawei.com>
> Date: Fri, 17 Oct 2025 10:48:27 +0800
> > The syzbot report a crash:
> >
> >   Oops: general protection fault, probably for non-canonical address 0x=
fbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> >   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4e=
ad0000001f]
> >   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREE=
MPT(full)
> >   Hardware name: Google Compute Engine/Google Compute Engine, BIOS Goog=
le 08/18/2025
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
> > in inet_init_csk_locks(). The INET_PROTOSW_ICSK flag is no need by smc,
> > just remove it.
> >
> > After removing the INET_PROTOSW_ICSK flag, this patch alse revert
> > commit 6fd27ea183c2 ("net/smc: fix lacks of icsk_syn_mss with IPPROTO_S=
MC")
> > to avoid casting smc_sock to inet_connection_sock.
> >
> > Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Df775be4458668f7d220e
> > Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
>
> nit: looks like this diff is not tested by syzbot, you may
> want to send diff to syzbot.
>
>
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Signed-off-by: Wang Liang <wangliang74@huawei.com>
>
> Change itself looks good.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Agreed

Reviewed-by: Eric Dumazet <edumazet@google.com>

