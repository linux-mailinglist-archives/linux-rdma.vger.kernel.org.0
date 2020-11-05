Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4862A852D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgKERnK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:43:10 -0500
Received: from verein.lst.de ([213.95.11.211]:48089 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgKERnK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 12:43:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1A3E68B02; Thu,  5 Nov 2020 18:43:06 +0100 (CET)
Date:   Thu, 5 Nov 2020 18:43:06 +0100
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
Message-ID: <20201105174306.GA10757@lst.de>
References: <20201105074205.1690638-1-hch@lst.de> <20201105074205.1690638-5-hch@lst.de> <20201105143418.GA4142106@ziepe.ca> <20201105170816.GC7502@lst.de> <20201105172357.GE36674@ziepe.ca> <20201105172921.GA9537@lst.de> <20201105173930.GF36674@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105173930.GF36674@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 01:39:30PM -0400, Jason Gunthorpe wrote:
> Hmm. This works for real devices like mlx5, but it means the three SW
> devices will also resolve to a real PCI device that is not the DMA
> device.

Does it?  When I followed the links on my system rxe was a virtual
device without a physical parent.  Weird.
