Return-Path: <linux-rdma+bounces-6238-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2F69E3CAE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 15:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29450282BD0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABEF1FF7B8;
	Wed,  4 Dec 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDuKmwJD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF351FECDC
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322466; cv=none; b=OGmk7omQTA827KPQILv1+vz2cJT43HXSPkcpopSfiVjc4emNRjuu897bpQTPgi0a7O6rebUQp5c80dku+VSl9TdS0RTqXVk6GT31E7vSkA2fVA69LqKPAxh+EbnOvBvoUAwgiYrbTLZXhUrlkAnrlv7sY3Yz+EmsNjGYA6Wbo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322466; c=relaxed/simple;
	bh=DzYsh2aZBp2qaaBnLZS62U94J7tp0AlwX5DuEGjQWRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVO9W+0gCQrMPLPSvs47CMEW2eN1j27hJF2rxIloL3ya3fk7RNK1ug0I9S9Q6tF6ZQzOL7lBYOVHBVLl0VnxpEiXQvxNFYqCmcnpy44KNdYGqKJ68KZDiw7zJ/gsfvkI1rhH12ee91nXSJBxK7Lwx6CSQcLLNE5MTEnpjiGC08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDuKmwJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8B9C4CECD;
	Wed,  4 Dec 2024 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733322465;
	bh=DzYsh2aZBp2qaaBnLZS62U94J7tp0AlwX5DuEGjQWRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDuKmwJDpW+tt4HHmRJrTxAxyqp14Cz+K4D+FjIy+cwqt5UUv6cGeGJcuDU8kYfMm
	 C7l4V0grIxt3Gz552HteDjyhfBn8LIBhOcP7LuO2Pc9kkqVfh6Lv5zLrzHbFJRpqHn
	 MpHAfaw1OCqFzrsy8JftwsWkJIbOzKpC//wcEatYYoEhHApR92yrYxaUWAAhmervda
	 ueUDGg6pJOmmiruGdxXEXYoypMfxa6uwU59BS0qgLCULal2dPSRx2Q476rAPzQt0gD
	 nOqNxeq239axujiLVKyIfCYdR1d2coZRL75eDpk7CP9mDOdZ4BNqIXpzRFFop9PPw1
	 IuWZfc7ljV/EQ==
Date: Wed, 4 Dec 2024 16:27:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 siw_query_port (2)
Message-ID: <20241204142741.GQ1245331@unreal>
References: <6746eaef.050a0220.21d33d.0021.GAE@google.com>
 <BN8PR15MB251331ECA48AD10C366BFCF199282@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20241128093708.GF1245331@unreal>
 <BN8PR15MB25132C47CC184BFAFB22CE3199352@BN8PR15MB2513.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR15MB25132C47CC184BFAFB22CE3199352@BN8PR15MB2513.namprd15.prod.outlook.com>

