Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5228149F96
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 09:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgA0IO2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 03:14:28 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39269 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgA0IO2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 03:14:28 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so8971874ioh.6
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2020 00:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6FfpQ3EF+FeiMJStrkHdD2OEKk4VcPwR97+BW/TsWAk=;
        b=UjChYt2NkcO2t61mlxYVC3YYhP5Qqid+AzG+OBurHoXeRl0SHlmS4JpfmxlPTkc39j
         pgQCxff01OHxMD/ubjAd0EcAkGVDaOVCRPjAVOkwOvXkwjB9/TZE1EDCKy5oKZHXNPtz
         bNFUq0zoaV4K37q5nwIB3JWiJ2BZb+sKuk4xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6FfpQ3EF+FeiMJStrkHdD2OEKk4VcPwR97+BW/TsWAk=;
        b=EATsyXQ+dbLjSoaNa81eAMSbD3H/ONn9Eb6XbysfCbmlb/HHYP1x780noKCSsW04MP
         mhmEbZSgZCSfFOmEhoKpFxTKww6Pt43V5CXu0dnGCoSZXti0+UO+/UhQwFAsCwU29DLz
         gSo2xDKtNEWCNMGsZ0dJgSDhrSI/Jjm9q07Mic6fFXQ7jObxz4Iezu+KuE2RULtBCYki
         fHGa/5hw3wz2v/2J51670XqdrpoPTYHEOBO6QH15ZM0HISkBBM6zp4pbS5/xYdrNI4Iv
         MgFub3R1pcDXGZyXVNPLQjsKYONa+HrKLYpJmN6Smurxx1AE3xJp+ZfQJZ8/jk7w1knT
         Slvg==
X-Gm-Message-State: APjAAAUtXxg2p50iIIqPZX7syHbvds5q68RnH8yvqzx8YMTPgz+JwA0C
        k1rCn5mUakoxC1mHJOagILlqg7khwb/VujQRNir1kQ==
X-Google-Smtp-Source: APXvYqzT9eBBEIHgXKDw4Amoe2TntkA9TsFG4B7bzmRgM/GeZMZq2ucXxIZEM4AdBERYT30VxBu/Xj2o5C4w1aWHYr0=
X-Received: by 2002:a5d:93d1:: with SMTP id j17mr12093351ioo.300.1580112867596;
 Mon, 27 Jan 2020 00:14:27 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com> <20200125174645.GC4616@mellanox.com>
In-Reply-To: <20200125174645.GC4616@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 27 Jan 2020 13:43:51 +0530
Message-ID: <CANjDDBht4vTzkrRH1L9_9CquvsfRwo6VmPb6FFT2HNzkkh0H0w@mail.gmail.com>
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation code
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 25, 2020 at 11:16 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jan 24, 2020 at 12:52:39AM -0500, Devesh Sharma wrote:
> > +static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
> > +{
> > +     struct bnxt_re_qp *gsi_sqp;
> > +     struct bnxt_re_ah *gsi_sah;
> > +     struct bnxt_re_dev *rdev;
> > +     int rc = 0;
> > +
> > +     rdev = qp->rdev;
> > +     gsi_sqp = rdev->gsi_ctx.gsi_sqp;
> > +     gsi_sah = rdev->gsi_ctx.gsi_sah;
> > +
> > +     /* remove from active qp list */
> > +     mutex_lock(&rdev->qp_lock);
> > +     list_del(&gsi_sqp->list);
> > +     atomic_dec(&rdev->qp_count);
> > +     mutex_unlock(&rdev->qp_lock);
> > +
> > +     dev_dbg(rdev_to_dev(rdev), "Destroy the shadow AH\n");
> > +     bnxt_qplib_destroy_ah(&rdev->qplib_res,
> > +                           &gsi_sah->qplib_ah,
> > +                           true);
> > +     bnxt_qplib_clean_qp(&qp->qplib_qp);
> > +
> > +     dev_dbg(rdev_to_dev(rdev), "Destroy the shadow QP\n");
> > +     rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> > +     if (rc) {
> > +             dev_err(rdev_to_dev(rdev), "Destroy Shadow QP failed");
> > +             goto fail;
> > +     }
> > +     bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> > +
> > +     kfree(rdev->gsi_ctx.sqp_tbl);
> > +     kfree(gsi_sah);
> > +     kfree(gsi_sqp);
> > +     rdev->gsi_ctx.gsi_sqp = NULL;
> > +     rdev->gsi_ctx.gsi_sah = NULL;
> > +     rdev->gsi_ctx.sqp_tbl = NULL;
> > +
> > +     return 0;
> > +fail:
> > +     mutex_lock(&rdev->qp_lock);
> > +     list_add_tail(&gsi_sqp->list, &rdev->qp_list);
> > +     atomic_inc(&rdev->qp_count);
> > +     mutex_unlock(&rdev->qp_lock);
> > +     return rc;
>
> This error unwind approach looks racy. destroy is not allowed to
> fail, so why all this mess?
True, the unwind is not required, even if the driver wants to keep it
for debugging purpose, the zombie resource would give rise to
confusion.
>
> >  /* Queue Pairs */
> >  int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
> >  {
> > @@ -750,10 +797,18 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
> >       unsigned int flags;
> >       int rc;
> >
> > +     mutex_lock(&rdev->qp_lock);
> > +     list_del(&qp->list);
> > +     atomic_dec(&rdev->qp_count);
> > +     mutex_unlock(&rdev->qp_lock);
> >       bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
> >       rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
> >       if (rc) {
> >               dev_err(rdev_to_dev(rdev), "Failed to destroy HW QP");
> > +             mutex_lock(&rdev->qp_lock);
> > +             list_add_tail(&qp->list, &rdev->qp_list);
> > +             atomic_inc(&rdev->qp_count);
> > +             mutex_unlock(&rdev->qp_lock);
> >               return rc;
> >       }
>
> More..
Let me see if I can remove it in this series, else future series would
remove it.
>
> Jason
