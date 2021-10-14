Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791DF42E278
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Oct 2021 22:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhJNUNi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 16:13:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:47605 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhJNUNh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Oct 2021 16:13:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="313978352"
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="313978352"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 13:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="660125011"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 14 Oct 2021 13:11:28 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 13:11:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 14 Oct 2021 13:11:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 14 Oct 2021 13:11:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 14 Oct 2021 13:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn6o5JQLYWZc5W3ngPSdueCchlBHYY3Z/skpIy93Qtgp+XA7nBPEO5VVHysxXAIqGFi/jM0FbVUpCPnVDuxv765i5VcDX2HzfA84bG54mFSnNADpGcHWQAPenQi3Lg41QLO9vM9HY7yQfxmLluWY7I7/35I6WZMxfQJArlYb5CV5XaMYFYr/KmKyh85qMSiN2MZAeABDv/CBuN5ALpVhkYERuELGrw5fmZTjaBaxIQerx9Kcc52BAecABOSTZuSIOQXb7bNh8BYS5c7p7B/nDi66AEksDxrDUuF8IENG3zzhhnzACnHzE+z7ROB3uz/8tinX0pODhRFtCTdWRQpf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZLJKDXy5RVpGpo81n1NlQpRzAGYLihltydeEpET2OU=;
 b=ljfZr/sofY1zKoyonb0ySIlSBb7zqICMgmpj31TmIRPA/QmrxYpEO3iw4ugOmVMXzESgV7E7ukayyP9fuy1ZsrZxed7ZFRr7pwwPa1oEVhIdOAT8MokqIJcfOkm+htKb1FdqZkU+qHLaetMwKrpEWLjsw0LIbmfwgJ54ooAQQlAnmxsx/4DpWfcgaeCpVvjmNNqv9AvU6xaozawLxaaq47efOFeHQJqFoRyImTYZVnltQd1Cx2qGym91DQjXdgm6QlZSY4sZheeqUPHqntrsCSV82v9tP2xxTLM9Oo78AJqbHArEBQpyqkJuywV4EAOgFTjL3uhjidTR/ksE62MdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZLJKDXy5RVpGpo81n1NlQpRzAGYLihltydeEpET2OU=;
 b=c7VURocFMNHxP2py1cYVjLFq726FODDqjHIDH8KhF/93NFLDPbcPgyMcJFHHUoQIgq+OCem51ahfd9Vl/kGlKWmLjoSMuIKwsnu/7cv+SDYsUHkVo2Gy5Idgg6/OczPUubyzFzIp3574ED29ChoBLbN5ZarPHeX8jFTlJSVvA80=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB4580.namprd11.prod.outlook.com (2603:10b6:5:2af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 14 Oct
 2021 20:11:25 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b41a:1b9a:17dc:4b7f]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b41a:1b9a:17dc:4b7f%9]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 20:11:25 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Topic: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Index: AQHXmDZjOykQbRhbB0OylwgVwYR9l6uBQpMAgA+prJCAAATrgIAcjKoAgAA+ygCAJXODQA==
Date:   Thu, 14 Oct 2021 20:11:25 +0000
Message-ID: <DM6PR11MB4692B56B4C7D1E790B50888DCBB89@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210902154003.GW1721383@nvidia.com>
 <DM6PR11MB4692517FBBC9AFD046990DCDCBA09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210920232330.GH327412@nvidia.com>
