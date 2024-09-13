Return-Path: <linux-rdma+bounces-4942-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F38978B72
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 00:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC363285216
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EEB158A2E;
	Fri, 13 Sep 2024 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imdnZiVR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CFD502;
	Fri, 13 Sep 2024 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267202; cv=none; b=r/OAq9tIUsajohUshTpUH0jSc6DtK1crqEiN3pmCj8UEi2jA73D6HbP1gIOe06sZ67PKVDOwscYcdoMuHqfDTANw5SIV5wbQmjHrSVzEteMeGbBxviTrc9gLGBJpjBOVqcRo7zVHNE/zKVmJpeKF20FI1XHS0nXF7wwexB3PKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267202; c=relaxed/simple;
	bh=JVylM2s0zxtVpYDuu0OuZUQXmSd6j/OJ4jwfmBC//i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huJ+H2a60eKAZOzT++cwHDp4n1QKwVojXH86h/iiiXx/6ED1LXN5C5PdR10zHifRHb/RCwEv8b6G4TtOUuLTNEHDVzo4WZUw8JP0x3//P9VfjrMP67JWR74gVTZentLD5R6HR2q90IDKeFrZBA+kizwBypMS+l44upMEaTlqTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imdnZiVR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726267200; x=1757803200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JVylM2s0zxtVpYDuu0OuZUQXmSd6j/OJ4jwfmBC//i4=;
  b=imdnZiVRYTg1QUIcvv/z53gHHOZhGq5B4LoGjEI7gWrfn7k+JgXdNR0C
   VdzcI0JE/+vytPhSa3oGuWRcRTPxQfNwPW6uST2dVPL5RPx26dhzN/2i1
   LiOYvMTuEHRSwe+rWA3lyT9JYUxfs8QCyIM8xG7z6LGbk0hPJLaxHEGwe
   hgnbh2muNFzbHybE6BDO7wqpNuKM+hmS4YMb26vqi9VWoO1ZEdtPyI5aw
   /cQ7KIoaVj9h+4xPyuF+cfxTm2MdBqMtnoC2JB/C8OB7OKU3dyYCXk2Gd
   BTxucR5nNZ3THsvwMPHn8fjxFh7uJRrmQrdjzLrlS7tJ/9iWxeXZRFO8N
   Q==;
