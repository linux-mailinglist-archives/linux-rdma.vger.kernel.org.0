Return-Path: <linux-rdma+bounces-1507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A4889AA9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70811C33486
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F201428FA;
	Mon, 25 Mar 2024 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyM+NSUH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C5143C59
	for <linux-rdma@vger.kernel.org>; Mon, 25 Mar 2024 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332694; cv=none; b=XM6zGe6o0bgUBYwx831vQBBaL9Vykas0ukIWfCkaOccRLFHQq7j1yvJd7DbZDsZYguIBtlEn+0gjDrSdQF7cgQGl6OFznf/tjP6/fW6jKoSeYcZCpY44r15C5+0BDLonukqe5d/5ZnCh/G0hDh22qDf1oAOPEIN81vMcEkSjG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332694; c=relaxed/simple;
	bh=6Upk9HpVnvdqSXAN+homYdfR9eVLX8GVlmX2hGmxejw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g6MUS5Rx+DC+0wqZ+2YhZTAPhzPUF42IvCGz0J75MnOlZdEpeW19mDKCtCviwvbdlJ7XpmLEy/ghCAcCqAOiHONEGlMhH95ylVFb5psTR2CPCncJLZlhknk5zJH1xsSR+01+ta9s7HCi4AOjr82+UlWDnh0BRHoqBacHKIJK3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyM+NSUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711332689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LZLO/mIIstkgFP8Jy9i1sdTVDL/fM4acrw4PX4Ic7og=;
	b=VyM+NSUHiiQADYbIhXGYo2XJN1p15ynwE7HXImPxmnxGvbxIkR7+3X3Kt5fCndneTy9ByV
	i8EniMdWifbGmin3iGk0V6nLAjE0QqBLruNNihxTsNVnXbh7RVF3LlXf6rwNL+zXVUWkJR
	bvK37W5NtqVQAN5XLgk3FBXfKIBgHpA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33--CUg2neLMf2YThlHn4WMmw-1; Sun, 24 Mar 2024 22:11:21 -0400
X-MC-Unique: -CUg2neLMf2YThlHn4WMmw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4751b21400so72427666b.1
        for <linux-rdma@vger.kernel.org>; Sun, 24 Mar 2024 19:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711332680; x=1711937480;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZLO/mIIstkgFP8Jy9i1sdTVDL/fM4acrw4PX4Ic7og=;
        b=GHrGR6MMw4MxW8IBvHYVbAybiXVwqy8638/m2XtWRyKlNTLrv23QPpERciyD3BrJl7
         nUoJSMHWbhUBhxrU7VvZ5pa6JlU62gVUqDsUDJuJS7hU/IawTnEvGggt61qsv33dGdCS
         g0lipFqk6+MJfeu25Nnx6FwmFXqCFuVQSZ0RE10Kjt8wZp8qjdCOY02GDSbDJXCp/2V4
         oJIkAantwGTRdpWFiExHaV352ystTQBGKB0aYbLG3S3PA9rmjuTuPJR0StFYNbqDj3mD
         F5O5JWgrZKvnfEkGgqyoLYIncrLHNIEcFjeTgaTTeXBKnXoIc9SYb/SzMxYku/764Ixd
         d9IA==
X-Forwarded-Encrypted: i=1; AJvYcCVA/I6gXlJHKBUiOGvptst238ByI+OqgWP6pF08ibeLoLrwvVvzk7kSknUp26HSqyNVn00ssUVf+RytJZzP4aq18PmSEVf1i4yRcg==
X-Gm-Message-State: AOJu0YzEunJAcjSCMDXJq6G2wMQK/JybVLz9npTUMDr5w0RODDGwornJ
	b0UWJEXYnBBV6PoqBRH3o22vrQvV9SxRuEX+Lg2ja6zETT9nqoceLnW/fPPNZnserVlEYNoCuEb
	btiocfjKOoZHVyhnLLFpseKL8cnVKNMtpE/Y04YCp1Lzb+9UGZN8zZKukJHgjtyiDwOHItd+qdv
	lFS9EUD5J8s6j38VaSuhlY5xio7kRmwEKn6Q==
X-Received: by 2002:a17:907:54b:b0:a46:e9f9:2208 with SMTP id wk11-20020a170907054b00b00a46e9f92208mr4432409ejb.3.1711332679841;
        Sun, 24 Mar 2024 19:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlvHyzb1y00a0FYKpm52OZFuMgSrNhoJRiBdIzTv8yYTOECUxWIn1dwVBxksvbNzrSvulGNb9Lk/iWgFtvNWU=
X-Received: by 2002:a17:907:54b:b0:a46:e9f9:2208 with SMTP id
 wk11-20020a170907054b00b00a46e9f92208mr4432394ejb.3.1711332679543; Sun, 24
 Mar 2024 19:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tao Liu <ltao@redhat.com>
Date: Mon, 25 Mar 2024 10:10:43 +0800
Message-ID: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
Subject: Implementing .shutdown method for efa module
To: mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, 
	jgg@ziepe.ca, leon@kernel.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Recently I experienced a kernel panic which is related to efa module
