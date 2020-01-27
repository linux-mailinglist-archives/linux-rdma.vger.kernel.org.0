Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0514A0AF
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 10:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgA0J0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 04:26:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgA0J0p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jan 2020 04:26:45 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 924782071E;
        Mon, 27 Jan 2020 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580117205;
        bh=BEYINrpt3lq7ToMp+mP3E/SaMYurewqc+wPPtq3aD8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Am/AYeKpvWAMAdtC8DWrNhRU8abHC4WMo0OH+DsArYliYxz/Y8/Zm6mdTNUxRaMTY
         P40BhgxPtQCv8Hmiqm+0UFKEyQOmyCxRPiFwkDs1xk+6K553gla1Z2KYZt42vG5eJ5
         R8KefAchNDOgKFDJyUbLRTDubITTyvDrnJiyWcjA=
Date:   Mon, 27 Jan 2020 11:26:41 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation
 code
Message-ID: <20200127092641.GM3870@unreal>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
 <20200125174645.GC4616@mellanox.com>
 <CANjDDBht4vTzkrRH1L9_9CquvsfRwo6VmPb6FFT2HNzkkh0H0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBht4vTzkrRH1L9_9CquvsfRwo6VmPb6FFT2HNzkkh0H0w@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 01:43:51PM +0530, Devesh Sharma wrote:
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

Jason doesn't suggest to leave zombie resources, but to clean everything
without any relation to returned status from bnxt_qplib_destroy_qp().

Thanks
