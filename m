Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04DE370B50
	for <lists+linux-rdma@lfdr.de>; Sun,  2 May 2021 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhEBL3I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 May 2021 07:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhEBL3I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 2 May 2021 07:29:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 561CE6101A;
        Sun,  2 May 2021 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619954897;
        bh=AMNoy9B2VJ3g2uiK6VkzTXDVLNv3gwMBB1RJc6UaDYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8Pu9MVE1UNok5UCP45oOAHZd5q+v3DL5ttb4uh7yX1+6z0Lal/QUTs+8RiNkm7F3
         G/VAWEEqwIpfTsCkNNqfsN8dhqFs9HoPSpWoNz3T1jqRF7vcdHI+w17JwfylXbI38W
         uqCvvhwbtRsgdiA5EmL5CI9DpQu7Smvb/mVEfTCF6qOFlAc9Yzn/M8sYuj0X+4dT9P
         OJs0WqNuCOhwG4iZJdqRjz4V00jfQakeUMuqdyPZN5yQOCdFVDkt4MgNoHRIWViSlt
         46ELMVUClzv1VX8x+PdnP0lRVMZpFHg54PUVA6y476HX2vJw4WE+kJ9kvb/LQQALbM
         8bScCO2jBQizg==
Date:   Sun, 2 May 2021 14:28:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <YI6MzXZ/AG9COtgh@unreal>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
 <20210422142939.GA2407382@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422142939.GA2407382@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 22, 2021 at 11:29:39AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 08:03:22AM +0300, Leon Romanovsky wrote:
> 
> > I didn't understand when reviewed either, but decided to post it anyway
> > to get possible explanation for this RDMA_RESTRACK_MR || RDMA_RESTRACK_QP
> > check.
> 
> I think the whole thing should look more like this and we delete the
> if entirely.

Finally, I had a time to work on it and got immediate reminder why we
have "if ...".

> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 2b9ffc21cbc4ad..479b16b8f6723a 100644

<...>

> @@ -1963,31 +1969,33 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
>  		rdma_rw_cleanup_mrs(qp);
>  
>  	rdma_counter_unbind_qp(qp, true);
> -	rdma_restrack_del(&qp->res);
> +	rdma_restrack_prepare_del(&qp->res);
>  	ret = qp->device->ops.destroy_qp(qp, udata);
> -	if (!ret) {
> -		if (alt_path_sgid_attr)
> -			rdma_put_gid_attr(alt_path_sgid_attr);
> -		if (av_sgid_attr)
> -			rdma_put_gid_attr(av_sgid_attr);
> -		if (pd)
> -			atomic_dec(&pd->usecnt);
> -		if (scq)
> -			atomic_dec(&scq->usecnt);
> -		if (rcq)
> -			atomic_dec(&rcq->usecnt);
> -		if (srq)
> -			atomic_dec(&srq->usecnt);
> -		if (ind_tbl)
> -			atomic_dec(&ind_tbl->usecnt);
> -		if (sec)
> -			ib_destroy_qp_security_end(sec);
> -	} else {
> +	if (ret) {
> +		rdma_restrack_abort_del(&qp->res);
>  		if (sec)
>  			ib_destroy_qp_security_abort(sec);
> +		return ret;
>  	}
>  
> -	return ret;
> +	rdma_restrack_finish_del(&qp->res);

This causes to use-after-free because "qp" is released in the driver.

[leonro@vm ~]$ mkt test
.s....[   24.350657] ==================================================================
[   24.350917] BUG: KASAN: use-after-free in rdma_restrack_finish_del+0x1a7/0x210 [ib_core]
[   24.351303] Read of size 1 at addr ffff88800c59f118 by task python3/243
[   24.351416] 
[   24.351495] CPU: 4 PID: 243 Comm: python3 Not tainted 5.12.0-rc2+ #2923
[   24.351644] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   24.351832] Call Trace:
[   24.351886]  dump_stack+0x93/0xc2
[   24.351965]  print_address_description.constprop.0+0x18/0x140
[   24.352074]  ? rdma_restrack_finish_del+0x1a7/0x210 [ib_core]
[   24.352204]  ? rdma_restrack_finish_del+0x1a7/0x210 [ib_core]
[   24.352333]  kasan_report.cold+0x7c/0xd8
[   24.352413]  ? rdma_restrack_finish_del+0x1a7/0x210 [ib_core]
[   24.352543]  rdma_restrack_finish_del+0x1a7/0x210 [ib_core]
[   24.352654]  ib_destroy_qp_user+0x297/0x540 [ib_core]
[   24.352769]  uverbs_free_qp+0x7d/0x150 [ib_uverbs]
[   24.352864]  uverbs_destroy_uobject+0x164/0x6c0 [ib_uverbs]
[   24.352949]  uobj_destroy+0x72/0xf0 [ib_uverbs]
[   24.353041]  ib_uverbs_cmd_verbs+0x19b9/0x2ee0 [ib_uverbs]
[   24.353147]  ? uverbs_free_qp+0x150/0x150 [ib_uverbs]
[   24.353246]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[   24.353340]  ? uverbs_fill_udata+0x540/0x540 [ib_uverbs]
[   24.353455]  ? filemap_map_pages+0x2d9/0xf30
[   24.353552]  ? lock_acquire+0x1a9/0x6d0
[   24.353620]  ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]
[   24.353720]  ? __might_fault+0xba/0x160
[   24.353790]  ? lock_release+0x6c0/0x6c0
[   24.353866]  ib_uverbs_ioctl+0x169/0x260 [ib_uverbs]
[   24.353958]  ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]
[   24.354049]  ? ib_uverbs_cmd_verbs+0x2ee0/0x2ee0 [ib_uverbs]
[   24.354158]  __x64_sys_ioctl+0x7e6/0x1050
[   24.354217]  ? generic_block_fiemap+0x60/0x60
[   24.354305]  ? down_write_nested+0x150/0x150
[   24.354400]  ? do_user_addr_fault+0x219/0xdc0
[   24.354497]  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
[   24.354584]  ? syscall_enter_from_user_mode+0x1d/0x50
[   24.354678]  do_syscall_64+0x2d/0x40
[   24.354747]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   24.354837] RIP: 0033:0x7fbfd862b5db
[   24.354911] Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39 c4 72 b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6d b8 0c 00 f7 d8 64 89 01 48
[   24.355200] RSP: 002b:00007fff7e9fde58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   24.355336] RAX: ffffffffffffffda RBX: 00007fff7e9fdf88 RCX: 00007fbfd862b5db
[   24.355468] RDX: 00007fff7e9fdf70 RSI: 00000000c0181b01 RDI: 0000000000000005
[   24.355587] RBP: 00007fff7e9fdf50 R08: 000055d6a4f8b3f0 R09: 00007fbfd800d000
[   24.355713] R10: 00007fbfd800d0f0 R11: 0000000000000246 R12: 00007fff7e9fdf50
[   24.355836] R13: 00007fff7e9fdf2c R14: 000055d6a4e59d90 R15: 000055d6a4f8b530
[   24.355973] 

So let's finish memory allocation conversion patches before.

Thanks
