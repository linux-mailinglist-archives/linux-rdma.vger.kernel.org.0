Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF885B94
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 09:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfHHH3x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 03:29:53 -0400
Received: from verein.lst.de ([213.95.11.211]:43992 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731226AbfHHH3w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 03:29:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD4D468B02; Thu,  8 Aug 2019 09:29:47 +0200 (CEST)
Date:   Thu, 8 Aug 2019 09:29:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>
Subject: Re: [PATCH v2 13/14] PCI/P2PDMA: No longer require no-mmu for host
 bridge whitelist
Message-ID: <20190808072947.GB29852@lst.de>
References: <20190730163545.4915-1-logang@deltatee.com> <20190730163545.4915-14-logang@deltatee.com> <20190807055958.GC6627@lst.de> <20190807124259.GX151852@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807124259.GX151852@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 07:43:01AM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 07, 2019 at 07:59:58AM +0200, Christoph Hellwig wrote:
> > no-mmu sounds stange, as we use that for linux ports without paging
> > hardware.  I think an "io" got lost somewhere..
> 
> I had already changed the subject to
> 
>   PCI/P2PDMA: Allow IOMMU for host bridge whitelist
> 
> but certainly open to better suggestions.

Maybe:

PCI/P2PDMA: Allow P2P transfers behind IOMMUs

?
