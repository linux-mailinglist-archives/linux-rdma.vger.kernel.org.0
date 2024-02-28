Return-Path: <linux-rdma+bounces-1159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7686A68B
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Feb 2024 03:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188D41C24F6A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Feb 2024 02:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AED1AAC9;
	Wed, 28 Feb 2024 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XEsBwW/L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A586AC2;
	Wed, 28 Feb 2024 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709087077; cv=none; b=Z0fZ/OI4InZV1jJMX2J9rq2FTRgGeeDoafuQVqv449b4EF6M5DKFSHtghN2wC/fMR8rd49hRHRE0674f04FYq8ygXXKTJUmrXFuo2wvNTDKXn9YbWum/sYyRIDLcNr4tskFmIFGj4HUorIn6/cu292DgHzkIteCFscN7uLFNarQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709087077; c=relaxed/simple;
	bh=dUID6ohR+RXty1cSQ5piuQvyhOp0QaaLnFZmYuABhCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3bKhFpRP1Qo1w6G3dTqTtFjrIlZ0f9gKq8RxIzumL5pva8+BTm2f22+W8+qP/eY2aAvFrgJSqdQG1qeHns+UM48xtSRC6f1nQqn8caGb1dZ9AUld7hgcclz97CevGOU8pZDLnv2kmirkTJi7qkI7q6s9Mpl1qoQvaxP4GuqV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XEsBwW/L; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709087076; x=1740623076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4wFy4vuT1S3xswTE3T6+ACD2TG+t+2UcAbEZUUQS+RA=;
  b=XEsBwW/L6uWYp5mbt4izurPjqK3ZWJFsh7t5DnpNbJ7V/qm5I5BY/PYQ
   4jWovIQrcI6+vZbG9/ATvT1XyaYdZDYFTAmYa1VW/ibtJXF4gQB6fEyf2
   JwnmgFvrqsAbsOiuf1ANxwbwNeJejQdjQgETa7YPUW852OR8Hx+jGWDab
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,189,1705363200"; 
   d="scan'208";a="277222233"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 02:24:34 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:59965]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.237:2525] with esmtp (Farcaster)
 id 73027e11-55df-4f15-9c6e-9b56af0bba93; Wed, 28 Feb 2024 02:24:33 +0000 (UTC)
X-Farcaster-Flow-ID: 73027e11-55df-4f15-9c6e-9b56af0bba93
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 02:24:31 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 28 Feb 2024 02:24:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <allison.henderson@oracle.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <rds-devel@oss.oracle.com>,
	<syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 net 4/5] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Tue, 27 Feb 2024 18:24:20 -0800
Message-ID: <20240228022420.27327-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJErUHpaAqs=qzuD_WxqtBC1rqSh3n9sJ_zJKwHyPORmg@mail.gmail.com>
References: <CANn89iJErUHpaAqs=qzuD_WxqtBC1rqSh3n9sJ_zJKwHyPORmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 13:06:07 +0100
> On Tue, Feb 27, 2024 at 2:12 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > syzkaller reported a warning of netns tracker [0] followed by KASAN
> > splat [1] and another ref tracker warning [1].
> >
> > syzkaller could not find a repro, but in the log, the only suspicious
> > sequence was as follows:
> >
> >   18:26:22 executing program 1:
> >   r0 = socket$inet6_mptcp(0xa, 0x1, 0x106)
> >   ...
> >   connect$inet6(r0, &(0x7f0000000080)={0xa, 0x4001, 0x0, @loopback}, 0x1c) (async)
> >
> > The notable thing here is 0x4001 in connect(), which is RDS_TCP_PORT.
> >
> > So, the scenario would be:
> >
> >   1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
> >       rds_tcp_listen_init().
> >   2. syz-executor connect()s to it and creates a reqsk.
> >   3. syz-executor exit()s immediately.
> >   4. netns is dismantled.  [0]
> >   5. reqsk timer is fired, and UAF happens while freeing reqsk.  [1]
> >   6. listener is freed after RCU grace period.  [2]
> >
> > Basically, reqsk assumes that the listener guarantees netns safety
> > until all reqsk timers are expired by holding the listener's refcount.
> > However, this was not the case for kernel sockets.
> >
> > Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> > inet_twsk_purge()") fixed this issue only for per-netns ehash, but
> > the issue still exists for the global ehash.
> >
> > We can apply the same fix, but this issue is specific to RDS.
> >
> > Instead of iterating ehash and purging reqsk during netns dismantle,
> > let's hold netns refcount for the kernel listener.
> >
> >
> 
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen endpoints, one per netns.")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/rds/tcp_listen.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> > index 05008ce5c421..2d40e523322c 100644
> > --- a/net/rds/tcp_listen.c
> > +++ b/net/rds/tcp_listen.c
> > @@ -274,8 +274,8 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
> >         int addr_len;
> >         int ret;
> >
> > -       ret = sock_create_kern(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM,
> > -                              IPPROTO_TCP, &sock);
> > +       ret = __sock_create(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM,
> > +                           IPPROTO_TCP, &sock, SOCKET_KERN_NET_REF);
> >         if (ret < 0) {
> >                 rdsdebug("could not create %s listener socket: %d\n",
> >                          isv6 ? "IPv6" : "IPv4", ret);
> 
> If RDS module keeps a listener alive, not attached to a user process,
> netns dismantle will never occur.
> 
> I think we have to cleanup SYN_RECV sockets in inet_twsk_purge()

Ah.. yes, __init_net ops hook must not take net ref..
I'll go that way in v3.


> 
> Yes, it removes one optimization you did.
> 
> Perhaps add a counter of all kernel sockets that were ever attached to
> a netns in order to decide to apply the optimization.
> (keeping a precise count of SYN_RECV would be too expensive)

I'll work on the follow-up for net-next after the right fix is merged.

Thanks!

