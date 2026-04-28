Return-Path: <linux-rdma+bounces-19641-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGU2LzZW8GkNSAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19641-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:39:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B250347E243
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A758300B9F9
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 06:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EEE34D915;
	Tue, 28 Apr 2026 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0ZqbkE5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEC30E829
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358383; cv=pass; b=G18UofmbSznyliU0m0SMPp888DLj7lvQxagiUGnIrStoBA2/feGSiAh09TY56hsYSxZBPozOjRt0IFpHEcnP2Eb2qzTwAvIPoUXpSKcsevBAw81gOjoj8EXZynsMFAaxQF6yp8qbZ6U9V4JjnnbCILGXweYSmPDSHVlbk3Gtjpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358383; c=relaxed/simple;
	bh=xCnEOznKgaLjCOAQ7K8qvnLXovVVYWei6F3tVMVannw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aH0sSbGKRhxaBVrbmSHd/MvKTsZSPmQL5QXEiXwjO9MqygYdjFZzQK+F8yEqv3sr/RD4FgB4WL72J9PB8Lsii8QEvuGpeZ8mwB8EW6XEMTXUagYG1GtH1PicKLbnS5LxF2MKh6pqvwg3TCkGqQBWZDNrkF3PVZGwLGbQnbCJTes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0ZqbkE5; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8ccc7755so11467918c88.0
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 23:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777358381; cv=none;
        d=google.com; s=arc-20240605;
        b=bFxFXiLyz7J+3WlRZ7WcWex0/Q7sAAoNd6+8ijlZh4g/3BIAttw6SPg4ig22JqQuN+
         Wh7JLLFrsMLCe7WdQMqZcdcaj460ZjcuWtmIZNh3S4TQ9iUeZ0EdHU63UfgcdtdTFXaz
         kI2dWPIpt24q/DYe0AVmaIGnYk92TDDF8AWyd0ghbDQeySLAcPTymlqJlWjOlduEI8PT
         3Ch/WpCOO2pKtt2zYgfSydDpogNMaewvaD8E8y2168HY/0lp1+KFe+8qM1UN7dcCrKCH
         SgTLWevGUNFMAzW8pjVOT+XpII0wrkCtwejcVQ28Nk9w8bMd+ZZ1x+tOMtVRlVMgnlj7
         dbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YlUutjTxW8du7hQ0Z0XR2YeBg+5G1NUgRo/AkqVnFgE=;
        fh=TpP6eAxMMViXN76/7EBArK/l02QVd4quOqMWTwiWTCc=;
        b=izbbuEvC8ubfUQVjSkjidlp0LPyDFOQ7w5s7lrCk7MOVfI2SSoBz/E+GhB7h3FzSl7
         gY+CToNL5Aj+Qb4sEauu3xnc2J3uPM4581OpyhS9axTulktv+Id6zea9oWbJ4ov4njTx
         MyjdyMDDxDJvFvwmkAquWdVLfqL3d76ntpG1n56lS0zohVwdjDCUb3f9jAkfh4ztxpuy
         34eVgP1Omq63hTXicIzq9O1SiJKK18wdAjvk1zYr4MaYe2p73uOsP+ULecSF/yNEruxk
         jI3eXGBl/RGcyrIjucbGewDo/EBsRbMn6S+AhOSwiF4l89FhHDwnKO6xTVhb1TyzGx7/
         2TaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777358381; x=1777963181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlUutjTxW8du7hQ0Z0XR2YeBg+5G1NUgRo/AkqVnFgE=;
        b=r0ZqbkE55SOJBCeTfgAPKhSQsYSi6hvH6Pes/1uI7gW9aTNGEZIS52jg6Ncw23KkUO
         x8FgfCnNxS7WYpETRmGgOWTZAM2xOkPkT5iTc/iJEProPRd7feMm09e+HqoowuGvwzAa
         v/bFc/v6q0ShsQxV+0qfxCCyn+9odO3J/8W/g2JlOwuG55BYxy7lwlxNXkCu79vX9jSH
         cTiLmKDzadCjbOWME/gk/5lWRLZrjFIQ3yTJjwQM1Z7hMvU0w3+LH4bKvDYy/Vqw21QD
         6tjHpGT+5nxoTu/kvWVfhaWpmzehd6P0TWDCol4PgPIuyuGGC8xdBlhsNOWCUbOC+9WQ
         oFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777358381; x=1777963181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YlUutjTxW8du7hQ0Z0XR2YeBg+5G1NUgRo/AkqVnFgE=;
        b=PAK91BbdW8LHtsO6nGaiwx9WIKkEvne8tNyeOkLxAH2wHbh/0TbP5sC7EytRo5dYe+
         DvPhS99ZKVdMWcSsfC8o7Db3OrSUHzrxcSWoEU+xvfTzoXKbqH0PGeL7cJG3CokAjrP3
         /vLSmhyAtKMlvq2DNktZpRA9q6e+sbnQV5APf6QaTrApS0Co+ARBo1MppD9CM8t2jYWC
         dx5TMrZPcueEQRWeoYBWrLHiycV82POhwcUyQMWB0CCJGkBUVrLpkwwylyykPvoUJZnY
         f9BEtSEbGRM6Qe/5CysYXCDkAGP3LHsk0gg03UUCKrNQVSlsbafGEKTShXmnxzv7A26b
         7XuA==
