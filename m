Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A527FB82
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgJAIce (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 04:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgJAIce (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Oct 2020 04:32:34 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3F920780;
        Thu,  1 Oct 2020 08:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601541153;
        bh=2haMYD7TepgYWr6LItxcess2dijmEg2sZDYiGW//9Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QOb2aBS2WdL87cqydMwSmBxjCK1a3ezS6WFZgaydDSqPDNnGL/LOcXcXXnB4/P8ff
         7rokoFKIbEhhCYTNeQ44MuMSLCjyxi/KTchLuHELyzFSStPKh+FTUVb8fPMJ7BvWKG
         hKlAeUrrfmPbAxbkkbrhab4P4ar3E1qCUTjzsgqQ=
Date:   Thu, 1 Oct 2020 11:32:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dave Ertman <david.m.ertman@intel.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/6] Add ancillary bus support
Message-ID: <20201001083229.GV3094@unreal>
References: <20201001050534.890666-1-david.m.ertman@intel.com>
 <20201001050534.890666-2-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001050534.890666-2-david.m.ertman@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 10:05:29PM -0700, Dave Ertman wrote:
> Add support for the Ancillary Bus, ancillary_device and ancillary_driver.
> It enables drivers to create an ancillary_device and bind an
> ancillary_driver to it.
>
> The bus supports probe/remove shutdown and suspend/resume callbacks.
> Each ancillary_device has a unique string based id; driver binds to
> an ancillary_device based on this id through the bus.
>
> Co-developed-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Co-developed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  Documentation/driver-api/ancillary_bus.rst | 230 +++++++++++++++++++++
>  Documentation/driver-api/index.rst         |   1 +
>  drivers/bus/Kconfig                        |   3 +
>  drivers/bus/Makefile                       |   3 +
>  drivers/bus/ancillary.c                    | 191 +++++++++++++++++
>  include/linux/ancillary_bus.h              |  58 ++++++
>  include/linux/mod_devicetable.h            |   8 +
>  scripts/mod/devicetable-offsets.c          |   3 +
>  scripts/mod/file2alias.c                   |   8 +
>  9 files changed, 505 insertions(+)
>  create mode 100644 Documentation/driver-api/ancillary_bus.rst
>  create mode 100644 drivers/bus/ancillary.c
>  create mode 100644 include/linux/ancillary_bus.h
>
> diff --git a/Documentation/driver-api/ancillary_bus.rst b/Documentation/driver-api/ancillary_bus.rst
> new file mode 100644
> index 000000000000..0a11979aa927
> --- /dev/null
> +++ b/Documentation/driver-api/ancillary_bus.rst
> @@ -0,0 +1,230 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +Ancillary Bus
> +=============
> +
> +In some subsystems, the functionality of the core device (PCI/ACPI/other) is
> +too complex for a single device to be managed as a monolithic block or a part of
> +the functionality needs to be exposed to a different subsystem.  Splitting the
> +functionality into smaller orthogonal devices would make it easier to manage
> +data, power management and domain-specific interaction with the hardware. A key
> +requirement for such a split is that there is no dependency on a physical bus,
> +device, register accesses or regmap support. These individual devices split from
> +the core cannot live on the platform bus as they are not physical devices that
> +are controlled by DT/ACPI. The same argument applies for not using MFD in this
> +scenario as MFD relies on individual function devices being physical devices
> +that are DT enumerated.
> +
> +An example for this kind of requirement is the audio subsystem where a single
> +IP is handling multiple entities such as HDMI, Soundwire, local devices such as
> +mics/speakers etc. The split for the core's functionality can be arbitrary or
> +be defined by the DSP firmware topology and include hooks for test/debug. This
> +allows for the audio core device to be minimal and focused on hardware-specific
> +control and communication.
> +
> +The ancillary bus is intended to be minimal, generic and avoid domain-specific
> +assumptions. Each ancillary_device represents a part of its parent
> +functionality. The generic behavior can be extended and specialized as needed
> +by encapsulating an ancillary_device within other domain-specific structures and
> +the use of .ops callbacks. Devices on the ancillary bus do not share any
> +structures and the use of a communication channel with the parent is
> +domain-specific.
> +
> +When Should the Ancillary Bus Be Used
> +=====================================
> +
> +The ancillary bus is to be used when a driver and one or more kernel modules,
> +who share a common header file with the driver, need a mechanism to connect and
> +provide access to a shared object allocated by the ancillary_device's
> +registering driver.  The registering driver for the ancillary_device(s) and the
> +kernel module(s) registering ancillary_drivers can be from the same subsystem,
> +or from multiple subsystems.
> +
> +The emphasis here is on a common generic interface that keeps subsystem
> +customization out of the bus infrastructure.
> +
> +One example could be a multi-port PCI network device that is rdma-capable and
> +needs to export this functionality and attach to an rdma driver in another
> +subsystem.  The PCI driver will allocate and register an ancillary_device for
> +each physical function on the NIC.  The rdma driver will register an
> +ancillary_driver that will be matched with and probed for each of these
> +ancillary_devices.  This will give the rdma driver access to the shared data/ops
> +in the PCI drivers shared object to establish a connection with the PCI driver.
> +
> +Another use case is for the a PCI device to be split out into multiple sub
> +functions.  For each sub function an ancillary_device will be created.  A PCI
> +sub function driver will bind to such devices that will create its own one or
> +more class devices.  A PCI sub function ancillary device will likely be
> +contained in a struct with additional attributes such as user defined sub
> +function number and optional attributes such as resources and a link to the
> +parent device.  These attributes could be used by systemd/udev; and hence should
> +be initialized before a driver binds to an ancillary_device.
> +
> +Ancillary Device
> +================
> +
> +An ancillary_device is created and registered to represent a part of its parent
> +device's functionality. It is given a name that, combined with the registering
> +drivers KBUILD_MODNAME, creates a match_name that is used for driver binding,
> +and an id that combined with the match_name provide a unique name to register
> +with the bus subsystem.
> +
> +Registering an ancillary_device is a two-step process.  First you must call
> +ancillary_device_initialize(), which will check several aspects of the
> +ancillary_device struct and perform a device_initialize().  After this step
> +completes, any error state must have a call to put_device() in its resolution
> +path.  The second step in registering an ancillary_device is to perform a call
> +to ancillary_device_add(), which will set the name of the device and add the
> +device to the bus.
> +
> +To unregister an ancillary_device, just a call to ancillary_device_unregister()
> +is used.  This will perform both a device_del() and a put_device().

Why did you chose ancillary_device_initialize() and not
ancillary_device_register() to be paired with ancillary_device_unregister()?

Thanks
