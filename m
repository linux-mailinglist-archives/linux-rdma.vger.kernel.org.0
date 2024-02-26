Return-Path: <linux-rdma+bounces-1137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479DF868132
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 20:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31268B2109D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F512FF68;
	Mon, 26 Feb 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R9x6HVXA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5F12FB3A;
	Mon, 26 Feb 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976357; cv=none; b=G82U1lKJlrc9M2tv2+k2uudz8rjPc3F1uj2IkgkJ16gCxegx9LS3UJnOJWvlgFhjud90TJGuxz/8Lb9lf8w4X0R5cNaDbzi8cx4i1jauoDO/RYQOiYuwfGB+bo92d9N8WJm2RF6CP2Jsb9hXVrgrTqJvEZK8uK8rFlBp7U4E2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976357; c=relaxed/simple;
	bh=Exmsbj5zEcpXtSMSN9cHzBX3eGcMdaVwOkJezJk8CPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abm2cATBekvYgGbwkf/amF4UEXE+XJKb2dU4YKoCgdhkDvZDvVRuemvICNd0qYBiBDc23kTv0o7n+aipyyCP2n6c1y6hIfbzIQIdot7G1khXchgteTHMdHr3G4vUvltPSCmXWlmZdTyzriF17BfsBPMaT8EbhzjsFhKVM7sCtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R9x6HVXA; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708976356; x=1740512356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RIRDlX5Zp0eO9uXyoVBk9Z6LkWSRosBeUMO3Ucc7gXg=;
  b=R9x6HVXA/WqrFlgjvlKgV8owpmuH8qucXZ2YO1lALsHdYkz05TRommmp
   a7dSFw6FwGVyUIW18cBamWL/XRWNAgZj7d4s3TAOh+clq3wHz6KO9jPmE
   78I3tX7vxcCAcS5a5MC9/U7wVUva8Vbm2S4+aIDnRPcfvV7FPgNsx4z2T
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,186,1705363200"; 
   d="scan'208";a="383779385"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 19:39:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:57198]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.172:2525] with esmtp (Farcaster)
 id 942f5887-c089-4ee4-83f9-928b5c302ee2; Mon, 26 Feb 2024 19:39:12 +0000 (UTC)
X-Farcaster-Flow-ID: 942f5887-c089-4ee4-83f9-928b5c302ee2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 19:39:09 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 26 Feb 2024 19:39:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <allison.henderson@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <rds-devel@oss.oracle.com>,
	<sowmini.varadhan@oracle.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Mon, 26 Feb 2024 11:38:57 -0800
