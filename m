Return-Path: <linux-rdma+bounces-12444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460FAB0FA03
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 20:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677DD17F9C3
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCEC223DDF;
	Wed, 23 Jul 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O7SH2ghI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134D2E36F0;
	Wed, 23 Jul 2025 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294251; cv=none; b=V+l7k9nj+zF5iNZXe405hrO4HeRdzrAJSGeV3l08fW5I8hfYKDc36xBHuBzLTyAlCFP5TCj9aj+RjHzTM2G1RCGknHSOlgmG6JLW7ss3rmOpwP41lwWBXV0Pie5VxF980LIWE5iXfd/c6xPxDl/ntf/Uy2yZFcwQ+1DuSj1vo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294251; c=relaxed/simple;
	bh=tKNJjaAqhMlo0SUQGs+ceDgPqde7WpwhfupbI7Mb4wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjA8RJXrUS2rBffobb/scxBI2BWfl3QcfxYFHuuxamif/W011tWLHNJKhXzlMFO/rr5RYQkgby13YztErvuUsk+vgA8cp1Qnjyxb7oIFnfm195yUy1Ab+JA7pDFiMVY/7RVMbiSG6HYP1Soclx+S9//1D0GphJ4qjf0rGQfa42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O7SH2ghI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=e7yAQVKufsGUq0RlWkmXXT76VJ5Jz8/4Modn4AF3l8Y=; b=O7SH2ghIeyJ4J07Wq82Am6kIXg
	mCZtwEIIPos7eogVB5F4K5ZUsUNFNft08J0nNKY92wMJ5T8msMb5f+Fxyb2zR9WiWXNg93VFKhzF1
	U1F3SUG0OSdJ5eVblMhR6L910dsJzBHA4SPi3xnoWQDBSzG6FhFKHkB8nLZ3AUtAYtmBD5cyGnZ/T
	Lhl3eBBKAym8Hd1B+gO7bH9EZwbxDPR0zp0Bhv/NNjlmVRNqdA973OVYO2o9x4vor9H+2JPKuq8Ap
	l7D+ZM1w9f4ehGy7/X/qD/bzfmN5YUZ3nirX5+kIm25iSEDX9Q0DcYTwrjXi92na9Jm1d8l/0Rrbt
	PGOtSY3g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uedvQ-00000005ifW-2wT6;
	Wed, 23 Jul 2025 18:10:44 +0000
Message-ID: <62345993-46bb-48d9-853b-09a82b03edaf@infradead.org>
Date: Wed, 23 Jul 2025 11:10:43 -0700
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
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250723173149.2568776-15-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/25 10:31 AM, Abhijit Gangurde wrote:
> Add ionic to the kernel build environment.
> 
> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
> v2->v3
>   - Removed select of ethernet driver
>   - Fixed make htmldocs error
> 
>  .../device_drivers/ethernet/index.rst         |  1 +
>  .../ethernet/pensando/ionic_rdma.rst          | 43 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++++
>  drivers/infiniband/Kconfig                    |  1 +
>  drivers/infiniband/hw/Makefile                |  1 +
>  drivers/infiniband/hw/ionic/Kconfig           | 15 +++++++
>  drivers/infiniband/hw/ionic/Makefile          |  9 ++++
>  7 files changed, 79 insertions(+)
>  create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
>  create mode 100644 drivers/infiniband/hw/ionic/Kconfig
>  create mode 100644 drivers/infiniband/hw/ionic/Makefile
> 

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

Please try to differentiate the title of this driver from that of
the Pensando ethernet driver:

========================================================
Linux Driver for the Pensando(R) Ethernet adapter family
========================================================

Thanks.

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
> +
> +Support
> +=======
> +
> +For general Linux rdma support, please use the rdma mailing
> +list, which is monitored by AMD Pensando personnel::
> +
> +  linux-rdma@vger.kernel.org


-- 
~Randy


