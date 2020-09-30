Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E8327EFA6
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 18:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgI3Qvr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 12:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3Qvr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 12:51:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD65206C9;
        Wed, 30 Sep 2020 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601484706;
        bh=MwdJW4mqrWOrBCkHeReFHIvPIJHWwvzq0/1WZ3thz34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0QiwqGrru7E0hnFByyf199zgzY5HfiHmMto2K2DP2GQaRpF+SQylW3LD64x0jYywQ
         GcH0r71FBZ2SrN2dwCGbIV3fjNBJqBLpm/gW0SCLI6mvVwTGAH152XfnjfVFnYbu9N
         wSMSXIznFZBAd5pNwXWXfAuppEMtLhJPcm6C38Ms=
Date:   Wed, 30 Sep 2020 19:51:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Subject: Re: [PATCH rdma-next v4 4/4] RDMA/umem: Move to allocate SG table
 from pages
Message-ID: <20200930165142.GS3094@unreal>
References: <20200927064647.3106737-1-leon@kernel.org>
 <20200927064647.3106737-5-leon@kernel.org>
 <20200929195929.GA803555@nvidia.com>
 <20200930095321.GL3094@unreal>
 <20200930114527.GE816047@nvidia.com>
 <80c49ff1-52c7-638f-553f-9de8130b188d@nvidia.com>
 <20200930115837.GF816047@nvidia.com>
 <7e09167f-c57a-cdfe-a842-c920e9421e53@nvidia.com>
 <20200930151406.GM816047@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930151406.GM816047@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 12:14:06PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 30, 2020 at 06:05:15PM +0300, Maor Gottlieb wrote:
> > This is right only for the last iteration. E.g. in the first iteration in
> > case that there are more pages (left_pages), then we allocate
> > SG_MAX_SINGLE_ALLOC.  We don't know how many pages from the second iteration
> > will be squashed to the SGE from the first iteration.
>
> Well, it is 0 or 1 SGE's. Check if the first page is mergable and
> subtract one from the required length?
>
> I dislike this sg_mark_end() it is something that should be internal,
> IMHO.

I don't think so, but Maor provided possible solution.
Can you take the patches?

Thanks

>
> Jason
