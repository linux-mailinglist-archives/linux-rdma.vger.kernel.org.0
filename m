Return-Path: <linux-rdma+bounces-1140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EC886817A
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 20:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49081F2565E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 19:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50087130ADC;
	Mon, 26 Feb 2024 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0V8jhptt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A25129A91
	for <linux-rdma@vger.kernel.org>; Mon, 26 Feb 2024 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977173; cv=none; b=Evi0bpp9++nE3zKAd1DQA+M10hDaSsT+s8ItUjnreU67YltJAgo4XZaAP1mX1ugyHN3MRiboDsNupqz2WfDg8vySJFiI/um8fKhi+Esb2dD4h8dvrbvCumoRADEU+mnVFh7wcy1KQCuExPrhdYUGS2RLGPPWQP42UDlH4Rcic7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977173; c=relaxed/simple;
	bh=y01BvFAkrfrVhU21/DQvkot2V+GFZJIYF91Q/ml5iKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+AufeEzmuvC8G8gY2x2xY2dv+4VRqamt8aRrBvR7s66JOcQvWSWB56xw+/9iN+KowQyTsPMH5Riqlb2XrPg1M9APB0HtAyDyTV29d9C70f/Z6gJ4Wh14K+PV1i/3MrmtH/t/p+Ggxm59RpXZ+UrCCyVyK7Tg0Jy6Ux9gr03m2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0V8jhptt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso354a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 26 Feb 2024 11:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708977169; x=1709581969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDgCF7iJjV3FkXUxcLoY1zQ9rm18ScJtC7x4eKLCNts=;
        b=0V8jhpttkzwTW0r9KOrz5DSdKka9CmXp1DjisHec8lRYB0AIViksI9HXh/AsRfK6v1
         kJti6H6RvyW30pwSRjQ0AyV2wzgA9l6aDCOHDaubKu9TuzHWKo0ZjXCTsqQAYKo0PJ0+
         pzWHFWnWtqzJ7FZJHHQjvNolWbBa2vN2IB9jxzSamu7GrCQQCHzCWhVjw6hsoWIbCcEW
         KiUqeZ9PHaVYRg3xugBK2793EWY3ADjopu6p2i1P3bVGfAt2XH/LQ7RI3F0D8rbGUvtd
         LX1ghj/jPkd2uImj/mkAgxS7OurTfazqitY9rjX6nAj58iSuBKybpZ+uLZMT8QFknFQI
         Bv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977169; x=1709581969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDgCF7iJjV3FkXUxcLoY1zQ9rm18ScJtC7x4eKLCNts=;
        b=jElQ9mkf7hBKAmqg4LkI4ypI2qtwHawHmJ3z3xJuWcjv9TfUmdh90sp9c/pZB1iysy
         dz9CSkD5LlbQIyfOBFvQHjVqPL4QEsFEBYt5u4YSjFlTXRBg+5IIhABbiBDmlMnQ+XA9
         y/QZKHGa7BtmRXaDOotqhlftRfhNECc+qkXgnCBK+oPh03pOgRLZoDEfDnst+3pX6qrz
         1vuhrclsVArVt6g15xZIF0tB48NMFneokhaq2zx+4sk+uyheBd6A6S961yk9XWsmgBPx
         xUFG0wWpTGWc/1fiJ1G/2mxJj+16QBXuTPZKKXurNYcoyLIrLSIa8NVLKcVjhef0oceR
         oGcg==
X-Forwarded-Encrypted: i=1; AJvYcCUOS0y7EKIijoeyZ2fC0DmG4WsICxRlbyG7wkcI5nvm9vuAigy1wXNxpFpyorAecnYAvl1fHbV6Xqn48Fnrs7v0Ff025M1a/6SaFQ==
X-Gm-Message-State: AOJu0Yyt2F3HMHOwotVbSMGQdVAYFUwRauJwHxtlkeba83jFBfgqG5BK
	Qeq+8qUx2ZC9LcVFfps96F/6lnFcQcPQvdM+EiNT6zicgNXiMhk2ezCqhjQknFC+6w+YY4qXNeW
	a1uu3tLm4B3oi9JDxH7eFpDUVZgTDLJtZJDBy
X-Google-Smtp-Source: AGHT+IEu75F1QGqG2VZKHqwXX0be24MSbstbIMxQ/9mnzwBiHCQbZZ5u32JcJfsAL3xxXz61OojTdtpXe6Lv89TnDbE=
X-Received: by 2002:a50:c30b:0:b0:560:1a1:eb8d with SMTP id
 a11-20020a50c30b000000b0056001a1eb8dmr30790edb.7.1708977169413; Mon, 26 Feb
 2024 11:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <725e8196ad84a91fadcf8858422b20b13f71ca0c.camel@oracle.com> <20240226193857.69672-1-kuniyu@amazon.com>
In-Reply-To: <20240226193857.69672-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Feb 2024 20:52:35 +0100
Message-ID: <CANn89iL+SSPYC8Bwm=-oDYRAkjE509_abvNK1KABThEPFaNL1g@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, kuba@kernel.org, 
	kuni1840@gmail.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, rds-devel@oss.oracle.com, sowmini.varadhan@oracle.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:39=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Allison Henderson <allison.henderson@oracle.com>
