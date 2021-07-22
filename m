Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBE3D1FBA
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGVHf6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 03:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhGVHf6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Jul 2021 03:35:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C81FC61279;
        Thu, 22 Jul 2021 08:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626941793;
        bh=J1qotel+OZG/vKP3FOFqOsfHAvbuOOwMlRpVmukHw6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dzdbw9Gqc1dmvNUTZCgg83GPDWaYlMnbGY0WO9YZpmlNE4nUw6hYsLpQ3dJxRBr09
         GJgHEeXNPCF/bN208MvMRU7bR16kxcgcholKN60duPXkLLnPxMeCeZGyWcqE6GLn5m
         pKbDk+QlMpYg8F+hgkyi9EdIjJOHvz2H3SnJUi98ey1hjWcyZbZt437phBnj9YUB9M
         7XaIlYROYDCZm3oEOPx+PnCKjKbEHY13phwiM2NLv2CaTN0a8eMK1q+ol2jYj4ThcY
         6bFzmRJCq6jqYXXU+1zQdDgHDPmhzjk1npH+lgoz7c1b/bm1YRniDa0ELcO564sg1Q
         kyK4G8r133XWw==
Date:   Thu, 22 Jul 2021 11:16:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 8/9] RDMA: Globally allocate and release QP
 memory
Message-ID: <YPkpXcPt7/I6PHZx@unreal>
References: <cover.1626609283.git.leonro@nvidia.com>
 <5b3bff16da4b6f925c872594262cd8ed72b301cd.1626609283.git.leonro@nvidia.com>
 <2d36585e-97da-1b27-4e2c-f3a7d2b76db7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d36585e-97da-1b27-4e2c-f3a7d2b76db7@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 03:59:04PM +0800, Wenpeng Liang wrote:
> 
> 
> On 2021/7/18 20:00, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Convert QP object to follow IB/core general allocation scheme.
> > That change allows us to make sure that restrack properly kref
> > the memory.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi, Leon, I tested your patchset, it looks good to hns.
> But there is a redundant assignment in hns.
> This is the patch.

Thanks a lot.

> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 364f404..fd0f71a 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -959,8 +959,6 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>         struct ib_device *ibdev = &hr_dev->ib_dev;
>         int ret;
> 
> -       hr_qp->ibqp.qp_type = init_attr->qp_type;
> -
>         if (init_attr->cap.max_inline_data > hr_dev->caps.max_sq_inline)
>                 init_attr->cap.max_inline_data = hr_dev->caps.max_sq_inline;
