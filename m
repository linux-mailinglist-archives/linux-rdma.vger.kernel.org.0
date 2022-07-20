Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6F57B401
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiGTJjV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 05:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiGTJjU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 05:39:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C21624A9
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 02:39:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a10so20464617ljj.5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVaXcrMYgL70/QfOwws5WlmusO00WAzJjJtMAmj9+B0=;
        b=YLfAMH3RUX8N/7v/J4Tp99vIWXOI0U9F23eA41bUaOBBr2oZl6P/OIo4vEVI5/OV2q
         u11OD8v2ZlhOBCpU1Xp072VV0SVEWA/qLQFMHi6BfNInTySsjqfRacMfYnwmn2dqGi8r
         10dF9QzMYLOAWl4g22glORCJnBFH/7evxzvaU+EWA912Va2HPF4EiTyV42f4GkCjPavG
         JQuK2dlMgIRwu2p9bY3nt7EV8aGHNgC+embFCAelzW8HzMJr3D+0oNpueQW/zr7/AxDe
         xZfOK54/EnF1L7k8LBR+PADe4CEwdjWYh2Df/+RIcphbJSed6WygQu7PXHE6h/P+oVj+
         k7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVaXcrMYgL70/QfOwws5WlmusO00WAzJjJtMAmj9+B0=;
        b=KxDyOwTMPQ+AuvkTB1pU+ji6Q10lp3TJwC7ELm53WRhRxBHh2hPMBlu2Q5wui3pfnO
         86Z9xyMN1sQXEYKq86Gy5WF0q3tOXwEYtrLcBxfsrWa1vKNaMBVO7wGFzCL/6BODBBjQ
         +wQmAfS2I5iaFfwtZ6QqW0QD3Y5Wq7UrHJIsQF2QBa4gNloiCmvv3jDvMvBekiTuRbBM
         16SSXhVzfC7hg49y3TTLf9MzTfCffOr7a1DTVXAWNgFaFzgc789l5r04Axq3VSfoBFre
         obj8E+Np2RXnyyF/hozQfA7Uc909rH3Qa6FzLbtzWHVNDaqtiZq3J91WmIEiApyHBJg5
         x2og==
X-Gm-Message-State: AJIora9eEb2kpHNrRDqfEryPTJF+lTc2mP5vJ5+jvuJGULXXUlSvF8JX
        4weJN66cWFn6qXtd94xjlksb978ZiKEKfZpB6cFre60tWjvmig==
X-Google-Smtp-Source: AGRyM1sc+8xF2C6NZCi/IjGYE+fpI1egJ0f3aYjT8f8jpbKqsDbezYP47+EnsyWR4rz9UeGYrmZ7q2BFDCIYkliWLf8=
X-Received: by 2002:a05:651c:11c5:b0:25d:d6a8:3758 with SMTP id
 z5-20020a05651c11c500b0025dd6a83758mr1010473ljo.481.1658309955684; Wed, 20
 Jul 2022 02:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220720035700.2076987-1-lizhijian@fujitsu.com>
