Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C03C4A5
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 09:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403758AbfFKHFG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 03:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391121AbfFKHFG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 03:05:06 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2A12089E;
        Tue, 11 Jun 2019 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560236705;
        bh=EAzJSqckQlM3OE7da/1yU1X9jj9ecDcRklGaPwtTufg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quv1Q2DBi570unb7KVCM1eRoP3Pl/7zLGsFZ/KMnWe8KZLnSK2/U5v5eEq8pvTVvR
         NLNykwi4pNnJVIHeHM5M6VZDJXeC4rJCPVt1wbvwPjwP7tg4IdqlNQopM8s6/kX5sb
         uuYBn/tz1KCMMT2I4+WXM4flh+u2EL8eQtrgxETg=
Date:   Tue, 11 Jun 2019 10:05:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] rdma: Remove nes
Message-ID: <20190611070502.GI6369@mtr-leonro.mtl.com>
References: <20190610194911.12427-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610194911.12427-1-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 04:49:11PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> This driver was first merged over 10 years ago and has not seen major
> activity by the authors in the last 7 years. However, in that time it has
> been patched 150 times to adapt it to changing kernel APIs.
>
> Further, the hardware has several issues, like not supporting 64 bit DMA,
> that make it rather uninteresting for use with modern systems and RDMA.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  .../ABI/stable/sysfs-class-infiniband         |   17 -
>  MAINTAINERS                                   |    8 -
>  drivers/infiniband/Kconfig                    |    1 -
>  drivers/infiniband/hw/Makefile                |    1 -
>  drivers/infiniband/hw/nes/Kconfig             |   15 -
>  drivers/infiniband/hw/nes/Makefile            |    3 -
>  drivers/infiniband/hw/nes/nes.c               | 1205 -----
>  drivers/infiniband/hw/nes/nes.h               |  574 ---
>  drivers/infiniband/hw/nes/nes_cm.c            | 3992 -----------------
>  drivers/infiniband/hw/nes/nes_cm.h            |  470 --
>  drivers/infiniband/hw/nes/nes_context.h       |  193 -
>  drivers/infiniband/hw/nes/nes_hw.c            | 3887 ----------------
>  drivers/infiniband/hw/nes/nes_hw.h            | 1380 ------
>  drivers/infiniband/hw/nes/nes_mgt.c           | 1155 -----
>  drivers/infiniband/hw/nes/nes_mgt.h           |   97 -
>  drivers/infiniband/hw/nes/nes_nic.c           | 1870 --------
>  drivers/infiniband/hw/nes/nes_utils.c         |  915 ----
>  drivers/infiniband/hw/nes/nes_verbs.c         | 3754 ----------------
>  drivers/infiniband/hw/nes/nes_verbs.h         |  198 -
>  include/uapi/rdma/nes-abi.h                   |  115 -
>  20 files changed, 19850 deletions(-)
>  delete mode 100644 drivers/infiniband/hw/nes/Kconfig
>  delete mode 100644 drivers/infiniband/hw/nes/Makefile
>  delete mode 100644 drivers/infiniband/hw/nes/nes.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes.h
>  delete mode 100644 drivers/infiniband/hw/nes/nes_cm.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_cm.h
>  delete mode 100644 drivers/infiniband/hw/nes/nes_context.h
>  delete mode 100644 drivers/infiniband/hw/nes/nes_hw.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_hw.h
>  delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.h
>  delete mode 100644 drivers/infiniband/hw/nes/nes_nic.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_utils.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.h
>  delete mode 100644 include/uapi/rdma/nes-abi.h
>
> As discussed.
>

It wasn't hard to review.

Thanks
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
