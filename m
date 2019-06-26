Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0642E57276
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 22:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfFZUVM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 16:21:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33005 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZUVM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jun 2019 16:21:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so5451009wme.0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2019 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OEhwVsMA3XIUpQpge8sgosocEMtryj/JM+GB3rxyxT0=;
        b=OBEQAdaamQq8DPC1D4CThjy6eV1PBaNXcwZ+5jy2E8475I+WlimCxcgC3HJrBb4Iz4
         0dVkwRaL7lX/ctEdlDzagRE1VjUA7WgtIyx9GWUJ9NC106rOa7MKYzwoHJ2RscAOG+kh
         liv+OYx3WzQdJn1mrZtCIdVHhASpUGnRNKNhiZ7r/v5geqVaTiphTa45C/tD01oSWo5h
         QTrSESIxcee5CT0pENaIxan0g84iO6+Gu//kRQzqTrgZKveJizs6i+Yea/t5c+iH4IKc
         klNTP6r9pOee8VKujHJlPdpJFTYHtk11YSZvgxxI84b3uC0Vv/4Zf/sKzq4cF6jKoHjF
         Kqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OEhwVsMA3XIUpQpge8sgosocEMtryj/JM+GB3rxyxT0=;
        b=DVfaZ7qvd5wNV0qicd+cCRpEWUGdkGIyxPDAF6UfiEnkbZ+42rltRKcNC+mHK5Vr9J
         r45PodP7V0xOlFpoUS6QY7MRqVTA3fyjUMMo4FelA7OL8M/nTsgjFJHTnxQed+KUSSA8
         Hs5z4drwpt2EiQwq/UeVU/NribAN/9AQY3BvLzDmhb36V5Oln4OU57ykm6rkrUG+V5Tc
         GLQARAA0dToIvVbvkit4hItGvCuGAQ1PUMDnAkGM4WcGLDZTMNRRWTeyw2TQha9oUZAv
         SoYiU/JUg7HTjeyo7qNQ1OBHoxY7e5z0OtIUIUhjCF+Q1nc4DbWYfE/YW4tW47sgyi94
         s+Yg==
X-Gm-Message-State: APjAAAWtZLEinB4Z/H5sWX3H/1UcWetgqgNd1Y04uGmjYF1vKXiFUJlU
        uxYPvHZRb11Nb90us4WlEV2xsg==
X-Google-Smtp-Source: APXvYqxSlsbE0PgFuCvLKbN06OJ5ff+z7EepoAOuIIAuuzNl3RxOn4db108Jy3bqKOnIlDRyHb96EQ==
X-Received: by 2002:a1c:cfc3:: with SMTP id f186mr446698wmg.134.1561580471033;
        Wed, 26 Jun 2019 13:21:11 -0700 (PDT)
Received: from ziepe.ca ([148.87.23.38])
        by smtp.gmail.com with ESMTPSA id r5sm38908409wrg.10.2019.06.26.13.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:21:10 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgEPk-0001YU-12; Wed, 26 Jun 2019 17:21:08 -0300
Date:   Wed, 26 Jun 2019 17:21:08 -0300
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
Message-ID: <20190626202107.GA5850@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
 <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 26, 2019 at 12:31:08PM -0600, Logan Gunthorpe wrote:
> > we have a hole behind len where we could store flag.  Preferably
> > optionally based on a P2P or other magic memory types config
> > option so that 32-bit systems with 32-bit phys_addr_t actually
> > benefit from the smaller and better packing structure.
> 
> That seems sensible. The one thing that's unclear though is how to get
> the PCI Bus address when appropriate. Can we pass that in instead of the
> phys_addr with an appropriate flag? Or will we need to pass the actual
> physical address and then, at the map step, the driver has to some how
> lookup the PCI device to figure out the bus offset?

I agree with CH, if we go down this path it is a layering violation
for the thing injecting bio's into the block stack to know what struct
device they egress&dma map on just to be able to do the dma_map up
front.

So we must be able to go from this new phys_addr_t&flags to some BAR
information during dma_map.

For instance we could use a small hash table of the upper phys addr
bits, or an interval tree, to do the lookup.

The bar info would give the exporting struct device and any other info
we need to make the iommu mapping.

This phys_addr_t seems like a good approach to me as it avoids the
struct page overheads and will lets us provide copy from/to bio
primitives that could work on BAR memory. I think we can surely use
this approach in RDMA as well.

Jason
