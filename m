Return-Path: <linux-rdma+bounces-386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 262DA80E4C1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 08:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16251F22CD1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 07:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048FF16431;
	Tue, 12 Dec 2023 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTWObTxw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568815AF5
	for <linux-rdma@vger.kernel.org>; Tue, 12 Dec 2023 07:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A7DC433C7;
	Tue, 12 Dec 2023 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702365648;
	bh=j0MFmRZIveokNQ2WYne6lAGwE8bUkMpXx0vVfZZNOGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTWObTxwgs63uGgAbwyGBDp2jTXD35kovEop2NRFpP+LDWj1/HIvB4JqmAIdfADcX
	 aCIRLwj3/tI4HcW6WlNw0Wh076GBJRVSje9CCaXzA6NySa89mlbFze3zKCCKKikgBl
	 ayw44pZey6lNWr10galq6Ug0NDYJi9w9BP91oo8WR9IwgZ1sfuIDVCQFFBAJ6hAwYV
	 Ej+T0eFXCshgaGLQbMfH/95nAJB8euYOQMMRi8uUvHP1NdC3RxlnwKcf67W5R7GXY0
	 sCOgEKhZisWr4bkT7s/chBTxP9c6XC/67e4AlOfjrEh/QiPqLfdUUEiZn2MUncibTU
	 +hU8DSNh4roVw==
Date: Tue, 12 Dec 2023 09:20:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Add EFA query MR support
Message-ID: <20231212072043.GK4870@unreal>
References: <20231207142748.10345-1-mrgolin@amazon.com>
 <20231211081032.GB4870@unreal>
 <c9bfd0e3-3640-46da-8a9b-4391c90ed1aa@amazon.com>
 <20231211112623.GE4870@unreal>
 <f0c9275f-130a-478e-86d2-865349606bcf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c9275f-130a-478e-86d2-865349606bcf@amazon.com>

On Mon, Dec 11, 2023 at 07:46:40PM +0200, Margolin, Michael wrote:
> 
> On 12/11/2023 1:26 PM, Leon Romanovsky wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> >
> >
> >
> > On Mon, Dec 11, 2023 at 12:35:34PM +0200, Margolin, Michael wrote:
> >> On 12/11/2023 10:10 AM, Leon Romanovsky wrote:
> >>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> >>>
> >>>
> >>>
> >>> On Thu, Dec 07, 2023 at 02:27:48PM +0000, Michael Margolin wrote:
> >>>> Add EFA driver uapi definitions and register a new query MR method that
> >>>> currently returns the physical PCI buses' IDs the device is using to
> >>>> reach the MR. Update admin definitions and efa-abi accordingly.
> >>>>
> >>>> Reviewed-by: Anas Mousa <anasmous@amazon.com>
> >>>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> >>>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> >>>> ---
> >>>>  drivers/infiniband/hw/efa/efa.h               |  5 +-
> >>>>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 31 ++++++++
> >>>>  drivers/infiniband/hw/efa/efa_com_cmd.c       |  6 ++
> >>>>  drivers/infiniband/hw/efa/efa_com_cmd.h       |  4 +
> >>>>  drivers/infiniband/hw/efa/efa_main.c          |  5 ++
> >>>>  drivers/infiniband/hw/efa/efa_verbs.c         | 77 +++++++++++++++++++
> >>>>  include/uapi/rdma/efa-abi.h                   | 19 +++++
> >>>>  7 files changed, 146 insertions(+), 1 deletion(-)
> >>> <...>
> >>>
> >>>> +     /*
> >>>> +      * Mask indicating which fields have valid values
> >>>> +      * 0 : recv_pci_bus_id
> >>>> +      * 1 : rdma_read_pci_bus_id
> >>>> +      * 2 : rdma_recv_pci_bus_id
> >>>> +      */
> >>>> +     u8 validity;
> >>> <...>
> >>>
> >>>>  #define EFA_GID_SIZE 16
> >>>> +#define EFA_INVALID_PCI_BUS_ID 0xffff
> >>> Is 0xffff value guaranteed by PCI subsystem to be invalid? Why don't you
> >>> provide "validity" field to userspace instead?
> >> The 0xffff value in only used internally in the driver to indicate an
> >> invalid id and isn't exposed to userspace. For userspace there is a
> >> validity field as you suggested:
> >>
> >> +       return uverbs_copy_to(attrs,
> >> EFA_IB_ATTR_QUERY_MR_RESP_PCI_BUS_ID_VALIDITY,
> >> +                             &pci_bus_id_validity,
> >> sizeof(pci_bus_id_validity));
> > So please rely on your EFA_GET(&cmd_completion.validity, EFA_ADMIN_XXX_PCI_BUS_ID)
> > checks when you fill pci_bus_id_validity and not on 0xffff value which can be
> > valid from PCI perspective.
> >
> > Thanks
> 
> 0xffff can't practically be a valid PCI id in this context, 

As long as PCI subsystem doesn't declare 0xffff as invalid, we can't
assume it too.

Thanks

