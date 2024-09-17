Return-Path: <linux-rdma+bounces-4978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B158F97B4F5
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2024 22:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77171C2274C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2024 20:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9919148F;
	Tue, 17 Sep 2024 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuMabh1p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45818800E;
	Tue, 17 Sep 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726606757; cv=none; b=QcC8kfJwuGTb9UPXILGAJJqjF3nl2yCbUNidsyQd3JAnHn3wK85Vcm0MfkZB9tFBZD4nlXuBQAs6jIA/NVF42wrMMKG1aNXnyORzW4o6YGa7OLN5j9YzZcDvr3gRd7NVyT1JehCPEtzlOxQsU0HewES80w7KmZy4T+LSivhSPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726606757; c=relaxed/simple;
	bh=y8WiALFhLO0/irzaEXz0qfBTR5z/1xRVyRpdIvoWuBI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JFE/TDdvoo1EY0RSvo5+Q2AKPWekW6S9eTbLiDk8y9t0t6/+RdUBQdH4Y8tpP8ZHlOSkwaPFOE7Ilw6ecE4J9ZiNJwi2ytTvZ2jIVhaDKP675Qu0OLOzxjP/VeD8oLrJ9Q2WNHFX7JKvaWOqs8prX8LrZA6BI8xBJMSgov6VkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuMabh1p; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726606755; x=1758142755;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=y8WiALFhLO0/irzaEXz0qfBTR5z/1xRVyRpdIvoWuBI=;
  b=BuMabh1pqcSRpwYH+ZqqJQKIhGQfp5aIvM+tLf3N23ERaq0F1EHdFfNH
   6sSYrG6t42b6i8TIfFNkJB/g01bn1d8CS7S8cL3U+lSUVvPbFYSTtnk4v
   J2m5Sie53ZbMb/o8eyd98dbaglvwOlJZwtB9gc8ZlYjRpbLq5RbcH+te6
   OLwH4++LvUJZ8M6gr6Nua+86sYjty5GC81+kSWvOIdFXJrstt5osA6JvO
   OtyfQTKsFiN6CWaEzyAhFxW8dEvSyQFB75YevW2/XIGPbMbBPEYnwBYbj
   pmi/0e6GMx15zlF7jSbdvlDc7EHK5+4lJGFtDX5e6bC45r0uMv4mlY6Ow
   A==;
X-CSE-ConnectionGUID: K80TUZzlTs6UtuA1wM18Mw==
X-CSE-MsgGUID: E1Cnn2DCQ1esZ4hnP7CFhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="50903190"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="50903190"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 13:59:14 -0700
X-CSE-ConnectionGUID: 6J88gzamR7mB+c4tZC5McA==
X-CSE-MsgGUID: K+D+2bLGQAGNFHF7lIgjjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="73882512"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.109.120]) ([10.125.109.120])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 13:59:13 -0700
Message-ID: <784c6a4a-bacf-4bd1-8ab2-daa76950c5b3@intel.com>
Date: Tue, 17 Sep 2024 13:59:12 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Introduce fwctl subystem
From: Dave Jiang <dave.jiang@intel.com>
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
 <8029e786-d693-4002-9dba-b45f9bb4acb1@intel.com>