On Mon, Dec 02, 2024 at 05:08:04PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Thursday, November 28, 2024 10:37 AM
> > To: Bernard Metzler <BMT@zurich.ibm.com>
> > Cc: jgg@ziepe.ca; linux-rdma@vger.kernel.org; zyjzyj2000@gmail.com
> > Subject: [EXTERNAL] Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
> > siw_query_port (2)
> > 
> > On Wed, Nov 27, 2024 at 12:57:45PM +0000, Bernard Metzler wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: syzbot <syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com>
> > > > Sent: Wednesday, November 27, 2024 10:49 AM
> > > > To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca;
> > leon@kernel.org;
> > > > linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
> > > > netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com
> > > > Subject: [EXTERNAL] [syzbot] [rdma?] KASAN: slab-use-after-free Read in
> > > > siw_query_port (2)
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    5d066766c5f1 net/l2tp: fix warning in l2tp_exit_net
> > found
> > > > ..
> > > > git tree:       net
> > > > console output: https%
> > > > 3A__syzkaller.appspot.com_x_log.txt-3Fx-
> > > >
> > 3D168e8dc0580000&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4t
> > > >
> > YSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx
> > > > 17mPmc2wtJaU4&s=6au3yUVQofLXZAr8nH0sfWV1MtQx2Z16Nk9rsXOeVFs&e=
> > > > kernel config:  https%
> > > > 3A__syzkaller.appspot.com_x_.config-3Fx-
> > > >
> > 3D83e9a7f9e94ea674&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE
> > > >
> > 4tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyy
> > > > Hx17mPmc2wtJaU4&s=n9aCEUutAWKdDNujKIupw82TQQSlr_TZcMgisng0Xus&e=
> > > > dashboard link: https%
> > > > 3A__syzkaller.appspot.com_bug-3Fextid-
> > > >
> > 3D67a887427af54ecb7c93&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbh
> > > >
> > vovE4tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vF
> > > > sIyyHx17mPmc2wtJaU4&s=7f-Omz7ps-pKM3jhyCcKlwMASxX_kB_Sd_pAF-Jvpxg&e=
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> > > > Debian) 2.40
> > > > syz repro:      https%
> > > > 3A__syzkaller.appspot.com_x_repro.syz-3Fx-
> > > >
> > 3D11355530580000&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4t
> > > >
> > YSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx
> > > > 17mPmc2wtJaU4&s=fZra1eeMYqeDiaYg5CltF9l2fz28wKtU-yI_jEtubGg&e=
> > > >
> > > > Downloadable assets:
> > > > disk image: https%
> > > > 3A__storage.googleapis.com_syzbot-2Dassets_ba9b7c97759c_disk-
> > > >
> > 2D5d066766.raw.xz&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4
> > > >
> > tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyH
> > > > x17mPmc2wtJaU4&s=4ypBicdKG1ksPIkOu2OLcppS8J0vPN08wFzXHtyvNEE&e=
> > > > vmlinux: https%
> > > > 3A__storage.googleapis.com_syzbot-2Dassets_92a30584a5ad_vmlinux-
> > > >
> > 2D5d066766.xz&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4tYSb
> > > >
> > qxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx17m
> > > > Pmc2wtJaU4&s=YyIgS6-_sljSEl3L1KN4bsGRpSJUuXDDkf1lrONXgNE&e=
> > > > kernel image: https%
> > > > 3A__storage.googleapis.com_syzbot-2Dassets_88d717deaf07_bzImage-
> > > >
> > 2D5d066766.xz&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4tYSb
> > > >
> > qxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx17m
> > > > Pmc2wtJaU4&s=hNlNLIJQasRBAom2wakJesBp-oiI9FnXezvbtTzPW34&e=
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the
> > > > commit:
> > > > Reported-by: syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com
> > > >
> > > > xfrm0 speed is unknown, defaulting to 1000
> > > > ==================================================================
> > > > BUG: KASAN: slab-use-after-free in siw_query_port+0x348/0x440
> > > > drivers/infiniband/sw/siw/siw_verbs.c:183
> > > > Read of size 4 at addr ffff88802ff88038 by task kworker/0:5/5883
> > > >
> > > > CPU: 0 UID: 0 PID: 5883 Comm: kworker/0:5 Not tainted 6.12.0-syzkaller-
> > > > 05491-g5d066766c5f1 #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 09/13/2024
> > > > Workqueue: infiniband ib_cache_event_task
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:94 [inline]
> > > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> > > >  print_address_description mm/kasan/report.c:377 [inline]
> > > >  print_report+0x169/0x550 mm/kasan/report.c:488
> > > >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> > > >  siw_query_port+0x348/0x440 drivers/infiniband/sw/siw/siw_verbs.c:183
> > > >  ib_cache_update+0x1a9/0xb80 drivers/infiniband/core/cache.c:1494
> > > >  ib_cache_event_task+0xf3/0x1e0 drivers/infiniband/core/cache.c:1568
> > > >  process_one_work kernel/workqueue.c:3229 [inline]
> > > >  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
> > > >  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> > > >  kthread+0x2f0/0x390 kernel/kthread.c:389
> > > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > >  </TASK>
> > > >
> > >
> > > Here siw is getting a use-after-free when accessing the netdev in
> > > query_port() verb, since the netdev got free'd already. I was
> > > assuming the rdma core would serialize device deallocation
> > > and driver access accordingly. Seems not to be the case?
> > 
> > I would say that SIW/RXE should be converted from direct store and access
> > of sdev->netdev in favor of ib_device_get_netdev() and in
> > ib_unregister_device_queued()
> > needs to see something like that ib_device_set_netdev(..., NULL, ...);
> > 
> 
> Makes sense. There is no good reason to keep the netdev
> pointer around in the driver, even worse without having
> a hold on it.
> 
> From netdev siw only needs MTU and ifindex information. I assume
> netdev's ifindex will not change (?), and MTU changes can be
> captured in the netdev notifier upcall. So probably simplest
> to just keep that information around in the driver - MTU to
> satisfy query_port(), query_qp() and restrict wildcard listen
> calls to the current device (ifindex needed here).

ifindex is stable.

> 
> Thanks,
> Bernard.
> 
> 
> > Thanks

