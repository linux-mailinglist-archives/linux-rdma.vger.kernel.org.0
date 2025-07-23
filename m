Return-Path: <linux-rdma+bounces-12445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A60B0FA10
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 20:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40621C8098D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B03226CF4;
	Wed, 23 Jul 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="jnsO6VBB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mta-201a.earthlink-vadesecure.net (mta-201a.earthlink-vadesecure.net [51.81.229.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E4223323;
	Wed, 23 Jul 2025 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.229.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294430; cv=none; b=mUWngVo/hm0lmGRuPdm8S9Kcxr5QYU0dCwEylLEjNxWXP+OpywzWPay/8vi7WI+xuNRjjEfXzUTXJEdGYeV+TPpUyr9mOuN0+A0yOzzvJBkaEx3zgFq5fHtAZB7V5bewpFHxrPUPjEVQFuLwcMVdzP+pOjwX1/YrmSfy35B1Zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294430; c=relaxed/simple;
	bh=tnjpzqd1Mggmvw8Wggg8wzHg0F7ogxOpOkKC+zxbTJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dqcwao1iLrrtmxYsNwoo/vr6nQVbrXLWKaPSfzpAXfnjSaF66D7pD37DJdmO5wllO/zQNqMQNbaQQhv5TZbKv3eUTryrTFlargZqRJfFVkuNlBIfPSA+ESUVuIMXRhM9rlo5VZsyZszNj2UfiVZlnk/6pcRhcOSpUX4qHJYh53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=jnsO6VBB; arc=none smtp.client-ip=51.81.229.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=svnelson@teleport.com smtp.mailfrom=sln@onemain.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=TopWGv7yYEm89cmEi+jB4nxn++rXyLPZlZQ0Hz
 pYEDk=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1753294419; x=1753899219; b=jnsO6VBBkNdZLB/t1bpISWlnOU/
 LVjFlWvHzwuo6RH9EWc3AkvhAhHbykqf9cxMulgGygCsFTRRoj7e961oJHIvRFXRwldeOZc
 A9nav7otEHwNwV+AGaO26d9/Ol4gRPOztsen3v4MOMgKEMH4J7qhRbPlYJJ/a5AhYIbpWId
 oh/phJjBszMhxdHnA3/MsKF7KulF60fvogiKUO7yqS26bfj4xGWl8c6hj5L29zosONGOX1X
 WhCmFoU0tWPk8j1nscL3Mequ2WvHODaR3SXOW/KI4VDNa/S4fvDbcAc6+gyl5XGl4TrWB9v
 KgRe94c9ELmnsmK/AqigTQfEy3Ozqzg==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel2nmtao01p.internal.vadesecure.com with ngmta
 id 1f341533-1854f3fbedb751fd; Wed, 23 Jul 2025 18:13:39 +0000
Message-ID: <086f34bd-12d9-40a4-919d-9c36a4089e8b@onemain.com>
Date: Wed, 23 Jul 2025 11:13:37 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build
 environment
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
 leon@kernel.org, andrew+netdev@lunn.ch
Cc: allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-15-abhijit.gangurde@amd.com>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <20250723173149.2568776-15-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 10:31 AM, Abhijit Gangurde wrote:
> Add ionic to the kernel build environment.
>
> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
> v2->v3
>    - Removed select of ethernet driver
>    - Fixed make htmldocs error
>
>   .../device_drivers/ethernet/index.rst         |  1 +
>   .../ethernet/pensando/ionic_rdma.rst          | 43 +++++++++++++++++++
>   MAINTAINERS                                   |  9 ++++
>   drivers/infiniband/Kconfig                    |  1 +
>   drivers/infiniband/hw/Makefile                |  1 +
>   drivers/infiniband/hw/ionic/Kconfig           | 15 +++++++
>   drivers/infiniband/hw/ionic/Makefile          |  9 ++++
>   7 files changed, 79 insertions(+)
>   create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>   create mode 100644 drivers/infiniband/hw/ionic/Kconfig
>   create mode 100644 drivers/infiniband/hw/ionic/Makefile
>
> diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
> index 139b4c75a191..4b16ecd289da 100644
> --- a/Documentation/networking/device_drivers/ethernet/index.rst
> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> @@ -50,6 +50,7 @@ Contents:
>      neterion/s2io
>      netronome/nfp
>      pensando/ionic
> +   pensando/ionic_rdma
>      smsc/smc9
>      stmicro/stmmac
>      ti/cpsw
> diff --git a/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
> new file mode 100644
> index 000000000000..80c4d9876d3e
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
> @@ -0,0 +1,43 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +============================================================
> +Linux Driver for the AMD Pensando(R) Ethernet adapter family
> +============================================================
> +
> +AMD Pensando RDMA driver.
> +Copyright (C) 2018-2025, Advanced Micro Devices, Inc.
> +
> +Contents
> +========
> +
> +- Identifying the Adapter
> +- Enabling the driver
> +- Support
> +
> +Identifying the Adapter
> +=======================
> +
> +See Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
> +for more information on identifying the adapter.
> +
> +Enabling the driver
> +===================
> +
> +The driver is enabled via the standard kernel configuration system,
> +using the make command::
> +
> +  make oldconfig/menuconfig/etc.
> +
> +The driver is located in the menu structure at:
> +
> +  -> Device Drivers
> +    -> InfiniBand support
> +      -> AMD Pensando DSC RDMA/RoCE Support

