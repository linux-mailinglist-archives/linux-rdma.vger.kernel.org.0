Return-Path: <linux-rdma+bounces-4019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5611B93D5C8
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41DD1F243CB
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49111BC46;
	Fri, 26 Jul 2024 15:15:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB317838B;
	Fri, 26 Jul 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006910; cv=none; b=q2oGZTboFfLEA0uzC0yCyxx9N71u9SrgzXdJJ4xN/MmsTbaKfRwOpzzpcpdfuH9boaJU5gRiAKQrRzDZ5sjWJrGjP8OxqjG4rA/Ios2wWMFIqxZHM1N7yGeJzEsd3KrV1GhhyJ2V9BBjafSW03eoKUVHmjkziY/BZ/207NI9HJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006910; c=relaxed/simple;
	bh=GOS5OzmoM+mCYghAchIDjKEcmg9M9uoWCw0h6GVOPwk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KM2ryyNrZe/yQwNYDxMS0Hgd+UFEQJkxBytUjX032rKRCCCJVrbbLQAvRq3DW15XEU/wTPDoRlBMaWwlM4q754+AISZr3mM2Hwzb/IVuladCBlg+N5eFDAdZggdt6kybiSCWlgC89xioyB6IY7k0UaIuDdFVXuxP5VvXCZZ0Sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVrpm2b2vz6K6Kl;
	Fri, 26 Jul 2024 23:12:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EA632140AB8;
	Fri, 26 Jul 2024 23:15:04 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 16:15:04 +0100
Date: Fri, 26 Jul 2024 16:15:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, Jakub
 Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v2 3/8] fwctl: FWCTL_INFO to return basic information
 about the device
Message-ID: <20240726161503.00001c85@Huawei.com>
In-Reply-To: <3-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<3-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 19:47:27 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Userspace will need to know some details about the fwctl interface being
> used to locate the correct userspace code to communicate with the
> kernel. Provide a simple device_type enum indicating what the kernel
> driver is.

As below - maybe consider a UUID?
Would let you decouple allocating those with upstreaming drivers.
We'll just get annoying races on the enum otherwise as multiple
drivers get upstreamed that use this.

> 
> Allow the device to provide a device specific info struct that contains
> any additional information that the driver may need to provide to
> userspace.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/fwctl/main.c       | 53 ++++++++++++++++++++++++++++++++++++++
>  include/linux/fwctl.h      |  8 ++++++
>  include/uapi/fwctl/fwctl.h | 29 +++++++++++++++++++++
>  3 files changed, 90 insertions(+)
> 
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index 6872c01d5c62e8..f1dec0b590aee4 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -17,6 +17,8 @@ enum {
>  static dev_t fwctl_dev;
>  static DEFINE_IDA(fwctl_ida);
>  
> +DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));

Why need for a new one?  That's the same as the one in slab.h from
6.9 onwards. Before that it was
if (_T)

I was going to suggest promoting this to slab.h and then found
the normal implementation had been improved since I last checked.


>  
>  /**
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 0bdce95b6d69d9..39db9f09f8068e 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -36,6 +36,35 @@
>   */
>  enum {
>  	FWCTL_CMD_BASE = 0,
> +	FWCTL_CMD_INFO = 0,
> +	FWCTL_CMD_RPC = 1,
>  };
>  
> +enum fwctl_device_type {
> +	FWCTL_DEVICE_TYPE_ERROR = 0,
> +};
> +
> +/**
> + * struct fwctl_info - ioctl(FWCTL_INFO)
> + * @size: sizeof(struct fwctl_info)
> + * @flags: Must be 0
> + * @out_device_type: Returns the type of the device from enum fwctl_device_type

Maybe a UUID?  Avoid need to synchronize that list for ever.

> + * @device_data_len: On input the length of the out_device_data memory. On
> + *	output the size of the kernel's device_data which may be larger or
> + *	smaller than the input. Maybe 0 on input.
> + * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
> + *	fill the entire memory, zeroing as required.

Why do we need device in names of these two?

> + *
> + * Returns basic information about this fwctl instance, particularly what driver
> + * is being used to define the device_data format.
> + */
> +struct fwctl_info {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 out_device_type;
> +	__u32 device_data_len;
> +	__aligned_u64 out_device_data;
> +};
> +#define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
> +
>  #endif