Message-ID: <20240226193857.69672-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <725e8196ad84a91fadcf8858422b20b13f71ca0c.camel@oracle.com>
References: <725e8196ad84a91fadcf8858422b20b13f71ca0c.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Allison Henderson <allison.henderson@oracle.com>
Date: Mon, 26 Feb 2024 19:22:01 +0000
> On Mon, 2024-02-26 at 11:14 -0800, Kuniyuki Iwashima wrote:
> > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Date: Fri, 23 Feb 2024 10:28:32 -0800
> > > From: Eric Dumazet <edumazet@google.com>
> > > Date: Fri, 23 Feb 2024 19:09:27 +0100
> > > > On Fri, Feb 23, 2024 at 6:26 PM Kuniyuki Iwashima
> > > > <kuniyu@amazon.com> wrote:
> > > > > 
> > > > > syzkaller reported a warning of netns tracker [0] followed by
> > > > > KASAN
> > > > > splat [1] and another ref tracker warning [1].
> > > > > 
> > > > > syzkaller could not find a repro, but in the log, the only
> > > > > suspicious
> > > > > sequence was as follows:
> > > > > 
> > > > >   18:26:22 executing program 1:
> > > > >   r0 = socket$inet6_mptcp(0xa, 0x1, 0x106)
> > > > >   ...
> > > > >   connect$inet6(r0, &(0x7f0000000080)={0xa, 0x4001, 0x0,
> > > > > @loopback}, 0x1c) (async)
> > > > > 
> > > > > The notable thing here is 0x4001 in connect(), which is
> > > > > RDS_TCP_PORT.
> > > > > 
> > > > > So, the scenario would be:
> > > > > 
> > > > >   1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
> > > > >       rds_tcp_listen_init().
> > > > >   2. syz-executor connect()s to it and creates a reqsk.
> > > > >   3. syz-executor exit()s immediately.
> > > > >   4. netns is dismantled.  [0]
> > > > >   5. reqsk timer is fired, and UAF happens while freeing
> > > > > reqsk.  [1]
> > > > >   6. listener is freed after RCU grace period.  [2]
> > > > > 
> > > > > Basically, reqsk assumes that the listener guarantees netns
> > > > > safety
> > > > > until all reqsk timers are expired by holding the listener's
> > > > > refcount.
> > > > > However, this was not the case for kernel sockets.
> > > > > 
> > > > > Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> > > > > inet_twsk_purge()") fixed this issue only for per-netns ehash,
> > > > > but
> > > > > the issue still exists for the global ehash.
> > > > > 
> > > > > We can apply the same fix, but this issue is specific to RDS.
> > > > > 
> > > > > Instead of iterating potentially large ehash and purging reqsk
> > > > > during
> > > > > netns dismantle, let's hold netns refcount for the kernel TCP
> > > > > listener.
> > > > > 
> > > > > 
> > > > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > > Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen
> > > > > endpoints, one per netns.")
> > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > > ---
> > > > >  net/rds/tcp_listen.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> > > > > index 05008ce5c421..4f7863932df7 100644
> > > > > --- a/net/rds/tcp_listen.c
> > > > > +++ b/net/rds/tcp_listen.c
> > > > > @@ -282,6 +282,11 @@ struct socket *rds_tcp_listen_init(struct
> > > > > net *net, bool isv6)
> > > > >                 goto out;
> > > > >         }
> > > > > 
> > > > > +       __netns_tracker_free(net, &sock->sk->ns_tracker,
> > > > > false);
> > > > > +       sock->sk->sk_net_refcnt = 1;
> > > > > +       get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
> > > > > +       sock_inuse_add(net, 1);
> > > > > +
> > > > 
> > > > Why using sock_create_kern() then later 'convert' this kernel
> > > > socket
> > > > to a user one ?
> > > > 
> > > > Would using __sock_create() avoid this ?
> > > 
> > > I think yes, but LSM would see kern=0 in pre/post socket() hooks.
> > > 
> > > Probably we can use __sock_create() in net-next and see if someone
> > > complains.
> > 
> > I noticed the patchwork status is Changes Requested.
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/netdevbpf/list/?series=829213&state=*__;Kg!!ACWV5N9M2RV99hQ!KHKUQKUDnNCdiEcb4ZK1VBiYSitarEb-CAWeSJvaeK04fgW4cuWePg3Ac2HmIAPUHuqeCwgt466fHEKAAdfa$
> >  
> > 
> > Should we use __sock_create() for RDS or add another parameter
> > to __sock_create(..., kern=true/false, netref=true/false) and
> > fix other similar uses (MPTCP, SMC, Netlink) altogether ?
> > 
> > Thanks!
> 
> Hi all,
> 
> Thank you for looking at this.  I've been doing a little investigation
> in the area to better understand the issue and this fix.  While I
> understand what this patch is trying to do here, I'd like to do a
> little more digging as to why 740ea3c4a0b2 didnt work for rds,

740ea3c4a0b2 works only for netns with its dedicated ehash, which
is unshare(CLONE_NEWNET)d with net.ipv4.tcp_child_ehash_entries != 0.

With the diff below, we can fix the issue, but as noted in the
description, this slows down netns dismantle where no reqsk, this
is true if the netns did not have kernel TCP sockets.

---8<---
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9e85f2a0bddd..0ecc7311dc6c 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -398,10 +398,6 @@ void tcp_twsk_purge(struct list_head *net_exit_list, int family)
 			/* Even if tw_refcount == 1, we must clean up kernel reqsk */
 			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo, family);
 		} else if (!purged_once) {
-			/* The last refcount is decremented in tcp_sk_exit_batch() */
-			if (refcount_read(&net->ipv4.tcp_death_row.tw_refcount) == 1)
-				continue;
-
 			inet_twsk_purge(&tcp_hashinfo, family);
 			purged_once = true;
 		}
---8<---


> or what
> else rds may not be doing correctly that the other sockets are.

RDS has to clean up all sockets before netns are destroyed, but
it doesn't.  RDS per-netns TCP listener could have reqsk tied to
it, and reqsk timer could be fired after the netns and the listener
are freed.

Here we have 2 options to fix the issue.

  1) iterate ehash and purge reqsk during netns dismantle
  2) defer netns dismantle until reqsk timers are all fired

and 2) is preferred as the issue is specific to RDS.


> I'm
> not quite sure about setting the kern parameter to 0 for socket_create.
> While it seems like it would have a similar effect, this looks
> incorrect since this is not a user space socket.  

Probably kern parameter could be enum.

  SOCKET_USER = 0,
  SOCKET_KERN,
  SOCKET_KERN_NET_REFCNT,

If the enum is > 0, we can invoke LSM and mask it with
SOCKET_KERN_NET_REFCNT and pass down to it.

