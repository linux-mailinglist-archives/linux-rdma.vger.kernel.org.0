Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79D5B2416
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiIHQ6r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiIHQ6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 12:58:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B13ED6F
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 09:58:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u6so25273218eda.12
        for <linux-rdma@vger.kernel.org>; Thu, 08 Sep 2022 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fdN0NiEhCFD/RsYtUZRFeLe9CN44coSoPfvCSXs8mjQ=;
        b=JdV5QttbV8NePye6mB/fr5Cug70ptnZTimezkPfX43wiaTHGQvbM04zYfaL9mkwQds
         JNQZQZdJIkDfI4+JkOI8ngn/VDH7l1Wzi4d5XC6kxcqXGMxI6cS/Raf4v/1rh55nL+Df
         822AEwPp2G7MreY7wgvel6H62jCTtVdR/5/w1vRGUdpXZryC7WsyEp+GqC1pV5OLP8OG
         S+xwSpxPRUpVU9nds08SKX7lhdDShk5kztD9Z4uzuolXYwrJe5fixsnR66u8SK69QOfU
         we7DCwExp9YZawZ41SKF612qlQ6OWq4NpDmYOGgPLz1x4XaVspqiUIQqJQTwQ8DjRKLQ
         Zomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fdN0NiEhCFD/RsYtUZRFeLe9CN44coSoPfvCSXs8mjQ=;
        b=B8Fg2bmQGHUILXCBiv9hinugIKE6yLt8sn5KX8XUDCbAnNfzgjwc+8mfz+009fmM5K
         PmlTyJ72wk7p6Koa3LjgUiRwb6MpDnRwrsIYTAvOEDlIBU8hgxEyPHMl1iLhSxkDAShX
         XN6m9/+eLVtw4KK2BFVQU5ZPd9mp7jydJ8YwynSBpwOFg1aMwtha6Syn6jdHPBpRqUo+
         zNmB6+Q7ov2yri147izfNc/auNMxSHJuwjiuEQXDIw8wJKa+Zilrt8OsyS4ISUWCSQuj
         fuJ7vL0KNuuLnDlZe3OM23KXp1S8tQ2dEbyYBfbyH5qzTqELtIyKFCK67jcLYGmM3peY
         AxfQ==
X-Gm-Message-State: ACgBeo05VDIrqpAHtd3cYRVToXKy5EpJvK0apZEUEPeamBTALp3cJuuM
        LYAvxF5fI49ulhyqbRHOI+W15YF1ee7+sUEANHD3UQ==
X-Google-Smtp-Source: AA6agR6HDOjTIIbBXbiiVbjJOkVchFonRNdcWkDi4CVHxDuaUevf+fUM2gBlB5TzqScsiELAVa5c0aAvOwXh3QJf4RE=
X-Received: by 2002:a05:6402:350b:b0:43e:f4be:c447 with SMTP id
 b11-20020a056402350b00b0043ef4bec447mr8231548edd.427.1662656285595; Thu, 08
 Sep 2022 09:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com> <b416663effb891cc63fff4ea11d0a8d24ba1706e.1662461897.git.matsuda-daisuke@fujitsu.com>
