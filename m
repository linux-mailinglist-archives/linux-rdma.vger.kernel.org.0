Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B04D4CF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 19:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfFTRX6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 13:23:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39182 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732300AbfFTRXu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 13:23:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so3969548qta.6
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SfbKUCdSGF4+jFDRzcaQ+Fna6TrcXDnyta04yl7lq1Y=;
        b=fDa+hMU4rcsLRRCH2gWRtgjYh9RFedwMwqv0Trz+YbWuMGaoX85v7I71KOkTii51uB
         oO9IljJOAF7bcm1YYxdaerj3SB1eX+ROcV7aGqi3ZBwoKVBEGC2K9Gm0a4yLiiEn/uAk
         fBk5sWnkPe6Qfa4DgWWmQRbh4XlFAlCgTAsATQPIvgIfBdORGI7YHDMsJoSK7wBXLdyk
         G7L29YhKyUqgAQjd6fwdckTK5NEQcVswgxlSYd5TMwXXMxxdYk5swQozsEqhRL82kEHN
         PYoc9M2dsT9k3d119XICrYvVvAjQcFqPNiWbp3QBf8xLIqoPCbUOF1ztjjMN/UPlCr8M
         O9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SfbKUCdSGF4+jFDRzcaQ+Fna6TrcXDnyta04yl7lq1Y=;
        b=pFHfMs5BUS4tmAuTn6cWREuwBRtG18b0fu28sPYGQy3vuzNs1yK4dVVzN6QdmN1ShJ
         F8YdnkNvgor/5kWqxo33v5JRYJe9OfBhe3/9xoDa3iQJGs4EZB6Rf6O1IQoq/yq/5jWz
         +Akfx4Vro2G/RiXD/bSFsFEas3O7kxXBMAIRDJPL6Y9+iK2NLp3VaAe62FTQSKjkFQn/
         96ThBbWj7AfK8JfWb1vBy5lEoi3msSAT33C7mydIx8d9HIh4Z9L5swAnDBuMWNmQ5Gx/
         hrMA63peTI/0LaxZqQbCX2ZWRb/3F+VDt1Wvo+LBXCZ3/rqzLr4X3cP9g7q3hTkfYGAG
         WGfA==
X-Gm-Message-State: APjAAAWd/TZs9itTA59sxzCJ0ivz7HX/yJyJkxom5TdRMYB4yrOrBQBQ
        WN7oPjZoKRd83Av0wAwQPHRwFQ==
X-Google-Smtp-Source: APXvYqw404QwKeABmWhU9qLItoqgwLK+kwwRuUpz/G8u1JQs97zHuMB8xnbcA0CiswhJAlAz0nkrug==
X-Received: by 2002:ac8:2409:: with SMTP id c9mr53861547qtc.145.1561051428982;
        Thu, 20 Jun 2019 10:23:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c5sm109198qtj.27.2019.06.20.10.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:23:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1he0mq-0005eq-0K; Thu, 20 Jun 2019 14:23:48 -0300
Date:   Thu, 20 Jun 2019 14:23:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 04/28] block: Never bounce dma-direct bios
Message-ID: <20190620172347.GE19891@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190620161240.22738-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620161240.22738-5-logang@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 10:12:16AM -0600, Logan Gunthorpe wrote:
> It is expected the creator of the dma-direct bio will ensure the
> target device can access the DMA address it's creating bios for.
> It's also not possible to bounce a dma-direct bio seeing the block
> layer doesn't have any way to access the underlying data behind
> the DMA address.
> 
> Thus, never bounce dma-direct bios.

I wonder how feasible it would be to implement a 'dma vec' copy
from/to? 

That is about the only operation you could safely do on P2P BAR
memory. 

I wonder if a copy implementation could somehow query the iommu layer
to get a kmap of the memory pointed at by the dma address so we don't
need to carry struct page around?

Jason
