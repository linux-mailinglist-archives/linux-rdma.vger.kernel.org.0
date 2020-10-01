Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8627F8D5
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 07:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgJAFGa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 01:06:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:21949 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgJAFGa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Oct 2020 01:06:30 -0400
IronPort-SDR: lzu6IAwXeexYQOs7JMfSP4JdZbMh+akYNG+srB5sAbRamWjlZfDP9HnkOgnu9HC5vQM7uVTm43
 AOYBL5oDH9Ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="161876190"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="161876190"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 22:06:27 -0700
IronPort-SDR: SpP/KCbE81v1gjDd2LHyl5Pe9t0sibTf1+NaN/G6LjltDPQa50yWwnuOE1yBd/MwDWSwR11JoL
 5DGj5m4P4vVg==
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="501563190"
Received: from dmert-dev.jf.intel.com ([10.166.241.5])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 22:06:27 -0700
From:   Dave Ertman <david.m.ertman@intel.com>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH 0/6] Ancillary bus implementation and SOF multi-client support
Date:   Wed, 30 Sep 2020 22:05:28 -0700
Message-Id: <20201001050534.890666-1-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Brief history of Ancillary Bus 
==============================
The ancillary bus code was originally submitted upstream as virtual 
bus, and was submitted through the netdev tree.  This process generated 
up to v4.  This discussion can be found here: 
 https://lore.kernel.org/netdev/0200520070227.3392100-2-jeffrey.t.kirsher@intel.com/T/#u 

At this point, GregKH requested that we take the review and revision 
process to an internal mailing list and garner the buy-in of a respected 
kernel contributor. 

The ancillary bus (then known as virtual bus) was originally submitted
along with implementation code for the ice driver and irdma drive,
causing the complication of also having dependencies in the rdma tree.
This new submission is utilizing an ancillary bus consumer in only the
sound driver tree to create the initial implementation and a single
user. 

Since implementation work has started on this patch set, there have been
multiple inquiries about the time frame of its completion.  It appears
that there will be numerous consumers of this functionality. 

The process of internal review and implementation using the sound
drivers generated 19 internal versions.  The changes, including the name
change from virtual bus to ancillary bus, from these versions can be
summarized as the following: 

- Fixed compilation and checkpatch errors 
- Improved documentation to address the motivation for virtual bus. 
- Renamed virtual bus to ancillary bus 
- increased maximum device name size 
- Correct order in Kconfig and Makefile 
- removed the mid-layer adev->release layer for device unregister 
- pushed adev->id management to parent driver 
- all error paths out of ancillary_device_register return error code 
- all error paths out of ancillary_device_register use put_device 
- added adev->name element 
- modname in register cannot be NULL 
- added KBUILD_MODNAME as prefix for match_name 
- push adev->id responsibility to registering driver 
- uevent now parses adev->dev name 
- match_id function now parses adev->dev name 
- changed drivers probe function to also take an ancillary_device_id param 
- split ancillary_device_register into device_initialize and device_add 
- adjusted what is done in device_initialize and device_add 
- change adev to ancildev and adrv to ancildrv 
- change adev to ancildev in documentation 

This submission is the first time that this patch set will be sent to
the alsa-devel mailing list, so it is currently being submitted as
version 1.

==========================

Introduces the ancillary bus implementation along with the example usage
in the Sound Open Firmware(SOF) audio driver.

In some subsystems, the functionality of the core device
(PCI/ACPI/other) may be too complex for a single device to be managed as
a monolithic block or a part of the functionality might need to be
exposed to a different subsystem.  Splitting the functionality into
smaller orthogonal devices makes it easier to manage data, power
management and domain-specific communication with the hardware.  Also,
common ancillary_device functionality across primary devices can be
handled by a common ancillary_device. A key requirement for such a split
is that there is no dependency on a physical bus, device, register
accesses or regmap support. These individual devices split from the core
cannot live on the platform bus as they are not physical devices that
are controlled by DT/ACPI. The same argument applies for not using MFD
in this scenario as it relies on individual function devices being
physical devices that are DT enumerated.

