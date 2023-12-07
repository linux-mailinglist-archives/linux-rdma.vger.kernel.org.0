Return-Path: <linux-rdma+bounces-297-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DB38081C8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 08:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44B51F21F84
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 07:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED15171C3;
	Thu,  7 Dec 2023 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEsTfRod"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7385182CF
	for <linux-rdma@vger.kernel.org>; Thu,  7 Dec 2023 07:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA3DC433C7;
	Thu,  7 Dec 2023 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701933787;
	bh=cb3ccs7Bks/ENxCVB9ZN3dVFwvNKcUz7NIJ9QwZ2vPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEsTfRodpqUO43uWNnS58/IVr6aKo2kXcHu/347dLg7We7E6WGmpgE/z05531ac4g
	 VuJTnqpYvdEyKO1I5UmDRJwZHjr4K8MRL5+Se9d7eID3ll2ndRnxvmcaQrvrmfWpm3
	 xc4fvaW5R9Q3ojtZuDlPszEhEw3EuFMdBW26uv1ok5O22gXBarcoLj9AmHQzojkAbN
	 Ys3pSRuU3XpltKyZ38RpMM3i4PO/GwCuetkAUnk61WmQimyo2lN+u0R/GMiU4dwuMx
	 Q1Y1qzsREixJme6qtg/PB/WYcog3rBXxzcuOB6+goAtliU2vM5/m6LGmzUTyNEJwHI
	 wxSE25AdfwjXw==
Date: Thu, 7 Dec 2023 09:23:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add EFA query MR support
Message-ID: <20231207072303.GA10455@unreal>
References: <20231205221606.26436-1-mrgolin@amazon.com>
 <08c5ccbe-1f9a-4e4d-b6bd-91ef62ef1b5b@linux.dev>
 <3df3da6b-9c8b-4bea-b9e0-25f2a06f71e5@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df3da6b-9c8b-4bea-b9e0-25f2a06f71e5@amazon.com>

On Wed, Dec 06, 2023 at 08:30:37PM +0200, Margolin, Michael wrote:
> Hey Gal,
> 
> Thanks for your comments.
> 
> On 12/6/2023 4:52 PM, Gal Pressman wrote:
> > Hi Michael,
> >
> > On 06/12/2023 0:16, Michael Margolin wrote:
> >> @@ -432,6 +435,9 @@ static int efa_ib_device_add(struct efa_dev *dev)
> >>
> >>       ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
> >>
> >> +     if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
> > EFA depends on CONFIG_INFINIBAND_USER_ACCESS:
> >
> >       7 config INFINIBAND_EFA
> >       8         tristate "Amazon Elastic Fabric Adapter (EFA) support"
> >       9         depends on PCI_MSI && 64BIT && !CPU_BIG_ENDIAN
> >      10         depends on INFINIBAND_USER_ACCESS
> 
> I'll remove this if statement.
> 
> >> +             dev->ibdev.driver_def = efa_uapi_defs;
> >> +
> >>       err = ib_register_device(&dev->ibdev, "efa_%d", &pdev->dev);
> >>       if (err)
> >>               goto err_destroy_eqs;
> >> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> >> index 0f8ca99d0827..d81904f4b876 100644
> >> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> >> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >> @@ -13,6 +13,9 @@
> >>  #include <rdma/ib_user_verbs.h>
> >>  #include <rdma/ib_verbs.h>
> >>  #include <rdma/uverbs_ioctl.h>
> >> +#define UVERBS_MODULE_NAME efa_ib
> >> +#include <rdma/uverbs_named_ioctl.h>
> >> +#include <rdma/ib_user_ioctl_cmds.h>
> >>
> >>  #include "efa.h"
> >>  #include "efa_io_defs.h"
> >> @@ -1653,6 +1656,9 @@ static int efa_register_mr(struct ib_pd *ibpd, struct efa_mr *mr, u64 start,
> >>       mr->ibmr.lkey = result.l_key;
> >>       mr->ibmr.rkey = result.r_key;
> >>       mr->ibmr.length = length;
> >> +     mr->recv_pci_bus_id = result.recv_pci_bus_id;
> >> +     mr->rdma_read_pci_bus_id = result.rdma_read_pci_bus_id;
> >> +     mr->rdma_recv_pci_bus_id = result.rdma_recv_pci_bus_id;
> > Why is a query_mr ioctl better than returning this data through udata on
> > MR creation?
> 
> We need this for both reg_user_mr and reg_user_mr_dmabuf and it doesn't
> make sense to implement it twice. In addition, those two verbs are using
> different mechanisms (write and ioctl) and extending dmabuf reg_mr will
> require more extensive changes on rdma-core side.

Both of these callbacks use ioctl() interface. We keep write() interface
for legacy systems which won't and/or shouldn't use any new API.

Thanks

> 
> Michael
> 

