Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2E280F24
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 10:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgJBImX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 04:42:23 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:6778 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBImX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 04:42:23 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f76e7ea0000>; Fri, 02 Oct 2020 16:42:18 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 08:42:17 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 08:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xrc9VU9lf8NwT6xTqMsRur7mQDmCr/a/bI8DKQqMUaj/I+L5fq4smVdlaBqw5RV1OUEuGvFKrIrNAOhJhTlkhP0jWs/QOw8akPscrRBvt+Q46OM3e85e6qGKDp8WGz36YUYmWnVg7nl3PZ3s99/gVFg/F/qXf95N36/prOFpyD9JFMfnf8Cy/N52275IPJ4bzcB4er5aZ+Sfc6K5z0btJyedWITUsH1PodX3YDFrzuaAUss5tQqjQVFyo/M1FGieq6TP3SAB7XwzxrtfY4cMz/OAGH2UNmHL/MdAJfLDRVpHlWqXFoB2KsHKPYUfXlYGe+uHndD+Eima5UeFAIVQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg9+dh5VvYOkvgsovhs1/blIgT19DXmU9w6zK7hXq0E=;
 b=UVavdoynDwjsaDUpqGXi2Al6+xmR43EjKpelN+vZjv6KKSW7oJsfVNo/g7ET7cci9MhNwBKV1ruycGXToodMCarR9HcqG/B1NB1mmZBlK49ZNWzl8+G6M1rMqqnakNfqvhRyP1P8ePSXQibb/LqK+rFJKN9I6vTwy3q5JGU2i8gGsKaWjAAp1x2v2xDpbSxmQlvPxlMxhmkYuWruVNa85EtM3s5TdkaEJnFYuNAhzuCl6Yt5YSvflWEoANXYgi4GR1B9rSdXwIKy3D1Q5BntbjoMA9LP1OvNqhRf3m5VrVk0d05Tnui50mDbontBAx5TjzD/16Atjb91S2F3apMeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 08:42:14 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%6]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 08:42:14 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "Ertman, David M" <david.m.ertman@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/6] Add ancillary bus support
Thread-Topic: [PATCH 1/6] Add ancillary bus support
Thread-Index: AQHWl7C1MSqUSmitS0u6NuJRdy7sUamCa2qAgACTjYCAAAWKgIAABlCQgAAY64CAAKN2UIAAEZaAgAAjU/A=
Date:   Fri, 2 Oct 2020 08:42:13 +0000
Message-ID: <BY5PR12MB4322C2E2E726DCF700802104DC310@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201001050534.890666-1-david.m.ertman@intel.com>
 <20201001050534.890666-2-david.m.ertman@intel.com>
 <20201001083229.GV3094@unreal>
 <DM6PR11MB2841DEF5C090BC8D830DEC52DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201001174025.GW3094@unreal>
 <BY5PR12MB4322C7955974B4DCFC8078EFDC300@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201001193211.GX3094@unreal>
 <BY5PR12MB4322EDDDF036BB58DE3A1F7BDC310@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201002062011.GY3094@unreal>
