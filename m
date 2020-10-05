Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C82283C94
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgJEQdH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgJEQdH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 12:33:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F25EC0613CE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Oct 2020 09:33:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 188so1822168qkk.12
        for <linux-rdma@vger.kernel.org>; Mon, 05 Oct 2020 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oowVlRsJEVJv/f1qJEWY252mRzVr4hWBivZL8HEemGQ=;
        b=E7OZ8A12leLVSPQCAg4P/fH9v44f/WulkCMZ1GeDadTvyFnBgaop9eYQJkYeA4zapj
         6pmtUIN5fmaOQpH0hvQpNBN/B8ueQW91k/wu2smlIcbGE2lkZ0Wasrk7Or81hICwjQmr
         q3fNUIoiHWQjdAuln4MIHRqsIIPq1mv7mYmTRO04q3+c2yq2SaQqAQupOobOs5gIHQUe
         RXkNfNyfWs/I2GjGhp+qlmIgjG9kNMoE469ml2BOgBt6aD6D25gk9QcQmfv0Wyc40/f0
         h7+6onewNO00cie1zOyk1EmLc6iLItw/pZ6xOCknQAjUVOlNEGvBRdEWWeaBR/tbALhR
         cTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oowVlRsJEVJv/f1qJEWY252mRzVr4hWBivZL8HEemGQ=;
        b=DQHcj9mKv/j3Crl+yVtjyN2pDiQJSgTLwH/j2q8y+11Cbb+R1gveFiqxR8IwLPrQAr
         cT+2djpIEUmsRH2dZMlOKWEYF7XiaE4cu91YQV7It70CQcPFJOsFpaVUB8parJKzE+dd
         EHHe/Z02tTFxMjyRmYzN+xklUMbiN95lGBn+0Ry/idv/V1fJO/094yj7jCashkMSneeY
         8Vu7V9BDAWKJyOBlEGLh51h8QU7ZoHXdVoNKqVG4mysW4m6eYKgAmkpNcEQL3SLIPGwS
         JDnlByQqR8Q4HNt1O3OJgXCCPFiwHaKl0zwdb9oYz9ogNKmwQESq+06dyOT2gue3BTXe
         13Iw==
X-Gm-Message-State: AOAM533jFE0Ik8iQRQP2LiqN4BxCJFY9PjCoip6d+e1Jt4Vg89sG5Yqo
        ZktVlrdRRUoQdTIk0f5faoEUF3BHSWsQ5qdg
X-Google-Smtp-Source: ABdhPJwrjwCYaioBhB9E/E5gO1HdGMgQDw1J+wcB40v1oo3zqYQL7kSaQI1BktuawKxECOFpRQw+rw==
X-Received: by 2002:a37:5904:: with SMTP id n4mr835887qkb.364.1601915585764;
        Mon, 05 Oct 2020 09:33:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m6sm361832qkh.106.2020.10.05.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:33:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPTQ8-007hcI-Bv; Mon, 05 Oct 2020 13:33:04 -0300
Date:   Mon, 5 Oct 2020 13:33:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201005163304.GU9916@ziepe.ca>
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
 <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
 <20201005131302.GQ9916@ziepe.ca>
 <MW3PR11MB455572267489B3F6B1C5F8C5E50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB455572267489B3F6B1C5F8C5E50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 05, 2020 at 04:18:11PM +0000, Xiong, Jianxin wrote:

> > The implementation in mlx5 will be much more understandable, it would just do dma_buf_dynamic_attach() and program the XLT exactly
> > the same as a normal umem.
> > 
> > The move_notify() simply zap's the XLT and triggers a work to reload it after the move. Locking is provided by the dma_resv_lock. Only a
> > small disruption to the page fault handler is needed.
> 
> We considered such scheme but didn't go that way due to the lack of
> notification when the move is done and thus the work wouldn't know
> when it can reload.

Well, the work would block on the reservation lock and that indicates
the move is done

It would be nicer if the dma_buf could provide an op that things are
ready to go though

> Now I think it again, we could probably signal the reload in the page fault handler. 

This also works, with a performance cost

> > > +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> > > +	sgt = dma_buf_map_attachment(umem_dmabuf->attach,
> > > +				     DMA_BIDIRECTIONAL);
> > > +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> > 
> > This doesn't look right, this lock has to be held up until the HW is programmed
> 
> The mapping remains valid until being invalidated again. There is a
> sequence number checking before programming the HW.

It races, we could immediately trigger invalidation and then
re-program the HW with this stale data.
 
> > The use of atomic looks probably wrong as well.
> 
> Do you mean umem_dmabuf->notifier_seq? Could you elaborate the concern?

It only increments once per invalidation, that usually is racy.

> > > +	total_pages = ib_umem_odp_num_pages(umem_odp);
> > > +	for_each_sg(umem->sg_head.sgl, sg, umem->sg_head.nents, j) {
> > > +		addr = sg_dma_address(sg);
> > > +		pages = sg_dma_len(sg) >> page_shift;
> > > +		while (pages > 0 && k < total_pages) {
> > > +			umem_odp->dma_list[k++] = addr | access_mask;
> > > +			umem_odp->npages++;
> > > +			addr += page_size;
> > > +			pages--;
> > 
> > This isn't fragmenting the sg into a page list properly, won't work for unaligned things
> 
> I thought the addresses are aligned, but will add explicit alignment here.

I have no idea what comes out of dma_buf, I wouldn't make too many
assumptions since it does have to pass through the IOMMU layer too

> > And really we don't need the dma_list for this case, with a fixed
> > whole mapping DMA SGL a normal umem sgl is OK and the normal umem
> > XLT programming in mlx5 is fine.
> 
> The dma_list is used by both "polulate_mtt()" and
> "mlx5_ib_invalidate_range", which are used for XLT programming and
> invalidating (zapping), respectively.

Don't use those functions for the dma_buf flow.

Jason
