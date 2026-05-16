Return-Path: <linux-rdma+bounces-20799-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOkWLO9lCGromgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20799-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 14:41:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E9655BD1C
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 14:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A632130115AA
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8533D648C;
	Sat, 16 May 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TmbCC9B1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12D30648A;
	Sat, 16 May 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778935257; cv=none; b=pbNpoW/bCltogNopsKgQNjdnt0cGIbqxjcH7LX5dUETgvRdXP53rUe3oXQrcdWjlaR0oodOHS9y8xG9ahKoGJCX8Mugpao71rJghoOdXvqDf/nWtpVVDX0fYtdE7gjZEna1a/tnpTlcfF+mYDDyFUW7hjkjxE+rOyF8cWpioV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778935257; c=relaxed/simple;
	bh=Vo5Z/L1Sas/37lmOMcWft35zXgLqFdtzmshl5IH4lm4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=V/Z6PA+Z2/SFkvgwENtNJYCbcsEwn+FV3SBgnRn/ejQ38CBTQ8Px/zK71LYU63QtO2z7zeM6k/l1o16jMBhlY6lLfuLI8+tDoEz4KXJOeejLUIPHkez43x20VoCjJ0SELw9b0LpoauRNWLM5iohAROQTbblEmupmq6/AM4yDR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TmbCC9B1; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1778935245; bh=4r1Zzi9wwhOJMeUIJBhxhb4qj0sTJbM5a/Qno3kXbgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmbCC9B1/dXbG446fXxez6yBlW/6Vy1YppixCLtA3p0KjKb4T4PgP7iZnsLr24L+p
	 v90ugzZabBymkyo49n7HcCbsNgLCmvi6nVbgcszotezsdeFxVArcw0/Adxx5o/6sMX
	 mt/iDNahi/S+6ydX6zjMbbE1Z/oRQ4SwU3ijP3Dw=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id A261E408; Sat, 16 May 2026 20:40:38 +0800
X-QQ-mid: xmsmtpt1778935238td8938n2x
Message-ID: <tencent_0106C0D2EA464109986EE86EF40CB5E7D406@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLJQzDT4rpHk3NSGAMaog6L8ccJhGUHTDim9aOeeRfUup7MlJ0o2
	 7G52pC20CBUtZU8xeIU3+E0Fsuq4BcYoksTUDD6kqR03xje6Cf0hdCGf8FE8zWU8mpJFRZJSEme2
	 DISTv6mf4YhYT6Tsw7QEMOV68U6Yyj2IDTsXCWJBQGYQ+UWY14z7m8HZPuKu3g01ivcGS+CpD5ae
	 w7rzaDSQHDcZ5pPZai+D1xEn6RlZ6q3g6FE19YnQqIQkF1vKVS/KkmIxohKPflN6zaM1LRNOOPrR
	 Y9kONH7Cwnj34orKrud7PHTOu3VUExMGt8/jZDLvh8sADqXfwofOOCOqNNK6ACv9Dz3JeNmCSYhy
	 VUc4g27dfguwav7WhFrjLrHTgovICd6pTYxjaWXxk9ag66c6NonzY4+jFi9TZz0e5dDY3557xyoz
	 mgoKbN1jkkSyLH7m0C/gK/yF9SMsiYjsvgDBafZN5rXK5iQve5elIiB2vflJA4diluw+1YBfa/bC
	 qnC6N2cxsJuuXTOcdpWePYvU90tPFl/SkJY3tTvlXHRyPn4ZELhhQ1mo8PCZ9OOuoHsYtu0Gjqw6
	 PJGBQMbEr8WlIWY8jyP9iXfhsZs1KWkl4tcukyFrYuLqQD0YRjAuvzVBynLRxz+6xGPL4Y568uqC
	 vTggwTUogekDgSoEfD+LXgcoNFQwiBuqVb1x+jMIt2CzC7AetB+Re5WFpb9Ml9eeqCGMwHTziyC4
	 FF21BDjxmNOsJGRvGxX0hBxk2Sq5ESKxzbbe+tcynUqfXl/CDKVSPrHdKQwQW0CaFFKKkWiPUKXI
	 OwZu39WzMMeUXEuBDHiHVy4tLMUntkG0axNAq+hp4FhErBdJ1uuETFxuy9lilbGQh7PciiApURG+
	 jspRIKBerHNTiesApK5RBlhoczdFdT6ufUOYeq8IzN3upEodpHX4q7mYfue8lsTAvNmdQsYeTsv4
	 slhUS2kpTpDUOzpnOg2ocokA9z4PMchr/hWrgB9JUCRf6QNcZG0ET2pTOCJ/eOnI67mr4g+pT8uQ
	 PO8ZkkU9YsE+cP7TCsFQ6RntxndStJOVrlSprCXZpvf0o8cPJl
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Edward Adam Davis <eadavis@qq.com>
To: jgg@ziepe.ca
Cc: akpm@linux-foundation.org,
	arjan@linux.intel.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	eadavis@qq.com,
	edumazet@google.com,
	hdanton@sina.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH] RDMA/nldev: add mutual exclusion in nldev_dellink()
