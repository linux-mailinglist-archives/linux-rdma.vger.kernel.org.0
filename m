Return-Path: <linux-rdma+bounces-7575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C2A2D256
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 01:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0387A249D
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DF1119A;
	Sat,  8 Feb 2025 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mslUzV/t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF96FBF;
	Sat,  8 Feb 2025 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738975250; cv=none; b=iXN6CQzC3uagIvq1jufWFJKNhHkf5jQ6n+Be+cQCRpt8ZnJtgpUvRrRG5cM8mjeUqb4aHPSH82qdEHpwR0AeSOUEuUIHaarKxCDOZO+munIySNgMa/X9YahSQDVzILxFMYqXBA8EJf4rkmddjsGox/Lh/KbS5StDdB04C23YY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738975250; c=relaxed/simple;
	bh=r0Ex0F0fUFBEj9IiF7YXJK4ZVY3iQam0/vTCzBxAVDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tv9GQzlxLEb1meTqa69/zk7B2OHIRvk9Hw9QVVk5uTgtTeojjXdf6L64WWl9/ICfd3p8/ycZi6qyARruUF89jO1wtp9oMCtxqdNPN8Lsceq+Asmnvkkp/QDP50li+RDv17gqsFML4V1MJWxjebEGXydTtmPlzzuMqQpbV3xAsVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mslUzV/t; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738975247; x=1770511247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r0Ex0F0fUFBEj9IiF7YXJK4ZVY3iQam0/vTCzBxAVDI=;
  b=mslUzV/tlpvnyJjhQArkt/BtBH22QGJaf46Fov97uk9PzuzPHpC7NJDu
   eZlElsCPmXsARvmMVN6qJibaeI6mkiIZGUKuYeiI22Xfymsp7/nVXkslD
   KCjX8l01cAAxwN1EwVjjR8ZWp6fpV4LvthpLl37xra3ax9qkuoZ8teWEy
   X4KqQQWX1NhmWNAGOCXKLk0NfGNGUJXBB3d0NcWnVTjTySwf2E/QMDtUc
   WXAWhA/ZRlRirIY0o7h/5hbaael2dj8WbDB2OCaFFSSlDtoFX0YrdpOA+
   u2yGgtWxDF14v9MdiKoCrIDzmNDBEXCkRGs6hTepjMgn+34tkEjSnuDpx
   w==;
X-CSE-ConnectionGUID: iuk7MYLgR0GIvmvKUKu3ow==
X-CSE-MsgGUID: OjflrmtmSU+taNAwTGzhwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42471313"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42471313"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:40:47 -0800
X-CSE-ConnectionGUID: 8U/fTnAfTpyJKAYaaq5wJA==
X-CSE-MsgGUID: yxNwIOmmTzy04xDvyNlH6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111879522"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:40:45 -0800
Message-ID: <98885525-2872-4583-bfd3-0064475af3ef@intel.com>
Date: Fri, 7 Feb 2025 17:40:43 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] fwctl: Add documentation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, David Ahern <dsahern@kernel.org>,
 Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>,
 Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "Nelson, Shannon"
 <shannon.nelson@amd.com>
References: <6-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/6/25 5:13 PM, Jason Gunthorpe wrote:
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

