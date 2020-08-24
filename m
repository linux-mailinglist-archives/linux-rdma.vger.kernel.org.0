Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE124F8DA
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgHXJiH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 05:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbgHXIrZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 04:47:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9DE1206F0;
        Mon, 24 Aug 2020 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258844;
        bh=mU7wLNwSEgm0IdifOlXYOj9CTLKhd8Cesitx3SSI2s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhLnk2vaFlWM6lq68p3yZ0s1cVJDNeSaatr9RaigJ+laPOW2EPtgAs17ZBTzIUwIT
         AFnQMI0JM0gAQKfpvAb+nnMaDo+bXNA/iTwnfDimRIpSMno8SnBIpFHvkpRWL92Hnf
         wtconydOsHsZ1QMVMQbxkQPDTeoXA+WtNHa+5ir8=
Date:   Mon, 24 Aug 2020 11:47:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 11/17] rdma_rxe: Address an issue with hardened user
 copy
Message-ID: <20200824084721.GG571722@unreal>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-12-rpearson@hpe.com>
 <4fd91289-7cd7-a62c-54ee-4ace9eb45a14@gmail.com>
 <f69f8a27-e4e6-88ae-77d8-358fde60d72e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f69f8a27-e4e6-88ae-77d8-358fde60d72e@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 21, 2020 at 11:16:59PM -0500, Bob Pearson wrote:
> On 8/21/20 10:32 PM, Zhu Yanjun wrote:
> > On 8/21/2020 6:46 AM, Bob Pearson wrote:
> >> Added a new feature to pools to let driver white list a region of
> >> a pool object. This removes a kernel oops caused when create qp
> >> returns the qp number so the next patch will work without errors.
> >>
> >> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe_pool.c | 20 +++++++++++++++++---
> >>   drivers/infiniband/sw/rxe/rxe_pool.h |  4 ++++
> >>   2 files changed, 21 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> >> index 5679714827ec..374e56689d30 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> >> @@ -40,9 +40,12 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
> >>           .name        = "rxe-qp",
> >>           .size        = sizeof(struct rxe_qp),
> >>           .cleanup    = rxe_qp_cleanup,
> >> -        .flags        = RXE_POOL_INDEX,
> >> +        .flags        = RXE_POOL_INDEX
> >> +                | RXE_POOL_WHITELIST,
> >>           .min_index    = RXE_MIN_QP_INDEX,
> >>           .max_index    = RXE_MAX_QP_INDEX,
> >> +        .user_offset    = offsetof(struct rxe_qp, ibqp.qp_num),
> >> +        .user_size    = sizeof(u32),
> >>       },
> >>       [RXE_TYPE_CQ] = {
> >>           .name        = "rxe-cq",
> >> @@ -116,10 +119,21 @@ int rxe_cache_init(void)
> >>           type = &rxe_type_info[i];
> >>           size = ALIGN(type->size, RXE_POOL_ALIGN);
> >>           if (!(type->flags & RXE_POOL_NO_ALLOC)) {
> >> -            type->cache =
> >> -                kmem_cache_create(type->name, size,
> >> +            if (type->flags & RXE_POOL_WHITELIST) {
> >> +                type->cache =
> >> +                    kmem_cache_create_usercopy(
> >> +                        type->name, size,
> >> +                        RXE_POOL_ALIGN,
> >> +                        RXE_POOL_CACHE_FLAGS,
> >> +                        type->user_offset,
> >> +                        type->user_size, NULL);
> >> +            } else {
> >> +                type->cache =
> >> +                    kmem_cache_create(type->name, size,
> >>                             RXE_POOL_ALIGN,
> >>                             RXE_POOL_CACHE_FLAGS, NULL);
> >> +            }
> >> +
> >>               if (!type->cache) {
> >>                   pr_err("Unable to init kmem cache for %s\n",
> >>                          type->name);
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
> >> index 664153bf9392..fc5b584a8137 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
> >> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> >> @@ -17,6 +17,7 @@ enum rxe_pool_flags {
> >>       RXE_POOL_INDEX        = BIT(1),
> >>       RXE_POOL_KEY        = BIT(2),
> >>       RXE_POOL_NO_ALLOC    = BIT(4),
> >> +    RXE_POOL_WHITELIST    = BIT(5),
> >>   };
> >>     enum rxe_elem_type {
> >> @@ -44,6 +45,9 @@ struct rxe_type_info {
> >>       u32            min_index;
> >>       size_t            key_offset;
> >>       size_t            key_size;
> >> +    /* for white listing where necessary */
> >
> > s/where/when
> >
> >
> >> +    unsigned int        user_offset;
> >> +    unsigned int        user_size;
> >>       struct kmem_cache    *cache;
> >>   };
> >>  
> >
> >
> The reason for this change is that every time I do anything with rdma_rxe on current head of tree I get a kernel oops with a warning that there is a bad or missing white list. I traced this back to the user_copy routine which (recently) decided that when you copy just a part of a kernel memory object stored in a kmem cache that this represented a risk of leaking information from the kernel to user space. For the QP object the qp_num is copied back to user space in the user API. They also provided a new kmem_ccache_create_usercopy call that allows you to specify a 'whitelisted' portion of each object with an offset and length. So I just made it a feature of pools since it may come up again instead of treating QPs differently that all the other objects. This is part of a general program to harden the Linux kernel.
> You can see the change to rxe_cache_init in the same file. Perhaps just dropping the comment would address the concern. See an earlier post I made with a pointer to an article in lwn describing the changes to the kernel.

RXE must be rewritten to be secure.

Please drop this patch, we don't need compilation for no reason.

Thanks
