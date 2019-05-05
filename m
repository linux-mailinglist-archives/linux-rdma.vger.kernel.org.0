Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9F1414F
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfEERKD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 13:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfEERKC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 13:10:02 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4C3206DF;
        Sun,  5 May 2019 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557076202;
        bh=KScoJzIpbKTiWvUaKye/1OSc/pXiMFHeT1U62U9JvdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bz+9m0CQQuWj9a7BsjbnPQsO240fF/TBncEQITjks24mjUYVyUJrHZHcG4G/SekPg
         06eQY8tSkEvN558jaf9r1FQGfGy+3giiat+Jaaud0zXOM/Cf6LCvqO8Tk4+euKoalY
         RnN+bgwZJKmL+XgKZBOexMVV+kPL/EyuRxedSz4s=
Date:   Sun, 5 May 2019 20:09:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org,
        Bernard Metzler <bmt@rims.zurich.ibm.com>
Subject: Re: [PATCH v8 02/12] SIW main include file
Message-ID: <20190505170956.GH6938@mtr-leonro.mtl.com>
References: <20190428110721.GI6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-3-bmt@zurich.ibm.com>
 <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 05, 2019 at 04:54:50PM +0000, Bernard Metzler wrote:
> -----"Leon Romanovsky" <leon@kernel.org> wrote: -----
>
> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
> >From: "Leon Romanovsky" <leon@kernel.org>
> >Date: 04/28/2019 01:07PM
> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
> ><bmt@rims.zurich.ibm.com>
> >Subject: Re: [PATCH v8 02/12] SIW main include file
> >
> >On Fri, Apr 26, 2019 at 03:18:42PM +0200, Bernard Metzler wrote:
> >> From: Bernard Metzler <bmt@rims.zurich.ibm.com>
> >>
> >> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> >> ---
> >>  drivers/infiniband/sw/siw/siw.h | 733
> >++++++++++++++++++++++++++++++++
> >>  1 file changed, 733 insertions(+)
> >>  create mode 100644 drivers/infiniband/sw/siw/siw.h
> >>
> >> diff --git a/drivers/infiniband/sw/siw/siw.h
> >b/drivers/infiniband/sw/siw/siw.h
> >> new file mode 100644
> >> index 000000000000..9a3c2abbd858
> >> --- /dev/null
> >> +++ b/drivers/infiniband/sw/siw/siw.h
> >> @@ -0,0 +1,733 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
> >> +
> >> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
> >> +/* Copyright (c) 2008-2019, IBM Corporation */
> >> +
> >> +#ifndef _SIW_H
> >> +#define _SIW_H
> >> +
> >> +#include <linux/idr.h>
> >> +#include <rdma/ib_verbs.h>
> >> +#include <linux/socket.h>
> >> +#include <linux/skbuff.h>
> >> +#include <linux/in.h>
> >> +#include <linux/fs.h>
> >> +#include <linux/netdevice.h>
> >> +#include <crypto/hash.h>
> >> +#include <linux/resource.h> /* MLOCK_LIMIT */
> >> +#include <linux/module.h>
> >> +#include <linux/version.h>
> >> +#include <linux/llist.h>
> >> +#include <linux/mm.h>
> >> +#include <linux/sched/signal.h>
> >> +
> >> +#include <rdma/siw_user.h>
> >> +#include "iwarp.h"
> >> +
> >> +/* driver debugging enabled */
> >> +#define DEBUG
> >
> >I clearly remember that we asked to remove this.
>
> Absolutely. Sorry, it sneaked in again since I did some
> debugging. Will remove...
> >
> >> +	spinlock_t lock;
> >> +
> >> +	/* object management */
> >> +	struct idr qp_idr;
> >> +	struct idr mem_idr;
> >
> >Why IDR and not XArray?
>
> Memory access keys and QP IDs are generated as random
> numbers, since both are exposed to the application.
> Since XArray is not designed for sparsely distributed
> id ranges, I am still in favor of IDR for these two
> resources.

Why do those number need to be "sparsely distributed"?
Isn't this ID to query in some internal object database?

At lease QP number is for sure can be sequential, there is no extra
value of creating it to be random.

>
> >
> >> +	/* active objects statistics */
> >
> >refcount_t please
> >
> >> +	atomic_t num_qp;
> >> +	atomic_t num_cq;
> >> +	atomic_t num_pd;
> >> +	atomic_t num_mr;
> >> +	atomic_t num_srq;
> >> +	atomic_t num_cep;
> >> +	atomic_t num_ctx;
> >> +
> >
>
> These counters are only used to limit the amount of
> resources allocated to their max values per device.
>
> Since there is no equivalent for atomic_inc_return()
> for refcounters I'd suggest to stay with atomic_t:
>
>         refcount_inc(&sdev->num_mr);
>         if (refcount_read(&sdev->num_mr) > SIW_MAX_MR) {
>                 siw_dbg_pd(pd, "too many mr's\n");
>                 rv = -ENOMEM;
>                 goto err_out;
>         }
> vs.
>         if (atomic_inc_return(&sdev->num_mr) > SIW_MAX_MR) {
>                 siw_dbg_pd(pd, "too many mr's\n");
>                 rv = -ENOMEM;
>                 goto err_out;
>         }
>

No problem, anyway we are planning to generalize it and remove from all drivers.

>
>
> ><...>
> >
> >> +/*
> >> + * Generic memory representation for registered siw memory.
> >> + * Memory lookup always via higher 24 bit of STag (STag index).
> >> + * Object relates to memory window if embedded mr pointer is valid
> >> + */
> >> +struct siw_mem {
> >> +	struct siw_device *sdev;
> >> +	struct kref ref;
> >
> ><...>
> >
> >> +struct siw_qp {
> >> +	struct ib_qp base_qp;
> >> +	struct siw_device *sdev;
> >> +	struct kref ref;
> >
> >I wonder if kref is needed in driver code.
> >
> ><...>
>
> Memory and QP objects are, while generally maintained
> by the RDMA midlayer, also guarded against deallocation
> while still in use by the driver. The code tries to avoid
> taking resource locks for operations like in flight RDMA reads
> on a memory object. So it makes use of the release function
> in kref_put().

krefs are not replacing the locks, but protect from release
during the operation on that object. I don't understand
the connection that your draw here between RDMA midlayer
and in-flight operations.

> >
> >> +/* Varia */
> >
> >????
> >
> right, will remove useless comment.
>
> >> +extern void siw_cq_flush(struct siw_cq *cq);
> >> +extern void siw_sq_flush(struct siw_qp *qp);
> >> +extern void siw_rq_flush(struct siw_qp *qp);
> >> +extern int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc);
> >> +extern void siw_print_hdr(union iwarp_hdr *hdr, int qp_id, char
> >*string);
> >> +#endif
> >> --
> >> 2.17.2
> >>
> >
> >
>