One spelling correction below. Otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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
> +The FW layer in devices has grown to incredible size and devices frequently
> +integrate clusters of fast processors to run it. For example, mlx5 devices have
> +over 30MB of FW code, and big configurations operate with over 1GB of FW managed
> +runtime state.
> +
> +The availability of such a flexible layer has created quite a variety in the
> +industry where single pieces of silicon are now configurable software-defined
> +devices and can operate in substantially different ways depending on the need.
> +Further, we often see cases where specific sites wish to operate devices in ways
> +that are highly specialized and require applications that have been tailored to
> +their unique configuration.
> +
> +Further, devices have become multi-functional and integrated to the point they
> +no longer fit neatly into the kernel's division of subsystems. Modern
> +multi-functional devices have drivers, such as bnxt/ice/mlx5/pds, that span many
> +subsystems while sharing the underlying hardware using the auxiliary device
> +system.
> +
> +All together this creates a challenge for the operating system, where devices
> +have an expansive FW environment that needs robust device-specific debugging
> +support, and FW-driven functionality that is not well suited to “generic”
> +interfaces. fwctl seeks to allow access to the full device functionality from
> +user space in the areas of debuggability, management, and first-boot/nth-boot
> +provisioning.
> +
> +fwctl is aimed at the common device design pattern where the OS and FW
> +communicate via an RPC message layer constructed with a queue or mailbox scheme.
> +In this case the driver will typically have some layer to deliver RPC messages
> +and collect RPC responses from device FW. The in-kernel subsystem drivers that
> +operate the device for its primary purposes will use these RPCs to build their
> +drivers, but devices also usually have a set of ancillary RPCs that don't really
> +fit into any specific subsystem. For example, a HW RAID controller is primarily
> +operated by the block layer but also comes with a set of RPCs to administer the
> +construction of drives within the HW RAID.
> +
> +In the past when devices were more single function, individual subsystems would
> +grow different approaches to solving some of these common problems. For instance
> +monitoring device health, manipulating its FLASH, debugging the FW,
> +provisioning, all have various unique interfaces across the kernel.
> +
> +fwctl's purpose is to define a common set of limited rules, described below,
> +that allow user space to securely construct and execute RPCs inside device FW.
> +The rules serve as an agreement between the operating system and FW on how to
> +correctly design the RPC interface. As a uAPI the subsystem provides a thin
> +layer of discovery and a generic uAPI to deliver the RPCs and collect the
> +response. It supports a system of user space libraries and tools which will
> +use this interface to control the device using the device native protocols.
> +
> +Scope of Action
> +---------------
> +
> +fwctl drivers are strictly restricted to being a way to operate the device FW.
> +It is not an avenue to access random kernel internals, or other operating system
> +SW states.
> +
> +fwctl instances must operate on a well-defined device function, and the device
> +should have a well-defined security model for what scope within the physical
> +device the function is permitted to access. For instance, the most complex PCIe
> +device today may broadly have several function-level scopes:
> +
> + 1. A privileged function with full access to the on-device global state and
> +    configuration
> +
> + 2. Multiple hypervisor functions with control over itself and child functions
> +    used with VMs
> +
> + 3. Multiple VM functions tightly scoped within the VM
> +
> +The device may create a logical parent/child relationship between these scopes.
> +For instance a child VM's FW may be within the scope of the hypervisor FW. It is
> +quite common in the VFIO world that the hypervisor environment has a complex
> +provisioning/profiling/configuration responsibility for the function VFIO
> +assigns to the VM.
> +
> +Further, within the function, devices often have RPC commands that fall within
> +some general scopes of action (see enum fwctl_rpc_scope):
> +
> + 1. Access to function & child configuration, FLASH, etc. that becomes live at a
> +    function reset. Access to function & child runtime configuration that is
> +    transparent or non-disruptive to any driver or VM.
> +
> + 2. Read-only access to function debug information that may report on FW objects
> +    in the function & child, including FW objects owned by other kernel
> +    subsystems.
> +
> + 3. Write access to function & child debug information strictly compatible with
> +    the principles of kernel lockdown and kernel integrity protection. Triggers
> +    a kernel Taint.
> +
> + 4. Full debug device access. Triggers a kernel Taint, requires CAP_SYS_RAWIO.
> +
> +User space will provide a scope label on each RPC and the kernel must enforce the
> +above CAPs and taints based on that scope. A combination of kernel and FW can
> +enforce that RPCs are placed in the correct scope by user space.
> +
> +Denied behavior
> +---------------
> +
> +There are many things this interface must not allow user space to do (without a
> +Taint or CAP), broadly derived from the principles of kernel lockdown. Some
> +examples:
> +
> + 1. DMA to/from arbitrary memory, hang the system, compromise FW integrity with
> +    untrusted code, or otherwise compromise device or system security and
> +    integrity.
> +
> + 2. Provide an abnormal “back door” to kernel drivers. No manipulation of kernel
> +    objects owned by kernel drivers.
> +
> + 3. Directly configure or otherwise control kernel drivers. A subsystem kernel
> +    driver can react to the device configuration at function reset/driver load
> +    time, but otherwise must not be coupled to fwctl.
> +
> + 4. Operate the HW in a way that overlaps with the core purpose of another
> +    primary kernel subsystem, such as read/write to LBAs, send/receive of
> +    network packets, or operate an accelerator's data plane.
> +
> +fwctl is not a replacement for device direct access subsystems like uacce or
> +VFIO.
> +
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
> +
> +sysfs Class
> +-----------
> +
> +fwctl has a sysfs class (/sys/class/fwctl/fwctlNN/) and character devices
> +(/dev/fwctl/fwctlNN) with a simple numbered scheme. The character device
> +operates the iotcl uAPI described above.
> +
> +fwctl devices can be related to driver components in other subsystems through
> +sysfs::
> +
> +    $ ls /sys/class/fwctl/fwctl0/device/infiniband/
> +    ibp0s10f0
> +
> +    $ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
> +    fwctl0/
> +
> +    $ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
> +    dev  device  power  subsystem  uevent
> +
> +User space Community
> +--------------------
> +
> +Drawing inspiration from nvme-cli, participating in the kernel side must come
> +with a user space in a common TBD git tree, at a minimum to usefully operate the
> +kernel driver. Providing such an implementation is a pre-condition to merging a
> +kernel driver.
> +
> +The goal is to build user space community around some of the shared problems
> +we all have, and ideally develop some common user space programs with some
> +starting themes of:
> +
> + - Device in-field debugging
> +
> + - HW provisioning
> +
> + - VFIO child device profiling before VM boot
> +
> + - Confidential Compute topics (attestation, secure provisioning)
> +
> +that stretch across all subsystems in the kernel. fwupd is a great example of
> +how an excellent user space experience can emerge out of kernel-side diversity.
> +
> +fwctl Kernel API
> +================
> +
> +.. kernel-doc:: drivers/fwctl/main.c
> +   :export:
> +.. kernel-doc:: include/linux/fwctl.h
> +
> +fwctl Driver design
> +-------------------
> +
> +In many cases a fwctl driver is going to be part of a larger cross-subsystem
> +device possibly using the auxiliary_device mechanism. In that case several
> +subsystems are going to be sharing the same device and FW interface layer so the
> +device design must already provide for isolation and cooperation between kernel
> +subsystems. fwctl should fit into that same model.
> +
> +Part of the driver should include a description of how its scope restrictions
> +and security model work. The driver and FW together must ensure that RPCs
> +provided by user space are mapped to the appropriate scope. If the validation is
> +done in the driver then the validation can read a 'command effects' report from
> +the device, or hardwire the enforcement. If the validation is done in the FW,
> +then the driver should pass the fwctl_rpc_scope to the FW along with the command.
> +
> +The driver and FW must cooperate to ensure that either fwctl cannot allocate
> +any FW resources, or any resources it does allocate are freed on FD closure.  A
> +driver primarily constructed around FW RPCs may find that its core PCI function
> +and RPC layer belongs under fwctl with auxiliary devices connecting to other
> +subsystems.
> +
> +Each device type must be mindful of Linux's philosophy for stable ABI. The FW
> +RPC interface does not have to meet a strictly stable ABI, but it does need to
> +meet an expectation that userspace tools that are deployed and in significant
> +use don't needlessly break. FW upgrade and kernel upgrade should keep widely
> +deployed tooling working.
> +
> +Development and debugging focused RPCs under more permissive scopes can have
> +less stablitiy if the tools using them are only run under exceptional

