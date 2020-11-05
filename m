Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AEE2A84E4
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKER30 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:29:26 -0500
Received: from verein.lst.de ([213.95.11.211]:48041 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKER30 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 12:29:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7E4D68C4E; Thu,  5 Nov 2020 18:29:21 +0100 (CET)
Date:   Thu, 5 Nov 2020 18:29:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 4/6] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Message-ID: <20201105172921.GA9537@lst.de>
References: <20201105074205.1690638-1-hch@lst.de> <20201105074205.1690638-5-hch@lst.de> <20201105143418.GA4142106@ziepe.ca> <20201105170816.GC7502@lst.de> <20201105172357.GE36674@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105172357.GE36674@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 01:23:57PM -0400, Jason Gunthorpe wrote:
> But that depends on the calling driver doing this properly, and we
> don't expose an API to get the PCI device of the struct ib_device
> .. how does nvme even work here?

The PCI p2pdma APIs walk the parent chains of a struct device until
they find a PCI device.  And the ib_device eventually ends up there.

> 
> If we can't get here then why did you add the check to the unmap side?

Because I added them to the map and unmap side, but forgot to commit
the map side.  Mostly to be prepared for the case where we could
end up there.  And thinking out loud I actually need to double check
rdmavt if that is true there as well.  It certainly is for rxe and
siw as I checked it on a live system.

> The SW drivers can't handle PCI pages at all, they are going to try to
> memcpy them or something else not __iomem, so we really do need to
> prevent P2P pages going into them.

Ok, let's prevent it for now.  And if someone wants to do it there
they have to do all the work.
