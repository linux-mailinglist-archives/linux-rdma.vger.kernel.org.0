Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78B2B065F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgKLNYB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 08:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgKLNXz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 08:23:55 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3836CC0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 05:23:55 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id u4so5125904qkk.10
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 05:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GgG+Zz++harjLdBXmMOeRXPhrbguvX47VfJimEaHELU=;
        b=JwWcwOy5hNV6Hs44MXlDrQMT9b8rvnkfLKT5x15JkGlQAL2D/g3vkEXmtuyY73EX6o
         0KEuYAaOT/zHSDTaNE7HmvJCG+FzAyx5YAhHwnfq5EOc4rgw+CffXgMVIFUESJNkl5os
         9HmCYfhwC758cBhubKJFWsIAWeEJMVzEWhyjhj/Ht0TTcziWf3PPh5fFBeEdnrX+hs+1
         XhbIXpcii4+DpBpk0gr5zFemIIzbRZ7tn5BuV/igI8xW0OJgEpL4cKXVyfBXb5JWlRaD
         5jHm2vhwGsyCuWRLmRZmCBXacFxtj+qlmsQ+TsjCcSKL8ngO+dHatJ0AU9/jCmaP5A6C
         9cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GgG+Zz++harjLdBXmMOeRXPhrbguvX47VfJimEaHELU=;
        b=m3vfk/fispcRvGlok9wNg5vkftyW2q4xViHt0s+Nk75MuKW+9B8aXYdWg2HcihS8w3
         uaNtsGM+m3ja2yKDLsFArGoT/h948eLTefTCiRKkhb9rN+c/AZmjOiZDcDstcmF6is07
         OseqGIweptLaXrjdoD0kh6Pb0EQSIrz5ts1TPUPUneGJEYfKUrhizJ6o6p96H84LUBC4
         20ULP9FPbE4X0xJKcFJRWbTn+VdsdKSgeohUWf8NmJrLcIOFSLLjtYvHoz5IvBA11fUJ
         na9q6DuRWXZ7op69V15v+Oyslsh2VOQub5Muqx8cqy3fyAXKN5uR/07UtHUikDfCsdht
         l6GA==
X-Gm-Message-State: AOAM532MeSNvn4jGQ1M96cUNefGfTUePYptHUQmdyVJV9r5/OTHEEIyM
        q5sH6DVIloSQaKIRt1d0aJiXqg==
X-Google-Smtp-Source: ABdhPJywkel8XB3mJwdENyyP8p0fxAGX2JW0meUrbieCppFxtts7eDEAYv3M6qnci9wS8irt7c69Bw==
X-Received: by 2002:a37:2c85:: with SMTP id s127mr30634838qkh.381.1605187434481;
        Thu, 12 Nov 2020 05:23:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j16sm4820609qkg.26.2020.11.12.05.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:23:53 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdCZt-003foe-6x; Thu, 12 Nov 2020 09:23:53 -0400
Date:   Thu, 12 Nov 2020 09:23:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: remove dma_virt_ops v2
Message-ID: <20201112132353.GQ244516@ziepe.ca>
References: <20201106181941.1878556-1-hch@lst.de>
 <20201112094030.GA19550@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112094030.GA19550@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 10:40:30AM +0100, Christoph Hellwig wrote:
> ping?
> 
> On Fri, Nov 06, 2020 at 07:19:31PM +0100, Christoph Hellwig wrote:
> > Hi Jason,
> > 
> > this series switches the RDMA core to opencode the special case of
> > devices bypassing the DMA mapping in the RDMA ULPs.  The virt ops
> > have caused a bit of trouble due to the P2P code node working with
> > them due to the fact that we'd do two dma mapping iterations for a
> > single I/O, but also are a bit of layering violation and lead to
> > more code than necessary.
> > 
> > Tested with nvme-rdma over rxe.
> > 
> > Note that the rds changes are untested, as I could not find any
> > simple rds test setup.
> > 
> > Changes since v2:
> >  - simplify the INFINIBAND_VIRT_DMA dependencies
> >  - add a ib_uses_virt_dma helper
> >  - use ib_uses_virt_dma in nvmet-rdma to disable p2p for virt_dma devices
> >  - use ib_dma_max_seg_size in umem
> >  - stop using dmapool in rds
> > 
> > Changes since v1:
> >  - disable software RDMA drivers for highmem configs
> >  - update the PCI commit logs

Santosh can you please check the RDA parts??

Jason
