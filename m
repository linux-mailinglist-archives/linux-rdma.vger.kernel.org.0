Return-Path: <linux-rdma+bounces-4212-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C57948AD0
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 10:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012261C23351
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E319716BE29;
	Tue,  6 Aug 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="X/FAQ0Z2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9432166F25
	for <linux-rdma@vger.kernel.org>; Tue,  6 Aug 2024 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931423; cv=none; b=LmfHkHRJkeQ9eewTssREsEUUUtrOxnf4GsEi4Bi5QWCiTGocSvNpyZUcQc7FvcmCateE4OVfseJCEkCs4043HaWSUPkPl/CbLkdfKBgLnS0t82YfJMkIKjfwVzZQGMn3v9mVbmunFmlpD5JBdni/TaKDxRbLA/G7kVF+DN0hI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931423; c=relaxed/simple;
	bh=D+CVP3LAHoyJieZ3IHwiq8BaUUn6T4eAcqe11vgaaBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYjuI0iPZwmJnddWNu19P+jvtDtcnfVJjTrGPMKO5PvqQHMp7pNQhm4zfwMCax7RXrbtlYEdUWkmqLaU9X5Sg9Fq2j+O1Fm4G9CJC7ex7fEJIEvS/J6adDER9AHqrU46DgbgIoFjMeBLgCZ+N7xEhJW6RE1lt3FW4zPV/w4rrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=X/FAQ0Z2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77ccec2810so4126966b.0
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2024 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722931419; x=1723536219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1fwrc/DA7sKGmzqpGYEgmGSkw9+5+g7yhXRUHdqNiP0=;
        b=X/FAQ0Z2Tc2j88WTHVkYd9+DESxadqceOVvPHDGPrgnCIWFdqp/u2p4/LvzGR5azGG
         IwXiu0HQJQqUnvqXtHp+gFdy+GU4So4IugmCce5L+vvNMJsAjlt+0kvQ9tch8+498aDO
         drhDc2aFQdP//+VXxgtAQ4eQVK5m+iRPxdDUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722931419; x=1723536219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fwrc/DA7sKGmzqpGYEgmGSkw9+5+g7yhXRUHdqNiP0=;
        b=IBAK9B5bKm6EmKz/J1PQ277Q01WUn1E0ReRNuddbHGS8lIOZrWxX7iDM1AV4beKEiz
         /v/4sD3Q+l1nBp+v4NNBcILL9L6RhC2IN8s3u003eM8jFH2M266P9ja2lC6oBT7Tmd6Z
         1Y2OSHWHrl23LQWqR1+HKGLbIIvRffBdsuI9ZtXc+Sc3jWGk58ekOCVsAufxFPAwp3FS
         +AlRsckzyaNRgIoRrc4WdgIIjMsikZ0k3IoMAHHTiNPme5K4TxuZG31aXBvH2bsuv+V2
         PiXimy14bwRAvTmJcrWzHn7Wo/R2Z6TrO7QEPkwshnugh3e/yJEtJuHsNVbxV0SdRb5m
         4iXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUweW0roWq00Z8I3Pwyv2D1W6jVWe5wwRO40rybMpZHBzjQ/4tDsJptJrVkOg+CnUkL91j5PLthomX2oaXgzop4uaWb6K9AUgCM0A==
X-Gm-Message-State: AOJu0YzG+5SohqpPrSc+oqOvnLMIXsWxJ1PpbVe9bPpqTFXznUjOwc0d
	sRuTjTeJiIh8wJX3e7lra/mivA6Rm+hYK9xjjWDgONzbuCZC2GiQZM/WrLjlAvU=
X-Google-Smtp-Source: AGHT+IHUBrEtzG8UGkaq7MGoA+u02UWoJ5jhYv8QTLfaPvSvLuRhvvePwtJl4SLzgUu/aKN9XEqgMw==
X-Received: by 2002:a17:907:d8e:b0:a7a:a4be:2f8f with SMTP id a640c23a62f3a-a7dc4b2ed0fmr615774766b.0.1722931418864;
        Tue, 06 Aug 2024 01:03:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8855sm527536866b.199.2024.08.06.01.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 01:03:38 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:03:36 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 6/8] fwctl: Add documentation
Message-ID: <ZrHY2Bds7oF7KRGz@phenom.ffwll.local>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
X-Operating-System: Linux phenom 6.9.10-amd64 

On Mon, Jun 24, 2024 at 07:47:30PM -0300, Jason Gunthorpe wrote:
> Document the purpose and rules for the fwctl subsystem.
> 
> Link in kdocs to the doc tree.
> 
> Nacked-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

I think we'll need something like fwctl rather sooner than later for gpus
too, so for all the fwctl patches up to this one:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I both really liked the approach to fwctl_unregister and
copy_struct_from_user, and didn't spot anything offensive in the code.

