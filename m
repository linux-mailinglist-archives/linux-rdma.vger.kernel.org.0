Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99513B7D70
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 08:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhF3GcY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 02:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhF3GcX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 02:32:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B354861459;
        Wed, 30 Jun 2021 06:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625034595;
        bh=7okMDfPJvuf4xALqZkt0/Ib+PKZ5zUye1p/vGQTvVzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDkWhrgCWo/ElLUGgWRWMpMXvIfkWj01IYdHjO0pPaK/yhIFDyycPXCKGNOlypeoI
         9sJaRM5xXvo+YQa22zCNFkNIveI1XJkTI7RkKlVT53DpcyAZClZ1FzptULpBoHIzCO
         uidzhZM3ak/r/9PT/DuHXQjfvQyO+ZqEaP0wFJh4WDTaf4bKan9Afw+0u4c+WplSh6
         un0LYGX82NAZUyzbqwUw7dPYWWR/Ymy5JN33IGpL4NU6HLbarcHmAcCcZCTN7GMleK
         YEV8ir0DA7sGyOKkk1QmKgHehHHsaavj/lcjeRuFvkJaTrGN0PvJhQKftdQUG4a2Uc
         XPKSd1/SfNfQA==
Date:   Wed, 30 Jun 2021 09:29:51 +0300
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
Message-ID: <YNwPX7BxPl22En9U@unreal>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <YNwIL4OguRO/CH6K@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNwIL4OguRO/CH6K@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 30, 2021 at 06:59:11AM +0100, Christoph Hellwig wrote:
> On Tue, Jun 29, 2021 at 11:40:01AM +0300, Leon Romanovsky wrote:
> > 2. Add a new field total_nents to reflect the total number of entries
> >    in the table. This is required for the release flow (sg_free_table).
> >    This filed should be used internally only by scatterlist.
> 
> No, please don't bloat the common structure.

Somehow we need to store that total_nents value and our internal
proposal was to wrap sg_table with another private structure that is
visible in lib/scatterlist.c only.

Something like that:
struct sg_table_private {
  struct sg_table table;
  unsigned int total_nents;
};

But it looks awkward.

> 
> > +	/* The fields below should be used internally only by
> > +	 * scatterlist implementation.
> > +	 */
> 
> And this is not the way kernel comments work.

It is netdev style.

Thanks
