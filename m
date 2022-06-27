Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF055D0F8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiF0IpZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 04:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiF0IpY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 04:45:24 -0400
Received: from mail-m2835.qiye.163.com (mail-m2835.qiye.163.com [103.74.28.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF12558A
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jun 2022 01:45:21 -0700 (PDT)
Received: from localhost (unknown [117.48.120.186])
        by mail-m2835.qiye.163.com (Hmail) with ESMTPA id 42A018A0324;
        Mon, 27 Jun 2022 16:45:18 +0800 (CST)
Date:   Mon, 27 Jun 2022 16:45:14 +0800
From:   Tao Liu <thomas.liu@ucloud.cn>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, saeedm@nvidia.com, talgi@nvidia.com,
        mgurtovoy@nvidia.com, jgg@nvidia.com, yaminf@nvidia.com
Subject: Re: [PATCH RFC net] linux/dim: Fix divide 0 in RDMA DIM.
Message-ID: <YrluGtk3wawXlnag@FVFF87CCQ6LR.local>
References: <20220623085858.42945-1-thomas.liu@ucloud.cn>
 <YrlfSnNNdjkaajAg@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrlfSnNNdjkaajAg@unreal>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGE0dVh1CGUhLTUpJHRpLT1UZERMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVPQ1VKSUtVSkNNWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NlE6CQw4HDIWNQkRCDQcLR8z
        DigKCxhVSlVKTU5NSEpCTkpDTUhJVTMWGhIXVQ8TFBYaCFUXEg47DhgXFA4fVRgVRVlXWRILWUFZ
        SkpMVU9DVUpJS1VKQ01ZV1kIAVlBTkNJSDcG
X-HM-Tid: 0a81a4562653841dkuqw42a018a0324
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 27, 2022 at 10:42:02AM +0300, Leon Romanovsky wrote:
> On Thu, Jun 23, 2022 at 04:58:58PM +0800, Tao Liu wrote:
> > We hit a divide 0 error in ofed 5.1.2.3.7.1. But dim.c and
> > rdma_dim.c seem same as upstream.
> > 
> > CallTrace:
> >   Hardware name: H3C R4900 G3/RS33M2C9S, BIOS 2.00.37P21 03/12/2020
> >   task: ffff880194b78000 task.stack: ffffc90006714000
> >   RIP: 0010:backport_rdma_dim+0x10e/0x240 [mlx_compat]
> >   RSP: 0018:ffff880c10e83ec0 EFLAGS: 00010202
> >   RAX: 0000000000002710 RBX: ffff88096cd7f780 RCX: 0000000000000064
> >   RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
> >   RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> >   R10: 0000000000000000 R11: 0000000000000000 R12: 000000001d7c6c09
> >   R13: ffff88096cd7f780 R14: ffff880b174fe800 R15: 0000000000000000
> >   FS:  0000000000000000(0000) GS:ffff880c10e80000(0000)
> >   knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 00000000a0965b00 CR3: 000000000200a003 CR4: 00000000007606e0
> >   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >   PKRU: 55555554
> >   Call Trace:
> >    <IRQ>
> >    ib_poll_handler+0x43/0x80 [ib_core]
> >    irq_poll_softirq+0xae/0x110
> >    __do_softirq+0xd1/0x28c
> >    irq_exit+0xde/0xf0
> >    do_IRQ+0x54/0xe0
> >    common_interrupt+0x8f/0x8f
> >    </IRQ>
> >    ? cpuidle_enter_state+0xd9/0x2a0
> >    ? cpuidle_enter_state+0xc7/0x2a0
> >    ? do_idle+0x170/0x1d0
> >    ? cpu_startup_entry+0x6f/0x80
> >    ? start_secondary+0x1b9/0x210
> >    ? secondary_startup_64+0xa5/0xb0
> >   Code: 0f 87 e1 00 00 00 8b 4c 24 14 44 8b 43 14 89 c8 4d 63 c8 44 29 c0 99 31 d0 29 d0 31 d2 48 98 48 8d 04 80 48 8d 04 80 48 c1 e0 02 <49> f7 f1 48 83 f8 0a 0f 86 c1 00 00 00 44 39 c1 7f 10 48 89 df
> >   RIP: backport_rdma_dim+0x10e/0x240 [mlx_compat] RSP: ffff880c10e83ec0
> > 
> > crash> struct dim ffff88096cd7f780
> > struct dim {
> >   state = 1 '\001',
> >   prev_stats = {
> >       ppms = 2142150514,
> >       bpms = 391112768,
> >       epms = -30709,
> >       cpms = 1,
> >       cpe_ratio = 0
> >     },
> >   start_sample = {
> >       time = 51174507127193614,
> >       pkt_ctr = 0,
> >       byte_ctr = 0,
> >       event_ctr = 1,
> >       comp_ctr = 494693321
> >     },
> >   measuring_sample = {
> >       time = 51174507266581985,
> >       pkt_ctr = 0,
> >       byte_ctr = 0,
> >       event_ctr = 65,
> >       comp_ctr = 494693385
> >     },
> >   work = {
> >       data = {
> >             counter = 128
> >           },
> >       entry = {
> >             next = 0xffff88096cd7f7d0,
> >             prev = 0xffff88096cd7f7d0
> >           },
> >       func = 0xffffffffa02b9f80
> >     },
> >   priv = 0xffff880b174fe800,
> >   profile_ix = 1 '\001',
> >   mode = 0 '\000',
> >   tune_state = 2 '\002',
> >   steps_right = 1 '\001',
> >   steps_left = 1 '\001',
> >   tired = 0 '\000'
> > }
> > 
> > Fixes: f4915455dcf0 ("linux/dim: Implement RDMA adaptive moderation (DIM)")
> > Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> > ---
> >  lib/dim/rdma_dim.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> I think that this change will be better as it won't change
> decision order in rdma_dim_stats_compare()
> 
> diff --git a/include/linux/dim.h b/include/linux/dim.h
> index b698266d0035..69ae238ec2dc 100644
> --- a/include/linux/dim.h
> +++ b/include/linux/dim.h
> @@ -21,7 +21,7 @@
>   * We consider 10% difference as significant.
>   */
>  #define IS_SIGNIFICANT_DIFF(val, ref) \
> -       (((100UL * abs((val) - (ref))) / (ref)) > 10)
> +       (ref && (((100UL * abs((val) - (ref))) / (ref)) > 10))
>  
>  /*
>   * Calculate the gap between two values.
> 
> 
Reviewed code in net_dim_stats_compare() and rdma_dim_stats_compare(), the
crash point is the only place not covered 0 condition. So it maybe not
need to change the macro.

But I am not familiar with the algorithm, and not sure what is the right
return value.
> > 
> > diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
> > index 15462d54758d..a657b106343c 100644
> > --- a/lib/dim/rdma_dim.c
> > +++ b/lib/dim/rdma_dim.c
> > @@ -34,6 +34,9 @@ static int rdma_dim_stats_compare(struct dim_stats *curr,
> >  		return (curr->cpms > prev->cpms) ? DIM_STATS_BETTER :
> >  						DIM_STATS_WORSE;
> >  
> > +	if (!prev->cpe_ratio)
> > +		return DIM_STATS_SAME;
> > +
> >  	if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, prev->cpe_ratio))
> >  		return (curr->cpe_ratio > prev->cpe_ratio) ? DIM_STATS_BETTER :
> >  						DIM_STATS_WORSE;
> > -- 
> > 2.30.1 (Apple Git-130)
> > 
> 
