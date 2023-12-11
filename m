Return-Path: <linux-rdma+bounces-348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BAB80C7EC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 12:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C1D281796
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A422836AF0;
	Mon, 11 Dec 2023 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsljIJks"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3D24A16
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 11:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D7CC433C7;
	Mon, 11 Dec 2023 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702293987;
	bh=FQ4Jbq8ycjgSyx+spAZ3FNcBTlXmXwfAE0LVVRy9Eq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MsljIJksriDt7P0Q07gR5nnS790xrsoxi6ysCVl6Sh4VL7wO68TyszJtPucc5Og6H
	 yv68wATg1Wx46g0sgRsqHADygedM5HbnGbeFqg0vIPgHyPKLrNWc10zu8zLs5Nf82h
	 IxnYG+ytWWv4dDtbUlrXqNB1NXu2Gvg8d5wRBiYyQ3RqctabF5gd8gAnT4JhhcOTaD
	 p6IkmEqymPxR9szAKTwuf9ZkZH4afz6tyzyaw7P3NRCW15CzOPsUbfJzac4v8M57O0
	 b2Z5eLwAaZndYSLuVgmhWzfKdYs3tmkSx7PKXNwbyEsJfY8fBJwgEf/+9lIH/GVffT
	 rnrWeRSRndyqQ==
Date: Mon, 11 Dec 2023 13:26:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Add EFA query MR support
Message-ID: <20231211112623.GE4870@unreal>
References: <20231207142748.10345-1-mrgolin@amazon.com>
 <20231211081032.GB4870@unreal>
 <c9bfd0e3-3640-46da-8a9b-4391c90ed1aa@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9bfd0e3-3640-46da-8a9b-4391c90ed1aa@amazon.com>

On Mon, Dec 11, 2023 at 12:35:34PM +0200, Margolin, Michael wrote:
> 
> On 12/11/2023 10:10 AM, Leon Romanovsky wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> >
> >
> >
> > On Thu, Dec 07, 2023 at 02:27:48PM +0000, Michael Margolin wrote:
> >> Add EFA driver uapi definitions and register a new query MR method that
> >> currently returns the physical PCI buses' IDs the device is using to
> >> reach the MR. Update admin definitions and efa-abi accordingly.
> >>
> >> Reviewed-by: Anas Mousa <anasmous@amazon.com>
> >> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> >> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> >> ---
> >>  drivers/infiniband/hw/efa/efa.h               |  5 +-
> >>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 31 ++++++++
> >>  drivers/infiniband/hw/efa/efa_com_cmd.c       |  6 ++
> >>  drivers/infiniband/hw/efa/efa_com_cmd.h       |  4 +
> >>  drivers/infiniband/hw/efa/efa_main.c          |  5 ++
> >>  drivers/infiniband/hw/efa/efa_verbs.c         | 77 +++++++++++++++++++
> >>  include/uapi/rdma/efa-abi.h                   | 19 +++++
> >>  7 files changed, 146 insertions(+), 1 deletion(-)
> > <...>
> >
> >> +     /*
> >> +      * Mask indicating which fields have valid values
> >> +      * 0 : recv_pci_bus_id
> >> +      * 1 : rdma_read_pci_bus_id
> >> +      * 2 : rdma_recv_pci_bus_id
> >> +      */
> >> +     u8 validity;
> > <...>
> >
> >>  #define EFA_GID_SIZE 16
> >> +#define EFA_INVALID_PCI_BUS_ID 0xffff
> > Is 0xffff value guaranteed by PCI subsystem to be invalid? Why don't you
> > provide "validity" field to userspace instead?
> 
> The 0xffff value in only used internally in the driver to indicate an
> invalid id and isn't exposed to userspace. For userspace there is a
> validity field as you suggested:
> 
> +       return uverbs_copy_to(attrs,
> EFA_IB_ATTR_QUERY_MR_RESP_PCI_BUS_ID_VALIDITY,
> +                             &pci_bus_id_validity,
> sizeof(pci_bus_id_validity));

So please rely on your EFA_GET(&cmd_completion.validity, EFA_ADMIN_XXX_PCI_BUS_ID)
checks when you fill pci_bus_id_validity and not on 0xffff value which can be
valid from PCI perspective.

Thanks

> 
> 
> Thanks
> 

