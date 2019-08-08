Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D691F85B99
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 09:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfHHHbN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 03:31:13 -0400
Received: from verein.lst.de ([213.95.11.211]:44048 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730887AbfHHHbN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 03:31:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC7D768B02; Thu,  8 Aug 2019 09:31:09 +0200 (CEST)
Date:   Thu, 8 Aug 2019 09:31:09 +0200
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
Subject: Re: [PATCH v2 03/14] PCI/P2PDMA: Add constants for not-supported
 result upstream_bridge_distance()
Message-ID: <20190808073109.GC29852@lst.de>
References: <20190730163545.4915-1-logang@deltatee.com> <20190730163545.4915-4-logang@deltatee.com> <20190807055455.GA6627@lst.de> <4b0c012a-c3a1-a1c0-b098-8b350963aed1@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0c012a-c3a1-a1c0-b098-8b350963aed1@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 09:58:06AM -0600, Logan Gunthorpe wrote:
> We only calculate it at the same time as we calculate the distance. This
> is necessary because, to calculate the type, we have to walk the tree
> and check the ACS bits. If we separated it, we'd have to walk the tree
> twice in a very similar way just to determine both the distance and the
> mapping type.

Calculating it together makes perfect sense.  What I find odd is the
overloading of a single return value.  Why not return the map type as
the return value, and the distance as a by reference argument to keep
them properly separated?
