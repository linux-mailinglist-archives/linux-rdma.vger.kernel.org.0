Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9C250971
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgHXTgh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 15:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXTgg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 15:36:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89BC061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 12:36:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l23so9131114edv.11
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PO6tpJXAmJVZ2z8xacTaE2SyGScvmP+sUHRljAKimZA=;
        b=AY1y4jxmPxoUOCF8zXrUeIzCag4+wNjXUVIqD8TD5CfnApHZSj/SJSrXVBoGHvC4n9
         jzh89M1ziL+GMTpPd7Q7lQCYOLlxdea/sUwEZba+fBcNeFLZfET71M2h0yHfn+iNhMJQ
         vahqQwyIgfBRMUaMrdS4Q5sAkuS9sscSLVuaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PO6tpJXAmJVZ2z8xacTaE2SyGScvmP+sUHRljAKimZA=;
        b=uQsfV3pgtZBxnvukk6uU4GF2FEPcSVkAFuCEfEo8Kqh+4Tc6yEpfb7tGZX1un2Jk7g
         WiBCQ/6uadJzuqk8O0c/Rb3d9BVRgise0lOyu0k6/6Zkbbv5OldAZ9+gPOprqeq8iPqn
         rI4hpLaIGGIwPFGEHwbpeM1wcGuqpMkcjQRtZIn0LIwU+fQFxahfGU+WZ486iKTGFSxX
         UqmirX8auqQWSawofXQh2nLOSP66rRR8ZYz+Zn9/iVhhPBgLrsCgknd9qqnCWO7hOtjD
         /mbpeBzDHNbD4SsS0+sRNPJSw4jE8TpydV745sEiXuuVk1P3+u31xT8yuD6ZEM+Qlh/8
         jqkA==
X-Gm-Message-State: AOAM533SMPHhE5Tb7nyTwCe5Qpwbz4cbv9xKURJmgL6psFQQPPJK2aGW
        P7AF1diaZT1Z7iPk7x0ojqO7ZGKLoGHQzNZ22Hpanw==
X-Google-Smtp-Source: ABdhPJzwUMH0HxA2PWZQI5h9ro+IQu3Hk3eA5X0raFF6ff+8oS09CUBufJA1E8XoGMFrE5wx2hpzRiKMoa89/oqXrL4=
X-Received: by 2002:aa7:d1cc:: with SMTP id g12mr7150221edp.385.1598297794911;
 Mon, 24 Aug 2020 12:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
 <1598292876-26529-2-git-send-email-selvin.xavier@broadcom.com> <20200824190141.GL571722@unreal>
In-Reply-To: <20200824190141.GL571722@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 25 Aug 2020 01:06:23 +0530
Message-ID: <CA+sbYW3R_uScvS63dWNNVO4965OjOCRPagpqOY1JKrbsOTEEeQ@mail.gmail.com>
Subject: Re: [PATCH for-rc 1/6] RDMA/bnxt_re: Remove the qp from list only if
 the qp destroy succeeds
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 12:31 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Aug 24, 2020 at 11:14:31AM -0700, Selvin Xavier wrote:
> > Driver crashes when destroy_qp is re-tried because of an
> > error returned. This is because the qp entry was  removed
> > from the qp list during the first call.
>
> How is it possible that destroy_qp fail?
>
One possibility is when the FW is in a crash state.   Driver commands
to FW  fails and it reports an error status for destroy_qp verb.
Even Though the chances of this failure is less,  wanted to avoid a
host crash seen in this scenario.
> >
> > Remove qp from the list only if destroy_qp returns success.
> >
> > Fixes: 8dae419f9ec7 ("RDMA/bnxt_re: Refactor queue pair creation code")
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > index 3f18efc..2f5aac0 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -752,12 +752,6 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
> >       gsi_sqp = rdev->gsi_ctx.gsi_sqp;
> >       gsi_sah = rdev->gsi_ctx.gsi_sah;
> >
> > -     /* remove from active qp list */
> > -     mutex_lock(&rdev->qp_lock);
> > -     list_del(&gsi_sqp->list);
> > -     mutex_unlock(&rdev->qp_lock);
> > -     atomic_dec(&rdev->qp_count);
> > -
> >       ibdev_dbg(&rdev->ibdev, "Destroy the shadow AH\n");
> >       bnxt_qplib_destroy_ah(&rdev->qplib_res,
> >                             &gsi_sah->qplib_ah,
> > @@ -772,6 +766,12 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
> >       }
> >       bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> >
> > +     /* remove from active qp list */
> > +     mutex_lock(&rdev->qp_lock);
> > +     list_del(&gsi_sqp->list);
> > +     mutex_unlock(&rdev->qp_lock);
> > +     atomic_dec(&rdev->qp_count);
> > +
> >       kfree(rdev->gsi_ctx.sqp_tbl);
> >       kfree(gsi_sah);
> >       kfree(gsi_sqp);
> > @@ -792,11 +792,6 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
> >       unsigned int flags;
> >       int rc;
> >
> > -     mutex_lock(&rdev->qp_lock);
> > -     list_del(&qp->list);
> > -     mutex_unlock(&rdev->qp_lock);
> > -     atomic_dec(&rdev->qp_count);
> > -
> >       bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
> >
> >       rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
> > @@ -819,6 +814,11 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
> >                       goto sh_fail;
> >       }
> >
> > +     mutex_lock(&rdev->qp_lock);
> > +     list_del(&qp->list);
> > +     mutex_unlock(&rdev->qp_lock);
> > +     atomic_dec(&rdev->qp_count);
> > +
> >       ib_umem_release(qp->rumem);
> >       ib_umem_release(qp->sumem);
> >
> > --
> > 2.5.5
> >
