Return-Path: <linux-rdma+bounces-1142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186D8681A5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 21:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2230A1C299E2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 20:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C032130AF2;
	Mon, 26 Feb 2024 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MmF7uzWE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4C129A91;
	Mon, 26 Feb 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977667; cv=none; b=EHVyKFETK/KtIgiJlb1EZKkcK48sKfrmu1yPTuxyrr0Vp6oRSlqQgqvKfZ9NCcvAnWa7ioGzBNocDwvh0rWMscF1KeSKfuifO2od05K0wyQdpcL5vLzJL9rHty0cr8NTkXjkj2VY7+UObjZ1MmfcHw9a9DCOBYEoUHiZHxuISbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977667; c=relaxed/simple;
	bh=XF6HBlstObL7tYjyP0gGN/+EF9C6yA1SIHDSAYKDQ5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1hPDnZdKpXGZ4BlcwPR4DA/N58IF9Fac9dOpxtTY+rm3rYsP13ayivmynE/uCpe6vceSqnYTO81WPUxwnZrKFLMXDUV5wsljjJWQBUrBek+gCV6/0ZLAURNrHsi4Q8DoO6YXXCXb/woRHPFKsscq/MTnNi4qnS2sBIdip+6iX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MmF7uzWE; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708977666; x=1740513666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mnBaJ7CtH6e4OUZFMPWkwm1W/OlrTstwL9y6AsGZ9Fg=;
  b=MmF7uzWEflYa+ex1/R3ZS+A2WLUVV6MmbLibRBMlq4WD2c7vk6oiM9H2
   hGqro4BcH0Dk0GOfjv7mVvHZ5hL4aqxeqbLU/Raqer/G4M/wALJy8tY4D
   FgRxyonU5xdzA2UEM4/X08zFcTQvmvBvV/ge1cvdzCLp5/pz77/oqzrDX
   U=;
X-IronPort-AV: E=Sophos;i="6.06,186,1705363200"; 
   d="scan'208";a="68881664"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 20:01:03 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:25431]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.67:2525] with esmtp (Farcaster)
 id 28dc76bb-c6a2-425e-9a69-44f99aedd695; Mon, 26 Feb 2024 20:01:03 +0000 (UTC)
X-Farcaster-Flow-ID: 28dc76bb-c6a2-425e-9a69-44f99aedd695
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 20:01:02 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 26 Feb 2024 20:00:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <allison.henderson@oracle.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <rds-devel@oss.oracle.com>,
	<sowmini.varadhan@oracle.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Mon, 26 Feb 2024 12:00:50 -0800
