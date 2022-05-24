Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B31532859
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 12:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiEXK45 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 06:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiEXK4z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 06:56:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E22CC8F
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 03:56:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m6so20440296ljb.2
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnYq5/1KDN6nj1Cx6w4BELQSxaZlmCHFI8UJEJylCow=;
        b=UQ8wuLN7bK6Vkz/LJwvBZdh47U3rso8jMnZ16DG/fEXfBUWQXqGQtUtwIz+oymUMcc
         i/wwSMdwbJ80cOHGa/lttWrZeZEvVyg1dynY/O6IlVfYHQZkV1D852EQOzT09QFlLRHk
         GjzVyC43DhFAPqLJnSORfc57khHbQSpR5Ta6yW55jVZBHjWmZMkaIHpxlgM/6PBO/F6h
         aIY+IsGnfNw6E52wmaa2t0f4bH5cpRErXOI9qxjtESCjfbvgDUPLLCFoMWJJ17wrf/0Q
         J01n68osZZJ12ocIJGI6BBU7HWM6hAJwu14PKSJ0LyTwDHWAmCZaxc4m+fz+SPXZL5EK
         damQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnYq5/1KDN6nj1Cx6w4BELQSxaZlmCHFI8UJEJylCow=;
        b=z8t6DoKrMJoMve9SPmNQXG8CyaJQc0MU2h7uGsDdxU2MHSjaTYtg7rLa74hkzoDD1A
         6XaVspl2FDhDnGPbo/rOJAXGyv308N9jrZMANzK+1Hi5/WUe34zobfN9d8/t5bR+CyLL
         shVI5eZ0BsVpSwHXFVkDXXeMGhge56w+PHuyIX+N5j7V6GpdyYGzzJaY1CbnZTbe0yo3
         lRPLqHff8vsXr7UG6NxliU9Z8PPsTKpDm7vfxYr7epv932zLhiw+BtoyGTuOyH48vA6v
         kVWbsrrjhge9se+lNie36UFSPsHoaFbVYGJnowY4Fw3s9cU7FXKEmbaMnzouYpT2hZPh
         MLeg==
X-Gm-Message-State: AOAM533mM0WqxmQ51FAr/DRWEvUvxO8Jokl7DXH0ZCfOifXfHv6dtYXC
        /UxqpOOL55IDANST29Z5o6ZWBfE1mlwRbOYIT8vzOw==
X-Google-Smtp-Source: ABdhPJxhhGu8tuKXGHamzXzuMkljtS+ymWd5z2W3fsBYEBxb0CUccqxyvHGKRftMXBEB5nzeyZHxgIs/7tFCW7qyHX4=
X-Received: by 2002:a2e:90c1:0:b0:24f:eca:3eb2 with SMTP id
 o1-20020a2e90c1000000b0024f0eca3eb2mr15627907ljg.158.1653389811988; Tue, 24
 May 2022 03:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220518043725.771549-1-lizhijian@fujitsu.com>
 <20220520144511.GA2302907@nvidia.com> <d956bac8-36a6-0148-6f9c-fa43c8c272a7@fujitsu.com>
 <3e3373f5-7b12-a8e8-2d73-c2976b272290@fujitsu.com>
In-Reply-To: <3e3373f5-7b12-a8e8-2d73-c2976b272290@fujitsu.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 24 May 2022 12:56:41 +0200
Message-ID: <CAJpMwyhhWSC_x4Fef32iW5Umzk5bLdJFweuZmN9LEJTQGyHfbQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Use kzalloc() to alloc map_set
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
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

