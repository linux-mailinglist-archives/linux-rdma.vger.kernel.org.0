Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B092C2FFE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 19:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404197AbgKXSdu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 13:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbgKXSdt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Nov 2020 13:33:49 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56AC0613D6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 10:33:48 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id e60so7600333qtd.3
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 10:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=odsbBeKSImj9d1Vv8raolHLvpmJrGUmkgBM9p8FNK3Q=;
        b=eLNZNZCQTAwNvP7xEmrTUCN5f1NDlDsjafaUM/HJUMB6EjXbHZ+bA1SNfHOcw83nD9
         ydyiFsplhGd8UN+pgnqim7lF0p6YxMhutezg55zTYcmVER4aXpTDApV0zsQ06T62pwwC
         hyOIl3cegy4mKfbIKMa2SC/5g0HeRUiqVO6On6jHP9EZbAckGKCaOkpFDqnlppjuTG/O
         BD0sdqpHptRUeecGpLSB5G9gJb+nJ2yztm/Fhf54ou5nz3bGH7T5x0JsVFWhA8hnUaLg
         dtbDcbcj+b6AjiblM4cU3e10jV6xM6azX/DlLqbgQ7e+dSro0Q0rlmHosPjSIVASBhXs
         K/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=odsbBeKSImj9d1Vv8raolHLvpmJrGUmkgBM9p8FNK3Q=;
        b=R5q98w8+pW6zC2cEs7PZVDoZeme8Ltmn4tBeJWxkAY69W91nxtN6hg6CD/VOixvxFh
         199hMnaABYpKg8cxLFOqBBIQ9ogkaIc3o3BpYTW4GQDiySHEueJLWLSwSsxZ6CiRUCXp
         dzxR27tHFey6SMT9EYFN6ApFAcAp0W51F5ljiWZT4F/0BBhAtIpzIU7cMPM9raIg/uyS
         9HRb3UMNA7dPkSOEujeCynmUiBkKN+O0RiIfDXM+STqTMpRkw1fidwZRnXUDMFTWmcvc
         8nzGX2jtjY7Of1zMVFkhVpw+suF8Wh6fEyRj3JuX88UCX97iEd/nLv0B8Jc6jkq9lPuS
         /cDQ==
X-Gm-Message-State: AOAM530QGTjYkAuU1TIB1+ZfC53i4L2XDCp/zKmZxaDPduUbVvX3229k
        gq/bIL0cdleA/vWlfFQlV2DGBg==
X-Google-Smtp-Source: ABdhPJzRkSGH4VGPVgluncPI5g1/7rvX0PdC+isyGXnvguOnIEpGZFiUrpVdGdfAGhO/9EaeK4vWEQ==
X-Received: by 2002:ac8:34ea:: with SMTP id x39mr5691723qtb.26.1606242828227;
        Tue, 24 Nov 2020 10:33:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id i9sm13437558qtp.72.2020.11.24.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:33:47 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khd8M-000tkv-TT; Tue, 24 Nov 2020 14:33:46 -0400
Date:   Tue, 24 Nov 2020 14:33:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH v11 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201124183346.GK5487@ziepe.ca>
References: <1606153919-104513-1-git-send-email-jianxin.xiong@intel.com>
 <1606153919-104513-2-git-send-email-jianxin.xiong@intel.com>
 <20201124093352.GB29715@infradead.org>
 <MW3PR11MB4555410B8487CA3B6627E463E5FB0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555410B8487CA3B6627E463E5FB0@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 06:24:43PM +0000, Xiong, Jianxin wrote:
> > From: Christoph Hellwig <hch@infradead.org>
> > Sent: Tuesday, November 24, 2020 1:34 AM
> > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>;
> > Leon Romanovsky <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koenig <christian.koenig@amd.com>; Vetter,
> > Daniel <daniel.vetter@intel.com>
> > Subject: Re: [PATCH v11 1/4] RDMA/umem: Support importing dma-buf as user memory region
> > 
> > As these are mostly trivial wrappers around the EXPORT_SYMBOL_GPL dmabuf exports please stick to that export style.
> > 
> > > +++ b/drivers/infiniband/core/umem_dmabuf.h
> > > @@ -0,0 +1,11 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> > > +/*
> > > + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> > > + */
> > > +
> > > +#ifndef UMEM_DMABUF_H
> > > +#define UMEM_DMABUF_H
> > > +
> > > +void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
> > > +
> > > +#endif /* UMEM_DMABUF_H */
> > 
> > Does this really need a separate header?
> 
> The symbol doesn't need to be exported otherwise it can be put into "ib_umem.h".
> Although the prototype could be put into the file where it is called directly, using a
> separate header file provides a cleaner interface.

It is fine to put this single symbol in ib_umem.h

Thanks
Jason
