Return-Path: <linux-rdma+bounces-7653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C2A30736
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 10:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268CF161F23
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED2B1F152B;
	Tue, 11 Feb 2025 09:33:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C901F1515;
	Tue, 11 Feb 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266417; cv=none; b=lbGScaFk6vlb+fD4sywiqfm96Fnw4ynYJ3Hdvn8XRd3NRIx0wl7K/aWH42AWD64qONj0JXWEEqwnygGz8MqIzIlKsonRaOkbHl6uh7TffdDgR5R5FEIe+xplEuofL9K4IvC+hA/1TBxIWBah73ZFsE3ik6zn93kBzrkfq6/DjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266417; c=relaxed/simple;
	bh=4vSZl2WPnLw3OPkUSssErIRZUxNMaeRRqYU17OwHZg4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnyTDrZext2gD2Rn5AesVe411MYaCluIHWyeNxdci5mcXW5ksFzFXZDNalgy0PMw+j4dLY1EyWBAzsI1NFZIytuEQtjlAsfV/dIoNrdWyomUjqvGgzQCN1Ltuk76Msc0E98SX8nKaGFL4KoTSSzzh2wsbw5AxlOEAL00dGQyaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ysblb4lCXz67sgR;
	Tue, 11 Feb 2025 17:30:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 20C941404F5;
	Tue, 11 Feb 2025 17:33:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 10:33:31 +0100
Date: Tue, 11 Feb 2025 09:33:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, David Ahern <dsahern@kernel.org>, Andy Gospodarek
	<gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>, Itay Avraham
	<itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 00/10] Introduce fwctl subystem
Message-ID: <20250211093329.00000b95@huawei.com>
In-Reply-To: <a0f1648f-eefb-455c-b264-169cb67a7486@intel.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<a0f1648f-eefb-455c-b264-169cb67a7486@intel.com>
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

On Fri, 7 Feb 2025 14:58:51 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 2/6/25 5:13 PM, Jason Gunthorpe wrote:
> > [
> > Many people were away around the holiday period, but work is back in full
> > swing now with Dave already at v3 on his CXL work over the past couple
> > weeks. We are looking at a good chance of reaching this merge window. I
> > will work out some shared branches with CXL and get it into linux-next
> > once all three drivers can be assembled and reviews seem to be concluding.
> > 
> > There are couple open notes
> >  - Greg was interested in a new name, but nobody offered any bikesheds
> >  - I would like a co-maintainer  
> 
> I volunteer as tribute. :) 
> 
> I got the CXL series rebased and tested on top of this series. So you can add
> Tested-by: Dave Jiang <dave.jiang@intel.com>
> for the core FWCTL bits in the series.

This is an area I plan to keep reviewing (and adding more use cases), so feel
free to add me as a Reviewer or Maintainer (depending on how guilty you want
me to feel if there is a backlog to review :)  Will save me making sure to
track these down as they get posted in different subsystems.

Thanks,

Jonathan

