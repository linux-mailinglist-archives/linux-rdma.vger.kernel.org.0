Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D949C74D87
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 13:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGYLul (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 07:50:41 -0400
Received: from verein.lst.de ([213.95.11.211]:60849 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfGYLul (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 07:50:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3990468BFE; Thu, 25 Jul 2019 13:50:40 +0200 (CEST)
Date:   Thu, 25 Jul 2019 13:50:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 14/14] PCI/P2PDMA: Introduce
 pci_p2pdma_[un]map_resource()
Message-ID: <20190725115038.GC31065@lst.de>
References: <20190722230859.5436-1-logang@deltatee.com> <20190722230859.5436-15-logang@deltatee.com> <20190724063235.GC1804@lst.de> <57e8fc1a-de70-fb65-5ef1-ffa2b95c73a6@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e8fc1a-de70-fb65-5ef1-ffa2b95c73a6@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 24, 2019 at 10:06:22AM -0600, Logan Gunthorpe wrote:
> Yes. This is the downside of dealing only with a phys_addr_t: we have to
> look up against it. Unfortunately, I believe it's possible for different
> BARs on a device to be in different windows, so something like this is
> necessary unless we already know the BAR the phys_addr_t belongs to. It
> might probably be sped up a bit by storing the offsets of each bar
> instead of looping through all the bridge windows, but I don't think it
> will get you *that* much.
> 
> As this is an example with no users, the answer here will really depend
> on what the use-case is doing. If they can lookup, ahead of time, the
> mapping type and offset then they don't have to do this work on the hot
> path and it means that pci_p2pdma_map_resource() is simply not a
> suitable API.

Ok.  So lets just keep this out as an RFC and don't merge it until an
actual concrete user shows up.
