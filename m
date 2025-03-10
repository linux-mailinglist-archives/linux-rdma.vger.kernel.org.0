Return-Path: <linux-rdma+bounces-8539-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D4A5A4ED
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 21:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FCA1891693
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 20:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8A71DE4CC;
	Mon, 10 Mar 2025 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxelR1C/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73BF1DDA09;
	Mon, 10 Mar 2025 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638442; cv=none; b=jceEnBtV78JrQjFkycYj0ohvLjT0lkkQLacZS2RSn12uOP5yTTW3OKIF2sxforrXhWyaRw1KuE8xu8QB27/BSUCXNxNAv/LhRdsRdFGxaqM3Xjv0otGYH6R9eYGGrVhn3yuM+aWzBCdYZTbGdn6PCET4VSMaqhdDjlzsDlLdP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638442; c=relaxed/simple;
	bh=/kz9J001nUCJ1TInU9c7H+CswaI1MEjTlNKpcpq1z8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqqBqRULpAVDb+IO0Jlg/ZleblMPfmxQr65gX0yupm9rgPY5uCFUBpGnM2Gv0dfsUpPVpJmcQeXSR5qqxeWYmm3VZhDuXwNDoFZ+26bDL8uAJevJlPeHiv4SCejBjl3bPlp46hY6YzMTvhlYHkoCYU4vbsa5vn1H5OYzSZ+U6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxelR1C/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741638441; x=1773174441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/kz9J001nUCJ1TInU9c7H+CswaI1MEjTlNKpcpq1z8c=;
  b=BxelR1C/ZHf6LRuNYI6EyIV7au6yFfmNZfvNjNJzAtkQ57MyiryLh9s8
   vo/v5ua6KUqaGbQBmQZYAjQ97fyJfdjV50o5sO4CGTGiFL0S2EaKmKfxR
   XXLnQINeZxObhLMWuoRdlKuFGSyDhwjRcfcpZKcxx7stPACLJg/PNtqB8
   a7yqtdmxQa0oesll6HOgDdxeG0yvDwmMGvebFTSA/lJfuXgrcufGr5UsC
   P6ra92NU6iRWtzDI9B0QCjLQ4rwkZY6kvOviJ2NZy/80U6azI+1P6IYQj
   14l2V6GuZ5ENj2kKqcpkMRftlazkASYT2SdH/pAqxI5OT0wY8CDRV1oI0
   g==;
X-CSE-ConnectionGUID: 8FfhGRwzQEWGEUaHa/P9og==
X-CSE-MsgGUID: PKe7omp8Qt6mZjeaYmu3RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="30229720"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="30229720"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 13:27:19 -0700
X-CSE-ConnectionGUID: GHxaZoHHRsKjuwlzRHBtxw==
X-CSE-MsgGUID: uk8CqsdMSyeoXL2SGEupmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="120988504"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 13:27:19 -0700
Message-ID: <ce0c9c98-c507-40c1-8bd5-5fe37ba624f6@intel.com>
Date: Mon, 10 Mar 2025 13:27:17 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] pds_fwctl: add Documentation entries
To: Shannon Nelson <shannon.nelson@amd.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-7-shannon.nelson@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250307185329.35034-7-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 11:53 AM, Shannon Nelson wrote:
> Add pds_fwctl to the driver and fwctl documentation pages.
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
>  Documentation/userspace-api/fwctl/index.rst   |  1 +
>  .../userspace-api/fwctl/pds_fwctl.rst         | 40 +++++++++++++++++++
>  3 files changed, 42 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
> index 04ad78a7cd48..fdcfe418a83f 100644
> --- a/Documentation/userspace-api/fwctl/fwctl.rst
> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
> @@ -150,6 +150,7 @@ fwctl User API
>  
>  .. kernel-doc:: include/uapi/fwctl/fwctl.h
>  .. kernel-doc:: include/uapi/fwctl/mlx5.h
> +.. kernel-doc:: include/uapi/fwctl/pds.h
>  
>  sysfs Class
>  -----------
> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
> index d9d40a468a31..316ac456ad3b 100644
> --- a/Documentation/userspace-api/fwctl/index.rst
> +++ b/Documentation/userspace-api/fwctl/index.rst
> @@ -11,3 +11,4 @@ to securely construct and execute RPCs inside device firmware.
>  
>     fwctl
>     fwctl-cxl
> +   pds_fwctl
> diff --git a/Documentation/userspace-api/fwctl/pds_fwctl.rst b/Documentation/userspace-api/fwctl/pds_fwctl.rst
> new file mode 100644
> index 000000000000..e8a63d4215d0
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
> @@ -0,0 +1,40 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +fwctl pds driver
> +================
> +
> +:Author: Shannon Nelson
> +
> +Overview
> +========
> +
> +The PDS Core device makes an fwctl service available through an

s/an fwctl/a fwctl/

> +auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds to
> +this device and registers itself with the fwctl subsystem.  The resulting
> +userspace interface is used by an application that is a part of the
> +AMD/Pensando software package for the Distributed Service Card (DSC).
> +
> +The pds_fwctl driver has little knowledge of the firmware's internals,
> +only knows how to send commands through pds_core's message queue to the
s/ , only/. It only/

> +firmware for fwctl requests.  The set of fwctl operations available
> +depends on the firmware in the DSC, and the userspace application
> +version must match the firmware so that they can talk to each other.
> +
> +When a connection is created the pds_fwctl driver requests from the
> +firmware a list of firmware object endpoints, and for each endpoint the
> +driver requests a list of operations for the endpoint.  Each operation
> +description includes a minimum scope level that the pds_fwctl driver can
> +use for filtering privilege levels.

Maybe a bit more details on the privilege levels?

> +
> +pds_fwctl User API
> +==================
> +
> +.. kernel-doc:: include/uapi/fwctl/pds.h
> +
> +Each RPC request includes the target endpoint and the operation id, and in
> +and out buffer lengths and pointers.  The driver verifies the existence
> +of the requested endpoint and operations, then checks the current scope
s/then/and then it/

> +against the required scope of the operation.  The request is then put
> +together with the request data and sent through pds_core's message queue
> +to the firmware, and the results are returned to the caller.

May be a good idea to touch on each of the ioctls being exported as well as maybe provide some sample user code on how to perform the RPCs. This documentation should serve as a guide to an application programmer on how to write the user application that accesses the fwctl char dev. 


