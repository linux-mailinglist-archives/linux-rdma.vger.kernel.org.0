Return-Path: <linux-rdma+bounces-1559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BECA88B6F9
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 02:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72521F3B470
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 01:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A005B2110E;
	Tue, 26 Mar 2024 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeLR3mjN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293B1C6BE
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417156; cv=none; b=iPaI3VCf245E59hIGIuyGfFSubRKDs93rnwTfgfgD7jyb/hC8Eda77YhMcE5gXlAOfsHx5wM6nHIhVzWR0axEbQHaxdLbaGsBF9ToWO9Knjv6Bcyk0nQ4//M+e32o6EChbsv4VK+ZYPpH2n3o6MSMDj9r9bv7ZG2TjwdA8w0wAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417156; c=relaxed/simple;
	bh=ozN5T78X/8LPjCWi2AnyTnIYDZmkjh80Ju6ZW4H2//U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoiIUPiz28WeOO1eZQH39wU0zD7HX9CDodETvKEGrXoC4aM3zKcUho/zM4g462SjXLvjZD3fU1uOJRQIKw3Rh/aXldKl9hMo6ASFKB3Nvfmhke9Af1Z/BcvloTsI6vxnEJhQa4ZnHQJIyepdXDSHpkYY16F0nXEJiQOXVL/v4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eeLR3mjN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711417153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTaD6mudg7VhN+d5uv+mspRcpmC/ctCIgx4dGqOcYps=;
	b=eeLR3mjNt/8vZD/op0V2xrWfeyHNBoAdyc19DhJvqEMY9+YKNkGhYaWNwNTop33JzO/4zl
	JO5kr8w7yPr6lkSx8g2c83bBdUCdfsDNA8iyJ0zKUHyq6prQmy1oZ1cnVLBrnzP+SYO3sM
	4wO27W2lgdk3FRKTEPdxaORubQ8aJdE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-MSS6yFc1MUmSo8plbFHU_Q-1; Mon, 25 Mar 2024 21:39:11 -0400
X-MC-Unique: MSS6yFc1MUmSo8plbFHU_Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d8d208be9so3407958f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Mar 2024 18:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711417150; x=1712021950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTaD6mudg7VhN+d5uv+mspRcpmC/ctCIgx4dGqOcYps=;
        b=jL1nE5f7kWdk9mjRHVPVRUJSHbP3nl9MSM0nimFUZW/pAksNU9ZrJDJcSrwcbv2Wui
         /sr+rphSw/IWfVEtkNg27c/1JugYOhG6t+ubwaSonf9548db+f1KkQipYblbxxpWj6Oi
         JtvdJmzY6RZOnn7kk3qPP47PzdzMv3GYfNT49+6eMvvhLhrX6FHYEJMs63Pt2b8Nclme
         JFpOlyJGzqkaJ2XaGL9KhrhsfFDn7qXjAwwYp5eva2i0TPZkGld9K/KAAnvbPSyMCmil
         z8FUfwySMoNqsVcMGn4i67Ec7k3EjES+KLP5s/xXO7R6el7kNxSh7ESGDx+k2qkA+p0G
         KLIA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8inpdPbi4Fw9X7zJmy+8UpnN0SA45fsMDJqF0+UJxb1CTRyvABr2l/u6JwjtKLsOQPcm1osN0jCTRPCIFgtwvf0LQjgh0/SXSw==
X-Gm-Message-State: AOJu0Yy4AFjTMjZ5Gj6bWlwS1Blc3gfkViG7kInqWQqvldRf1HHindtY
	I1UPPDlAN1vHNvKYVmPgKh7XYe6sS1+63bZuJqMWUjfhGEX8o8E7NybygMQDBsqUggoO86A4lDx
	zmL+DhiXiijWYHXOZwnkq51VYqnp3PrraZso5oBT72IXNei1ZcVC96yj0YDkIdPbM25SSdVDNk/
	ziHwx7cSoq3xyje2grKeC1LQVaTjSxOzZKHQ==
X-Received: by 2002:a5d:60c9:0:b0:341:865b:65c9 with SMTP id x9-20020a5d60c9000000b00341865b65c9mr7571758wrt.22.1711417150412;
        Mon, 25 Mar 2024 18:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGAVRQvSolwKhN9lxaw7HUOTpaQxkO72OCZv+7YVENFG33vSWYVqDPTA5Pq/1JgP4Gbiom3nqQHbE/DxEgqA8=
X-Received: by 2002:a5d:60c9:0:b0:341:865b:65c9 with SMTP id
 x9-20020a5d60c9000000b00341865b65c9mr7571746wrt.22.1711417150064; Mon, 25 Mar
 2024 18:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
In-Reply-To: <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 26 Mar 2024 09:38:33 +0800
Message-ID: <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
Subject: Re: Implementing .shutdown method for efa module
To: Gal Pressman <gal.pressman@linux.dev>
Cc: mrgolin@amazon.com, sleybo@amazon.com, jgg@ziepe.ca, leon@kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gal,

