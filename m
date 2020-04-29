Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A001E1BE4FB
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD2RSI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Apr 2020 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgD2RSH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Apr 2020 13:18:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA29C035493
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 10:18:07 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t20so2469296qtq.13
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=//P0tRyIIC+MlXz3WV6tUsY624nVtXrnIyCYsqSOaUI=;
        b=gX6NMJkhTK/1cn0j6iA+1zQI+H0IHG+NGCaT1RO3+6yeFA2qV28xtHZixBqybLAH+c
         TXT6xirwzqkXS86BSpVny0b+XkxrcQUR1jyydMUGfZyRudcEibbuHvFe4K1PkACdLMPz
         4smC6QGS2zhG9KtIZkdqo0xkuvLECDADAk+F+JN8Rr38s19MWvbo2ZqQAToRpUH7WUDn
         kcifK+MRXO9ZahfSM17E7ROMYEQszGNtALAS/VSIoaAJanlSvmz/x5ErEQu0K26lJRIu
         X2yf1DlioXhwCTltsKKN7uaVfeEwa7cLVuyM+KZrbo8EG20w0c4n7+PVEESND6pXYm6x
         b7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=//P0tRyIIC+MlXz3WV6tUsY624nVtXrnIyCYsqSOaUI=;
        b=j1bOaF8j1Y0x02bUmMhbIlfbuWeVVTmPzmS6gbsPPS4nCKDkvAtN7q2Lp3BgT+8L7G
         +KmaOfs3R0jvZND9KTcRbs6KXXMWmlBMr8h/A/uMlsOPj6amE2slcLbTHYJcNJWXYa0Z
         Y0Zq+XCvPLksBpGvVhGRskw8Mg5+pIC++a+zrCg6c7NDdQmLyVxhOiKTUwVZAyvsp33P
         9fKFkEPpO/PQNCdLq7pZxJ2sxw6cFQ3HeU8cp4fyKQ5KXTqkd55dOfPJnd/iXY0V1K8u
         NbYPeieTM6YYUXRzyVO6Kzq9EC20uCHHiiUuUYyS0cM3SgUNoOkI+9YgJIVgarpROgYg
         uQZQ==
X-Gm-Message-State: AGi0PuZNyyBIhXRJAVNgF0SIzDhY8FogOmhNS+i0RGxmvyE7qPr90Bt/
        oz4O6M2H+H2o8n1e1CTye21i0A==
X-Google-Smtp-Source: APiQypIiaKXLeHMrLxzvv1tSKH33bpTpDMGZuma2zyRnjx0q+NgBkLNnueqNf4QIH/1+aUcrR71Lpg==
X-Received: by 2002:ac8:6695:: with SMTP id d21mr36147178qtp.176.1588180686666;
        Wed, 29 Apr 2020 10:18:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t7sm8106233qtr.93.2020.04.29.10.18.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 10:18:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTqLU-0000NH-NF; Wed, 29 Apr 2020 14:18:04 -0300
Date:   Wed, 29 Apr 2020 14:18:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v13 23/25] block/rnbd: include client and server modules
 into kernel compilation
Message-ID: <20200429171804.GE26002@ziepe.ca>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-24-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427141020.655-24-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 27, 2020 at 04:10:18PM +0200, Danil Kipnis wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> Add rnbd Makefile, Kconfig and also corresponding lines into upper
> block layer files.
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>  drivers/block/Kconfig       |  2 ++
>  drivers/block/Makefile      |  1 +
>  drivers/block/rnbd/Kconfig  | 28 ++++++++++++++++++++++++++++
>  drivers/block/rnbd/Makefile | 15 +++++++++++++++
>  4 files changed, 46 insertions(+)
>  create mode 100644 drivers/block/rnbd/Kconfig
>  create mode 100644 drivers/block/rnbd/Makefile
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 025b1b77b11a..084b9efcefca 100644
> +++ b/drivers/block/Kconfig
> @@ -458,4 +458,6 @@ config BLK_DEV_RSXX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rsxx.
>  
> +source "drivers/block/rnbd/Kconfig"
> +
>  endif # BLK_DEV
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index 795facd8cf19..e1f63117ee94 100644
> +++ b/drivers/block/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
>  
>  obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
>  obj-$(CONFIG_ZRAM) += zram/
> +obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
>  
>  obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
>  null_blk-objs	:= null_blk_main.o
> diff --git a/drivers/block/rnbd/Kconfig b/drivers/block/rnbd/Kconfig
> new file mode 100644
> index 000000000000..4b6d3d816d1f
> +++ b/drivers/block/rnbd/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +config BLK_DEV_RNBD
> +	bool
> +
> +config BLK_DEV_RNBD_CLIENT
> +	tristate "RDMA Network Block Device driver client"
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
> +	tristate "RDMA Network Block Device driver server"
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
> index 000000000000..450a9e4974d7
> +++ b/drivers/block/rnbd/Makefile
> @@ -0,0 +1,15 @@
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

keep lists of things sorted

Jason