Bunch of optional thoughs below, my take at least from the drm point is
that it's better to get this going and learn as we do, than try to get
this perfect from the go. Some of the nuances will need to be informed by
practice anyway.
-Sima

> ---
>  Documentation/userspace-api/fwctl.rst | 269 ++++++++++++++++++++++++++
>  Documentation/userspace-api/index.rst |   1 +
>  2 files changed, 270 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl.rst b/Documentation/userspace-api/fwctl.rst
> new file mode 100644
> index 00000000000000..ece2db2530502f
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
> +software-defined pieces of hardware. The evolution of this approach is largely a
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
> +some general scopes of action:

In your fwctl_rpc_scope you only have 4, not 5, and I think that's
clearer. Might also be good to put a kerneldoc link to the enum in here
for the details.

> + 1. Access to function & child configuration, FLASH, etc/ that becomes live at a
> +    function reset.
> +
> + 2. Access to function & child runtime configuration that kernel drivers can
> +    discover at runtime.

This one worries me, since it has potential for people to get it very
wrong and e.g. expose configuration where it's only safe if the driver
isn't bound, or at least no userspace is using it. I'd drop this and just
leave the one configuration rpc, with maybe more detail what exactly "When
configuration is written to the device remains in a fully supported
state." from the kerneldoc means. I think only safe options woulb be a)
applied on function reset b) transparent to both kernel and userspace
(beyond maybe device performance).

That might not cut all configuration items, but for those I think it'd be
best if fwctl guarantees through the driver model that there's no driver
bound to that function (or used by vfio/kvm), to guarantee safety. So
explicitly split them out as runtime configuration with a distinct rpc
scope. Maybe an addition for later.

> +
> + 3. Read only access to function debug information that may report on FW objects
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

Kinda the same worry as above, I think this should be "... but otherwise
_must_ not be coupled to fwctl".

> + 4. Operate the HW in a way that overlaps with the core purpose of another
> +    primary kernel subsystem, such as read/write to LBAs, send/receive of
> +    network packets, or operate an accelerator's data plane.

I still think some words about what to do when fwctl exposes some
functional which later on is covered by a newly added subsystem that
didn't yet exist. Also maybe adding some more examples from the RAS side
of things, since that's come up a few time in the ksummit-discuss thread,
plus I think it's where we'll most likely have a new subsystem or extended
functionality of an existing one pop up and cause conflicts with fwctl
rpcs that have landed earlier.

I'm personally fine with "we'll figure that out when it happens."

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
> +That stretch across all subsystems in the kernel. fwupd is a great example of
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
> +Each device type must represent a stable FW ABI, such that the userspace
> +components have the same general stability we expect from the kernel. FW upgrade
> +should not break the userspace tools.

I think an exception for the debug rpcs (or maybe only
FWCTL_DEBUG_WRITE_FULL if we're super strict) could really help the case
for fwctl. Still not allowing to break individual rpcs, but maybe allow fw
to remove outdated ones. With gpu fw we already struggle with abi
breakages where the kernel driver can do some amount of impendance
mismatch. If this is extended to debug tooling I fear it just wont happen,
forcing big junks of what fwctl could support to stay out of tree.

And especially for field and even more in-house debug tooling, you really
want the userspace version matching your fw anyway.

Currently that mess tends to leave in debugfs and/or out-of-tree, so
there's no stable uapi guarantee anyway. And I don't see the point in
requiring it - if there is a need for stabling tooling, maybe that
indicates more the need for a new subsystem that standardized things
across devices/vendors.

Another case in point are tracepoints, where the stable abi question also
has a lot more nuanced answer. Debug fw support imo falls into that same
bucket.

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
> +   functions that different products have defined, but more exists.
> +
> + - CXL also has a NVMe-like vendor command system.
> +
> + - DRM allows user space drivers to send commands to the device via kernel
> +   mediation
> +
> + - RDMA allows user space drivers to directly push commands to the device
> +   without kernel involvement
> +
> + - Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc
> +
> +The first 4 are examples of areas that fwctl intends to cover.

Maybe add a sentence here why the latter 3 aren't, just to strengthen that
point?

> +
> +Some key lessons learned from these past efforts are the importance of having a
> +common user space project to use as a pre-condition for obtaining a kernel
> +driver. Developing good community around useful software in user space is key to
> +getting companies to fund participation to enable their products.
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index 8a251d71fa6e14..990b4c0710c99e 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -44,6 +44,7 @@ Devices and I/O
>  
>     accelerators/ocxl
>     dma-buf-alloc-exchange
> +   fwctl
>     gpio/index
>     iommu
>     iommufd
> -- 
> 2.45.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

