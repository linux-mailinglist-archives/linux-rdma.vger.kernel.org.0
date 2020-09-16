Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F626BDCB
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 09:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIPHSc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 03:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIPHS3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 03:18:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FAC72076B;
        Wed, 16 Sep 2020 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600240709;
        bh=HAQ3vL/VYHuED6APCm9izUwtd9CezAHSvsIV/bvACZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXez6po/Fea8/xUFMpfxQ5VMeRSXLkXPv1MI4sma3b0HJHFgmQ1FjXD5DUd3yb7vp
         +X4uGd40HgZiC3+7rfgXaESz45XwQ4l+wVq+fX4Xs4fLURFzYuITMjCwP96gwy0QLm
         J0yn1bDPDCJ3jmiTlQMDtQQQA5TOod1QIImSi85o=
Date:   Wed, 16 Sep 2020 10:18:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/4] lib/scatterlist: Add support in
 dynamically allocation of SG entries
Message-ID: <20200916071824.GD486552@unreal>
References: <20200910134259.1304543-1-leon@kernel.org>
 <20200910134259.1304543-3-leon@kernel.org>
 <20200915161926.GB24320@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915161926.GB24320@lst.de>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 15, 2020 at 06:19:26PM +0200, Christoph Hellwig wrote:
> > +			/* We decrease one since the prvious last sge in used to
> > +			 * chainning.
> > +			 */
>
> The normal style would be:

It is netdev style of formatting, will change.

>
> 			/*
> 			 * We decrease one since the prvious last sge in used to
> 			 * chain the chunks together.
> 			 */
>
> (also fixing up what I think it should be saying while I'm at it)
>
> > + *   Thus if @nents is bigger than @max_ents, the scatterlists will be
> > + *   chained in units of @max_ents.
> > + *
> > + **/
> > +static int sg_alloc_next(struct sg_table *table, struct scatterlist *last,
> > +			 unsigned int nents, unsigned int max_ents,
> > +			 gfp_t gfp_mask)
> > +{
> > +	return sg_alloc(table, last, nents, max_ents, NULL, 0, gfp_mask,
> > +			sg_kmalloc);
> > +}
>
> This helper seems unused in this patch.  For bisection you probably
> want to move it into the next patch with the user.
>
> In fact I'm not even sure there is much of a point in splitting out
> this patch either.

We will squash.