X-CSE-ConnectionGUID: s88W8ryKT+ucqSV51onIPw==
X-CSE-MsgGUID: zRbzFHeCR0ikFrYx9fEORw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28095966"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="28095966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 15:40:00 -0700
X-CSE-ConnectionGUID: X3e292kgTOirRQEJSxxNtg==
X-CSE-MsgGUID: kWazInGYQYGQMDRwbAxZvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="91487691"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.177]) ([10.125.108.177])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 15:39:58 -0700
Message-ID: <8029e786-d693-4002-9dba-b45f9bb4acb1@intel.com>
Date: Fri, 13 Sep 2024 15:39:57 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Introduce fwctl subystem
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, David Ahern <dsahern@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/24 11:10 AM, Jason Gunthorpe wrote:
> fwctl is a new subsystem intended to bring some common rules and order to
> the growing pattern of exposing a secure FW interface directly to
> userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
> exposing a device for datapath operations fwctl is focused on debugging,
> configuration and provisioning of the device. It will not have the
> necessary features like interrupt delivery to support a datapath.
> 
> This concept is similar to the long standing practice in the "HW" RAID
> space of having a device specific misc device to manager the RAID
> controller FW. fwctl generalizes this notion of a companion debug and
> management interface that goes along with a dataplane implemented in an
> appropriate subsystem.
> 
> The need for this has reached a critical point as many users are moving to
> run lockdown enabled kernels. Several existing devices have had long
> standing tooling for management that relied on /sys/../resource0 or PCI
> config space access which is not permitted in lockdown. A major point of
> fwctl is to define and document the rules that a device must follow to
> expose a lockdown compatible RPC.
> 
> Based on some discussion fwctl splits the RPCs into four categories
> 
> 	FWCTL_RPC_CONFIGURATION
> 	FWCTL_RPC_DEBUG_READ_ONLY
> 	FWCTL_RPC_DEBUG_WRITE
> 	FWCTL_RPC_DEBUG_WRITE_FULL
> 
> Where the latter two trigger a new TAINT_FWCTL, and the final one requires
> CAP_SYS_RAWIO - excluding it from lockdown. The device driver and its FW
> would be responsible to restrict RPCs to the requested security scope,
> while the core code handles the tainting and CAP checks.
> 
> For details see the final patch which introduces the documentation.
> 
> This series incorporates a version of the mlx5ctl interface previously
> proposed:
>   https://lore.kernel.org/r/20240207072435.14182-1-saeed@kernel.org/
> 
> For this series the memory registration mechanism was removed, but I
> expect it will come back.
> 
> It also includes the FWCL driver series from David:
>   https://lore.kernel.org/all/20240718213446.1750135-1-dave.jiang@intel.com/
> 
> 
> This is still waiting a 3rd fwctl driver and the CXL side to finish some
> of its development. The github has the necessary CXL precursor patches.
> 
> There have been two LWN articles written discussing various aspects of
> this proposal:
> 
>  https://lwn.net/Articles/955001/
>  https://lwn.net/Articles/969383/
> 
> And a really giant ksummit thread:
> 
>  https://lore.kernel.org/ksummit/668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Several have expressed general support for this concept:
> 
>  Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
>  Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org/
>  Daniel Vetter - https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
>  Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org/
>  NVIDIA Networking
>  Oded Gabbay/Habana - https://lore.kernel.org/r/ZrMl1bkPP-3G9B4N@T14sgabbay.
>  Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq
>  SuSE/Hannes - https://lore.kernel.org/r/2fd48f87-2521-4c34-8589-dbb7e91bb1c8@suse.com
> 
> Work is ongoing for a robust multi-device open source userspace, currently
> the mlx5ctl_user that was posted by Saeed has been updated to use fwctl.
> 
>   https://github.com/saeedtx/mlx5ctl.git
>   https://github.com/jgunthorpe/mlx5ctl.git
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/fwctl
> 
> v3:
>  - Rebase to v6.11-rc4
>  - Add a squashed version of David's CXL series as the 2nd driver
>  - Add missing includes
>  - Improve comments based on feedback
>  - Use the kdoc format that puts the member docs inside the struct
>  - Rewrite fwctl_alloc_device() to be clearer
>  - Incorporate all remarks for the documentation
> v2: https://lore.kernel.org/r/0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com
>  - Rebase to v6.10-rc5
>  - Minor style changes
>  - Follow the style consensus for the guard stuff
>  - Documentation grammer/spelling
>  - Add missed length output for mlx5 get_info
>  - Add two more missed MLX5 CMD's
>  - Collect tags
> v1: https://lore.kernel.org/r/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> 
> Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Cc: Aron Silverton <aron.silverton@oracle.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Itay Avraham <itayavr@nvidia.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: Leonid Bloch <lbloch@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Dave Jiang (1):
>   fwctl/cxl: Add driver for CXL mailbox for handling CXL features
>     commands (RFC)
> 
> Jason Gunthorpe (7):
>   fwctl: Add basic structure for a class subsystem with a cdev
>   fwctl: Basic ioctl dispatch for the character device
>   fwctl: FWCTL_INFO to return basic information about the device
>   taint: Add TAINT_FWCTL
>   fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
>   fwctl: Add documentation
>   cxl: Create an auxiliary device for fwctl_cxl
> 
> Saeed Mahameed (2):
>   fwctl/mlx5: Support for communicating with mlx5 fw
>   mlx5: Create an auxiliary device for fwctl_mlx5
> 
>  Documentation/admin-guide/tainted-kernels.rst |   5 +
>  Documentation/userspace-api/fwctl.rst         | 285 ++++++++++++
>  Documentation/userspace-api/index.rst         |   1 +
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |  23 +
>  drivers/Kconfig                               |   2 +
>  drivers/Makefile                              |   1 +
>  drivers/cxl/core/memdev.c                     |  19 +
>  drivers/fwctl/Kconfig                         |  32 ++
>  drivers/fwctl/Makefile                        |   6 +
>  drivers/fwctl/cxl/Makefile                    |   4 +
>  drivers/fwctl/cxl/cxl.c                       | 274 ++++++++++++
>  drivers/fwctl/main.c                          | 414 ++++++++++++++++++
>  drivers/fwctl/mlx5/Makefile                   |   4 +
>  drivers/fwctl/mlx5/main.c                     | 337 ++++++++++++++
>  drivers/net/ethernet/mellanox/mlx5/core/dev.c |   8 +
>  include/linux/cxl/mailbox.h                   | 104 +++++
>  include/linux/fwctl.h                         | 135 ++++++
>  include/linux/panic.h                         |   3 +-
>  include/uapi/fwctl/cxl.h                      |  94 ++++
>  include/uapi/fwctl/fwctl.h                    | 140 ++++++
>  include/uapi/fwctl/mlx5.h                     |  36 ++
>  kernel/panic.c                                |   1 +
>  tools/debugging/kernel-chktaint               |   8 +
>  24 files changed, 1936 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/userspace-api/fwctl.rst
>  create mode 100644 drivers/fwctl/Kconfig
>  create mode 100644 drivers/fwctl/Makefile
>  create mode 100644 drivers/fwctl/cxl/Makefile
>  create mode 100644 drivers/fwctl/cxl/cxl.c
>  create mode 100644 drivers/fwctl/main.c
>  create mode 100644 drivers/fwctl/mlx5/Makefile
>  create mode 100644 drivers/fwctl/mlx5/main.c
>  create mode 100644 include/linux/fwctl.h
>  create mode 100644 include/uapi/fwctl/cxl.h
>  create mode 100644 include/uapi/fwctl/fwctl.h
>  create mode 100644 include/uapi/fwctl/mlx5.h
> 
> 
> base-commit: cd0c76bee95e9c2092418523599439d2c8dbff7e

Hi Jason,
Which base-commit is this? I'm not finding the hash in the upstream tree. I'm having trouble applying the series against 6.10 or 6.11-rc7 via b4. 

