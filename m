Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA1B32A81C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579789AbhCBRJl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245759AbhCBLgz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Mar 2021 06:36:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 992FF64EF4;
        Tue,  2 Mar 2021 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614684945;
        bh=QYORUg6MWJj5KzcskwuwqFJFmFdTn9wtcbYZ2e/OC7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LhiW0BbUVmxzju8Ku3/nzwaXdeOGALz2rmnPpAY6VUM6N6kOcBkTYaq1FaLAJhy87
         LsHwmsIkehJfjUojX3iKwnuIqji2Im17g/T607fg1sJW0eoME4hsc5U8QimBqMhnTp
         o4Zh8AdT7IcrEkzsg2iPM2zF1X6EYgn8qJDOnL0BtQhZ/w8EFwCMcI/1f+h+/KKErd
         bpiheHvTyIJKJdjyxMm8JKuEq7CLWYk+TYna9KGVSpkzu8vMDcrXQoqSYwz2vf2ixL
         WtmWzNty6MeuF88mczCjRfC9wjmGhal6QA7rGISBYkUak4jBOI6PyXhmhuIQUaXbiN
         SZ79S/0TPbdMw==
Date:   Tue, 2 Mar 2021 13:35:41 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 1/2] RDMA/mlx5: Set correct kernel-doc identifier
Message-ID: <YD4jDbyn6PZQ76HB@unreal>
References: <20210302074214.1054299-1-leon@kernel.org>
 <20210302074214.1054299-2-leon@kernel.org>
 <20210302093109.GA2690909@dell>
 <YD4SxWLbPkEoH3GR@unreal>
 <20210302104410.GD2690909@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302104410.GD2690909@dell>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 02, 2021 at 10:44:10AM +0000, Lee Jones wrote:
> On Tue, 02 Mar 2021, Leon Romanovsky wrote:
>
> > On Tue, Mar 02, 2021 at 09:31:09AM +0000, Lee Jones wrote:
> > > On Tue, 02 Mar 2021, Leon Romanovsky wrote:
> > >
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > >
> > > > The W=1 allmodconfig build produces the following warning:
> > > > drivers/infiniband/hw/mlx5/odp.c:1086: warning: wrong kernel-doc identifier on line:
> > > >   * Parse a series of data segments for page fault handling.
> > > >
> > > > Fix it by changing /** to be /* as it is written in kernel-doc documentation.
> > > >
> > > > Fixes: 5e769e444d26 ("RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in 'pagefault_data_segments()'")
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  drivers/infiniband/hw/mlx5/odp.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> > > > index 374698186662..b103555b1f5d 100644
> > > > --- a/drivers/infiniband/hw/mlx5/odp.c
> > > > +++ b/drivers/infiniband/hw/mlx5/odp.c
> > > > @@ -1082,7 +1082,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
> > > >  	return ret ? ret : npages;
> > > >  }
> > > >
> > > > -/**
> > > > +/*
> > >
> > > This is not the correct fix.
> >
> > I don't want kernel-doc comments on static function. It is local to this
> > file, so change from /** to /* was to mark that this is not kernel-doc.
> >
> > >
> > > Kernel-doc is asking for the function name.
> >
> > The thing is that I don't want it to be kernel-doc.
>
> In the past, if the authors have made a good effort to document the
> function, I have left the kernel-doc formatting in place.  It looks
> odd / non-consistent to demote some, but not others.  Especially
> considering there are 100's if not 1000's of other static functions
> documented in the kernel with kernel-doc formatting.

I'm not interested to solve all kernel-doc issues, but only specific to
drivers/infiniband and especially this mlx5 driver which is under my
responsibility.

>
> There are also 1000's of uses that are left referenced by kernel-doc::
> tags.  See: scripts/find-unused-docs.sh for more details.
>
> If you're going to go through with this, you should at least say what
> you're doing and why in the commit message.  Since demoting an
> otherwise full and complete kernel-doc header seems a little harsh to
> say the least.

It wasn't kernel-doc from the beginning.

Thanks

>
> --
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
