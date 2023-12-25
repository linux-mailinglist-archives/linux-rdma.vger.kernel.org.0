Return-Path: <linux-rdma+bounces-491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A65DC81E00E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 12:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9E01C20CA6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670651014;
	Mon, 25 Dec 2023 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1kgY3B9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A85100A
	for <linux-rdma@vger.kernel.org>; Mon, 25 Dec 2023 11:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EC6C433C8;
	Mon, 25 Dec 2023 11:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703503569;
	bh=OvjcJTFzfytkoHLbxalWgVOezIJMj0wx7tS+3HzWKmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1kgY3B9cs8wD3SujkkLJwwPpTgxG1GQTjOugDu01XeLaZhWGxwW9WQXxJZW8QwHr
	 SiorssUVDCfpTA6Hp7t19XzM7Dpcy2GqmYGpAwYyKP+Nz1bQ5NiDAP/tAA9DFuChv/
	 NsROPG+i8CN2gNMMzGvbK+td0H9BQ7HPPi3XyCEjLVegUdGCaQBgEtsY6no0y4v3Ru
	 dH60ybz81XQM3t3BH4+zcUIUZOryxh/lpyiQ7pwQp6RBFe5o8rmFR4fbS1HDrws6WT
	 PTdRzpAvP5z/YeC4714l50uXY2EfUcGr5SrVf/V7xV/yf8F5gk//lIfWo88MqbdhUL
	 q0OI7IhWka72w==
Date: Mon, 25 Dec 2023 13:26:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, gal.pressman@linux.dev,
	linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v3] RDMA/efa: Add EFA query MR support
Message-ID: <20231225112605.GC59971@unreal>
References: <20231211174715.7369-1-mrgolin@amazon.com>
 <20231211175019.GK2944114@nvidia.com>
 <c9790d7c-e904-4014-a238-343f376a08b9@amazon.com>
 <2a4a71b1-4a85-40fb-87c0-59ff50a956c2@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4a71b1-4a85-40fb-87c0-59ff50a956c2@amazon.com>

On Thu, Dec 21, 2023 at 03:45:56PM +0200, Margolin, Michael wrote:
> On 12/13/2023 7:05 PM, Margolin, Michael wrote:
> 
> > On 12/11/2023 7:50 PM, Jason Gunthorpe wrote:
> >> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> >>
> >>
> >>
> >> On Mon, Dec 11, 2023 at 05:47:15PM +0000, Michael Margolin wrote:
> >>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >>> index 9c65bd27bae0..597f7ca6f31d 100644
> >>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >>> @@ -415,6 +415,32 @@ struct efa_admin_reg_mr_resp {
> >>>        * memory region
> >>>        */
> >>>       u32 r_key;
> >>> +
> >>> +     /*
> >>> +      * Mask indicating which fields have valid values
> >>> +      * 0 : recv_pci_bus_id
> >>> +      * 1 : rdma_read_pci_bus_id
> >>> +      * 2 : rdma_recv_pci_bus_id
> >>> +      */
> >>> +     u8 validity;
> >>> +
> >>> +     /*
> >>> +      * Physical PCIe bus used by the device to reach the MR for receive
> >>> +      * operation
> >>> +      */
> >>> +     u8 recv_pci_bus_id;
> >>> +
> >>> +     /*
> >>> +      * Physical PCIe bus used by the device to reach the MR for RDMA read
> >>> +      * operation
> >>> +      */
> >>> +     u8 rdma_read_pci_bus_id;
> >>> +
> >>> +     /*
> >>> +      * Physical PCIe bus used by the device to reach the MR for RDMA write
> >>> +      * receive
> >>> +      */
> >>> +     u8 rdma_recv_pci_bus_id;
> >> What driver is bound to this other PCIe bus and how did the iommu get
> >> setup for it?
> >>
> >> Jason
> > It's internal bus that is not directly exposed to the host. Addresses
> > mapping is acquired from accelerator's driver as for any MR residing in
> > accelerator memory, and the translation is owned by devices on that bus.
> >
> >
> > Michael
> 
> Hi,
> 
> Just want to make sure if there are any questions / comments regarding
> to this patch that haven't been addressed?

I'm waiting from Jason ack/nack on this patch as he was the one who
asked the question.

Thanks

> 
> 
> Michael
> 

