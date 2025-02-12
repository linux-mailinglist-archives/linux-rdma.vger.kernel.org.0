Return-Path: <linux-rdma+bounces-7690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 345ABA33259
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 23:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC96216825D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 22:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FB0202C2E;
	Wed, 12 Feb 2025 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vhKDFuYT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4725190470
	for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398912; cv=none; b=MuSpSQcL1tGeGIDdEVRTsvXJPp3ryX2DjiuV+2J0OK9mae9Ach/JAgfiPK8dVPKXAnuLlC7qW+8tX6gdl8jLmlKptlbMnz9pFBplhhXgou9EdPKjkjFXk+pf/op2Hrll0ToXKQsVPqRptZ0OhtOjvgRENEemeA7+fLBmTc8rWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398912; c=relaxed/simple;
	bh=AfhynHGRbH0gMXRJkvIVbIvpzdPQS9W+xRsY08e4EXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pM/p5C5B+qGmOmx01Ksc1ow922+sfwWArtxTIgwFjCqoO51KAr2EWa2zG7UaYapKhe1meyHSJDLhsgWts9vgdsLKI6p/uyopWJ6whLaxzj/kEbDFZFz59G/ZoSSjKurDEkw405aDM67SCQ7Q1fwca3zLOmQSuStDTulAFQgy4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vhKDFuYT; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f762254-3912-4a8d-97a4-51a9bc7be74b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739398897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2/mEf+N9Ckmk5bgWQ5dh9b2BxLFZgefgkcJwKHRJTc=;
	b=vhKDFuYTJKe1e+8LoMCiE6aVX4ptQjk6hcW0HS1wgd31KtMSuy026j+XlTvMSUupePSa+X
	vd9IHFerfUby+4AnGRKerQRM8Py0jaiBv+rqmD7pg++Q7njDcZzbbF0Op/riZTx+gl9dJ8
	Y1ECbb6SuqqrHL9uvPkgDRgfn9EX0cM=
Date: Wed, 12 Feb 2025 23:21:29 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 00/10] Introduce fwctl subystem
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 "Nelson, Shannon" <shannon.nelson@amd.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/7 1:13, Jason Gunthorpe 写道:
> [
> Many people were away around the holiday period, but work is back in full
> swing now with Dave already at v3 on his CXL work over the past couple
> weeks. We are looking at a good chance of reaching this merge window. I
> will work out some shared branches with CXL and get it into linux-next
> once all three drivers can be assembled and reviews seem to be concluding.
> 
> There are couple open notes
>   - Greg was interested in a new name, but nobody offered any bikesheds
>   - I would like a co-maintainer
> ]
> 
> fwctl is a new subsystem intended to bring some common rules and order to
> the growing pattern of exposing a secure FW interface directly to
> userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
> exposing a device for datapath operations fwctl is focused on debugging,
> configuration and provisioning of the device. It will not have the
> necessary features like interrupt delivery to support a datapath.
> 
> This concept is similar to the long standing practice in the "HW" RAID
> space of having a device specific misc device to manage the RAID
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
> The CXL FWCTL driver is now in it own series on v3:
>   https://lore.kernel.org/r/20250204220430.4146187-1-dave.jiang@intel.com
> 
> I'm expecting a 3rd driver (from Shannon @ Pensando) to be posted right
> away, the github version I saw looked good. I've got soft commitments for
> about 6 drivers in total now.
> 
> There have been three LWN articles written discussing various aspects of
> this proposal:
> 
>   https://lwn.net/Articles/955001/
>   https://lwn.net/Articles/969383/
>   https://lwn.net/Articles/990802/
> 
> A really giant ksummit thread preceding a discussion at the Maintainer
> Summit:
> 
>   https://lore.kernel.org/ksummit/668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Several have expressed general support for this concept:
> 
>   AMD/Pensando - https://lore.kernel.org/linux-rdma/20241205222818.44439-1-shannon.nelson@amd.com
>   Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
>   Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org
>   Daniel Vetter - https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
>   Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org
>   NVIDIA Networking
>   Oded Gabbay/Habana - https://lore.kernel.org/r/ZrMl1bkPP-3G9B4N@T14sgabbay.
>   Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq
>   SuSE/Hannes - https://lore.kernel.org/r/2fd48f87-2521-4c34-8589-dbb7e91bb1c8@suse.com
> 
> Work is ongoing for userspace, currently the mellanox tool suite has been
> ported over:
>    https://github.com/Mellanox/mstflint
> 
> And a more simplified example how to use it:
>    https://github.com/jgunthorpe/mlx5ctl.git

Hi, Jason

