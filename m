Return-Path: <linux-rdma+bounces-1663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED88889183B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 12:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5E01C22668
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 11:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722908172E;
	Fri, 29 Mar 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKfq70Nt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0668060A
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713527; cv=none; b=QtyLXaEIWcZHcWHmNnGndpsyWqkAiYFcu6ftYmBmgZtVxhkOAP2G/uRaYAqNLz1bzlW7wiix7bKqLfsUGbMMRPm+ET1NuBLg5BXu1eCzkKgspcKhCj9RaD6s/Q2g/NkPTHoec9hi/ON6kntBQkMbxrk3phkKCUiRAFh0UDmHivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713527; c=relaxed/simple;
	bh=n1p0wMs8L4piS4hcZ5So+hMK4nWV0mmI7DqSki9R77Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzCdUSlMsmFT2UHdK/mF/vmzE2jB8T7TQ2C8YxiVWDhE/5nJ+s2SrC/3SHLIu+OHPVaqPNh/0Qxg6tc8ut2UvQt+vm8VTUxmnhjnAWZPwsHxlfIhCfbHUjsYcFEF4qnNY7mBRF85Og02DVFlizr59Ix0h3OUszFgVZ6rvOfEnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKfq70Nt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711713524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+LHpNPPv5r3fabbBCDIlTQ2i8Fj/aWIo5DO75zVos0=;
	b=GKfq70Nt7BXT4eMbecXQTQIKduSJdoGG4CsJbnFOoFn0POUg6O3w60uUIjGvdlGz+4Gyj8
	HUHgXyzYjX4Za+xPGQbJI9SGtkwN28JhUx+XzIo2BihgmiLYotkIOC9qQsQsbifNFlllEx
	lbUFVzmregbU0yuLWsj8uvHJwz3Myus=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-5yfYu2fUMkOZuRgwUp_FmA-1; Fri, 29 Mar 2024 07:58:42 -0400
X-MC-Unique: 5yfYu2fUMkOZuRgwUp_FmA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4751d1e7a2so79536466b.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 04:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711713521; x=1712318321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+LHpNPPv5r3fabbBCDIlTQ2i8Fj/aWIo5DO75zVos0=;
        b=aMP5tXMOz/ubj2zPzcMK86VgSoXWY6Fv+dm3ZQhqe3S+jQUYQyPfa+7A+NRsqePvXw
         hPRa8VFPnENVsWCvPpfs5Z7dpjcjrAGoPKDrYog6mc2+KrWEMhJS0REEI1OonEYVYJTg
         3JjSEgbQ4J3aQw7Dol/0WSvvrEMYKU4AEeEV26z56xeucKGGAOJ890OHw3dZoj9TxgTE
         cMZXobl5I2ldZ9uS0qH5J1w4DV7PK7j/TKYi3GNMYpYadaeNqra9ZsHaD8qb1ZDEoG4r
         5TxFJXYt80eI7zRvWE4nCYeGYuKVeVJydGBs2KmpwdsHAxLStgQj0lTQMcvUmov8Bdx2
         tLQg==
X-Forwarded-Encrypted: i=1; AJvYcCXqyxuFR2Pr5+tr1YA66qdF20c+fB/+lJbGyY4YCp3yUc7UD7MJhi+fK+njYGJLl09SzyHSCtMvAM7XdgldjM0owgPRxlwnz5kzXQ==
X-Gm-Message-State: AOJu0Yx5NSkRKi9++xX12f9jhsaRKAni8Pt8q/gUrbMe4NjxNC/763GC
	X8ZPlLodvteN9H3M63Xc4z4pZZ4Cdt5VB+t6mIDz75xUxPTyJH76PZaUA1xGaD2kVRoAUuibeCG
	Jx06LBcJDgg4/LLCpr7ngx4L20C8KWOzpzb0jYz0jwc+/2ic72qEi8pIgmllvjcRDt6VhdHOtJy
	DPhG9f5yEg0T0oliuTnIVHOdfZ3auM9UoLpw==
