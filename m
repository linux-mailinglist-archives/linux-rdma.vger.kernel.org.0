Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C92A991
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2019 14:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfEZMNi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 May 2019 08:13:38 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6641 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEZMNi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 May 2019 08:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558872816; x=1590408816;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=F3/UOtZnUpISQ5KbL7g+fO4/mNnlzApmf07O7DIhCkE=;
  b=MLoCe2BL0UVrr/AtxPpm+oBrzuFTrjXSgT56V0BySPnecc4L3xBgFO92
   tkPnofqKqH4SdlqDNCm85Ow0q5oJXopLFRhB2s1LA43NHYmkVRyZMQnIQ
   0AVUqv6MJlebA+1u3LBVUEpoF/lahGuCvwYZzCzCaCZOs1zP/lIQwltHv
   Q=;
X-IronPort-AV: E=Sophos;i="5.60,514,1549929600"; 
   d="scan'208";a="734804937"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 May 2019 12:13:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4QCDYZS106068
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 26 May 2019 12:13:35 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 26 May 2019 12:13:34 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.140) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 26 May 2019 12:13:31 +0000
Subject: Re: [PATCH for-next v1 12/12] SIW addition to kernel build
 environment
To:     Bernard Metzler <bmt@zurich.ibm.com>, <linux-rdma@vger.kernel.org>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-13-bmt@zurich.ibm.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <a6373742-6d27-ad4b-ff6d-61f00db663d4@amazon.com>
Date:   Sun, 26 May 2019 15:13:26 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190526114156.6827-13-bmt@zurich.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.140]
X-ClientProxiedBy: EX13D12UWA002.ant.amazon.com (10.43.160.88) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 26/05/2019 14:41, Bernard Metzler wrote:
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

SOFT-RDMA or SOFT-IWARP RDMA?

> +M:	Bernard Metzler (bmt@zurich,ibm.com)

Should be a dot between zurich and ibm?

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
> 