Message-ID: <20240226200050.71690-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iL+SSPYC8Bwm=-oDYRAkjE509_abvNK1KABThEPFaNL1g@mail.gmail.com>
References: <CANn89iL+SSPYC8Bwm=-oDYRAkjE509_abvNK1KABThEPFaNL1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Feb 2024 20:52:35 +0100
> On Mon, Feb 26, 2024 at 8:39 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Allison Henderson <allison.henderson@oracle.com>
> > Date: Mon, 26 Feb 2024 19:22:01 +0000
> > > On Mon, 2024-02-26 at 11:14 -0800, Kuniyuki Iwashima wrote:
> > > > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > Date: Fri, 23 Feb 2024 10:28:32 -0800
> > > > > From: Eric Dumazet <edumazet@google.com>
> > > > > Date: Fri, 23 Feb 2024 19:09:27 +0100
> > > > > > On Fri, Feb 23, 2024 at 6:26 PM Kuniyuki Iwashima
> > > > > > <kuniyu@amazon.com> wrote:
> > > > > > >
> > > > > > > syzkaller reported a warning of netns tracker [0] followed by
> > > > > > > KASAN
> > > > > > > splat [1] and another ref tracker warning [1].
> > > > > > >
> > > > > > > syzkaller could not find a repro, but in the log, the only
> > > > > > > suspicious
> > > > > > > sequence was as follows:
> > > > > > >
> > > > > > >   18:26:22 executing program 1:
> > > > > > >   r0 = socket$inet6_mptcp(0xa, 0x1, 0x106)
> > > > > > >   ...
> > > > > > >   connect$inet6(r0, &(0x7f0000000080)={0xa, 0x4001, 0x0,
> > > > > > > @loopback}, 0x1c) (async)
> > > > > > >
> > > > > > > The notable thing here is 0x4001 in connect(), which is
> > > > > > > RDS_TCP_PORT.
> > > > > > >
> > > > > > > So, the scenario would be:
> > > > > > >
> > > > > > >   1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
> > > > > > >       rds_tcp_listen_init().
> > > > > > >   2. syz-executor connect()s to it and creates a reqsk.
> > > > > > >   3. syz-executor exit()s immediately.
> > > > > > >   4. netns is dismantled.  [0]
> > > > > > >   5. reqsk timer is fired, and UAF happens while freeing
> > > > > > > reqsk.  [1]
> > > > > > >   6. listener is freed after RCU grace period.  [2]
> > > > > > >
> > > > > > > Basically, reqsk assumes that the listener guarantees netns
> > > > > > > safety
> > > > > > > until all reqsk timers are expired by holding the listener's
> > > > > > > refcount.
> > > > > > > However, this was not the case for kernel sockets.
> > > > > > >
> > > > > > > Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> > > > > > > inet_twsk_purge()") fixed this issue only for per-netns ehash,
> > > > > > > but
> > > > > > > the issue still exists for the global ehash.
> > > > > > >
> > > > > > > We can apply the same fix, but this issue is specific to RDS.
> > > > > > >
> > > > > > > Instead of iterating potentially large ehash and purging reqsk
> > > > > > > during
> > > > > > > netns dismantle, let's hold netns refcount for the kernel TCP
> > > > > > > listener.
> > > > > > >
> > > > > > >
> > > > > > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > > > > Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen
> > > > > > > endpoints, one per netns.")
> > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > > > ---
> > > > > > >  net/rds/tcp_listen.c | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> > > > > > > index 05008ce5c421..4f7863932df7 100644
> > > > > > > --- a/net/rds/tcp_listen.c
> > > > > > > +++ b/net/rds/tcp_listen.c
> > > > > > > @@ -282,6 +282,11 @@ struct socket *rds_tcp_listen_init(struct
> > > > > > > net *net, bool isv6)
> > > > > > >                 goto out;
> > > > > > >         }
> > > > > > >
> > > > > > > +       __netns_tracker_free(net, &sock->sk->ns_tracker,
> > > > > > > false);
> > > > > > > +       sock->sk->sk_net_refcnt = 1;
> > > > > > > +       get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> > > > > > > +       sock_inuse_add(net, 1);
> > > > > > > +
> > > > > >
> > > > > > Why using sock_create_kern() then later 'convert' this kernel
> > > > > > socket
> > > > > > to a user one ?
> > > > > >
> > > > > > Would using __sock_create() avoid this ?
> > > > >
> > > > > I think yes, but LSM would see kern=0 in pre/post socket() hooks.
> > > > >
> > > > > Probably we can use __sock_create() in net-next and see if someone
> > > > > complains.
> > > >
> > > > I noticed the patchwork status is Changes Requested.
> > > > https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdevbpf/list/?series=829213&state=*__;Kg!!ACWV5N9M2RV99hQ!KHKUQKUDnNCdiEcb4ZK1VBiYSitarEb-CAWeSJvaeK04fgW4cuWePg3Ac2HmIAPUHuqeCwgt466fHEKAAdfa$
> > > >
> > > >
> > > > Should we use __sock_create() for RDS or add another parameter
> > > > to __sock_create(..., kern=true/false, netref=true/false) and
> > > > fix other similar uses (MPTCP, SMC, Netlink) altogether ?
> > > >
> > > > Thanks!
> > >
> > > Hi all,
> > >
> > > Thank you for looking at this.  I've been doing a little investigation
> > > in the area to better understand the issue and this fix.  While I
> > > understand what this patch is trying to do here, I'd like to do a
> > > little more digging as to why 740ea3c4a0b2 didnt work for rds,
> >
> > 740ea3c4a0b2 works only for netns with its dedicated ehash, which
> > is unshare(CLONE_NEWNET)d with net.ipv4.tcp_child_ehash_entries != 0.
> >
> > With the diff below, we can fix the issue, but as noted in the
> > description, this slows down netns dismantle where no reqsk, this
> > is true if the netns did not have kernel TCP sockets.
> 
> BTW I note that inet_twsk_purge() probably would need this "goto
> restart;" as well....
> 
> sk_nulls_for_each_rcu(sk, node, &head->chain)  is not a _safe variant...

Ah exactly!  Will you post it or I can include it as the first patch.

The following patch will remove it and the end result will be the
same though.


> 
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> index 5befa4de5b2416281ad2795713a70d0fd847b0b2..a62031d85bcce00261193136dd72d9f57ffd34fc
> 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -283,10 +283,11 @@ void inet_twsk_purge(struct inet_hashinfo
> *hashinfo, int family)
>                                  * freed.  Userspace listener and
> reqsk never exist here.
>                                  */
>                                 if (unlikely(sk->sk_state == TCP_NEW_SYN_RECV &&
> -                                            hashinfo->pernet)) {
> +
> !refcount_read(&sock_net(sk)->ns.count))) {
>                                         struct request_sock *req =
> inet_reqsk(sk);
> 
> 
> inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
> +                                       goto restart;
>                                 }
> 
>                                 continue;

