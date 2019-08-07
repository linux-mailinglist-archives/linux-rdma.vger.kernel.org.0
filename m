Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1675385399
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 21:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfHGT3W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 15:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbfHGT3W (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 15:29:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D2D2086D;
        Wed,  7 Aug 2019 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565206161;
        bh=yXgPGJFs+0VUo2NWm5PbQV6rtXGmgZ7WNLD2jaMJULA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsHOLQIqia0vm7jEQwRvEfaIJiT4oNspPc3C3XhOQkCr/aELbAHdwvZ58J3aP8C6n
         FhNN6PBh/8gfW37xhCWtyvdJfkM02m1cZ4TO7+L840PtPLMickXdOYayXWcHaI2JIp
         6rVgsht/L1OyTZ46I85rFiLdIOS4uF5UPd4w+0PQ=
Date:   Wed, 7 Aug 2019 14:29:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/14] PCI/P2PDMA: Support transactions that hit the
 host bridge
Message-ID: <20190807192919.GY151852@google.com>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190806234439.GW151852@google.com>
 <e31f13f8-5afd-6f38-a206-163e9f77c91a@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31f13f8-5afd-6f38-a206-163e9f77c91a@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 06:31:07PM -0600, Logan Gunthorpe wrote:
> On 2019-08-06 5:44 p.m., Bjorn Helgaas wrote:

> > I tentatively applied these to pci/p2pdma with minor typographical
> > updates (below), but I'll update the branch if necessary.
> 
> Great, thanks! The typographical changes look good.
> 
> I already have one very minor change queued up for these. Should I just
> send you a small patch against your branch for you to squash?

Yes, an incremental patch against my branch would be nice.

Bjorn