X-Forwarded-Encrypted: i=1; AFNElJ8ND9/p2nhcSPgZi+5+X+Fgr/WE4cC6LJjn8L4uohI35Namx/QDHOQ+21Z3Sk2y6ixQhzJe+xqKqHde@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qdTDh8UlVdDHCoFeTbi34G9gns0rpL3/rg7q38DeoM2apZXs
	NnP4Al+3Xhue6X5CsMf/o9qAm68nuRCJ6FfWp/lqU4EX/L35Mb2qZ/fDham9AQXvsVmz3zcg5TA
	7qpV6gE0VPszDfO4YMhxXhgzvVTyg8l/L2oClOInA
X-Gm-Gg: AeBDiesNdenfi1E3jtD9BprP20Hpfqvxdcr6PpuJmvtENi/IEWY6uRmO3CDkTIhpu3Y
	aZGgT4THAQeFUR2W5QwtI34Za9SMW0/uUjsWNSzvf5OdbAv81UGm6PD87qq/eHYMYxh/ZjjqQZC
	WdHqHq3xB8NRXnQ6AE14bSq15Le4yKwWpJlUU2j7VhTrGIhaZnrniKeY6PkXsby5GzRnMa9ECSO
	0CsWFiq44fUsT1e3LpCiC3pcg4u3pI7+0bVc/86p1KDLf5e/NwJHwjAszNCxciH7x9CMsefAxdw
	F6oNs2Y0QhZ9jJiuk4ZGrNwxN7VZUdxVVMt4YJC2fW24HL81peMXu2YePXIwH/vdHV0O1O08vPe
	fKG+Q93FZJ64qr5Vkj7ib/2WLKtJpdBYzjopIcnBSjI546rtPVMrzil0f0wQaQ2adPHXy+/+FJQ
	==
X-Received: by 2002:a05:7022:618f:b0:12c:44a5:fb4f with SMTP id
 a92af1059eb24-12ddd950130mr881645c88.10.1777358380419; Mon, 27 Apr 2026
 23:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425060436.2316620-1-kuniyu@google.com> <20260425060436.2316620-2-kuniyu@google.com>
 <030d3487-b5b9-4067-8b8c-89b4e8756e1a@linux.dev> <86499305-4522-4a82-a689-0247f2d5f6c0@kernel.org>
 <4196fe33-88c2-416d-ac20-b68bf7f328a6@linux.dev> <CAAVpQUAh2KT=YpfDO5nkqrzH0kbAXEBVe6jtOtLc93wjs3N7Fg@mail.gmail.com>
 <e2e1406f-8d9d-4a96-949d-e75096446d1a@linux.dev> <9681c9e2-79a9-4d72-b1ad-229ba6d7aab7@kernel.org>
 <0cf42593-0149-4019-a51b-36f74ff67f51@linux.dev> <CAAVpQUDVb4VDibeXz-DmAHF7gOAvDenSTGA6DpEwwS5HaQjM5w@mail.gmail.com>
 <0c1258e2-7060-4084-9a07-dd7af8262dec@kernel.org> <0ef2f2e0-e437-4ec9-8ebe-21c702041acb@linux.dev>
 <bbaf583c-2170-41d8-9226-2d4e742f71d1@linux.dev> <CAAVpQUDVFb5=DNahoRkhv1iM1TYU4_keJEETeLswUx_QFT6G4w@mail.gmail.com>
 <73aea9b3-6afc-4e93-8bd6-b23d43591879@linux.dev>
