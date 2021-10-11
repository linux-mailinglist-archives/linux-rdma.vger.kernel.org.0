Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBE04299D3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 01:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhJKXan (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Oct 2021 19:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhJKXam (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Oct 2021 19:30:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1EC061570
        for <linux-rdma@vger.kernel.org>; Mon, 11 Oct 2021 16:28:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z40so16515056qko.7
        for <linux-rdma@vger.kernel.org>; Mon, 11 Oct 2021 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hKTDl4kdaWB0vdYudkwpZowlFD1zaZpzSpL3qYnGjpI=;
        b=HgSVsa1leI1AlSIfToVWroe+BjAOI3ghwR21CHGPDVexnWIRNvq+Q6E9d3FU+ST+no
         ocS0/TW3SNZ8jyMLrwCJrPh0ePUJ+a688MNeO/SOH6dsbggdYjQGAUsJxiPe5U0kF/4c
         XY58+grwbQEppK31zpbsIZaW6qYJZ2vewp8ofGFLbXaclZQIMcZ93nEBHioo26AFAdN3
         o9ugEBJiQo11Zaj9DuRnUJDPPLYMfgS8KowTy+yVz6++iq5k4ln0p/MdXC+vaaQP/YGk
         4LaDhUUPgzqijbwXAaNpf83nIDlspt7EVCcaadtiRVk58NDA1pLNB31/ejPvhAokpOj1
         4Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKTDl4kdaWB0vdYudkwpZowlFD1zaZpzSpL3qYnGjpI=;
        b=NolLZ6XCqjUg+rKwKwUCfzUh3ofZkaLYBb9C4uUS0LSKqoDqQSF7ApcMJH9/ZoWj4I
         QJBLW9nTkcw5a+Na98K+ppX4MItyOUsYD2FLm6+9dHRz++HmPWtyIhjYbN0pFx4akv/j
         +56foUNi25J5WaAuYJDZLGs6gRiGIwYtY0ihsceISkK7gsepcpFFWRZram2pZW91tTJb
         4DFwpTQSRc4rjT/69wYWUxWXh+anuCS9OlaGH74AT7Vyi2QCqXcZAVwxHxw1CAiF48B/
         bcgngxaidDQwQNi0a2QtiBAqEwpwYEtsXdMxcmsQFWjEew3wuy3TB5PkwI9Np1puhvmw
         tbMw==
X-Gm-Message-State: AOAM5300bbVXnBYfFVhlqeDi0CS/HK2YMaJO0q3Xnzi8SukE7vvLIPgY
        /FToqUXLoFdAHLI7RevqFVD5FQ==
X-Google-Smtp-Source: ABdhPJztEyniOAoNC1NU3iq7Ij0MXitTU2tCF7xYZyS71yMXt88Vb38CmA4delGadNYZaeqqHQ8bqQ==
X-Received: by 2002:a37:f71a:: with SMTP id q26mr16843729qkj.3.1633994921355;
        Mon, 11 Oct 2021 16:28:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id d5sm5245821qtr.61.2021.10.11.16.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 16:28:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ma4il-00Dk4y-VJ; Mon, 11 Oct 2021 20:28:39 -0300
Date:   Mon, 11 Oct 2021 20:28:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Firas Jahjah <firasj@amazon.com>
Subject: Re: [RFC PATCH 2/2] RDMA/efa: Add support for dmabuf memory regions
Message-ID: <20211011232839.GF2688930@ziepe.ca>
References: <20211007104301.76693-1-galpress@amazon.com>
 <20211007104301.76693-3-galpress@amazon.com>
 <20211007114018.GD2688930@ziepe.ca>
 <77082c57-29f8-1eba-b260-7cb658ec34d1@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77082c57-29f8-1eba-b260-7cb658ec34d1@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 10, 2021 at 09:55:49AM +0300, Gal Pressman wrote:
> On 07/10/2021 14:40, Jason Gunthorpe wrote:
> > On Thu, Oct 07, 2021 at 01:43:00PM +0300, Gal Pressman wrote:
> > 
> >> @@ -1491,26 +1493,29 @@ static int efa_create_pbl(struct efa_dev *dev,
> >>  	return 0;
> >>  }
> >>  
> >> -struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
> >> -			 u64 virt_addr, int access_flags,
> >> -			 struct ib_udata *udata)
> >> +static void efa_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
> >> +{
> >> +	WARN_ON_ONCE(1,
> >> +		     "Invalidate callback should not be called when memory is pinned\n");
> >> +}
> >> +
> >> +static struct dma_buf_attach_ops efa_dmabuf_attach_ops = {
> >> +	.allow_peer2peer = true,
> >> +	.move_notify = efa_dmabuf_invalidate_cb,
> >> +};
> > 
> > Shouldn't move_notify really just be left as NULL? I mean fixing
> > whatever is preventing that?
> 
> That's what I had in the previous RFC and I think Christian didn't really like it.

Well, having drivers define a dummy function that only fails looks
a lot worse to me. If not null then it should be a general
'dmabuf_unsupported_move_notify' shared function

> >> +	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
> >> +	if (err) {
> >> +		ibdev_dbg(&dev->ibdev, "Failed to map dmabuf pages\n");
> >> +		goto err_unpin;
> >> +	}
> >> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> > 
> > If it is really this simple the core code should have this logic,
> > 'ib_umem_dmabuf_get_pinned()' or something
> 
> Should get_pinned do just get + dma_buf_pin, or should it do
> ib_umem_dmabuf_map_pages as well?

Yes the map_pages too, a umem is supposed to be dma mapped after
creation.

Jason