X-Received: by 2002:a17:906:6a20:b0:a47:4bec:a211 with SMTP id qw32-20020a1709066a2000b00a474beca211mr1956937ejc.40.1711713521418;
        Fri, 29 Mar 2024 04:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4LGq/zCNjccPlkWXMqnAQtTk5FisZJ00DlO4vf/rvLzeFUI2KtBJEPGGQwQKNh+VcNLkxHzp5ARbTRVvr0/g=
X-Received: by 2002:a17:906:6a20:b0:a47:4bec:a211 with SMTP id
 qw32-20020a1709066a2000b00a474beca211mr1956914ejc.40.1711713521006; Fri, 29
 Mar 2024 04:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev> <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
In-Reply-To: <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 29 Mar 2024 19:58:02 +0800
Message-ID: <CAO7dBbVNWmpdubvoTnVo25W=36i-O5adcLUGHOhSA7bK4NkQTA@mail.gmail.com>
Subject: Re: Implementing .shutdown method for efa module
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, sleybo@amazon.com, jgg@ziepe.ca, 
	leon@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Libing He <libhe@redhat.com>, 
	Frank Liang <xiliang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Sorry for the late reply. We spent some time to reproduce the issue on
the upstream kernel 6.9.0-rc1. I added our QE(libhe and xiliang) in
the CC list, who helped perform the test using their testing program.

On Tue, Mar 26, 2024 at 8:35=E2=80=AFPM Margolin, Michael <mrgolin@amazon.c=
om> wrote:
>
> Hi Tao,
>
> Thanks for bringing this up.
>
> I've unsuccessfully tried to reproduce this kernel panic using
> production Red Hat 9.3 AMI (5.14.0-362.18.1.el9_3.aarch64).
>
> Are there any related changes in the kernel you are testing?

We got the issue reproduced on upstream kernel 6.9.0-rc1, please see
the dmesg log as follows, however there is no suspicious "IRQ 191: no
longer affine to CPU7" string in "psci: CPUXX killed":

[    5.722007] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    5.722903] systemd[1]: Finished Load Kernel Module fuse.
[    5.723705] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    5.724421] systemd[1]: Finished Load Kernel Module drm.
[    5.725366] systemd[1]: Finished Read and set NIS domainname from
/etc/sysconfig/network.
[    5.726556] systemd[1]: Finished Load Kernel Modules.
[    5.727338] systemd[1]: Finished Generate network units from Kernel
command line.
[    5.728215] systemd[1]: Started Journal Service.
[    5.741469] systemd-journald[1198]: Received client request to
flush runtime journal.
[    6.144313] efa 0000:00:1b.0: enabling device (0010 -> 0012)
[    6.312684] efa 0000:00:1b.0: Setup irq:191 name:efa-mgmnt@pci:0000:00:1=
b.0
[    6.335149] efa 0000:00:1b.0 efa_0: IB device registered
[    6.360319] XFS (nvme3n1p2): Mounting V5 Filesystem
d7003ecc-db6f-4bfb-bf92-60376b6a6563
[    6.386816] XFS (nvme3n1p2): Ending clean mount
[   10.229126] block nvme3n1: the capability attribute has been deprecated.
[   10.557952] PEFILE: Unsigned PE binary

Red Hat Enterprise Linux 9.4 Beta (Plow)
Kernel 6.9.0-rc1 on an aarch64

