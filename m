Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708D3149FAE
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 09:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgA0IQu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 03:16:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44542 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgA0IQu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 03:16:50 -0500
Received: by mail-io1-f67.google.com with SMTP id e7so8950978iof.11
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2020 00:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIZnt8ZTP3K5I+jQW6mPUBoNWy51dEeOmjSOTS79PF8=;
        b=dxNfc401lhm3IHtUV28DJU7sUjs4P0cegqKwAGkp+7n/f6KU0bU2U/jeiNlcB14p7/
         2hxZKOP64kNq8vaLraPyEmh16yw5SEJDznwRv3A8Z9H+51vXG2HDoy3X4yaqVRUSeC2y
         4/FwAK7HdlsRfG9NMDMNNoLgCTzDZGA44w+aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIZnt8ZTP3K5I+jQW6mPUBoNWy51dEeOmjSOTS79PF8=;
        b=mGrPl1dMtNHozaVNQxLbuMRWxyeY2MzLiISrylU3JB/e9uasS4jqIIY2BypLt9+PEH
         a2kqio3XITY1OZjlm4liXBvKdPMA6FCmjtquIfvM/YsN+J2eOARdXDCtTMm9mNHdu/7g
         P9KUKuSiHgQEbqMUo6cLUdFmapnYNG+3K+s5pnMk3VEqV9Z2np/BRHuhVOZw25ugPcEp
         Q+G/Xnc3BjOpvXIn9ZY51n7DuryxD2JbS2obuKYEjdI4p+Im8gH+vorBQtFAZJUy1Ll+
         iXw7w5NPdIH9QwSjuRMLD/SRKzWy3Hhx7W4omRJ6gyduTtX302U40l2/VQRCMfREMFI3
         esEQ==
X-Gm-Message-State: APjAAAWVeDQPMwwqUPhxtW8YyuriAZiNjre9IvLfAEqPY17oK7LYVFfg
        M+m4UuRKXhr8lhi+5L+oqNN0SzyiqIjq35IigUTN4C4F
X-Google-Smtp-Source: APXvYqwntDmr3PU1glwUVsWVi7AQvbvIV58aT23j0HHBqv3Y2/y+QeInnE68imBpBOPn/3x9lO7De7ttuvpHiMJEmLQ=
X-Received: by 2002:a5e:9246:: with SMTP id z6mr12117612iop.232.1580113009858;
 Mon, 27 Jan 2020 00:16:49 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
 <20200125174645.GC4616@mellanox.com> <CANjDDBht4vTzkrRH1L9_9CquvsfRwo6VmPb6FFT2HNzkkh0H0w@mail.gmail.com>
In-Reply-To: <CANjDDBht4vTzkrRH1L9_9CquvsfRwo6VmPb6FFT2HNzkkh0H0w@mail.gmail.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 27 Jan 2020 13:46:13 +0530
Message-ID: <CANjDDBigH2EvkKVoFrRc0hdMG+1czSg0DChTmkj9M3Kzt2d=gQ@mail.gmail.com>
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation code
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 1:43 PM Devesh Sharma
<devesh.sharma@broadcom.com> wrote:
>
> On Sat, Jan 25, 2020 at 11:16 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Fri, Jan 24, 2020 at 12:52:39AM -0500, Devesh Sharma wrote:
> > > +static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
> > > +{
> > > +     struct bnxt_re_qp *gsi_sqp;
> > > +     struct bnxt_re_ah *gsi_sah;
> > > +     struct bnxt_re_dev *rdev;
> > > +     int rc = 0;
> > > +
> > > +     rdev = qp->rdev;
> > > +     gsi_sqp = rdev->gsi_ctx.gsi_sqp;
> > > +     gsi_sah = rdev->gsi_ctx.gsi_sah;
> > > +
> > > +     /* remove from active qp list */
> > > +     mutex_lock(&rdev->qp_lock);
> > > +     list_del(&gsi_sqp->list);
> > > +     atomic_dec(&rdev->qp_count);
> > > +     mutex_unlock(&rdev->qp_lock);
> > > +
> > > +     dev_dbg(rdev_to_dev(rdev), "Destroy the shadow AH\n");
> > > +     bnxt_qplib_destroy_ah(&rdev->qplib_res,
> > > +                           &gsi_sah->qplib_ah,
> > > +                           true);
> > > +     bnxt_qplib_clean_qp(&qp->qplib_qp);
> > > +
> > > +     dev_dbg(rdev_to_dev(rdev), "Destroy the shadow QP\n");
> > > +     rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> > > +     if (rc) {
> > > +             dev_err(rdev_to_dev(rdev), "Destroy Shadow QP failed");
> > > +             goto fail;
> > > +     }
> > > +     bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> > > +
> > > +     kfree(rdev->gsi_ctx.sqp_tbl);
> > > +     kfree(gsi_sah);
> > > +     kfree(gsi_sqp);
> > > +     rdev->gsi_ctx.gsi_sqp = NULL;
> > > +     rdev->gsi_ctx.gsi_sah = NULL;
> > > +     rdev->gsi_ctx.sqp_tbl = NULL;
> > > +
> > > +     return 0;
> > > +fail:
> > > +     mutex_lock(&rdev->qp_lock);
> > > +     list_add_tail(&gsi_sqp->list, &rdev->qp_list);
> > > +     atomic_inc(&rdev->qp_count);
> > > +     mutex_unlock(&rdev->qp_lock);
> > > +     return rc;
> >
> > This error unwind approach looks racy. destroy is not allowed to
> > fail, so why all this mess?
> True, the unwind is not required, even if the driver wants to keep it
> for debugging purpose, the zombie resource would give rise to
> confusion.
> >
> > >  /* Queue Pairs */
> > >  int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
> > >  {
> > > @@ -750,10 +797,18 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
> > >       unsigned int flags;
> > >       int rc;
> > >
> > > +     mutex_lock(&rdev->qp_lock);
> > > +     list_del(&qp->list);
> > > +     atomic_dec(&rdev->qp_count);
> > > +     mutex_unlock(&rdev->qp_lock);
> > >       bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
> > >       rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
> > >       if (rc) {
> > >               dev_err(rdev_to_dev(rdev), "Failed to destroy HW QP");
> > > +             mutex_lock(&rdev->qp_lock);
> > > +             list_add_tail(&qp->list, &rdev->qp_list);
> > > +             atomic_inc(&rdev->qp_count);
> > > +             mutex_unlock(&rdev->qp_lock);
> > >               return rc;
> > >       }
> >
> > More..
> Let me see if I can remove it in this series, else future series would
> remove it.
> >
> > Jason

At the top level, if provider driver is so keen on returning success
in any case, should we change the return type to void of
ib_destroy_xx() hooks?
