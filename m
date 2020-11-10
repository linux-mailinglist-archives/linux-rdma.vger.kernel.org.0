Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64C82AD872
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 15:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgKJOOv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 09:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbgKJOOv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Nov 2020 09:14:51 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC035C0613D1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Nov 2020 06:14:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r17so8907915wrw.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Nov 2020 06:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8IcGGTKYyeJzANG/fH/4OAuqD6l1LU2uOKX7qMbCBZA=;
        b=ZMmpCnGxT6S84bDoG46UlaLwRiQ1gDDBqsmHOxrOomO6S/WC7lm/CkFL6l/jEbG2VE
         0uUNIVSRlyWZIH0XvjuiIhJ7/nyKnTlTHlAbcHB+4tEtMHyv7xEGekHYi1h6UjxMtfaz
         jxmFK8Yd9UF4q17j06Fs+WDiJwzyKTx95pXes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8IcGGTKYyeJzANG/fH/4OAuqD6l1LU2uOKX7qMbCBZA=;
        b=RGzKOzzH/bqMLLpRd8knTUB8/Oi0Ye79O0f/hmArEn73DpIhSMcW+KVXhrLUYwnUqt
         969gNQSMZCONqN2XjeiKRix8eOFtp4VAn805pNEiGa20RdgtU/YuQpl/ZPVSJPoeDzkz
         cGb6g5AiJoDOcNAcx3SYIW9edfSSISHb5acocaUeEJ5QAsU71D7nBGkSsU3a3SbOyTSD
         5GJTznqIBvLqQaTP+InhHsPlJVjfufuICOzNcG0PpmurceesB16STO5ygNI48mparPCj
         CDkjwdw0/ZOqBbHBH1nL/8sUCV6wB/pjTRQ/kjamIzk2zHJ+Z9dD68raDNqmexhO/PUK
         jRfQ==
X-Gm-Message-State: AOAM533vFHibIn+b1bqSKDsr0W39imE6kY3myDFITHDUHdVpYKw0Wb7j
        yJ4DKlVbl/y2n00iUXDkrRMocw==
X-Google-Smtp-Source: ABdhPJzG/UIF3dNTtGW7tPhr4EP9TwE3B/cEGkHpgw4VNMo89aauYpYSkqO0ZWw2XriDN6QoBX/YVQ==
X-Received: by 2002:a5d:6046:: with SMTP id j6mr24473612wrt.317.1605017688496;
        Tue, 10 Nov 2020 06:14:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a128sm3232055wmf.5.2020.11.10.06.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:14:47 -0800 (PST)
Date:   Tue, 10 Nov 2020 15:14:45 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v8 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201110141445.GI401619@phenom.ffwll.local>
References: <1604616489-69267-1-git-send-email-jianxin.xiong@intel.com>
 <1604616489-69267-2-git-send-email-jianxin.xiong@intel.com>
 <20201106000851.GK36674@ziepe.ca>
 <MW3PR11MB45552DC0851F4490B2450EDFE5ED0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20201106163953.GR36674@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106163953.GR36674@ziepe.ca>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 12:39:53PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 04:34:07PM +0000, Xiong, Jianxin wrote:
> 
> > > The user could specify a length that is beyond the dma buf, can
> > > the dma buf length be checked during get?
> > 
> > In order to check the length, the buffer needs to be mapped. That can be done.
> 
> Do DMA bufs even have definitate immutable lengths? Going to be a
> probelm if they can shrink

Yup. Unfortunately that's not document in the structures themselves,
there's just some random comments sprinkled all over that dma-buf size is
invariant, e.g. see the @mmap kerneldoc in dma_buf_ops:

https://dri.freedesktop.org/docs/drm/driver-api/dma-buf.html?highlight=dma_buf_ops#c.dma_buf_ops

"Because dma-buf buffers have invariant size over their lifetime, ..."

Jianxin, can you pls do a kerneldoc patch which updates the comment for
dma_buf.size and dma_buf_export_info.size?

Thanks, Daniel

> 
> > > Also page_size can be 0 because iova is not OK. iova should be
> > > checked for alignment during get as well:
> > > 
> > >   iova & (PAGE_SIZE-1) == umem->addr & (PAGE_SIZE-1)
> > 
> > If ib_umem_dmabuf_map_pages is called during get this error is automatically caught.
> 
> The ib_umem_find_best_pgsz() checks this equation, yes.
> 
> So you'd map the sgl before allocating the mkey? This then checks the
> length and iova?
> 
> Jason
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
