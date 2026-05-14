Return-Path: <linux-rdma+bounces-20666-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHpxOBt7BWp2XgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20666-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:34:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 477F053EE3E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 634DA30265BB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D7346AC1;
	Thu, 14 May 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="acJUPOhP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4312EB84E;
	Thu, 14 May 2026 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743970; cv=none; b=XJ1TlA2MIxPmRj+CQ21rzALYRbAh4RPq9o8FbntzL+nM4hBMm8V/qXHuHhdAlknF7wXbW5RQHBjQHWaISDZtMZL56I14lXforENWZPvarURkLRpvNeuonHwx+1SbmRjCMhkaOmX8qCNWvUGRsr0NaXG+26IrjfloTTyRmRg+2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743970; c=relaxed/simple;
	bh=Gcv/3TmB6X/Gim0xJr2Nc+3UIH7op0AjglJfJJVqCbQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ky9+xC9LQFgLrmcFuhVa4bSl7tTH0iq16vrpQs0qgQ7xcFWjF1Y4PGKIIU+N1wO9x10N2DEZqiKLJa4kq0Y235TnSy0+4NWAAo5DZZruVyYPZ+CG72Ec6nH1FLmWw7NrhAwpLNnD0Prm9mWLAJq2w+iVn6YGJ4hv+pLp2lM27Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=acJUPOhP; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1778743958; bh=bv/EbRAJTMl6i/tZey18uJhXGjZxaVUoJcVMqmPJVIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=acJUPOhPRkjeKp0aCp+1e5YYsY5zAb0QuMWzryQD0PMJcAFgmEldpyfUitt7GxXHL
	 rlRBy5Mz2DFt31AQc1pZ3/DMmA9RQju0Tp0LYtRjhQoVz2FrOk9JVxPDdoDfont5ai
	 BTZGfv6OlwGAseYm2WxQ8QEt8O+x0wTnKM63kL5I=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 7D60E063; Thu, 14 May 2026 15:31:22 +0800
X-QQ-mid: xmsmtpt1778743882te9r1ns07
Message-ID: <tencent_3CCD70788A6EAC2D356D4C9674E8D2EEEA0A@qq.com>
X-QQ-XMAILINFO: OOHLocUS1do2fzVZIX4VVQJ9A+Q8MPK84D4VBxiaG+wp/GBaiGy6PjcDNAtmNj
	 B0JFyCwFgUgZB8zR/oZwRONygk9JAk+Dkh7zi/02apDIAL4FSlGYZc+0liuN36DIsUHoa74d11xh
	 OQl5KKEPHc6WE/fYdwBsKv8rnkhv0CJp+F6IvdHe7a7Rby0xV5/XQmG664yxh8Iwm0NtjPCK8Y5t
	 sq8jC8kUfgPAEzTUL6WsHwY40deMThjwg1WpvARa/tUkUjXJn7OMZk9vPX+mk+V6Kv1GPs8s172F
	 uqWsvvtt2G7apNZNS/F2QCapmphd845jfrGI7wr1rteR7DRHzjICVOmimactdJr83Kd2V2PyKfT1
	 Iemxegho7o8pqUG3UeMYSlA/uc/Ckm9sbz2lFgDCbmxWSxFfbRN6UuWkb2ROF9K7j0Qe14BvxB2P
	 zAnXdtlV0JaeOONASm7ZbAx5D71V9e30/BJbhYIrmtmVi2r217HzsqxsWRedVYJMTpGkSNB2T1f9
	 BP3rNEMogUiYHhBqRT9AUPe3TblsoFVZJi3ssBlbbTKWIolpLCKYpuTx6S5UaE/5Yt0ih21br38h
	 Ho8caFTZOna6WSpRMJTd7uAChkFl0sDjcqwRbrCydyL2/qz3fjlIZZNQWFYHm1gX63ckeu8z4HH/
	 S/R2nyKQX3ZuAqhcByXjyOqHKC/SGDauJBh8JoI72R/99tTnFEyfnDIo1VDqvrfl7XpYTpVSPJAf
	 GIbIUWSp6HsgD3AtxHhfdoOnKp+Z4QqlzeBHLkW9IeAcqTs1y9uiR7OiRZt3GaJ3r1jtHWWlvs7B
	 M9kLmRf0D4itAr38DJfy60KvnVCj6HuDMT1PFp9doLUvdKfg0k4X5PyIUeusdvrZS4fW8B7+2qQE
	 3vgppMOfYW0gwsV6Qe+t/49SYPdNlrhRUDNNDa05AToDaQ2/eU2miPNi2+IiXWKuljeFI2Np34vr
	 wzVoq0bkFrsYGoL/mhG3krhPk4OYza9OJimqhekotAyMNGO29sS2+8XDazRoyQswP4YobodMov7O
	 TY+5/jgzyMF749Lqd27vVgK+ZKV/A=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
Date: Thu, 14 May 2026 15:31:22 +0800
X-OQ-MSGID: <20260514073121.414236-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513234655.GW7702@ziepe.ca>
References: <20260513234655.GW7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 477F053EE3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20666-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,qq.com,google.com,sina.com,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,linux.dev,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:mid,qq.com:dkim]
X-Rspamd-Action: no action

On Wed, 13 May 2026 20:46:55 -0300, Jason Gunthorpe wrote:
> On Wed, May 13, 2026 at 02:17:28PM -0400, Leon Romanovsky wrote:
> >
> > On Thu, 07 May 2026 20:50:10 +0800, Edward Adam Davis wrote:
> > > We must serialize calls to nldev_dellink() or risk a crash as syzbot
> > > reported:
> > >
> > > Call Trace:
> > >  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> > >  rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
> > >  rxe_sock_put drivers/infiniband/sw/rxe/rxe_net.c:639 [inline]
> > >  rxe_net_del+0xfb/0x290 drivers/infiniband/sw/rxe/rxe_net.c:660
> > >  rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] RDMA/nldev: add mutual exclusion in nldev_dellink()
> >       https://git.kernel.org/rdma/rdma/c/0b28000b64f40d
> 
> This seems like a rxe bug, I would have expected the lock to be inside
> rxe to protect its racy implementation of rxe_net_del(), which looks
> like it is possibly also triggered by NETDEV_UNREGISTER...
No, it was triggered by RDMA_NLDEV_CMD_DELLINK, you can see the "call trace".
> 
> ie it should not change nldev_dellink().
While this could be fixed within RXE, the same issue affects all other
RXE-like submodules when they subsequently support the "dellink" interface,
therefore, handling this within nldev_dellink() is relatively more appropriate.

Edward