Date: Sat, 16 May 2026 20:40:38 +0800
X-OQ-MSGID: <20260516124037.428461-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514141409.GA7702@ziepe.ca>
References: <20260514141409.GA7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2E9655BD1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20799-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,qq.com,google.com,sina.com,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,linux.dev,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:mid,qq.com:dkim]
X-Rspamd-Action: no action

On Thu, 14 May 2026 11:14:09 -0300, Jason Gunthorpe wrote:
> On Thu, May 14, 2026 at 07:58:18AM -0600, David Ahern wrote:
> > On 5/14/26 5:50 AM, Jason Gunthorpe wrote:
> > > On Thu, May 14, 2026 at 03:31:22PM +0800, Edward Adam Davis wrote:
> > >> On Wed, 13 May 2026 20:46:55 -0300, Jason Gunthorpe wrote:
> > >>> On Wed, May 13, 2026 at 02:17:28PM -0400, Leon Romanovsky wrote:
> > >>>>
> > >>>> On Thu, 07 May 2026 20:50:10 +0800, Edward Adam Davis wrote:
> > >>>>> We must serialize calls to nldev_dellink() or risk a crash as syzbot
> > >>>>> reported:
> > >>>>>
> > >>>>> Call Trace:
> > >>>>>  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> > >>>>>  rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
> > >>>>>  rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
> > >>>>>  rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
> > >>>>>  rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
> > >>>>>
> > >>>>> [...]
> > >>>>
> > >>>> Applied, thanks!
> > >>>>
> > >>>> [1/1] RDMA/nldev: add mutual exclusion in nldev_dellink()
> > >>>>       https://git.kernel.org/rdma/rdma/c/0b28000b64f40d
> > >>>
> > >>> This seems like a rxe bug, I would have expected the lock to be inside
> > >>> rxe to protect its racy implementation of rxe_net_del(), which looks
> > >>> like it is possibly also triggered by NETDEV_UNREGISTER...
> > >> No, it was triggered by RDMA_NLDEV_CMD_DELLINK, you can see the "call trace".
> >
> > Not that Jason's point. Code wise
> >
> > rxe_dellink -> rxe_net_del
> >
> > netdev NETDEV_UNREGISTER:
> >  rxe_notify -> rxe_net_del
> >
> > both can lead to the same problem
> >
> > >>>
> > >>> ie it should not change nldev_dellink().
> > >> While this could be fixed within RXE, the same issue affects all other
> > >> RXE-like submodules when they subsequently support the "dellink" interface,
> > >> therefore, handling this within nldev_dellink() is relatively more appropriate.
> > >
> > > Why would other modules have an issue? The problem is rxe's racey
> > > refcounting scheme for its lazy socket creation. There is nothing
> > > wrong with nldev, and now you've created some nasty BKL in the nldev
> > > code to fix rxe while ignoring its other races.
> >
> > +1
> 
> Edward, please come with a fixup on top of this since it was already
> applied
OK.

Edward


