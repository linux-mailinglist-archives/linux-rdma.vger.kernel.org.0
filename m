Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B1B52438
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 09:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFYHS5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 03:18:57 -0400
Received: from verein.lst.de ([213.95.11.211]:60200 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfFYHS4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 03:18:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0E82368B02; Tue, 25 Jun 2019 09:18:24 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:18:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190625071823.GA30350@lst.de>
References: <20190620161240.22738-1-logang@deltatee.com> <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com> <20190620193353.GF19891@ziepe.ca> <20190624073126.GB3954@lst.de> <20190624134641.GA8268@ziepe.ca> <1041d2c6-f22c-81f2-c141-fb821b35c0c1@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041d2c6-f22c-81f2-c141-fb821b35c0c1@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 10:10:16AM -0600, Logan Gunthorpe wrote:
> Yes, that's correct. The intent was to invert it so the dma_map could
> happen at the start of the process so that P2PDMA code could be called
> with all the information it needs to make it's decision on how to map;
> without having to hook into the mapping process of every driver that
> wants to participate.

And that just isn't how things work in layering.  We need to keep
generating the dma addresses in the driver in the receiving end, as
there are all kinds of interesting ideas how we do that.  E.g. for the
Mellanox NICs addressing their own bars is not done by PCIe bus
addresses but by relative offsets.  And while NVMe has refused to go
down that route in the current band aid fix for CMB addressing I suspect
it will sooner or later have to do the same to deal with the addressing
problems in a multiple PASID world.
