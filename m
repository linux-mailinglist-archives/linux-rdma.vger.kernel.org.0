Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6051ADD57
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgDQMb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 08:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728071AbgDQMb1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 08:31:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19529C061A0C
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:31:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s30so1754108qth.2
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HMUofvPCsPY7hTCC6RIPzXSRLfhxf2L64il5kqnOl6U=;
        b=I4sRKIdJgJzEzgmo9IW+ekW44TyxfYcND7gQkH4nu808smmPXsF45o51nIo+H6Vs2W
         22mrAiWKT4SHeDWMtG5561T4KQlaAEDAtS1lATU5qsRvk2vAYxdbWMUv2HN+z5n52E7j
         8emk1cQp1Q4mjJF3eWEnlMTgo86HhhS5mRoeKyKVsc7ZeuN9sRTa3vFbjBsojarJPUj9
         kQT3Khxe1HrBddfq0mrebjed5FI5bvBT9M9m9OjIsavSx+BpW8NO84gUmCBNo3YFVsaU
         QCMRuw8CfzyMOtwUmMV0Ayz+IH5LziWEYPOddQ8II3i1kalfNTMaCF9Xpq2sOdbyr11D
         Ymzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HMUofvPCsPY7hTCC6RIPzXSRLfhxf2L64il5kqnOl6U=;
        b=ht1+gxVD0Of9M5KtFv+RLE4068CpiIBNOQtpySNK+NqZ7RSD79ND4BvIFL17lpqEro
         EdUGUq29rbzFoIaFw7hNyRVbD/nGz9L0MGa/mmwu4LjzBbSPSs73GWGM2S4M092ILyQX
         H4lkuHK1T81ad/mh9yR+Nm42QsHP1dEVhot2dQ+WZszzNreRqkF6V/UWmec8Iny5aTuV
         nLk+iDiihIPFAdv3bBP5s9aVDdfe8valVxqsvpVJzV+0vWXtuqjqyHAESMlZu/R/Z7Yz
         J1ARfIhAIwfyQmU1GS9YFXC7CjtimBZJOpjlBb10cOsqg/KIWgLMDX6APOPPEiIRPGzb
         NDug==
X-Gm-Message-State: AGi0PuZSEXCwrtGIRFa+RFqBtwbVb87j24Lh6nT51x5BQr0IEHiS9+hU
        SuLZHyBgDR/PeAfUGIjsNvp08A==
X-Google-Smtp-Source: APiQypLHRpSBi2AbPFZzgNKP0SqrmcU4tZd+JDxDFZJJ5DCYuw2u8Rohfbw7TlN31PeIhaLlJcJq0Q==
X-Received: by 2002:ac8:27a2:: with SMTP id w31mr493382qtw.318.1587126686260;
        Fri, 17 Apr 2020 05:31:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h23sm2188829qkk.90.2020.04.17.05.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 05:31:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPQ9U-0006me-OH; Fri, 17 Apr 2020 09:31:24 -0300
Date:   Fri, 17 Apr 2020 09:31:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20200417123124.GA26002@ziepe.ca>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
 <20200416180151.GU5100@ziepe.ca>
 <MW3PR11MB4555DDC186D6F5EF30771EB0E5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555DDC186D6F5EF30771EB0E5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 07:41:33PM +0000, Xiong, Jianxin wrote:
> > > +void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) {
> > > +	enum dma_data_direction dir;
> > > +
> > > +	dir = umem_dmabuf->umem.writable ? DMA_BIDIRECTIONAL :
> > > +DMA_FROM_DEVICE;
> > > +
> > > +	/*
> > > +	 * Only use the original sgt returned from dma_buf_map_attachment(),
> > > +	 * otherwise the scatterlist may be freed twice due to the map caching
> > > +	 * mechanism.
> > > +	 */
> > > +	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt, dir);
> > > +	dma_buf_detach(umem_dmabuf->dmabuf, umem_dmabuf->attach);
> > > +	dma_buf_put(umem_dmabuf->dmabuf);
> > > +	mmdrop(umem_dmabuf->umem.owning_mm);
> > > +	kfree(umem_dmabuf);
> > > +}
> > > +EXPORT_SYMBOL(ib_umem_dmabuf_release);
> > 
> > Why is this an EXPORT_SYMBOL?
> 
> It is called from ib_umem_release() which is in a different file.

export is only required to call outside the current module, which is
is not.

> > > diff --git a/include/rdma/ib_umem_dmabuf.h
> > > b/include/rdma/ib_umem_dmabuf.h new file mode 100644 index
> > > 0000000..e82b205
> > > +++ b/include/rdma/ib_umem_dmabuf.h
> > 
> > This should not be a public header
> 
> It's put there to be consistent with similar headers such as "ib_umem_odp.h". Can be changed.

ib_umem_odp is needed by drivers, this is not.

Jason
