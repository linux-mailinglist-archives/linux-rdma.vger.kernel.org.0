Return-Path: <linux-rdma+bounces-2867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA88FC1D7
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 04:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFA31F25D26
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 02:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105AC61FE5;
	Wed,  5 Jun 2024 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C0sfatRB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44C10E4;
	Wed,  5 Jun 2024 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554677; cv=none; b=la7Qhewivk1a5dvPSvPRm1n5e3Oh0uXxY2O6p53yEBb7KL4/l8E8Ue7H6xINxBryVRUN5KtqioMCB+EdfdLh+X1o2cZ5//FobceLTPjuxaip8TGdNw3rl2q2qTWt9mw+ti7ifywStoZDD+iccxru0R2PrBwuRMY9brqeKZbtZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554677; c=relaxed/simple;
	bh=fmqGcsNNSDwkwttOcQF2Y6zkUQcVi2/GjQnhPjZiHTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7QpITL3ZMA7+I02yt40IT/2fYCq+ATiH1n2MKsaHW6ildSWXn8uIayYW0v6sUmYx/3Sj9ptaFJ6YzJxjMIiaguo2P4n7oXQjeitVL975708ClynhLSK0Fnno0NmDbX8JJwG4JwDPHilrQy9RCNq8hbsJUWwZgg/z1iHZB/7s8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C0sfatRB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yK8fbs3ViLrJnthl24hEbVhcvGVand/1c9old/3DAzM=; b=C0sfatRBWMFjWhBXZc5z0F6Cbl
	yBHlbJjcosdJhlvgoZSfYtLiTNFaaYvns1wujQaoTdq/RyUyn927rUw1RBt3A5MDYTYZ0s6IRou00
	lN3rLIPBxcV2AYXr5J3pbV7A9CfpHKO6uBtNtXJ4wvD6gPZ4s9Ux340gI3XUCJ8b3usrTjb++p3g4
	TnkmYFV6TiQX5LkHxay5puONuOa2eAWQrndJ7RHiinPcnMV994vPSDB1Ni4PR65v7d9yGINeQz+nS
	csnpQW3DksMQOWBKC1T+tSWQW+GAOBDufeTyitUZEkH3H1A5uT6MYUbT+Kp7l7fbzPwg/rUX4m5Os
	/cacgC7Q==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEgQh-00000004T7I-0hUq;
	Wed, 05 Jun 2024 02:31:11 +0000
Message-ID: <7a28cd2c-b5a8-4c06-b9e2-9b390d8c96e4@infradead.org>
Date: Tue, 4 Jun 2024 19:31:10 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] fwctl: Add documentation
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <6-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/3/24 8:53 AM, Jason Gunthorpe wrote:
> Document the purpose and rules for the fwctl subsystem.
> 
> Link in kdocs to the doc tree.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  Documentation/userspace-api/fwctl.rst | 269 ++++++++++++++++++++++++++
>  Documentation/userspace-api/index.rst |   1 +
>  2 files changed, 270 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl.rst b/Documentation/userspace-api/fwctl.rst
> new file mode 100644
> index 00000000000000..630e75a91838f0
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl.rst
> @@ -0,0 +1,269 @@
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
> +software defined pieces of hardware. The evolution of this approach is largely a

  software-defined

> +reaction to Moore's Law where a chip tape out is now highly expensive, and the
> +chip design is extremely large. Replacing fixed HW logic with a flexible and
> +tightly coupled FW/HW combination is an effective risk mitigation against chip
> +respin. Problems in the HW design can be counteracted in device FW. This is
> +especially true for devices which present a stable and backwards compatible
> +interface to the operating system driver (such as NVMe).
> +
> +The FW layer in devices has grown to incredible sizes and devices frequently
> +integrate clusters of fast processors to run it. For example, mlx5 devices have
> +over 30MB of FW code, and big configurations operate with over 1GB of FW managed
> +runtime state.
> +
> +The availability of such a flexible layer has created quite a variety in the
> +industry where single pieces of silicon are now configurable software defined

                                                                software-defined

> +devices and can operate in substantially different ways depending on the need.
> +Further we often see cases where specific sites wish to operate devices in ways

   Further,

like in the next paragraph.

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
> +support, and FW driven functionality that is not well suited to “generic”

                FW-driven

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
> +In the past when devices were more single function individual subsystems would

                                             function,

> +grow different approaches to solving some of these common problems, for instance

                                                             problems. For instance

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
> +device today may broadly have several function level scopes:

                                         function-level

> +
> + 1. A privileged function with full access to the on-device global state and
> +    configuration
> +
> + 2. Multiple hypervisor functions with control over itself and child functions
> +    used with VMs
> +
> + 3. Multiple VM functions tightly scoped within the VM
> +
> +The device may create a logical parent/child relationship between these scopes,

                                                                           scopes;
or end that line with a period and begin the next one with "For".

