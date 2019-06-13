Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F644554
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfFMQna (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 12:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbfFMGjX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 02:39:23 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4EC20896;
        Thu, 13 Jun 2019 06:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560407962;
        bh=Clx2tklHWCT/oJr1HcqxYfREn5z4/KkCmyddMlr8fTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AR/4pC2yyH+z3bYA0VH0MQfJCUzVtFvez4EOGZfC2hAtSwDrbXIJ2iWjGGbOCQD7P
         J2/6Bkq7gq+gL4crw39zo/VjuvXfTX+yq5q/h5MkpcUdS1t12WUlWCd3FSvc0MxRsz
         KsqtoznI/jFUU2m3Z6btvA5vTevy/InKRs/box0o=
Date:   Thu, 13 Jun 2019 09:39:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] rdma: Remove nes
Message-ID: <20190613063918.GX6369@mtr-leonro.mtl.com>
References: <20190610194911.12427-1-jgg@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5B2A8BB@fmsmsx124.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5B2A8BB@fmsmsx124.amr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 06:48:53PM +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH] rdma: Remove nes
> >
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > This driver was first merged over 10 years ago and has not seen major activity by
> > the authors in the last 7 years. However, in that time it has been patched 150 times
> > to adapt it to changing kernel APIs.
> >
> > Further, the hardware has several issues, like not supporting 64 bit DMA, that make
> > it rather uninteresting for use with modern systems and RDMA.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > ---
> >  .../ABI/stable/sysfs-class-infiniband         |   17 -
> >  MAINTAINERS                                   |    8 -
> >  drivers/infiniband/Kconfig                    |    1 -
> >  drivers/infiniband/hw/Makefile                |    1 -
> >  drivers/infiniband/hw/nes/Kconfig             |   15 -
> >  drivers/infiniband/hw/nes/Makefile            |    3 -
> >  drivers/infiniband/hw/nes/nes.c               | 1205 -----
> >  drivers/infiniband/hw/nes/nes.h               |  574 ---
> >  drivers/infiniband/hw/nes/nes_cm.c            | 3992 -----------------
> >  drivers/infiniband/hw/nes/nes_cm.h            |  470 --
> >  drivers/infiniband/hw/nes/nes_context.h       |  193 -
> >  drivers/infiniband/hw/nes/nes_hw.c            | 3887 ----------------
> >  drivers/infiniband/hw/nes/nes_hw.h            | 1380 ------
> >  drivers/infiniband/hw/nes/nes_mgt.c           | 1155 -----
> >  drivers/infiniband/hw/nes/nes_mgt.h           |   97 -
> >  drivers/infiniband/hw/nes/nes_nic.c           | 1870 --------
> >  drivers/infiniband/hw/nes/nes_utils.c         |  915 ----
> >  drivers/infiniband/hw/nes/nes_verbs.c         | 3754 ----------------
> >  drivers/infiniband/hw/nes/nes_verbs.h         |  198 -
> >  include/uapi/rdma/nes-abi.h                   |  115 -
> >  20 files changed, 19850 deletions(-)
> >  delete mode 100644 drivers/infiniband/hw/nes/Kconfig  delete mode 100644
> > drivers/infiniband/hw/nes/Makefile
> >  delete mode 100644 drivers/infiniband/hw/nes/nes.c  delete mode 100644
> > drivers/infiniband/hw/nes/nes.h  delete mode 100644
> > drivers/infiniband/hw/nes/nes_cm.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_cm.h
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_context.h
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_hw.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_hw.h
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.h
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_nic.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_utils.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.h
> >  delete mode 100644 include/uapi/rdma/nes-abi.h
> >
>
> Thank you!
>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>

Extra thing, can you please add a comment in
include/uapi/rdma/rdma_user_ioctl_cmds.h near RDMA_DRIVER_NES that this
driver is removed.

Thanks