An example for this kind of requirement is the audio subsystem where a
single IP handles multiple entities such as HDMI, Soundwire, local
devices such as mics/speakers etc. The split for the core's
functionality can be arbitrary or be defined by the DSP firmware
topology and include hooks for test/debug. This allows for the audio
core device to be minimal and tightly coupled with handling the
hardware-specific logic and communication.

The ancillary bus is intended to be minimal, generic and avoid
domain-specific assumptions. Each ancillary bus device represents a part
of its parent functionality. The generic behavior can be extended and
specialized as needed by encapsulating an ancillary bus device within
other domain-specific structures and the use of .ops callbacks.

The SOF driver adopts the ancillary bus for implementing the
multi-client support. A client in the context of the SOF driver
represents a part of the core device's functionality. It is not a
physical device but rather an ancillary device that needs to communicate
with the DSP via IPCs. With multi-client support,the sound card can be
separated into multiple orthogonal ancillary devices for local devices
(mic/speakers etc), HDMI, sensing, probes, debug etc.  In this series,
we demonstrate the usage of the ancillary bus with the help of the IPC
test client which is used for testing the serialization of IPCs when
multiple clients talk to the DSP at the same time.

Dave Ertman (1):
  Add ancillary bus support

Fred Oh (1):
  ASoC: SOF: debug: Remove IPC flood test support in SOF core

Ranjani Sridharan (4):
  ASoC: SOF: Introduce descriptors for SOF client
  ASoC: SOF: Create client driver for IPC test
  ASoC: SOF: ops: Add ops for client registration
  ASoC: SOF: Intel: Define ops for client registration

 Documentation/driver-api/ancillary_bus.rst | 230 +++++++++++++++
 Documentation/driver-api/index.rst         |   1 +
 drivers/bus/Kconfig                        |   3 +
 drivers/bus/Makefile                       |   3 +
 drivers/bus/ancillary.c                    | 191 +++++++++++++
 include/linux/ancillary_bus.h              |  58 ++++
 include/linux/mod_devicetable.h            |   8 +
 scripts/mod/devicetable-offsets.c          |   3 +
 scripts/mod/file2alias.c                   |   8 +
 sound/soc/sof/Kconfig                      |  29 +-
 sound/soc/sof/Makefile                     |   7 +
 sound/soc/sof/core.c                       |  12 +
 sound/soc/sof/debug.c                      | 230 ---------------
 sound/soc/sof/intel/Kconfig                |   9 +
 sound/soc/sof/intel/Makefile               |   3 +
 sound/soc/sof/intel/apl.c                  |  18 ++
 sound/soc/sof/intel/bdw.c                  |  18 ++
 sound/soc/sof/intel/byt.c                  |  22 ++
 sound/soc/sof/intel/cnl.c                  |  18 ++
 sound/soc/sof/intel/intel-client.c         |  49 ++++
 sound/soc/sof/intel/intel-client.h         |  26 ++
 sound/soc/sof/ops.h                        |  14 +
 sound/soc/sof/sof-client.c                 | 117 ++++++++
 sound/soc/sof/sof-client.h                 |  65 +++++
 sound/soc/sof/sof-ipc-test-client.c        | 314 +++++++++++++++++++++
 sound/soc/sof/sof-priv.h                   |  16 +-
 26 files changed, 1233 insertions(+), 239 deletions(-)
 create mode 100644 Documentation/driver-api/ancillary_bus.rst
 create mode 100644 drivers/bus/ancillary.c
 create mode 100644 include/linux/ancillary_bus.h
 create mode 100644 sound/soc/sof/intel/intel-client.c
 create mode 100644 sound/soc/sof/intel/intel-client.h
 create mode 100644 sound/soc/sof/sof-client.c
 create mode 100644 sound/soc/sof/sof-client.h
 create mode 100644 sound/soc/sof/sof-ipc-test-client.c

-- 
2.26.2

