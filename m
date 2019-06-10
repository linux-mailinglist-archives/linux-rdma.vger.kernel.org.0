Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215193AFC5
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfFJHgw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 03:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388000AbfFJHgw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 03:36:52 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1EC12082E;
        Mon, 10 Jun 2019 07:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560152211;
        bh=lg2e5oI4yLI3bsVP7NzvXeQvaJUE1rWwAH6Vzo8NH20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyMZNHvzyUVTLX/hn8AsnFSPFj+O732ukkS4JQ1LCexFBC9WYT9jTF87t5RFgtgL1
         fF2IUsAxcnnphXRq0ZLGbQCkfkYwsgqFmB00ZhmAVzpIHGmRtqQZM4zyDx6fR0FgtG
         SS79yugNwPji0Yjq0w0l5vR8AWXNsNqCMdmawYPU=
Date:   Mon, 10 Jun 2019 10:36:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 12/12] SIW addition to kernel build
 environment
Message-ID: <20190610073647.GK6369@mtr-leonro.mtl.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-13-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526114156.6827-13-bmt@zurich.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 01:41:56PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  MAINTAINERS                        |  7 +++++++
>  drivers/infiniband/Kconfig         |  1 +
>  drivers/infiniband/sw/Makefile     |  1 +
>  drivers/infiniband/sw/siw/Kconfig  | 17 +++++++++++++++++
>  drivers/infiniband/sw/siw/Makefile | 12 ++++++++++++
>  5 files changed, 38 insertions(+)
>  create mode 100644 drivers/infiniband/sw/siw/Kconfig
>  create mode 100644 drivers/infiniband/sw/siw/Makefile
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5cfbea4ce575..3b437abffc39 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14545,6 +14545,13 @@ M:	Chris Boot <bootc@bootc.net>
>  S:	Maintained
>  F:	drivers/leds/leds-net48xx.c
>
> +SOFT-RDMA DRIVER (siw)
> +M:	Bernard Metzler (bmt@zurich,ibm.com)

As Gal said "." in email and it should be <bmt@zurich.ibm.com>
and not (bmt@zurich,ibm.com)

> +L:	linux-rdma@vger.kernel.org
> +S:	Supported
> +F:	drivers/infiniband/sw/rxe/
> +F:	include/uapi/rdma/siw-abi.h
> +
>  SOFT-ROCE DRIVER (rxe)
>  M:	Moni Shoua <monis@mellanox.com>
>  L:	linux-rdma@vger.kernel.org
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index cbfbea49f126..2013ef848fd1 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -107,6 +107,7 @@ source "drivers/infiniband/hw/hfi1/Kconfig"
>  source "drivers/infiniband/hw/qedr/Kconfig"
>  source "drivers/infiniband/sw/rdmavt/Kconfig"
>  source "drivers/infiniband/sw/rxe/Kconfig"
> +source "drivers/infiniband/sw/siw/Kconfig"
>  endif
>
>  source "drivers/infiniband/ulp/ipoib/Kconfig"
> diff --git a/drivers/infiniband/sw/Makefile b/drivers/infiniband/sw/Makefile
> index 8b095b27db87..d37610fcbbc7 100644
> --- a/drivers/infiniband/sw/Makefile
> +++ b/drivers/infiniband/sw/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_INFINIBAND_RDMAVT)		+= rdmavt/
>  obj-$(CONFIG_RDMA_RXE)			+= rxe/
> +obj-$(CONFIG_RDMA_SIW)			+= siw/
> diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
> new file mode 100644
> index 000000000000..94f684174ce3
> --- /dev/null
> +++ b/drivers/infiniband/sw/siw/Kconfig
> @@ -0,0 +1,17 @@
> +config RDMA_SIW
> +	tristate "Software RDMA over TCP/IP (iWARP) driver"
> +	depends on INET && INFINIBAND && CRYPTO_CRC32
> +	help
> +	This driver implements the iWARP RDMA transport over
> +	the Linux TCP/IP network stack. It enables a system with a
> +	standard Ethernet adapter to interoperate with a iWARP
> +	adapter or with another system running the SIW driver.
> +	(See also RXE which is a similar software driver for RoCE.)
> +
> +	The driver interfaces with the Linux RDMA stack and
> +	implements both a kernel and user space RDMA verbs API.
> +	The user space verbs API requires a support
> +	library named libsiw which is loaded by the generic user
> +	space verbs API, libibverbs. To implement RDMA over
> +	TCP/IP, the driver further interfaces with the Linux
> +	in-kernel TCP socket layer.
> diff --git a/drivers/infiniband/sw/siw/Makefile b/drivers/infiniband/sw/siw/Makefile
> new file mode 100644
> index 000000000000..ff190cb0d254
> --- /dev/null
> +++ b/drivers/infiniband/sw/siw/Makefile
> @@ -0,0 +1,12 @@
> +obj-$(CONFIG_RDMA_SIW) += siw.o
> +
> +siw-y := \
> +	siw_cm.o \
> +	siw_cq.o \
> +	siw_debug.o \
> +	siw_main.o \
> +	siw_mem.o \
> +	siw_qp.o \
> +	siw_qp_tx.o \
> +	siw_qp_rx.o \
> +	siw_verbs.o
> --
> 2.17.2
>
