Return-Path: <linux-rdma+bounces-1139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9186816D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 20:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0659128BA29
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D967130ACC;
	Mon, 26 Feb 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wh3wuSXN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211660BA1;
	Mon, 26 Feb 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976936; cv=none; b=QgEOQc/pNAchN+uzMvgiVZvedO/Jl0RKbNsG1iRYLMB4z4fipsQJtL87ND3XATLP14TB1aOoIK/FkMQHvhk05MA1hgATAztugYT5Kt0v5XwizOLlenpcagr7cJ/4mg+gfqu7u1QuElduc2rC0bzptasqZTejD8L7NUjLk3XO4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976936; c=relaxed/simple;
	bh=w84SHmgAHfOatuxBCiBAzB/+W9CyFtGI+9YgH2NGO+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qb199zumahsdDGYDIQWzVRuhYWDkP4hIuOpbLFxvWNVECsay6aedAS9GELt5Lh0Fk+mRGYt1oY3v6wz9o5PWkajpcX1wzgvgGZpdzQU8AKYn3I6rOXIrIkKGLkGhTAIDyUzuf8fmUacp1ZikbASGdSAwwtYiLlYmWOMXPmHRlE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wh3wuSXN; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708976934; x=1740512934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmUKGrfjFiVhh7T43Pat5Bc0aWlwO+ddTpTRlWa+3Js=;
  b=Wh3wuSXNjib1B+aejaKxP9XFkJ6UqNSrja3J2xo6PDNShUClKmlGj7kW
   noHvE2YElI+FGYAL6OfYMiPLBjbONyt940N3uo1HCr5TmKAr86dQHAFtz
   ssvGK6ThYKwSdq5cAgpEkffuiIe9rXWiduw0tfyat13xPlaWXZo+SL2VV
   0=;
X-IronPort-AV: E=Sophos;i="6.06,186,1705363200"; 
   d="scan'208";a="68874358"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 19:48:51 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:46392]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.172:2525] with esmtp (Farcaster)
 id e1feba73-12d9-449e-b68a-4485c7360ccb; Mon, 26 Feb 2024 19:48:50 +0000 (UTC)
X-Farcaster-Flow-ID: e1feba73-12d9-449e-b68a-4485c7360ccb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 19:48:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 26 Feb 2024 19:48:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <allison.henderson@oracle.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <rds-devel@oss.oracle.com>,
	<sowmini.varadhan@oracle.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Mon, 26 Feb 2024 11:48:38 -0800
Message-ID: <20240226194838.70789-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJb-TeMKZCAzhfXhhzQ2FkYYZd9DqyHCwRoOn5KV4+Z5A@mail.gmail.com>
References: <CANn89iJb-TeMKZCAzhfXhhzQ2FkYYZd9DqyHCwRoOn5KV4+Z5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Feb 2024 20:40:10 +0100
> On Mon, Feb 26, 2024 at 8:22 PM Allison Henderson
> <allison.henderson@oracle.com> wrote:
> >
> > On Mon, 2024-02-26 at 11:14 -0800, Kuniyuki Iwashima wrote:
> > > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > Date: Fri, 23 Feb 2024 10:28:32 -0800
> > > > From: Eric Dumazet <edumazet@google.com>
> > > > Date: Fri, 23 Feb 2024 19:09:27 +0100
> > > > > On Fri, Feb 23, 2024 at 6:26 PM Kuniyuki Iwashima
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
> > > > > >   r0 = socket$inet6_mptcp(0xa, 0x1, 0x106)
> > > > > >   ...
> > > > > >   connect$inet6(r0, &(0x7f0000000080)={0xa, 0x4001, 0x0,
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
> > > > > > +       sock->sk->sk_net_refcnt = 1;
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
> > > > I think yes, but LSM would see kern=0 in pre/post socket() hooks.
> > > >
> > > > Probably we can use __sock_create() in net-next and see if someone
> > > > complains.
> > >
> > > I noticed the patchwork status is Changes Requested.
> > > https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdevbpf/list/?series=829213&state=*__;Kg!!ACWV5N9M2RV99hQ!KHKUQKUDnNCdiEcb4ZK1VBiYSitarEb-CAWeSJvaeK04fgW4cuWePg3Ac2HmIAPUHuqeCwgt466fHEKAAdfa$
> > >
> > >
> > > Should we use __sock_create() for RDS or add another parameter
> > > to __sock_create(..., kern=true/false, netref=true/false) and
> > > fix other similar uses (MPTCP, SMC, Netlink) altogether ?
> > >
> > > Thanks!
> >
> > Hi all,
> >
> > Thank you for looking at this.  I've been doing a little investigation
> > in the area to better understand the issue and this fix.  While I
> > understand what this patch is trying to do here, I'd like to do a
> > little more digging as to why 740ea3c4a0b2 didnt work for rds, or what
> > else rds may not be doing correctly that the other sockets are.  I'm
> > not quite sure about setting the kern parameter to 0 for socket_create.
> > While it seems like it would have a similar effect, this looks
> > incorrect since this is not a user space socket.
> >
> > I'll do a little more diging myself too.  If you had another idea about
> > adding parameters to __sock_create, I'd be happy to take a look.  Thank
> > you!
> 
> I wonder if the following change would help ?

Yes, it also fixes the issue. :)
https://lore.kernel.org/netdev/20240226193857.69672-1-kuniyu@amazon.com/

but it will trigger full ehash iteration for netns with no RDS usage
(and even without TCP).

So, I think __sock_create() or the netref conversion would be better.


> 
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 9e85f2a0bddd4978b1bde6add1efc6aad351db8b..0ecc7311dc6ceedd8ada7b99b1441a562a6be4d6
> 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -398,10 +398,6 @@ void tcp_twsk_purge(struct list_head
> *net_exit_list, int family)
>                         /* Even if tw_refcount == 1, we must clean up
> kernel reqsk */
> 
> inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo, family);
>                 } else if (!purged_once) {
> -                       /* The last refcount is decremented in
> tcp_sk_exit_batch() */
> -                       if
> (refcount_read(&net->ipv4.tcp_death_row.tw_refcount) == 1)
> -                               continue;
> -
>                         inet_twsk_purge(&tcp_hashinfo, family);
>                         purged_once = true;
>                 }