I read all the threads about this fwctl subsystem carefully. I think 
that this fwctl tool is very nice and helpful in our work. But I can not 
find a user guide in the threads.

I want to have a try in our debug work with mlx5 devices. Can you share 
a link of a user guide with us?

Your helps are much appreciated.

Thanks a lot.
Zhu Yanjun

> 
> This is on github: https://github.com/jgunthorpe/linux/commits/fwctl
> 
> v4:
>   - Rebase to v6.14-rc1
>   - Fine tune comments and rst documentatin
>   - Adjust cleanup.h usage - remove places that add more ofuscation than
>     value
>   - CXL is back to its own independent series
>   - Increase FWCTL_MAX_DEVICES to 4096, someone hit the limit
>   - Fix mlx5ctl_validate_rpc() logic around scope checking
>   - Disable mlx5ctl on SFs
> v3: https://patch.msgid.link/r/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com
>   - Rebase to v6.11-rc4
>   - Add a squashed version of David's CXL series as the 2nd driver
>   - Add missing includes
>   - Improve comments based on feedback
>   - Use the kdoc format that puts the member docs inside the struct
>   - Rewrite fwctl_alloc_device() to be clearer
>   - Incorporate all remarks for the documentation
> v2: https://lore.kernel.org/r/0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com
>   - Rebase to v6.10-rc5
>   - Minor style changes
>   - Follow the style consensus for the guard stuff
>   - Documentation grammer/spelling
>   - Add missed length output for mlx5 get_info
>   - Add two more missed MLX5 CMD's
>   - Collect tags
> v1: https://lore.kernel.org/r/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> 
> Andy Gospodarek (2):
>    fwctl/bnxt: Support communicating with bnxt fw
>    bnxt: Create an auxiliary device for fwctl_bnxt
> 
> Jason Gunthorpe (6):
>    fwctl: Add basic structure for a class subsystem with a cdev
>    fwctl: Basic ioctl dispatch for the character device
>    fwctl: FWCTL_INFO to return basic information about the device
>    taint: Add TAINT_FWCTL
>    fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
>    fwctl: Add documentation
> 
> Saeed Mahameed (2):
>    fwctl/mlx5: Support for communicating with mlx5 fw
>    mlx5: Create an auxiliary device for fwctl_mlx5
> 
>   Documentation/admin-guide/tainted-kernels.rst |   5 +
>   Documentation/userspace-api/fwctl/fwctl.rst   | 285 ++++++++++++
>   Documentation/userspace-api/fwctl/index.rst   |  12 +
>   Documentation/userspace-api/index.rst         |   1 +
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   MAINTAINERS                                   |  16 +
>   drivers/Kconfig                               |   2 +
>   drivers/Makefile                              |   1 +
>   drivers/fwctl/Kconfig                         |  32 ++
>   drivers/fwctl/Makefile                        |   6 +
>   drivers/fwctl/bnxt/Makefile                   |   4 +
>   drivers/fwctl/bnxt/bnxt.c                     | 167 +++++++
>   drivers/fwctl/main.c                          | 416 ++++++++++++++++++
>   drivers/fwctl/mlx5/Makefile                   |   4 +
>   drivers/fwctl/mlx5/main.c                     | 340 ++++++++++++++
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   3 +
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 126 +++++-
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   4 +
>   drivers/net/ethernet/mellanox/mlx5/core/dev.c |   9 +
>   include/linux/fwctl.h                         | 135 ++++++
>   include/linux/panic.h                         |   3 +-
>   include/uapi/fwctl/bnxt.h                     |  27 ++
>   include/uapi/fwctl/fwctl.h                    | 140 ++++++
>   include/uapi/fwctl/mlx5.h                     |  36 ++
>   kernel/panic.c                                |   1 +
>   tools/debugging/kernel-chktaint               |   8 +
>   27 files changed, 1782 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/userspace-api/fwctl/fwctl.rst
>   create mode 100644 Documentation/userspace-api/fwctl/index.rst
>   create mode 100644 drivers/fwctl/Kconfig
>   create mode 100644 drivers/fwctl/Makefile
>   create mode 100644 drivers/fwctl/bnxt/Makefile
>   create mode 100644 drivers/fwctl/bnxt/bnxt.c
>   create mode 100644 drivers/fwctl/main.c
>   create mode 100644 drivers/fwctl/mlx5/Makefile
>   create mode 100644 drivers/fwctl/mlx5/main.c
>   create mode 100644 include/linux/fwctl.h
>   create mode 100644 include/uapi/fwctl/bnxt.h
>   create mode 100644 include/uapi/fwctl/fwctl.h
>   create mode 100644 include/uapi/fwctl/mlx5.h
> 
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b