when testing kexec -l && kexec -e to switch to a new kernel on AWS
i4g.16xlarge instance.

Here is the dmesg log:

[    6.379918] systemd[1]: Mounting FUSE Control File System...
[    6.381984] systemd[1]: Mounting Kernel Configuration File System...
[    6.383918] systemd[1]: Starting Apply Kernel Variables...
[    6.385430] systemd[1]: Started Journal Service.
[    6.394221] ACPI: bus type drm_connector registered
[    6.421408] systemd-journald[1263]: Received client request to
flush runtime journal.
[    7.262543] efa 0000:00:1b.0: enabling device (0010 -> 0012)
[    7.432420] efa 0000:00:1b.0: Setup irq:191 name:efa-mgmnt@pci:0000:00:1b.0
[    7.435581] efa 0000:00:1b.0 efa_0: IB device registered
[    7.885564] random: crng init done
[    8.139857] XFS (nvme0n1p2): Mounting V5 Filesystem
d7003ecc-db6f-4bfb-bf92-60376b6a6563
[    8.265233] XFS (nvme0n1p2): Ending clean mount
[   10.555612] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

Red Hat Enterprise Linux 9.4 Beta (Plow)
Kernel 5.14.0-425.el9.aarch64 on an aarch64

ip-10-0-27-226 login: [   29.940381] kexec_core: Starting new kernel
[   30.079279] psci: CPU1 killed (polled 0 ms)
[   30.119222] psci: CPU2 killed (polled 0 ms)
[   30.199293] psci: CPU3 killed (polled 0 ms)
[   30.309214] psci: CPU4 killed (polled 0 ms)
[   30.379221] psci: CPU5 killed (polled 0 ms)
[   30.419210] psci: CPU6 killed (polled 0 ms)
[   30.489207] IRQ 191: no longer affine to CPU7
[   30.489667] psci: CPU7 killed (polled 0 ms)
..snip...
[   33.849123] psci: CPU63 killed (polled 0 ms)
[   33.849943] Bye!
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
[    0.000000] Linux version 5.14.0-417.el9.aarch64
(mockbuild@arm64-025.build.eng.bos.redhat.com) (gcc (GCC) 11.4.1
20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-42.el9) #1 SMP
PREEMPT_DYNAMIC Thu Feb 1 21:23:03 EST 2024
...snip...
[    1.012692] Freeing unused kernel memory: 6016K
[    2.370947] Checked W+X mappings: passed, no W+X pages found
[    2.370980] Run /init as init process
[    2.370982]   with arguments:
[    2.370983]     /init
[    2.370984]   with environment:
[    2.370984]     HOME=/
[    2.370985]     TERM=linux
[    2.373257] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    2.373259] CPU: 1 PID: 1 Comm: init Not tainted 5.14.0-417.el9.aarch64 #1
[    2.382240] Hardware name: Amazon EC2 i4g.16xlarge/, BIOS 1.0 11/1/2018
[    2.383814] Call trace:
[    2.384410]  dump_backtrace+0xa8/0x120
[    2.385318]  show_stack+0x1c/0x30
[    2.386124]  dump_stack_lvl+0x74/0x8c
[    2.387011]  dump_stack+0x14/0x24
[    2.387810]  panic+0x158/0x368
[    2.388553]  do_exit+0x3a8/0x3b0
[    2.389333]  do_group_exit+0x38/0xa4
[    2.390195]  get_signal+0x7a4/0x810
[    2.391044]  do_signal+0x1bc/0x260
[    2.391870]  do_notify_resume+0x108/0x210
[    2.392839]  el0_da+0x154/0x160
[    2.393603]  el0t_64_sync_handler+0xdc/0x150
[    2.394628]  el0t_64_sync+0x17c/0x180
[    2.395513] SMP: stopping secondary CPUs
[    2.396483] Kernel Offset: 0x586f04e00000 from 0xffff800008000000
[    2.397934] PHYS_OFFSET: 0x40000000
[    2.398774] CPU features: 0x0,00000101,70020143,10417a0b
[    2.400042] Memory Limit: none
[    2.400783] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

In the dmesg log, I found "[   30.489207] IRQ 191: no longer affine to
CPU7" is suspicious, which is related to efa module. After blacklist
efa module from automatic loading when bootup, the kernel panic issue
doesn't appear again.

It looks to me it is due to the efa being not properly shutdown during
kexec, so the ongoing DMA/interrupts etc overwrite the memory range.

Though the issue is reproduced on rhel's kernel, the upstream kernel
[1] doesn't have the .shutdown method implemented either. Since I'm
not very familiar with the efa driver, could you please implement the
.shutdown method in drivers/infiniband/hw/efa/efa_main.c? Thanks in
advance!

[1]: https://github.com/torvalds/linux/blob/master/drivers/infiniband/hw/efa/efa_main.c#L674

Thanks,
Tao Liu


