Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0328E14A310
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgA0Lca (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 06:32:30 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45662 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbgA0Lca (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 06:32:30 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so7120961iln.12
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2020 03:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MaNilQuB5nbqm+vL8ABQt6AN9+AQY+2x+3xXniGfwc=;
        b=UG+B7sZfr7KIeAQM2WvahrGhfffzUITkLp4dLKKBJHVXsENUYiIT49m5UEz0XlPjF2
         e3d2xnGhAHI+j0SUwFCEBQ10weqvDV2fVXP2SSqxjnvyRVUwYJzspilXXzMxVty2RIYa
         Xhh07BFI7NHc+KWmHvsxoG1Ya8hhUwWNbodKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MaNilQuB5nbqm+vL8ABQt6AN9+AQY+2x+3xXniGfwc=;
        b=Py+BZUaSnbyAF0+8Is47Lg9t16gFvwi8GFHS4Kfp2Sy7wav7iBby86Nnzj1hm+gH8I
         BiDE7uO7RpzguKPENseN+me1MQArPSmdjMnWE63NRDH1WJo9F2FNvNOIHvgmOYTcZwmC
         RJw50vSUq26zr4QUsM7wkz/3S8LY0p44WnzMBODNfnAlyC+6Hmqt3W3KnJzA9l2RuQFh
         iFDPSOlWgrgVgeREN4HMWCcd1g71pac01nDErhAnBL6xt9TwpgA9jii6nMX6oGvur7Rs
         8lwMgwE/Ncj4yf5hZu3XWWmFNLf6Q5So51FYZG4R1e4bBcotEAR3p0gYNrfT8FI0Apm5
         Eemw==
X-Gm-Message-State: APjAAAWh08f0E38W5qq0mXBWFYL0goU46hVSC4MekWmrtYXQUjqSL9CT
        lDgaZ8+X3OXYOWPNttWiocBykicHUr7tlIHePEdkaA==
X-Google-Smtp-Source: APXvYqwcLEHzb35dACcEJcdFOXQXmkYsOYs9OYxJaMPH8YUB0PFOIgObLuFpVYP3q2UdIVREsQ+cFOnqUYbEm49cITY=
X-Received: by 2002:a92:9ac5:: with SMTP id c66mr6381321ill.232.1580124749482;
 Mon, 27 Jan 2020 03:32:29 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
 <20200125174645.GC4616@mellanox.com> <CANjDDBht4vTzkrRH1L9_9CquvsfRwo6VmPb6FFT2HNzkkh0H0w@mail.gmail.com>
 <20200127092641.GM3870@unreal>
In-Reply-To: <20200127092641.GM3870@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Mon, 27 Jan 2020 17:01:53 +0530
Message-ID: <CANjDDBgBMWUdqHVDAoAfBibiFqB_ia1YyTiMTJcJ-8-Ls09-Sw@mail.gmail.com>
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation code
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 2:56 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Jan 27, 2020 at 01:43:51PM +0530, Devesh Sharma wrote:
> > On Sat, Jan 25, 2020 at 11:16 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Fri, Jan 24, 2020 at 12:52:39AM -0500, Devesh Sharma wrote:
> > > > +static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
> > > > +{
> > > > +     struct bnxt_re_qp *gsi_sqp;
> > > > +     struct bnxt_re_ah *gsi_sah;
> > > > +     struct bnxt_re_dev *rdev;
> > > > +     int rc = 0;
> > > > +
> > > > +     rdev = qp->rdev;
> > > > +     gsi_sqp = rdev->gsi_ctx.gsi_sqp;
> > > > +     gsi_sah = rdev->gsi_ctx.gsi_sah;
> > > > +
> > > > +     /* remove from active qp list */
> > > > +     mutex_lock(&rdev->qp_lock);
> > > > +     list_del(&gsi_sqp->list);
> > > > +     atomic_dec(&rdev->qp_count);
> > > > +     mutex_unlock(&rdev->qp_lock);
> > > > +
> > > > +     dev_dbg(rdev_to_dev(rdev), "Destroy the shadow AH\n");
> > > > +     bnxt_qplib_destroy_ah(&rdev->qplib_res,
> > > > +                           &gsi_sah->qplib_ah,
> > > > +                           true);
> > > > +     bnxt_qplib_clean_qp(&qp->qplib_qp);
> > > > +
> > > > +     dev_dbg(rdev_to_dev(rdev), "Destroy the shadow QP\n");
> > > > +     rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> > > > +     if (rc) {
> > > > +             dev_err(rdev_to_dev(rdev), "Destroy Shadow QP failed");
> > > > +             goto fail;
> > > > +     }
> > > > +     bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> > > > +
> > > > +     kfree(rdev->gsi_ctx.sqp_tbl);
> > > > +     kfree(gsi_sah);
> > > > +     kfree(gsi_sqp);
> > > > +     rdev->gsi_ctx.gsi_sqp = NULL;
> > > > +     rdev->gsi_ctx.gsi_sah = NULL;
> > > > +     rdev->gsi_ctx.sqp_tbl = NULL;
> > > > +
> > > > +     return 0;
> > > > +fail:
> > > > +     mutex_lock(&rdev->qp_lock);
> > > > +     list_add_tail(&gsi_sqp->list, &rdev->qp_list);
> > > > +     atomic_inc(&rdev->qp_count);
> > > > +     mutex_unlock(&rdev->qp_lock);
> > > > +     return rc;
> > >
> > > This error unwind approach looks racy. destroy is not allowed to
> > > fail, so why all this mess?
> > True, the unwind is not required, even if the driver wants to keep it
> > for debugging purpose, the zombie resource would give rise to
> > confusion.
>
> Jason doesn't suggest to leave zombie resources, but to clean everything
> without any relation to returned status from bnxt_qplib_destroy_qp().
Yeah, let me complete my statement, "zombie resources should go, no
need to have them on the list even if destroy-object firmware command
has failed."
>
> Thanks
