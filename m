Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F97736654E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 08:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhDUGVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 02:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhDUGVG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 02:21:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6560161420;
        Wed, 21 Apr 2021 06:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618986034;
        bh=j5LjdSfD2+y7izkXC30K8ois2tEE2m+ZECTEPLI15cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVALplFIRfFlXKjDi119zJYmwO3fb2fWZo+77mUTkW79X5d48EX570hBTc7N8vhZH
         E89KOPRW7kdSAWXEScvudfBsYmTWSGIadsqEIvxMLQRNWnCR6lKEdcSmR8TZzJDZEr
         ykn7JtELx/A+2n4GNUSHOHsCcLSftDanS8bio1vz/xaWscSmEwoxEZrAYBZmC+44XO
         QO5euATTjhWt/lbfGKIcOsOYl6KjKCI1pnSv6La1HSLRUCry6RzTDaB5I7DC3PLmu/
         q92vMxzU30arMbNz0kso+SQSssRhlD7Mqy3qbzgSOHqu2Iul3sOa9xhpHycCm2VLml
         MXtLfZjawHHWQ==
Date:   Wed, 21 Apr 2021 09:20:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v3 4/9] RDMA/rxe: Add ib_alloc_mw and
 ib_dealloc_mw verbs
Message-ID: <YH/ELqtyNUB1DHeh@unreal>
References: <20210421052015.4546-1-rpearson@hpe.com>
 <20210421052015.4546-5-rpearson@hpe.com>
 <CAD=hENe-Xw2L46=U2uLO4evmFfgNNMWJBLtSYid=SNrJ9W75Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENe-Xw2L46=U2uLO4evmFfgNNMWJBLtSYid=SNrJ9W75Yw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 21, 2021 at 01:54:49PM +0800, Zhu Yanjun wrote:
> On Wed, Apr 21, 2021 at 1:20 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > Add ib_alloc_mw and ib_dealloc_mw verbs APIs.
> >
> > Added new file rxe_mw.c focused on MWs.
> > Changed the 8 bit random key generator.
> > Added a cleanup routine for MWs.
> > Added verbs routines to ib_device_ops.
> >
> > Signed-off-by: Bob Pearson <rpearson@hpe.com>
> > ---
> >  drivers/infiniband/sw/rxe/Makefile    |  1 +
> >  drivers/infiniband/sw/rxe/rxe_loc.h   |  6 +++
> >  drivers/infiniband/sw/rxe/rxe_mr.c    | 20 +++++-----
> >  drivers/infiniband/sw/rxe/rxe_mw.c    | 53 +++++++++++++++++++++++++++
> >  drivers/infiniband/sw/rxe/rxe_pool.c  |  1 +
> >  drivers/infiniband/sw/rxe/rxe_verbs.c |  3 ++
> >  drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +
> >  7 files changed, 75 insertions(+), 11 deletions(-)
> >  create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
> >
> > diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> > index 66af72dca759..1e24673e9318 100644
> > --- a/drivers/infiniband/sw/rxe/Makefile
> > +++ b/drivers/infiniband/sw/rxe/Makefile
> > @@ -15,6 +15,7 @@ rdma_rxe-y := \
> >         rxe_qp.o \
> >         rxe_cq.o \
> >         rxe_mr.o \
> > +       rxe_mw.o \
> >         rxe_opcode.o \
> >         rxe_mmap.o \
> >         rxe_icrc.o \
> > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> > index ef8061d2fbe0..edf575930a98 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > @@ -76,6 +76,7 @@ enum copy_direction {
> >         from_mr_obj,
> >  };
> >
> > +u8 rxe_get_next_key(u32 last_key);
> >  void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
> >
> >  int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
> > @@ -106,6 +107,11 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg);
> >
> >  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> >
> > +/* rxe_mw.c */
> > +int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
> > +int rxe_dealloc_mw(struct ib_mw *ibmw);
> > +void rxe_mw_cleanup(struct rxe_pool_entry *arg);
> > +
> >  /* rxe_net.c */
> >  void rxe_loopback(struct sk_buff *skb);
> >  int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > index 9f63947bab12..7f2cfc1ce659 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -7,19 +7,17 @@
> >  #include "rxe.h"
> >  #include "rxe_loc.h"
> >
> > -/*
> > - * lfsr (linear feedback shift register) with period 255
> > +/* Return a random 8 bit key value that is
> > + * different than the last_key. Set last_key to -1
> > + * if this is the first key for an MR or MW
> >   */
> > -static u8 rxe_get_key(void)
> > +u8 rxe_get_next_key(u32 last_key)
> >  {
> > -       static u32 key = 1;
> > -
> > -       key = key << 1;
> > -
> > -       key |= (0 != (key & 0x100)) ^ (0 != (key & 0x10))
> > -               ^ (0 != (key & 0x80)) ^ (0 != (key & 0x40));
> > +       u8 key;
> >
> > -       key &= 0xff;
> > +       do {
> > +               get_random_bytes(&key, 1);
> > +       } while (key == last_key);
> >
> >         return key;
> >  }
> > @@ -47,7 +45,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
> >
> >  static void rxe_mr_init(int access, struct rxe_mr *mr)
> >  {
> > -       u32 lkey = mr->pelem.index << 8 | rxe_get_key();
> > +       u32 lkey = mr->pelem.index << 8 | rxe_get_next_key(-1);
> >         u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
> >
> >         mr->ibmr.lkey = lkey;
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> > new file mode 100644
> > index 000000000000..69128e298d44
> > --- /dev/null
> > +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > +/*
> > + * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
> > + */
> 
> The above is different with the following:
> "
> // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> /*
>  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
>  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
>  */
> "
> 
> One is Hewlett Packard Enterprise, Inc, the other is Mellanox Technologies Ltd.
> 
> I am not sure whether it is a legal problem.
>

It is not an issue, because Bob created new file together with adding
enough new code in it.

Thanks
