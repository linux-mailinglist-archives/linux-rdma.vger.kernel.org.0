Return-Path: <linux-rdma+bounces-19535-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJK2IMEF7GlbTwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19535-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 02:07:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0311464324
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 02:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA66F3011BFB
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 00:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3A1C01;
	Sat, 25 Apr 2026 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0qcx/Cs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E317993
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777075621; cv=pass; b=AxrpTfHPYchSNvsZCKmpW3cd9JFBPD6ZAV4srrEvsn5lRzeOCJPls8nNfyYhuURc1ZH4ytGTcZF2U1ZXtGu6SPWSWvcJk9n8bC1jGGPeJnOm5wVWRbP2C1z5IcaqYMOJUp+CJ/y4LXdNxTXV+Ew82fQqWZ1LL5Ec5inoRJnjEgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777075621; c=relaxed/simple;
	bh=gmdk9RpSibV09mnK8vad4Jev9Bj/0aIzQ/+OBqdkTVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSW8hZIWlaGIMwY5s/t5RXmANgv/46KKdvlQd6BUfpls//uwJ+ftcL8zRF1qrfF2vkoUMLevp1gcKj+0IvP5UdEKUrWAC5hIB54//9xlJVMspV6zSiOUX3ZKa8rXNmcsJWYqwbUT7A0xlyPRKSenq2Z+h8JQoy6UsRnyL+G/SY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0qcx/Cs; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12dcdcd54adso98952c88.1
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 17:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777075619; cv=none;
        d=google.com; s=arc-20240605;
        b=OWDrf9Pkt/Z1NRS+SlIqMLweBVnx+mldykDeX0pUr9IMvNq3obWPkjPEz2Ep7+2tw/
         /C11Zx9XH8z3XM+fQvEwMrhQl63g5Y2SBaVk8xqHYs8mFv83/je6PhbaV+d3PX1su0XC
         UQg48YKeE4ND3ExDEQka9m7yHw/qVXw8300E3ZqvnI+7cWfVwIMZT95QYq5PZB5smP1s
         v210CYSXzUTjPcH5UEYMUEDT/bU1xTjV+C8r9d9jtim/X2MxLn7n94ilA+hGLnhfXkgU
         UMS7M5cHOTh6WpuY0BSQrM5Uwm9xHn1PO/GY07ZwYqiStm61I+iKOGhJw5q7hBiA//td
         eCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=56ZmdRyb9HqO8v/x2MD60ePI1t8EyQI80TonLQFFWug=;
        fh=yMIpH0qHbXYRpb+5gqdVenInQSWrDxZ3bbx2KYVScDk=;
        b=TQLcR92h7ki28QrdV7BqpMsKq3XKui0WeCZYVtKvlEMkbH/UUU28WH5hxn1wXOq35U
         AV4iivQQF6yJTSxDAAkjDlHTHOj6K9l5Vo3/Il6HTJdw2be31LY/IVJRF7eslcm/Q42v
         OHdC4cEIPSnladhW8MAV8CWAhbjG4D6oj3c/cSILXUnH+Ydo+rWKOjgZgOvqmhEaaemC
         0vNVKoxSl5Qp7OgFVRKJ+sB1M31xiiXFsCqZZcrS8o7pCorlIunKCZnqRrkH9GM1aS8B
         019Y4RWw78v9QRUQHQqSj6sBOUdxhj8ToLtYogBNe40ICD03mc9/dgauZNQa6T7ifJ+Q
         bdeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777075619; x=1777680419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56ZmdRyb9HqO8v/x2MD60ePI1t8EyQI80TonLQFFWug=;
        b=X0qcx/Csf2eAoeghjc4KQa7cVqlR4LyGqtV5TUfgaSBWgvB+kxO/Ppf03/GG9qqsOB
         vv9DF2p3tjE89Bp/UuThHkS8JPLVVDB6Euz9quXOKkjhR9/BzzzM66gc/9rwJ4dDuo6h
         0TULngBXH7cj9DKTaV+lGcl2P+Jev9nZLIZ53/WItGtc/UqdU6JlhMo9wqZnRuQHq/aH
         QT+dc94bzHXE/Z8dYv4K9R68nLMLLxVJaxKJT1a8Emr/07vFyMOZqg528o+WE5TNAOmE
         2p8GL8s9RqGc7Kfl/e/XflYOAxS1qx53Ar9HvPZZ0wX/Ss+qQkw8zB00qmuEAMjpFbGV
         XsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777075619; x=1777680419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=56ZmdRyb9HqO8v/x2MD60ePI1t8EyQI80TonLQFFWug=;
        b=LIe/C8lIBjc9iwInxsVBatVHbniB9ie3f92t2c0NrEo/xxBI+n5E1ZAKkXUv4JioBd
         CWYpZXWE2xkr+XFU2UbxOnQ1y3Hx0g16Mk9MSXuFnKjSIT3Yf80VvMD2u/42/HHDXfMF
         TLASlbvzgzClZ/yViTTU8/MieW4xRLqs1ohiWZzYXHzNviduMaSxbyz85x27yjHWiwt8
         a+ct/QarZ6l//+n/sU8KWNc2oqrCTBlQk9kTA2PG+/DJB2yAwOQay9GOKlBqp7UxTHLE
         lJvnEnIqFDLywU7k8cAs92F7e6632838JUxhhNciXyMSx1sJ/YbzMBlSujiiXO/0bqgd
         QTVg==
