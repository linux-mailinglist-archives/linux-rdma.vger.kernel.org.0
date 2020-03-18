Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3556F1897A9
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 10:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRJNw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 05:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgCRJNw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 05:13:52 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EF3820767;
        Wed, 18 Mar 2020 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584522831;
        bh=K9d7Q4ibY31/9Tj95TOmMoRmMlZS3Do7zERJLvevqak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wv/5Rs6dX3i+R9gWL3Qubfsobb4NHKXjJZwD6biJGdju1r3oF967LPkT4B1GXVT5l
         VmKl44wkaKpyJUJYk4PVleodK4DNJHLtQqcAUCTHFzEKMBvTR5oFHVs5s5qI1AvO09
         hOPm4D0rkiVnIcas3CO+MHxBR10ddL24udOG3ykg=
Date:   Wed, 18 Mar 2020 11:13:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 03/11] RDMA/efa: Use in-kernel offsetofend()
 to check field availability
Message-ID: <20200318091348.GS3351@unreal>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200310091438.248429-4-leon@kernel.org>
 <a1635b7d-004c-5721-a884-e11b3870928d@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1635b7d-004c-5721-a884-e11b3870928d@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 15, 2020 at 09:44:04AM +0200, Gal Pressman wrote:
> On 10/03/2020 11:14, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Remove custom and duplicated variant of offsetofend().
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> >  drivers/infiniband/hw/efa/efa_verbs.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index bf3120f140f7..5c57098a4aee 100644
> > --- a/drivers/infiniband/hw/efa/efa_verbs.c
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -144,9 +144,6 @@ static inline bool is_rdma_read_cap(struct efa_dev *dev)
> >         return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
> >  }
> >
> > -#define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
> > -                                sizeof_field(typeof(x), fld) <= (sz))
>
> I would use offsetofend here and keep the field_avail naming for readability
> sake of the using functions, but I guess that's fine as well.
>
> Thanks Leon,
> Acked-by: Gal Pressman <galpress@amazon.com>

Jason,

Can you please pick this patch?

Thanks
