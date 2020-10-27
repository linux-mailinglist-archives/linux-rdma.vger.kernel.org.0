Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9338629C940
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 20:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443681AbgJ0Tvm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 15:51:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38091 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411512AbgJ0Tvm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Oct 2020 15:51:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id j129so2427794qke.5
        for <linux-rdma@vger.kernel.org>; Tue, 27 Oct 2020 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tny+Go8Wlg2gBVQUisVFS/zNRhx6BeGWA7LrDqL6x2k=;
        b=ZzCQVs2cnQ3zSIELdpGRcFB5x/lUOzhctVtmCOMNH5B4ZbSqpAe1OmIL9qLoKdPC6s
         uZz5vfElPfOc2hKaE5pagJV5eYJeq7+QUXCNTdDD96AnAhr2DG0P9mzKD6BZelowxg6O
         aOKRwBDK7QW+UlCLyhsN1UEzdSKqYFrHzzS25CW9ZJ0VIEWgs+UZHBR5v3A6mTexzgV1
         T07EBp4zpXRbui0/w5QLhiKg/qyOdsT8YwiNzm4RBGTrwH3ovjTYHFjjx6M0j2uD/cs4
         a2wrVAOQdBuXjc1UGcN9SDwYwrXqCkMlFtz8928MBb4aUTGGxbb+COWj8kVkR1bl7sN7
         YSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tny+Go8Wlg2gBVQUisVFS/zNRhx6BeGWA7LrDqL6x2k=;
        b=Tg7mGrm5JFQnx/pAU0zVOu0+hxlP0acfpfsJL7SFEoz6jraDE0mUsOl2idI4u+ffpG
         i5zj1hSK6BEBgw/xFwIOjRD4mMTuM5VxFt4YCpIckkF/R5zv4MzPpSlLQm0PBznFo7lk
         1RB0jhmsBokjwpE5YtvMCMDMnRZm2Nm3+JtIYeG2LCHC7PXiGeWfj98vVNdhsoHBJgi/
         rBiJAjqhYvnX83izqWcLM331c+fhqFUN6TTnowGavSHPbQzgg/ZexPCpSK39O5Ut+Qc2
         Pa5K3Gea6EGA2eor4CsxXZg/GBxlpsgSwHwxpFG2fWcibPZdjVMpzAPMKijeuu9VT07o
         t+SA==
X-Gm-Message-State: AOAM533UvLx1EOKVLl3qxUBPDk8JizM4bM/LGhDfSys8ZdKX4QUsJVcE
        56hM9gtI83fmXLiciU0CT2x84A==
X-Google-Smtp-Source: ABdhPJyGHcDRkkajtNI9UZWjHFV5KNgtH9k54FQ77KgXBk8TbYuTisXXaKXk29QBcjrKDzRLrbteEA==
X-Received: by 2002:a37:e20d:: with SMTP id g13mr3839866qki.325.1603828300886;
        Tue, 27 Oct 2020 12:51:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a30sm1538970qtn.55.2020.10.27.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:51:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kXV0N-009f0s-6M; Tue, 27 Oct 2020 16:51:39 -0300
Date:   Tue, 27 Oct 2020 16:51:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201027195139.GV36674@ziepe.ca>
References: <1603471201-32588-1-git-send-email-jianxin.xiong@intel.com>
 <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
 <20201023164911.GF401619@phenom.ffwll.local>
 <20201023182005.GP36674@ziepe.ca>
 <20201024074807.GA3112@infradead.org>
 <20201026122637.GQ36674@ziepe.ca>
 <20201027080816.GA2692@infradead.org>
 <MW3PR11MB4555208D038CEFE6C468DAF5E5160@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555208D038CEFE6C468DAF5E5160@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 27, 2020 at 05:32:26PM +0000, Xiong, Jianxin wrote:
> > On Mon, Oct 26, 2020 at 09:26:37AM -0300, Jason Gunthorpe wrote:
> > > On Sat, Oct 24, 2020 at 08:48:07AM +0100, Christoph Hellwig wrote:
> > > > On Fri, Oct 23, 2020 at 03:20:05PM -0300, Jason Gunthorpe wrote:
> > > > > The problem is we have RDMA drivers that assume SGL's have a valid
> > > > > struct page, and these hacky/wrong P2P sgls that DMABUF creates
> > > > > cannot be passed into those drivers.
> > > >
> > > > RDMA drivers do not assume scatterlist have a valid struct page,
> > > > scatterlists are defined to have a valid struct page.  Any
> > > > scatterlist without a struct page is completely buggy.
> > >
> > > It is not just having the struct page, it needs to be a CPU accessible
> > > one for memcpy/etc. They aren't correct with the
> > > MEMORY_DEVICE_PCI_P2PDMA SGLs either.
> > 
> > Exactly.
> 
> In the function ib_umem_dmabuf_sgt_slice() (part of this patch) we could generate
> a dma address array instead of filling the scatterlist
> 'umem->sg_head'. 

I don't think we should change the format, the SGL comes out of the
dmabuf and all the umem code is able to process it like that. Adding
another datastructure just for this one case is going to be trouble.

Ultimately I'd like to see some 'dma only sgl', CH has been talking
about this for a while. When we have that settled just change
everything connected to umem

I think in the meantime the answer for this patch is drivers just
can't call these APIs and use the struct page side, just like they
can't call the DMA buf API and use the struct page side..

Jason