X-Forwarded-Encrypted: i=1; AFNElJ+b9yBt9ec9nB1rWZRPOYh2wouYuG5XPPXahvhLHCX37ERnTBwYSE4hcbulx0S0I9S3KAYdHBOJx1zk@vger.kernel.org
X-Gm-Message-State: AOJu0YwTnrKn9Pp3PXzEx/tqd4qRbNsMWTuejtmgGvE+Cv0DZvH2hsVB
	2Limh5YIC0u/14SD1z0Cdw/cjvi0y1QfBJtZlKqoximfM98vPEyGOw5LznIcPuAML5GpxIfvD8T
	V+3ZV+2lt0b0J7KV/a1jODe6O6TcthI7lVqrRjkti
X-Gm-Gg: AeBDievfHUYv7+Njr2ag137OIKm6svLTF5h7AwIi5O1MwdBqL/AkGSCwvAc0kJylVsZ
	A6mO0XfkJ46LPpl9nLWzetVDQdVdcQxp0ikRSNKuUBb5ijAwEM9jmXE+aLRzcZI8gyNsJn14bRl
	P/Nqz9SkfEGrT7TSmoqMbe82eXafuQo2hE81a9Q6tcni74cjYqtg00D6mcXVps1inbfBku7B7Ko
	QXiA/oFVsPts0kqWN1fgmDGgOCdjEk2rAT3HKdJulCbMPqKX7FsHX3Nsspq7l9A+CmeSvX2sUPZ
	xfWBz2QnoKcItGlbrChd3fQyVcssrZU8vzegkBDp7R3JO/URq55s0UUdHwrZ8SvyfQKoNifTcFY
	AsqUDvvLwZ4RQa96wWuiya4JHI3yQp12yU9RM+tED5ttAxY80qnTTJeeJIsMeuafRl7hOlnWn7Q
	==
X-Received: by 2002:a05:7022:6289:b0:12a:9b80:8a1b with SMTP id
 a92af1059eb24-12c73fb27fcmr18782265c88.34.1777075617474; Fri, 24 Apr 2026
 17:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424013759.728288-1-kuniyu@google.com> <14cf9ac5-1f11-428e-abf7-cf5075d6c9f9@linux.dev>
In-Reply-To: <14cf9ac5-1f11-428e-abf7-cf5075d6c9f9@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 24 Apr 2026 17:06:46 -0700
X-Gm-Features: AQROBzBa-8MqL1QsHIlrDkwmyoN-LtP0lPzFdg13mS-BaIpH4_2edLDdJUKV50g
Message-ID: <CAAVpQUB_t5zd_MYcxR4k_pfN69QpwbzJNMYUuNxGBgoOt6x96Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix null-ptr-deref in kernel_sock_shutdown().
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-rdma@vger.kernel.org, 
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E0311464324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19535-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Thu, Apr 23, 2026 at 8:10=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
>
> =E5=9C=A8 2026/4/23 18:37, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > syzbot reported null-ptr-deref in kernel_sock_shutdown(). [0]
> >
> > The problem is rxe_net_del() can be called for the same
> > device concurrently.
> >
> > Multiple threads might call udp_tunnel_sock_release()
> > for the same socket.
> >
> > Let's add a per-netns mutex to synchronise rxe_net_del().
> >
> > [0]:
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc000000000d: 0000 [#1] SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
> > CPU: 3 UID: 0 PID: 12652 Comm: syz.7.1709 Tainted: G             L     =
 syzkaller #0 PREEMPT(full)
> > Tainted: [L]=3DSOFTLOCKUP
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2 04/01/2014
> > RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3785
> > Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00=
 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 =
75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c e9 46
> > RSP: 0018:ffffc9000566f180 EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: ffff888058587240 RCX: 0000000000000000
> > RDX: 000000000000000d RSI: ffffffff895ced12 RDI: 0000000000000068
> > RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1006d98945
> > R10: ffff888036cc4a2b R11: 0000003683c25c00 R12: 0000000000000000
> > R13: ffff88805c998000 R14: 0000000000000002 R15: 0000000000000018
> > FS:  00007f1306d976c0(0000) GS:ffff8880d65db000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f1306d97d58 CR3: 00000000404f1000 CR4: 0000000000352ef0
> > DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000002
> > DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:202
> >   rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inlin=
e]
> >   rxe_sock_put+0xae/0x130 drivers/infiniband/sw/rxe/rxe_net.c:639
> >   rxe_net_del+0x83/0x120 drivers/infiniband/sw/rxe/rxe_net.c:660
> >   rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
> >   nldev_dellink+0x289/0x3c0 drivers/infiniband/core/nldev.c:1849
> >   rdma_nl_rcv_msg+0x392/0x6f0 drivers/infiniband/core/netlink.c:195
> >   rdma_nl_rcv_skb.constprop.0.isra.0+0x2cb/0x410 drivers/infiniband/cor=
e/netlink.c:239
> >   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
> >   netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
> >   netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
> >   sock_sendmsg_nosec net/socket.c:787 [inline]
> >   __sock_sendmsg net/socket.c:802 [inline]
> >   ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
> >   ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
> >   __sys_sendmsg+0x170/0x220 net/socket.c:2784
> >   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >   do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f1305f9c819
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f1306d97028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007f1306216090 RCX: 00007f1305f9c819
> > RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000003
> > RBP: 00007f1306032c91 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f1306216128 R14: 00007f1306216090 R15: 00007ffd8ecad288
> >   </TASK>
> > Modules linked in:
> >
> > Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruct=
ion per net namespace")
> > Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/69ea344f.a00a0220.17a17.0040.GAE@go=
ogle.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_net.c |  2 ++
> >   drivers/infiniband/sw/rxe/rxe_ns.c  | 18 ++++++++++++++++++
> >   drivers/infiniband/sw/rxe/rxe_ns.h  |  2 ++
> >   3 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/s=
w/rxe/rxe_net.c
> > index 50a2cb5405e2..1b3615c9262a 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -655,6 +655,7 @@ void rxe_net_del(struct ib_device *dev)
> >
> >       net =3D dev_net(ndev);
> >
> > +     rxe_ns_pernet_sk_lock(net);
> >       sk =3D rxe_ns_pernet_sk4(net);
> >       if (sk)
> >               rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
> > @@ -662,6 +663,7 @@ void rxe_net_del(struct ib_device *dev)
> >       sk =3D rxe_ns_pernet_sk6(net);
> >       if (sk)
> >               rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
> > +     rxe_ns_pernet_sk_unlock(net);
>
> If one thread is calling rxe_net_del (destroying the socket) while
> another thread simultaneously
>
> calls rxe_newlink to create the socket, I am not sure if a race
> condition will occur or not.
>
> If yes, I think all locations that modify these pointers should hold the
> mutex.

