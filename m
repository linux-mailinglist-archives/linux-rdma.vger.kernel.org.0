Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1AA374B0
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfFFM7i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 08:59:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38326 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfFFM7h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 08:59:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so2471877qtj.5
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pcms2hpiozX31D6cP+b+pcEmPCGLaGYLU1hDb/Ksv08=;
        b=MkdX75Ny9LXeEDd7M2ULnDHXydpfH/hamtC61IJll/djUvPjzu3CL4xNMlr5cz6Q5w
         guXxPdUF+9pLJqSbeFYaU0ImdK+8nAij30U0KPUu6/8BURnKFaQs0UmduUvDZSZvS3t9
         KBmMub0KUG4Vu/RcFYW7BchKnUQlRyD5eB/hRcBQ502FwMXpWw81+Pu+hLi173/AjDI5
         NP7He53xnoEtj8xoDotmmQb52tCLcvzr3zPzMDREz/bS8CoABsqvoL1RwTYigpnE7jWm
         Us4tLj2+XhGrNSs+5OFv+xlEHIunotlG5e2WVBNFLJZ98kl/iklZykxEmFHo7iATuPWe
         rK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pcms2hpiozX31D6cP+b+pcEmPCGLaGYLU1hDb/Ksv08=;
        b=NQA4Be6Oq5fJ6iQ9Zcod4W+u1Xh/OuhCUgVgWh8TeonLb2iQN6DHC/TUGfMoZ9++u9
         E7oppGd2A9B9d0w7YMalaqJGrDuFsNm+wPdGISu2z0XX7I7EqsYJswhvEDkLVJfM6sOm
         +LUPKQ3MHl0prQESLZE9/+bAxwfg2+qOJhhCTreye13+N/NNzr/A1wzWshI97T6au/jS
         Iz0Jns/NOD3zJq5h0F8VZ3sqNANMnvNzRJVyQOjunLGJZul5JnsaOUg1l8T0Wg6NIlbS
         nOWUf+EwoFQgsHq315h3gmiHFJIpUR7UwQqZiYo2FYXlKjm7NfbS9pcO4fsjPe0VBZrh
         UoEQ==
X-Gm-Message-State: APjAAAVMM1cIwZm22DrHYpneh1vKUsymjnlVa01m4L/EgNpiYmI62teE
        qX+b3/y8++Ckd0VM7/5xQJDhww==
X-Google-Smtp-Source: APXvYqyDJboU1GnyolHbPy9u8JPHRKlv/ujxxO2lQHi1JZVZmAE4fxPsnUgZOrHcZM/zPgtxL88Vqg==
X-Received: by 2002:ac8:7a87:: with SMTP id x7mr32060230qtr.215.1559825976661;
        Thu, 06 Jun 2019 05:59:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f67sm934787qtb.68.2019.06.06.05.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 05:59:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYrzT-00057B-B5; Thu, 06 Jun 2019 09:59:35 -0300
Date:   Thu, 6 Jun 2019 09:59:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] IB/iser: set virt_boundary_mask in the scsi host
Message-ID: <20190606125935.GA17373@ziepe.ca>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-9-hch@lst.de>
 <20190605202235.GC3273@ziepe.ca>
 <20190606062441.GB26745@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606062441.GB26745@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 08:24:41AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 05, 2019 at 05:22:35PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 05, 2019 at 09:08:31PM +0200, Christoph Hellwig wrote:
> > > This ensures all proper DMA layer handling is taken care of by the
> > > SCSI midlayer.
> > 
> > Maybe not entirely related to this series, but it looks like the SCSI
> > layer is changing the device global dma_set_max_seg_size() - at least
> > in RDMA the dma device is being shared between many users, so we
> > really don't want SCSI to make this value smaller.
> > 
> > Can we do something about this?
> 
> We could do something about it as outlined in my mail - pass the
> dma_params explicitly to the dma_map_sg call.  But that isn't really
> suitable for a short term fix and will take a little more time.

Sounds good to me, having every dma mapping specify its restrictions
makes a lot more sense than a device global setting, IMHO.

In RDMA the restrictions to build a SGL, create a device queue or
build a MR are all a little different.

ie for MRs alignment of the post-IOMMU DMA address is very important
for performance as the MR logic can only build device huge pages out
of properly aligned DMA addresses. While for SGLs we don't care about
this, instead SGLs usually have the 32 bit per-element length limit in
the HW that MRs do not.

> Until we've sorted that out the device paramter needs to be set to
> the smallest value supported.

smallest? largest? We've been setting it to the largest value the
device can handle (ie 2G)

Jason