In-Reply-To: <20201002062011.GY3094@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.172.151.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7620c440-db02-48a0-5450-08d866af0fba
x-ms-traffictypediagnostic: BY5PR12MB4195:
x-microsoft-antispam-prvs: <BY5PR12MB419524744AED0EC2116DBF5FDC310@BY5PR12MB4195.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ucaaB9jpvzVmCPZcf1/qDA0fmZqEOmo1olIKAOT0lpBBVYVG1BztwRgeaiMgUFxyRUqg2N0HuSAYK74i1MMmsy1ePVo7lg9Wizlsp29KfumDh0xnqTUGgfl4eUW6unuSOv7WpnzvESRGSMA5/wg1RzQ2GxcyC0tGP9SLwa7P9zgw2GJrM2yKh/T0cR6iVzxLkJLlSJRK8q6jmx/DfQdIIetP+MZTEzVSAeNjM1zviv3rns1yofVzb4zPwwnoZlt0VlcQmyreprkzy3KhN60HHYkB5vPV3SXDzG6o8xm6XLE13ykEj/EVd//nlPcrTUQ2076cgj0jCet5uWylQSwcyl6Dyc3D+IbUjJubLvVKj0nBNWIW7EPfw+mHBYIzYfoj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(9686003)(478600001)(8676002)(64756008)(7696005)(186003)(66946007)(4326008)(54906003)(86362001)(66476007)(316002)(2906002)(8936002)(55236004)(55016002)(6506007)(66446008)(33656002)(83380400001)(71200400001)(26005)(52536014)(5660300002)(6916009)(66556008)(76116006)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jnsXEe/sBjk+FnQoCwZa1n86tzsrrT2XmQiWn/3jwC1bUFGS5E0ECT9lZDNziupJjbHZl9p/zzUhQN59lF04l8B9BuwPHMr1bA9oFvgff5Y8K7COsaAqAjBNO6KpMG1e6SiPJVlKDb19/3rX/yaYMJgSkAd7jQ/Cc/1Ct6OSqOwdU2L8giKMPewsROX7B32bzObJ3oFdpoVEtdzvTma2RC4Kf7S8OBGoqzuhMEyKQTuX4CuQuNlbS0fBe/5gfkuNarpB8bbVkob1k/cFXVslRfdSchcz27qKv5idyGmaY9fT2uB7liD3Bu9GAfprIBY/bpn1vMEeKiTbQ4s2ItSUcx/ce7GpTdrvzmDjwHs6L5T9asX6Gck9vUVEcBR5SaO39grsxlbanMf6hZ8DOESEw3llF01YsJB7x/nL1S8uCAT5Ugp5QQPifGQVtBse0+JV1vVI+josTus4EtPiMHzjcXIX5MCzQDPAKKryFZXagdkPA7wMfHK6Z41SNohmIESB+UMHtVqyDNWxMcRR5HjH1pgz579ob45OXv8fWt3GPMd2RtY+f4rujhZZ9uPEp0sGSIB9jkBuvSr5gebYX/5YC8ohBKFXeeXqsQqTqNZIhduXPVPHoEqxiKiclXUHVHSmGnKEP8juUr8oy7CUSlOQQg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7620c440-db02-48a0-5450-08d866af0fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 08:42:14.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+Uo8s6e++sUTUk9t35XcAf3ZL6a7rNzFKKHj+NtWrpgz0JlFvE/mlT6vPsfkQvo3tQTNA+QPm1oKvNALfclGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601628138; bh=jg9+dh5VvYOkvgsovhs1/blIgT19DXmU9w6zK7hXq0E=;
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
        b=HWmbg9Kzb4uq1BHcdXRWXDkVjSg4J9LEtSrVAxHCTN78dyBuEf3vis5pWwvdYyuCB
         2WKkUlSR9MWQnwtSYfP9fynQT6Muuy9OojZMZSU4PR6ANnjzUy+LG7siv4gJVjIv+Q
         /FaMZfU5gql7GyqMMT+HgkldmpzAtharAVZIWoOSvEKkcmMZy7SCA6oup5AuWLhsJc
         Cc/rtE0roveurHpohpEAfLhvQftVOxDtLnl03Qsi04r+GGh0wuI/yWoFhk5+ikLRvG
         yRETYTBNyCACkiwqQ9LR957GNI/uha2XpkAlQSKkmWq9sBTJwdIZIFXTz2k5NkMvRC
         qxVFr2v1MKBnQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Leon Romanovsky <leon@kernel.org>
