Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686238FD6D
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 10:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfHPINx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 04:13:53 -0400
Received: from verein.lst.de ([213.95.11.211]:53379 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPINx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Aug 2019 04:13:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE84668B02; Fri, 16 Aug 2019 10:13:49 +0200 (CEST)
Date:   Fri, 16 Aug 2019 10:13:49 +0200
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
Subject: Re: [PATCH v3 09/14] PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
Message-ID: <20190816081349.GI9249@lst.de>
References: <20190812173048.9186-1-logang@deltatee.com> <20190812173048.9186-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812173048.9186-10-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 11:30:43AM -0600, Logan Gunthorpe wrote:
> Add pci_p2pdma_unmap_sg() to the two places that call pci_p2pdma_map_sg().
> 
> This is a prep patch to introduce correct mappings for p2pdma transactions
> that go through the root complex.

I personally wouldn't split it from actually adding useful functionality,
but that aside this looks ok:

Reviewed-by: Christoph Hellwig <hch@lst.de>
