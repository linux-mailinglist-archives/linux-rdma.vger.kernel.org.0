Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5757338
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 23:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFZVAU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 17:00:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37191 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFZVAU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jun 2019 17:00:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh12so3604plb.4
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2019 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n76JK0suQeeFW6xhcmoHNw4tHnQpupZZOhWEzOjxM6k=;
        b=Bzws5exLVLEQgXXhLhLFWqBVYZgCRHFpKtPyJBjrSzDy5QeDAHSVxsk8YbisLRWP8K
         gyvdK9QMRZC/Q9Lv8BEC1bfZcneBYta/G2rBRALUo6HTzmUqzFrqVSlVj6lxlLP8iVD/
         ItXAUkEnikSxp7rVIR66tj23/0yyoFt6OR9A5zPnz0Zdh0XhP3IFRUqiX6ed1780IoNc
         68xBPq3zg9j1M+eT5Cgt5VQeye7h1DSohOgMQOI97tGEfTRmJRNbHVsgZr/i/ymDA0oA
         rvDhJ0nAfbrM6fDUXFbeFu7iU0ZewvMV7C6xqGI1Z1GztnlgZD3hT6pAeKUwZKjoJnKO
         +dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n76JK0suQeeFW6xhcmoHNw4tHnQpupZZOhWEzOjxM6k=;
        b=PdZRKWh1cVPkE+KN8+FX/ct4O3QuclSzcOhc3cgNEnTHCX6bEuA7iaTKQ/VaSidQzT
         rozGU/lnwUV5nbjpKlGqXOCOoWoqiHlBboi5+lXCifoweCfJZushu1bmMxuFAVTX0ooS
         592xKORsMvljbhNRjJGjPWw//S8TieQf6tMkzit/crwebHvN6kd5BenZhLXV1MmWZFE7
         mw7vxTSW0s0ulygiLD/6MZXA3zZQESaqd0jATwoIeaU/nivmCUjy1uz5wbS9AVLs0LXz
         rL5RvBQCPWSLBcB3D+2rvDskVSQE38xQrzpW0fZE2/vSPbvozG+ZDz0lPnYjPXDvVocf
         ZV3w==
X-Gm-Message-State: APjAAAVSH/F3iA5rDrtdogjrlJ0x1W/kqS9gq/5mqCtqSrEDwrjyHJJA
        WnTxqWvEEXAZ+MtB3ZJpxny7JQ==
X-Google-Smtp-Source: APXvYqxn58rW6cya64e/DP42Cl4dWDsxuE9ORp8ZfuhKICUjVgykMrFxCwFRYmlyz7x1VeOTA+0fBw==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr144473plc.78.1561582819849;
        Wed, 26 Jun 2019 14:00:19 -0700 (PDT)
Received: from ziepe.ca ([148.87.23.38])
        by smtp.gmail.com with ESMTPSA id p27sm134242pfq.136.2019.06.26.14.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 14:00:19 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgF1e-0001mN-Hl; Wed, 26 Jun 2019 18:00:18 -0300
Date:   Wed, 26 Jun 2019 18:00:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190626210018.GB6392@ziepe.ca>
References: <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
 <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 26, 2019 at 02:45:38PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-06-26 2:21 p.m., Jason Gunthorpe wrote:
> > On Wed, Jun 26, 2019 at 12:31:08PM -0600, Logan Gunthorpe wrote:
> >>> we have a hole behind len where we could store flag.  Preferably
> >>> optionally based on a P2P or other magic memory types config
> >>> option so that 32-bit systems with 32-bit phys_addr_t actually
> >>> benefit from the smaller and better packing structure.
> >>
> >> That seems sensible. The one thing that's unclear though is how to get
> >> the PCI Bus address when appropriate. Can we pass that in instead of the
> >> phys_addr with an appropriate flag? Or will we need to pass the actual
> >> physical address and then, at the map step, the driver has to some how
> >> lookup the PCI device to figure out the bus offset?
> > 
> > I agree with CH, if we go down this path it is a layering violation
> > for the thing injecting bio's into the block stack to know what struct
> > device they egress&dma map on just to be able to do the dma_map up
> > front.
> 
> Not sure I agree with this statement. The p2pdma code already *must*
> know and access the pci_dev of the dma device ahead of when it submits
> the IO to know if it's valid to allocate and use P2P memory at all.

I don't think we should make drives do that. What if it got CMB memory
on some other device?

> > For instance we could use a small hash table of the upper phys addr
> > bits, or an interval tree, to do the lookup.
> 
> Yes, if we're going to take a hard stance on this. But using an interval
> tree (or similar) is a lot more work for the CPU to figure out these
> mappings that may not be strictly necessary if we could just pass better
> information down from the submitting driver to the mapping driver.

Right, this is coming down to an optimization argument. I think there
are very few cases (Basically yours) where the caller will know this
info, so we need to support the other cases anyhow.

I think with some simple caching this will become negligible for cases
you care about

Jason
