Return-Path: <linux-rdma+bounces-13935-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FB9BEE3B1
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 13:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E47834A0D4
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2F2E3360;
	Sun, 19 Oct 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gID7d59i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA421FF4A
	for <linux-rdma@vger.kernel.org>; Sun, 19 Oct 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760873210; cv=none; b=I4vee9B/+pRjxixHFi85A/Nf6J9ugdNB8eBj5dUCVWPYdLOFMNdV77LDn9AK04DRYEW+0d3bIzdtUumv2Cd6H5hZfuOoAqRc0gZ0ERX6rykoZs7V/Ws7fckK+zQYP40FGL5egqnfK+uFESzZQxfmLisby7g23wXlEhsEFlxm+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760873210; c=relaxed/simple;
	bh=DB4mTFgGPSOjpPEhTt8b2of8ZUYJbg6bHwD4ygXyeWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWRzoYcyt/GJ4nYOuafOVAnE7AEfxMf61+03YH1HMvFVzYSay6y0Na1t/DHBCBRDix3QJ04Hb5MqzlFVfVOXDSEjWiujNtkRRz+9bXusFNnL0/fCDTFGeOvh0xjSMTTQisCkicTvHDtPkJFW98g48gsIvcJTYz1inZC+0xjRd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gID7d59i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3D6C4CEE7;
	Sun, 19 Oct 2025 11:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760873208;
	bh=DB4mTFgGPSOjpPEhTt8b2of8ZUYJbg6bHwD4ygXyeWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gID7d59iKozxN1mKPeze1lFov6jhBB/Zi8BFkzf8MVtnH/Ya7YgvFah3/bEBdWv3S
	 3Nr/ghhljYYLH8cXA3iWZcR65G6tOKlcaAIKSzYT6+gs8dqv92ISnMbONBGO/nVY82
	 IOGT09NMloraoYVs9i3KTzw1Jw1NLjLVZ4vIhXHvKW2fWi1NA7DuoeLnyazBKNarSd
	 842O4SSauQcpjcW9JvGLvArCsyPK2KnVdd0u4VkBcvLcd79kVZjQHDz0Qa9OPZBYVV
	 2GcuiCsfr4E2M95CA0U1TWqFPAKLwVdAIFXOy7HSOAYlghwExEvGDX0/ti1hJnb787
	 9EUPcrsS/lwow==
Date: Sun, 19 Oct 2025 14:26:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: linux-rdma@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/cxgb4: Fix possible circular locking
 dependency
Message-ID: <20251019112643.GF6199@unreal>
References: <20251008192837.481193-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008192837.481193-1-kheib@redhat.com>