In-Reply-To: <b416663effb891cc63fff4ea11d0a8d24ba1706e.1662461897.git.matsuda-daisuke@fujitsu.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 8 Sep 2022 18:57:54 +0200
Message-ID: <CAJpMwyg7S-NErAfyJohWkGNXiWuSKnu9NrsjnbyYHMAOojjPpw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] RDMA/rxe: Allow registering MRs for On-Demand Paging
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        haris iqbal <haris.phnx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 7, 2022 at 4:45 AM Daisuke Matsuda
<matsuda-daisuke@fujitsu.com> wrote:
>
> Allow applications to register an ODP-enabled MR, in which case the flag
> IB_ACCESS_ON_DEMAND is passed to rxe_reg_user_mr(). However, there is no
> RDMA operation supported right now. They will be enabled later in the
> subsequent two patches.
>
> rxe_odp_do_pagefault() is called to initialize an ODP-enabled MR here.
> It syncs process address space from the CPU page table to the driver page
> table(dma_list/pfn_list in umem_odp) when called with a
> RXE_PAGEFAULT_SNAPSHOT flag. Additionally, It can be used to trigger page
> fault when pages being accessed are not present or do not have proper
> read/write permissions and possibly to prefetch pages in the future.
>
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       |  7 +++
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  5 ++
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  7 ++-
>  drivers/infiniband/sw/rxe/rxe_odp.c   | 80 +++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 21 +++++--
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  8 ++-
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +
>  7 files changed, 121 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 51daac5c4feb..0719f451253c 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -73,6 +73,13 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>                         rxe->ndev->dev_addr);
>
>         rxe->max_ucontext                       = RXE_MAX_UCONTEXT;
> +
> +       if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
> +               rxe->attr.kernel_cap_flags |= IBK_ON_DEMAND_PAGING;
> +
> +               /* IB_ODP_SUPPORT_IMPLICIT is not supported right now. */
> +               rxe->attr.odp_caps.general_caps |= IB_ODP_SUPPORT;
> +       }
>  }
>
>  /* initialize port attributes */
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0f8cb9e38cc9..03b4078b90a3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -64,6 +64,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
>
>  /* rxe_mr.c */
>  u8 rxe_get_next_key(u32 last_key);
> +void rxe_mr_init(int access, struct rxe_mr *mr);
>  void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
>  int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>                      int access, struct rxe_mr *mr);
> @@ -188,4 +189,8 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
>         return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
>  }
>
> +/* rxe_odp.c */
> +int rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
> +                          int access_flags, struct rxe_mr *mr);
> +
>  #endif /* RXE_LOC_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 814116ec4778..0ae72a4516be 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -48,7 +48,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>                                 | IB_ACCESS_REMOTE_WRITE        \
>                                 | IB_ACCESS_REMOTE_ATOMIC)
>
> -static void rxe_mr_init(int access, struct rxe_mr *mr)
> +void rxe_mr_init(int access, struct rxe_mr *mr)
>  {
>         u32 lkey = mr->elem.index << 8 | rxe_get_next_key(-1);
>         u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
> @@ -438,7 +438,10 @@ int copy_data(
>                 if (bytes > 0) {
>                         iova = sge->addr + offset;
>
> -                       err = rxe_mr_copy(mr, iova, addr, bytes, dir);
> +                       if (mr->odp_enabled)
> +                               err = -EOPNOTSUPP;
> +                       else
> +                               err = rxe_mr_copy(mr, iova, addr, bytes, dir);
>                         if (err)
>                                 goto err2;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 0f702787a66e..1f6930ba714c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -5,6 +5,8 @@
>
>  #include <rdma/ib_umem_odp.h>
>
> +#include "rxe.h"
> +
>  bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
>                              const struct mmu_notifier_range *range,
>                              unsigned long cur_seq)
> @@ -32,3 +34,81 @@ bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
>  const struct mmu_interval_notifier_ops rxe_mn_ops = {
>         .invalidate = rxe_ib_invalidate_range,
>  };
> +
> +#define RXE_PAGEFAULT_RDONLY BIT(1)
> +#define RXE_PAGEFAULT_SNAPSHOT BIT(2)
> +static int rxe_odp_do_pagefault(struct rxe_mr *mr, u64 user_va, int bcnt, u32 flags)
> +{
> +       int np;
> +       u64 access_mask;
> +       bool fault = !(flags & RXE_PAGEFAULT_SNAPSHOT);
> +       struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +
> +       access_mask = ODP_READ_ALLOWED_BIT;
> +       if (umem_odp->umem.writable && !(flags & RXE_PAGEFAULT_RDONLY))
> +               access_mask |= ODP_WRITE_ALLOWED_BIT;
> +
> +       /*
> +        * umem mutex is held after return from ib_umem_odp_map_dma_and_lock().
> +        * Release it when access to user MR is done or not required.
> +        */
> +       np = ib_umem_odp_map_dma_and_lock(umem_odp, user_va, bcnt,
> +                                         access_mask, fault);
> +
> +       return np;
> +}
> +
> +static int rxe_init_odp_mr(struct rxe_mr *mr)
> +{
> +       int ret;
> +       struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +
> +       ret = rxe_odp_do_pagefault(mr, mr->umem->address, mr->umem->length,
> +                                  RXE_PAGEFAULT_SNAPSHOT);
> +       mutex_unlock(&umem_odp->umem_mutex);
> +
> +       return ret >= 0 ? 0 : ret;
> +}
> +
> +int rxe_create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length, u64 iova,
> +                          int access_flags, struct rxe_mr *mr)
> +{
> +       int err;
> +       struct ib_umem_odp *umem_odp;
> +       struct rxe_dev *dev = container_of(pd->device, struct rxe_dev, ib_dev);
> +
> +       if (!IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
> +               return -EOPNOTSUPP;
> +
> +       rxe_mr_init(access_flags, mr);
> +
> +       if (!start && length == U64_MAX) {
> +               if (iova != 0)
> +                       return -EINVAL;
> +               if (!(dev->attr.odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
> +                       return -EINVAL;
> +
> +               /* Never reach here, for implicit ODP is not implemented. */
> +       }
> +
> +       umem_odp = ib_umem_odp_get(pd->device, start, length, access_flags,
> +                                  &rxe_mn_ops);
> +       if (IS_ERR(umem_odp))
> +               return PTR_ERR(umem_odp);
> +
> +       umem_odp->private = mr;
> +
> +       mr->odp_enabled = true;
> +       mr->ibmr.pd = pd;
> +       mr->umem = &umem_odp->umem;
> +       mr->access = access_flags;
> +       mr->length = length;
> +       mr->iova = iova;
> +       mr->offset = ib_umem_offset(&umem_odp->umem);
> +       mr->state = RXE_MR_STATE_VALID;
> +       mr->type = IB_MR_TYPE_USER;
> +
> +       err = rxe_init_odp_mr(mr);
> +
> +       return err;
> +}
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index cadc8fa64dd0..dd8632e783f6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -535,8 +535,12 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
>         int     err;
>         int data_len = payload_size(pkt);
>
> -       err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
> -                         payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
> +       if (qp->resp.mr->odp_enabled)

You cannot use qp->resp.mr here, because for zero byte operations,
resp.mr is not set in the function check_rkey().

The code fails for RTRS with the following stack trace,

[Thu Sep  8 20:12:22 2022] BUG: kernel NULL pointer dereference,
address: 0000000000000158
[Thu Sep  8 20:12:22 2022] #PF: supervisor read access in kernel mode
[Thu Sep  8 20:12:22 2022] #PF: error_code(0x0000) - not-present page
[Thu Sep  8 20:12:22 2022] PGD 0 P4D 0
[Thu Sep  8 20:12:22 2022] Oops: 0000 [#1] PREEMPT SMP
[Thu Sep  8 20:12:22 2022] CPU: 3 PID: 38 Comm: kworker/u8:1 Not
tainted 6.0.0-rc2-pserver+ #17
[Thu Sep  8 20:12:22 2022] Hardware name: QEMU Standard PC (i440FX +
PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[Thu Sep  8 20:12:22 2022] Workqueue: rxe_resp rxe_do_work [rdma_rxe]
[Thu Sep  8 20:12:22 2022] RIP: 0010:rxe_responder+0x1910/0x1d90 [rdma_rxe]
[Thu Sep  8 20:12:22 2022] Code: 06 48 63 88 fc 15 63 c0 0f b6 46 01
83 ea 04 c0 e8 04 29 ca 83 e0 03 29 c2 49 8b 87 08 05 00 00 49 03 87
00 05 00 00 4c 63 ea <80> bf 58 01 00 00 00 48 8d 14 0e 48 89 c6 4d 89
ee 44 89 e9 0f 84
[Thu Sep  8 20:12:22 2022] RSP: 0018:ffffb0358015fd80 EFLAGS: 00010246
[Thu Sep  8 20:12:22 2022] RAX: 0000000000000000 RBX: ffff9af4839b5e28
RCX: 0000000000000020
[Thu Sep  8 20:12:22 2022] RDX: 0000000000000000 RSI: ffff9af485094a6a
RDI: 0000000000000000
[Thu Sep  8 20:12:22 2022] RBP: ffff9af488bd7128 R08: 0000000000000000
R09: 0000000000000000
[Thu Sep  8 20:12:22 2022] R10: ffff9af4808eaf7c R11: 0000000000000001
R12: 0000000000000008
[Thu Sep  8 20:12:22 2022] R13: 0000000000000000 R14: ffff9af488bd7380
R15: ffff9af488bd7000
[Thu Sep  8 20:12:22 2022] FS:  0000000000000000(0000)
GS:ffff9af5b7d80000(0000) knlGS:0000000000000000
[Thu Sep  8 20:12:22 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Thu Sep  8 20:12:22 2022] CR2: 0000000000000158 CR3: 000000004a60a000
CR4: 00000000000006e0
[Thu Sep  8 20:12:22 2022] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[Thu Sep  8 20:12:22 2022] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[Thu Sep  8 20:12:22 2022] Call Trace:
[Thu Sep  8 20:12:22 2022]  <TASK>
[Thu Sep  8 20:12:22 2022]  ? newidle_balance+0x2e5/0x400
[Thu Sep  8 20:12:22 2022]  ? _raw_spin_unlock+0x12/0x30
[Thu Sep  8 20:12:22 2022]  ? finish_task_switch+0x91/0x2a0
[Thu Sep  8 20:12:22 2022]  rxe_do_work+0x86/0x110 [rdma_rxe]
[Thu Sep  8 20:12:22 2022]  process_one_work+0x1dc/0x3a0
[Thu Sep  8 20:12:22 2022]  worker_thread+0x4a/0x3b0
[Thu Sep  8 20:12:22 2022]  ? process_one_work+0x3a0/0x3a0
[Thu Sep  8 20:12:22 2022]  kthread+0xe7/0x110
[Thu Sep  8 20:12:22 2022]  ? kthread_complete_and_exit+0x20/0x20
[Thu Sep  8 20:12:22 2022]  ret_from_fork+0x22/0x30
[Thu Sep  8 20:12:22 2022]  </TASK>
[Thu Sep  8 20:12:22 2022] Modules linked in: rnbd_server rtrs_server
rtrs_core rdma_ucm rdma_cm iw_cm ib_cm crc32_generic rdma_rxe
ip6_udp_tunnel udp_tunnel ib_uverbs ib_core loop null_blk
[Thu Sep  8 20:12:22 2022] CR2: 0000000000000158
[Thu Sep  8 20:12:22 2022] ---[ end trace 0000000000000000 ]---
[Thu Sep  8 20:12:22 2022] BUG: kernel NULL pointer dereference,
address: 0000000000000158
[Thu Sep  8 20:12:22 2022] RIP: 0010:rxe_responder+0x1910/0x1d90 [rdma_rxe]
[Thu Sep  8 20:12:22 2022] #PF: supervisor read access in kernel mode
[Thu Sep  8 20:12:22 2022] Code: 06 48 63 88 fc 15 63 c0 0f b6 46 01
83 ea 04 c0 e8 04 29 ca 83 e0 03 29 c2 49 8b 87 08 05 00 00 49 03 87
00 05 00 00 4c 63 ea <80> bf 58 01 00 00 00 48 8d 14 0e 48 89 c6 4d 89
ee 44 89 e9 0f 84
[Thu Sep  8 20:12:22 2022] #PF: error_code(0x0000) - not-present page
[Thu Sep  8 20:12:22 2022] RSP: 0018:ffffb0358015fd80 EFLAGS: 00010246
[Thu Sep  8 20:12:22 2022] PGD 0 P4D 0

Technically, for operations with 0 length, the code can simply not do
any of the *_mr_copy, and carry on with success. So maybe you can
check data_len first and copy only if needed.


> +               err = -EOPNOTSUPP;
> +       else
> +               err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
> +                                 payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
> +
>         if (err) {
>                 rc = RESPST_ERR_RKEY_VIOLATION;
>                 goto out;
> @@ -667,7 +671,10 @@ static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
>                 if (mr->state != RXE_MR_STATE_VALID)
>                         return RESPST_ERR_RKEY_VIOLATION;
>
> -               ret = rxe_atomic_ops(qp, pkt, mr);
> +               if (mr->odp_enabled)
> +                       ret = RESPST_ERR_UNSUPPORTED_OPCODE;
> +               else
> +                       ret = rxe_atomic_ops(qp, pkt, mr);
>         } else
>                 ret = RESPST_ACKNOWLEDGE;
>
> @@ -831,8 +838,12 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>         if (!skb)
>                 return RESPST_ERR_RNR;
>
> -       err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> -                         payload, RXE_FROM_MR_OBJ);
> +       if (mr->odp_enabled)
> +               err = -EOPNOTSUPP;
> +       else
> +               err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> +                                 payload, RXE_FROM_MR_OBJ);
> +
>         if (err)
>                 pr_err("Failed copying memory\n");
>         if (mr)
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 7510f25c5ea3..b00e9b847382 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -926,10 +926,14 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>                 goto err2;
>         }
>
> -
>         rxe_get(pd);
>
> -       err = rxe_mr_init_user(pd, start, length, iova, access, mr);
> +       if (access & IB_ACCESS_ON_DEMAND)
> +               err = rxe_create_user_odp_mr(&pd->ibpd, start, length, iova,
> +                                            access, mr);
> +       else
> +               err = rxe_mr_init_user(pd, start, length, iova, access, mr);
> +
>         if (err)
>                 goto err3;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index b09b4cb9897a..98d2bb737ebc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -324,6 +324,8 @@ struct rxe_mr {
>         atomic_t                num_mw;
>
>         struct rxe_map          **map;
> +
> +       bool                    odp_enabled;
>  };
>
>  enum rxe_mw_state {
> --
> 2.31.1
>