I haven't looked into newlink path as dellink had
__sock_put(), but yeah, it looks very racy.



> >
> >       dev_put(ndev);
> >   }
> > diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw=
/rxe/rxe_ns.c
> > index 8b9d734229b2..375c7d79d9d3 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_ns.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> > @@ -16,6 +16,7 @@
> >   struct rxe_ns_sock {
> >       struct sock __rcu *rxe_sk4;
> >       struct sock __rcu *rxe_sk6;
> > +     struct mutex rxe_sk_lock;
> >   };
> >
> >   /*
> > @@ -28,9 +29,12 @@ static unsigned int rxe_pernet_id;
> >    */
> >   static int rxe_ns_init(struct net *net)
> >   {
> > +     struct rxe_ns_sock *ns_sk =3D net_generic(net, rxe_pernet_id);
> > +
> >       /* defer socket create in the namespace to the first
> >        * device create.
> >        */
> > +     mutex_init(&ns_sk->rxe_sk_lock);
>
> The lock is initialized in rxe_ns_init, but this lock is not handled in
> rxe_ns_exit
>
> (or the corresponding cleanup function).
>
> Although a mutex typically does not require special operations upon
> destruction,
>
> the presence of pending lock contention could potentially cause the
> namespace destruction process to hang.
>
> So in rxe_ns_exit or other cleanup functions, add
> "mutex_destroy(&ns_sk->rxe_sk_lock);"
>
> This seems more professional.
>
> >
> >       return 0;
> >   }
> > @@ -71,6 +75,20 @@ static struct pernet_operations rxe_net_ops =3D {
> >       .size =3D sizeof(struct rxe_ns_sock),
> >   };
> >
> > +void rxe_ns_pernet_sk_lock(struct net *net)
> > +{
> > +     struct rxe_ns_sock *ns_sk =3D net_generic(net, rxe_pernet_id);
> > +
> > +     mutex_lock(&ns_sk->rxe_sk_lock);
> > +}
> > +
> > +void rxe_ns_pernet_sk_unlock(struct net *net)
> > +{
> > +     struct rxe_ns_sock *ns_sk =3D net_generic(net, rxe_pernet_id);
> > +
> > +     mutex_unlock(&ns_sk->rxe_sk_lock);
> > +}
> > +
>
> Introducing a mutex lock will serialize all RXE device deletion operation=
s
>
> within the same network namespace (netns). Although deletion is not a
>
> fast path operation, it may increase control-plane latency in environment=
s
>
> with a large number of virtual adapters. It is necessary to verify
> whether a more
>
> lightweight solution (such as an xchg atomic exchange operation) exists t=
o
>
> handle the extraction and nullification of the socket pointers.
>
> Although rxe is a simulation driver, it does not focus on the
> performance. But a lighter lock
>
> might as well benefit the whole system

I will move socket creation/destruction to __net_init and
 __net_exit instead of adding mutex.  Then, sock_hold()
and __sock_put() will be unnecessary too.

I don't find a good reason to defer socket creation to
the first device creation, which needs synchronisation
within the same netns anyway.

