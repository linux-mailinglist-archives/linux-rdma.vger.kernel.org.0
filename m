Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC213DD9A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 15:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPOkK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 09:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgAPOkJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jan 2020 09:40:09 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB7E2075B;
        Thu, 16 Jan 2020 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185608;
        bh=1i12krPcGmcf1vhk4iOjCd9fMDoc3UG25/e8tUHCCpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DliOFolloFKVKky18XKti2//2YKztt+I4CuA+ZGoskKeYZBTAL0BryEFIfcCRlBLw
         EOAhBMQ8enhryWokE+ZEd/Y1yT2YmGVrQzi3JQS6trPtU2AmZaypcVV1Wxw44QvQWQ
         0lw1LVVYabezE7huBb90RUAt7tgDRdK+PFMmxLaQ=
Date:   Thu, 16 Jan 2020 16:40:05 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: Re: [PATCH v7 23/25] block/rnbd: include client and server modules
 into kernel compilation
Message-ID: <20200116144005.GB12433@unreal>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-24-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116125915.14815-24-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 01:59:13PM +0100, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> Add rnbd Makefile, Kconfig and also corresponding lines into upper
> block layer files.
>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/Kconfig       |  2 ++
>  drivers/block/Makefile      |  1 +
>  drivers/block/rnbd/Kconfig  | 28 ++++++++++++++++++++++++++++
>  drivers/block/rnbd/Makefile | 17 +++++++++++++++++
>  4 files changed, 48 insertions(+)
>  create mode 100644 drivers/block/rnbd/Kconfig
>  create mode 100644 drivers/block/rnbd/Makefile
>
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 1bb8ec575352..1636a7d9e91e 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -468,4 +468,6 @@ config BLK_DEV_RSXX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rsxx.
>
> +source "drivers/block/rnbd/Kconfig"
> +
>  endif # BLK_DEV
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index a53cc1e3a2d3..914f9d07835c 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
>
>  obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
>  obj-$(CONFIG_ZRAM) += zram/
> +obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
>
>  obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
>  null_blk-objs	:= null_blk_main.o
> diff --git a/drivers/block/rnbd/Kconfig b/drivers/block/rnbd/Kconfig
> new file mode 100644
> index 000000000000..56e44745a36a
> --- /dev/null
> +++ b/drivers/block/rnbd/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +config BLK_DEV_RNBD
> +	bool
> +
> +config BLK_DEV_RNBD_CLIENT
> +	tristate "Network block device driver on top of RTRS transport"
> +	depends on INFINIBAND_RTRS_CLIENT
> +	select BLK_DEV_RNBD
> +	help
> +	  RNBD client is a network block device driver using rdma transport.
> +
> +	  RNBD client allows for mapping of a remote block devices over
> +	  RTRS protocol from a target system where RNBD server is running.
> +
> +	  If unsure, say N.
> +
> +config BLK_DEV_RNBD_SERVER
> +	tristate "Network block device over RDMA server support"
> +	depends on INFINIBAND_RTRS_SERVER
> +	select BLK_DEV_RNBD
> +	help
> +	  RNBD server is the server side of RNBD using rdma transport.
> +
> +	  RNBD server allows for exporting local block devices to a remote client
> +	  over RTRS protocol.
> +
> +	  If unsure, say N.
> diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
> new file mode 100644
> index 000000000000..125c3576f221
> --- /dev/null
> +++ b/drivers/block/rnbd/Makefile
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +ccflags-y := -Idrivers/infiniband/ulp/rtrs
> +
> +rnbd-client-y := rnbd-clt.o \
> +		  rnbd-common.o \
> +		  rnbd-clt-sysfs.o
> +
> +rnbd-server-y := rnbd-srv.o \
> +		  rnbd-common.o \
> +		  rnbd-srv-dev.o \
> +		  rnbd-srv-sysfs.o
> +
> +obj-$(CONFIG_BLK_DEV_RNBD_CLIENT) += rnbd-client.o
> +obj-$(CONFIG_BLK_DEV_RNBD_SERVER) += rnbd-server.o
> +
> +-include $(src)/compat/compat.mk

What is it?

Thanks

> --
> 2.17.1
>
