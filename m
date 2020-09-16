Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBF26BDC7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIPHRb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 03:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgIPHRZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 03:17:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB262076B;
        Wed, 16 Sep 2020 07:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600240645;
        bh=lPltz0UA//MmcZWvq3LaaXKDBJM+SO+YnSL4n5jpfn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMzTtvuFxSoJYvZ7IP4WZyqQbx/dcPRXdz6RQZjc+n2IF/YMhxHfBLeuuLUwnFqNc
         LFmDCGuU2WxJtVTymLWNQfl8d5IK4RCWU39i4wANX5kBlTQY/o+yEfrUE0/PBaZQH8
         hJ0Do36tvsGC6pcl73QrN9mGhPrcESKmBbAOU3v8=
Date:   Wed, 16 Sep 2020 10:17:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 1/4] lib/scatterlist: Refactor
 sg_alloc_table_from_pages
Message-ID: <20200916071721.GC486552@unreal>
References: <20200910134259.1304543-1-leon@kernel.org>
 <20200910134259.1304543-2-leon@kernel.org>
 <20200915161643.GA24320@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915161643.GA24320@lst.de>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 15, 2020 at 06:16:43PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 10, 2020 at 04:42:56PM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@nvidia.com>
> >
> > Currently, sg_alloc_table_from_pages doesn't support dynamic chaining of
> > SG entries. Therefore it requires from user to allocate all the pages in
> > advance and hold them in a large buffer. Such a buffer consumes a lot of
> > temporary memory in HPC systems which do a very large memory registration.
> >
> > The next patches introduce API for dynamically allocation from pages and
> > it requires us to do the following:
> >  * Extract the code to alloc_from_pages_common.
> >  * Change the build of the table to iterate on the chunks and not on the
> >    SGEs. It will allow dynamic allocation of more SGEs.
> >
> > Since sg_alloc_table_from_pages allocate exactly the number of chunks,
> > therefore chunks are equal to the number of SG entries.
> >
> > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>
> I really don't think this refactoring on its own adds any value,
> it just makes reading the rest of the series harder.

We expected this type of the comment, but decided to send "splitted"
version because it is much easier to squash patches instead of splitting
them later.

We will squash and resubmit.

>
> (functionally it looks correct, though)

Thanks
