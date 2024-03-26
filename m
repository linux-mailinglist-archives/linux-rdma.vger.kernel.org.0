Return-Path: <linux-rdma+bounces-1566-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B4688C231
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 13:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAC730002E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 12:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D12E3E0;
	Tue, 26 Mar 2024 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rbvwCW0J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC41879;
	Tue, 26 Mar 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456500; cv=none; b=pa31qnGQDATPK6zMSNJbXP1VIi42qhBplKF9hpq2OgQthjAQXyG16NMGA6HcRkg9DYFx04iPv57ListN23dePCC11ihOkUGXsn2XJ22RkmAXpgqA3LCMFKhVt9NOnALGtoeEVnwFEQyhH6ewZ7fNx34P4H03bQn71wAj0DhLRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456500; c=relaxed/simple;
	bh=Zr48gZ+iMtiZUMEn2j/4Ms/L/2+GuhX7mRUEzUTza5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qlh4dk/Ju4h1yQrK7iACos6sxexN+cJ20LXpJziKgwawUB7hrihGAOARVRC3UU+a/LSAipCBppx8+03r0CzhD7auesA7LlV6J8mIgVXOjPPAheDoOJVyMZEWo0BKeGGcd9OJu6JfPaH/ODjCdLMHI6gAq1v7kCg0eaqxn2GLpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rbvwCW0J; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711456500; x=1742992500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mRQbNSw2E83MSaXvm8O7UtJ5JtXj8itcmTN7uuFR/aQ=;
  b=rbvwCW0JuqarDbI5AApkio/mYiSYZUtFOr1zEGmn2Ll1oV08PfJxq6vn
   7jR7mmu0Xhu7YxU7Kh/3cHNBQYLjoKaiUQzsz87+c4LTktXg1OyGXR/Cj
   E0k8bdkevuO+P5/VIkvE8hPMAG9gQIuyo3YFK9UxNbT0Ax3AXCfjM0TrK
   8=;
X-IronPort-AV: E=Sophos;i="6.07,156,1708387200"; 
   d="scan'208";a="390593410"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 12:34:56 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:54885]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.153:2525] with esmtp (Farcaster)
 id 1431dfb6-3a84-49e8-b598-f34b07be410d; Tue, 26 Mar 2024 12:34:54 +0000 (UTC)
X-Farcaster-Flow-ID: 1431dfb6-3a84-49e8-b598-f34b07be410d
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 12:34:54 +0000
Received: from [192.168.79.84] (10.85.143.175) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 12:34:50 +0000
Message-ID: <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
Date: Tue, 26 Mar 2024 14:34:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Implementing .shutdown method for efa module
Content-Language: en-US
To: Tao Liu <ltao@redhat.com>, Gal Pressman <gal.pressman@linux.dev>
CC: <sleybo@amazon.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
 <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Hi Tao,

Thanks for bringing this up.

I've unsuccessfully tried to reproduce this kernel panic using 
production Red Hat 9.3 AMI (5.14.0-362.18.1.el9_3.aarch64).

Are there any related changes in the kernel you are testing?

Anyways we do need to handle shutdown properly, please let know if 
calling to efa_remove solves your issue.

Michael

