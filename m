Return-Path: <linux-rdma+bounces-7515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74CCA2C340
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 14:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537CB16AFA4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD11EE7B1;
	Fri,  7 Feb 2025 13:06:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA31E1A23;
	Fri,  7 Feb 2025 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933608; cv=none; b=bg2ZM0lJunlTFENAAWgrGH/NLqfQ3o6AbGjGv8Y7DoCG/UNA4IKagGcbJi2TUna3vpvBwzZRoLh4Sj7nOSqCISDIbxLFjWOcGv+Whv1HBfUqcTzkyGyuhX+/LLyNOzpswnxGY8XqkZBozvyLvsLHTtl8VcjQCYWU9CinMh0ull4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933608; c=relaxed/simple;
	bh=D7RNcAAO05N1HIIZezFPcpHocutqTqQ2WqDfdpexqi8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7wqMlOjYpPnFn38EnK3i8Nr2U+rmxsXhGgK3zf3tycIuKHQ2bfP6/eovIE2NRqh57K0mrY/P6KYEDTBn0KqiZ0ngjgYeywSIcm47NmuYmktqGnW8yZCrQyHafqzdDzUYycIsNpPRsvYsfvQ5cGede18S8/Bzbun8xY206PsiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqDjf5vc6z6HJbd;
	Fri,  7 Feb 2025 21:05:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EC9E0140A30;
	Fri,  7 Feb 2025 21:06:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Feb
 2025 14:06:43 +0100
Date: Fri, 7 Feb 2025 13:06:41 +0000
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
Subject: Re: [PATCH v4 03/10] fwctl: FWCTL_INFO to return basic information
 about the device
Message-ID: <20250207130641.00005cb9@huawei.com>
In-Reply-To: <3-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<3-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Feb 2025 20:13:25 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Userspace will need to know some details about the fwctl interface being
> used to locate the correct userspace code to communicate with the
> kernel. Provide a simple device_type enum indicating what the kernel
> driver is.
> 
> Allow the device to provide a device specific info struct that contains
> any additional information that the driver may need to provide to
> userspace.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Trivial comment inline.


> ---
>  drivers/fwctl/main.c       | 51 ++++++++++++++++++++++++++++++++++++++
>  include/linux/fwctl.h      | 12 +++++++++
>  include/uapi/fwctl/fwctl.h | 32 ++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index d561deaf2b86d8..4b6792f2031e86 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -27,8 +27,58 @@ struct fwctl_ucmd {


> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index f4718a6240f281..ac66853200a5a8 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -4,6 +4,9 @@
>  #ifndef _UAPI_FWCTL_H
>  #define _UAPI_FWCTL_H
>  
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
>  #define FWCTL_TYPE 0x9A
>  
>  /**
> @@ -33,6 +36,35 @@
>   */
>  enum {
>  	FWCTL_CMD_BASE = 0,
> +	FWCTL_CMD_INFO = 0,
> +	FWCTL_CMD_RPC = 1,

Trivial but in theory should perhaps leave RPC for patch 5?

>  };



