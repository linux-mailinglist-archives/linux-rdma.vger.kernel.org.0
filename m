Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CABC84408
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 07:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfHGFzB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 01:55:01 -0400
Received: from verein.lst.de ([213.95.11.211]:34536 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfHGFzB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 01:55:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D3B3168B05; Wed,  7 Aug 2019 07:54:55 +0200 (CEST)
Date:   Wed, 7 Aug 2019 07:54:55 +0200
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
Subject: Re: [PATCH v2 03/14] PCI/P2PDMA: Add constants for not-supported
 result upstream_bridge_distance()
Message-ID: <20190807055455.GA6627@lst.de>
References: <20190730163545.4915-1-logang@deltatee.com> <20190730163545.4915-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730163545.4915-4-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 30, 2019 at 10:35:34AM -0600, Logan Gunthorpe wrote:
> Add constant flags to indicate two devices are not supported or whether
> the data path goes through the host bridge instead of using the negative
> values -1 and -2.
> 
> This helps annotate the code better, but the main reason is so we
> can use the information to store the required mapping method in an
> xarray.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Is there really no way to keep the distance separate from the type of
the connection as I requested?  I think that would avoid a lot of
confusion down the road.
