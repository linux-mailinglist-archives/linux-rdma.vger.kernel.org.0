Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CA4280691
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 20:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgJAS3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 14:29:36 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:45420 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgJAS3f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Oct 2020 14:29:35 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7620090000>; Fri, 02 Oct 2020 02:29:29 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 18:29:25 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 1 Oct 2020 18:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpjIZoY90XKnaxf3zYB0kKHDH2jGAaznm2XtS/4tfqa52T86Wq0Y3Qc4rdKcQs8oqozlvVlLDgIHqS+z0kFEXKEyj1lbmR4HjC2vERD82xSmk9NdPHcPx8BrH/Z1S7ERU+mSzivt29SEwetBEjF5qNxHKbncUtoYauHV3CRgIjW7APujwDnjBTKElcBtKlVYHHQjUPWI0pi6ZhdPoNfMu0SQqWkP4F0qslDD6HbniKMGHRXdelC4Pmmr0W66pDLTWfPRPVypyo3lCYly2RGjxKGlYvqFPBzeuvKvuWpG2UvrVFjxIFxT3FY40KSXIwfLbz3uM1yd0FiTsQK1RWMbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3eVgdAa5yK3wZzl2DYd38Dey5dS0wo1rBHbsEdXAc8=;
 b=nD7CXPBr7qBbiUoVaC2JU0+6rcngqkMkLzUZAhP+5MLRfmCJp9u2TfI4jVrKTjJKz6A3Q1+mbr0Z0/9X6vsb4CKzfGT3bvpGmcljr07eHlXoHOYiIO8EIrgZpFuJnibCScBK0Ijj0K2e39p85KOZUX3qz23NZNTJ8UAD7EiRwfVQmn+YzdUTEPft4V/he486sxD5R1lxbVQ6j5p0LdKdVXW2bzaFYdKDmTp68x+jSWFyC2EsthtQZ8vfhHqme5oGrBPe0G1NiXZmvOYa9U/F+hHoYgB1BrBDA+exO9KMH+naBR2OSa+vko7eg/BXDpI8kyuAFVbsbhrFeFCEs6jyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 18:29:22 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 18:29:22 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "Ertman, David M" <david.m.ertman@intel.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/6] Add ancillary bus support
Thread-Topic: [PATCH 1/6] Add ancillary bus support
Thread-Index: AQHWl7C1MSqUSmitS0u6NuJRdy7sUamCa2qAgACTjYCAAAWKgIAABlCQ
Date:   Thu, 1 Oct 2020 18:29:22 +0000
Message-ID: <BY5PR12MB4322C7955974B4DCFC8078EFDC300@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201001050534.890666-1-david.m.ertman@intel.com>
 <20201001050534.890666-2-david.m.ertman@intel.com>
 <20201001083229.GV3094@unreal>
 <DM6PR11MB2841DEF5C090BC8D830DEC52DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201001174025.GW3094@unreal>
