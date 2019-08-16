Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571088FD2F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfHPIIU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 04:08:20 -0400
Received: from verein.lst.de ([213.95.11.211]:53284 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfHPIIU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Aug 2019 04:08:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 16B1368B02; Fri, 16 Aug 2019 10:08:16 +0200 (CEST)
Date:   Fri, 16 Aug 2019 10:08:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v3 03/14] PCI/P2PDMA: Add constants for map type
 results to upstream_bridge_distance()
Message-ID: <20190816080815.GC9249@lst.de>
References: <20190812173048.9186-1-logang@deltatee.com> <20190812173048.9186-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190812173048.9186-4-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 11:30:37AM -0600, Logan Gunthorpe wrote:
> Add constant flags to indicate how two devices will be mapped or if they
> are unsupported. upstream_bridge_distance() will now return the
> mapping type and the distance in a passed-by-reference argument.
> 
> This helps annotate the code better, but the main reason is so we can use
> the information to store the required mapping method in an xarray.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-4-logang@deltatee.com
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
