Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54483D2459
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhGVM2U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhGVM2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jul 2021 08:28:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74790C061575;
        Thu, 22 Jul 2021 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+mjAA153JG0Ln8wFYY041kj2Rsi0lJ7YGWt7SwKJF/8=; b=PCpF0eOlIHL6HnaeLDPKGuJyur
        Pj7KAq8ENbbzU+SxmHu185G55Dox0US5sMQr1fkTbdb/zTJoE2dUMURZfqMgPvnY8Hw0Llq333J0/
        oYE1BbgMLmoWGIzHtyuYyyCjalyd5tJdIFcFM4VCDTmiZoYCPAA7QYxkWdeGOKGZNvkzZQGuGbuAu
        Jk2CxbLLWhfMRsoZbr62BVyBGiSsCcw0KdRDbcOTDQaShIX0iKY0n7puoBCH+YYkpr1ODbfZcIDZr
        VPW+l2FIH+WqntMDhWe4muRuevFo7ZNkAA3hAJHgAoXtN3DhasPfQxNY3uEhb/YUUsj/C4mQgg8Tr
        QgC9QV6w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6YQZ-00AHI5-Mg; Thu, 22 Jul 2021 13:07:53 +0000
Date:   Thu, 22 Jul 2021 14:07:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zack Rusin <zackr@vmware.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v2 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YPltp39n9URglTXT@infradead.org>
References: <cover.1626605893.git.leonro@nvidia.com>
 <36d655a0ff45f4c86762358c7b6a7b58939313fb.1626605893.git.leonro@nvidia.com>
 <20210722130040.GH1117491@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722130040.GH1117491@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 10:00:40AM -0300, Jason Gunthorpe wrote:
> this is better:
> 
>    struct sg_append_table state;
> 
>    sg_append_init(&state, sgt, gfp_mask);
> 
>    while (..)
>      ret = sg_append_pages(&state, pages, n_pages, ..)
>      if (ret)
> 	 sg_append_abort(&state); // Frees the sgt and puts it to NULL
>    sg_append_complete(&state)
> 
> Which allows sg_alloc_table_from_pages() to be written as
> 
>    struct sg_append_table state;
>    sg_append_init(&state, sgt, gfp_mask);
>    ret = sg_append_pages(&state,pages, n_pages, offset, size, UINT_MAX)
>    if (ret) {
>       sg_append_abort(&state);
>       return ret;
>    }
>    sg_append_complete(&state);
>    return 0;
> 
> And then the API can manage all of this in some sane and
> understandable way.

That would be a lot easier to use for sure.  Not sure how invasive the
changes would be, though.
