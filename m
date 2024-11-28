Return-Path: <linux-rdma+bounces-6141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F899DB4DA
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 10:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59BE282CD7
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA9155C8A;
	Thu, 28 Nov 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMoIifCK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE95B216
	for <linux-rdma@vger.kernel.org>; Thu, 28 Nov 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786634; cv=none; b=BLQ2U7DpCiz0DZ/AGwh0qNM7HDZg91qVkRVqe4iOhKGdfaALt+Dso1SyayWxka89/hP1cU2xsfjh4O5DqT0Nx0oyJckWXvwjCSJvBmPxQ+gFLaj4mDJI3J46p3wYCiJMsKiaj0zId2SNEORiuYGscMeL7vYQfn1p4LMb4ttP0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786634; c=relaxed/simple;
	bh=3tmPR/+msxLmmLHurGC76ex5d2ZeefijEom8MHaFhlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPTFhSlIZgjTrj/vOrjFFPePhViXJDwrFIbn2Nb7eMaB9dt+FuLZ+noD1HNFaEFFA4jbt1wDMcOA9D955sRSy3PD6Lq6wjDwtfXJIu8YaDtIGN8/PElviNcMCuqm4r8938BChfvvygiwkYjwrfkP6aTM+FnYLMqfcYy7GtQuzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMoIifCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A685C4CECE;
	Thu, 28 Nov 2024 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732786633;
	bh=3tmPR/+msxLmmLHurGC76ex5d2ZeefijEom8MHaFhlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMoIifCKNPics2lH1Vb5E1NyUWtugk7QakXYKxMxKkYe67iids15tcWAy5JwpF0xB
	 kiSrnFaS9IkhhNO48Z6Xo2uljEMuVhNyhdhn+vXO0d+/BTZbFWwpfP7DRhrgHA/vna
	 azKF97giLOwMfGl2UqsqS6aY4yipMD/ttcNjheaFgxqUbYJzvKJc5OXl0XIFbpbUGC
	 OQeTiyyM05bDg8TPl79p9jNxAL2jrcmrUORY0NboZBP+x4A7S1p+/dWcEMLJcNcB6f
	 smJgsaa/ADW7W/qWwDc0+r3bkJC9GBOfX0yEc0dKmHs+kcVlUnKxF0Z1vCiy5nmWWx
	 VVTYZDea4jAfQ==
Date: Thu, 28 Nov 2024 11:37:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 siw_query_port (2)
Message-ID: <20241128093708.GF1245331@unreal>
References: <6746eaef.050a0220.21d33d.0021.GAE@google.com>
 <BN8PR15MB251331ECA48AD10C366BFCF199282@BN8PR15MB2513.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR15MB251331ECA48AD10C366BFCF199282@BN8PR15MB2513.namprd15.prod.outlook.com>

On Wed, Nov 27, 2024 at 12:57:45PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: syzbot <syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com>
> > Sent: Wednesday, November 27, 2024 10:49 AM
> > To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org;
> > linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
> > netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com
> > Subject: [EXTERNAL] [syzbot] [rdma?] KASAN: slab-use-after-free Read in
> > siw_query_port (2)
> > 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    5d066766c5f1 net/l2tp: fix warning in l2tp_exit_net found
> > ..
> > git tree:       net
> > console output: https% 
> > 3A__syzkaller.appspot.com_x_log.txt-3Fx-
> > 3D168e8dc0580000&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4t
> > YSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx
> > 17mPmc2wtJaU4&s=6au3yUVQofLXZAr8nH0sfWV1MtQx2Z16Nk9rsXOeVFs&e=
> > kernel config:  https% 
> > 3A__syzkaller.appspot.com_x_.config-3Fx-
> > 3D83e9a7f9e94ea674&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE
> > 4tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyy
> > Hx17mPmc2wtJaU4&s=n9aCEUutAWKdDNujKIupw82TQQSlr_TZcMgisng0Xus&e=
> > dashboard link: https% 
> > 3A__syzkaller.appspot.com_bug-3Fextid-
> > 3D67a887427af54ecb7c93&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbh
> > vovE4tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vF
> > sIyyHx17mPmc2wtJaU4&s=7f-Omz7ps-pKM3jhyCcKlwMASxX_kB_Sd_pAF-Jvpxg&e=
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> > Debian) 2.40
> > syz repro:      https% 
> > 3A__syzkaller.appspot.com_x_repro.syz-3Fx-
> > 3D11355530580000&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4t
> > YSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx
> > 17mPmc2wtJaU4&s=fZra1eeMYqeDiaYg5CltF9l2fz28wKtU-yI_jEtubGg&e=
> > 
> > Downloadable assets:
> > disk image: https% 
> > 3A__storage.googleapis.com_syzbot-2Dassets_ba9b7c97759c_disk-
> > 2D5d066766.raw.xz&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4
> > tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyH
> > x17mPmc2wtJaU4&s=4ypBicdKG1ksPIkOu2OLcppS8J0vPN08wFzXHtyvNEE&e=
> > vmlinux: https% 
> > 3A__storage.googleapis.com_syzbot-2Dassets_92a30584a5ad_vmlinux-
> > 2D5d066766.xz&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4tYSb
> > qxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx17m
> > Pmc2wtJaU4&s=YyIgS6-_sljSEl3L1KN4bsGRpSJUuXDDkf1lrONXgNE&e=
> > kernel image: https% 
> > 3A__storage.googleapis.com_syzbot-2Dassets_88d717deaf07_bzImage-
> > 2D5d066766.xz&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4tYSb
> > qxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx17m
> > Pmc2wtJaU4&s=hNlNLIJQasRBAom2wakJesBp-oiI9FnXezvbtTzPW34&e=
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the
> > commit:
> > Reported-by: syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com
> > 
> > xfrm0 speed is unknown, defaulting to 1000
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in siw_query_port+0x348/0x440
> > drivers/infiniband/sw/siw/siw_verbs.c:183
> > Read of size 4 at addr ffff88802ff88038 by task kworker/0:5/5883
> > 
> > CPU: 0 UID: 0 PID: 5883 Comm: kworker/0:5 Not tainted 6.12.0-syzkaller-
> > 05491-g5d066766c5f1 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 09/13/2024
> > Workqueue: infiniband ib_cache_event_task
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0x169/0x550 mm/kasan/report.c:488
> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> >  siw_query_port+0x348/0x440 drivers/infiniband/sw/siw/siw_verbs.c:183
> >  ib_cache_update+0x1a9/0xb80 drivers/infiniband/core/cache.c:1494
> >  ib_cache_event_task+0xf3/0x1e0 drivers/infiniband/core/cache.c:1568
> >  process_one_work kernel/workqueue.c:3229 [inline]
> >  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
> >  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> > 
> 
> Here siw is getting a use-after-free when accessing the netdev in
> query_port() verb, since the netdev got free'd already. I was
> assuming the rdma core would serialize device deallocation
> and driver access accordingly. Seems not to be the case?

I would say that SIW/RXE should be converted from direct store and access
of sdev->netdev in favor of ib_device_get_netdev() and in ib_unregister_device_queued()
needs to see something like that ib_device_set_netdev(..., NULL, ...);

Thanks

