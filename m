Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17235149F6D
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgA0IEo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 03:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgA0IEo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jan 2020 03:04:44 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909042071E;
        Mon, 27 Jan 2020 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580112284;
        bh=qm/j6PIBJR5e6IF2G5xjHTG1i8NyH5ALnfgJSlcuBCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnyZzXP6mORIm2SZKLcAGrIj9krzCFo1PvUsrqZBc1zaNL79NN+nyoRpnhiJ7kUcl
         P3uBPh0NxT9QJYDgPCowt5eE9eQkJcC3vnBetMfkiaahpZsZPGTrcJb8E4Ck7i0iWv
         txVc3pjpncrGENtZhM36x9VANtFP+XEgZ/yxzDmU=
Date:   Mon, 27 Jan 2020 10:04:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH for-next 2/7] RDMA/bnxt_re: Replace chip context
 structure with pointer
Message-ID: <20200127080440.GL3870@unreal>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-3-git-send-email-devesh.sharma@broadcom.com>
 <20200125180252.GD4616@mellanox.com>
 <CANjDDBiSLY55v=cA+gMC6QFAqxUxiiFCy3y3_Rw9vF+v40LgDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBiSLY55v=cA+gMC6QFAqxUxiiFCy3y3_Rw9vF+v40LgDQ@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 01:09:46PM +0530, Devesh Sharma wrote:
> On Sat, Jan 25, 2020 at 11:33 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Fri, Jan 24, 2020 at 12:52:40AM -0500, Devesh Sharma wrote:
> > >  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
> > >  {
> > > +     struct bnxt_qplib_chip_ctx *chip_ctx;
> > > +
> > > +     if (!rdev->chip_ctx)
> > > +             return;
> > > +     chip_ctx = rdev->chip_ctx;
> > > +     rdev->chip_ctx = NULL;
> > >       rdev->rcfw.res = NULL;
> > >       rdev->qplib_res.cctx = NULL;
> > > +     kfree(chip_ctx);
> > >  }
> >
> > Are you sure this kfree is late enough? I couldn't deduce if it was
> > really safe to NULL chip_ctx here.
> With the current design its okay to free this here because
> bnxt_re_destroy_chip_ctx is indeed the last deallocation performed
> before ib_device_dealloc() in any exit path. Further, the call to
> bnxt_re_destroy_chip_ctx is protected by rtnl.

??? Why does device destroy path need global lock to already existing
protection from ib_core?

Thanks
