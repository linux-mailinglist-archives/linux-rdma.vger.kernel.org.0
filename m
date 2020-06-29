Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2D920D2C8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgF2Sv6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbgF2Svy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Jun 2020 14:51:54 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4F2C031C40
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2020 11:51:55 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y2so18335636ioy.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2020 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CCIipEx24qQGQawiu9O28g+b/pGnrcz4jo+bEDeLSx0=;
        b=HEUh4Hn/lBp1dAbzazQ3lzJahX7uSM2zWL/uHaZLJdORUNyEzcvyTBijotu/L7WjDP
         PmDYFGD4ImtUwvBPAqCiK/j6e7BwbaDW9T0u+YSDigaUqEqj7og0VZXqyzdznblxQ8HR
         aZ477TcfRGdUgMcVZ2pjEeroN0egS9wVIm4N+4gN1wvQ83e9eVMLyPf0RSqeWQtIFHhi
         w66eu5XULPWzMuCwaWqS6WHnhQENwxevw99GQoqcfo4PHhMkvCpphtGhxCId6lVD2jTG
         Fdig/12nSg1NV41N87WTwtLG7kkcLrcOorE2qVz/R/DOxY4H2oi6Jp9ZEYDzRLia4ja2
         /9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CCIipEx24qQGQawiu9O28g+b/pGnrcz4jo+bEDeLSx0=;
        b=WwUk087/6ZwNzG8vjtGKLAEQ0bKGDVnGYyQcUlxtfOWwau6+MBgGnN2gYoKe1Lubo0
         XKWphgrEKVss2+5RcdvpZgNzaFN+P+0skmmkBu36Ju5v0FC2HqbNN/NSnJX9Ysb6ZC0b
         Wrjtv+1bswgAzQtSE2kK9p8RobZGJHcXIYFeHtV6zuCMh77ujBS3dZXooEjzFAZ+vQH4
         bEFooxDG9/UoKpGfoDQqvmOA48SiNcFi40ZHApmY9naPji+BIpvXZiBgTCrAvJWMMKPt
         vEaQiFWch5oxDA5kObwRApkXNCT+PIngh9OGRhou0SWLGoMzjYiqyUrLJzpZKhEb3FiP
         Ca4w==
X-Gm-Message-State: AOAM532WyCPRxmGt+9UqLj+3TBJXhE/irjuUDp6ZanDdXRCle/v1TfSk
        /9iiNS1yLp+CmKjTGTWjMqVYI/4j0GHBDQ==
X-Google-Smtp-Source: ABdhPJwxxsEVuMXUzFdkmZo9eQb/kPp4Meuup1+AAcsG6GxwoJadDMeVO0BKcGaMaxplqAj7VGjQbw==
X-Received: by 2002:a02:70d4:: with SMTP id f203mr19770290jac.74.1593456714392;
        Mon, 29 Jun 2020 11:51:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id o193sm378658ila.79.2020.06.29.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:51:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jpysi-001BIx-Im; Mon, 29 Jun 2020 15:51:52 -0300
Date:   Mon, 29 Jun 2020 15:51:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200629185152.GD25301@ziepe.ca>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 29, 2020 at 10:31:40AM -0700, Jianxin Xiong wrote:

> ZONE_DEVICE is a new zone for device memory in the memory management
> subsystem. It allows pages from device memory being described with
> specialized page structures. As the result, calls like get_user_pages()
> can succeed, but what can be done with these page structures may be

get_user_pages() does not succeed with ZONE_DEVICE_PAGEs

> Heterogeneous Memory Management (HMM) utilizes mmu_interval_notifier
> and ZONE_DEVICE to support shared virtual address space and page
> migration between system memory and device memory. HMM doesn't support
> pinning device memory because pages located on device must be able to
> migrate to system memory when accessed by CPU. Peer-to-peer access
> is possible if the peer can handle page fault. For RDMA, that means
> the NIC must support on-demand paging.

peer-peer access is currently not possible with hmm_range_fault().

> This patch series adds dma-buf importer role to the RDMA driver in
> attempt to support RDMA using device memory such as GPU VRAM. Dma-buf is
> chosen for a few reasons: first, the API is relatively simple and allows
> a lot of flexibility in implementing the buffer manipulation ops.
> Second, it doesn't require page structure. Third, dma-buf is already
> supported in many GPU drivers. However, we are aware that existing GPU
> drivers don't allow pinning device memory via the dma-buf interface.

So.. this patch doesn't really do anything new? We could just make a
MR against the DMA buf mmap and get to the same place?

> Pinning and mapping a dma-buf would cause the backing storage to migrate
> to system RAM. This is due to the lack of knowledge about whether the
> importer can perform peer-to-peer access and the lack of resource limit
> control measure for GPU. For the first part, the latest dma-buf driver
> has a peer-to-peer flag for the importer, but the flag is currently tied
> to dynamic mapping support, which requires on-demand paging support from
> the NIC to work.

ODP for DMA buf?

> There are a few possible ways to address these issues, such as
> decoupling peer-to-peer flag from dynamic mapping, allowing more
> leeway for individual drivers to make the pinning decision and
> adding GPU resource limit control via cgroup. We would like to get
> comments on this patch series with the assumption that device memory
> pinning via dma-buf is supported by some GPU drivers, and at the
> same time welcome open discussions on how to address the
> aforementioned issues as well as GPU-NIC peer-to-peer access
> solutions in general.

These seem like DMA buf problems, not RDMA problems, why are you
asking these questions with a RDMA patch set? The usual DMA buf people
are not even Cc'd here.

> This is the second version of the patch series. Here are the changes
> from the previous version:
> * Instead of adding new device method for dma-buf specific registration,
> existing method is extended to accept an extra parameter.

I think the comment was the extra parameter should have been a umem or
maybe a new umem_description struct, not blindly adding a fd as a
parameter and a wack of EOPNOTSUPPS

> This series is organized as follows. The first patch adds the common
> code for importing dma-buf from a file descriptor and pinning and
> mapping the dma-buf pages. Patch 2 extends the reg_user_mr() method
> of the ib_device structure to accept dma-buf file descriptor as an extra
> parameter. Vendor drivers are updated with the change. Patch 3 adds a
> new uverbs command for registering dma-buf based memory region.

The ioctl stuff seems OK, but this doesn't seem to bring any new
functionality?

Jason
