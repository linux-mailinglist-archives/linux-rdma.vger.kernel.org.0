Return-Path: <linux-rdma+bounces-14453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704CC52BD6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F04A37E9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2C2877CF;
	Wed, 12 Nov 2025 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYBuGJnR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827023A994
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957173; cv=none; b=SZ1kBxBRwJQO1aJRDaeasuxMvbKIzE/+sYsKVZXndw6v/DcI9AaiI1ae23QjQoN18PbN+aEkKKGKB7ovwNdmhlNjRSTgOi2KwMsurGDbyubWowX8D5FKXYN2hA+BOvKuk2qp/06krf2ql4hpgTOc4Xk9Nv5RaW83Q7I147hr6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957173; c=relaxed/simple;
	bh=F79buxaT2shZcDQoQ6EGSRgzHbLWiQNcTggMZxe1wAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8u1B/jM8ZNWjfAtgCOlRbTxFWov9mCKYBXuLdX631AUNDNM2cBOcyGXEo0Q9XRKsoVBTh8iCPzY6ariWmXXr5q5eOlkPGeAPWtVEIL7YHwny/hmjJWSGLxjKOlAM1zbpwdXGxyGpd44cKH3OxvCSHcl1ocVNIkn6keixk2jPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYBuGJnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BEAC4CEF8;
	Wed, 12 Nov 2025 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762957173;
	bh=F79buxaT2shZcDQoQ6EGSRgzHbLWiQNcTggMZxe1wAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYBuGJnRZOG1K299ivKTncueygQEKDUQAX16MGkp9TjRDmghfuiOiiwxdzjUvDZ6t
	 noQa4BctKc9HqL1JZQ41/3QRIZFdB8fP6wataL5SWZRVOwsO/l0DNeQ/XoP0b3TEDS
	 9RqwzkAKMVMbapIHLxQevrcQ6kMvZZs7XhjDxcwjF4+FWLGYItAKTqQ+XCU2fyyCbk
	 yODszUG1Zc2XXEswz+CHpO/hjdL6B1vsXveek4SD+X35CvDOQQBhMYow7Vce06LXyx
	 hEvCZ70JPomAw2Men7OCPPO51IujROiKD9JP+f3rTmOMfts8/ZKbe3R6auRTB2/svE
	 lMVr17I6GMH9g==
Date: Wed, 12 Nov 2025 16:19:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [????] Re: [PATCH] RDMA/core: Prevent soft lockup during large
 user memory region cleanup
Message-ID: <20251112141927.GE17382@unreal>
References: <20251111070107.2627-1-lirongqing@baidu.com>
 <20251111120136.GP15456@unreal>
 <5a9e07930f134ff283d4a65373a62b85@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9e07930f134ff283d4a65373a62b85@baidu.com>

On Tue, Nov 11, 2025 at 12:09:42PM +0000, Li,Rongqing wrote:
> 
> 
> > On Tue, Nov 11, 2025 at 03:01:07PM +0800, lirongqing wrote:
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > When a process exits with numerous large, pinned memory regions
> > > consisting of 4KB pages, the cleanup of the memory region through
> > > __ib_umem_release() may cause soft lockups. This is because
> > > unpin_user_page_range_dirty_lock()
> > 
> > Do you have soft lookup splat?
> > 
> 
> 
> A user meet this lockup issue on ubuntu 22.04 kernel, after change watchdog_thresh to 60, the soft lockup is disappeared.
> 
> I think his program registered too many memory region(this program has 400G memory), but the lockup should be fixed too.

So please add this information to next version together with change
proposed by Junxian.

Thanks

