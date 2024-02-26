Return-Path: <linux-rdma+bounces-1135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFEF8680AC
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 20:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F1A1C24666
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9954B131E21;
	Mon, 26 Feb 2024 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ynqm5rzn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735C12EBE8;
	Mon, 26 Feb 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974884; cv=none; b=Cw4ddmWq1fYV4PP2CozjfcqyvlqldTUZT0PNNpW9GEPShvgLfYz5/cxt8z3l5XQXsbZBdmcp+9dORzun76+CKZFIYi3Zqnwk19gluc5WXPBeJM/gWlIZGKA1o8ZulAwp3/faCg13RvX630pV8zg/qFyc8J87Le/L34aQznG2B+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974884; c=relaxed/simple;
	bh=2IMvj6BKrad+UO3o4Lame0r1eHqCS356qNz3ZuhZK+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWQvJMpEeQVtVD6QkBgUdwFa3jyIhBTViC7+wuofMGMBLDwhE1p6r3uft4gqXc7pUG/+yNAzEnxUJhtdpuBi/NEY6HXinCg0Z4ZbyqYw05RaSjUA8Xz8l+9vYAtodVwOEhqph0o9T8vm6bEoTolVX35xBQ1dL7ub+3s5bx2oPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ynqm5rzn; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708974883; x=1740510883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iEKwG7cNpTMOSKTX2FSnQ7X44J36E2CiTEJVO4bOpAs=;
  b=Ynqm5rznyuBrOe/SiBZdfsvE2R0SIzqjpXrRV3hqcY2g8mP3Ei0evwG2
   Lx/QQ49W365ivOhJVnXoB1SYo3nyjvFuzjG5ER6fWTvkof33aaXaTS2n2
   8jbzp1dbzroxzK7wclhNU610xNe9jL/UNwkVfwXiUmf4lxNGqlVidue/d
   k=;
X-IronPort-AV: E=Sophos;i="6.06,186,1705363200"; 
   d="scan'208";a="383773673"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 19:14:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:65011]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.27:2525] with esmtp (Farcaster)
 id 6c797f54-cb18-4c26-bb08-5b44a9c49f79; Mon, 26 Feb 2024 19:14:38 +0000 (UTC)
X-Farcaster-Flow-ID: 6c797f54-cb18-4c26-bb08-5b44a9c49f79
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 19:14:33 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 26 Feb 2024 19:14:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <allison.henderson@oracle.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<rds-devel@oss.oracle.com>, <sowmini.varadhan@oracle.com>,
	<syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Mon, 26 Feb 2024 11:14:21 -0800
Message-ID: <20240226191421.66834-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223182832.99661-1-kuniyu@amazon.com>
References: <20240223182832.99661-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Fri, 23 Feb 2024 10:28:32 -0800
> From: Eric Dumazet <edumazet@google.com>
> Date: Fri, 23 Feb 2024 19:09:27 +0100
> > On Fri, Feb 23, 2024 at 6:26 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > >
> > > syzkaller reported a warning of netns tracker [0] followed by KASAN
> > > splat [1] and another ref tracker warning [1].
> > >
> > > syzkaller could not find a repro, but in the log, the only suspicious
> > > sequence was as follows:
> > >
> > >   18:26:22 executing program 1:
> > >   r0 = socket$inet6_mptcp(0xa, 0x1, 0x106)
> > >   ...
> > >   connect$inet6(r0, &(0x7f0000000080)={0xa, 0x4001, 0x0, @loopback}, 0x1c) (async)
> > >
> > > The notable thing here is 0x4001 in connect(), which is RDS_TCP_PORT.
> > >
> > > So, the scenario would be:
> > >
> > >   1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
> > >       rds_tcp_listen_init().
> > >   2. syz-executor connect()s to it and creates a reqsk.
> > >   3. syz-executor exit()s immediately.
> > >   4. netns is dismantled.  [0]
> > >   5. reqsk timer is fired, and UAF happens while freeing reqsk.  [1]
> > >   6. listener is freed after RCU grace period.  [2]
> > >
> > > Basically, reqsk assumes that the listener guarantees netns safety
> > > until all reqsk timers are expired by holding the listener's refcount.
> > > However, this was not the case for kernel sockets.
> > >
> > > Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> > > inet_twsk_purge()") fixed this issue only for per-netns ehash, but
> > > the issue still exists for the global ehash.
> > >
> > > We can apply the same fix, but this issue is specific to RDS.
> > >
> > > Instead of iterating potentially large ehash and purging reqsk during
> > > netns dismantle, let's hold netns refcount for the kernel TCP listener.
> > >
> > >
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen endpoints, one per netns.")
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/rds/tcp_listen.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> > > index 05008ce5c421..4f7863932df7 100644
> > > --- a/net/rds/tcp_listen.c
> > > +++ b/net/rds/tcp_listen.c
> > > @@ -282,6 +282,11 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
> > >                 goto out;
> > >         }
> > >
> > > +       __netns_tracker_free(net, &sock->sk->ns_tracker, false);
> > > +       sock->sk->sk_net_refcnt = 1;
> > > +       get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> > > +       sock_inuse_add(net, 1);
> > > +
> > 
> > Why using sock_create_kern() then later 'convert' this kernel socket
> > to a user one ?
> > 
> > Would using __sock_create() avoid this ?
> 
> I think yes, but LSM would see kern=0 in pre/post socket() hooks.
> 
> Probably we can use __sock_create() in net-next and see if someone
> complains.

I noticed the patchwork status is Changes Requested.
https://patchwork.kernel.org/project/netdevbpf/list/?series=829213&state=*

Should we use __sock_create() for RDS or add another parameter
to __sock_create(..., kern=true/false, netref=true/false) and
fix other similar uses (MPTCP, SMC, Netlink) altogether ?

Thanks!