On Tue, May 24, 2022 at 6:00 AM lizhijian@fujitsu.com
<lizhijian@fujitsu.com> wrote:
>
> Hi Jason & Bob
> CC Guoqing
>
> @Guoqing, It may correlate with your previous bug report: https://lore.kernel.org/all/20220210073655.42281-1-guoqing.jiang@linux.dev/T/
>
>
> It's observed that a same MR in rnbd server will trigger below code
> path:
>   -> rxe_mr_init_fast()
>   |-> alloc map_set() # map_set is uninitialized
>   |...-> rxe_map_mr_sg() # build the map_set
>       |-> rxe_mr_set_page()
>   |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE that means
>                            # we can access host memory(such rxe_mr_copy)
>   |...-> rxe_invalidate_mr() # mr->state change to FREE from VALID
>   |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE,
>                            # but map_set was not built again
>   |...-> rxe_mr_copy() # kernel crash due to access wild addresses
>                        # that lookup from the map_set
>
> I draft a patch like below for it, but i wonder if it's rxe's responsibility to do such checking.
> Any comments are very welcome.
>
>
>  From e9d0bd821f07f5e049027f07b3ce9dc283624201 Mon Sep 17 00:00:00 2001
> From: Li Zhijian <lizhijian@fujitsu.com>
> Date: Tue, 24 May 2022 10:56:19 +0800
> Subject: [PATCH] RDMA/rxe: check map_set valid when handle IB_WR_REG_MR
>
> It's observed that a same MR in rnbd server will trigger below code
> path:
>   -> rxe_mr_init_fast()
>   |-> alloc map_set() # map_set is uninitialized
>   |...-> rxe_map_mr_sg() # build the map_set
>       |-> rxe_mr_set_page()
>   |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE that means
>                            # we can access host memory(such rxe_mr_copy)
>   |...-> rxe_invalidate_mr() # mr->state change to FREE from VALID
>   |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE,
>                            # but map_set was not built again
>   |...-> rxe_mr_copy() # kernel crash due to access wild addresses
>                        # that lookup from the map_set
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 9 +++++++++
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 1 +
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>   3 files changed, 11 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 787c7dadc14f..09673d559c06 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -90,6 +90,7 @@ static int rxe_mr_alloc_map_set(int num_map, struct rxe_map_set **setp)
>          if (!set->map)
>                  goto err_free_set;
>
> +       set->valid = false;
>          for (i = 0; i < num_map; i++) {
>                  set->map[i] = kmalloc(sizeof(struct rxe_map), GFP_KERNEL);
>                  if (!set->map[i])
> @@ -216,6 +217,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>          }
>
>          set = mr->cur_map_set;
> +       set->valid = true;
>          set->page_shift = PAGE_SHIFT;
>          set->page_mask = PAGE_SIZE - 1;
>
> @@ -643,6 +645,7 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
>          }
>
>          mr->state = RXE_MR_STATE_FREE;
> +       mr->cur_map_set->valid = mr->next_map_set->valid = false;
>          ret = 0;
>
>   err_drop_ref:
> @@ -679,12 +682,18 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>                  return -EINVAL;
>          }
>
> +       if (!mr->next_map_set->valid) {
> +               pr_warn("%s: map set is not valid\n", __func__);
> +               return -EINVAL;
> +       }
> +
>          mr->access = access;
>          mr->lkey = (mr->lkey & ~0xff) | key;
>          mr->rkey = (access & IB_ACCESS_REMOTE) ? mr->lkey : 0;
>          mr->state = RXE_MR_STATE_VALID;
>
>          set = mr->cur_map_set;
> +       set->valid = false;
>          mr->cur_map_set = mr->next_map_set;
>          mr->cur_map_set->iova = wqe->wr.wr.reg.mr->iova;
>          mr->next_map_set = set;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 58e4412b1d16..4b7ae2d1d921 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -992,6 +992,7 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>          set->page_shift = ilog2(ibmr->page_size);
>          set->page_mask = ibmr->page_size - 1;
>          set->offset = set->iova & set->page_mask;
> +       set->valid = true;
>
>          return n;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 86068d70cd95..2edf31aab7e1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -289,6 +289,7 @@ struct rxe_map {
>
>   struct rxe_map_set {
>          struct rxe_map          **map;
> +       bool                    valid;
>          u64                     va;
>          u64                     iova;
>          size_t                  length;
> --
> 2.31.1

Thanks for posting the description and the patch.

We have been facing the exact same issue (only with rxe), and we also
realized that to get around this we will have to call ib_map_mr_sg()
before every IB_WR_REG_MR wr; even if we are reusing the MR and simply
invalidating and re-validating them.

In reference to this, we have 2 questions.

1) This change was made in the following commit.

commit 647bf13ce944f20f7402f281578423a952274e4a
Author: Bob Pearson <rpearsonhpe@gmail.com>
Date:   Tue Sep 14 11:42:06 2021 -0500

    RDMA/rxe: Create duplicate mapping tables for FMRs

    For fast memory regions create duplicate mapping tables so ib_map_mr_sg()
    can build a new mapping table which is then swapped into place
    synchronously with the execution of an IB_WR_REG_MR work request.

    Currently the rxe driver uses the same table for receiving RDMA operations
    and for building new tables in preparation for reusing the MR. This
    exposes users to potentially incorrect results.

    Link: https://lore.kernel.org/r/20210914164206.19768-5-rpearsonhpe@gmail.com
    Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

We tried to understand what potential incorrect result that commit
message talks about, but were not able to. If someone can through
light into this scenario where single mapping table can result into
issues, it would be great.

2)
We wanted to confirm that, with the above patch, it clearly means that
the use-case where we reuse the MR, by simply invalidating and
re-validating (IB_WR_REG_MR wr) is a correct one.
And there is no requirement saying that ib_map_mr_sg() needs to be
done everytime regardless.

(We were planning to send this in the coming days, but wanted other
discussions to get over. Since the patch got posted and discussion
started, we thought better to put this out.)

Regards

>
>
> On 23/05/2022 22:02, Li, Zhijian wrote:
> >
> > on 2022/5/20 22:45, Jason Gunthorpe wrote:
> >> On Wed, May 18, 2022 at 12:37:25PM +0800, Li Zhijian wrote:
> >>> Below call chains will alloc map_set without fully initializing map_set.
> >>> rxe_mr_init_fast()
> >>>   -> rxe_mr_alloc()
> >>>      -> rxe_mr_alloc_map_set()
> >>>
> >>> Uninitialized values inside struct rxe_map_set are possible to cause
> >>> kernel panic.
> >> If the value is uninitialized then why is 0 an OK value?
> >>
> >> Would be happier to know the exact value that is not initialized
> >
> > Well, good question. After re-think of this issue, it seems this patch wasn't the root cause though it made the crash disappear in some extent.
> >
> > I'm still working on the root cause :)
> >
> > Thanks
> >
> > Zhijian
> >
> >
> >>
> >> Jason
> >
> >