s/stablitiy/stability/

DJ

> +circumstances and not for every day use of the device. Debugging tools may even
> +require exact version matching as they may require something similar to DWARF
> +debug information from the FW binary.
> +
> +Security Response
> +=================
> +
> +The kernel remains the gatekeeper for this interface. If violations of the
> +scopes, security or isolation principles are found, we have options to let
> +devices fix them with a FW update, push a kernel patch to parse and block RPC
> +commands or push a kernel patch to block entire firmware versions/devices.
> +
> +While the kernel can always directly parse and restrict RPCs, it is expected
> +that the existing kernel pattern of allowing drivers to delegate validation to
> +FW to be a useful design.
> +
> +Existing Similar Examples
> +=========================
> +
> +The approach described in this document is not a new idea. Direct, or near
> +direct device access has been offered by the kernel in different areas for
> +decades. With more devices wanting to follow this design pattern it is becoming
> +clear that it is not entirely well understood and, more importantly, the
> +security considerations are not well defined or agreed upon.
> +
> +Some examples:
> +
> + - HW RAID controllers. This includes RPCs to do things like compose drives into
> +   a RAID volume, configure RAID parameters, monitor the HW and more.
> +
> + - Baseboard managers. RPCs for configuring settings in the device and more
> +
> + - NVMe vendor command capsules. nvme-cli provides access to some monitoring
> +   functions that different products have defined, but more exist.
> +
> + - CXL also has a NVMe-like vendor command system.
> +
> + - DRM allows user space drivers to send commands to the device via kernel
> +   mediation
> +
> + - RDMA allows user space drivers to directly push commands to the device
> +   without kernel involvement
> +
> + - Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc.
> +
> +The first 4 are examples of areas that fwctl intends to cover. The latter three
> +are examples of denied behavior as they fully overlap with the primary purpose
> +of a kernel subsystem.
> +
> +Some key lessons learned from these past efforts are the importance of having a
> +common user space project to use as a pre-condition for obtaining a kernel
> +driver. Developing good community around useful software in user space is key to
> +getting companies to fund participation to enable their products.
> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
> new file mode 100644
> index 00000000000000..06959fbf154743
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/index.rst
> @@ -0,0 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Firmware Control (FWCTL) Userspace API
> +======================================
> +
> +A framework that define a common set of limited rules that allows user space
> +to securely construct and execute RPCs inside device firmware.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   fwctl
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index b1395d94b3fd0a..e8e861f767fd5c 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -45,6 +45,7 @@ Devices and I/O
>  
>     accelerators/ocxl
>     dma-buf-alloc-exchange
> +   fwctl/index
>     gpio/index
>     iommufd
>     media/index
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
>  F:	drivers/fwctl/
>  F:	include/linux/fwctl.h
>  F:	include/uapi/fwctl/