ip-10-0-20-120 login: [   15.349910] PEFILE: Unsigned PE binary
[   19.601416] kexec_core: Starting new kernel
[   19.700609] psci: CPU1 killed (polled 0 ms)
[   19.750454] psci: CPU2 killed (polled 0 ms)
[   19.800416] psci: CPU3 killed (polled 0 ms)
[   19.870431] psci: CPU4 killed (polled 0 ms)
[   19.930427] psci: CPU5 killed (polled 0 ms)
[   20.000415] psci: CPU6 killed (polled 0 ms)
[   20.060417] psci: CPU7 killed (polled 0 ms)
[   20.150404] psci: CPU8 killed (polled 0 ms)
[   20.240416] psci: CPU9 killed (polled 0 ms)
[   20.310424] psci: CPU10 killed (polled 0 ms)
[   20.380418] psci: CPU11 killed (polled 0 ms)
[   20.440418] psci: CPU12 killed (polled 0 ms)
[   20.510406] psci: CPU13 killed (polled 0 ms)
[   20.570404] psci: CPU14 killed (polled 0 ms)
[   20.670406] psci: CPU15 killed (polled 0 ms)
[   20.730487] psci: CPU16 killed (polled 0 ms)
[   20.790421] psci: CPU17 killed (polled 0 ms)
[   20.890428] psci: CPU18 killed (polled 0 ms)
[   20.940423] psci: CPU19 killed (polled 0 ms)
[   20.990427] psci: CPU20 killed (polled 0 ms)
[   21.040426] psci: CPU21 killed (polled 0 ms)
[   21.090423] psci: CPU22 killed (polled 0 ms)
[   21.140406] psci: CPU23 killed (polled 0 ms)
[   21.210414] psci: CPU24 killed (polled 0 ms)
[   21.260407] psci: CPU25 killed (polled 0 ms)
[   21.320410] psci: CPU26 killed (polled 0 ms)
[   21.380412] psci: CPU27 killed (polled 0 ms)
[   21.430408] psci: CPU28 killed (polled 0 ms)
[   21.490407] psci: CPU29 killed (polled 0 ms)
[   21.540396] psci: CPU30 killed (polled 0 ms)
[   21.590385] psci: CPU31 killed (polled 0 ms)
[   21.640416] psci: CPU32 killed (polled 0 ms)
[   21.700411] psci: CPU33 killed (polled 0 ms)
[   21.750420] psci: CPU34 killed (polled 0 ms)
[   21.800408] psci: CPU35 killed (polled 0 ms)
[   21.850417] psci: CPU36 killed (polled 0 ms)
[   21.900411] psci: CPU37 killed (polled 0 ms)
[   21.960400] psci: CPU38 killed (polled 0 ms)
[   22.010399] psci: CPU39 killed (polled 0 ms)
[   22.060401] psci: CPU40 killed (polled 0 ms)
[   22.110393] psci: CPU41 killed (polled 0 ms)
[   22.160398] psci: CPU42 killed (polled 0 ms)
[   22.210407] psci: CPU43 killed (polled 0 ms)
[   22.260392] psci: CPU44 killed (polled 0 ms)
[   22.320386] psci: CPU45 killed (polled 0 ms)
[   22.370388] psci: CPU46 killed (polled 0 ms)
[   22.420815] psci: CPU47 killed (polled 0 ms)
[   22.470402] psci: CPU48 killed (polled 0 ms)
[   22.530398] psci: CPU49 killed (polled 0 ms)
[   22.600393] psci: CPU50 killed (polled 0 ms)
[   22.650395] psci: CPU51 killed (polled 0 ms)
[   22.700393] psci: CPU52 killed (polled 0 ms)
[   22.750405] psci: CPU53 killed (polled 0 ms)
[   22.800388] psci: CPU54 killed (polled 0 ms)
[   22.850397] psci: CPU55 killed (polled 0 ms)
[   22.900396] psci: CPU56 killed (polled 0 ms)
[   22.960392] psci: CPU57 killed (polled 0 ms)
[   23.010412] psci: CPU58 killed (polled 0 ms)
[   23.060426] psci: CPU59 killed (polled 0 ms)
[   23.110424] psci: CPU60 killed (polled 0 ms)
[   23.160433] psci: CPU61 killed (polled 0 ms)
[   23.210450] psci: CPU62 killed (polled 0 ms)
[   23.260485] psci: CPU63 killed (polled 0 ms)
[   23.261213] Bye!
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
[    0.000000] Linux version 6.9.0-rc1
(ec2-user@ip-10-0-31-71.us-west-2.compute.internal) (gcc (GCC) 11.4.1
20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-43.el9) #1 SMP
PREEMPT_DYNAMIC Wed Mar 27 11:54:07 UTC 2024
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS=3D0x7bed0000 SMBIOS 3.0=3D0x7beb0000
ACPI=3D0x786e0000 ACPI 2.0=3D0x786e0014 MEMATTR=3D0x7a759a98 RNG=3D0x70ea00=
18
MEMRESERVE=3D0x7857a918
...snip...
[    5.747760] SELinux:  policy capability cgroup_seclabel=3D1
[    5.748618] SELinux:  policy capability nnp_nosuid_transition=3D1
[    5.749549] SELinux:  policy capability genfs_seclabel_symlinks=3D1
[    5.750507] SELinux:  policy capability ioctl_skip_cloexec=3D0
[    5.751397] SELinux:  policy capability userspace_initial_context=3D0
[    5.755680] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000018
[    5.757055] Mem abort info:
[    5.757505]   ESR =3D 0x0000000096000004
[    5.758125]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    5.758966]   SET =3D 0, FnV =3D 0
[    5.759457]   EA =3D 0, S1PTW =3D 0
[    5.759964]   FSC =3D 0x04: level 0 translation fault
[    5.760738] Data abort info:
[    5.761197]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[    5.762062]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[    5.762866]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[    5.763709] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000406d43000
[    5.764717] [0000000000000018] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[    5.765778] Internal error: Oops: 0000000096000004 [#1] SMP
[    5.766659] Modules linked in: xfs(E) libcrc32c(E) nvme_tcp(E)
nvme_fabrics(E) crct10dif_ce(E) ghash_ce(E) sha2_ce(E) sha256_arm64(E)
sha1_ce(E) nvme(E) nvme_core(E) ena(E) sunrpc(E) dm_mirror(E)
dm_region_hash(E) dm_log(E) dm_mod(E) be2iscsi(E) cxgb4i(E) cxgb4(E)
tls(E) libcxgbi(E) libcxgb(E) qla4xxx(E) iscsi_boot_sysfs(E)
iscsi_tcp(E) libiscsi_tcp(E) libiscsi(E) scsi_transport_iscsi(E)
fuse(E)
[    5.772170] CPU: 7 PID: 1 Comm: systemd Tainted: G            E
 6.9.0-rc1 #1
[    5.773380] Hardware name: Amazon EC2 i4g.16xlarge/, BIOS 1.0 11/1/2018
[    5.774451] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    5.775595] pc : __dentry_path+0xa8/0x1c8
[    5.776266] lr : __dentry_path+0x8c/0x1c8
[    5.776929] sp : ffff80008021b8a0
[    5.777482] x29: ffff80008021b8a0 x28: ffff0003cc8f7ffe x27: ffff0003cc8=
f7fff
[    5.778640] x26: ffffba330fc39000 x25: ffffba330fc39604 x24: ffff8000802=
1b908
[    5.779799] x23: ffff0003cbff1140 x22: 000000000000002f x21: 00000000000=
00366
[    5.780971] x20: 0000000000000000 x19: 0000000000000ffe x18: fffffffffff=
fffff
[    5.782130] x17: 00000000ada0e07b x16: 00000000892a1b2a x15: 00000000000=
00010
[    5.783295] x14: 5d160d0000000000 x13: 0000000000000000 x12: 00000000000=
0002c
[    5.784467] x11: 0101010101010101 x10: 5d160d0000000000 x9 : ffffba330df=
0ee88
[    5.785623] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 00000000000=
00000
[    5.786788] x5 : fffffdffcf323dc0 x4 : 0000000000000000 x3 : 00000000000=
00000
[    5.787950] x2 : ffff0003c1451480 x1 : 0000000000000000 x0 : 00000000000=
00000
[    5.789115] Call trace:
[    5.789526]  __dentry_path+0xa8/0x1c8
[    5.790141]  dentry_path_raw+0x50/0x90
[    5.790763]  inode_doinit_with_dentry+0x310/0x520
[    5.791543]  sb_finish_set_opts+0x13c/0x358
[    5.792233]  selinux_set_mnt_opts+0x410/0x658
[    5.792957]  delayed_superblock_init+0x20/0x30
[    5.793686]  iterate_supers+0xa0/0x140
[    5.794316]  selinux_complete_init+0x28/0x88
[    5.795014]  selinux_policy_commit+0x2ac/0x2d0
[    5.795748]  sel_write_load+0x130/0x280
[    5.796386]  vfs_write+0xd8/0x360
[    5.796948]  ksys_write+0x70/0x108
[    5.797512]  __arm64_sys_write+0x20/0x30
[    5.798172]  invoke_syscall.constprop.0+0x7c/0xd0
[    5.798943]  do_el0_svc+0x4c/0xd0
[    5.799493]  el0_svc+0x44/0x1d8
[    5.800024]  el0t_64_sync_handler+0x134/0x150
[    5.800757]  el0t_64_sync+0x17c/0x180
[    5.801367] Code: 540006cd 381ff376 aa1403e0 51000673 (f9400e94)
[    5.802354] ---[ end trace 0000000000000000 ]---
[    5.803107] Kernel panic - not syncing: Oops: Fatal exception
[    5.804042] SMP: stopping secondary CPUs
[    5.804726] Kernel Offset: 0x3a328dc00000 from 0xffff800080000000
[    5.805713] PHYS_OFFSET: 0x40000000
[    5.806288] CPU features: 0x0,0000080b,80100528,42417a0b
[    5.807149] Memory Limit: none
[    5.807668] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]=
---

