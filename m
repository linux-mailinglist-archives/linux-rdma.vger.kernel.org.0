Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A302AD91D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 15:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbgKJOoM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Nov 2020 09:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgKJOoM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Nov 2020 09:44:12 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14869C0613CF
        for <linux-rdma@vger.kernel.org>; Tue, 10 Nov 2020 06:44:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p19so2159330wmg.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Nov 2020 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X4vUCbZyJ1/CJiuVNPzRZXx6UspNaZqxadNszyTjElM=;
        b=EKf0wqjhjoi8CDQBN/YapYVcD9ppM8MymSKwgFzwh+6C8G528otoa9GfWvPSa1VN+x
         ttzIUaZwKWq951JtrKF3g5hlKY4bYwQdIrh0rp9mmmNzCK1ulIOSNz1aQnzO1B9D55+z
         z5xjqgkdbXu1FxvK+92WZIPqE/6XO2jesgAG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X4vUCbZyJ1/CJiuVNPzRZXx6UspNaZqxadNszyTjElM=;
        b=cFEo1QsDSOsj8FYRwuzOO2MHmDWDavWlPRHdkEu1XITDe2ETA//qtoGdtQQj+nDbOs
         HVaZG0PJEneMJsssAFaDTG/9/Icmplm0uCCT/C7RF0yQXifmeq9maJmcKfhO8En+LWOf
         oHqdHyZaiUU3ux5Y1fz6S3LghDVtZfOOZ9db0yPhFMHCnxUTbQwA0a7lEyI3+XbADwt5
         n1B6iWBDInTiOi6PeBul1wlDU6GHDMyMe2AsVxdFz1yVdK1/y/pRsnbMrbpKwGh9ow2d
         wH2joQoWBLnXgnWNcJxhU8tlCsrmCEfEsVqbgxN9mM5+o5vjV3sjtvxw9CTL79ur48jV
         eesQ==
X-Gm-Message-State: AOAM533unL2hW6cEpH71ULEFla1NzT/XT8kJaaWFQiYZyLUFaMDJ9qZE
        Ssf7kOQpcISMIciNbpu/nwHC6w==
X-Google-Smtp-Source: ABdhPJzvA98qUEPUaJPVXtedEF5rKAoJOw1c/CBxkwRdVX+xWolXlj0cCNgVgBA+mX1/y3lk+tCuQA==
X-Received: by 2002:a7b:c845:: with SMTP id c5mr5087088wml.135.1605019449854;
        Tue, 10 Nov 2020 06:44:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v9sm17009623wrp.11.2020.11.10.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:44:09 -0800 (PST)
Date:   Tue, 10 Nov 2020 15:44:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v8 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201110144407.GM401619@phenom.ffwll.local>
References: <1604616489-69267-1-git-send-email-jianxin.xiong@intel.com>
 <1604616489-69267-2-git-send-email-jianxin.xiong@intel.com>
 <20201106000851.GK36674@ziepe.ca>
 <MW3PR11MB45552DC0851F4490B2450EDFE5ED0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20201106163953.GR36674@ziepe.ca>
 <20201110141445.GI401619@phenom.ffwll.local>
 <20201110142757.GM244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110142757.GM244516@ziepe.ca>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 10, 2020 at 10:27:57AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 10, 2020 at 03:14:45PM +0100, Daniel Vetter wrote:
> > On Fri, Nov 06, 2020 at 12:39:53PM -0400, Jason Gunthorpe wrote:
> > > On Fri, Nov 06, 2020 at 04:34:07PM +0000, Xiong, Jianxin wrote:
> > > 
> > > > > The user could specify a length that is beyond the dma buf, can
> > > > > the dma buf length be checked during get?
> > > > 
> > > > In order to check the length, the buffer needs to be mapped. That can be done.
> > > 
> > > Do DMA bufs even have definitate immutable lengths? Going to be a
> > > probelm if they can shrink
> > 
> > Yup. Unfortunately that's not document in the structures themselves,
> > there's just some random comments sprinkled all over that dma-buf size is
> > invariant, e.g. see the @mmap kerneldoc in dma_buf_ops:
> > 
> > https://dri.freedesktop.org/docs/drm/driver-api/dma-buf.html?highlight=dma_buf_ops#c.dma_buf_ops
> > 
> > "Because dma-buf buffers have invariant size over their lifetime, ..."
> > 
> > Jianxin, can you pls do a kerneldoc patch which updates the comment for
> > dma_buf.size and dma_buf_export_info.size?
> 
> So we can check the size without doing an attachment?

Yeah size should be invariant over the lifetime of the dma_buf (it's also
needed for dma_buf_vmap kernel cpu access and dma_buf_mmap userspace mmap
forwarding). No lock or attachment needed. But like I said, would be good
to have the kerneldoc patch to make this clear.

The history here is that the X shm extension suffered badly from
resizeable storage object exploits of the X server, this is why both
dma-buf (and also drm_gem_buffer_object before that generalization) and
memfd are size sealed.
-Daniel

> That means the flow should be put back to how it was a series or two
> ago where the SGL is only attached during page fault with the entire
> programming sequence under the resv lock
> 
> Jason

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