> 
> [9769474.755472] mlx5_core 0000:b0:00.0: mlx5_query_module_eeprom_by_page:475:(pid 3380349): Module ID not recognized: 0x19
> [9793445.031306] watchdog: BUG: soft lockup - CPU#44 stuck for 26s! [python3:73464]
> [9793445.032792] Kernel panic - not syncing: softlockup: hung tasks
> [9793445.033695] CPU: 44 PID: 73464 Comm: python3 Tainted: G           OEL    5.15.0-124-generic #134-Ubuntu
> [9793445.035024] Hardware name: BCC, BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [9793445.036500] Call Trace:
> [9793445.036955]  <IRQ>
> [9793445.037339]  show_stack+0x52/0x5c
> [9793445.037892]  dump_stack_lvl+0x4a/0x63
> [9793445.038485]  dump_stack+0x10/0x16
> [9793445.039024]  panic+0x15c/0x33b
> [9793445.039540]  watchdog_timer_fn.cold+0xc/0x16
> [9793445.040204]  ? lockup_detector_update_enable+0x60/0x60
> [9793445.040999]  __hrtimer_run_queues+0x104/0x230
> [9793445.041678]  ? clockevents_program_event+0xaa/0x130
> [9793445.042427]  hrtimer_interrupt+0x101/0x220
> [9793445.043070]  __sysvec_apic_timer_interrupt+0x5e/0xe0
> [9793445.043826]  sysvec_apic_timer_interrupt+0x7b/0x90
> [9793445.044563]  </IRQ>
> [9793445.044968]  <TASK>
> [9793445.045353]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [9793445.046138] RIP: 0010:free_unref_page+0xff/0x190
> [9793445.046861] Code: b9 ae 72 44 89 ea 4c 89 e7 e8 5d ce ff ff 65 48 03 1d fd b8 ae 72 41 f7 c6 00 02 00 00 0f 84 30 ff ff ff fb 66 0f 1f 44 00 00 <5b> 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc ba 00 08 0
> 0 00 e9 41
> [9793445.049506] RSP: 0018:ff7f1fce1bb039a8 EFLAGS: 00000206
> [9793445.050315] RAX: 0000000000000000 RBX: ff40b8648212ea88 RCX: ffc2d725bc39b808
> [9793445.051371] RDX: ff7f1fce1bb03920 RSI: ffc2d725bc39b7c8 RDI: ff40b86a3ffd7010
> [9793445.052436] RBP: ff7f1fce1bb039d0 R08: 0000000000000010 R09: 0000000000000000
> [9793445.053498] R10: ffc2d725bc39b800 R11: dead000000000122 R12: ffc2d728f67bcdc0
> [9793445.054551] R13: 0000000000000000 R14: 0000000000000297 R15: 0000000000000000
> [9793445.055604]  ? free_unref_page+0xe3/0x190
> [9793445.056255]  __put_page+0x77/0xe0
> [9793445.056831]  put_compound_head+0xed/0x100
> [9793445.057504]  unpin_user_page_range_dirty_lock+0xb2/0x180
> [9793445.058344]  __ib_umem_release+0x57/0xb0 [ib_core]
> [9793445.059148]  ib_umem_release+0x3f/0xd0 [ib_core]
> [9793445.059916]  mlx5_ib_dereg_mr+0x2e9/0x440 [mlx5_ib]
> [9793445.060716]  ib_dereg_mr_user+0x43/0xb0 [ib_core]
> [9793445.061492]  uverbs_free_mr+0x15/0x20 [ib_uverbs]
> [9793445.062242]  destroy_hw_idr_uobject+0x21/0x60 [ib_uverbs]
> [9793445.063091]  uverbs_destroy_uobject+0x38/0x1b0 [ib_uverbs]
> [9793445.063947]  __uverbs_cleanup_ufile+0xd1/0x150 [ib_uverbs]
> [9793445.064806]  uverbs_destroy_ufile_hw+0x3f/0x100 [ib_uverbs]
> [9793445.065671]  ib_uverbs_close+0x1f/0xb0 [ib_uverbs]
> [9793445.066450]  __fput+0x9c/0x280
> [9793445.066993]  ____fput+0xe/0x20
> [9793445.067541]  task_work_run+0x6a/0xb0
> [9793445.068149]  do_exit+0x217/0x3c0
> [9793445.068726]  do_group_exit+0x3b/0xb0
> [9793445.069327]  get_signal+0x150/0x900
> [9793445.069926]  arch_do_signal_or_restart+0xde/0x100
> [9793445.070679]  ? fput+0x13/0x20
> [9793445.071195]  ? do_epoll_wait+0x8f/0xe0
> [9793445.071817]  exit_to_user_mode_loop+0xc4/0x160
> [9793445.072526]  exit_to_user_mode_prepare+0xa0/0xb0
> [9793445.073253]  syscall_exit_to_user_mode+0x27/0x50
> [9793445.073985]  ? x64_sys_call+0xfab/0x1fa0
> [9793445.074632]  do_syscall_64+0x63/0xb0
> [9793445.075227]  ? exit_to_user_mode_prepare+0x37/0xb0
> [9793445.075985]  ? syscall_exit_to_user_mode+0x2c/0x50
> [9793445.076739]  ? x64_sys_call+0x1ea1/0x1fa0
> [9793445.077394]  ? do_syscall_64+0x63/0xb0
> [9793445.078011]  ? syscall_exit_to_user_mode+0x2c/0x50
> [9793445.078762]  ? x64_sys_call+0xfab/0x1fa0
> [9793445.079404]  ? do_syscall_64+0x63/0xb0
> [9793445.080018]  ? x64_sys_call+0x1ea1/0x1fa0
> [9793445.080674]  ? do_syscall_64+0x63/0xb0
> [9793445.081287]  ? do_syscall_64+0x63/0xb0
> [9793445.081903]  ? do_syscall_64+0x63/0xb0
> 
> 
> 
> -Li
> 
> 
> 
> > > is called in a tight loop for unpin and releasing page without
> > > yielding the CPU.
> > >
> > > Fix the soft lockup by adding cond_resched() calls in
> > > __ib_umem_release
> > >
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > >  drivers/infiniband/core/umem.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/infiniband/core/umem.c
> > > b/drivers/infiniband/core/umem.c index c5b6863..70c1520 100644
> > > --- a/drivers/infiniband/core/umem.c
> > > +++ b/drivers/infiniband/core/umem.c
> > > @@ -59,6 +59,7 @@ static void __ib_umem_release(struct ib_device *dev,
> > struct ib_umem *umem, int d
> > >  		unpin_user_page_range_dirty_lock(sg_page(sg),
> > >  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
> > >
> > > +	cond_resched();
> > >  	sg_free_append_table(&umem->sgt_append);
> > >  }
> > >
> > > --
> > > 2.9.4
> > >

