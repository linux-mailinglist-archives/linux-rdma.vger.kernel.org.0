Return-Path: <linux-rdma+bounces-13808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1555BCA6CF
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Oct 2025 19:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D100481608
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Oct 2025 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99CB1E2614;
	Thu,  9 Oct 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2IzdXsw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D95244675
	for <linux-rdma@vger.kernel.org>; Thu,  9 Oct 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032172; cv=none; b=DtTNtFyIej6zWiRyLFoUFj+swXFYiJpeNWjIH8JvG27UPQa9/K/tejp4TckPgf33ZNKwVwRdiz66Lh5DpfAOSPVwR+otsH1YAg9Y++FSUkSc7OmSey+45ZVuvoejbhr27XYytE7J/XCoZsZ3uQ7M7McGv5SFeOMEaFJFmO7flvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032172; c=relaxed/simple;
	bh=xTeocJNivW72u7fJnjhSmjM2ybMxX54CX5P44vMtjBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3+XSGqRi06getLmjXIm9IHe/uyJTGodPaPAIKWLlngBLVddXkCb8BsxoUSHcwch5S7vRW8D3hx1UvxJ5MSrMKnjq4fFFh4WR8WHmVnqmD+BQtPFidzsaWXVJ9motm9O/keOwIFjDIHZd+Gyy7FcCxNa4r8LrJxwuPzauwSBEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2IzdXsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBCBC4CEE7;
	Thu,  9 Oct 2025 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760032172;
	bh=xTeocJNivW72u7fJnjhSmjM2ybMxX54CX5P44vMtjBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2IzdXswelaUl1CvMBCP+/FAft4w1IRPwlkz1XGVBT3se2Hm4SAVCqHGWmbk787rH
	 LYAw9/XohN+jRy9xQCTxT1f9siQmeMVkErlyMitKAvBFVLvFy95R9H6IYLEhBO2kTv
	 0GOSAVaeaDY2UpW3zwMDLnmK7fltrhLSUtKz6+Fo3yPljHvKWnr8FsOhtO8WoFQflN
	 jk0rmBpypTaoENKzNs7r30K6RJ7cs9LDpSSTeaE5N7EoDE89sHKUUakotipwebESCx
	 jPFqoyaJ4ft367VobLZ5Az84CKolUI+2dY48ZvUYDTrtXT0t23hXJqAEkne1CyXQpG
	 ztFbIodJbT0GA==
Date: Thu, 9 Oct 2025 20:49:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jian Wen <wenjianhn@gmail.com>
Cc: jgg@nvidia.com, Jian Wen <wenjian1@xiaomi.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use mlx5_cmd_is_down to detect PCIe Surprise
 Link Down
Message-ID: <20251009174927.GA14552@unreal>
References: <20251009142326.3794769-1-wenjian1@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009142326.3794769-1-wenjian1@xiaomi.com>