> Sent: Friday, October 2, 2020 11:50 AM
>=20
> On Fri, Oct 02, 2020 at 05:29:26AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Friday, October 2, 2020 1:02 AM
> >
> > > > > > > > +Registering an ancillary_device is a two-step process.
> > > > > > > > +First you must call ancillary_device_initialize(), which
> > > > > > > > +will check several aspects of the ancillary_device struct
> > > > > > > > +and perform a device_initialize().  After this step
> > > > > > > > +completes, any error state must have a call to
> > > > > > > > +put_device() in its
> > > > > > > resolution
> > > > > > > > +path.  The second step in registering an ancillary_device
> > > > > > > > +is to perform a
> > > > > > > call
> > > > > > > > +to ancillary_device_add(), which will set the name of the
> > > > > > > > +device and add
> > > > > > > the
> > > > > > > > +device to the bus.
> > > > > > > > +
> > > > > > > > +To unregister an ancillary_device, just a call to
> > > > > > > ancillary_device_unregister()
> > > > > > > > +is used.  This will perform both a device_del() and a
> put_device().
> > > > > > >
> > > > > > > Why did you chose ancillary_device_initialize() and not
> > > > > > > ancillary_device_register() to be paired with
> > > > > ancillary_device_unregister()?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > We originally had a single call to ancillary_device_register()
> > > > > > that paired with unregister, but there was an ask to separate
> > > > > > the register into an initialize and add to make the error
> > > > > > condition unwind more
> > > > > compartimentalized.
> > > > >
> > > > > It is correct thing to separate, but I would expect:
> > > > > ancillary_device_register()
> > > > > ancillary_device_add()
> > > > >
> > > > device_initialize(), device_add() and device_unregister() is the
> > > > pattern widely
> > > followed in the core.
> > >
> > > It doesn't mean that I need to agree with that, right?
> > >
> > Right. May be I misunderstood your comment where you said "I expect
> device_register() and device_add()" in response to "device_initialize() a=
nd
> device_add".
> > I interpreted your comment as to replace initialize() with register().
> > Because that is odd naming and completely out of sync from the core API=
s.
> >
> > A helper like below that wraps initialize() and add() is buggy, because=
 when
> register() returns an error, it doesn't know if should do kfree() or
> put_device().
>=20
> I wrote above (14 lines above this line) that I understand and support th=
e
> request to separate init and add parts. There is only one thing that I di=
dn't
> like that we have _unregister() but don't have _register().
> It is not a big deal.
>=20
> >
> > ancillary_device_register(adev)
> > {
> >   ret =3D ancillary_device_initialize();
> >   if (ret)
> >     return ret;
> >
> >   ret =3D ancillary_device_add();
> >   if (ret)
> >     put_device(dev);
> >   return ret;
> > }
> >
> > > >
> > > > > vs.
> > > > > ancillary_device_unregister()
> > > > >
> > > > > It is not a big deal, just curious.
> > > > >
> > > > > The much more big deal is that I'm required to create 1-to-1
> > > > > mapping between device and driver, and I can't connect all my
> > > > > different modules to one xxx_core.pf.y device in N-to-1 mapping. =
"N"
> > > > > represents different protocols (IB, ETH, SCSI) and "1" is one PCI=
 core.
