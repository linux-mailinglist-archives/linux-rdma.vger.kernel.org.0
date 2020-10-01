Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B9280505
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbgJARUw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:20:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:16739 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARUw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Oct 2020 13:20:52 -0400
IronPort-SDR: o+hwg5fLBimvw7huyPHXrLMkXZAZSZJGKvZ0BdkQuG8wgv/7lyUrya+7OEYfG3TjbL6DmFO4Fr
 jLmYB8uwN3cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="226907371"
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="226907371"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 10:20:49 -0700
IronPort-SDR: eHu+/zlGhMZoDlVQWZWN9JLrPQK7kOjQevqD8FgEj+fVxULt2kacejXbZBzNltb3jQ2kRR+eY9
 EoYpA/NQu5/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="385608264"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 01 Oct 2020 10:20:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Oct 2020 10:20:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 1 Oct 2020 10:20:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 1 Oct 2020 10:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEiD5XMAp2l/QR+3ijc1r1R3XJxXcF/U+OGkzCxHILRnIuLmbpzbkoTMiHZ6DLcWvw8qG6ueVdXPqxBmumSes1c9pzHuTQFkGLDWlgEC1vTUpFgQT6d9PdXg8W66u5zusx4nrj86imyCDGwoM0t8vL6N1qXURke2sUToNMwFTLeJpmFnyWQe+g0tgG3qISP6/0tpQFzqoBBX91GTD2HTJrNdhKU7iqLKITbI8yfBrdC4r4nz+WyfuSKoPbt0IE8kKK6BDaQtwYN+CVv9ImwKOBvhD1b8XQyqNOQo1GCrOnMrPZGrGy7J6XEz6bFNAY4UQ3aVQ1jlmlB/p5S4lPt2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovNcUJ6S2jdbDy7oS/y12LYY6lClGNvTaXCw1Yb7ro4=;
 b=Zm4J0pWwekcZMepHha/jy+rKcVBejXwrhaK2CXthyvC9opesNcoVv4I2OZdocifu4u5DPGsZcIs7pw7RtuWI0CLqXkVSA62FRSNPcKOj/yAOqBLqveHqII9Gx1oeFQFFjkm3pKlP2Qmx2RbyncMXkoa995DVPXxoZYIZYSg1tJw/ik1hzzgBpu3MoFiCPYd2sgrD1v5tFg/6mVNaMXEz1ihT1mwfJ0LwEFsUhU2RMGUmEGDKMw5cutA0u3qIaIPUSD7LotDOkkXVNZj/iMeqkGjI9RT/IAVFnv9DhKufG8nYck1mA7I46ZpEgoFWwDZh5QjRn3PVogspCGU34rZEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovNcUJ6S2jdbDy7oS/y12LYY6lClGNvTaXCw1Yb7ro4=;
 b=q5EzWFIvwfHKbmWswdXlC8ABMhDHwxrTA36s1KQF7xm5gbsMPu5AmQtEEgGyQuKIz8jkCob+XlvwOKxsqb10nngBMV8uAKPrzMwt+V1d0wEOi+eSMma4Nk/FtLZ7v7h1GveWhuHtmz7HYBAznJcjatgPhyrfXL1oRZ5z/Crbc+E=
Received: from DM6PR11MB2841.namprd11.prod.outlook.com (2603:10b6:5:c8::32) by
 DM6PR11MB2618.namprd11.prod.outlook.com (2603:10b6:5:c0::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.25; Thu, 1 Oct 2020 17:20:35 +0000
Received: from DM6PR11MB2841.namprd11.prod.outlook.com
 ([fe80::6d8e:9b06:ef72:2a]) by DM6PR11MB2841.namprd11.prod.outlook.com
 ([fe80::6d8e:9b06:ef72:2a%5]) with mapi id 15.20.3433.035; Thu, 1 Oct 2020
 17:20:35 +0000
From:   "Ertman, David M" <david.m.ertman@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/6] Add ancillary bus support
Thread-Topic: [PATCH 1/6] Add ancillary bus support
Thread-Index: AQHWl7C2Zoxzt0/NcE+ZrGUsQliUQamCa2qAgACTDpA=
Date:   Thu, 1 Oct 2020 17:20:35 +0000
Message-ID: <DM6PR11MB2841DEF5C090BC8D830DEC52DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
References: <20201001050534.890666-1-david.m.ertman@intel.com>
 <20201001050534.890666-2-david.m.ertman@intel.com>
 <20201001083229.GV3094@unreal>