On Thu, Oct 09, 2025 at 10:23:20PM +0800, Jian Wen wrote:
> mlx5r_umr_post_send_wait() will get stuck when the pcie link is down
> as the call trace[1].
> 
> When pciehp detects the link is down it calls
> pci_dev_set_disconnected() before mlx5_ib_dereg_mr(). Thus we can use
> mlx5_cmd_is_down() to detect PCIe Surprise Link Down in
> mlx5r_umr_post_send().
> 
> [1]
> pcieport 0000:b9:01.0: pciehp: Slot(2-4): Link Down
> pcieport 0000:b9:01.0: pciehp: Slot(2-4): Card not present
> mlx5_core 0000:bb:00.0: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
> mlx5_core 0000:bb:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
> mlx5_core 0000:bb:00.0: poll_health:1083:(pid 0): Fatal error 1 detected
> mlx5_core 0000:bb:00.0: print_health_info:491:(pid 0): PCI slot is unavailable
> INFO: task irq/105-pciehp:1246 blocked for more than 122 seconds.
>       Tainted: G           OE      6.8.0-54-generic #56-Ubuntu
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:irq/105-pciehp  state:D stack:0     pid:1246  tgid:1246  ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  __schedule+0x27c/0x6b0
>  schedule+0x33/0x110
>  schedule_timeout+0x157/0x170
>  wait_for_completion+0x88/0x150
>  mlx5r_umr_post_send_wait+0x15f/0x2d0 [mlx5_ib]
>  ? __pfx_mlx5r_umr_done+0x10/0x10 [mlx5_ib]
>  mlx5r_umr_revoke_mr+0x98/0xc0 [mlx5_ib]
>  __mlx5_ib_dereg_mr+0x24a/0x740 [mlx5_ib]
>  ? wait_for_completion+0x114/0x150
>  mlx5_ib_dereg_mr+0x21/0xc0 [mlx5_ib]
>  ? rdma_restrack_del+0x59/0x160 [ib_core]
>  ib_dereg_mr_user+0x41/0xc0 [ib_core]
>  uverbs_free_mr+0x15/0x30 [ib_uverbs]
>  destroy_hw_idr_uobject+0x21/0x60 [ib_uverbs]
>  uverbs_destroy_uobject+0x38/0x1d0 [ib_uverbs]
>  __uverbs_cleanup_ufile+0xcf/0x150 [ib_uverbs]
>  uverbs_destroy_ufile_hw+0x3f/0x100 [ib_uverbs]
>  ib_uverbs_remove_one+0x147/0x1c0 [ib_uverbs]
>  remove_client_context+0x95/0x100 [ib_core]
>  disable_device+0x8f/0x180 [ib_core]
>  __ib_unregister_device+0x108/0x170 [ib_core]
>  ? __pfx_mlx5_ib_stage_ib_reg_cleanup+0x10/0x10 [mlx5_ib]
>  ib_unreister_device+0x26/0x40 [ib_core]
>  mlx5_ib_stage_ib_reg_cleanup+0xe/0x20 [mlx5_ib]
>  mlx5r_remove+0x52/0xb0 [mlx5_ib]
>  auxiliary_bus_remove+0x1c/0x40
>  device_remove+0x40/0x80
>  device_release_driver_internal+0x20b/0x270
>  device_release_driver+0x12/0x20
>  bus_remove_device+0xcb/0x140
>  device_del+0x161/0x3e0
>  ? is_ib_enabled+0x52/0x90 [mlx5_core]
>  mlx5_rescan_drivers_locked+0xfe/0x350 [mlx5_core]
>  mlx5_unregister_device+0x38/0x60 [mlx5_core]
>  mlx5_uninit_one+0x39/0x160 [mlx5_core]
>  remove_one+0x55/0x100 [mlx5_core]
>  pci_device_remove+0x3e/0xb0
>  device_remove+0x40/0x80
>  device_release_driver_internal+0x20b/0x270
>  device_release_driver+0x12/0x20
>  pci_stop_bus_device+0x7a/0xb0
>  pci_stop_and_remove_bus_device+0x12/0x30
>  pciehp_unconfigure_device+0x98/0x170
>  pciehp_disable_slot+0x69/0x130
>  pciehp_handle_presence_or_link_change+0x71/0x220
>  pciehp_ist+0x22e/0x260
>  ? __pfx_irq_thread_fn+0x10/0x10
>  irq_thread_fn+0x21/0x70
>  irq_thread+0xf8/0x1c0
>  ? __pfx_irq_thread_dtor+0x10/0x10
>  ? __pfx_irq_thread+0x10/0x10
>  kthread+0xef/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x44/0x70
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> 
> Fixes: 6f0689fdf19e ("RDMA/mlx5: Introduce mlx5_umr_post_send_wait()")
> Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
> ---
>  drivers/infiniband/hw/mlx5/umr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
> index 4e562e0dd9e1..f3700ef6ea07 100644
> --- a/drivers/infiniband/hw/mlx5/umr.c
> +++ b/drivers/infiniband/hw/mlx5/umr.c
> @@ -254,7 +254,7 @@ static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
>  	unsigned int idx;
>  	int size, err;
>  
> -	if (unlikely(mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
> +	if (unlikely(mlx5_cmd_is_down(mdev)))

mlx5_cmd_is_down() is defined in mlx5_core.ko module and doesn't have EXPORT_SYMBOL.
Did you success to compile this patch?

Thanks

>  		return -EIO;
>  
>  	spin_lock_irqsave(&qp->sq.lock, flags);
> -- 
> 2.43.0
> 
> 

