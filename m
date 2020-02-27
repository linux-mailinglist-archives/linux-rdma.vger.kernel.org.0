Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C7172843
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgB0TBd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 14:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgB0TBd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 14:01:33 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D5A72467B;
        Thu, 27 Feb 2020 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582830092;
        bh=jB6PxrsYAh6O2oHTdDruFl7xaP2WE5fpKkdA7wnBSxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dweqwxe9B/LIH1xt5nH3oTH8yslhc+7dAqb+BO0xfhWy9mBFLuEIv2kuH+SVm78Sp
         26DW2PhiVtYrt5bMd7PmDZh4VNjfpUqPUuNhoybtJ5LOxC5psrqYjZM3f606TgEiQs
         JYEGB77HDmRgI71hwZFqam35Iaym+PE9B8bizkwY=
Date:   Thu, 27 Feb 2020 21:01:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/core: Fix pkey and port assignment in
 get_new_pps
Message-ID: <20200227190126.GO12414@unreal>
References: <20200227125728.100551-1-leon@kernel.org>
 <CY4PR1101MB2262DAEFBC6C06EDF69B0F1286EB0@CY4PR1101MB2262.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1101MB2262DAEFBC6C06EDF69B0F1286EB0@CY4PR1101MB2262.namprd11.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 02:07:10PM +0000, Marciniszyn, Mike wrote:
> >
> > From: Maor Gottlieb <maorg@mellanox.com>
> >
> > When port is part of the modify mask, then we should take
> > it from the qp_attr and not from the old pps. Same for PKEY.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in
> > get_pkey_idx_qp_list")
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/core/security.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/security.c
> > b/drivers/infiniband/core/security.c
> > index b9a36ea244d4..2d5608315dc8 100644
> > --- a/drivers/infiniband/core/security.c
> > +++ b/drivers/infiniband/core/security.c
> > @@ -340,11 +340,15 @@ static struct ib_ports_pkeys *get_new_pps(const
> > struct ib_qp *qp,
> >  		return NULL;
> >
> >  	if (qp_attr_mask & IB_QP_PORT)
> > -		new_pps->main.port_num =
> > -			(qp_pps) ? qp_pps->main.port_num : qp_attr-
> > >port_num;
> > +		new_pps->main.port_num = qp_attr->port_num;
> > +	else if (qp_pps)
> > +		new_pps->main.port_num = qp_pps->main.port_num;
> > +
> >  	if (qp_attr_mask & IB_QP_PKEY_INDEX)
> > -		new_pps->main.pkey_index = (qp_pps) ? qp_pps-
> > >main.pkey_index :
> > -						      qp_attr->pkey_index;
> > +		new_pps->main.pkey_index = qp_attr->pkey_index;
> > +	else if (qp_pps)
> > +		new_pps->main.pkey_index = qp_pps->main.pkey_index;
> > +
> >  	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask &
> > IB_QP_PORT))
> >  		new_pps->main.state = IB_PORT_PKEY_VALID;
> >
>
> I agree with this aspect of the patch and it does fix the panic, because the correct unit
> is gotten from qp_pps.
>
> My issue is that the new_pps->main.state will come back as 0, and the insert routine will drop any new pkey index update.
>
> The sequence I'm concerned about is:
>
> 0x71 attr mask with both pkey index and port.
>
> A ulp decides to change the pkey index and does an 0x51 modify without setting the unit.
>
> I see new_pps->main.state being returned as 0 and port_pkey_list_insert() will early out.

I see, maybe we can store the main.state in qps and restore it from there?

>
> I asked this exact question in https://marc.info/?l=linux-rdma&m=158278763015030&w=2.
>
> I also asked about the logical or, and you answered that pointing to an additional patch.
>
> You but didn't address the main.state being 0 and losing the pkey_index update in the 0x51 modify.
>
> Mike
>
>
>
>
>
>
