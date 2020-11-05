Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E432A851A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgKERjd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKERjc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 12:39:32 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40298C0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 09:39:32 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id i17so1073817qvp.11
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 09:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ubXxQSNX1b1oqxlICbUVJ8ka1QZRYtb9rgzYhqrREuI=;
        b=E++HclqmQVeK92papBPF4aIcnXcN7nQrgTwqb5TYWE+kVi3biy3Pr+xFPeoPzc+vkl
         haPfPdFVl3+6NE0S+pEPlGv0uynG18Tq/AoX78TJYIaICvZbDLZYASeMow80Cb0EMtO9
         82fxXgUS8G++0gS1rZwPFffiaxeqNtL36E1CUZYQTgo/e6WLkqNBShxnWmJfup4jkyqp
         /PcgP3Xwu+p8jV0wiO3SiGzvGP1aDHvi1kbSjEWmk5R31h7Jm3q3p9XYedzANbb83h/M
         tOeaaAAkWZ2HusMuRnBgLCI2OHIO+cdzQBpr293za1JoX5HlMfar+r9LU2MN31PG0H0i
         lZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ubXxQSNX1b1oqxlICbUVJ8ka1QZRYtb9rgzYhqrREuI=;
        b=JGu39iydz0OQWgpJWkkAwtXJC7YMZK9kkJcRL9ChSv5+nDWmewNtqaLfOaeKMWbD21
         AKLdISkrAUzJ+LWrAV80wP2pmkfE/vAE1hk7wmbol4YPW7Mxk0SuyGbhEVFPdSSPd6QB
         MOKm6kYyw64E2N2DZsIA5w1vITikCAi62hxW63Eg8I+pAOwNnV25aeGkJ+NooCOeoImN
         Rn4zqEVkd34JB95Q2lOK1NsYTqzSgmuNzW9w5eceJTqn39kCNV6eYNCtL06VguVFQ8Ex
         iYOEwxCovMjBK6xgLLNuXv2c29kURaHAlV5BXHAWpq4agFMdCI6TfgexkCW5wj2QN81Z
         CnbA==
X-Gm-Message-State: AOAM531CnwZybjwYE3Lac6tRGGd6py7m+4I/k7z+T+LiDGXI0qm2nODt
        UjIYK9f/sYb25nzpuDmFyT/6Lg==
X-Google-Smtp-Source: ABdhPJx+0vEjrI7P8UuwVjg1neN0lTplv9fazt5XCR/ixwReG/F1831L+mIEo9skzDNwWI1oj7cgeA==
X-Received: by 2002:a05:6214:1188:: with SMTP id t8mr3117414qvv.18.1604597971538;
        Thu, 05 Nov 2020 09:39:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j5sm1298744qtv.91.2020.11.05.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:39:30 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kajEQ-0008oJ-B8; Thu, 05 Nov 2020 13:39:30 -0400
Date:   Thu, 5 Nov 2020 13:39:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 4/6] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Message-ID: <20201105173930.GF36674@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-5-hch@lst.de>
 <20201105143418.GA4142106@ziepe.ca>
 <20201105170816.GC7502@lst.de>
 <20201105172357.GE36674@ziepe.ca>
 <20201105172921.GA9537@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105172921.GA9537@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 06:29:21PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 05, 2020 at 01:23:57PM -0400, Jason Gunthorpe wrote:
> > But that depends on the calling driver doing this properly, and we
> > don't expose an API to get the PCI device of the struct ib_device
> > .. how does nvme even work here?
> 
> The PCI p2pdma APIs walk the parent chains of a struct device until
> they find a PCI device.  And the ib_device eventually ends up there.

Hmm. This works for real devices like mlx5, but it means the three SW
devices will also resolve to a real PCI device that is not the DMA
device.

If nvme wants to do something like this it should walk from the
ibdev->dma_device, after these patches to make dma_device NULL.

eg rxe is like:

$ sudo rdma link add rxe0 type rxe netdev eth1

lrwxrwxrwx 1 root root 0 Nov  5 17:34 /sys/class/infiniband/rxe0/device -> ../../../0000:00:09.0/

I think this is a bug, these virtual devices should have NULL
parents...

> > If we can't get here then why did you add the check to the unmap side?
> 
> Because I added them to the map and unmap side, but forgot to commit
> the map side.  Mostly to be prepared for the case where we could
> end up there.  And thinking out loud I actually need to double check
> rdmavt if that is true there as well.  It certainly is for rxe and
> siw as I checked it on a live system.

rdmavt parents itself to the HFI/QIB PCI device, so the walk above
should also find a real PCI device

> > The SW drivers can't handle PCI pages at all, they are going to try to
> > memcpy them or something else not __iomem, so we really do need to
> > prevent P2P pages going into them.
> 
> Ok, let's prevent it for now.  And if someone wants to do it there
> they have to do all the work.

Yes, that is the safest - just block the SW devices from ever touch
P2P pages.

Jason
