Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E190F8FD71
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 10:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfHPIOJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 04:14:09 -0400
Received: from verein.lst.de ([213.95.11.211]:53397 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfHPIOJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Aug 2019 04:14:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AFE3A68B02; Fri, 16 Aug 2019 10:14:05 +0200 (CEST)
Date:   Fri, 16 Aug 2019 10:14:05 +0200
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
Subject: Re: [PATCH v3 10/14] PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
Message-ID: <20190816081405.GJ9249@lst.de>
References: <20190812173048.9186-1-logang@deltatee.com> <20190812173048.9186-11-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812173048.9186-11-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 11:30:44AM -0600, Logan Gunthorpe wrote:
> Factor out the bus-only mapping into its own static function.  No
> functional changes. The original pci_p2pdma_map_sg_attrs() will be used to
> decide whether this is an appropriate way to map.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-11-logang@deltatee.com
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
