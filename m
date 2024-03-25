Return-Path: <linux-rdma+bounces-1537-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2A188A285
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 14:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B961C38D8E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED013B2BF;
	Mon, 25 Mar 2024 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PgJSqEQn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC115886D
	for <linux-rdma@vger.kernel.org>; Mon, 25 Mar 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354004; cv=none; b=Cn1y1FDOxhNfphIxuGPquFEoKBuH/M6lMiodZQ8mbUU0f7s3LRmVeD36VcCW2mNU78ovM0prnjpHKxnMdqjTWvcZBjRbtob5vDIXYtICuQtP4TJ8vQKuAJif8lRJd1YnDuo8tcrsaw4KSzkav+YdYpohhG+6h390PirJ3UV8Cqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354004; c=relaxed/simple;
	bh=pZuKPKaS/70/EEjHqPwvnuI3Nv7pHPqM7eodBdRE2D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJ7QAXT+mq56hnLGZl1CZn8kEzngYo+P3oo6btZgglM3jYu76jP7kESma45kdlJZgAQwpbOGuitgLnwystw0S8cYxu53u8/w5OnXtW5G7zItHzjt93JJ+YiDNS51aEV7HNgbNa3m1OLojLVzzE4rWtICKTVPtVbC/HqvEVfFFxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PgJSqEQn; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711353999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kUG+lsqJ1QQuFkGv5dH8HcbXqMG4qHWWB+lJs5BhUk=;
	b=PgJSqEQnlK7l3dgEAICzgenPT/R0kT+G2wPQWNj7fdwAGAfLkhZhroYVbeLWRZxZVqsISV
	nla3fzcjJbbRtnfvbWVp4ZgmVPQO4eqIBs4Voz8Ed4tfjgo1HvxyEXrv348RvRkvk+vaGr
	bt02QaFD7OIEyGVUto41e1XyYMFcSgc=
Date: Mon, 25 Mar 2024 10:06:33 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Implementing .shutdown method for efa module
To: Tao Liu <ltao@redhat.com>, mrgolin@amazon.com, sleybo@amazon.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/03/2024 4:10, Tao Liu wrote:
> Hi,
> 
> Recently I experienced a kernel panic which is related to efa module
> when testing kexec -l && kexec -e to switch to a new kernel on AWS
> i4g.16xlarge instance.
> 
> Here is the dmesg log:
> 
> [    6.379918] systemd[1]: Mounting FUSE Control File System...
> [    6.381984] systemd[1]: Mounting Kernel Configuration File System...
> [    6.383918] systemd[1]: Starting Apply Kernel Variables...
> [    6.385430] systemd[1]: Started Journal Service.
> [    6.394221] ACPI: bus type drm_connector registered
> [    6.421408] systemd-journald[1263]: Received client request to
> flush runtime journal.
> [    7.262543] efa 0000:00:1b.0: enabling device (0010 -> 0012)
> [    7.432420] efa 0000:00:1b.0: Setup irq:191 name:efa-mgmnt@pci:0000:00:1b.0
> [    7.435581] efa 0000:00:1b.0 efa_0: IB device registered
> [    7.885564] random: crng init done
> [    8.139857] XFS (nvme0n1p2): Mounting V5 Filesystem
> d7003ecc-db6f-4bfb-bf92-60376b6a6563
> [    8.265233] XFS (nvme0n1p2): Ending clean mount
> [   10.555612] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> 
> Red Hat Enterprise Linux 9.4 Beta (Plow)
> Kernel 5.14.0-425.el9.aarch64 on an aarch64
> 
> ip-10-0-27-226 login: [   29.940381] kexec_core: Starting new kernel
> [   30.079279] psci: CPU1 killed (polled 0 ms)
> [   30.119222] psci: CPU2 killed (polled 0 ms)
> [   30.199293] psci: CPU3 killed (polled 0 ms)
> [   30.309214] psci: CPU4 killed (polled 0 ms)
> [   30.379221] psci: CPU5 killed (polled 0 ms)
> [   30.419210] psci: CPU6 killed (polled 0 ms)
> [   30.489207] IRQ 191: no longer affine to CPU7
> [   30.489667] psci: CPU7 killed (polled 0 ms)
> ..snip...
> [   33.849123] psci: CPU63 killed (polled 0 ms)
> [   33.849943] Bye!
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
> [    0.000000] Linux version 5.14.0-417.el9.aarch64
> (mockbuild@arm64-025.build.eng.bos.redhat.com) (gcc (GCC) 11.4.1
> 20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-42.el9) #1 SMP
> PREEMPT_DYNAMIC Thu Feb 1 21:23:03 EST 2024
> ...snip...
> [    1.012692] Freeing unused kernel memory: 6016K
> [    2.370947] Checked W+X mappings: passed, no W+X pages found
> [    2.370980] Run /init as init process
> [    2.370982]   with arguments:
> [    2.370983]     /init
> [    2.370984]   with environment:
> [    2.370984]     HOME=/
> [    2.370985]     TERM=linux
> [    2.373257] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    2.373259] CPU: 1 PID: 1 Comm: init Not tainted 5.14.0-417.el9.aarch64 #1
> [    2.382240] Hardware name: Amazon EC2 i4g.16xlarge/, BIOS 1.0 11/1/2018
> [    2.383814] Call trace:
> [    2.384410]  dump_backtrace+0xa8/0x120
> [    2.385318]  show_stack+0x1c/0x30
> [    2.386124]  dump_stack_lvl+0x74/0x8c
> [    2.387011]  dump_stack+0x14/0x24
> [    2.387810]  panic+0x158/0x368
> [    2.388553]  do_exit+0x3a8/0x3b0
> [    2.389333]  do_group_exit+0x38/0xa4
> [    2.390195]  get_signal+0x7a4/0x810
> [    2.391044]  do_signal+0x1bc/0x260
> [    2.391870]  do_notify_resume+0x108/0x210
> [    2.392839]  el0_da+0x154/0x160
> [    2.393603]  el0t_64_sync_handler+0xdc/0x150
> [    2.394628]  el0t_64_sync+0x17c/0x180
> [    2.395513] SMP: stopping secondary CPUs
> [    2.396483] Kernel Offset: 0x586f04e00000 from 0xffff800008000000
> [    2.397934] PHYS_OFFSET: 0x40000000
> [    2.398774] CPU features: 0x0,00000101,70020143,10417a0b
> [    2.400042] Memory Limit: none
> [    2.400783] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
> 
> In the dmesg log, I found "[   30.489207] IRQ 191: no longer affine to
> CPU7" is suspicious, which is related to efa module. After blacklist
> efa module from automatic loading when bootup, the kernel panic issue
> doesn't appear again.
> 
> It looks to me it is due to the efa being not properly shutdown during
> kexec, so the ongoing DMA/interrupts etc overwrite the memory range.
> 
> Though the issue is reproduced on rhel's kernel, the upstream kernel
> [1] doesn't have the .shutdown method implemented either. Since I'm
> not very familiar with the efa driver, could you please implement the
> .shutdown method in drivers/infiniband/hw/efa/efa_main.c? Thanks in
> advance!

Did you try to reproduce it on upstream kernel?

> 
> [1]: https://github.com/torvalds/linux/blob/master/drivers/infiniband/hw/efa/efa_main.c#L674
> 
> Thanks,
> Tao Liu
> 

Try assigning efa_remove as the shutdown callback:
    .shutdown = efa_remove,

Does it fix it?

