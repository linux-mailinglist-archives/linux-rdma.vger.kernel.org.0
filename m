Return-Path: <linux-rdma+bounces-7990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B8A4004E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 21:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8210C7A79DB
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19838252914;
	Fri, 21 Feb 2025 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BkLBWBkR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13E1FCD0B
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168173; cv=none; b=W0ZScaNisyYwbhbVswrcCvX6ihMWam33cHqsULEuFraznxudBUerrDPTgLKtK7Ivg9btq0x7PdJIVwl3U87v7VY7Zf+1tOFQPbw6b60zY7sriwblKuBLjKhIo08zuZu2WI8No4/a5ME01kNW3kUAQUPzjb0ffYsIVqT8eQUoHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168173; c=relaxed/simple;
	bh=ziCuF3Qs14VwHWFz3orte9U/36adlwGkxjDaRih0Y9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL6mgPaHU9tUZ/ttRyFHcDbu4jCO7RYyNMwEHtAKRztKY8O3OgKbREvQNkNFMfl5mRHWYZQCq1sI8lUhr3kwQ41DywpJuOUwaNnks3Dv/KojbIUDEZqOPF9XEFQF16jAiYFXyfZrJ1im5SJOKpUdhCvgajBJIwRZ5HeCK+CHSvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BkLBWBkR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 20:02:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740168154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDf9NdwllYzQWciAD/0BNA+3WkLMBQpFcChpqNa5lto=;
	b=BkLBWBkRjFNUbYJnDydCMl/9jPwqyth7FM+4ZmQLoyiTx6KhfLBFVO8Bjk92YaWOIbB5M6
	zwxlCoOAoh3/JPdhXy3AG6q4nZr+WefQ7BOsWz8s87bJyIXiGZd38ClLEFOGecrCh9JDfV
	QdphBi4ruYjp45OQpO4hQd0cXb/5iys=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Parav Pandit <parav@mellanox.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <Z7jb1z8WSllnFFyX@google.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gF3UC7PvVxeRcq@google.com>
 <CY8PR12MB7195D93F387845E0A7314C34DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195D93F387845E0A7314C34DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 21, 2025 at 08:03:33AM +0000, Parav Pandit wrote:
> > From: Roman Gushchin <roman.gushchin@linux.dev>
> > Sent: Friday, February 21, 2025 10:20 AM
> > 
> > On Fri, Feb 21, 2025 at 04:34:25AM +0000, Parav Pandit wrote:
> > >
> > > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > > Sent: Friday, February 21, 2025 9:56 AM
> > > >
> > > > On Fri, Feb 21, 2025 at 03:14:16AM +0000, Parav Pandit wrote:
> > > > >
> > > > > > From: Roman Gushchin <roman.gushchin@linux.dev>
> > > > > > Sent: Friday, February 21, 2025 7:36 AM
> > > > > >
> > > > > > Commit 54747231150f ("RDMA: Introduce and use
> > > > > > rdma_device_to_ibdev()") introduced rdma_device_to_ibdev()
> > > > > > helper which has to be used to obtain an ib_device pointer from a
> > device pointer.
> > > > > >
> > > > >
> > > > > > hw_stat_device_show() and hw_stat_device_store() were missed.
> > > > > >
> > > > > > It causes a NULL pointer dereference panic on an attempt to read
> > > > > > hw counters from a namespace, when the device structure is not
> > > > > > embedded into the ib_device structure.
> > > > > Do you mean net namespace other than default init_net?
> > > > > Assuming the answer is yes, some question below.
> > > > >
> > > > > > In this case casting the device pointer into the ib_device
> > > > > > pointer using container_of() is wrong.
> > > > > > Instead, rdma_device_to_ibdev() should be used, which uses the
> > > > > > back- reference (container_of(device, struct ib_core_device, dev))-
> > >owner.
> > > > > >
> > > > > > [42021.807566] BUG: kernel NULL pointer dereference, address:
> > > > > > 0000000000000028 [42021.814463] #PF: supervisor read access in
> > > > > > kernel mode [42021.819549] #PF: error_code(0x0000) - not-present
> > > > > > page [42021.824636] PGD 0 P4D 0 [42021.827145] Oops: 0000 [#1]
> > > > > > SMP PTI [42021.830598] CPU: 82 PID: 2843922 Comm: switchto-
> > defaul Kdump:
> > > > loaded
> > > > > > Tainted: G S      W I        XXX
> > > > > > [42021.841697] Hardware name: XXX [42021.849619] RIP:
> > > > > > 0010:hw_stat_device_show+0x1e/0x40 [ib_core] [42021.855362]
> > > > > > Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f
> > > > > > 44 00 00 49 89 d0 4c 8b 5e 20 48 8b 8f b8 04 00 00 48 81 c7 f0
> > > > > > fa ff ff <48> 8b
> > > > > > 41 28 48 29 ce 48 83 c6 d0 48 c1 ee 04 69 d6 ab aa aa aa 48
> > > > > > [42021.873931]
> > > > > > RSP: 0018:ffff97fe90f03da0 EFLAGS: 00010287 [42021.879108] RAX:
> > > > > > ffff9406988a8c60 RBX: ffff940e1072d438 RCX: 0000000000000000
> > > > > > [42021.886169] RDX: ffff94085f1aa000 RSI: ffff93c6cbbdbcb0 RDI:
> > > > > > ffff940c7517aef0 [42021.893230] RBP: ffff97fe90f03e70 R08:
> > > > > > ffff94085f1aa000 R09: 0000000000000000 [42021.900294] R10:
> > > > > > ffff94085f1aa000 R11: ffffffffc0775680 R12: ffffffff87ca2530
> > > > > > [42021.907355]
> > > > > > R13: ffff940651602840 R14: ffff93c6cbbdbcb0 R15:
> > > > > > ffff94085f1aa000 [42021.914418] FS:  00007fda1a3b9700(0000)
> > > > GS:ffff94453fb80000(0000)
> > > > > > knlGS:0000000000000000 [42021.922423] CS:  0010 DS: 0000 ES:
> > > > > > 0000
> > > > CR0:
> > > > > > 0000000080050033 [42021.928130] CR2: 0000000000000028 CR3:
> > > > > > 00000042dcfb8003 CR4: 00000000003726f0 [42021.935194] DR0:
> > > > > > 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > > > > > [42021.942257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > > > > 0000000000000400 [42021.949324] Call Trace:
> > > > > > [42021.951756]  <TASK>
> > > > > > [42021.953842]  [<ffffffff86c58674>] ? show_regs+0x64/0x70
> > > > > > [42021.959030] [<ffffffff86c58468>] ? __die+0x78/0xc0
> > > > > > [42021.963874]
> > > > [<ffffffff86c9ef75>] ?
> > > > > > page_fault_oops+0x2b5/0x3b0 [42021.969749]  [<ffffffff87674b92>] ?
> > > > > > exc_page_fault+0x1a2/0x3c0 [42021.975549]  [<ffffffff87801326>] ?
> > > > > > asm_exc_page_fault+0x26/0x30 [42021.981517]  [<ffffffffc0775680>]
> > ?
> > > > > > __pfx_show_hw_stats+0x10/0x10 [ib_core] [42021.988482]
> > > > > > [<ffffffffc077564e>] ? hw_stat_device_show+0x1e/0x40 [ib_core]
> > > > > > [42021.995438]  [<ffffffff86ac7f8e>] dev_attr_show+0x1e/0x50
> > > > > > [42022.000803]  [<ffffffff86a3eeb1>] sysfs_kf_seq_show+0x81/0xe0
> > > > > > [42022.006508]  [<ffffffff86a11134>] seq_read_iter+0xf4/0x410
> > > > > > [42022.011954]  [<ffffffff869f4b2e>] vfs_read+0x16e/0x2f0
> > > > > > [42022.017058] [<ffffffff869f50ee>] ksys_read+0x6e/0xe0
> > > > > > [42022.022073]  [<ffffffff8766f1ca>]
> > > > > > do_syscall_64+0x6a/0xa0 [42022.027441]  [<ffffffff8780013b>]
> > > > > > entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > > > > >
> > > > > > Fixes: 54747231150f ("RDMA: Introduce and use
> > > > > > rdma_device_to_ibdev()")
> > > > > Commit eb15c78b05bd9 eliminated hw_counters sysfs directory into
> > > > > the
> > > > net namespace.
> > > > > I don't see it created in any other net ns other than init_net
> > > > > with kernel
> > > > 6.12+.
> > > > >
> > > > > I am puzzled. Can you please explain/share the reproduction steps
> > > > > for
> > > > generating above call trace?
> > > >
> > > > Hi Parav!
> > > >
> > > > This bug was spotted in the production on a small number of
> > > > machines. They were running a 6.6-based kernel (with no changes
> > > > around this code). I don't have a reproducer (and there is no simple
> > > > way for me to reproduce the problem), but I've several core dumps
> > > > and from inspecting them it was clear that a ib_device pointer
> > > > obtained in hw_stat_device_show() was wrong. At the same time the
> > > > ib_pointer obtained in the way rdma_device_to_ibdev() works was
> > correct.
> > > >
> > > I just tried reproducing now on 6.12+ kernel manually.
> > 
> > Can you, please, share your steps? Or try the 6.6 kernel?
> >
> $ rdma system show to display 'netns shared'.
> $ ip netns add foo
> $ ip netns exec foo bash
> $ attempt to access the hw counters from the foo net namespace.

Ok, it worked well. The following commands

  $ ip netns add foo
  $ ip netns exec foo bash
  $ cat /sys/class/infiniband/mlx4_0/hw_counters/*

cause a panic on a vanilla v6.12.9 without my changes
and work perfectly fine with my patch.

Thanks!