> Date: Mon, 26 Feb 2024 19:22:01 +0000
> > On Mon, 2024-02-26 at 11:14 -0800, Kuniyuki Iwashima wrote:
> > > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > Date: Fri, 23 Feb 2024 10:28:32 -0800
> > > > From: Eric Dumazet <edumazet@google.com>
> > > > Date: Fri, 23 Feb 2024 19:09:27 +0100
> > > > > On Fri, Feb 23, 2024 at 6:26=E2=80=AFPM Kuniyuki Iwashima
> > > > > <kuniyu@amazon.com> wrote:
> > > > > >
> > > > > > syzkaller reported a warning of netns tracker [0] followed by
> > > > > > KASAN
> > > > > > splat [1] and another ref tracker warning [1].
> > > > > >
> > > > > > syzkaller could not find a repro, but in the log, the only
> > > > > > suspicious
> > > > > > sequence was as follows:
> > > > > >
> > > > > >   18:26:22 executing program 1:
> > > > > >   r0 =3D socket$inet6_mptcp(0xa, 0x1, 0x106)
> > > > > >   ...
> > > > > >   connect$inet6(r0, &(0x7f0000000080)=3D{0xa, 0x4001, 0x0,
> > > > > > @loopback}, 0x1c) (async)
> > > > > >
> > > > > > The notable thing here is 0x4001 in connect(), which is
> > > > > > RDS_TCP_PORT.
> > > > > >
> > > > > > So, the scenario would be:
> > > > > >
> > > > > >   1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
> > > > > >       rds_tcp_listen_init().
> > > > > >   2. syz-executor connect()s to it and creates a reqsk.
> > > > > >   3. syz-executor exit()s immediately.
> > > > > >   4. netns is dismantled.  [0]
> > > > > >   5. reqsk timer is fired, and UAF happens while freeing
> > > > > > reqsk.  [1]
> > > > > >   6. listener is freed after RCU grace period.  [2]
> > > > > >
> > > > > > Basically, reqsk assumes that the listener guarantees netns
> > > > > > safety
> > > > > > until all reqsk timers are expired by holding the listener's
> > > > > > refcount.
> > > > > > However, this was not the case for kernel sockets.
> > > > > >
> > > > > > Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> > > > > > inet_twsk_purge()") fixed this issue only for per-netns ehash,
> > > > > > but
> > > > > > the issue still exists for the global ehash.
> > > > > >
> > > > > > We can apply the same fix, but this issue is specific to RDS.
> > > > > >
> > > > > > Instead of iterating potentially large ehash and purging reqsk
> > > > > > during
> > > > > > netns dismantle, let's hold netns refcount for the kernel TCP
> > > > > > listener.
> > > > > >
> > > > > >
> > > > > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > > > Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen
> > > > > > endpoints, one per netns.")
> > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > > ---
> > > > > >  net/rds/tcp_listen.c | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > >
> > > > > > diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> > > > > > index 05008ce5c421..4f7863932df7 100644
> > > > > > --- a/net/rds/tcp_listen.c
> > > > > > +++ b/net/rds/tcp_listen.c
> > > > > > @@ -282,6 +282,11 @@ struct socket *rds_tcp_listen_init(struct
> > > > > > net *net, bool isv6)
> > > > > >                 goto out;
> > > > > >         }
> > > > > >
> > > > > > +       __netns_tracker_free(net, &sock->sk->ns_tracker,
> > > > > > false);
> > > > > > +       sock->sk->sk_net_refcnt =3D 1;
> > > > > > +       get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> > > > > > +       sock_inuse_add(net, 1);
> > > > > > +
> > > > >
> > > > > Why using sock_create_kern() then later 'convert' this kernel
> > > > > socket
> > > > > to a user one ?
> > > > >
> > > > > Would using __sock_create() avoid this ?
> > > >
> > > > I think yes, but LSM would see kern=3D0 in pre/post socket() hooks.
> > > >
> > > > Probably we can use __sock_create() in net-next and see if someone
> > > > complains.
> > >
> > > I noticed the patchwork status is Changes Requested.
> > > https://urldefense.com/v3/__https://patchwork.kernel.org/project/netd=
evbpf/list/?series=3D829213&state=3D*__;Kg!!ACWV5N9M2RV99hQ!KHKUQKUDnNCdiEc=
b4ZK1VBiYSitarEb-CAWeSJvaeK04fgW4cuWePg3Ac2HmIAPUHuqeCwgt466fHEKAAdfa$
> > >
> > >
> > > Should we use __sock_create() for RDS or add another parameter
> > > to __sock_create(..., kern=3Dtrue/false, netref=3Dtrue/false) and
> > > fix other similar uses (MPTCP, SMC, Netlink) altogether ?
> > >
> > > Thanks!
> >
> > Hi all,
> >
> > Thank you for looking at this.  I've been doing a little investigation
> > in the area to better understand the issue and this fix.  While I
> > understand what this patch is trying to do here, I'd like to do a
> > little more digging as to why 740ea3c4a0b2 didnt work for rds,
>
> 740ea3c4a0b2 works only for netns with its dedicated ehash, which
> is unshare(CLONE_NEWNET)d with net.ipv4.tcp_child_ehash_entries !=3D 0.
>
> With the diff below, we can fix the issue, but as noted in the
> description, this slows down netns dismantle where no reqsk, this
> is true if the netns did not have kernel TCP sockets.

BTW I note that inet_twsk_purge() probably would need this "goto
restart;" as well....

sk_nulls_for_each_rcu(sk, node, &head->chain)  is not a _safe variant...

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5befa4de5b2416281ad2795713a70d0fd847b0b2..a62031d85bcce00261193136dd7=
2d9f57ffd34fc
100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -283,10 +283,11 @@ void inet_twsk_purge(struct inet_hashinfo
*hashinfo, int family)
                                 * freed.  Userspace listener and
reqsk never exist here.
                                 */
                                if (unlikely(sk->sk_state =3D=3D TCP_NEW_SY=
N_RECV &&
-                                            hashinfo->pernet)) {
+
!refcount_read(&sock_net(sk)->ns.count))) {
                                        struct request_sock *req =3D
inet_reqsk(sk);


inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
+                                       goto restart;
                                }

                                continue;