In-Reply-To: <20201001174025.GW3094@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.172.151.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cc7340f-ebcb-4bf6-f942-08d86637eb07
x-ms-traffictypediagnostic: BYAPR12MB3222:
x-microsoft-antispam-prvs: <BYAPR12MB3222C363CA2CE6AB4BF04B00DC300@BYAPR12MB3222.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qa7hz75s93cKmW0dMt1D/Jk3kPJ6RxKUgnMbBR38x/3a4GL8zqGaRiAbP0uAx/cn/p7smR+RKus+sJ4wVCMlx81rynoqYSaXhdYwQPRGThXbbZohGo0xj/GzyZWdVUZleUp6zr7UdbIojMI7rW/8CS8OnfDROMPmZGvmRVXuez2moOks6KTFurSll4gzvT6eIyoBbq8+LTPXF1SSllD3+YX3qm17yrzAVWqBWCv0znyWxq/ldtbjUrDKwXOGq/NBLeEaSginwDPlW1Vu34c1YPCJdz2OqYAdb9M5LYuZQz6DZwFDKXd3oBkz5Of36lqxeYZAYyFCSpqXZIzo3Ji5WzPEJ0aZET5q5d8S/StKe6Ie6MAUZPe/ZGEN7UEPVxj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(8676002)(86362001)(316002)(110136005)(66556008)(66446008)(26005)(76116006)(66946007)(66476007)(64756008)(478600001)(7696005)(53546011)(71200400001)(52536014)(186003)(6506007)(55236004)(5660300002)(33656002)(83380400001)(2906002)(4326008)(9686003)(8936002)(55016002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: aqc/L4yn6j3Xot6SpJUObxZHXn3zMhYV9rYW7TXse0q0q5mTnvE7UbkNPpNBrwmRsqAXCDp8N/3dIHepQE1ppDWVgZ8+kvKlE3cGI5yQLlI9cTgBmqga2uPgq8js6BSDyl3OdYQa4WAMrnyoZyzH9RzvDXX9LsjCBECktVseE1hj5LbB7ucwsCoi9EYU3rGc7M1mWDNRjm25mJxxBVDwJGnZajTGFr7zNLvLlEDtq9mT2/r7mftAuqEBBfzsBvyBFtynRHW3wTWQBzGr+54gNqH6B5rJTREtenhsWMrjLVHQms793n+9R407wTZVDUeM+H1VcoZNkjXkvvNsOdKMPWYahva9nWQB9FNUDKb53rr2vvKD8jBUsweHRBhjv+W+kupqak5JY8crJhXuldKR+7KaBuLow3nmJz0ft78Fp4HzhT9UbD70WaaY/GjVzngzIGAu0p/6b1YMs5uZq60rOGx8Uvvj3WLuq+4Ki3HiwKSw10mzDTdx67HzX8o9Lz2i/1xoV7PTJLJ5it0jqDHAKiN1nBX+tTOq2jmpZvrygQWdaxMeI77nhMmS+Cj0/HwER6qdZ7/gK5sDGPB4emQej6DOX114qpPcRSfs2vMgqt+17BgmT8T7KPmeJdV1NxdDCW8sr4NDU1I1r8LbgFw5/A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc7340f-ebcb-4bf6-f942-08d86637eb07
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 18:29:22.3725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eUG/NuEXQGami1aySFCuqIyvwCX/zoVPsJKEwsYxew8JbYm0RnX7P1Nzsm6f42oWczb9UDS2VvTTAQt/U/crg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3222
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601576969; bh=Z3eVgdAa5yK3wZzl2DYd38Dey5dS0wo1rBHbsEdXAc8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         x-ms-exchange-transport-forked:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=CsEt8MDfZ7AtrNSpiXGECfwQs80j8rRkPLYCMujDUADHa7Mmdnh9Fta5H1JavsZ0P
         3rRAUtDfhbMyXQLuleiIJwE0mzriFk1cIXf93VcoMt07HToacRR3KXArByJCDiO2wP
         ty5MHbQ/h4VJcjq1H+mbh7+N3sbZWebLm4PjAEWb3kgHVcIJfvAhJcUk/fLiWs02X5
         6YcwBadLHMXG9fG6fiDAmphTCO2LeSMDdBUAjp/kKBc7MC7++9jAradZEw+jFnLZ3L
         DR5E5Jon8PB7Z+o/Z3IIxlWJ+GK+4nTZSrSh1kJ8WC1Daa/LM2q15OKh8zmY0FjjjH
         kmP3Gm8/+JLLw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, October 1, 2020 11:10 PM
>=20
> On Thu, Oct 01, 2020 at 05:20:35PM +0000, Ertman, David M wrote:
> > > -----Original Message-----
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Thursday, October 1, 2020 1:32 AM
> > > To: Ertman, David M <david.m.ertman@intel.com>
> > > Cc: linux-rdma@vger.kernel.org
> > > Subject: Re: [PATCH 1/6] Add ancillary bus support
> > >
> > > On Wed, Sep 30, 2020 at 10:05:29PM -0700, Dave Ertman wrote:
> > > > Add support for the Ancillary Bus, ancillary_device and ancillary_d=
river.
> > > > It enables drivers to create an ancillary_device and bind an
> > > > ancillary_driver to it.
> > > >
> > > > The bus supports probe/remove shutdown and suspend/resume
> callbacks.
> > > > Each ancillary_device has a unique string based id; driver binds
> > > > to an ancillary_device based on this id through the bus.
> > > >
> > > > Co-developed-by: Kiran Patil <kiran.patil@intel.com>
> > > > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > > > Co-developed-by: Ranjani Sridharan
> > > > <ranjani.sridharan@linux.intel.com>
> > > > Signed-off-by: Ranjani Sridharan
> > > > <ranjani.sridharan@linux.intel.com>
> > > > Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> > > > Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> > > > Reviewed-by: Pierre-Louis Bossart
> > > > <pierre-louis.bossart@linux.intel.com>
> > > > Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > > > Reviewed-by: Parav Pandit <parav@mellanox.com>
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > > > ---
> > > >  Documentation/driver-api/ancillary_bus.rst | 230
> > > +++++++++++++++++++++
> > > >  Documentation/driver-api/index.rst         |   1 +
> > > >  drivers/bus/Kconfig                        |   3 +
> > > >  drivers/bus/Makefile                       |   3 +
> > > >  drivers/bus/ancillary.c                    | 191 +++++++++++++++++
> > > >  include/linux/ancillary_bus.h              |  58 ++++++
> > > >  include/linux/mod_devicetable.h            |   8 +
> > > >  scripts/mod/devicetable-offsets.c          |   3 +
> > > >  scripts/mod/file2alias.c                   |   8 +
> > > >  9 files changed, 505 insertions(+)  create mode 100644
> > > > Documentation/driver-api/ancillary_bus.rst
> > > >  create mode 100644 drivers/bus/ancillary.c  create mode 100644
> > > > include/linux/ancillary_bus.h
> > > >
> > > > diff --git a/Documentation/driver-api/ancillary_bus.rst
> > > b/Documentation/driver-api/ancillary_bus.rst
> > > > new file mode 100644
> > > > index 000000000000..0a11979aa927
> > > > --- /dev/null
> > > > +++ b/Documentation/driver-api/ancillary_bus.rst
> > > > @@ -0,0 +1,230 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +Ancillary Bus
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +In some subsystems, the functionality of the core device
> > > (PCI/ACPI/other) is
> > > > +too complex for a single device to be managed as a monolithic
> > > > +block or a
> > > part of
> > > > +the functionality needs to be exposed to a different subsystem.
> > > > +Splitting
> > > the
> > > > +functionality into smaller orthogonal devices would make it
> > > > +easier to
> > > manage
> > > > +data, power management and domain-specific interaction with the
> > > hardware. A key
> > > > +requirement for such a split is that there is no dependency on a
> > > > +physical
> > > bus,
> > > > +device, register accesses or regmap support. These individual
> > > > +devices split
> > > from
> > > > +the core cannot live on the platform bus as they are not physical
> > > > +devices
> > > that
> > > > +are controlled by DT/ACPI. The same argument applies for not
> > > > +using MFD
> > > in this
> > > > +scenario as MFD relies on individual function devices being
> > > > +physical
> > > devices
> > > > +that are DT enumerated.
> > > > +
> > > > +An example for this kind of requirement is the audio subsystem
> > > > +where a
> > > single
> > > > +IP is handling multiple entities such as HDMI, Soundwire, local
> > > > +devices
> > > such as
> > > > +mics/speakers etc. The split for the core's functionality can be
> > > > +arbitrary or be defined by the DSP firmware topology and include
> > > > +hooks for
> > > test/debug. This
> > > > +allows for the audio core device to be minimal and focused on
> > > > +hardware-
> > > specific
> > > > +control and communication.
> > > > +
> > > > +The ancillary bus is intended to be minimal, generic and avoid
> > > > +domain-
> > > specific
> > > > +assumptions. Each ancillary_device represents a part of its
> > > > +parent functionality. The generic behavior can be extended and
> > > > +specialized as
> > > needed
> > > > +by encapsulating an ancillary_device within other domain-specific
> > > structures and
> > > > +the use of .ops callbacks. Devices on the ancillary bus do not
> > > > +share any structures and the use of a communication channel with
> > > > +the parent is domain-specific.
> > > > +
> > > > +When Should the Ancillary Bus Be Used
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +The ancillary bus is to be used when a driver and one or more
> > > > +kernel
> > > modules,
> > > > +who share a common header file with the driver, need a mechanism
> > > > +to
> > > connect and
> > > > +provide access to a shared object allocated by the
> > > > +ancillary_device's registering driver.  The registering driver
> > > > +for the ancillary_device(s) and
> > > the
> > > > +kernel module(s) registering ancillary_drivers can be from the
> > > > +same
> > > subsystem,
> > > > +or from multiple subsystems.
> > > > +
> > > > +The emphasis here is on a common generic interface that keeps
> > > subsystem
> > > > +customization out of the bus infrastructure.
> > > > +
> > > > +One example could be a multi-port PCI network device that is
> > > > +rdma-
> > > capable and
> > > > +needs to export this functionality and attach to an rdma driver
> > > > +in another subsystem.  The PCI driver will allocate and register
> > > > +an ancillary_device for each physical function on the NIC.  The
> > > > +rdma driver will register an ancillary_driver that will be
> > > > +matched with and probed for each of these ancillary_devices.
> > > > +This will give the rdma driver access to the shared
> > > data/ops
> > > > +in the PCI drivers shared object to establish a connection with
> > > > +the PCI
> > > driver.
> > > > +
> > > > +Another use case is for the a PCI device to be split out into
> > > > +multiple sub functions.  For each sub function an
> > > > +ancillary_device will be created.  A PCI sub function driver will
> > > > +bind to such devices that will create its own one or more class
> > > > +devices.  A PCI sub function ancillary device will likely be
> > > > +contained in a struct with additional attributes such as user
> > > > +defined sub function number and optional attributes such as
> > > > +resources and a link to
> > > the
> > > > +parent device.  These attributes could be used by systemd/udev;
> > > > +and
> > > hence should
> > > > +be initialized before a driver binds to an ancillary_device.
> > > > +
> > > > +Ancillary Device
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +An ancillary_device is created and registered to represent a part
> > > > +of its
> > > parent
> > > > +device's functionality. It is given a name that, combined with
> > > > +the
> > > registering
> > > > +drivers KBUILD_MODNAME, creates a match_name that is used for
> > > > +driver
> > > binding,
> > > > +and an id that combined with the match_name provide a unique name
> > > > +to
> > > register
> > > > +with the bus subsystem.
> > > > +
> > > > +Registering an ancillary_device is a two-step process.  First you
> > > > +must call ancillary_device_initialize(), which will check several
> > > > +aspects of the ancillary_device struct and perform a
> > > > +device_initialize().  After this step completes, any error state
> > > > +must have a call to put_device() in its
> > > resolution
> > > > +path.  The second step in registering an ancillary_device is to
> > > > +perform a
> > > call
> > > > +to ancillary_device_add(), which will set the name of the device
> > > > +and add
> > > the
> > > > +device to the bus.
> > > > +
> > > > +To unregister an ancillary_device, just a call to
> > > ancillary_device_unregister()
> > > > +is used.  This will perform both a device_del() and a put_device()=
.
> > >
> > > Why did you chose ancillary_device_initialize() and not
> > > ancillary_device_register() to be paired with
> ancillary_device_unregister()?
> > >
> > > Thanks
> >
> > We originally had a single call to ancillary_device_register() that
> > paired with unregister, but there was an ask to separate the register
> > into an initialize and add to make the error condition unwind more
> compartimentalized.
>=20
> It is correct thing to separate, but I would expect:
> ancillary_device_register()
> ancillary_device_add()
>=20
device_initialize(), device_add() and device_unregister() is the pattern wi=
dely followed in the core.

> vs.
> ancillary_device_unregister()
>=20
> It is not a big deal, just curious.
>=20
> The much more big deal is that I'm required to create 1-to-1 mapping
> between device and driver, and I can't connect all my different modules t=
o
> one xxx_core.pf.y device in N-to-1 mapping. "N" represents different
> protocols (IB, ETH, SCSI) and "1" is one PCI core.

For one mlx5 (pf/vf/sf) device, there are three class erivers (ib, vdpa, en=
).

So there should be one ida allocate per mlx5 device type.

Static const mlx5_adev_names[MLX5_INTERFACE_PROTOCOL_MAX] =3D {
	"rdma",
	"eth",
	"vdpa"
};
=09
Something like for current mlx5_register_device(),
mlx5_register_device()
{
	id =3D ida_alloc(0, UINT_MAX, GFP_KERNEL);

	for (i =3D 0; I < MLX5_INTERFACE_PROTOCOL_MAX; i++) {
		adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
		adev.name =3D mlx5_adev_names[i];
		adev.id =3D ret;
		adev.dev.parent =3D mlx5_core_dev->device;
		adev->coredev =3D mlx5_core_dev;
		ret =3D ancillary_device_initialize(&adev);=09
		ret =3D ancillary_device_register(adev);
}

This will create 3 ancillary devices for each PCI PF/VF/SF.
mlx5_core.rdma.1
mlx5_core.eth.1
mlx5_core.vdpa.1

and mlx5_ib driver will do

ancillary_driver_register()
{
	For ID of mlx5_core.rdma.
}

mlx5_vdpa driver does,

ancillary_driver_register()
{
	For ID of mlx5_core.vdpa
}

This is uniform for pf/vf/sf for one or more all protocols.
