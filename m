Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAA52C1D4E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 06:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKXFUi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 00:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKXFUi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 00:20:38 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B922F206FB;
        Tue, 24 Nov 2020 05:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606195237;
        bh=CZmOlpAXthrok53dncEi1TM6zYhGparxevAdxX2PqY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fH/cbdtyvJ4E/7OgOkETyt1mrV7tII2Nz4HxNO6dykmgTqDe92tYHDinqqi5xdQF/
         hyLjcm5o2xLc0Gy167DQR0vkwaR1MBWAtv6VAqDAC/0pShylrx6zj87Ab9wDz6FtqY
         Db4H190RPKFRV/RvfxsmHnzV5LFsReL3Gri3Hefc=
Date:   Tue, 24 Nov 2020 07:20:32 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/mlx5: Use ib_dma APIs instead of open
 access to parent device
Message-ID: <20201124052032.GE3159@unreal>
References: <20201123082400.351371-1-leon@kernel.org>
 <20201123135931.GM917484@nvidia.com>
 <BY5PR12MB43226D6014DAABFD08BFBEABDCFB0@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB43226D6014DAABFD08BFBEABDCFB0@BY5PR12MB4322.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 03:34:56AM +0000, Parav Pandit wrote:
>
>
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, November 23, 2020 7:30 PM
> >
> > On Mon, Nov 23, 2020 at 10:24:00AM +0200, Leon Romanovsky wrote:
> > > From: Parav Pandit <parav@nvidia.com>
> > >
> > > DMA operation of the IB device is done using ib_device->dma_device.
> > > This is well abstracted using ib_dma APIs.
> > >
> > > Hence, instead of doing open access to parent device, use IB core
> > > provided dma mapping APIs.
> >
> > Why?
> >
> > The ib DMA APIs are for people using verbs, they are only needed to pack things
> > into the ib_sge
> >
> > If you are inside a driver, not using the verbs API, or not using ib_sge, then you
> > should not be using the ib_dma API
> >
> Thanks for clarifying this. Using ib_dma apis make the code clear for dma device access clear and explicit.
>
> > It is an abberation, we should minimize its use.
> Alright. In that case will use the pci_dev as mlx5 driver internally has the knowledge of it and avoid using ib_dma APIs.

Yeah, let's do v2, although I don't understand the purpose of ib_dma
helpers if ib drivers can't use it.

Thanks
