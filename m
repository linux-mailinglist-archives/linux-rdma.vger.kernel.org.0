Return-Path: <linux-rdma+bounces-1118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8ED861B9E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 19:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7F028C899
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B85142623;
	Fri, 23 Feb 2024 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nY6W+eVE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24212D1F9;
	Fri, 23 Feb 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712951; cv=none; b=flCUhiGJkz3YBsfsrXNVCUFCuI+eI+LstnWYwTLJI6jMhSI4jIXWx/5e+ZRJ4pxD2SBdNcjy1GJQA0gn2YP2tDj9QWm4SmMtJi1WgImp+xY3PfYwMiGInyCGCvPhwyZNRdj02c+OC9GXkI9n8k1JgHkKTI4bpZddwUcrd8d8NPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712951; c=relaxed/simple;
	bh=yM7C/mIoTSeuQ//rGHXdVbVv9xlMbS5XhqsoRpKnB2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ext4X0wkynlUjdLIw+fLTp5usMDCfRF5fONsDuGRze54UKCPKPiRNJwsbIsHC5ikCK0no2akAx+XQ64Dk26ckFKZ0+SsTHHyROlgOP4lFrl4e85LiTynGHYQyGiCS7bKeSfBCJeL5FVgnSVQjeqQaWisHcFDhPLnE0y+aDYh8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nY6W+eVE; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708712949; x=1740248949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXqiXMxMIOF5N7hJ6ZqTDuaFCpdWZYr39M4bT/KPRYU=;
  b=nY6W+eVEi5pN+opPyW1sD1aHcfndznQJQ/MoOP34ajFRzXavJAQbwmMr
   j+nghnqTGn50TqxOI7/rLNVaL3bsE+poY1/JcW3qHBbpSfCXbufL1fiTo
   AdPoIbM08xVxCu65C3Q3qQmo9K9PPk5W/An8A9A2oSU5ba0+cPaR13xqP
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="399271952"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 18:28:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:31941]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.241:2525] with esmtp (Farcaster)
 id 62082d0e-ffc5-4cd0-9cc7-1f9783866926; Fri, 23 Feb 2024 18:28:51 +0000 (UTC)
X-Farcaster-Flow-ID: 62082d0e-ffc5-4cd0-9cc7-1f9783866926
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 18:28:43 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 18:28:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <allison.henderson@oracle.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <rds-devel@oss.oracle.com>,
	<sowmini.varadhan@oracle.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Fri, 23 Feb 2024 10:28:32 -0800
Message-ID: <20240223182832.99661-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKD9i-UKABN2XVczfYsrSKC81VUVQH+eJxYGgdz42ExTQ@mail.gmail.com>
References: <CANn89iKD9i-UKABN2XVczfYsrSKC81VUVQH+eJxYGgdz42ExTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Feb 2024 19:09:27 +0100
> On Fri, Feb 23, 2024 at 6:26 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
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
> > Instead of iterating potentially large ehash and purging reqsk during
> > netns dismantle, let's hold netns refcount for the kernel TCP listener.
> >
> >
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen endpoints, one per netns.")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/rds/tcp_listen.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> > index 05008ce5c421..4f7863932df7 100644
> > --- a/net/rds/tcp_listen.c
> > +++ b/net/rds/tcp_listen.c
> > @@ -282,6 +282,11 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
> >                 goto out;
> >         }
> >
> > +       __netns_tracker_free(net, &sock->sk->ns_tracker, false);
> > +       sock->sk->sk_net_refcnt = 1;
> > +       get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> > +       sock_inuse_add(net, 1);
> > +
> 
> Why using sock_create_kern() then later 'convert' this kernel socket
> to a user one ?
> 
> Would using __sock_create() avoid this ?

I think yes, but LSM would see kern=0 in pre/post socket() hooks.

Probably we can use __sock_create() in net-next and see if someone
complains.

