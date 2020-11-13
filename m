Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F412B1B51
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 13:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKMMtK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 07:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgKMMtJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 07:49:09 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8589C0613D1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Nov 2020 04:49:09 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id g19so4495754qvy.2
        for <linux-rdma@vger.kernel.org>; Fri, 13 Nov 2020 04:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RcvJ0ZjeSv/YgPQ0Qoap3goR6x+DGLtXOMsSJfrBjSk=;
        b=oQ2LazpMrvjAQvcBZ9lE0E4g7PuQt+LQvg0yLMauHeuqSBAhJJCcP7ZyvGsFLxjQ64
         IpjAuezncv+uVVvPG57vG5ST+ZLoLQKA2cYObEzfME5bQqWsie/91wjK1jBU2ygh+GNR
         3q6yYFAC2NkspnFZi0/jzc+/HRnOLj1hwIUxpR62OdJJDpOBjRE3AUO3vJdkf6LHtkBQ
         aPWk6DxQhJKLNvbDMOuVC73cpB89RfKQVcT2VIa8POExfzWPctvgGNr8jAQH6ephc2O+
         oLSJmnsP6WSmg39cRR6U8PEN0+8pjnDSAb4qsm93v3T7ysMxhAkqauP0yWCYoWXF3dlb
         8+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RcvJ0ZjeSv/YgPQ0Qoap3goR6x+DGLtXOMsSJfrBjSk=;
        b=kPcl+5e7rm5fDSHHHwmnSJk7UZiTDcmM0OT5cjyHD5poRGm4yFQ8jK74UKTpNH2Z6+
         JpE4i7Pc7SM1clXzoD8xVkaL4tNVgFyLfbcDDkxjTT+UPeLJp9fJS2sYVYDWAAXE35RM
         xqGZMApwzkRY7nDcwoqGiimjlVsK427A/A6qXQui2HDjJL9hNomNv73YpSa7ouuIP72a
         ar+jtmzRW3aeE0ux6HgNak8V/QEtiX/Hl3yTrKG5xGrNr4LWbkACWSLWTZopjUeHMlmT
         Q1wSByFZr2ncM3KQ4uW6QfZKmvtr1jwWwf5pyeobuydzzkcwbxReO382D9OkCW9w3eXB
         J2qg==
X-Gm-Message-State: AOAM531JY/fP0Iprbl+saEw/VXWJ6bUjGoIzQ4ahGSzbg2cfch2z+uUE
        edtqBK72zZzDfj6V/uFmyxpm0Q==
X-Google-Smtp-Source: ABdhPJwIF8ycppZSd+rISqHYM9BvW9DZmk6aIDyfXSgiNUIrCa8Gmbax0jo6QmVC6Wi7QqOX+U1DaQ==
X-Received: by 2002:a0c:ecc1:: with SMTP id o1mr2010711qvq.6.1605271748507;
        Fri, 13 Nov 2020 04:49:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s134sm6952212qke.99.2020.11.13.04.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:49:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdYVm-004PIv-Vu; Fri, 13 Nov 2020 08:49:07 -0400
Date:   Fri, 13 Nov 2020 08:49:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH v10 1/6] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201113124906.GC244516@ziepe.ca>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
 <1605044477-51833-2-git-send-email-jianxin.xiong@intel.com>
 <20201113003037.GY244516@ziepe.ca>
 <MW3PR11MB45558223F95CCE4ABF57B9BCE5E60@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45558223F95CCE4ABF57B9BCE5E60@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 13, 2020 at 03:30:04AM +0000, Xiong, Jianxin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, November 12, 2020 4:31 PM
> > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> > <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koenig <christian.koenig@amd.com>; Vetter, Daniel
> > <daniel.vetter@intel.com>
> > Subject: Re: [PATCH v10 1/6] RDMA/umem: Support importing dma-buf as user memory region
> > 
> > On Tue, Nov 10, 2020 at 01:41:12PM -0800, Jianxin Xiong wrote:
> > > +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> > > +				   unsigned long offset, size_t size,
> > > +				   int fd, int access,
> > > +				   const struct dma_buf_attach_ops *ops) {
> > > +	struct dma_buf *dmabuf;
> > > +	struct ib_umem_dmabuf *umem_dmabuf;
> > > +	struct ib_umem *umem;
> > > +	unsigned long end;
> > > +	long ret;
> > > +
> > > +	if (check_add_overflow(offset, (unsigned long)size, &end))
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	if (unlikely(PAGE_ALIGN(end) < PAGE_SIZE))
> > > +		return ERR_PTR(-EINVAL);
> > 
> > This is weird, what does it do?
> 
> This sequence is modeled after the following code from ib_umem_init_odp():
> 
>                 if (check_add_overflow(umem_odp->umem.address,
>                                        (unsigned long)umem_odp->umem.length,
>                                        &end))
>                         return -EOVERFLOW;
>                 end = ALIGN(end, page_size);
>                 if (unlikely(end < page_size))
>                         return -EOVERFLOW;
> 
> The weird part seems to be checking if 'end' is 0, but that should have been covered
> by check_add_overflow() already.

I think the
 +	if (unlikely(!ib_umem_num_pages(umem))) {

Catches the same condition, no need to do it twice

Jason
