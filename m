Return-Path: <linux-rdma+bounces-2055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DDE8B0F39
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 17:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193912982B8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A285315FD04;
	Wed, 24 Apr 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YR2Y281u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860B15F41C
	for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974263; cv=none; b=HIQISW0ZIOHhbahQpLTxxqR4aF93IBRdYvGb4FBZ0exidHqzNaTAyD4EOJlVg05Xe1mNZ06N30eEW98WSGfU6G7dn70Js2X7gRbpnZJhfI6/1R2nEx3NBHAyoYjO9ZFrv9uUdu2bi9+Oh73gJhFzKnRs8Y2epOQ+xnsOQPKa8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974263; c=relaxed/simple;
	bh=kFAZjpxk+nb50PNOEjpyicP5Hh5zXX8jQ8wDgzxHSNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROwo+85BDkTUzcXDZk7jkqmPqRbknN1zGJzR/CpvqzkCs/kqtU8L8qjJIjvSmJs7WuYOVU0Y3yMg5hK7PA0QJmVMxdGNlqL6LfycPwC9RtuPzYYISsiLV1Hu6+mmVDGqpoyDUZMTFmpd0cnSexpxMlsjFEgQyC2VK2wtuRswFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YR2Y281u; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19bf5745-1b3b-4b8a-81c2-20d945943aaf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713974258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SxqOziA6DWW4cE93s84HX/oxHi2Mzk4HdhUeHzPV5A=;
	b=YR2Y281uHC1H74U0obNuXypASM+FKdVDMg0beTExO8CWYzMd294YUlXFG2tcZPRqRyaDsy
	bZWnUjazxtnAVU2OvE7HHrKFX6LhLdXrvel5/X/Nu6/sBV2ugRxrXR7nkMFWj6rqs7w9L8
	yTn9OHocNNH8GOgYy2m0JknYTKv5PKg=
Date: Wed, 24 Apr 2024 17:57:35 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report] kmemleak in rdma_core observed during blktests
 nvme/rdma use siw
To: Yi Zhang <yi.zhang@redhat.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
References: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/4/8 8:03, Yi Zhang 写道:
> Hi
> I found the below kmemleak issue during blktests nvme/rdma on the
> latest linux-rdma/for-next, please help check it and let me know if
> you need any info/testing for it, thanks.

I have once made blktests nvme/rdma. It seems that this problem does not 
exist at that time.

So can we use "git bisec" to find the commit that cause this problem if 
this problem can be reproduced?

Just my 2 cent suggestions.

Zhu Yanjun

> 
> # dmesg | grep kmemleak
> [   67.130652] kmemleak: Kernel memory leak detector initialized (mem
> pool available: 36041)
> [   67.130728] kmemleak: Automatic memory scanning thread started
> [ 1051.771867] kmemleak: 2 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [ 1832.796189] kmemleak: 8 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [ 2578.189075] kmemleak: 17 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [ 3330.710984] kmemleak: 4 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> 
> unreferenced object 0xffff88855da53400 (size 192):
>    comm "rdma", pid 10630, jiffies 4296575922
>    hex dump (first 32 bytes):
>      37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7...............
>      10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.].....4.]....
>    backtrace (crc 47f66721):
>      [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
>      [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
>      [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]
>      [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
>      [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
>      [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_core]
>      [<ffffffffc2a3d389>] 0xffffffffc2a3d389
>      [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
>      [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
>      [<ffffffffc264648c>]
> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
>      [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
>      [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
>      [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
>      [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
>      [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
>      [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79
> 