On Mon, Mar 25, 2024 at 4:06=E2=80=AFPM Gal Pressman <gal.pressman@linux.de=
v> wrote:
>
> On 25/03/2024 4:10, Tao Liu wrote:
> > Hi,
> >
> > Recently I experienced a kernel panic which is related to efa module
> > when testing kexec -l && kexec -e to switch to a new kernel on AWS
> > i4g.16xlarge instance.
> >
> > Here is the dmesg log:
> >
> > [    6.379918] systemd[1]: Mounting FUSE Control File System...
> > [    6.381984] systemd[1]: Mounting Kernel Configuration File System...
> > [    6.383918] systemd[1]: Starting Apply Kernel Variables...
> > [    6.385430] systemd[1]: Started Journal Service.
> > [    6.394221] ACPI: bus type drm_connector registered
> > [    6.421408] systemd-journald[1263]: Received client request to
> > flush runtime journal.
> > [    7.262543] efa 0000:00:1b.0: enabling device (0010 -> 0012)
> > [    7.432420] efa 0000:00:1b.0: Setup irq:191 name:efa-mgmnt@pci:0000:=
00:1b.0
> > [    7.435581] efa 0000:00:1b.0 efa_0: IB device registered
> > [    7.885564] random: crng init done
> > [    8.139857] XFS (nvme0n1p2): Mounting V5 Filesystem
> > d7003ecc-db6f-4bfb-bf92-60376b6a6563
> > [    8.265233] XFS (nvme0n1p2): Ending clean mount
> > [   10.555612] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> >
> > Red Hat Enterprise Linux 9.4 Beta (Plow)
> > Kernel 5.14.0-425.el9.aarch64 on an aarch64
> >
> > ip-10-0-27-226 login: [   29.940381] kexec_core: Starting new kernel
> > [   30.079279] psci: CPU1 killed (polled 0 ms)
> > [   30.119222] psci: CPU2 killed (polled 0 ms)
> > [   30.199293] psci: CPU3 killed (polled 0 ms)
> > [   30.309214] psci: CPU4 killed (polled 0 ms)
> > [   30.379221] psci: CPU5 killed (polled 0 ms)
> > [   30.419210] psci: CPU6 killed (polled 0 ms)
> > [   30.489207] IRQ 191: no longer affine to CPU7
> > [   30.489667] psci: CPU7 killed (polled 0 ms)
> > ..snip...
> > [   33.849123] psci: CPU63 killed (polled 0 ms)
> > [   33.849943] Bye!
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
> > [    0.000000] Linux version 5.14.0-417.el9.aarch64
> > (mockbuild@arm64-025.build.eng.bos.redhat.com) (gcc (GCC) 11.4.1
> > 20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-42.el9) #1 SMP
> > PREEMPT_DYNAMIC Thu Feb 1 21:23:03 EST 2024
> > ...snip...
> > [    1.012692] Freeing unused kernel memory: 6016K
> > [    2.370947] Checked W+X mappings: passed, no W+X pages found
> > [    2.370980] Run /init as init process
> > [    2.370982]   with arguments:
> > [    2.370983]     /init
> > [    2.370984]   with environment:
> > [    2.370984]     HOME=3D/
> > [    2.370985]     TERM=3Dlinux
> > [    2.373257] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=3D0x0000000b
> > [    2.373259] CPU: 1 PID: 1 Comm: init Not tainted 5.14.0-417.el9.aarc=
h64 #1
> > [    2.382240] Hardware name: Amazon EC2 i4g.16xlarge/, BIOS 1.0 11/1/2=
018
> > [    2.383814] Call trace:
> > [    2.384410]  dump_backtrace+0xa8/0x120
> > [    2.385318]  show_stack+0x1c/0x30
> > [    2.386124]  dump_stack_lvl+0x74/0x8c
> > [    2.387011]  dump_stack+0x14/0x24
> > [    2.387810]  panic+0x158/0x368
> > [    2.388553]  do_exit+0x3a8/0x3b0
> > [    2.389333]  do_group_exit+0x38/0xa4
> > [    2.390195]  get_signal+0x7a4/0x810
> > [    2.391044]  do_signal+0x1bc/0x260
> > [    2.391870]  do_notify_resume+0x108/0x210
> > [    2.392839]  el0_da+0x154/0x160
> > [    2.393603]  el0t_64_sync_handler+0xdc/0x150
> > [    2.394628]  el0t_64_sync+0x17c/0x180
> > [    2.395513] SMP: stopping secondary CPUs
> > [    2.396483] Kernel Offset: 0x586f04e00000 from 0xffff800008000000
> > [    2.397934] PHYS_OFFSET: 0x40000000
> > [    2.398774] CPU features: 0x0,00000101,70020143,10417a0b
> > [    2.400042] Memory Limit: none
> > [    2.400783] ---[ end Kernel panic - not syncing: Attempted to kill
> > init! exitcode=3D0x0000000b ]---
> >
> > In the dmesg log, I found "[   30.489207] IRQ 191: no longer affine to
> > CPU7" is suspicious, which is related to efa module. After blacklist
> > efa module from automatic loading when bootup, the kernel panic issue
> > doesn't appear again.
> >
> > It looks to me it is due to the efa being not properly shutdown during
> > kexec, so the ongoing DMA/interrupts etc overwrite the memory range.
> >
> > Though the issue is reproduced on rhel's kernel, the upstream kernel
> > [1] doesn't have the .shutdown method implemented either. Since I'm
> > not very familiar with the efa driver, could you please implement the
> > .shutdown method in drivers/infiniband/hw/efa/efa_main.c? Thanks in
> > advance!
>
> Did you try to reproduce it on upstream kernel?
>
Thanks for your comments! No I haven't, I will give it a try.
> >
> > [1]: https://github.com/torvalds/linux/blob/master/drivers/infiniband/h=
w/efa/efa_main.c#L674
> >
> > Thanks,
> > Tao Liu
> >
>
> Try assigning efa_remove as the shutdown callback:
>     .shutdown =3D efa_remove,
>
> Does it fix it?

Thanks, I will also try the code, and I will post the testing results.

Thanks,
Tao Liu

>