In-Reply-To: <73aea9b3-6afc-4e93-8bd6-b23d43591879@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Apr 2026 23:39:28 -0700
X-Gm-Features: AVHnY4LYOWfoTr3jGJYQM3Cx2TZvacPrPFnnqhQnzpgdHSwieV4MIIQY6pNxaDs
Message-ID: <CAAVpQUBS0aeCEUK2Nvkq_9NqePiTaLoVQ5T4V8gPiJpbvDYj8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in kernel_sock_shutdown().
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	linux-rdma@vger.kernel.org, 
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B250347E243
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ziepe.ca,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19641-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 11:30=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
>
> =E5=9C=A8 2026/4/27 22:22, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > On Mon, Apr 27, 2026 at 10:12=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.d=
ev> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2026/4/27 19:15, Zhu Yanjun =E5=86=99=E9=81=93:
> >>>
> >>> =E5=9C=A8 2026/4/27 17:58, David Ahern =E5=86=99=E9=81=93:
> >>>> On 4/27/26 6:52 PM, Kuniyuki Iwashima wrote:
> >>>>> To be clear, you meant implementing David' idea, right ?
> >>>>> I'm asking because dellink won't need locking then.
> >>>> dellink is not needed with my suggestion. It was added to manage
> >>>> basically a refcount on the socket to close on last rxe delete in th=
e
> >>>
> >>> This is my original implementation.
> >>>
> >>> @Kuniyuki Iwashima, can you reproduce this problem in your local host=
 or
> >>> other test environments?
> >
> > The syzbot does not have a repro, but I think it can be
> > reproduced by calling newlink and dellink with multiple
> > threads.
> >
> > newlink would trigger kmemleak splat while dellink trigger
> > KASAN splat.
> >
> >
> >>>
> >>> If yes, can you make tests after applying the commit in the link:
> >>> https://patchwork.kernel.org/project/linux-rdma/
> >>> patch/20260424043522.22901-1-yanjun.zhu@linux.dev/
> >>>
> >>> Thanks a lot.
> >>
> >> Hi, David && Kuniyuki
> >>
> >> I read the call trace again.
> >>
> >> If net namespace has already released socket in A thread, then rdma li=
nk
> >> del command is called in B thread to release socket.
> >>
> >> So A thread has released socket firstly, then B thread also release so=
cket.
> >>
> >> The similar call trace would appear.
> >>
> >> The followiing is the explanation to the commit
> >> https://patchwork.kernel.org/project/linux-rdma/patch/20260424043522.2=
2901-1-yanjun.zhu@linux.dev/
> >>
> >> The double-free occurs as follows:
> >>
> >> CPU 0 (Net NameSpace cleanup)        CPU 1 (RDMA device removal)
> >> ---------------------                ---------------------------
> >> rxe_ns_exit()                        rxe_link_delete() (rdma link del =
)
> >
> > If rxe_link_delete() is in progress, it means the user thread is
> > alive, holding the netns refcount, and rxe_ns_exit() cannot be
> > called.
> >
> > So, dellink() never races with rxe_ns_exit(), and it races only
> > with the concurrent dellink().
> >
> > And when that occurs, the number of threads is not limited to
> > two, theoretically triple-free, quad-free, ... are possible.
>
> Thread 1: rdma link del          Thread 2: rdma link del
>       (User A calls dellink)           (User B calls dellink)
>                |                                 |
>        (1) Get Socket Pointer            (2) Get Socket Pointer
>            sk =3D ns_sk->rxe_sk4               sk =3D ns_sk->rxe_sk4
>                |                                 |
>        (3) Release Socket                (4) Release Socket
>            udp_tunnel_sock_release(sk)       udp_tunnel_sock_release(sk)
>                |                                 |
>          [ FIRST FREE ]                          |
>                |                          [ DOUBLE FREE! ]
>                v                                 v
>          (Memory freed)                  (Kernel Panic / Crash)
>
> I think the above should explain your idea. If so, your solution makes
> senses to add a per-netns mutex to synchronise.
>
> Let us use the first solution
> https://lore.kernel.org/all/20260424013759.728288-1-kuniyu@google.com/
>
> BTW, 1) add mutex_destroy 2) take into account of rdma link add.
>
> I am not sure if it is OK or not. @David Ahern

No, newlink is still racy and the same kind of race leaks
the udp tunnel.

If we defer allocation, there are two options:

1. David's idea, allocate on first use, and no free
  until netns destruction (newlink can add a fast path
  like check the pointer and only take mutex when it's
  NULL, and check again under mutex and allcoate a
 tunnel if not yet allocated)

2. Manage refcount properly.  (If we allocate a dedicated
  refcount for each tunnel socket in rxe_ns_sock, we
  can implement a similar fast path for newlink, and dellink
  will be lockless thanks to atomic)