> +for instance a child VM's FW may be within the scope of the hypervisor FW. It is
> +quite common in the VFIO world that the hypervisor environment has a complex
> +provisioning/profiling/configuration responsibility for the function VFIO
> +assigns to the VM.
> +
> +Further, within the function, devices often have RPC commands that fall within
> +some general scopes of action:
> +
> + 1. Access to function & child configuration, flash, etc that becomes live at a

                                                        etc.

       Use FLASH as above or change above FLASH to "flash".

> +    function reset.
> +
> + 2. Access to function & child runtime configuration that kernel drivers can
> +    discover at runtime.
> +
> + 3. Read only access to function debug information that may report on FW objects

       Read-only

> +    in the function & child, including FW objects owned by other kernel
> +    subsystems.
> +
> + 4. Write access to function & child debug information strictly compatible with
> +    the principles of kernel lockdown and kernel integrity protection. Triggers
> +    a kernel Taint.
> +
> + 5. Full debug device access. Triggers a kernel Taint, requires CAP_SYS_RAWIO.
> +
> +Userspace will provide a scope label on each RPC and the kernel must enforce the
> +above CAP's and taints based on that scope. A combination of kernel and FW can
> +enforce that RPCs are placed in the correct scope by userspace.
> +
> +Denied behavior
> +---------------
> +
> +There are many things this interface must not allow user space to do (without a
> +Taint or CAP), broadly derived from the principles of kernel lockdown. Some
> +examples:
> +
> + 1. DMA to/from arbitrary memory, hang the system, run code in the device, or
> +    otherwise compromise device or system security and integrity.
> +
> + 2. Provide an abnormal “back door” to kernel drivers. No manipulation of kernel
> +    objects owned by kernel drivers.
> +
> + 3. Directly configure or otherwise control kernel drivers. A subsystem kernel
> +    driver can react to the device configuration at function reset/driver load
> +    time, but otherwise should not be coupled to fwctl.
> +
> + 4. Operate the HW in a way that overlaps with the core purpose of another
> +    primary kernel subsystem, such as read/write to LBAs, send/receive of
> +    network packets, or operate an accelerator's data plane.
> +
> +fwctl is not a replacement for device direct access subsystems like uacce or
> +VFIO.
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
> +That stretches across all subsystems in the kernel. fwupd is a great example of

   that stretch across

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
> +device design must already provide for isolation and co-operation between kernel

                                                        cooperation

> +subsystems. fwctl should fit into that same model.
> +
> +Part of the driver should include a description of how its scope restrictions
> +and security model work. The driver and FW together must ensure that RPCs
> +provided by user space are mapped to the appropriate scope. If the validation is
> +done in the driver then the validation can read a 'command effects' report from
> +the device, or hardwire the enforcement. If the validation is done in the FW,
> +then the driver should pass the fwctl_rpc_scope to the FW along with the command.
> +
> +The driver and FW must co-operate to ensure that either fwctl cannot allocate

                          cooperate

> +any FW resources, or any resources it does allocate are freed on FD closure.  A
> +driver primarily constructed around FW RPCs may find that its core PCI function
> +and RPC layer belongs under fwctl with auxiliary devices connecting to other
> +subsystems.
> +
> +Each device type must represent a stable FW ABI, such that the userspace
> +components have the same general stability we expect from the kernel. FW upgrade
> +should not break the userspace tools.
> +
> +Security Response
> +=================
> +
> +The kernel remains the gatekeeper for this interface. If violations of the
> +scopes, security or isolation principles are found, we have options to let
> +devices fix them with a FW update, push a kernel patch to parse and block RPC
> +commands or push a kernel patch to block entire firmware versions, or devices.

                             no comma needed                        ^

> +
> +While the kernel can always directly parse and restrict RPCs, it is expected
> +that the existing kernel pattern of allowing drivers to delegate validation to
> +FW to be a useful design.

(and one that can be abused...)

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
> +   functions that different products have defined, but more exists.
> +
> + - CXL also has a NVMe like vendor command system.

                     NVMe-like

> +
> + - DRM allows user space drivers to send commands to the device via kernel
> +   mediation
> +
> + - RDMA allows user space drivers to directly push commands to the device
> +   without kernel involvement
> +
> + - Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc
> +
> +The first 4 would be examples of areas that fwctl intends to cover.

I would s/would be/are/ fwiw.

> +
> +Some key lessons learned from these past efforts are the importance of having a
> +common user space project to use as a pre-condition for obtaining a kernel
> +driver. Developing good community around useful software in user space is key to
> +getting companies to fund participation to enable their products.
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index 5926115ec0ed86..9685942fc8a21f 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -43,6 +43,7 @@ Devices and I/O
>  
>     accelerators/ocxl
>     dma-buf-alloc-exchange
> +   fwctl
>     gpio/index
>     iommu
>     iommufd

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

