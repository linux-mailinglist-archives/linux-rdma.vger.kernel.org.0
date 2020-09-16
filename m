Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA726C724
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgIPSTp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 14:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbgIPST1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 14:19:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD5521655;
        Wed, 16 Sep 2020 18:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600280355;
        bh=+JmGQ/EiV4TkHPA7FyaKj9RbV4ow4WAIuKsmvYs9RXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rR2p/JKwdTx4oLY0mp8zGuzpdfm4OfMy0RgiayX1p7CNPaZ/dGZ5Vrpv+ItxO6sa1
         zkIldfvyGgBuawrbvw2r/3Ch6VyvXeEWUjMQVuusJu/8BwbUOv2l7L+NJdukKAwwvp
         BenmtdQi2Ld8U0rsUg+tlGdm3f0ge2AC6d9mWASE=
Date:   Wed, 16 Sep 2020 21:19:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/4] IB/core: Enable ODP sync without faulting
Message-ID: <20200916181911.GL486552@unreal>
References: <20200914113949.346562-1-leon@kernel.org>
 <20200914113949.346562-3-leon@kernel.org>
 <20200916164706.GB11582@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916164706.GB11582@infradead.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 05:47:06PM +0100, Christoph Hellwig wrote:
> > +		if (fault) {
> > +			/*
> > +			 * Since we asked for hmm_range_fault() to populate pages,
>
> Totally pointless line over 80 characters.

checkpatch.pl was updated to allow 100 symbols.

Regarding "pointless", at least for me it wasn't clear why we don't
have HMM_PFN_ERROR check in non-fault path so I asked form Yishai to
add this comment.

>
> > +			access_mask = (range.hmm_pfns[pfn_index] & HMM_PFN_WRITE) ?
> > +				(ODP_READ_ALLOWED_BIT | ODP_WRITE_ALLOWED_BIT) :
> > +				 ODP_READ_ALLOWED_BIT;
> > +		}
>
> Another weird overly long line, caused by rather osfucated code.  This
> really should be something like:
>
> 			access_mask = ODP_READ_ALLOWED_BIT;
> 			if (range.hmm_pfns[pfn_index] & HMM_PFN_WRITE)
> 				access_mask |= ODP_WRITE_ALLOWED_BIT;

Sure

>
