Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86FE67195A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfGWNfo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 09:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfGWNfo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 09:35:44 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAD222543;
        Tue, 23 Jul 2019 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563888943;
        bh=OO8nJomSEO2D++ABdtc/+QNB5Q/xBy1hdo/4xmkUvD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFGNdhTnVi9OKRQLmpNipDJlG933tuuZwTDDwKTK35bjSW4mvlHyhaj7g9/XYn1gy
         N2C/W66/LLvWcPB4fXxCfA1V7xj5sJYGvhWUGgVRTm7I3eu+jPGH2YL7QBjmLKfWag
         RM1jQ2I34WRSOuuRhTrecSKgmTYuuaYY9kHZ3iN4=
Date:   Tue, 23 Jul 2019 16:35:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     YueHaibing <yuehaibing@huawei.com>, oulijun@huawei.com,
        xavier.huwei@huawei.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix build error for hip08
Message-ID: <20190723133540.GM5125@mtr-leonro.mtl.com>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
 <20190723074339.GJ5125@mtr-leonro.mtl.com>
 <20190723123402.GA15357@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723123402.GA15357@ziepe.ca>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 23, 2019 at 09:34:02AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 23, 2019 at 10:43:39AM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 23, 2019 at 10:49:08AM +0800, YueHaibing wrote:
> > > If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
> > > but INFINIBAND_HNS is y, building fails:
> > >
> > > drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
> > > hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
> > > drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
> > > hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'
> >
> > It means that you have a problem with header files of your hns3.
> >
> > >
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > >  drivers/infiniband/hw/hns/Kconfig | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
> > > index b59da5d..4371c80 100644
> > > +++ b/drivers/infiniband/hw/hns/Kconfig
> > > @@ -23,7 +23,8 @@ config INFINIBAND_HNS_HIP06
> > >
> > >  config INFINIBAND_HNS_HIP08
> > >  	bool "Hisilicon Hip08 Family RoCE support"
> > > -	depends on INFINIBAND_HNS && PCI && HNS3
> > > +	depends on INFINIBAND_HNS && (INFINIBAND_HNS = HNS3)
> >
> > This is wrong.
>
> It is tricky. It is asserting that the IB side is built as a module if
> the ethernet side is a module..
>
> It is kind of a weird pattern as the module config is INFINIBAND_HNS
> and these others are just bool opens what to include, but I think it
> is OK..

select ???

>
> Jason
