Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542FF3B7DC8
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 09:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhF3HEo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 03:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhF3HEn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 03:04:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6D3C611AF;
        Wed, 30 Jun 2021 07:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625036535;
        bh=fHMMVrtlxKeaKsAvLWSY7uHaUoi7yT4jN4cdWFy07Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FT8PQ9XsaNMtbxvhMA+KQF2M5q77vzCstbkWP1GXp251+YRgazbFXCrMHcfQ3VLbc
         vTkMf1hd+cX88d9/o5QBCRTAkOW5QbEJMT2kf+IKvUfe2q+zf1noQGKhHCIZbr5NVO
         rJ3lyP6PU+GB9bBhLtT7Ga/QDTwQRkNXd6MFPhNHYZGlrD5oi8XGkSeHy2mjrSUuxO
         k2ICLfkc87ujh7YP28lK33PmwSis3XUJIyJ86DhOimN3AykgQYX3es2CwapqfrTgZp
         S4wr68Uxhlf72wLfK+2uzl4bn15SwRRWQ/aLJmHSM4ourpFATSxOGAWH1SQjiFye4Z
         tDeiWt1HqOT+g==
Date:   Wed, 30 Jun 2021 10:02:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YNwW83ZpXZSSPDfM@unreal>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <YNwIL4OguRO/CH6K@infradead.org>
 <YNwPX7BxPl22En9U@unreal>
 <YNwQLV87aBdclTYe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwQLV87aBdclTYe@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 30, 2021 at 07:33:17AM +0100, Christoph Hellwig wrote:
> On Wed, Jun 30, 2021 at 09:29:51AM +0300, Leon Romanovsky wrote:
> > On Wed, Jun 30, 2021 at 06:59:11AM +0100, Christoph Hellwig wrote:
> > > On Tue, Jun 29, 2021 at 11:40:01AM +0300, Leon Romanovsky wrote:
> > > > 2. Add a new field total_nents to reflect the total number of entries
> > > >    in the table. This is required for the release flow (sg_free_table).
> > > >    This filed should be used internally only by scatterlist.
> > > 
> > > No, please don't bloat the common structure.
> > 
> > Somehow we need to store that total_nents value and our internal
> > proposal was to wrap sg_table with another private structure that is
> > visible in lib/scatterlist.c only.
> > 
> > Something like that:
> > struct sg_table_private {
> >   struct sg_table table;
> >   unsigned int total_nents;
> > };
> > 
> > But it looks awkward.
> 
> Well, the important point is that we only need it for the new
> way of collapsing, appending allocations.  We should not burden
> it on all other users.

Another possible solution is to change __sg_alloc_table()/__sg_alloc_table_from_pages
to return total_nents and expect from the users to store it internally and pass
it later to the __sg_free_table().

Something like that.

Thanks
