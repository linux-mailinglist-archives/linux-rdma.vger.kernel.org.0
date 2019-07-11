Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5704165AAA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 17:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfGKPrl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 11:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfGKPrl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 11:47:41 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D8821537;
        Thu, 11 Jul 2019 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562860059;
        bh=7JLbmhIYkDmXeab2B6YN/6znaQrDI8XsH9/KzUSdyAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qaajx5dQ1t655UuxAxo29unrqr34Cu57DVHKRQwThlXVQ2i/jSsvFJpyG8Rr2YcGl
         eqKr9vVytrrk1U+tnALX13jvhD6QLgTV7jxlXfk8Ct9SjzfEfBHmD/jaDhaCauxAFu
         CDbI4uTKkZXqT4giF9wBuemOqmP6r8nLBSjHc/0A=
Date:   Thu, 11 Jul 2019 18:47:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Message-ID: <20190711154734.GI23598@mtr-leonro.mtl.com>
References: <20190711153118.14635-1-leon@kernel.org>
 <20190711154324.GK25821@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711154324.GK25821@mellanox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 03:43:28PM +0000, Jason Gunthorpe wrote:
> On Thu, Jul 11, 2019 at 06:31:18PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Multiply by 100 can potentially overflow cpms value and will produce
> > incorrect wrong ratio statistics. Update code to use built-in division
> > macro, so it will fix the following UBSAN warning.
> >
> >  [ 1040.120129] ================================================================================
> >  [ 1040.127124] UBSAN: Undefined behaviour in lib/dim/dim.c:78:23
> >  [ 1040.130118] signed integer overflow:
> >  [ 1040.131643] 134718714 * 100 cannot be represented in type 'int'
> >  [ 1040.134374] CPU: 0 PID: 22846 Comm: iperf3 Not tainted 5.2.0-rc6-for-upstream-dbg-2019-06-29_03-18-13-29 #1
> >  [ 1040.139068] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> >  [ 1040.144469] Call Trace:
> >  [ 1040.145897]  <IRQ>
> >  [ 1040.147366]  dump_stack+0x9a/0xeb
> >  [ 1040.149061]  ubsan_epilogue+0x9/0x7c
> >  [ 1040.150462]  handle_overflow+0x16d/0x198
> >  [ 1040.151911]  ? __ubsan_handle_negate_overflow+0x15c/0x15c
> >  [ 1040.153679]  ? sk_free+0x15/0x30
> >  [ 1040.155011]  ? kvm_clock_read+0x14/0x30
> >  [ 1040.156433]  ? kvm_sched_clock_read+0x5/0x10
> >  [ 1040.157952]  ? sched_clock+0x5/0x10
> >  [ 1040.159318]  ? sched_clock_cpu+0x18/0x260
> >  [ 1040.160801]  dim_calc_stats+0x4a1/0x4c0
> >  [ 1040.162274]  net_dim+0x147/0x920
> >  [ 1040.163592]  ? net_dim_stats_compare+0x330/0x330
> >  [ 1040.165283]  mlx5e_napi_poll+0x410/0x1030 [mlx5_core]
> >  [ 1040.166876]  ? lock_stats+0xd41/0x1740
> >  [ 1040.168266]  ? mlx5e_trigger_irq+0x550/0x550 [mlx5_core]
> >  [ 1040.169918]  ? __module_text_address+0x13/0x140
> >  [ 1040.171409]  ? lock_stats+0xd41/0x1740
> >  [ 1040.172757]  ? net_rx_action+0x262/0xda0
> >  [ 1040.174156]  net_rx_action+0x421/0xda0
> >  [ 1040.175519]  ? napi_complete_done+0x370/0x370
> >  [ 1040.176979]  ? kvm_clock_read+0x14/0x30
> >  [ 1040.178316]  ? kvm_sched_clock_read+0x5/0x10
> >  [ 1040.179690]  ? sched_clock+0x5/0x10
> >  [ 1040.180920]  ? sched_clock_cpu+0x18/0x260
> >  [ 1040.182286]  __do_softirq+0x287/0xb4e
> >  [ 1040.183581]  ? irqtime_account_irq+0x1d5/0x3b0
> >  [ 1040.184998]  irq_exit+0x17d/0x1d0
> >  [ 1040.186212]  do_IRQ+0x129/0x220
> >  [ 1040.187412]  common_interrupt+0xf/0xf
> >  [ 1040.188673]  </IRQ>
> >  [ 1040.189685] RIP: 0033:0x7f092c41a07a
> >  [ 1040.190884] Code: 45 31 f6 e9 8a 00 00 00 0f 1f 84 00 00 00 00 00 48
> > 89 df ff 93 88 01 00 00 85 c0 0f 88 c7 00 00 00 48 98 48 01 85 88 02 00
> > 00 <48> 8b 85 c8 02 00 00 48 83 85 90 02 00 00 01 48 83 78 10 00 74 0b
> >  [ 1040.195584] RSP: 002b:00007fffbebe7870 EFLAGS: 00000206 ORIG_RAX: ffffffffffffffd7
> >  [ 1040.197933] RAX: 0000000000020000 RBX: 0000000000e239b0 RCX: 000000000006b280
> >  [ 1040.199740] RDX: 0000000000020000 RSI: 00007f092c805000 RDI: 0000000000000007
> >  [ 1040.201525] RBP: 0000000000e21260 R08: 0000000000000000 R09: 00007fffbebfb0a0
> >  [ 1040.203237] R10: 0000000000000380 R11: 0000000000000246 R12: 00007fffbebe7950
> >  [ 1040.204944] R13: 0000000000000007 R14: 0000000000000001 R15: 00007fffbebe7870
> >  [ 1040.206686] ================================================================================
> >
> > Fixes: 398c2b05bbee ("linux/dim: Add completions count to dim_sample")
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  lib/dim/dim.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> > index 439d641ec796..38045d6d0538 100644
> > +++ b/lib/dim/dim.c
> > @@ -74,8 +74,8 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
> >  					delta_us);
> >  	curr_stats->cpms = DIV_ROUND_UP(ncomps * USEC_PER_MSEC, delta_us);
> >  	if (curr_stats->epms != 0)
> > -		curr_stats->cpe_ratio =
> > -				(curr_stats->cpms * 100) / curr_stats->epms;
> > +		curr_stats->cpe_ratio = DIV_ROUND_DOWN_ULL(
> > +			curr_stats->cpms * 100, curr_stats->epms);
>
> This will still potentially overfow the 'int' for cpe_ratio if epms <
> 100 ?

I assumed that assignment to "unsigned long long" will do the trick.
https://elixir.bootlin.com/linux/latest/source/include/linux/kernel.h#L94

Thanks

>
> Jason
