Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F16298CDA
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 13:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775095AbgJZM0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 08:26:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36514 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442309AbgJZM0m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 08:26:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id r7so8058578qkf.3
        for <linux-rdma@vger.kernel.org>; Mon, 26 Oct 2020 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sFAWCcExMHTOHRRV6PN8qO5lJJu/poaIEUM21VQxEeo=;
        b=ZpyWLyYtOxl9708I/3m316/fIsDBjoAhyxwdOJlxJsIQp89vrJ1psU80YjbboMJ7f+
         tjkXsGPp1n/tjrS7CO8YSh0BHMKyUL63RtYRbvtww00icDvInnKVld+7oqUZ9+TGlc6F
         fDw882W6OHcN4/prlG8d1si+B4vfUksndF/RKBd79O6i+A4Kk0TDArWp84D8tONbHwUO
         mjzsEQIK9YKqjijoHPI8dDym7XkPY3mjwJHpu56witca+ty26WsTaDlk50Tz3FaSzx+y
         iFM/9NSMb8xonezq2xpKJPKvrRGrNpyEg6Oc7kGTBlfyP5WaH+WvPUOYZYZL+VsZPtau
         HvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sFAWCcExMHTOHRRV6PN8qO5lJJu/poaIEUM21VQxEeo=;
        b=NjzxSghnlxzCCbHy/jNbgucEUT8MXs/XDLYy2T2CuaJIo5nnQmkqG231Ek2YxEIhye
         9PHfYKqC9ApuVbDFavNyIM4RMvpl0GkFOeambNG1TjfImV5/1qlVX7DY5s20U1urqPPK
         9DUdiuhsgZ7uw1mybgxUYGErcoTbrEe/P0Q6aB5aMaOdgSH8SUN5e4MArAuKgwhZsm0/
         NPOdr9/ApA1Vj1BsGFTjE91EKPHPkHd5veaj4McczZVrOqEI/wbt6TWNQxsVZQKIDdZ7
         Qo6Gj+dBzRcLC0p+KUX4yytpqCuHAinHmRLd+k22MamMLP6nwre7swxgEHI9vRq4YUL0
         OG7A==
X-Gm-Message-State: AOAM530fN2PgpfFEOjjSgc1Fim7TFBDBn3wrc7qZrq1MiwLv1GBdtAPN
        sUhePWow2P6FovLvzGBPyMCPnA==
X-Google-Smtp-Source: ABdhPJwVw9RhhXxLcuyakL72UDPW4hT0r1fAS1TYVYmudNNMnoyPoutHDAwVmODEJzlfT62CHDCqmw==
X-Received: by 2002:a05:620a:214b:: with SMTP id m11mr16914254qkm.6.1603715200851;
        Mon, 26 Oct 2020 05:26:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y125sm6145331qkb.114.2020.10.26.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:26:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kX1a9-007zcj-SH; Mon, 26 Oct 2020 09:26:37 -0300
Date:   Mon, 26 Oct 2020 09:26:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201026122637.GQ36674@ziepe.ca>
References: <1603471201-32588-1-git-send-email-jianxin.xiong@intel.com>
 <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
 <20201023164911.GF401619@phenom.ffwll.local>
 <20201023182005.GP36674@ziepe.ca>
 <20201024074807.GA3112@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024074807.GA3112@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 24, 2020 at 08:48:07AM +0100, Christoph Hellwig wrote:
> On Fri, Oct 23, 2020 at 03:20:05PM -0300, Jason Gunthorpe wrote:
> > The problem is we have RDMA drivers that assume SGL's have a valid
> > struct page, and these hacky/wrong P2P sgls that DMABUF creates cannot
> > be passed into those drivers.
> 
> RDMA drivers do not assume scatterlist have a valid struct page,
> scatterlists are defined to have a valid struct page.  Any scatterlist
> without a struct page is completely buggy.

It is not just having the struct page, it needs to be a CPU accessible
one for memcpy/etc. They aren't correct with the
MEMORY_DEVICE_PCI_P2PDMA SGLs either.

Jason
