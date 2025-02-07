Return-Path: <linux-rdma+bounces-7520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4E3A2C5BE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 15:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712803A4506
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416ED23ED7D;
	Fri,  7 Feb 2025 14:42:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC392206A0;
	Fri,  7 Feb 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939377; cv=none; b=dsrlclBRtNO6x8OVIZi7dLtR+jhx+LGEjHLwniLX2MrLafR/YNwpvsM2kNfuE/3D6usO1I/Ab/T7R5/59lH/z/KpcK8N2EpieeqeXZxN4t2vztVeoqby7C8dZ7tpLxw8SMkNqtUunP3vhKrg2BQvtg2f3RzCQZ2HziJaZv4G2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939377; c=relaxed/simple;
	bh=hTAH9CDVAVmikUCkkTbmfxcvKGpyCVE3UYAyXb3D7BY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEj5tzbXalrKautnkCaIsRhzZ7PPrY3Ligz/nnhnTIlEeoPoXghBRfM8JIX1GYsKEEEwd3/wtr6ZehoAP7IsdCil/pAVp/CWVrTG8w5i2vy60NFsE8nDRopyMcWPwfuH54hj9musKNEwttljYB/g5XBDvz8yLdvOCWWu/YYofUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGpZ1nVXz6L5CZ;
	Fri,  7 Feb 2025 22:40:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 35F64140A30;
	Fri,  7 Feb 2025 22:42:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Feb
 2025 15:42:50 +0100
Date: Fri, 7 Feb 2025 14:42:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Daniel
 Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, David
 Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, Christoph
 Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Leonid Bloch
	<lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Nelson,
 Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 06/10] fwctl: Add documentation
Message-ID: <20250207144249.00000521@huawei.com>
In-Reply-To: <6-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<6-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Feb 2025 20:13:28 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Document the purpose and rules for the fwctl subsystem.
> 
> Link in kdocs to the doc tree.
> 
> Nacked-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

A few tiny things inline.

> ---
>  Documentation/userspace-api/fwctl/fwctl.rst | 285 ++++++++++++++++++++
>  Documentation/userspace-api/fwctl/index.rst |  12 +
>  Documentation/userspace-api/index.rst       |   1 +
>  MAINTAINERS                                 |   2 +-
>  4 files changed, 299 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/userspace-api/fwctl/fwctl.rst
>  create mode 100644 Documentation/userspace-api/fwctl/index.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
> new file mode 100644
> index 00000000000000..428f6f5bb9b4f9
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
> @@ -0,0 +1,285 @@

> +Operations exposed through fwctl's non-taining interfaces should be fully
> +sharable with other users of the device. For instance exposing a RPC through
> +fwctl should never prevent a kernel subsystem from also concurrently using that
> +same RPC or hardware unit down the road. In such cases fwctl will be less
> +important than proper kernel subsystems that eventually emerge. Mistakes in this
> +area resulting in clashes will be resolved in favour of a kernel implementation.
> +
> +fwctl User API
> +==============
> +
> +.. kernel-doc:: include/uapi/fwctl/fwctl.h
> +.. kernel-doc:: include/uapi/fwctl/mlx5.h

Doesn't exist yet...  I'm not sure if that actually causes a build issue
or not but probably better to just slip this in later in the series.

> +Development and debugging focused RPCs under more permissive scopes can have
> +less stablitiy if the tools using them are only run under exceptional

stability 

> +circumstances and not for every day use of the device. Debugging tools may even
> +require exact version matching as they may require something similar to DWARF
> +debug information from the FW binary.
> +

...

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f30adbe6c8521..319169f7cb7e1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9561,7 +9561,7 @@ FWCTL SUBSYSTEM
>  M:	Jason Gunthorpe <jgg@nvidia.com>
>  M:	Saeed Mahameed <saeedm@nvidia.com>
>  S:	Maintained
> -F:	Documentation/userspace-api/fwctl.rst
> +F:	Documentation/userspace-api/fwctl/

Push back to patch 1 or introduce this here for the first time.

>  F:	drivers/fwctl/
>  F:	include/linux/fwctl.h
>  F:	include/uapi/fwctl/


