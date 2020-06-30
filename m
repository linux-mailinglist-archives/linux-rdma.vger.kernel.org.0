Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70E720FAA3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgF3Rei (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 13:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgF3Rei (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jun 2020 13:34:38 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B8C061755
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2020 10:34:37 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e18so7796172ilr.7
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2020 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gL8EyU9UQnezCYstU0/XScATbm4WCiRKQBl+0jLmsH4=;
        b=lvKR7J55s3TIK2bfiJvXktOD2cH5uoxL/C3qQ6sN9HXyn81R/zvil0/Qxwp4x6MzvC
         8xSmVjZKvQboMIxjBnNrz9NmjftcYf4Rc9HHMtbwhS9b3lTdvdt8Q0xJGFesFOu20pda
         thYPTQ2ZU27NdB04Lz4OZXNFhXBABuP46PgyR01yKuAw/5tQO96YaeTDgQHFy1OqI3Dv
         aeAhaZbcoMqPtl6Z41tHI8uqVCYhZYzb8tcMn310P3NaW0nr43kBr+MErbLeQYRnq79n
         KE66YKlIQ7+tqPIY+VBiknFfYI67pgpKNwSN1xYWsxXpaDnZMNMz8QcEmU6Ss4KeyWDD
         hBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gL8EyU9UQnezCYstU0/XScATbm4WCiRKQBl+0jLmsH4=;
        b=nnCUNtp6RCoGe+gQ4hlgMxeeUTHdErivI2PXvC/DGOt6ctq2/DZmQmWb+aPXRLOnSe
         JtmUruSM+tql2Hhh8aiv0PZzCo6LLEJkS9xBXoZm2xnjZDakWWqY6llUZRARptrm4wmu
         A2tNHSLkps1PydcB6BfkBWd/9vVcN5asyOJaZrR1TbiNouA0KLXxFP4tM6Ku6t411XyN
         3c9d/SQJ43tCtG6wo8+eqBK+SoPlrZuVwOYwv7QYKII/QriIqZpvhR3jOlhnyftw6en6
         ODeG2y7+gBAAaCh9W2rf+XIBFXmVGZ0FexJAkvnDh3CAnRN/0MvZqUTuRUX2lzxzj8Vc
         yusQ==
X-Gm-Message-State: AOAM530YPKMeR/xBNQ6HCQ40w0fPiVhwEWKWJvn61yrsT4EApMJNSiZz
        Zd4txZ/j4H9ygGtzLDybSWzdrg==
X-Google-Smtp-Source: ABdhPJz5Hr5g3EnLwk/E4ksVpppNsJbCj9ndjvy8jygJo3RI2iUOzJyPNOp1Ej52zqExFLvbb/xb8w==
X-Received: by 2002:a05:6e02:606:: with SMTP id t6mr3659189ils.181.1593538477075;
        Tue, 30 Jun 2020 10:34:37 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id a10sm1934607iln.20.2020.06.30.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:34:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jqK9T-001vwy-CD; Tue, 30 Jun 2020 14:34:35 -0300
Date:   Tue, 30 Jun 2020 14:34:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200630173435.GK25301@ziepe.ca>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca>
 <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 05:21:33PM +0000, Xiong, Jianxin wrote:
> > > Heterogeneous Memory Management (HMM) utilizes mmu_interval_notifier
> > > and ZONE_DEVICE to support shared virtual address space and page
> > > migration between system memory and device memory. HMM doesn't support
> > > pinning device memory because pages located on device must be able to
> > > migrate to system memory when accessed by CPU. Peer-to-peer access is
> > > possible if the peer can handle page fault. For RDMA, that means the
> > > NIC must support on-demand paging.
> > 
> > peer-peer access is currently not possible with hmm_range_fault().
> 
> Currently hmm_range_fault() always sets the cpu access flag and device
> private pages are migrated to the system RAM in the fault handler. However, 
> it's possible to have a modified code flow to keep the device private page info
> for use with peer to peer access.

Sort of, but only within the same device, RDMA or anything else
generic can't reach inside a DEVICE_PRIVATE and extract anything
useful.

> > So.. this patch doesn't really do anything new? We could just make a MR against the DMA buf mmap and get to the same place?
> 
> That's right, the patch alone is just half of the story. The functionality
> depends on availability of dma-buf exporter that can pin the device
> memory.

Well, what do you want to happen here? The RDMA parts are reasonable,
but I don't want to add new functionality without a purpose - the
other parts need to be settled out first.

The need for the dynamic mapping support for even the current DMA Buf
hacky P2P users is really too bad. Can you get any GPU driver to
support non-dynamic mapping?

> > > migrate to system RAM. This is due to the lack of knowledge about
> > > whether the importer can perform peer-to-peer access and the lack of
> > > resource limit control measure for GPU. For the first part, the latest
> > > dma-buf driver has a peer-to-peer flag for the importer, but the flag
> > > is currently tied to dynamic mapping support, which requires on-demand
> > > paging support from the NIC to work.
> > 
> > ODP for DMA buf?
> 
> Right.

Hum. This is not actually so hard to do. The whole dma buf proposal
would make a lot more sense if the 'dma buf MR' had to be the dynamic
kind and the driver had to provide the faulting. It would not be so
hard to change mlx5 to be able to work like this, perhaps. (the
locking might be a bit tricky though)

> > > There are a few possible ways to address these issues, such as
> > > decoupling peer-to-peer flag from dynamic mapping, allowing more
> > > leeway for individual drivers to make the pinning decision and adding
> > > GPU resource limit control via cgroup. We would like to get comments
> > > on this patch series with the assumption that device memory pinning
> > > via dma-buf is supported by some GPU drivers, and at the same time
> > > welcome open discussions on how to address the aforementioned issues
> > > as well as GPU-NIC peer-to-peer access solutions in general.
> > 
> > These seem like DMA buf problems, not RDMA problems, why are you asking these questions with a RDMA patch set? The usual DMA buf
> > people are not even Cc'd here.
> 
> The intention is to have people from both RDMA and DMA buffer side to
> comment. Sumit Semwal is the DMA buffer maintainer according to the
> MAINTAINERS file. I agree more people could be invited to the discussion.
> Just added Christian Koenig to the cc-list.

Would be good to have added the drm lists too

> If the umem_description you mentioned is for information used to create the
> umem (e.g. a structure for all the parameters), then this would work better.

It would make some more sense, and avoid all these weird EOPNOTSUPPS.

Jason
