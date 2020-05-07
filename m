Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462B81C81F3
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 07:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgEGF6T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 01:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgEGF6T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 01:58:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7005320753;
        Thu,  7 May 2020 05:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588831099;
        bh=fyTUPi8v8JClBMMEuAa7g8FvRzpq4i23J9BbQc/DiYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DY3IIMTRrXnUGUKH7Y2yDxcgbQdiyK0FTUmHlaPHZHP1LSfBgYo2f0V0WW1BQRbzj
         rHHTGFXGkvHfSgDf7HD7P7jUQSIIszUdr9zgIvvfXO1WITMc/Acs/m7WmaokEWlrby
         BzVm9UCWDc+yA6LKUFZNxX9eUqPBikk6wDMomFwM=
Date:   Thu, 7 May 2020 08:58:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     jackm <jackm@dev.mellanox.co.il>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        ferasda@mellanox.com, mohammadkab@mellanox.com, moshet@mellanox.com
Subject: Re: [PATCH rdma-rc v1] IB/core: Fix potential NULL pointer
 dereference in pkey cache
Message-ID: <20200507055814.GC78674@unreal>
References: <20200506053213.566264-1-leon@kernel.org>
 <20200506144344.GA8875@ziepe.ca>
 <20200506165608.GA4600@unreal>
 <20200506180936.GI26002@ziepe.ca>
 <20200506214123.0000121c@dev.mellanox.co.il>
 <20200506185737.GJ26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506185737.GJ26002@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 03:57:37PM -0300, Jason Gunthorpe wrote:
> On Wed, May 06, 2020 at 09:41:23PM +0300, jackm wrote:
> > On Wed, 6 May 2020 15:09:36 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > > > > > +out:
> > > > > > +	ib_cache_release_one(device);
> > > > > > +	return err;
> > > > >
> > > > > ib_cache_release_once can be called only once, and it is always
> > > > > called by ib_device_release(), it should not be called here
> > > >
> > > > It doesn't sound right if we rely on ib_device_release() to unwind
> > > > error in ib_cache_setup_one(). I don't think that we need to return
> > > > from ib_cache_setup_one() without cleaning it.
> > >
> > > We do as ib_cache_release_one() cannot be called multiple times
> > >
> > > The general design of all this pre-registration stuff is that the
> > > release function does the clean up and the individual functions should
> > > not error unwind cleanup done in the unconditional release.
> > >
> > > Other schemes were too complicated
> > >
> > > Jason
> >
> > What about calling gid_table_release_one(device) instead of
> > ib_cache_release_one(device) in the error flow ?
>
> Why?

Because it doesn't look clean.

>
> That is not the design, everything that is freed by release is defered
> to release, even on error paths.

I'll resend now.

Thanks

>
> Jason