On 3/26/2024 3:38 AM, Tao Liu wrote:
> Hi Gal,
>
> On Mon, Mar 25, 2024 at 4:06 PM Gal Pressman <gal.pressman@linux.dev> wrote:
>> On 25/03/2024 4:10, Tao Liu wrote:
>>> Hi,
>>>
>>> Recently I experienced a kernel panic which is related to efa module
>>> when testing kexec -l && kexec -e to switch to a new kernel on AWS
>>> i4g.16xlarge instance.
>>>
>>> Here is the dmesg log:
>>>
>>> [    6.379918] systemd[1]: Mounting FUSE Control File System...
>>> [    6.381984] systemd[1]: Mounting Kernel Configuration File System...
>>> [    6.383918] systemd[1]: Starting Apply Kernel Variables...
>>> [    6.385430] systemd[1]: Started Journal Service.
>>> [    6.394221] ACPI: bus type drm_connector registered
>>> [    6.421408] systemd-journald[1263]: Received client request to
>>> flush runtime journal.
>>> [    7.262543] efa 0000:00:1b.0: enabling device (0010 -> 0012)
>>> [    7.432420] efa 0000:00:1b.0: Setup irq:191 name:efa-mgmnt@pci:0000:00:1b.0
>>> [    7.435581] efa 0000:00:1b.0 efa_0: IB device registered
>>> [    7.885564] random: crng init done
>>> [    8.139857] XFS (nvme0n1p2): Mounting V5 Filesystem
>>> d7003ecc-db6f-4bfb-bf92-60376b6a6563
>>> [    8.265233] XFS (nvme0n1p2): Ending clean mount
>>> [   10.555612] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>>>
>>> Red Hat Enterprise Linux 9.4 Beta (Plow)
>>> Kernel 5.14.0-425.el9.aarch64 on an aarch64
>>>
>>> ip-10-0-27-226 login: [   29.940381] kexec_core: Starting new kernel
>>> [   30.079279] psci: CPU1 killed (polled 0 ms)
>>> [   30.119222] psci: CPU2 killed (polled 0 ms)
>>> [   30.199293] psci: CPU3 killed (polled 0 ms)
>>> [   30.309214] psci: CPU4 killed (polled 0 ms)
>>> [   30.379221] psci: CPU5 killed (polled 0 ms)
>>> [   30.419210] psci: CPU6 killed (polled 0 ms)
>>> [   30.489207] IRQ 191: no longer affine to CPU7
>>> [   30.489667] psci: CPU7 killed (polled 0 ms)
>>> ..snip...
>>> [   33.849123] psci: CPU63 killed (polled 0 ms)
>>> [   33.849943] Bye!
>>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
>>> [    0.000000] Linux version 5.14.0-417.el9.aarch64
>>> (mockbuild@arm64-025.build.eng.bos.redhat.com) (gcc (GCC) 11.4.1
>>> 20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-42.el9) #1 SMP
>>> PREEMPT_DYNAMIC Thu Feb 1 21:23:03 EST 2024
>>> ...snip...
>>> [    1.012692] Freeing unused kernel memory: 6016K
>>> [    2.370947] Checked W+X mappings: passed, no W+X pages found
>>> [    2.370980] Run /init as init process
>>> [    2.370982]   with arguments:
>>> [    2.370983]     /init
>>> [    2.370984]   with environment:
>>> [    2.370984]     HOME=/
>>> [    2.370985]     TERM=linux
>>> [    2.373257] Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x0000000b
>>> [    2.373259] CPU: 1 PID: 1 Comm: init Not tainted 5.14.0-417.el9.aarch64 #1
>>> [    2.382240] Hardware name: Amazon EC2 i4g.16xlarge/, BIOS 1.0 11/1/2018
>>> [    2.383814] Call trace:
>>> [    2.384410]  dump_backtrace+0xa8/0x120
>>> [    2.385318]  show_stack+0x1c/0x30
>>> [    2.386124]  dump_stack_lvl+0x74/0x8c
>>> [    2.387011]  dump_stack+0x14/0x24
>>> [    2.387810]  panic+0x158/0x368
>>> [    2.388553]  do_exit+0x3a8/0x3b0
>>> [    2.389333]  do_group_exit+0x38/0xa4
>>> [    2.390195]  get_signal+0x7a4/0x810
>>> [    2.391044]  do_signal+0x1bc/0x260
>>> [    2.391870]  do_notify_resume+0x108/0x210
>>> [    2.392839]  el0_da+0x154/0x160
>>> [    2.393603]  el0t_64_sync_handler+0xdc/0x150
>>> [    2.394628]  el0t_64_sync+0x17c/0x180
>>> [    2.395513] SMP: stopping secondary CPUs
>>> [    2.396483] Kernel Offset: 0x586f04e00000 from 0xffff800008000000
>>> [    2.397934] PHYS_OFFSET: 0x40000000
>>> [    2.398774] CPU features: 0x0,00000101,70020143,10417a0b
>>> [    2.400042] Memory Limit: none
>>> [    2.400783] ---[ end Kernel panic - not syncing: Attempted to kill
>>> init! exitcode=0x0000000b ]---
>>>
>>> In the dmesg log, I found "[   30.489207] IRQ 191: no longer affine to
>>> CPU7" is suspicious, which is related to efa module. After blacklist
>>> efa module from automatic loading when bootup, the kernel panic issue
>>> doesn't appear again.
>>>
>>> It looks to me it is due to the efa being not properly shutdown during
>>> kexec, so the ongoing DMA/interrupts etc overwrite the memory range.
>>>
>>> Though the issue is reproduced on rhel's kernel, the upstream kernel
>>> [1] doesn't have the .shutdown method implemented either. Since I'm
>>> not very familiar with the efa driver, could you please implement the
>>> .shutdown method in drivers/infiniband/hw/efa/efa_main.c? Thanks in
>>> advance!
>> Did you try to reproduce it on upstream kernel?
>>
> Thanks for your comments! No I haven't, I will give it a try.
>>> [1]: https://github.com/torvalds/linux/blob/master/drivers/infiniband/hw/efa/efa_main.c#L674
>>>
>>> Thanks,
>>> Tao Liu
>>>
>> Try assigning efa_remove as the shutdown callback:
>>      .shutdown = efa_remove,
>>
>> Does it fix it?
> Thanks, I will also try the code, and I will post the testing results.
>
> Thanks,
> Tao Liu
>
>

