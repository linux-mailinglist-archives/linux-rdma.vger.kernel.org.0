Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DCB47C078
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 14:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhLUNJe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 08:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhLUNJe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Dec 2021 08:09:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC695C06173F
        for <linux-rdma@vger.kernel.org>; Tue, 21 Dec 2021 05:09:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5BE7B816A7
        for <linux-rdma@vger.kernel.org>; Tue, 21 Dec 2021 13:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B0FC36AF9;
        Tue, 21 Dec 2021 13:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640092171;
        bh=hrdq71MZHKBHtEXybCJ1hz0C1vr9ySs4TSm4bWtKotM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sS+Q9N0jUoXCIPoR5oxfC65hUu4WRyi610h3UPq1zNpPPCFXTRK9MOEqer0Ts1aNv
         OhNbN1HEwPHUwyGp7BWiosg2XhULSHoDm71lVgKxudpv8eia1cnLUfFhTmWdJpKtqT
         3+k0Kx0NLmIIQiOtge7wRBL4Ri7C4WosB4G2mb+hBl+Ikar5T94SM7HJT86XWniI5r
         UNDrEuuVNc7DR+g8zq7zJmMpyIgNWWD64TvU3iM2BGqeR8lVwQhIMGbxlzmF3Cihcu
         LPV4yJQ1oFtAtZ5rKksTVUtcsTZWRm2Q2MZzK9Mpb7SPIgo2OfU5ss9YA+DJ5U7TIG
         qx6vyTTXFirWg==
Date:   Tue, 21 Dec 2021 15:09:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next 00/11] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <YcHSBnKHmR9sb6KR@unreal>
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221024858.25938-1-chengyou@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 21, 2021 at 10:48:47AM +0800, Cheng Xu wrote:
> Hello all,
> 
> This patch set introduces the Elastic RDMA Adapter (ERDMA) driver, which
> released in Apsara Conference 2021 by Alibaba.
> 
> ERDMA enables large-scale RDMA acceleration capability in Alibaba ECS
> environment, initially offered in g7re instance. It can improve the
> efficiency of large-scale distributed computing and communication
> significantly and expand dynamically with the cluster scale of Alibaba
> Cloud.
> 
> ERDMA is a RDMA networking adapter based on the Alibaba MOC hardware. It
> works in the VPC network environment (overlay network), and uses iWarp
> tranport protocol. ERDMA supports reliable connection (RC). ERDMA also
> supports both kernel space and user space verbs. Now we have already
> supported HPC/AI applications with libfabric, NoF and some other internal
> verbs libraries, such as xrdma, epsl, etc,.

We will need to get erdma provider implementation in the rdma-core too,
in order to consider to merge it.

> 
> For the ECS instance with RDMA enabled, there are two kinds of devices
> allocated, one for ERDMA, and one for the original netdev (virtio-net).
> They are different PCI deivces. ERDMA driver can get the information about
> which netdev attached to in its PCIe barspace (by MAC address matching).

This is very questionable. The netdev part should be kept in the
drivers/ethernet/... part of the kernel.

Thanks

> 
> Thanks,
> Cheng Xu
> 
> Cheng Xu (11):
>   RDMA: Add ERDMA to rdma_driver_id definition
>   RDMA/erdma: Add the hardware related definitions
>   RDMA/erdma: Add main include file
>   RDMA/erdma: Add cmdq implementation
>   RDMA/erdma: Add event queue implementation
>   RDMA/erdma: Add verbs header file
>   RDMA/erdma: Add verbs implementation
>   RDMA/erdma: Add connection management (CM) support
>   RDMA/erdma: Add the erdma module
>   RDMA/erdma: Add the ABI definitions
>   RDMA/erdma: Add driver to kernel build environment
> 
>  MAINTAINERS                               |    8 +
>  drivers/infiniband/Kconfig                |    1 +
>  drivers/infiniband/hw/Makefile            |    1 +
>  drivers/infiniband/hw/erdma/Kconfig       |   10 +
>  drivers/infiniband/hw/erdma/Makefile      |    5 +
>  drivers/infiniband/hw/erdma/erdma.h       |  381 +++++
>  drivers/infiniband/hw/erdma/erdma_cm.c    | 1585 +++++++++++++++++++++
>  drivers/infiniband/hw/erdma/erdma_cm.h    |  158 ++
>  drivers/infiniband/hw/erdma/erdma_cmdq.c  |  489 +++++++
>  drivers/infiniband/hw/erdma/erdma_cq.c    |  201 +++
>  drivers/infiniband/hw/erdma/erdma_debug.c |  314 ++++
>  drivers/infiniband/hw/erdma/erdma_debug.h |   18 +
>  drivers/infiniband/hw/erdma/erdma_eq.c    |  346 +++++
>  drivers/infiniband/hw/erdma/erdma_hw.h    |  474 ++++++
>  drivers/infiniband/hw/erdma/erdma_main.c  |  711 +++++++++
>  drivers/infiniband/hw/erdma/erdma_qp.c    |  624 ++++++++
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 1477 +++++++++++++++++++
>  drivers/infiniband/hw/erdma/erdma_verbs.h |  366 +++++
>  include/uapi/rdma/erdma-abi.h             |   49 +
>  include/uapi/rdma/ib_user_ioctl_verbs.h   |    1 +
>  20 files changed, 7219 insertions(+)
>  create mode 100644 drivers/infiniband/hw/erdma/Kconfig
>  create mode 100644 drivers/infiniband/hw/erdma/Makefile
>  create mode 100644 drivers/infiniband/hw/erdma/erdma.h
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.h
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_cmdq.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_cq.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.h
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_eq.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_hw.h
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_main.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_qp.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.c
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.h
>  create mode 100644 include/uapi/rdma/erdma-abi.h
> 
> -- 
> 2.27.0
> 