> > > >
> > > > For one mlx5 (pf/vf/sf) device, there are three class erivers (ib, =
vdpa,
> en).
> > > >
> > > > So there should be one ida allocate per mlx5 device type.
> > > >
> > > > Static const mlx5_adev_names[MLX5_INTERFACE_PROTOCOL_MAX] =3D
> {
> > > > 	"rdma",
> > > > 	"eth",
> > > > 	"vdpa"
> > > > };
> > > >
> > > > Something like for current mlx5_register_device(),
> > >
> > > I know it and already implemented it, this is why I'm saying that it
> > > is not what I would expect from the implementation.
> > >
> > > It is wrong create mlx5_core.rdma.1 device that is equal to
> > > mlx5_core.eth.1 just to connect our mlx5_ib.ko to it, while
> > > documentation explains about creating
> >
> > Ancillary bus's documentation? If so, it should be corrected.
> > Do you have specific text snippet to point to that should be fixed?
>=20
> +One example could be a multi-port PCI network device that is
> +rdma-capable and needs to export this functionality and attach to an
> +rdma driver in another subsystem.  The PCI driver will allocate and
> +register an ancillary_device for each physical function on the NIC.
> +The rdma driver will register an ancillary_driver that will be matched
> +with and probed for each of these ancillary_devices.  This will give
> +the rdma driver access to the shared data/ops in the PCI drivers shared
> object to establish a connection with the PCI driver.
>=20
> >
> > For purpose of matching service functionality, for each different class=
 (ib,
> eth, vdpa) there is one ancillary device created.
> > What exactly is wrong here? (and why is it wrong now and not in
> > previous version of the RFC?)
>=20
> Here the example of two real systems, see how many links we created to
> same mlx5_core PCI logic. I imagine that Qlogic and Chelsio drivers will =
look
> even worse, because they spread over more subsystems than mlx5.
>=20
> This is first time when I see real implementation of real device.
>=20
> System with 2 IB and 1 RoCE cards:
> [leonro@vm ~]$ ls -l /sys/bus/ancillary/devices/
>  mlx5_core.eth.0 -> ../../../devices/pci0000:00/0000:00:09.0/mlx5_core.et=
h.0
>  mlx5_core.eth.1 -> ../../../devices/pci0000:00/0000:00:0a.0/mlx5_core.et=
h.1
>  mlx5_core.eth.2 -> ../../../devices/pci0000:00/0000:00:0b.0/mlx5_core.et=
h.2
This gives you the ability to not load the netdevice and rdma device of a V=
F and only load the vdpa device.
These are real use case that users have asked for.
In use case one, they are only interested in rdma device.
In second use case only vdpa device.
How shall one achieve that without spinning of the device for each class?

>  mlx5_core.ib.0 -> ../../../devices/pci0000:00/0000:00:09.0/mlx5_core.ib.=
0
>  mlx5_core.ib.1 -> ../../../devices/pci0000:00/0000:00:0a.0/mlx5_core.ib.=
1
>  mlx5_core.ib.2 -> ../../../devices/pci0000:00/0000:00:0b.0/mlx5_core.ib.=
2
>  mlx5_core.vdpa.0 -> ../../../devices/pci0000:00/0000:00:09.0/mlx5_core.i=
b.0
>  mlx5_core.vdpa.1 -> ../../../devices/pci0000:00/0000:00:0a.0/mlx5_core.i=
b.1
>  mlx5_core.vdpa.2 -> ../../../devices/pci0000:00/0000:00:0b.0/mlx5_core.i=
b.2
> [leonro@vm ~]$ rdma dev
> 0: ibp0s9: node_type ca fw 4.6.9999 node_guid 5254:00c0:fe12:3455
> sys_image_guid 5254:00c0:fe12:3455
> 1: ibp0s10: node_type ca fw 4.6.9999 node_guid 5254:00c0:fe12:3456
> sys_image_guid 5254:00c0:fe12:3456
> 2: rdmap0s11: node_type ca fw 4.6.9999 node_guid 5254:00c0:fe12:3457
> sys_image_guid 5254:00c0:fe12:3457
>=20
> System with RoCE SR-IOV card with 4 VFs:
>=20
> Maybe, what I would like to see is:
> [leonro@vm ~]$ ls -l /sys/bus/ancillary/devices/
>  mlx5_core.pf.0 ->
> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.0/mlx5_core.pf.0
>  mlx5_core.vf.0 ->
> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.1/mlx5_core.vf.0
>  mlx5_core.vf.1 ->
> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.2/mlx5_core.vf.1
>  mlx5_core.vf.2 ->
> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.3/mlx5_core.vf.2
>  mlx5_core.vf.3 ->
> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.4/mlx5_core.vf.3
>=20
> The mlx5_ib, mlx5_vdpa and mlx5_en will connect to one of mlx5_core.XX.YY
> devices.
In that case, I really don't see the need of creating ancillary device at a=
ll.
A generic wrapper around blocking_notifier_chain_register() with a notion o=
f id, and some well defined structure as library can serve the purpose.
But it will miss out power suspend() resume() hooks, which we get for free =
now using ancillary device, in addition to the ability to selectively load =
only few class device.
Each 'struct device's is close to 744 bytes in size in 5.9 kernel.
Is so many 'struct device' of ancillary type a real problem, that aims to a=
ddress these use cases?

>=20
> Thanks