In-Reply-To: <20220720035700.2076987-1-lizhijian@fujitsu.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 20 Jul 2022 11:39:04 +0200
Message-ID: <CAJpMwyjAsU-prCai30wbZZ+LWbjhX6hcsxbd1rmR8m5D6SjiPA@mail.gmail.com>
Subject: Re: [RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate mapping
 tables for FMRs"
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 20, 2022 at 5:50 AM lizhijian@fujitsu.com
<lizhijian@fujitsu.com> wrote:
>
> Below 2 commits will be reverted:
>      8ff5f5d9d8cf ("RDMA/rxe: Prevent double freeing rxe_map_set()")
>      647bf13ce944 ("RDMA/rxe: Create duplicate mapping tables for FMRs")
>
> The community has a few bug reports which pointed this commit at last.
> Some proposals are raised up in the meantime but all of them have no
> follow-up operation.
>
> The previous commit led the map_set of FMR to be not avaliable any more if
> the MR is registered again after invalidating. Although the mentioned
> patch try to fix a potential race in building/accessing the same table
> for fast memory regions, it broke rnbd etc ULPs. Since the latter could
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
> [   80.158930] CPU: 0 PID: 11 Comm: ksoftirqd/0 Not tainted 5.18.0-rc1-roce-flush+ #60                                                                                                                                         [0/9090]
> [   80.160736] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-27-g64f37cc530f1-prebuilt.qemu.org 04/01/2014
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
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   |   1 -
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 199 +++++++++-----------------
>  drivers/infiniband/sw/rxe/rxe_mw.c    |   6 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  39 +++--
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  21 ++-
>  5 files changed, 104 insertions(+), 162 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0e022ae1b8a5..e9437b53a269 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -79,7 +79,6 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
>  int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
>  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
> -int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
>  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
>  void rxe_mr_cleanup(struct rxe_pool_elem *elem);
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 9a5c2af6a56f..4f19e4133d84 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -24,7 +24,7 @@ u8 rxe_get_next_key(u32 last_key)
>
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>  {
> -       struct rxe_map_set *set = mr->cur_map_set;
> +
>
>         switch (mr->type) {
>         case IB_MR_TYPE_DMA:
> @@ -32,8 +32,8 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>
>         case IB_MR_TYPE_USER:
>         case IB_MR_TYPE_MEM_REG:
> -               if (iova < set->iova || length > set->length ||
> -                   iova > set->iova + set->length - length)
> +               if (iova < mr->iova || length > mr->length ||
> +                   iova > mr->iova + mr->length - length)
>                         return -EFAULT;
>                 return 0;
>
> @@ -65,89 +65,41 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
>         mr->map_shift = ilog2(RXE_BUF_PER_MAP);
>  }
>
> -static void rxe_mr_free_map_set(int num_map, struct rxe_map_set *set)
> -{
> -       int i;
> -
> -       for (i = 0; i < num_map; i++)
> -               kfree(set->map[i]);
> -
> -       kfree(set->map);
> -       kfree(set);
> -}
> -
> -static int rxe_mr_alloc_map_set(int num_map, struct rxe_map_set **setp)
> +static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
>  {
>         int i;
> -       struct rxe_map_set *set;
> +       int num_map;
> +       struct rxe_map **map = mr->map;
>
> -       set = kmalloc(sizeof(*set), GFP_KERNEL);
> -       if (!set)
> -               goto err_out;
> +       num_map = (num_buf + RXE_BUF_PER_MAP - 1) / RXE_BUF_PER_MAP;
>
> -       set->map = kmalloc_array(num_map, sizeof(struct rxe_map *), GFP_KERNEL);
> -       if (!set->map)
> -               goto err_free_set;
> +       mr->map = kmalloc_array(num_map, sizeof(*map), GFP_KERNEL);
> +       if (!mr->map)
> +               goto err1;
>
>         for (i = 0; i < num_map; i++) {
> -               set->map[i] = kmalloc(sizeof(struct rxe_map), GFP_KERNEL);
> -               if (!set->map[i])
> -                       goto err_free_map;
> +               mr->map[i] = kmalloc(sizeof(**map), GFP_KERNEL);
> +               if (!mr->map[i])
> +                       goto err2;
>         }
>
> -       *setp = set;
> -
> -       return 0;
> -
> -err_free_map:
> -       for (i--; i >= 0; i--)
> -               kfree(set->map[i]);
> -
> -       kfree(set->map);
> -err_free_set:
> -       kfree(set);
> -err_out:
> -       return -ENOMEM;
> -}
> -
> -/**
> - * rxe_mr_alloc() - Allocate memory map array(s) for MR
> - * @mr: Memory region
> - * @num_buf: Number of buffer descriptors to support
> - * @both: If non zero allocate both mr->map and mr->next_map
> - *       else just allocate mr->map. Used for fast MRs
> - *
> - * Return: 0 on success else an error
> - */
> -static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf, int both)
> -{
> -       int ret;
> -       int num_map;
> -
>         BUILD_BUG_ON(!is_power_of_2(RXE_BUF_PER_MAP));
> -       num_map = (num_buf + RXE_BUF_PER_MAP - 1) / RXE_BUF_PER_MAP;
>
>         mr->map_shift = ilog2(RXE_BUF_PER_MAP);
>         mr->map_mask = RXE_BUF_PER_MAP - 1;
> +
>         mr->num_buf = num_buf;
> -       mr->max_buf = num_map * RXE_BUF_PER_MAP;
>         mr->num_map = num_map;
> -
> -       ret = rxe_mr_alloc_map_set(num_map, &mr->cur_map_set);
> -       if (ret)
> -               return -ENOMEM;
> -
> -       if (both) {
> -               ret = rxe_mr_alloc_map_set(num_map, &mr->next_map_set);
> -               if (ret)
> -                       goto err_free;
> -       }
> +       mr->max_buf = num_map * RXE_BUF_PER_MAP;
>
>         return 0;
>
> -err_free:
> -       rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
> -       mr->cur_map_set = NULL;
> +err2:
> +       for (i--; i >= 0; i--)
> +               kfree(mr->map[i]);
> +
> +       kfree(mr->map);
> +err1:
>         return -ENOMEM;
>  }
>
> @@ -164,7 +116,6 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
>  int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>                      int access, struct rxe_mr *mr)
>  {
> -       struct rxe_map_set      *set;
>         struct rxe_map          **map;
>         struct rxe_phys_buf     *buf = NULL;
>         struct ib_umem          *umem;
> @@ -172,6 +123,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>         int                     num_buf;
>         void                    *vaddr;
>         int err;
> +       int i;
>
>         umem = ib_umem_get(pd->ibpd.device, start, length, access);
>         if (IS_ERR(umem)) {
> @@ -185,20 +137,18 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>
>         rxe_mr_init(access, mr);
>
> -       err = rxe_mr_alloc(mr, num_buf, 0);
> +       err = rxe_mr_alloc(mr, num_buf);
>         if (err) {
>                 pr_warn("%s: Unable to allocate memory for map\n",
>                                 __func__);
>                 goto err_release_umem;
>         }
>
> -       set = mr->cur_map_set;
> -       set->page_shift = PAGE_SHIFT;
> -       set->page_mask = PAGE_SIZE - 1;
> -
> -       num_buf = 0;
> -       map = set->map;
> +       mr->page_shift = PAGE_SHIFT;
> +       mr->page_mask = PAGE_SIZE - 1;
>
> +       num_buf                 = 0;
> +       map = mr->map;
>         if (length > 0) {
>                 buf = map[0]->buf;
>
> @@ -214,29 +164,33 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>                                 pr_warn("%s: Unable to get virtual address\n",
>                                                 __func__);
>                                 err = -ENOMEM;
> -                               goto err_release_umem;
> +                               goto err_cleanup_map;
>                         }
>
>                         buf->addr = (uintptr_t)vaddr;
>                         buf->size = PAGE_SIZE;
>                         num_buf++;
>                         buf++;
> +
>                 }
>         }
>
>         mr->ibmr.pd = &pd->ibpd;
>         mr->umem = umem;
>         mr->access = access;
> +       mr->length = length;
> +       mr->iova = iova;
> +       mr->va = start;
> +       mr->offset = ib_umem_offset(umem);
>         mr->state = RXE_MR_STATE_VALID;
>         mr->type = IB_MR_TYPE_USER;
>
> -       set->length = length;
> -       set->iova = iova;
> -       set->va = start;
> -       set->offset = ib_umem_offset(umem);
> -
>         return 0;
>
> +err_cleanup_map:
> +       for (i = 0; i < mr->num_map; i++)
> +               kfree(mr->map[i]);
> +       kfree(mr->map);
>  err_release_umem:
>         ib_umem_release(umem);
>  err_out:
> @@ -250,7 +204,7 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
>         /* always allow remote access for FMRs */
>         rxe_mr_init(IB_ACCESS_REMOTE, mr);
>
> -       err = rxe_mr_alloc(mr, max_pages, 1);
> +       err = rxe_mr_alloc(mr, max_pages);
>         if (err)
>                 goto err1;
>
> @@ -268,24 +222,21 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
>  static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
>                         size_t *offset_out)
>  {
> -       struct rxe_map_set *set = mr->cur_map_set;
> -       size_t offset = iova - set->iova + set->offset;
> +       size_t offset = iova - mr->iova + mr->offset;
>         int                     map_index;
>         int                     buf_index;
>         u64                     length;
> -       struct rxe_map *map;
>
> -       if (likely(set->page_shift)) {
> -               *offset_out = offset & set->page_mask;
> -               offset >>= set->page_shift;
> +       if (likely(mr->page_shift)) {
> +               *offset_out = offset & mr->page_mask;
> +               offset >>= mr->page_shift;
>                 *n_out = offset & mr->map_mask;
>                 *m_out = offset >> mr->map_shift;
>         } else {
>                 map_index = 0;
>                 buf_index = 0;
>
> -               map = set->map[map_index];
> -               length = map->buf[buf_index].size;
> +               length = mr->map[map_index]->buf[buf_index].size;
>
>                 while (offset >= length) {
>                         offset -= length;
> @@ -295,8 +246,7 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
>                                 map_index++;
>                                 buf_index = 0;
>                         }
> -                       map = set->map[map_index];
> -                       length = map->buf[buf_index].size;
> +                       length = mr->map[map_index]->buf[buf_index].size;
>                 }
>
>                 *m_out = map_index;
> @@ -317,7 +267,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>                 goto out;
>         }
>
> -       if (!mr->cur_map_set) {
> +       if (!mr->map) {
>                 addr = (void *)(uintptr_t)iova;
>                 goto out;
>         }
> @@ -330,13 +280,13 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>
>         lookup_iova(mr, iova, &m, &n, &offset);
>
> -       if (offset + length > mr->cur_map_set->map[m]->buf[n].size) {
> +       if (offset + length > mr->map[m]->buf[n].size) {
>                 pr_warn("crosses page boundary\n");
>                 addr = NULL;
>                 goto out;
>         }
>
> -       addr = (void *)(uintptr_t)mr->cur_map_set->map[m]->buf[n].addr + offset;
> +       addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
>
>  out:
>         return addr;
> @@ -372,7 +322,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>                 return 0;
>         }
>
> -       WARN_ON_ONCE(!mr->cur_map_set);
> +       WARN_ON_ONCE(!mr->map);
>
>         err = mr_check_range(mr, iova, length);
>         if (err) {
> @@ -382,7 +332,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>
>         lookup_iova(mr, iova, &m, &i, &offset);
>
> -       map = mr->cur_map_set->map + m;
> +       map = mr->map + m;
>         buf     = map[0]->buf + i;
>
>         while (length > 0) {
> @@ -628,9 +578,8 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
>  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>  {
>         struct rxe_mr *mr = to_rmr(wqe->wr.wr.reg.mr);
> -       u32 key = wqe->wr.wr.reg.key & 0xff;
> +       u32 key = wqe->wr.wr.reg.key;
>         u32 access = wqe->wr.wr.reg.access;
> -       struct rxe_map_set *set;
>
>         /* user can only register MR in free state */
>         if (unlikely(mr->state != RXE_MR_STATE_FREE)) {
> @@ -646,36 +595,19 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>                 return -EINVAL;
>         }
>
> +       /* user is only allowed to change key portion of l/rkey */
> +       if (unlikely((mr->lkey & ~0xff) != (key & ~0xff))) {
> +               pr_warn("%s: key = 0x%x has wrong index mr->lkey = 0x%x\n",
> +                       __func__, key, mr->lkey);
> +               return -EINVAL;
> +       }
> +
>         mr->access = access;
> -       mr->lkey = (mr->lkey & ~0xff) | key;
> -       mr->rkey = (access & IB_ACCESS_REMOTE) ? mr->lkey : 0;
> +       mr->lkey = key;
> +       mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
> +       mr->iova = wqe->wr.wr.reg.mr->iova;
>         mr->state = RXE_MR_STATE_VALID;
>
> -       set = mr->cur_map_set;
> -       mr->cur_map_set = mr->next_map_set;
> -       mr->cur_map_set->iova = wqe->wr.wr.reg.mr->iova;
> -       mr->next_map_set = set;
> -
> -       return 0;
> -}
> -
> -int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr)
> -{
> -       struct rxe_mr *mr = to_rmr(ibmr);
> -       struct rxe_map_set *set = mr->next_map_set;
> -       struct rxe_map *map;
> -       struct rxe_phys_buf *buf;
> -
> -       if (unlikely(set->nbuf == mr->num_buf))
> -               return -ENOMEM;
> -
> -       map = set->map[set->nbuf / RXE_BUF_PER_MAP];
> -       buf = &map->buf[set->nbuf % RXE_BUF_PER_MAP];
> -
> -       buf->addr = addr;
> -       buf->size = ibmr->page_size;
> -       set->nbuf++;
> -
>         return 0;
>  }
>
> @@ -695,14 +627,15 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  void rxe_mr_cleanup(struct rxe_pool_elem *elem)
>  {
>         struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
> +       int i;
>
>         rxe_put(mr_pd(mr));
> -
>         ib_umem_release(mr->umem);
>
> -       if (mr->cur_map_set)
> -               rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
> +       if (mr->map) {
> +               for (i = 0; i < mr->num_map; i++)
> +                       kfree(mr->map[i]);
>
> -       if (mr->next_map_set)
> -               rxe_mr_free_map_set(mr->num_map, mr->next_map_set);
> +               kfree(mr->map);
> +       }
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> index bb6a1edaaee8..7c8ff3232234 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -121,15 +121,15 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>
>         /* C10-75 */
>         if (mw->access & IB_ZERO_BASED) {
> -               if (unlikely(wqe->wr.wr.mw.length > mr->cur_map_set->length)) {
> +               if (unlikely(wqe->wr.wr.mw.length > mr->length)) {
>                         pr_err_once(
>                                 "attempt to bind a ZB MW outside of the MR\n");
>                         return -EINVAL;
>                 }
>         } else {
> -               if (unlikely((wqe->wr.wr.mw.addr < mr->cur_map_set->iova) ||
> +               if (unlikely((wqe->wr.wr.mw.addr < mr->iova) ||
>                              ((wqe->wr.wr.mw.addr + wqe->wr.wr.mw.length) >
> -                             (mr->cur_map_set->iova + mr->cur_map_set->length)))) {
> +                             (mr->iova + mr->length)))) {
>                         pr_err_once(
>                                 "attempt to bind a VA MW outside of the MR\n");
>                         return -EINVAL;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 151c6280abd5..e264cf69bf55 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -978,26 +978,41 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>         return ERR_PTR(err);
>  }
>
> -/* build next_map_set from scatterlist
> - * The IB_WR_REG_MR WR will swap map_sets
> - */
> +static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
> +{
> +       struct rxe_mr *mr = to_rmr(ibmr);
> +       struct rxe_map *map;
> +       struct rxe_phys_buf *buf;
> +
> +       if (unlikely(mr->nbuf == mr->num_buf))
> +               return -ENOMEM;
> +
> +       map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
> +       buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
> +
> +       buf->addr = addr;
> +       buf->size = ibmr->page_size;
> +       mr->nbuf++;
> +
> +       return 0;
> +}
> +
>  static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>                          int sg_nents, unsigned int *sg_offset)
>  {
>         struct rxe_mr *mr = to_rmr(ibmr);
> -       struct rxe_map_set *set = mr->next_map_set;
>         int n;
>
> -       set->nbuf = 0;
> +       mr->nbuf = 0;
>
> -       n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_mr_set_page);
> +       n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
>
> -       set->va = ibmr->iova;
> -       set->iova = ibmr->iova;
> -       set->length = ibmr->length;
> -       set->page_shift = ilog2(ibmr->page_size);
> -       set->page_mask = ibmr->page_size - 1;
> -       set->offset = set->iova & set->page_mask;
> +       mr->va = ibmr->iova;
> +       mr->iova = ibmr->iova;
> +       mr->length = ibmr->length;
> +       mr->page_shift = ilog2(ibmr->page_size);
> +       mr->page_mask = ibmr->page_size - 1;
> +       mr->offset = mr->iova & mr->page_mask;
>
>         return n;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 628e40c1714b..4108dc6565e9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -286,17 +286,6 @@ struct rxe_map {
>         struct rxe_phys_buf     buf[RXE_BUF_PER_MAP];
>  };
>
> -struct rxe_map_set {
> -       struct rxe_map          **map;
> -       u64                     va;
> -       u64                     iova;
> -       size_t                  length;
> -       u32                     offset;
> -       u32                     nbuf;
> -       int                     page_shift;
> -       int                     page_mask;
> -};
> -
>  static inline int rkey_is_mw(u32 rkey)
>  {
>         u32 index = rkey >> 8;
> @@ -314,20 +303,26 @@ struct rxe_mr {
>         u32                     rkey;
>         enum rxe_mr_state       state;
>         enum ib_mr_type         type;
> +       u64                     va;
> +       u64                     iova;
> +       size_t                  length;
> +       u32                     offset;
>         int                     access;
>
> +       int                     page_shift;
> +       int                     page_mask;
>         int                     map_shift;
>         int                     map_mask;
>
>         u32                     num_buf;
> +       u32                     nbuf;
>
>         u32                     max_buf;
>         u32                     num_map;
>
>         atomic_t                num_mw;
>
> -       struct rxe_map_set      *cur_map_set;
> -       struct rxe_map_set      *next_map_set;
> +       struct rxe_map          **map;
>  };
>
>  enum rxe_mw_state {
> --

There seems to be some problem with this email/patch. Downloading it
generates a file without code but something else. The raw version
below also looks mangled.

https://lore.kernel.org/linux-rdma/20220720035700.2076987-1-lizhijian@fujitsu.com/raw

> 2.31.1