Content-Language: en-US
In-Reply-To: <8029e786-d693-4002-9dba-b45f9bb4acb1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/13/24 3:39 PM, Dave Jiang wrote:
> 
> 
> On 8/21/24 11:10 AM, Jason Gunthorpe wrote:
>> fwctl is a new subsystem intended to bring some common rules and order to
>> the growing pattern of exposing a secure FW interface directly to
>> userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
>> exposing a device for datapath operations fwctl is focused on debugging,
>> configuration and provisioning of the device. It will not have the
>> necessary features like interrupt delivery to support a datapath.
>>
>> This concept is similar to the long standing practice in the "HW" RAID
>> space of having a device specific misc device to manager the RAID
>> controller FW. fwctl generalizes this notion of a companion debug and
>> management interface that goes along with a dataplane implemented in an
>> appropriate subsystem.
>>
>> The need for this has reached a critical point as many users are moving to
>> run lockdown enabled kernels. Several existing devices have had long
>> standing tooling for management that relied on /sys/../resource0 or PCI
>> config space access which is not permitted in lockdown. A major point of
>> fwctl is to define and document the rules that a device must follow to
>> expose a lockdown compatible RPC.
>>
>> Based on some discussion fwctl splits the RPCs into four categories
>>
>> 	FWCTL_RPC_CONFIGURATION
>> 	FWCTL_RPC_DEBUG_READ_ONLY
>> 	FWCTL_RPC_DEBUG_WRITE
>> 	FWCTL_RPC_DEBUG_WRITE_FULL
>>
>> Where the latter two trigger a new TAINT_FWCTL, and the final one requires
>> CAP_SYS_RAWIO - excluding it from lockdown. The device driver and its FW
>> would be responsible to restrict RPCs to the requested security scope,
>> while the core code handles the tainting and CAP checks.
>>
>> For details see the final patch which introduces the documentation.
>>
>> This series incorporates a version of the mlx5ctl interface previously
>> proposed:
>>   https://lore.kernel.org/r/20240207072435.14182-1-saeed@kernel.org/
>>
>> For this series the memory registration mechanism was removed, but I
>> expect it will come back.
>>
>> It also includes the FWCL driver series from David:
>>   https://lore.kernel.org/all/20240718213446.1750135-1-dave.jiang@intel.com/
>>
>>
>> This is still waiting a 3rd fwctl driver and the CXL side to finish some
>> of its development. The github has the necessary CXL precursor patches.
>>
>> There have been two LWN articles written discussing various aspects of
>> this proposal:
>>
>>  https://lwn.net/Articles/955001/
>>  https://lwn.net/Articles/969383/
>>
>> And a really giant ksummit thread:
>>
>>  https://lore.kernel.org/ksummit/668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch/
>>
>> Several have expressed general support for this concept:
>>
>>  Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
>>  Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org/
>>  Daniel Vetter - https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
>>  Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org/
>>  NVIDIA Networking
>>  Oded Gabbay/Habana - https://lore.kernel.org/r/ZrMl1bkPP-3G9B4N@T14sgabbay.
>>  Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq
>>  SuSE/Hannes - https://lore.kernel.org/r/2fd48f87-2521-4c34-8589-dbb7e91bb1c8@suse.com
>>
>> Work is ongoing for a robust multi-device open source userspace, currently
>> the mlx5ctl_user that was posted by Saeed has been updated to use fwctl.
>>
>>   https://github.com/saeedtx/mlx5ctl.git
>>   https://github.com/jgunthorpe/mlx5ctl.git
>>
>> This is on github: https://github.com/jgunthorpe/linux/commits/fwctl
>>
>> v3:
>>  - Rebase to v6.11-rc4
>>  - Add a squashed version of David's CXL series as the 2nd driver
>>  - Add missing includes
>>  - Improve comments based on feedback
>>  - Use the kdoc format that puts the member docs inside the struct
>>  - Rewrite fwctl_alloc_device() to be clearer
>>  - Incorporate all remarks for the documentation
>> v2: https://lore.kernel.org/r/0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com
>>  - Rebase to v6.10-rc5
>>  - Minor style changes
>>  - Follow the style consensus for the guard stuff
>>  - Documentation grammer/spelling
>>  - Add missed length output for mlx5 get_info
>>  - Add two more missed MLX5 CMD's
>>  - Collect tags
>> v1: https://lore.kernel.org/r/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
>>
>> Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>
>> Cc: Aron Silverton <aron.silverton@oracle.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: David Ahern <dsahern@kernel.org>
>> Cc: Itay Avraham <itayavr@nvidia.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Jiri Pirko <jiri@nvidia.com>
>> Cc: Leon Romanovsky <leonro@nvidia.com>
>> Cc: Leonid Bloch <lbloch@nvidia.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: linux-cxl@vger.kernel.org
>> Cc: linux-rdma@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>
>> Dave Jiang (1):
>>   fwctl/cxl: Add driver for CXL mailbox for handling CXL features
>>     commands (RFC)
>>
>> Jason Gunthorpe (7):
>>   fwctl: Add basic structure for a class subsystem with a cdev
>>   fwctl: Basic ioctl dispatch for the character device
>>   fwctl: FWCTL_INFO to return basic information about the device
>>   taint: Add TAINT_FWCTL
>>   fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
>>   fwctl: Add documentation
>>   cxl: Create an auxiliary device for fwctl_cxl
>>
>> Saeed Mahameed (2):
>>   fwctl/mlx5: Support for communicating with mlx5 fw
>>   mlx5: Create an auxiliary device for fwctl_mlx5
>>
>>  Documentation/admin-guide/tainted-kernels.rst |   5 +
>>  Documentation/userspace-api/fwctl.rst         | 285 ++++++++++++
>>  Documentation/userspace-api/index.rst         |   1 +
>>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>>  MAINTAINERS                                   |  23 +
>>  drivers/Kconfig                               |   2 +
>>  drivers/Makefile                              |   1 +
>>  drivers/cxl/core/memdev.c                     |  19 +
>>  drivers/fwctl/Kconfig                         |  32 ++
>>  drivers/fwctl/Makefile                        |   6 +
>>  drivers/fwctl/cxl/Makefile                    |   4 +
>>  drivers/fwctl/cxl/cxl.c                       | 274 ++++++++++++
>>  drivers/fwctl/main.c                          | 414 ++++++++++++++++++
>>  drivers/fwctl/mlx5/Makefile                   |   4 +
>>  drivers/fwctl/mlx5/main.c                     | 337 ++++++++++++++
>>  drivers/net/ethernet/mellanox/mlx5/core/dev.c |   8 +
>>  include/linux/cxl/mailbox.h                   | 104 +++++
>>  include/linux/fwctl.h                         | 135 ++++++
>>  include/linux/panic.h                         |   3 +-
>>  include/uapi/fwctl/cxl.h                      |  94 ++++
>>  include/uapi/fwctl/fwctl.h                    | 140 ++++++
>>  include/uapi/fwctl/mlx5.h                     |  36 ++
>>  kernel/panic.c                                |   1 +
>>  tools/debugging/kernel-chktaint               |   8 +
>>  24 files changed, 1936 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/userspace-api/fwctl.rst
>>  create mode 100644 drivers/fwctl/Kconfig
>>  create mode 100644 drivers/fwctl/Makefile
>>  create mode 100644 drivers/fwctl/cxl/Makefile
>>  create mode 100644 drivers/fwctl/cxl/cxl.c
>>  create mode 100644 drivers/fwctl/main.c
>>  create mode 100644 drivers/fwctl/mlx5/Makefile
>>  create mode 100644 drivers/fwctl/mlx5/main.c
>>  create mode 100644 include/linux/fwctl.h
>>  create mode 100644 include/uapi/fwctl/cxl.h
>>  create mode 100644 include/uapi/fwctl/fwctl.h
>>  create mode 100644 include/uapi/fwctl/mlx5.h
>>
>>
>> base-commit: cd0c76bee95e9c2092418523599439d2c8dbff7e
> 
> Hi Jason,
> Which base-commit is this? I'm not finding the hash in the upstream tree. I'm having trouble applying the series against 6.10 or 6.11-rc7 via b4. 

Got it to apply against 6.11. So ignore this. :) 


