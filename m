Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D150F58230D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiG0J0V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiG0J0U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 05:26:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DDC14D31
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 02:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0322B81F87
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 09:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E394C433C1;
        Wed, 27 Jul 2022 09:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658913976;
        bh=4SXMgqCWXolEg4588A5vGX3UQ1vQsj4y6Amt6DN7Eb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIOoA2kYTvXmxYlESNBxUbSP2xD25SmHCd48PqWFLmvexT1N4YKm9SS8KvXZsd/db
         oYUoMI18nEdbUvM1oDisJFPkjpg6FjHXDs2rG+msSDMiBvmO8AOaCErb0/+Ibrijkp
         zVdMVTenQ67Nlu7KBd/sVP48d2Qy/Rhg/KvB03pUHl88RA/wURbeg2B3eLdom13uY/
         iBn3cZUEtPZHDbfkGKsWrkI/P3zTmP6YI3GqnH1UaTBfFS8+oJz6RC/ZsyZG6ICPp0
         B3q8ED6v6JrhelHSoHK+NUhuYbUSMgm6PmG9lGkZvfooM1pmTlboEYo91u6kSqMP6/
         to5Q14N2NXnxg==
Date:   Wed, 27 Jul 2022 12:26:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH for-next v2] Revert "RDMA/rxe: Create duplicate mapping
 tables for FMRs"
