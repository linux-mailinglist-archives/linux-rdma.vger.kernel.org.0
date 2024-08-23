Return-Path: <linux-rdma+bounces-4518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C295CFD9
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5F5286E79
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E918BBB6;
	Fri, 23 Aug 2024 14:14:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54977185945;
	Fri, 23 Aug 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422458; cv=none; b=bL5XO4FV+T9Ze8Y3TxjS5WSTzW7uVN+IBqMo4HkiwXfLQzDgk5QgcskYotNShsRNGwJv5rSKD9uI8ghw8aEzZb6BGfx2ncV0OgRUU3KLQfnspeoaWXoQ5scWA9t+hCoKpFqw9WCUb/W3QCZiCi0+w6dUf99seOSkdkTA24sSwkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422458; c=relaxed/simple;
	bh=iMZNmgoaM+JAvvT971xQl/qlZv1rJVduCW2DtCa+Htc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcK5ZG9I3MsPkkCIlqlP1q3ncE8n8j78APKltIvBbWZkBxIAWJ4CMfXnu4zHZPqO2++NVztxOzg2QtQaFFc0IHc7UBARwwkkDWkpP4YF1oL5jezmKFcegJVJSjwyUNAjBc5slEqEz3B2LXlj2ZdXlJpfP3CNWE9qWFybjIohStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr26b4lGkz6K93W;
	Fri, 23 Aug 2024 22:11:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B363140B2A;
	Fri, 23 Aug 2024 22:14:12 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 15:14:12 +0100
Date: Fri, 23 Aug 2024 15:14:11 +0100
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
Subject: Re: [PATCH v3 03/10] fwctl: FWCTL_INFO to return basic information
 about the device
Message-ID: <20240823151411.00004b30@Huawei.com>
In-Reply-To: <3-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
	<3-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Aug 2024 15:10:55 -0300
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
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Just one minor question: How likely is the data being passed back
from the driver to be const?  Feels like it might be and should
be easy enough to support either const or not.

Either way, LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index ca4245825e91bf..6b596931a55169 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -7,6 +7,7 @@
>  #include <linux/device.h>
>  #include <linux/cdev.h>
>  #include <linux/cleanup.h>
> +#include <uapi/fwctl/fwctl.h>
>  
>  struct fwctl_device;
>  struct fwctl_uctx;
> @@ -19,6 +20,10 @@ struct fwctl_uctx;
>   * it will block device hot unplug and module unloading.
>   */
>  struct fwctl_ops {
> +	/**
> +	 * @device_type: The drivers assigned device_type number. This is uABI.
> +	 */
> +	enum fwctl_device_type device_type;
>  	/**
>  	 * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
>  	 * bytes of this memory will be a fwctl_uctx. The driver can use the
> @@ -35,6 +40,13 @@ struct fwctl_ops {
>  	 * is closed.
>  	 */
>  	void (*close_uctx)(struct fwctl_uctx *uctx);
> +	/**
> +	 * @info: Implement FWCTL_INFO. Return a kmalloc() memory that is copied
> +	 * to out_device_data. On input length indicates the size of the user
> +	 * buffer on output it indicates the size of the memory. The driver can
> +	 * ignore length on input, the core code will handle everything.
> +	 */

Maybe it's worth supporting const data as well?

> +	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
>  };
>  
>  /**



