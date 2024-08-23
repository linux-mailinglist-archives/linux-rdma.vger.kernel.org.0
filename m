Return-Path: <linux-rdma+bounces-4520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B07D95D02C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F8BB2431C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5D118A6A0;
	Fri, 23 Aug 2024 14:35:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DFC18453C;
	Fri, 23 Aug 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423723; cv=none; b=g0tzIhtcs57bPojtoTbDNQR2gx/e6dQdZXTw3+IoS3kMZwFECoAUoC8Tana4/Wj3CNz8DxVH8QC6ihjPQ9t81yw7tc1vHC273+h6ywA/hg1REJvP2106fYVLQ0ApZGElJpIameqSFJ0B09frtvWZXlHBABeVsvWl7OWHXyvD1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423723; c=relaxed/simple;
	bh=pBL3ap7bMgMjYKLDZVHWrfgYzXV6+h/J6k6ee6lAWx4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFDW+3KQ8FuzdgryyNnJyR4dxLsJmJ/KXqNZcc2ezW7ZImt+o75LnUXuRbi6Ms7dUTu2tmSGOR0nrEJ90yQjAQRlBKAtPp4kx0MASxFrV0pmsQ2phe4DaDcQDyYUh2Ex25ws2KFPbZioIiw0h3sWFOE8dHOUqcX95/kIktJta+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr2Zy3Bxdz6K93W;
	Fri, 23 Aug 2024 22:32:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 32127140447;
	Fri, 23 Aug 2024 22:35:15 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 15:35:14 +0100
Date: Fri, 23 Aug 2024 15:35:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Daniel
 Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, David
 Ahern <dsahern@kernel.org>, "Greg Kroah-Hartman"
	<gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Itay
 Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 06/10] fwctl: Add documentation
Message-ID: <20240823153513.00000499@Huawei.com>
In-Reply-To: <6-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
	<6-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Aug 2024 15:10:58 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Document the purpose and rules for the fwctl subsystem.
> 
> Link in kdocs to the doc tree.
> 
> Nacked-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Just one trivial plural / singular comment.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/userspace-api/fwctl.rst | 285 ++++++++++++++++++++++++++
>  Documentation/userspace-api/index.rst |   1 +
>  2 files changed, 286 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl.rst b/Documentation/userspace-api/fwctl.rst
> new file mode 100644
> index 00000000000000..8f3da30ee7c91b
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl.rst
> @@ -0,0 +1,285 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +fwctl subsystem
> +===============
> +
> +:Author: Jason Gunthorpe
> +
> +Overview
> +========
> +
> +Modern devices contain extensive amounts of FW, and in many cases, are largely
> +software-defined pieces of hardware. The evolution of this approach is largely a
> +reaction to Moore's Law where a chip tape out is now highly expensive, and the
> +chip design is extremely large. Replacing fixed HW logic with a flexible and
> +tightly coupled FW/HW combination is an effective risk mitigation against chip
> +respin. Problems in the HW design can be counteracted in device FW. This is
> +especially true for devices which present a stable and backwards compatible
> +interface to the operating system driver (such as NVMe).
> +
> +The FW layer in devices has grown to incredible sizes and devices frequently
incredible size
(tricky to get the plurals right in this sentence, but currently its a mixture)
> +integrate clusters of fast processors to run it. For example, mlx5 devices have
> +over 30MB of FW code, and big configurations operate with over 1GB of FW managed
> +runtime state.
...


