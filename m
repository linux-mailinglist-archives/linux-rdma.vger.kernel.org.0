Return-Path: <linux-rdma+bounces-9973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01451AA97C0
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 17:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06A4179671
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0990B2627E5;
	Mon,  5 May 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB1axkxy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59725E458
	for <linux-rdma@vger.kernel.org>; Mon,  5 May 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459901; cv=none; b=b+UoeLIPdvEHeMKiKQ/3mPDs31HUyQkgWbdJiiD5r0jkR0JQRTWkoah74R2q7m+Ow2uG8QEWL89MTmRrnq+hVZvGEJhV3624W5fpXoOQYGK8B52lG1C2kKE9kf3sSCgCjmT6ugxuwYddZCxuoBOEp7M8WPKVSvpW1XvyhjmjX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459901; c=relaxed/simple;
	bh=6finTitxHM3jkpYX8IgU4pAIPod9DT/kJvPlNb6TPvQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Apkc4ou1GpQXz89vVh8ITKdUnFAQXwXdMVQYQ8vgr27yNpaOeXOg306GxcHqtmZh+iV9hJtIBA2OtPmY6tT6F1xHtWhV0wRLzlvz00dV20MLS780CwuzrqIPH+NgSmeOJu9tdqUfmM3NC8vzY8ZRhGcGOEXIxfdXbAj7eh+iooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB1axkxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B303C4CEE4;
	Mon,  5 May 2025 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746459901;
	bh=6finTitxHM3jkpYX8IgU4pAIPod9DT/kJvPlNb6TPvQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WB1axkxyILLuac+rH85YOIpHyOFpd2KKBD/QJ+zr0B/eGJ1MaqPsqI/rG95E4D457
	 4yv27TIi6EWQD95HiueDBkIUfsKPXGLi+1Ag9u3+KZZ20ExP8/LOgNGbkehb2alGKh
	 nSZnq2uyHGSCeLkNJ5zwmV8wxwKmOEN1C2NqQ/QuAYh5Ze1gUil84DaQMaaJL2w4E7
	 fp2PUeuENhm7SIy6MeU4pQT+kTMvSCzv6e+92rgywtA1IhmN+W1bWQcRCXWlId3wRX
	 vani7fZw/v1iVRZzX4D3mnIPi9r2K8uHDZyVk4SAJwSZqAajeFFTuAvd+cj9fP/8Bd
	 sJJ1Ktwz2LAsw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <3181433ccdd695c63560eeeb3f0c990961732101.1745839855.git.leon@kernel.org>
References: <3181433ccdd695c63560eeeb3f0c990961732101.1745839855.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix error flow upon firmware
 failure for RQ destruction
Message-Id: <174645989742.411350.15212260963996218954.b4-ty@kernel.org>
Date: Mon, 05 May 2025 11:44:57 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 28 Apr 2025 14:34:07 +0300, Leon Romanovsky wrote:
> Upon RQ destruction if the firmware command fails which is the
> last resource to be destroyed some SW resources were already cleaned
> regardless of the failure.
> 
> Now properly rollback the object to its original state upon such failure.
> 
> In order to avoid a use-after free in case someone tries to destroy the
> object again, which results in the following kernel trace:
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 0 PID: 37589 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x148
> Modules linked in: rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) ib_umad(OE) mlx5_ib(OE) rfkill mlx5_core(OE) mlxdevm(OE) ib_uverbs(OE) ib_core(OE) psample mlxfw(OE) mlx_compat(OE) macsec tls pci_hyperv_intf sunrpc vfat fat virtio_net net_failover failover fuse loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_console virtio_gpu virtio_blk virtio_dma_buf virtio_mmio dm_mirror dm_region_hash dm_log dm_mod xpmem(OE)
> CPU: 0 UID: 0 PID: 37589 Comm: python3 Kdump: loaded Tainted: G           OE     -------  ---  6.12.0-54.el10.aarch64 #1
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : refcount_warn_saturate+0xf4/0x148
> lr : refcount_warn_saturate+0xf4/0x148
> sp : ffff80008b81b7e0
> x29: ffff80008b81b7e0 x28: ffff000133d51600 x27: 0000000000000001
> x26: 0000000000000000 x25: 00000000ffffffea x24: ffff00010ae80f00
> x23: ffff00010ae80f80 x22: ffff0000c66e5d08 x21: 0000000000000000
> x20: ffff0000c66e0000 x19: ffff00010ae80340 x18: 0000000000000006
> x17: 0000000000000000 x16: 0000000000000020 x15: ffff80008b81b37f
> x14: 0000000000000000 x13: 2e656572662d7265 x12: ffff80008283ef78
> x11: ffff80008257efd0 x10: ffff80008283efd0 x9 : ffff80008021ed90
> x8 : 0000000000000001 x7 : 00000000000bffe8 x6 : c0000000ffff7fff
> x5 : ffff0001fb8e3408 x4 : 0000000000000000 x3 : ffff800179993000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000133d51600
> Call trace:
>  refcount_warn_saturate+0xf4/0x148
>  mlx5_core_put_rsc+0x88/0xa0 [mlx5_ib]
>  mlx5_core_destroy_rq_tracked+0x64/0x98 [mlx5_ib]
>  mlx5_ib_destroy_wq+0x34/0x80 [mlx5_ib]
>  ib_destroy_wq_user+0x30/0xc0 [ib_core]
>  uverbs_free_wq+0x28/0x58 [ib_uverbs]
>  destroy_hw_idr_uobject+0x34/0x78 [ib_uverbs]
>  uverbs_destroy_uobject+0x48/0x240 [ib_uverbs]
>  __uverbs_cleanup_ufile+0xd4/0x1a8 [ib_uverbs]
>  uverbs_destroy_ufile_hw+0x48/0x120 [ib_uverbs]
>  ib_uverbs_close+0x2c/0x100 [ib_uverbs]
>  __fput+0xd8/0x2f0
>  __fput_sync+0x50/0x70
>  __arm64_sys_close+0x40/0x90
>  invoke_syscall.constprop.0+0x74/0xd0
>  do_el0_svc+0x48/0xe8
>  el0_svc+0x44/0x1d0
>  el0t_64_sync_handler+0x120/0x130
>  el0t_64_sync+0x1a4/0x1a8
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Fix error flow upon firmware failure for RQ destruction
      https://git.kernel.org/rdma/rdma/c/5d2ea5aebbb2f3

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