Message-ID: <YuEEtGW0BPUoPnr3@unreal>
References: <1658805386-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658805386-2-1-git-send-email-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 26, 2022 at 03:16:26AM +0000, Li Zhijian wrote:
> Below 2 commits will be reverted:
>  commit 8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
>  commit 647bf13ce944 ("RDMA/rxe: Create duplicate mapping tables for FMRs")
> 
> The community has a few bug reports which pointed this commit at last.
> Some proposals are raised up in the meantime but all of them have no
> follow-up operation.
> 
> The previous commit led the map_set of FMR to be not available any more if
> the MR is registered again after invalidating. Although the mentioned
> patch try to fix a potential race in building/accessing the same table
> for fast memory regions, it broke rtrs etc ULPs. Since the latter could
> be worse, revert this patch.
> 
> With previous commit, it's observed that a same MR in rnbd server will
> trigger below code path:
>  -> rxe_mr_init_fast()
>  |-> alloc map_set() # map_set is uninitialized
>  |...-> rxe_map_mr_sg() # build the map_set
>      |-> rxe_mr_set_page()
>  |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE that means
>                           # we can access host memory(such rxe_mr_copy)
>  |...-> rxe_invalidate_mr() # mr->state change to FREE from VALID
>  |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE,
>                           # but map_set was not built again
>  |...-> rxe_mr_copy() # kernel crash due to access wild addresses
>                       # that lookup from the map_set
> 
> The backtraces are not always identical.
> [1st]----------
> [   80.163579] RIP: 0010:lookup_iova+0x66/0xa0 [rdma_rxe]
> [   80.164825] Code: 00 00 00 48 d3 ee 89 32 c3 4c 8b 18 49 8b 3b 48 8b 47 08 48 39 c6 72 38 48 29 c6 45 31 d2 b8 01 00 00 00 48 63 c8 48 c1 e1 04 <48> 8b 4c 0f 08 48 39 f1 77 21 83 c0 01 48 29 ce 3d 00 01 00 00 75
> [   80.168935] RSP: 0018:ffffb7ff80063bf0 EFLAGS: 00010246
> [   80.170333] RAX: 0000000000000000 RBX: ffff9b9949d86800 RCX: 0000000000000000
> [   80.171976] RDX: ffffb7ff80063c00 RSI: 0000000049f6b378 RDI: 002818da00000004
> [   80.173606] RBP: 0000000000000120 R08: ffffb7ff80063c08 R09: ffffb7ff80063c04
> [   80.176933] R10: 0000000000000002 R11: ffff9b9916f7eef8 R12: ffff9b99488a0038
> [   80.178526] R13: ffff9b99488a0038 R14: ffff9b9914fb346a R15: ffff9b990ab27000
> [   80.180378] FS:  0000000000000000(0000) GS:ffff9b997dc00000(0000) knlGS:0000000000000000
> [   80.182257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   80.183577] CR2: 00007efc33a98ed0 CR3: 0000000014f32004 CR4: 00000000001706f0
> [   80.185210] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   80.186890] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   80.188517] Call Trace:
> [   80.189269]  <TASK>
> [   80.189949]  rxe_mr_copy.part.0+0x6f/0x140 [rdma_rxe]
> [   80.191173]  rxe_responder+0x12ee/0x1b60 [rdma_rxe]
> [   80.192409]  ? rxe_icrc_check+0x7e/0x100 [rdma_rxe]
> [   80.193576]  ? rxe_rcv+0x1d0/0x780 [rdma_rxe]
> [   80.194668]  ? rxe_icrc_hdr.isra.0+0xf6/0x160 [rdma_rxe]
> [   80.195952]  rxe_do_task+0x67/0xb0 [rdma_rxe]
> [   80.197081]  rxe_xmit_packet+0xc7/0x210 [rdma_rxe]
> [   80.198253]  rxe_requester+0x680/0xee0 [rdma_rxe]
> [   80.199439]  ? update_load_avg+0x5f/0x690
> [   80.200530]  ? update_load_avg+0x5f/0x690
> [   80.213968]  ? rtrs_clt_recv_done+0x1b/0x30 [rtrs_client]
> 
> [2nd]----------
> [ 5213.049494] RIP: 0010:rxe_mr_copy.part.0+0xa8/0x140 [rdma_rxe]
> [ 5213.050978] Code: 00 00 49 c1 e7 04 48 8b 00 4c 8d 2c d0 48 8b 44 24 10 4d 03 7d 00 85 ed 7f 10 eb 6c 89 54 24 0c 49 83 c7 10 31 c0 85 ed 7e 5e <49> 8b 3f 8b 14 24 4c 89 f6 48 01 c7 85 d2 74 06 48 89 fe 4c 89 f7
> [ 5213.056463] RSP: 0018:ffffae3580063bf8 EFLAGS: 00010202
> [ 5213.057986] RAX: 0000000000018978 RBX: ffff9d7ef7a03600 RCX: 0000000000000008
> [ 5213.059797] RDX: 000000000000007c RSI: 000000000000007c RDI: ffff9d7ef7a03600
> [ 5213.061720] RBP: 0000000000000120 R08: ffffae3580063c08 R09: ffffae3580063c04
> [ 5213.063532] R10: ffff9d7efece0038 R11: ffff9d7ec4b1db00 R12: ffff9d7efece0038
> [ 5213.065445] R13: ffff9d7ef4098260 R14: ffff9d7f11e23c6a R15: 4c79500065708144
> [ 5213.067264] FS:  0000000000000000(0000) GS:ffff9d7f3dc00000(0000) knlGS:0000000000000000
> [ 5213.069442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5213.071004] CR2: 00007fce47276c60 CR3: 0000000003f66004 CR4: 00000000001706f0
> [ 5213.072827] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 5213.074484] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 5213.076292] Call Trace:
> [ 5213.077027]  <TASK>
> [ 5213.077718]  rxe_responder+0x12ee/0x1b60 [rdma_rxe]
> [ 5213.079019]  ? rxe_icrc_check+0x7e/0x100 [rdma_rxe]
> [ 5213.080380]  ? rxe_rcv+0x1d0/0x780 [rdma_rxe]
> [ 5213.081708]  ? rxe_icrc_hdr.isra.0+0xf6/0x160 [rdma_rxe]
> [ 5213.082990]  rxe_do_task+0x67/0xb0 [rdma_rxe]
> [ 5213.084030]  rxe_xmit_packet+0xc7/0x210 [rdma_rxe]
> [ 5213.085156]  rxe_requester+0x680/0xee0 [rdma_rxe]
> [ 5213.088258]  ? update_load_avg+0x5f/0x690
> [ 5213.089381]  ? update_load_avg+0x5f/0x690
> [ 5213.090446]  ? rtrs_clt_recv_done+0x1b/0x30 [rtrs_client]
> [ 5213.092087]  rxe_do_task+0x67/0xb0 [rdma_rxe]
> [ 5213.093125]  tasklet_action_common.constprop.0+0x92/0xc0
> [ 5213.094366]  __do_softirq+0xe1/0x2d8
> [ 5213.095287]  run_ksoftirqd+0x21/0x30
> [ 5213.096456]  smpboot_thread_fn+0x183/0x220
> [ 5213.097519]  ? sort_range+0x20/0x20
> [ 5213.098761]  kthread+0xe2/0x110
> [ 5213.099638]  ? kthread_complete_and_exit+0x20/0x20
> [ 5213.100948]  ret_from_fork+0x22/0x30
> 
> Link: https://lore.kernel.org/all/20220210073655.42281-1-guoqing.jiang@linux.dev/T/
> Link: https://www.spinics.net/lists/linux-rdma/msg110836.html
> Link: https://lore.kernel.org/lkml/94a5ea93-b8bb-3a01-9497-e2021f29598a@linux.dev/t/
> 
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> CC: Haris Iqbal <haris.iqbal@ionos.com>
> CC: Guoqing Jiang <guoqing.jiang@linux.dev>
> Tested-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2: fix commit log
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   |   1 -
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 199 +++++++++++-----------------------
>  drivers/infiniband/sw/rxe/rxe_mw.c    |   6 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  39 +++++--
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  21 ++--
>  5 files changed, 104 insertions(+), 162 deletions(-)
> 

Thanks, applied.
