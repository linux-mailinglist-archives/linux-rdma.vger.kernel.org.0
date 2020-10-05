Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3D283654
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJENNH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJENNH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 09:13:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A54C0613CE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Oct 2020 06:13:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z6so3240496qkz.4
        for <linux-rdma@vger.kernel.org>; Mon, 05 Oct 2020 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g/nm80+Ud0wRxvGfW3dlVEjR1+0DLL+VUhoF4LmgS+Q=;
        b=HHMoe12/eAzH/fwzfESo4EPwuolZOIMbQjNC5GQRJrIb3mESWoCqFb/+X48/ok5xAY
         1Ib5j6cJag2rt7rEGRcYQvbjvT6rY99IutD+lWrQU8ZQAc2QLQ8yiHaxqA+hTUm9R0AG
         5niHdR+a9omhIWYTsRo+b8q6GcK3Zs8XSzXSBOQxcbygY0/2oiGqrcWOgqeLm3zPijhF
         mb40XErkCkx8a657/zpPt7xIE+/WVgRfNKkWYIzrCp2tFDP+3BInjM7+gEMEf76WZHqQ
         mWS1lNBj11tGTpzFwmXWxgQhpUHsgSF55YjnC64n3+0PHEFGUfjNmCIcTTGmKI9MGu2d
         kCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g/nm80+Ud0wRxvGfW3dlVEjR1+0DLL+VUhoF4LmgS+Q=;
        b=Kwgc8GZ7hsf/n7+cdjQCMOU1zHD8uR61d2SrppNnLAVIJ4p0JblIySgFkdsqN9p9P8
         BykQY4bsNaZMmQy7zsF8emCk0+5dQb368sO6PgRjhH645FKK3Q27p0UxaVS1/WlP4Q9C
         dDOmwkQXZMWj0v2veTnFJAcLnPqsomN01tom+NdJc5HR6u+WwlVNR+Zq5qwoYO5n9Jsm
         gvQSnhjhTVU4qwQZzg9WeQMsBwt1fKJsT27gic5OxW6F2exyYoFf77jOSbi13cvKQAbE
         lhwdjyk7yRx8sGDPlGY5jdPjZ0YpRoBeowHJKmPpdNbYQKRC3gVOViJUATPtoPP9MRN0
         oB6A==
X-Gm-Message-State: AOAM531SZOIi2wMrOmf/ujRnbh0mynDOdndWNH//Bb8TIxqoskEhz4pe
        h81FqFVIijMQopCNo0ggacvKsA==
X-Google-Smtp-Source: ABdhPJyrho8zIByNj5JL9HWW/xbMfB4xrHk9GWGi+3WSdBd2xnU203QhJSgXIPPx+itKthHZDwz+Yg==
X-Received: by 2002:a37:bec2:: with SMTP id o185mr13957738qkf.37.1601903584565;
        Mon, 05 Oct 2020 06:13:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p29sm7381872qtu.68.2020.10.05.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 06:13:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPQIY-007crb-Gz; Mon, 05 Oct 2020 10:13:02 -0300
Date:   Mon, 5 Oct 2020 10:13:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201005131302.GQ9916@ziepe.ca>
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
 <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 04, 2020 at 12:12:28PM -0700, Jianxin Xiong wrote:
> Dma-buf is a standard cross-driver buffer sharing mechanism that can be
> used to support peer-to-peer access from RDMA devices.
> 
> Device memory exported via dma-buf is associated with a file descriptor.
> This is passed to the user space as a property associated with the
> buffer allocation. When the buffer is registered as a memory region,
> the file descriptor is passed to the RDMA driver along with other
> parameters.
> 
> Implement the common code for importing dma-buf object and mapping
> dma-buf pages.
> 
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> ---
>  drivers/infiniband/core/Makefile      |   2 +-
>  drivers/infiniband/core/umem.c        |   4 +
>  drivers/infiniband/core/umem_dmabuf.c | 291 ++++++++++++++++++++++++++++++++++
>  drivers/infiniband/core/umem_dmabuf.h |  14 ++
>  drivers/infiniband/core/umem_odp.c    |  12 ++
>  include/rdma/ib_umem.h                |  19 ++-
>  6 files changed, 340 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/infiniband/core/umem_dmabuf.c
>  create mode 100644 drivers/infiniband/core/umem_dmabuf.h

I think this is using ODP too literally, dmabuf isn't going to need
fine grained page faults, and I'm not sure this locking scheme is OK -
ODP is horrifically complicated.

If this is the approach then I think we should make dmabuf its own
stand alone API, reg_user_mr_dmabuf()

The implementation in mlx5 will be much more understandable, it would
just do dma_buf_dynamic_attach() and program the XLT exactly the same
as a normal umem.

The move_notify() simply zap's the XLT and triggers a work to reload
it after the move. Locking is provided by the dma_resv_lock. Only a
small disruption to the page fault handler is needed.

> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +	sgt = dma_buf_map_attachment(umem_dmabuf->attach,
> +				     DMA_BIDIRECTIONAL);
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);

This doesn't look right, this lock has to be held up until the HW is
prorgammed

The use of atomic looks probably wrong as well.

> +	k = 0;
> +	total_pages = ib_umem_odp_num_pages(umem_odp);
> +	for_each_sg(umem->sg_head.sgl, sg, umem->sg_head.nents, j) {
> +		addr = sg_dma_address(sg);
> +		pages = sg_dma_len(sg) >> page_shift;
> +		while (pages > 0 && k < total_pages) {
> +			umem_odp->dma_list[k++] = addr | access_mask;
> +			umem_odp->npages++;
> +			addr += page_size;
> +			pages--;

This isn't fragmenting the sg into a page list properly, won't work
for unaligned things

And really we don't need the dma_list for this case, with a fixed
whole mapping DMA SGL a normal umem sgl is OK and the normal umem XLT
programming in mlx5 is fine.

Jason