>
> Anyways we do need to handle shutdown properly, please let know if
> calling to efa_remove solves your issue.

We also tested the same kernel code, with " .shutdown =3D efa_remove,"
change in efa_main.c, the issue doesn't get reproduced. It looks to me
the issue can be solved by this code change, however according to
Jason, there might be problems. I'm not familiar with this, could you
please try to fix this issue? Thanks in advance!

Thanks,
Tao Liu

>
> Michael
>
> On 3/26/2024 3:38 AM, Tao Liu wrote:
> > Hi Gal,
> >
> > On Mon, Mar 25, 2024 at 4:06=E2=80=AFPM Gal Pressman <gal.pressman@linu=
x.dev> wrote:
> >> On 25/03/2024 4:10, Tao Liu wrote:
> >>> Hi,
> >>>
> >>> Recently I experienced a kernel panic which is related to efa module
> >>> when testing kexec -l && kexec -e to switch to a new kernel on AWS
> >>> i4g.16xlarge instance.
> >>>
> >>> Here is the dmesg log:
> >>>
> >>> [    6.379918] systemd[1]: Mounting FUSE Control File System...
> >>> [    6.381984] systemd[1]: Mounting Kernel Configuration File System.=
..
> >>> [    6.383918] systemd[1]: Starting Apply Kernel Variables...
> >>> [    6.385430] systemd[1]: Started Journal Service.
> >>> [    6.394221] ACPI: bus type drm_connector registered
> >>> [    6.421408] systemd-journald[1263]: Received client request to
> >>> flush runtime journal.
> >>> [    7.262543] efa 0000:00:1b.0: enabling device (0010 -> 0012)
> >>> [    7.432420] efa 0000:00:1b.0: Setup irq:191 name:efa-mgmnt@pci:000=
0:00:1b.0
> >>> [    7.435581] efa 0000:00:1b.0 efa_0: IB device registered
> >>> [    7.885564] random: crng init done
> >>> [    8.139857] XFS (nvme0n1p2): Mounting V5 Filesystem
> >>> d7003ecc-db6f-4bfb-bf92-60376b6a6563
> >>> [    8.265233] XFS (nvme0n1p2): Ending clean mount
> >>> [   10.555612] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes read=
y
> >>>
> >>> Red Hat Enterprise Linux 9.4 Beta (Plow)
> >>> Kernel 5.14.0-425.el9.aarch64 on an aarch64
> >>>
> >>> ip-10-0-27-226 login: [   29.940381] kexec_core: Starting new kernel
> >>> [   30.079279] psci: CPU1 killed (polled 0 ms)
> >>> [   30.119222] psci: CPU2 killed (polled 0 ms)
> >>> [   30.199293] psci: CPU3 killed (polled 0 ms)
> >>> [   30.309214] psci: CPU4 killed (polled 0 ms)
> >>> [   30.379221] psci: CPU5 killed (polled 0 ms)
> >>> [   30.419210] psci: CPU6 killed (polled 0 ms)
> >>> [   30.489207] IRQ 191: no longer affine to CPU7
> >>> [   30.489667] psci: CPU7 killed (polled 0 ms)
> >>> ..snip...
> >>> [   33.849123] psci: CPU63 killed (polled 0 ms)
> >>> [   33.849943] Bye!
> >>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1=
]
> >>> [    0.000000] Linux version 5.14.0-417.el9.aarch64
> >>> (mockbuild@arm64-025.build.eng.bos.redhat.com) (gcc (GCC) 11.4.1
> >>> 20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-42.el9) #1 SMP
> >>> PREEMPT_DYNAMIC Thu Feb 1 21:23:03 EST 2024
> >>> ...snip...
> >>> [    1.012692] Freeing unused kernel memory: 6016K
> >>> [    2.370947] Checked W+X mappings: passed, no W+X pages found
> >>> [    2.370980] Run /init as init process
> >>> [    2.370982]   with arguments:
> >>> [    2.370983]     /init
> >>> [    2.370984]   with environment:
> >>> [    2.370984]     HOME=3D/
> >>> [    2.370985]     TERM=3Dlinux
> >>> [    2.373257] Kernel panic - not syncing: Attempted to kill init!
> >>> exitcode=3D0x0000000b
> >>> [    2.373259] CPU: 1 PID: 1 Comm: init Not tainted 5.14.0-417.el9.aa=
rch64 #1
> >>> [    2.382240] Hardware name: Amazon EC2 i4g.16xlarge/, BIOS 1.0 11/1=
/2018
> >>> [    2.383814] Call trace:
> >>> [    2.384410]  dump_backtrace+0xa8/0x120
> >>> [    2.385318]  show_stack+0x1c/0x30
> >>> [    2.386124]  dump_stack_lvl+0x74/0x8c
> >>> [    2.387011]  dump_stack+0x14/0x24
> >>> [    2.387810]  panic+0x158/0x368
> >>> [    2.388553]  do_exit+0x3a8/0x3b0
> >>> [    2.389333]  do_group_exit+0x38/0xa4
> >>> [    2.390195]  get_signal+0x7a4/0x810
> >>> [    2.391044]  do_signal+0x1bc/0x260
> >>> [    2.391870]  do_notify_resume+0x108/0x210
> >>> [    2.392839]  el0_da+0x154/0x160
> >>> [    2.393603]  el0t_64_sync_handler+0xdc/0x150
> >>> [    2.394628]  el0t_64_sync+0x17c/0x180
> >>> [    2.395513] SMP: stopping secondary CPUs
> >>> [    2.396483] Kernel Offset: 0x586f04e00000 from 0xffff800008000000
> >>> [    2.397934] PHYS_OFFSET: 0x40000000
> >>> [    2.398774] CPU features: 0x0,00000101,70020143,10417a0b
> >>> [    2.400042] Memory Limit: none
> >>> [    2.400783] ---[ end Kernel panic - not syncing: Attempted to kill
> >>> init! exitcode=3D0x0000000b ]---
> >>>
> >>> In the dmesg log, I found "[   30.489207] IRQ 191: no longer affine t=
o
> >>> CPU7" is suspicious, which is related to efa module. After blacklist
> >>> efa module from automatic loading when bootup, the kernel panic issue
> >>> doesn't appear again.
> >>>
> >>> It looks to me it is due to the efa being not properly shutdown durin=
g
> >>> kexec, so the ongoing DMA/interrupts etc overwrite the memory range.
> >>>
> >>> Though the issue is reproduced on rhel's kernel, the upstream kernel
> >>> [1] doesn't have the .shutdown method implemented either. Since I'm
> >>> not very familiar with the efa driver, could you please implement the
> >>> .shutdown method in drivers/infiniband/hw/efa/efa_main.c? Thanks in
> >>> advance!
> >> Did you try to reproduce it on upstream kernel?
> >>
> > Thanks for your comments! No I haven't, I will give it a try.
> >>> [1]: https://github.com/torvalds/linux/blob/master/drivers/infiniband=
/hw/efa/efa_main.c#L674
> >>>
> >>> Thanks,
> >>> Tao Liu
> >>>
> >> Try assigning efa_remove as the shutdown callback:
> >>      .shutdown =3D efa_remove,
> >>
> >> Does it fix it?
> > Thanks, I will also try the code, and I will post the testing results.
> >
> > Thanks,
> > Tao Liu
> >
> >
>


