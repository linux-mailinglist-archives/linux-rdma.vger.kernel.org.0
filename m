Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FCB2A8462
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgKERDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:03:32 -0500
Received: from verein.lst.de ([213.95.11.211]:47892 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgKERDb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 12:03:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1537568B02; Thu,  5 Nov 2020 18:03:29 +0100 (CET)
Date:   Thu, 5 Nov 2020 18:03:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/6] RMDA/sw: don't allow drivers using dma_virt_ops on
 highmem configs
Message-ID: <20201105170328.GB7502@lst.de>
References: <20201105074205.1690638-1-hch@lst.de> <20201105074205.1690638-2-hch@lst.de> <20201105144123.GB4142106@ziepe.ca> <74729b8d-146f-803a-98a3-e8149bd97e34@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74729b8d-146f-803a-98a3-e8149bd97e34@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 03:29:58PM +0000, Robin Murphy wrote:
> It's commonly done using the "def_bool" shorthand. I fact, I think simply 
> "def_bool !HIGHMEM" would suffice for the fundamental definition here.

Indeed, I'll switch it over.