> 
> I'll post the CXL FWCTL series v4 shortly.
> 
> DJ
> 
> > ]
> > 
> > fwctl is a new subsystem intended to bring some common rules and order to
> > the growing pattern of exposing a secure FW interface directly to
> > userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
> > exposing a device for datapath operations fwctl is focused on debugging,
> > configuration and provisioning of the device. It will not have the
> > necessary features like interrupt delivery to support a datapath.
> > 
> > This concept is similar to the long standing practice in the "HW" RAID
> > space of having a device specific misc device to manage the RAID
> > controller FW. fwctl generalizes this notion of a companion debug and
> > management interface that goes along with a dataplane implemented in an
> > appropriate subsystem.
> > 
> > The need for this has reached a critical point as many users are moving to
> > run lockdown enabled kernels. Several existing devices have had long
> > standing tooling for management that relied on /sys/../resource0 or PCI
> > config space access which is not permitted in lockdown. A major point of
> > fwctl is to define and document the rules that a device must follow to
> > expose a lockdown compatible RPC.
> > 
> > Based on some discussion fwctl splits the RPCs into four categories
> > 
> > 	FWCTL_RPC_CONFIGURATION
> > 	FWCTL_RPC_DEBUG_READ_ONLY
> > 	FWCTL_RPC_DEBUG_WRITE
> > 	FWCTL_RPC_DEBUG_WRITE_FULL
> > 
> > Where the latter two trigger a new TAINT_FWCTL, and the final one requires
> > CAP_SYS_RAWIO - excluding it from lockdown. The device driver and its FW
> > would be responsible to restrict RPCs to the requested security scope,
> > while the core code handles the tainting and CAP checks.
> > 
> > For details see the final patch which introduces the documentation.
> > 
> > The CXL FWCTL driver is now in it own series on v3:
> >  https://lore.kernel.org/r/20250204220430.4146187-1-dave.jiang@intel.com
> > 
> > I'm expecting a 3rd driver (from Shannon @ Pensando) to be posted right
> > away, the github version I saw looked good. I've got soft commitments for
> > about 6 drivers in total now.
> > 
> > There have been three LWN articles written discussing various aspects of
> > this proposal:
> > 
> >  https://lwn.net/Articles/955001/
> >  https://lwn.net/Articles/969383/
> >  https://lwn.net/Articles/990802/
> > 
> > A really giant ksummit thread preceding a discussion at the Maintainer
> > Summit:
> > 
> >  https://lore.kernel.org/ksummit/668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch/
> > 
> > Several have expressed general support for this concept:
> > 
> >  AMD/Pensando - https://lore.kernel.org/linux-rdma/20241205222818.44439-1-shannon.nelson@amd.com
> >  Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
> >  Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org
> >  Daniel Vetter - https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
> >  Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org
> >  NVIDIA Networking
> >  Oded Gabbay/Habana - https://lore.kernel.org/r/ZrMl1bkPP-3G9B4N@T14sgabbay.
> >  Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq
> >  SuSE/Hannes - https://lore.kernel.org/r/2fd48f87-2521-4c34-8589-dbb7e91bb1c8@suse.com
> > 
> > Work is ongoing for userspace, currently the mellanox tool suite has been
> > ported over:
> >   https://github.com/Mellanox/mstflint
> > 
> > And a more simplified example how to use it:
> >   https://github.com/jgunthorpe/mlx5ctl.git
> > 
> > This is on github: https://github.com/jgunthorpe/linux/commits/fwctl
> > 
> > v4:
> >  - Rebase to v6.14-rc1
> >  - Fine tune comments and rst documentatin
> >  - Adjust cleanup.h usage - remove places that add more ofuscation than
> >    value
> >  - CXL is back to its own independent series
> >  - Increase FWCTL_MAX_DEVICES to 4096, someone hit the limit
> >  - Fix mlx5ctl_validate_rpc() logic around scope checking
> >  - Disable mlx5ctl on SFs
> > v3: https://patch.msgid.link/r/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com
> >  - Rebase to v6.11-rc4
> >  - Add a squashed version of David's CXL series as the 2nd driver
> >  - Add missing includes
> >  - Improve comments based on feedback
> >  - Use the kdoc format that puts the member docs inside the struct
> >  - Rewrite fwctl_alloc_device() to be clearer
> >  - Incorporate all remarks for the documentation
> > v2: https://lore.kernel.org/r/0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com
> >  - Rebase to v6.10-rc5
> >  - Minor style changes
> >  - Follow the style consensus for the guard stuff
> >  - Documentation grammer/spelling
> >  - Add missed length output for mlx5 get_info
> >  - Add two more missed MLX5 CMD's
> >  - Collect tags
> > v1: https://lore.kernel.org/r/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> > 
> > Andy Gospodarek (2):
> >   fwctl/bnxt: Support communicating with bnxt fw
> >   bnxt: Create an auxiliary device for fwctl_bnxt
> > 
> > Jason Gunthorpe (6):
> >   fwctl: Add basic structure for a class subsystem with a cdev
> >   fwctl: Basic ioctl dispatch for the character device
> >   fwctl: FWCTL_INFO to return basic information about the device
> >   taint: Add TAINT_FWCTL
> >   fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
> >   fwctl: Add documentation
> > 
> > Saeed Mahameed (2):
> >   fwctl/mlx5: Support for communicating with mlx5 fw
> >   mlx5: Create an auxiliary device for fwctl_mlx5
> > 
> >  Documentation/admin-guide/tainted-kernels.rst |   5 +
> >  Documentation/userspace-api/fwctl/fwctl.rst   | 285 ++++++++++++
> >  Documentation/userspace-api/fwctl/index.rst   |  12 +
> >  Documentation/userspace-api/index.rst         |   1 +
> >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >  MAINTAINERS                                   |  16 +
> >  drivers/Kconfig                               |   2 +
> >  drivers/Makefile                              |   1 +
> >  drivers/fwctl/Kconfig                         |  32 ++
> >  drivers/fwctl/Makefile                        |   6 +
> >  drivers/fwctl/bnxt/Makefile                   |   4 +
> >  drivers/fwctl/bnxt/bnxt.c                     | 167 +++++++
> >  drivers/fwctl/main.c                          | 416 ++++++++++++++++++
> >  drivers/fwctl/mlx5/Makefile                   |   4 +
> >  drivers/fwctl/mlx5/main.c                     | 340 ++++++++++++++
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   3 +
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 126 +++++-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   4 +
> >  drivers/net/ethernet/mellanox/mlx5/core/dev.c |   9 +
> >  include/linux/fwctl.h                         | 135 ++++++
> >  include/linux/panic.h                         |   3 +-
> >  include/uapi/fwctl/bnxt.h                     |  27 ++
> >  include/uapi/fwctl/fwctl.h                    | 140 ++++++
> >  include/uapi/fwctl/mlx5.h                     |  36 ++
> >  kernel/panic.c                                |   1 +
> >  tools/debugging/kernel-chktaint               |   8 +
> >  27 files changed, 1782 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/userspace-api/fwctl/fwctl.rst
> >  create mode 100644 Documentation/userspace-api/fwctl/index.rst
> >  create mode 100644 drivers/fwctl/Kconfig
> >  create mode 100644 drivers/fwctl/Makefile
> >  create mode 100644 drivers/fwctl/bnxt/Makefile
> >  create mode 100644 drivers/fwctl/bnxt/bnxt.c
> >  create mode 100644 drivers/fwctl/main.c
> >  create mode 100644 drivers/fwctl/mlx5/Makefile
> >  create mode 100644 drivers/fwctl/mlx5/main.c
> >  create mode 100644 include/linux/fwctl.h
> >  create mode 100644 include/uapi/fwctl/bnxt.h
> >  create mode 100644 include/uapi/fwctl/fwctl.h
> >  create mode 100644 include/uapi/fwctl/mlx5.h
> > 
> > 
> > base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b  
> 
> 


