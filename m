Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C205D8BE
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 02:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGCA2G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 20:28:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34169 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfGCA2G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jul 2019 20:28:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so409011qkt.1
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jul 2019 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MdOAu5KOREG+EbRK6Nq+YrKhvJXs3HmUBDCrdZ5KiX8=;
        b=AAxljt6pnpE2phFv0au/KMXwtndrEkpi/j2/EJsMk1Ltm/znau8U4oC61EO2/d59Sk
         xJPU1u0BtjEPFESekQuX2BJ1u/SqIZ7bMflpffyt+/cccxx1yOrusUEn8yOp2ywWrOCf
         Lld5MDyXgnJIr3ve2Fh/w5j5fkwVyTxgAGins3VH29cEQcbzt+qyDR2bHhjmFSi3jbg6
         /F7F3gPexkQQQsNw63xYHhsOrFz2Bzyo6kl0n9KIvQtP8bxrPZ5QJz8X1GXONm3VkV3X
         NKNrdqQe5b84FicJ1h0fFR5CFdrR9SaWP/732ngOtvNn+h+/TB30mAQ6Zl96yTI1xlw7
         I9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MdOAu5KOREG+EbRK6Nq+YrKhvJXs3HmUBDCrdZ5KiX8=;
        b=oO0vEvTVMt6lyurf90kJ5BB1Rjav1WXO9Nm/Q45tdIHN7x6gav8k8YZRd2M+lcM37X
         luYmC2VKyAUF4P7qPnzuZb4ZMFSnSZrhpBDK3XNmMzLXD5W3IvelFUvUeF+tBaW8/FyM
         n+klrCS++1F3bTgAnpmgIurMgWOkc+KyN+lyKziicjPCtt3GDUf0SJ7jRDL7Ci+TQxE4
         DWc8h5q5sEIRXAOoHllVusQYtMRMraTL2+wnGrUsIO79buyrpEaHfDP8Nhi6FyU4xPdY
         BrZJqD4PDoCt55PY2+Pe53BRtkK6X02wncwEhkOwsy605JV6D1bIUtguRaeoegAn2EH6
         SSVQ==
X-Gm-Message-State: APjAAAUNv+oKFgMK/Dgytzb8l48zWagteAwcbrEldOFTAmqL/AKrDvTL
        pvhx4iM8Z67ITNv/C352Jc7mmw==
X-Google-Smtp-Source: APXvYqzUcLNxWLj8a1mpiDGB2K6z0y2WfLWUEsAEOQWJszxbWpBMhPdailzBeKZol6g1VGK7JNoCSA==
X-Received: by 2002:a37:9904:: with SMTP id b4mr26656775qke.159.1562107531140;
        Tue, 02 Jul 2019 15:45:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j3sm141576qki.5.2019.07.02.15.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 15:45:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hiRWk-0003Lm-82; Tue, 02 Jul 2019 19:45:30 -0300
Date:   Tue, 2 Jul 2019 19:45:30 -0300
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
Message-ID: <20190702224530.GD11860@ziepe.ca>
References: <20190627063223.GA7736@ziepe.ca>
 <6afe4027-26c8-df4e-65ce-49df07dec54d@deltatee.com>
 <20190627163504.GB9568@ziepe.ca>
 <4894142c-3233-a3bb-f9a3-4a4985136e9b@deltatee.com>
 <20190628045705.GD3705@ziepe.ca>
 <8022a2a4-4069-d256-11da-e6d9b2ffbf60@deltatee.com>
 <20190628172926.GA3877@ziepe.ca>
 <25a87c72-630b-e1f1-c858-9c8b417506fc@deltatee.com>
 <20190628190931.GC3877@ziepe.ca>
 <cb680437-9615-da42-ebc5-4751e024a45f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb680437-9615-da42-ebc5-4751e024a45f@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 01:35:42PM -0600, Logan Gunthorpe wrote:

> > However, I'd feel more comfortable about that assumption if we had
> > code to support the IOMMU case, and know for sure it doesn't require
> > more info :(
> 
> The example I posted *does* support the IOMMU case. That was case (b1)
> in the description. The idea is that pci_p2pdma_dist() returns a
> distance with a high bit set (PCI_P2PDMA_THRU_HOST_BRIDGE) when an IOMMU
> mapping is required and the appropriate flag tells it to call
> dma_map_resource(). This way, it supports both same-segment and
> different-segments without needing any look ups in the map step.

I mean we actually have some iommu drivers that can setup P2P in real
HW. I'm worried that real IOMMUs will need to have the BDF of the
completer to route completions back to the requester - which we can't
trivially get through this scheme.

However, maybe that is just a future problem, and certainly we can see
that with an interval tree or otherwise such a IOMMU could get the
information it needs.

Jason
