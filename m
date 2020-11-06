Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1051C2A9667
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 13:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKFMsg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 07:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgKFMsg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 07:48:36 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0686C0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 04:48:35 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id h12so607596qtc.9
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 04:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dT/suzaNkB3c7S+yaEZ14QPSLd3HnsKmQIxsHBswjYA=;
        b=JQfd8wBzk3V/4qXEdChqsDgUtvZ9OKF+td8b1EK2NBfvWYsVkmasAbBjZntX0rqdM7
         kltSlTy7iYIKPt9IXRVkNOzCqztDLU3CCuod/463qdFzfh+B9ljPI0ygOB5fhiyEHM8I
         MKC8x+s3iSxQt/7BvRoL428wDYhJ0DwKlSkrpAbOCQrDhwVEz9g2i0PhsEWR6+YrPysA
         iTmcGO9vmhbxWYrm5owaMABbQAQDQcsu/dw2Gc9ZKXHlsSav2bubgXgmbCPe7DCa50ZI
         JY33QQaidF0F98ieqItIn7AvgmG/zwo8zOLCgaCbavga7Jxg2VzeZUdiZy2P7E6+vJiy
         uc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dT/suzaNkB3c7S+yaEZ14QPSLd3HnsKmQIxsHBswjYA=;
        b=ugLcUq4lHbyWwJ7+/Atf9z7S5JuLIuL5Lo7tX8YDjjKyJ49X4p8HpVo2Bf6WuGC8h4
         JeIrUVNGeJdH4+TaP4PYT7DeLKgla2AZ3S+hI6MJi8X36dzu4OiuELTVwiPGIsQ8fSzl
         Lt1oUxuwmlk3sMF9dEZuNIoVcu3VEm1qAX7NbjkOIoKGBzWKyBkN4pbAlrheT+GFEo+n
         dUCkkmrObjVKXUtm70JpqNQt2fPQOpW/1cH57cpyhsEa8XxuJM+6el0dY8/gnJBAN4/0
         jV+44QIZaDVk8bCzn9Jxpczk7Zf32Tde3uIgblmSze7cxfE2JlfugTUPx5mSZnWWiFFS
         BpPA==
X-Gm-Message-State: AOAM5336sj7Ek7PTM18sYHUwxum8tKBEgCO+qxjHn667cSzxVxWvnkia
        NxayHSb+5GQvrQgKxIdpFZzv4w==
X-Google-Smtp-Source: ABdhPJxdLSvL+7ucIJuva+yEGO+hLgE5wOg7ZB6/6wXGjHV/nF9UoGM01M2i1Of2FF8JKh/+nxYYaw==
X-Received: by 2002:ac8:7408:: with SMTP id p8mr1223264qtq.320.1604666915029;
        Fri, 06 Nov 2020 04:48:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x26sm402691qki.108.2020.11.06.04.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 04:48:34 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kb1AP-000lO1-8C; Fri, 06 Nov 2020 08:48:33 -0400
Date:   Fri, 6 Nov 2020 08:48:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH v8 4/5] RDMA/mlx5: Support dma-buf based userspace memory
 region
Message-ID: <20201106124833.GN36674@ziepe.ca>
References: <1604616489-69267-1-git-send-email-jianxin.xiong@intel.com>
 <1604616489-69267-5-git-send-email-jianxin.xiong@intel.com>
 <20201106002515.GM36674@ziepe.ca>
 <MW3PR11MB45556A1524ABE605698B9A8EE5ED0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45556A1524ABE605698B9A8EE5ED0@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 01:11:38AM +0000, Xiong, Jianxin wrote:
> > On Thu, Nov 05, 2020 at 02:48:08PM -0800, Jianxin Xiong wrote:
> > > @@ -966,7 +969,10 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
> > >  	struct mlx5_ib_mr *mr;
> > >  	unsigned int page_size;
> > >
> > > -	page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iova);
> > > +	if (umem->is_dmabuf)
> > > +		page_size = ib_umem_find_best_pgsz(umem, PAGE_SIZE, iova);
> > 
> > You said the sgl is not set here, why doesn't this crash? It is certainly wrong to call this function without a SGL.
> 
> The sgl is NULL, and nmap is 0. The 'for_each_sg' loop is just skipped and won't crash.

Just wire this to 4k it is clearer than calling some no-op pgsz


> > > +	if (!mr->cache_ent) {
> > > +		mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
> > > +		WARN_ON(mr->descs);
> > > +	}
> > > +}
> > 
> > I would expect this to call ib_umem_dmabuf_unmap_pages() ?
> > 
> > Who calls it on the dereg path?
> > 
> > This looks quite strange to me, it calls ib_umem_dmabuf_unmap_pages() only from the invalidate callback?
> 
> It is also called from ib_umem_dmabuf_release(). 

Hmm, that is no how the other APIs work, the unmap should be paired
with the map in the caller, and the sequence for destroy should be

 invalidate
 unmap
 destroy_mkey
 release_umem

I have another series coming that makes the other three destroy flows
much closer to that ideal.

> > I feel uneasy how this seems to assume everything works sanely, we can have parallel page faults so pagefault_dmabuf_mr() can be called
> > multiple times after an invalidation, and it doesn't protect itself against calling ib_umem_dmabuf_map_pages() twice.
> > 
> > Perhaps the umem code should keep track of the current map state and exit if there is already a sgl. NULL or not NULL sgl would do and
> > seems quite reasonable.
> 
> Ib_umem_dmabuf_map() already checks the sgl and will do nothing if it is already set.

How? What I see in patch 1 is an unconditonal call to
dma_buf_map_attachment() ?

> > > +		if (is_dmabuf_mr(mr))
> > > +			return pagefault_dmabuf_mr(mr, umem_dmabuf, user_va,
> > > +						   bcnt, bytes_mapped, flags);
> > 
> > But this doesn't care about user_va or bcnt it just triggers the whole thing to be remapped, so why calculate it?
> 
> The range check is still needed, in order to catch application
> errors of using incorrect address or count in verbs command. Passing
> the values further in is to allow pagefault_dmabuf_mr to generate
> return value and set bytes_mapped in a way consistent with the page
> fault handler chain.

The HW validates the range. The range check in the ODP case is to
protect against a HW bug that would cause the kernel to
malfunction. For dmabuf you don't need to do it

Jason