On Wed, Oct 08, 2025 at 03:28:37PM -0400, Kamal Heib wrote:
> Holding dev_mutex across c4iw_remove() during module exit can lead to a
> lockdep warning and potential deadlock. The RDMA core takes global
> locks (e.g. devices_rwsem) inside ib_unregister_device(), which may
> conflict with the locking order used elsewhere in the driver.
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  6.12.0-124.5.1.el10_1.x86_64+debug #1 Not tainted
>  ------------------------------------------------------
>  rmmod/3524 is trying to acquire lock:
>  ffffffffc1c0dd18 (devices_rwsem){++++}-{4:4}, at: disable_device+0xaf/0x240 [ib_core]
> 
>  but task is already holding lock:
>  ffff889104e44708 (&device->unregistration_lock){+.+.}-{4:4}, at: __ib_unregister_device+0x209/0x460 [ib_core]
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #6 (&device->unregistration_lock){+.+.}-{4:4}:
>         __lock_acquire+0x559/0xb80
>         lock_acquire.part.0+0xbe/0x270
>         __mutex_lock+0x18b/0x12b0
>         __ib_unregister_device+0x209/0x460 [ib_core]
>         ib_unregister_device+0x25/0x30 [ib_core]
>         c4iw_remove+0xce/0xda [iw_cxgb4]
>         c4iw_exit_module+0x7d/0xe0 [iw_cxgb4]
>         __do_sys_delete_module.isra.0+0x33a/0x540
>         do_syscall_64+0x92/0x180
>         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  -> #5 (dev_mutex){+.+.}-{4:4}:
>         __lock_acquire+0x559/0xb80
>         lock_acquire.part.0+0xbe/0x270
>         __mutex_lock+0x18b/0x12b0
>         c4iw_uld_add+0x137/0x500 [iw_cxgb4]
>         uld_attach+0x908/0xd80 [cxgb4]
>         cxgb4_uld_alloc_resources.part.0+0x364/0x1120 [cxgb4]
>         cxgb4_register_uld+0x10c/0x400 [cxgb4]
>         c4iw_init_module+0x77/0x80 [iw_cxgb4]
>         do_one_initcall+0xa5/0x260
>         do_init_module+0x238/0x7c0
>         init_module_from_file+0xdf/0x150
>         idempotent_init_module+0x230/0x770
>         __x64_sys_finit_module+0xbe/0x130
>         do_syscall_64+0x92/0x180
>         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  -> #4 (uld_mutex){+.+.}-{4:4}:
>         __lock_acquire+0x559/0xb80
>         lock_acquire.part.0+0xbe/0x270
>         __mutex_lock+0x18b/0x12b0
>         cxgb_up+0x24/0xee0 [cxgb4]
>         cxgb_open+0x7e/0x250 [cxgb4]
>         __dev_open+0x241/0x420
>         __dev_change_flags+0x44c/0x660
>         dev_change_flags+0x80/0x160
>         do_setlink+0x1acd/0x23e0
>         __rtnl_newlink+0xb07/0xe40
>         rtnl_newlink+0x62/0x90
>         rtnetlink_rcv_msg+0x2f3/0xb20
>         netlink_rcv_skb+0x13d/0x3b0
>         netlink_unicast+0x42e/0x720
>         netlink_sendmsg+0x765/0xc20
>         ____sys_sendmsg+0x974/0xc60
>         ___sys_sendmsg+0xfd/0x180
>         __sys_sendmsg+0xe8/0x190
>         do_syscall_64+0x92/0x180
>         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  -> #3 (rtnl_mutex){+.+.}-{4:4}:
>         __lock_acquire+0x559/0xb80
>         lock_acquire.part.0+0xbe/0x270
>         __mutex_lock+0x18b/0x12b0
>         ib_get_eth_speed+0xee/0x9d0 [ib_core]
>         ib_query_port+0x140/0x1f0 [ib_core]
>         ib_setup_port_attrs+0x1a5/0x4c0 [ib_core]
>         add_one_compat_dev+0x4bd/0x7b0 [ib_core]
>         rdma_dev_init_net+0x257/0x3e0 [ib_core]
>         ops_init+0x109/0x300
>         setup_net+0x1c4/0x730
>         copy_net_ns+0x23b/0x540
>         create_new_namespaces+0x358/0x920
>         unshare_nsproxy_namespaces+0x8a/0x1b0
>         ksys_unshare+0x2df/0x740
>         __x64_sys_unshare+0x31/0x40
>         do_syscall_64+0x92/0x180
>         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  -> #2 (&device->compat_devs_mutex){+.+.}-{4:4}:
>         __lock_acquire+0x559/0xb80
>         lock_acquire.part.0+0xbe/0x270
>         __mutex_lock+0x18b/0x12b0
>         add_one_compat_dev+0xe0/0x7b0 [ib_core]
>         rdma_dev_init_net+0x257/0x3e0 [ib_core]
>         ops_init+0x109/0x300
>         setup_net+0x1c4/0x730
>         copy_net_ns+0x23b/0x540
>         create_new_namespaces+0x358/0x920
>         unshare_nsproxy_namespaces+0x8a/0x1b0
>         ksys_unshare+0x2df/0x740
>         __x64_sys_unshare+0x31/0x40
>         do_syscall_64+0x92/0x180
>         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  -> #1 (rdma_nets_rwsem){++++}-{4:4}:
>         __lock_acquire+0x559/0xb80
>         lock_acquire.part.0+0xbe/0x270
>         down_read+0xa3/0x4b0
>         enable_device_and_get+0x26b/0x350 [ib_core]
>         ib_register_device+0x1c3/0x4f0 [ib_core]
>         bnxt_re_ib_init+0x433/0x530 [bnxt_re]
>         bnxt_re_add_device+0x60d/0x760 [bnxt_re]
>         bnxt_re_probe+0xcf/0x140 [bnxt_re]
>         auxiliary_bus_probe+0xa1/0xf0
>         really_probe+0x1e0/0x8a0
>         __driver_probe_device+0x18c/0x370
>         driver_probe_device+0x4a/0x120
>         __driver_attach+0x194/0x4a0
>         bus_for_each_dev+0x106/0x190
>         bus_add_driver+0x2a1/0x4d0
>         driver_register+0x1a5/0x360
>         __auxiliary_driver_register+0x152/0x240
>         c4iw_init_module+0x43/0x80 [iw_cxgb4]
>         do_one_initcall+0xa5/0x260
>         do_init_module+0x238/0x7c0
>         init_module_from_file+0xdf/0x150
>         idempotent_init_module+0x230/0x770
>         __x64_sys_finit_module+0xbe/0x130
>         do_syscall_64+0x92/0x180
>         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  -> #0 (devices_rwsem){++++}-{4:4}:
>         check_prev_add+0xf1/0xce0
>         validate_chain+0x481/0x560
>         __lock_acquire+0x559/0xb80
>         lock_acquire.part.0+0xbe/0x270
>         down_write+0x99/0x220
>         disable_device+0xaf/0x240 [ib_core]
>         __ib_unregister_device+0x26f/0x460 [ib_core]
>         ib_unregister_device+0x25/0x30 [ib_core]
>         c4iw_remove+0xce/0xda [iw_cxgb4]
>         c4iw_exit_module+0x7d/0xe0 [iw_cxgb4]
>         __do_sys_delete_module.isra.0+0x33a/0x540
>         do_syscall_64+0x92/0x180
>         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  other info that might help us debug this:
> 
>  Chain exists of:
>    devices_rwsem --> dev_mutex --> &device->unregistration_lock
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&device->unregistration_lock);
>                                 lock(dev_mutex);
>                                 lock(&device->unregistration_lock);
>    lock(devices_rwsem);
> 
>   *** DEADLOCK ***
> 
> This patch fixes the issue by moving all uld_ctx entries from the global
> uld_ctx_list to a temporary local list while holding dev_mutex, then
> releasing the mutex before calling c4iw_remove() and freeing the
> contexts. This prevents any lock inversion while safely avoiding races
> on the shared list.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/infiniband/hw/cxgb4/device.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
> index d892f55febe2..fe902e2f3b0d 100644
> --- a/drivers/infiniband/hw/cxgb4/device.c
> +++ b/drivers/infiniband/hw/cxgb4/device.c
> @@ -1554,14 +1554,18 @@ static int __init c4iw_init_module(void)
>  static void __exit c4iw_exit_module(void)
>  {
>  	struct uld_ctx *ctx, *tmp;
> +	LIST_HEAD(local_list);
>  
>  	mutex_lock(&dev_mutex);
> -	list_for_each_entry_safe(ctx, tmp, &uld_ctx_list, entry) {
> +	list_splice_init(&uld_ctx_list, &local_list);
> +	mutex_unlock(&dev_mutex);

It doesn't make any sense to hold this mutex. You are calling to remove
cxgb4 module and worry about running probe at the same time. It
shouldn't happen. This lock can be removed.

Thanks

> +
> +	list_for_each_entry_safe(ctx, tmp, &local_list, entry) {
> +		list_del(&ctx->entry);
>  		if (ctx->dev)
>  			c4iw_remove(ctx);
>  		kfree(ctx);
>  	}
> -	mutex_unlock(&dev_mutex);
>  	destroy_workqueue(reg_workq);
>  	cxgb4_unregister_uld(CXGB4_ULD_RDMA);
>  	c4iw_cm_term();
> -- 
> 2.51.0
> 