In-Reply-To: <20201001083229.GV3094@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.38.47.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a8b083e-0f06-4e7b-384a-08d8662e4ef9
x-ms-traffictypediagnostic: DM6PR11MB2618:
x-microsoft-antispam-prvs: <DM6PR11MB26189075486356B24EAB5656DD300@DM6PR11MB2618.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r79P7/JOxxmFSb21xmjcTiS38iu90kgRxbGn1bbBHHR+VMXX54cwGFqF/2SJzbWG4zD+TKXGRpDyNX30QNO/62EkfVjhCyi4eTMubyOJgp9LU2beFHiy0vYcuMlp9aZD/SjYSQ7Fyq3GX4qf6vQWKF58vNJ8NDTdHiO6UQhzVNWEL0Mq0UWF3uG93RUrTrFxOZ+s5CaFmUs2j84WAjsYfYpHt1oeJYes3ZtCgXDYOEGfQnLNx08LU/Zl3LHwZ65E4xpTOLPHWsyshxbvr00oRVVl8tsX7jM9aFiu2f+GITqW+fw/JUfHIrJ+Sq03RM1o0pPcGGWpxn6kpWDdJk9bxhlYScbnIiZ0uywEl2R7qApluIVWoqjKiwbq/Fba6ACy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2841.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(71200400001)(66946007)(478600001)(2906002)(8936002)(26005)(5660300002)(6506007)(4326008)(186003)(53546011)(52536014)(55016002)(8676002)(83380400001)(86362001)(9686003)(316002)(66476007)(64756008)(66446008)(66556008)(76116006)(6916009)(33656002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bfnKesIbLaqwirOtbq74s2nGwVSGad1Scq3BnatZQtPLnO96/X0H6Ch13WuZwttVZFyqU7KWsQEXVY/Aceo/t5B8w7JyFAlc/BtWBU6+gQrACWDMQp07w5dJw8lWmEDBa58SwaW+3mkVg/NjDO6ocixj3wemFiM3O9V+PGfGyEaUjeByuZOwLje3HCqZgtBuISQkIAZyCcm+1HZ9F6h1BuF3xAY34aIL3uaHyrJhrC1+CJeCTOXwRjnUn7p0vX64YhLMykPK88yCgQrDyAYD8WqU0Bk6dIlI2v3f0xlLF7SVpPs0k0FbjrQZFphRn/O85kxCN9dhFa00truHzSx6TmO/amwgQBMheRFtqwcHJNhlj0u8HLG4gvk4/HySJntJcjnCwfRcjyKsCX/FmH/X3KluE2AfWcwpbrMKhA/A9BhTGXlI2H/oGVXAkUFfjjAtjji1+dysiu8JRA33lEZBdNMu18/BIPfkEzowAmPdEETqx4KfrFri6jCm8MudV6jM1PZ9cbBMKl1U91TWX1bm8K16+cKk420VtHXoWdvRbhKF9/O0yybAKBCvQb2Ntd4TRjB0Sy5gbPSRs3/qyFQeo4LMjT7f13npPqhG5McmB7EJ0KC5Emfe6WTSX81fuwAibb67WyoRWRcibxmxcSu2TQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2841.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8b083e-0f06-4e7b-384a-08d8662e4ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 17:20:35.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cW6+R7qUI5bUBPPQshEvYEj+bHyY1bRxW/7vUWJ0NxZbVkTE1DGu0hiyfKqX3hF4ZCORMjzsTtNbRocyfaT4aeIpwy5kYuhsqSs5tZeapyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2618
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, October 1, 2020 1:32 AM
> To: Ertman, David M <david.m.ertman@intel.com>
> Cc: linux-rdma@vger.kernel.org
> Subject: Re: [PATCH 1/6] Add ancillary bus support
>=20
> On Wed, Sep 30, 2020 at 10:05:29PM -0700, Dave Ertman wrote:
> > Add support for the Ancillary Bus, ancillary_device and ancillary_drive=
r.
> > It enables drivers to create an ancillary_device and bind an
> > ancillary_driver to it.
> >
> > The bus supports probe/remove shutdown and suspend/resume callbacks.
> > Each ancillary_device has a unique string based id; driver binds to
> > an ancillary_device based on this id through the bus.
> >
> > Co-developed-by: Kiran Patil <kiran.patil@intel.com>
> > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > Co-developed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> > Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com=
>
> > Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > Reviewed-by: Parav Pandit <parav@mellanox.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > ---
> >  Documentation/driver-api/ancillary_bus.rst | 230
> +++++++++++++++++++++
> >  Documentation/driver-api/index.rst         |   1 +
> >  drivers/bus/Kconfig                        |   3 +
> >  drivers/bus/Makefile                       |   3 +
> >  drivers/bus/ancillary.c                    | 191 +++++++++++++++++
> >  include/linux/ancillary_bus.h              |  58 ++++++
> >  include/linux/mod_devicetable.h            |   8 +
> >  scripts/mod/devicetable-offsets.c          |   3 +
> >  scripts/mod/file2alias.c                   |   8 +
> >  9 files changed, 505 insertions(+)
> >  create mode 100644 Documentation/driver-api/ancillary_bus.rst
> >  create mode 100644 drivers/bus/ancillary.c
> >  create mode 100644 include/linux/ancillary_bus.h
> >
> > diff --git a/Documentation/driver-api/ancillary_bus.rst
> b/Documentation/driver-api/ancillary_bus.rst
> > new file mode 100644
> > index 000000000000..0a11979aa927
> > --- /dev/null
> > +++ b/Documentation/driver-api/ancillary_bus.rst
> > @@ -0,0 +1,230 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Ancillary Bus
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +In some subsystems, the functionality of the core device
> (PCI/ACPI/other) is
> > +too complex for a single device to be managed as a monolithic block or=
 a
> part of
> > +the functionality needs to be exposed to a different subsystem.  Split=
ting
> the
> > +functionality into smaller orthogonal devices would make it easier to
> manage
> > +data, power management and domain-specific interaction with the
> hardware. A key
> > +requirement for such a split is that there is no dependency on a physi=
cal
> bus,
> > +device, register accesses or regmap support. These individual devices =
split
> from
> > +the core cannot live on the platform bus as they are not physical devi=
ces
> that
> > +are controlled by DT/ACPI. The same argument applies for not using MFD
> in this
> > +scenario as MFD relies on individual function devices being physical
> devices
> > +that are DT enumerated.
> > +
> > +An example for this kind of requirement is the audio subsystem where a
> single
> > +IP is handling multiple entities such as HDMI, Soundwire, local device=
s
> such as
> > +mics/speakers etc. The split for the core's functionality can be arbit=
rary or
> > +be defined by the DSP firmware topology and include hooks for
> test/debug. This
> > +allows for the audio core device to be minimal and focused on hardware=
-
> specific
> > +control and communication.
> > +
> > +The ancillary bus is intended to be minimal, generic and avoid domain-
> specific
> > +assumptions. Each ancillary_device represents a part of its parent
> > +functionality. The generic behavior can be extended and specialized as
> needed
> > +by encapsulating an ancillary_device within other domain-specific
> structures and
> > +the use of .ops callbacks. Devices on the ancillary bus do not share a=
ny
> > +structures and the use of a communication channel with the parent is
> > +domain-specific.
> > +
> > +When Should the Ancillary Bus Be Used
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The ancillary bus is to be used when a driver and one or more kernel
> modules,
> > +who share a common header file with the driver, need a mechanism to
> connect and
> > +provide access to a shared object allocated by the ancillary_device's
> > +registering driver.  The registering driver for the ancillary_device(s=
) and
> the
> > +kernel module(s) registering ancillary_drivers can be from the same
> subsystem,
> > +or from multiple subsystems.
> > +
> > +The emphasis here is on a common generic interface that keeps
> subsystem
> > +customization out of the bus infrastructure.
> > +
> > +One example could be a multi-port PCI network device that is rdma-
> capable and
> > +needs to export this functionality and attach to an rdma driver in ano=
ther
> > +subsystem.  The PCI driver will allocate and register an ancillary_dev=
ice for
> > +each physical function on the NIC.  The rdma driver will register an
> > +ancillary_driver that will be matched with and probed for each of thes=
e
> > +ancillary_devices.  This will give the rdma driver access to the share=
d
> data/ops
> > +in the PCI drivers shared object to establish a connection with the PC=
I
> driver.
> > +
> > +Another use case is for the a PCI device to be split out into multiple=
 sub
> > +functions.  For each sub function an ancillary_device will be created.=
  A PCI
> > +sub function driver will bind to such devices that will create its own=
 one or
> > +more class devices.  A PCI sub function ancillary device will likely b=
e
> > +contained in a struct with additional attributes such as user defined =
sub
> > +function number and optional attributes such as resources and a link t=
o
> the
> > +parent device.  These attributes could be used by systemd/udev; and
> hence should
> > +be initialized before a driver binds to an ancillary_device.
> > +
> > +Ancillary Device
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +An ancillary_device is created and registered to represent a part of i=
ts
> parent
> > +device's functionality. It is given a name that, combined with the
> registering
> > +drivers KBUILD_MODNAME, creates a match_name that is used for driver
> binding,
> > +and an id that combined with the match_name provide a unique name to
> register
> > +with the bus subsystem.
> > +
> > +Registering an ancillary_device is a two-step process.  First you must=
 call
> > +ancillary_device_initialize(), which will check several aspects of the
> > +ancillary_device struct and perform a device_initialize().  After this=
 step
> > +completes, any error state must have a call to put_device() in its
> resolution
> > +path.  The second step in registering an ancillary_device is to perfor=
m a
> call
> > +to ancillary_device_add(), which will set the name of the device and a=
dd
> the
> > +device to the bus.
> > +
> > +To unregister an ancillary_device, just a call to
> ancillary_device_unregister()
> > +is used.  This will perform both a device_del() and a put_device().
>=20
> Why did you chose ancillary_device_initialize() and not
> ancillary_device_register() to be paired with ancillary_device_unregister=
()?
>=20
> Thanks

We originally had a single call to ancillary_device_register() that paired =
with
unregister, but there was an ask to separate the register into an initializ=
e and
add to make the error condition unwind more compartimentalized.

-DaveE