In-Reply-To: <20210920232330.GH327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97f0a884-6ad5-4e7a-c840-08d98f4eccfd
x-ms-traffictypediagnostic: DM6PR11MB4580:
x-microsoft-antispam-prvs: <DM6PR11MB4580C0B9EB056C8FCB3AF879CBB89@DM6PR11MB4580.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5e+aYS3WMGkQnA3NFXqKGZanzn2LsVpZrijRGZhrpX7wWqPZbCN2pAgaVgHVcKQu0Bd1B9AJFprPHscf5yLg/eHyBHbo/ws2fi+ekQY/CMQpp5DXQfpzeIg4/rgluLwuUrIpaRoq6ekJ5Js7rug2TcTXAQ0MwC/BHVrdKmqPOtSnw0vmGxYZWzPPr+SUJJf81MGBlO5/v/hDucHy9O4shi13xiF/uruhPeyNkegNRDQo2popX673piyMHTUNbSt4J4bqKCwaZW6RjnbU4HZfEZf1XdnKswk5Ve/b5q+lfpsN7TGH9E1pdI/UhOPe9ZaGiI4v6pa+JS+TsxxSWsd6R68ScJuizniPaLQfkNSFLdbWWKd+FmKKJLEapLc1hO3ik90cYOpexUzQh+TsoS4zwSnyoTCQGdar5YkEbCgkNxNZmpIL9y3/dtDbhJYRtl3bzcMMfuE2kKavs7VD+IqFZ4A/k7ybSSfTuiZ39gempiP3lAZinyL2NU6wHoYJ/0J51C2DvAasIo4zydgm/fk5rN3/mwy8sfP6lOYMMuIr29UqWSiT93+rzZSQ7zkZtS+PUdY/6yD/ndnGPiPN21XB8hNmmtT4G96PoOYIMcPp6t3NVgo496ZsVtAMSeyPPMipN8a6FQGSdZiRUZAm70AnG1aeKMEd9AVQNassxDRDlM94TsNWLtzt+phFqDUX8qNLB6R7XJon9sYPszNl7tarxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(38070700005)(5660300002)(33656002)(55016002)(6506007)(53546011)(6916009)(122000001)(9686003)(4326008)(38100700002)(54906003)(7696005)(66946007)(316002)(66476007)(66446008)(186003)(8936002)(64756008)(83380400001)(66556008)(71200400001)(2906002)(76116006)(82960400001)(508600001)(8676002)(26005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cu+hQYp7arliQwZ3gHwi5kmoIkSYjAtaCyXyVp10uckQBnajNWqHutCGlUhH?=
 =?us-ascii?Q?3qd/YIFOvc418fRA/D3TiM7kby5rebtdpm0m9Id6+/b+wJzsuP/MABxUrBLz?=
 =?us-ascii?Q?PFWdsbdVffXVd7b1Vc3hmK3NwmKdRwH6ny3Xpm5vhccR+uqiyEZ/S84pYJ22?=
 =?us-ascii?Q?eBZqn4b3JnSi4Lf/tEeXYjN/YleA5w4rfd8bprgLt5FgF64MUOWpWNGZw6TL?=
 =?us-ascii?Q?YwSZEk1wBOH0U3133ceXE/8uRps4Cx8CbRLHIPAkYc0r/JhxLL6fod52N0zk?=
 =?us-ascii?Q?HbMh3OatK67krSkq2XjhiFB9A5Sm7yCZgTQ3Rlih25P7X2yEO8XPOs4wLRBg?=
 =?us-ascii?Q?sNQYJ2L3R+S3Nq0GtUNlVXdVtgj2uMzg8PhlHbxJkuuN6g+JmH5M4MzwriBN?=
 =?us-ascii?Q?8sPQMyfdg1n/aZDj8oM7jfqKInvhOpjfnCta8RtaLuWNqnRp+5aAhlMmkVmy?=
 =?us-ascii?Q?ZyQoKcaLDcJijqpNuUvcRkYl6xrmF6p9gm1OMCTcfpChy7yJCzpenBMcK6MP?=
 =?us-ascii?Q?p6QPQ9t6ujW6ELx3XYYYCvmeN93mtXu/rXh/Y29Kk6RmRir/cJVW5mR/Ghyo?=
 =?us-ascii?Q?+4FiyWB7xh+ilqdKA6hvF1XoYMvLxvr4tml5Yf0OOHfYbq8clNz4lglHeiVr?=
 =?us-ascii?Q?gVpzhdn/z1ATi2ynWWWQMdgSGpgv2YMvsNd/rI3vXibE5tRkPwcaO/d2vA6Q?=
 =?us-ascii?Q?GuzYQFjBDvjRY13E2/uLnBrBp9H9je50Djzt0IuURT3+pDwOrmwCRP5yseuu?=
 =?us-ascii?Q?KP9StJ5AqV7nTBUK9nuXIh4bQKT+/AksqxJ2VmxQL7fCL2LSBuuZl/Kh2wgN?=
 =?us-ascii?Q?lkd3XAgxzqRrVFLMuT/EMThM6mjnK5XTNXgw+ou1CUuLWqkgTSOFqXjbQmZa?=
 =?us-ascii?Q?Vjle5RVfscfKZ6HRSvi8qImJqwnqr7cBjGlVx1WPUsVxVlPRt4kxO5mCdnvE?=
 =?us-ascii?Q?3jCHP+OiWSROUwQEYSh/n/9hKd2hlIpa4BTUP+VsM1J9iZ33wncvosNurhnC?=
 =?us-ascii?Q?XC1mAxfAZCKrcDW2T9Dx7rP/xCDEWloEvbkv9k0haPGoGDRgs61i5eplih3a?=
 =?us-ascii?Q?tmMJHrwVC/kpK9f3ffg76AGvPezOGEyLEdj0q29Hz2ztKiRX4hU+HHhN4N55?=
 =?us-ascii?Q?CxuHIIhyYAnjtXn2T4yI4LHMn18bTlhFX7z6HNt6hgJUrXz7KDKS15+AOIMm?=
 =?us-ascii?Q?BccuS/ym3Yy7yERwsNZVoYRveT+rbLQF4qBgU+9wq8jYhYnYAzJ6YbFOU9oa?=
 =?us-ascii?Q?bRZf7v/9kl8CdFjZncJRIN0y2mG/Y/4BkeBYJ9+VPDpt4qWoRT1VzfkF6C+i?=
 =?us-ascii?Q?bKC2Mj/8VAAKv9YiDvfIK6bw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f0a884-6ad5-4e7a-c840-08d98f4eccfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 20:11:25.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XA/YEMXOhJfPRqST25lWAEwbP2mKDLawRlZdNpaLDr/37AYUNXTMrkYXwJzZpxHTmuvQ8JlWMtrtw2yEaCeMlEtj7/2ly7NlISOfbnIdAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4580
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, September 20, 2021 6:24 PM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
> rules
>=20
> On Mon, Sep 20, 2021 at 07:41:21PM +0000, Nikolova, Tatyana E wrote:
> >
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, September 2, 2021 10:40 AM
> > > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > > Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> > > Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to
> > > kernel-boot rules
> > >
> > > On Thu, Sep 02, 2021 at 03:29:43PM +0000, Nikolova, Tatyana E wrote:
> > > > > Given that ice is both iwarp and roce, is there some better way
> > > > > to detect this? Doesn't the aux device encode it?
> > > >
> > > > Hi Jason,
> > > >
> > > > We tried a few experiments without success. The auxiliary devices
> > > > alias with our driver and not ice, so maybe this is the reason?
> > > >
> > > > Here is an example of what we tried.
> > > >
> > > > udevadm info
> > > > /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > > E:
> > > > DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > > E: DRIVER=3Dirdma
> > > > E: MODALIAS=3Dauxiliary:ice.roce
> > > > E: SUBSYSTEM=3Dauxiliary
> > > >
> > > > udevadm info /sys/bus/auxiliary/devices/ice.roce.0
> > > > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > > E:
> > > > DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > > E: DRIVER=3Dirdma
> > > > E: MODALIAS=3Dauxiliary:ice.roce
> > > > E: SUBSYSTEM=3Dauxiliary
> > > >
> > > > Given the udevadm output, we put the following line in the udev
> > > > rdma-
> > > description.rules:
> > > >
> > > > SUBSYSTEMS=3D=3D"auxiliary",
> > > DEVPATH=3D=3D"*/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce=
.0/
> > > *",
> > > ENV{ID_RDMA_ROCE}=3D"1"
> > >
> > > What is the SUBSYSTEM=3D=3D"infiniband" device like?
> > >
> > > This seems like the right direction, you need to wrangle udev though.=
.
> > >
> >
> > Hi Jason,
> >
> > After more research and given the udevadm output, we revised the irdma
> udev rule to make it work. Could you please review the patch bellow?
> >
> > diff --git a/kernel-boot/rdma-description.rules
> > b/kernel-boot/rdma-description.rules
> > index 48a7cede..09deb451 100644
> > +++ b/kernel-boot/rdma-description.rules
> > @@ -1,7 +1,7 @@
> >  # This is a version of net-description.rules for
> > /sys/class/infiniband devices
> >
> >  ACTION=3D=3D"remove", GOTO=3D"rdma_description_end"
> > -SUBSYSTEM!=3D"infiniband", GOTO=3D"rdma_description_end"
> > +SUBSYSTEM!=3D"infiniband", GOTO=3D"rdma_infiniband_end"
> >
> >  # NOTE: DRIVERS searches up the sysfs path to find the driver that is
> bound to  # the PCI/etc device that the RDMA device is linked to. This is=
 not
> the kernel @@ -40,4 +40,9 @@ DEVPATH=3D=3D"*/infiniband/rxe*",
> ATTR{parent}=3D=3D"*", ENV{ID_RDMA_ROCE}=3D"1"
> >  SUBSYSTEMS=3D=3D"pci", ENV{ID_BUS}=3D"pci",
> ENV{ID_VENDOR_ID}=3D"$attr{vendor}", ENV{ID_MODEL_ID}=3D"$attr{device}"
> >  SUBSYSTEMS=3D=3D"pci", IMPORT{builtin}=3D"hwdb --subsystem=3Dpci"
> >
> > +LABEL=3D"rdma_infiniband_end"
> > +
> > +SUBSYSTEM!=3D"auxiliary", GOTO=3D"rdma_description_end"
> > +KERNEL=3D=3D"ice.iwarp.?", ENV{ID_RDMA_IWARP}=3D"1"
> > +KERNEL=3D=3D"ice.roce.?", ENV{ID_RDMA_ROCE}=3D"1"
> >  LABEL=3D"rdma_description_end"
>=20
> This doesn't seem right, the ID_* must be applied to an infiniband device=
 or
> the other stuff doesn't that consumes this won't work right.

Hi Jason,

Based on the following output, it seems that some systemd services won't wo=
rk. I just tested with the port mapper which worked.

udevadm info -q all  /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.=
iwarp.0
P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.iwarp.0
E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.iwarp.0
E: DRIVER=3Dirdma
E: ID_RDMA_IWARP=3D1
E: MODALIAS=3Dauxiliary:ice.iwarp
E: SUBSYSTEM=3Dauxiliary
E: SYSTEMD_WANTS=3Diwpmd.service
E: TAGS=3D:systemd:
E: USEC_INITIALIZED=3D33683420

The parent of the aux device (and our ib device) is=20

'/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0':
    KERNELS=3D=3D"0000:2f:00.0"
    SUBSYSTEMS=3D=3D"pci"
    DRIVERS=3D=3D"ice"
    ATTRS{ari_enabled}=3D=3D"1"
    ATTRS{broken_parity_status}=3D=3D"0"
    ATTRS{class}=3D=3D"0x020000"
...

If we need to use the aux device name in the udev rules, then I am not awar=
e how to get to the aux device through the infiniband or the pci subsystem.

> What does the udev debugging say about these ID tags?
>=20
> The SUBSYSTEMS=3D=3D"" is the right approach, as shown above for the othe=
r
> metadata. If you are having trobule I'm wondering if there is some kind o=
f
> kernel problem creating the wrong sysfs?
>=20

Previously I was using an RC1 kernel and seeing issues with sysfs. After sw=
itching to a GA kernel, it works better.=20

udevadm info --attribute-walk /sys/class/infiniband/rocep47s0f0

  looking at device '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infiniba=
nd/rocep47s0f0':
    KERNEL=3D=3D"rocep47s0f0"
    SUBSYSTEM=3D=3D"infiniband"
    DRIVER=3D=3D""
    ATTR{fw_ver}=3D=3D"1.48"
    ATTR{node_desc}=3D=3D""
    ATTR{node_guid}=3D=3D"6a05:caff:fec1:c790"
    ATTR{node_type}=3D=3D"1: CA"
    ATTR{sys_image_guid}=3D=3D"6805:cac1:c790:0000"

  looking at parent device '/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0':
    KERNELS=3D=3D"0000:2f:00.0"
    SUBSYSTEMS=3D=3D"pci"
    DRIVERS=3D=3D"ice"
    ATTRS{ari_enabled}=3D=3D"1"
    ATTRS{broken_parity_status}=3D=3D"0"
    ATTRS{class}=3D=3D"0x020000"=20
    ...

So adding the following to rdma-description.rules seems to work. Is this ac=
ceptable?

diff --git a/kernel-boot/rdma-description.rules b/kernel-boot/rdma-descript=
ion.rules
index 48a7ced..9a18b67 100644
--- a/kernel-boot/rdma-description.rules
+++ b/kernel-boot/rdma-description.rules
@@ -33,6 +33,8 @@ DRIVERS=3D=3D"mlx4_core", ENV{ID_RDMA_ROCE}=3D"1"
 DRIVERS=3D=3D"mlx5_core", ENV{ID_RDMA_ROCE}=3D"1"
 DRIVERS=3D=3D"qede", ENV{ID_RDMA_ROCE}=3D"1"
 DRIVERS=3D=3D"vmw_pvrdma", ENV{ID_RDMA_ROCE}=3D"1"
+KERNEL=3D=3D"iw*", ENV{ID_RDMA_IWARP}=3D"1"
+KERNEL=3D=3D"roce*", ENV{ID_RDMA_ROCE}=3D"1"
 DEVPATH=3D=3D"*/infiniband/rxe*", ATTR{parent}=3D=3D"*", ENV{ID_RDMA_ROCE}=
=3D"1"

This script results in the following settings:

udevadm info -q all /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infin=
iband/iw-ifname
P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infiniband/iw-ifname
E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/infiniband/iw-if=
name
E: ID_BUS=3Dpci
E: ID_MODEL_ID=3D0x1593
E: ID_PCI_CLASS_FROM_DATABASE=3DNetwork controller
E: ID_PCI_SUBCLASS_FROM_DATABASE=3DEthernet controller
E: ID_RDMA_IWARP=3D1
E: ID_VENDOR_FROM_DATABASE=3DIntel Corporation
E: ID_VENDOR_ID=3D0x8086
E: NAME=3Diw-ifname
E: SUBSYSTEM=3Dinfiniband
E: SYSTEMD_WANTS=3Drdma-ndd.service iwpmd.service rdma-hw.target rdma-load-=
modules@iwarp.service
E: TAGS=3D:systemd:
E: USEC_INITIALIZED=3D41070786

Thank you,
Tatyana

