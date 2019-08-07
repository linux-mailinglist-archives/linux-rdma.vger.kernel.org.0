Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10B884BDB
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfHGMnF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 08:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfHGMnF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 08:43:05 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820C821E6A;
        Wed,  7 Aug 2019 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565181783;
        bh=DSOqHZKzfxJCZQfOS8mvVgo1QbtlO3rC0sbZdySkgik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhtpjOYeSpO9C1DJpFn99mKnBiMif6GrpQHf6lp9Pdd4gFfXvvrZHGDpYLqD9+J5Z
         mDscs4/7yqUvRNrD3ene0kDil0UPhZNmqa5Yfc0wvno1BiDoJQJR/K1/9+BL5D9GTC
         BUHo3tTuGvyKWOoP4kgc+ImwkG0E4+bjNllLpA7o=
Date:   Wed, 7 Aug 2019 07:43:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
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
Message-ID: <20190807124259.GX151852@google.com>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190730163545.4915-14-logang@deltatee.com>
 <20190807055958.GC6627@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807055958.GC6627@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 07:59:58AM +0200, Christoph Hellwig wrote:
> no-mmu sounds stange, as we use that for linux ports without paging
> hardware.  I think an "io" got lost somewhere..

I had already changed the subject to

  PCI/P2PDMA: Allow IOMMU for host bridge whitelist

but certainly open to better suggestions.
