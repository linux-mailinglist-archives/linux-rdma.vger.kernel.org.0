Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF80914D653
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 07:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgA3GFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 01:05:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33606 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgA3GFS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jan 2020 01:05:18 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so2713267ioh.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2020 22:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXcNOpKnxQpFC9p0YtSCwY8vkC7znsJwRL+XlmQ08VU=;
        b=SaAKjPj0F9scUqQeZ3LDM6NPcjp37pJBOmP4+DI0lQLwcEnmI6zsBi+QSH9VB2CXZo
         fULAu1Y6rOBASW2zUbYvFzH/4JN53jkPCX6HnVZQNeIRRFLTHIkdBBi/vi+jfSb8Wbuo
         pturiCXoQ7BlMrJmJkc8hY8SHBzgMenhYEV1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXcNOpKnxQpFC9p0YtSCwY8vkC7znsJwRL+XlmQ08VU=;
        b=DFMSHb9Hfw0KDVFDVGzxV8glChUf7DkH+HQfPtKXGMVFd36bf4xuvxNTMAwVEvZOJF
         d3NWtcrLz73Et+7LawKVlGSYEJm9b9NEzNV3JQ01B0XjkX9Ahh/H4HoIh8iTl3gPmaly
         fwxWALxmsk1HhKUUxhoiFm4ZxMyG8bJPyCDWWHziUljsb6yAnYqqMHLLcTgzjMVhUS6C
         VcoHejGc9szEpT/29EEvJSTavD6AVufkJZtqkjTDndkZcnCpX5IrdR2OVNoRCR2woMN7
         sjCrPLI5Cb7YZYHRTmx69GrGuU8Hlhe4mDkpd5LIpvXERKgLy6PLhmKyG/m9xWjCMJpG
         OIJQ==
X-Gm-Message-State: APjAAAWtpjM72FYvlaBk/DPCuA/Ue0egLxknnFMnOMAD78iWga/WRGHa
        lCSRBvJjizkpxcLDARm+pNtYJohlJtftTpiBYlP/yQ==
X-Google-Smtp-Source: APXvYqyebzgCO9DNj4cbxood9Rg9DwxjqSjuP0aJjjHXKVl5PsYwaGTkqZpBuxKmQ4WVd4PapCj4cGPtk/Rzj94oDXI=
X-Received: by 2002:a6b:7113:: with SMTP id q19mr2818850iog.87.1580364316081;
 Wed, 29 Jan 2020 22:05:16 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
 <20200125174645.GC4616@mellanox.com> <CANjDDBht4vTzkrRH1L9_9CquvsfRwo6VmPb6FFT2HNzkkh0H0w@mail.gmail.com>
In-Reply-To: <CANjDDBht4vTzkrRH1L9_9CquvsfRwo6VmPb6FFT2HNzkkh0H0w@mail.gmail.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 30 Jan 2020 11:34:39 +0530
Message-ID: <CANjDDBjcrfBvGk=THyqiqhOPS0-xzLrnCUc5=A98j=pfPJbtsA@mail.gmail.com>
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
Done, removing unwind logic in V2.
> >
> > Jason