Please add some verbage about this being an auxiliary_device dependent 
on the ionic driver, and that it can be disabled/enab led with a devlink 
command.

sln


> +
> +Support
> +=======
> +
> +For general Linux rdma support, please use the rdma mailing
> +list, which is monitored by AMD Pensando personnel::
> +
> +  linux-rdma@vger.kernel.org
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b4f3fa14ddca..f52409bde673 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1165,6 +1165,15 @@ F:	Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
>   F:	drivers/net/ethernet/amd/pds_core/
>   F:	include/linux/pds/
>   
> +AMD PENSANDO RDMA DRIVER
> +M:	Abhijit Gangurde <abhijit.gangurde@amd.com>
> +M:	Allen Hubbe <allen.hubbe@amd.com>
> +L:	linux-rdma@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
> +F:	drivers/infiniband/hw/ionic/
> +F:	include/uapi/rdma/ionic-abi.h
> +
>   AMD PMC DRIVER
>   M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index 3a394cd772f6..f0323f1d6f01 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -85,6 +85,7 @@ source "drivers/infiniband/hw/efa/Kconfig"
>   source "drivers/infiniband/hw/erdma/Kconfig"
>   source "drivers/infiniband/hw/hfi1/Kconfig"
>   source "drivers/infiniband/hw/hns/Kconfig"
> +source "drivers/infiniband/hw/ionic/Kconfig"
>   source "drivers/infiniband/hw/irdma/Kconfig"
>   source "drivers/infiniband/hw/mana/Kconfig"
>   source "drivers/infiniband/hw/mlx4/Kconfig"
> diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
> index df61b2299ec0..b706dc0d0263 100644
> --- a/drivers/infiniband/hw/Makefile
> +++ b/drivers/infiniband/hw/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
>   obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
>   obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
>   obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
> +obj-$(CONFIG_INFINIBAND_IONIC)		+= ionic/
> diff --git a/drivers/infiniband/hw/ionic/Kconfig b/drivers/infiniband/hw/ionic/Kconfig
> new file mode 100644
> index 000000000000..de6f10e9b6e9
> --- /dev/null
> +++ b/drivers/infiniband/hw/ionic/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2018-2025, Advanced Micro Devices, Inc.
> +
> +config INFINIBAND_IONIC
> +	tristate "AMD Pensando DSC RDMA/RoCE Support"
> +	depends on NETDEVICES && ETHERNET && PCI && INET && IONIC
> +	help
> +	  This enables RDMA/RoCE support for the AMD Pensando family of
> +	  Distributed Services Cards (DSCs).
> +
> +	  To learn more, visit our website at
> +	  <https://www.amd.com/en/products/accelerators/pensando.html>.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called ionic_rdma.
> diff --git a/drivers/infiniband/hw/ionic/Makefile b/drivers/infiniband/hw/ionic/Makefile
> new file mode 100644
> index 000000000000..957973742820
> --- /dev/null
> +++ b/drivers/infiniband/hw/ionic/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ccflags-y :=  -I $(srctree)/drivers/net/ethernet/pensando/ionic
> +
> +obj-$(CONFIG_INFINIBAND_IONIC)	+= ionic_rdma.o
> +
> +ionic_rdma-y :=	\
> +	ionic_ibdev.o ionic_lif_cfg.o ionic_queue.o ionic_pgtbl.o ionic_admin.o \
> +	ionic_controlpath.o ionic_datapath.o ionic_hw_stats.o


