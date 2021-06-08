Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5339339EE20
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 07:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFHFbY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 01:31:24 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com ([40.107.93.72]:16609
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229655AbhFHFbX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 01:31:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbG3q24qhCdonsc5b3OYYhxtGYzPqcVEhS6BJxryMYKc81SzRBmgNwQBLfbCc0QiAFPSYGWqu37jaZHYXR8rfIRAAdcvIToFOqsX7LHjo7pOSeQz4kHUmVEtzDXQx2628xBQnMzq0Vpx6EG3wjEQIImpSirmSLEiRZxFpKB/ZqY0hM04aqnMQW/VQ64CPvuU2oqyhejwWC8xzxEgAwjsZs78u63dfxIkeDDBkCQX/MsshK0lcqJ2+h55H3waDO1/4PeohscKhklz1ItxRuwutBaQbFihaHTY2Oj1j+3rrPwWjdFpHpd5Wl9w89LMXDmhV7XI5u3Vfxkdt7+CHdJqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB+fKXeGJ3Vv+6hh38TjBiiUbvz7GPd4LPLd9fm1xT4=;
 b=B9BFKHspueiBXVY2MhjlUWjGVU8+FWHm4q65J4Rthnzeq7hAwLche7iLR2/IIv4KBinwIj3h1LhhHNRvJCNr0CNAJaIsskQ/8gIMiTg9CuzwpkdJT5xxG9h2aHHij5BhyyEkGn5mm6Kb4m+6LzFdBTEp6rUuSf+QMsFVyA6pphMnPUo8Gh0QgRCGeZ13TaammhrEGkTlanLHmhlOYY88928lVs3iHw9wjaD6cfvMHQWMARJaTfFLLqLrO8WnEp7+bEVb4tExHalo+FmPRG5Ejvp3e+zXRueLGUaUIRzruIT2h6qwiO+TCLAs6DBsulaPsuanjhHEpfmqaGhmq+yHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB+fKXeGJ3Vv+6hh38TjBiiUbvz7GPd4LPLd9fm1xT4=;
 b=RQ0SuVW0BHANLFjVuyY0vdNUE5L1tlB6ATN8HkI1G+wRJVmtsLU2Wfuo6mVlDrhDVFt4PShyQAZGmVk6fAmRPzQpkMCgfLpKrk/cXXnJmYPzZ/v8Fx8mxepYzfIhIclpGF7ArwxRKm1FAemPCj0RhTPFiUrHZ/c6rMxjH9h3QOTx2/+dlYTkM/R7q2Dz3l3WlYxbJhaO0thMmftztVEVvOh84Zax56SxWblW4wdv1GqFM1yE4xgpF1YGI8HXR7af8c4D1WZFYcsbKNe0cKbkLNkamZCD1KMeMOyUW6+eJNJf0wVgRSN07Gym0JSHY3xslNHAhx1/GmXT8WUM7FgJ5w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 05:29:29 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 05:29:29 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: RE: [PATCH rdma-next v1 14/15] RDMA/core: Allow port_groups to be
 used with namespaces
Thread-Topic: [PATCH rdma-next v1 14/15] RDMA/core: Allow port_groups to be
 used with namespaces
Thread-Index: AQHXW3XTgmUrShoLP0aSfA0ttnjNH6sIiqTAgACpEgCAAGNfcA==
Date:   Tue, 8 Jun 2021 05:29:29 +0000
Message-ID: <PH0PR12MB5481D66883EA5F32AA8488B0DC379@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <a1a8a96629405ff3b2990f5f8dbd7b57a818571e.1623053078.git.leonro@nvidia.com>
 <PH0PR12MB5481C3DE73C097E938B4E5D1DC389@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210607233202.GU1002214@nvidia.com>
In-Reply-To: <20210607233202.GU1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.202.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 970d7120-7ad2-44bb-69ee-08d92a3e6399
x-ms-traffictypediagnostic: PH0PR12MB5483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54835954DEF26F9B6F26FFFFDC379@PH0PR12MB5483.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQ92iXHfemSnVRxkCd9uoXZk9qNxqnVUoVU4jUDPtDp+LelyK8Pg6548sB8VGaUxzO5UZDjCCjhXpv9It2j0L3cTDdLglIhr5hMzyAiYDSzwlx8H64i2MFMLDZaIXX3Vpx/WGeArB6bwlnJ9Xb563gNw6vA9jfSn4BqY7aGrPqeIb9PT4wy0eh6RWC0AqNFUHt7isBHaEVpaRhcvdTG+RHthvB+gXR2/CNHxROC8EwUmK1Lfs9Lt77tgm9v9yV44OUeI2Mjl/JLBxQS3xoSPRzMT6PVKB0d8OwJf2LRdvCi9t02NbK9ElBAsLV+kC3gk7SYKfEv76nor1kmLJFTWce81F8h8Hr4H9HKmEVfwO0/+9HBlyy/T7vD4XO64XjvtCOcUD/Q9LEa3zi1cNwyTZ/j0eLwJrS43aMFwQtSrbnQ8ew2Nvv0LXHwyfC/GdVRk+1OtqXU7Xi3NDqjqq/umiU6a9C7LxoOZwrphFv8hjefcEEUedPd5lx7pA+xRuAztOckxJJaR345BNDrFHYPMqB4d0roYrtjKgYPhiZ1Lin3acOYU0YLj4usy4Co+0QixLCUoRAorgrfOgBtDsgrDRBB+DzHm21gk0e70WFgTj0k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(186003)(55016002)(6506007)(76116006)(2906002)(8676002)(26005)(55236004)(8936002)(316002)(54906003)(66476007)(83380400001)(66556008)(64756008)(66946007)(52536014)(86362001)(4326008)(5660300002)(71200400001)(66446008)(478600001)(33656002)(7416002)(7696005)(6636002)(38100700002)(6862004)(9686003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mMoU9Y/MFMxfK7bxC3qDcieNzSJ9WFhtLQfk68Ye4w38xpSog9O6eZaIjft/?=
 =?us-ascii?Q?RgpB+BeqsfAiPvoh6MrPYfHbRcqYaUtbW7mj75gQDUg7VV5FkpF6WuEIVyCg?=
 =?us-ascii?Q?Qwe2iwPUljOLdfQHxLqXeH3dj0CSChYfZdtOxUUGdm5WGo8YRwkyB9hbZ/T2?=
 =?us-ascii?Q?0VVqayNnuT6qysxczs1Nn5B6g8rPdS5aIO6n++VdvpBX1HJ2SeJXhbEubnYN?=
 =?us-ascii?Q?iSV0DurNlqMohkNKIU+smtjt/zVcc8KzgEXomrmf+8FeeE8I/Hl3IgrHZE8f?=
 =?us-ascii?Q?ovK6cTI6XJCzni9mW7zhTt7/rScjzjRmMnpNNwzRc+FEuMkae4Sha7yKK+Ho?=
 =?us-ascii?Q?oubHUgcJ6fQ2QCusCagmkJdsaam09ixAoEmk/X8pCZD8HlDZpJGJ3wzScVl4?=
 =?us-ascii?Q?fN1UYCuMi/q2vCG3O1J0l/t70VczTEiX7NIOwbCK0a74GmVGSrN+3q96d2bF?=
 =?us-ascii?Q?yCR91l2E7J3NhOvwfEBeKM2iR2HknuO4Tayl+/LSh8gzuVwqf6MbC7EFlUPy?=
 =?us-ascii?Q?cBPCKjBeUN4KbHM4BOe+OjTeR8tkC5MzYa2D697/v8LlogmEvcuq4fY59Rx7?=
 =?us-ascii?Q?0ZayYCTZF95Rz8LgNoKfmJsBiXPO2UYiunc46l8ERKS8V4qFTcBR1RkW7gq5?=
 =?us-ascii?Q?NFpPLXBQH0FCBJKyl5XuQZkERbKCxmF2IHMMyzWiYJD9MhbdgjKOMuzK7zuA?=
 =?us-ascii?Q?W6YMP4cQpa1uMjtI5n+Y1vwrc6x7wyT7fvNQG75UI+uetCQ4v9RWUxfRN7R1?=
 =?us-ascii?Q?BZnHgSR+Qam/DbDRtoENvRUdkRZNxNF7Or1vY4vc1dSxl8guy6taCcanSbap?=
 =?us-ascii?Q?J218IvsepClOZute3Te8bhuX9PgXxHxVNvubdCnjXM4JL+teFDo/yhtkk4uc?=
 =?us-ascii?Q?pSWmzp7VsoO3k4/GVLYX2mMzFC1wwMNSiDzZPq1PS3pmYBTFpb6a0bZPutBw?=
 =?us-ascii?Q?/HYg0iV6drWvC8S7pYuGozWx93ZrEsoTE6FoB4kUKsxjihsSwya+3NT4UYXA?=
 =?us-ascii?Q?N/7ocdQTDRJvAAdV5au1bVJpnjTf8dpjYK6JSQhlmgU21E0z0HDC52ce3ix+?=
 =?us-ascii?Q?WxO2rBrxV2+IdBuaA+mIK6G3IOtNAIwNBSNfLGPAnuxXHz/WejZshJ/amSwM?=
 =?us-ascii?Q?sXo9QX1iv+fIU6YXgdBFQdWUuJ9+dKojS3aHlUBsO7bOtJaRlL/RQIpFpsMa?=
 =?us-ascii?Q?ZhkEVuPWn3gfUdrpKsmxrmfcCN7kbxAKE3rFgEIo9kFzS5PqQpcnz0cGbpBa?=
 =?us-ascii?Q?oenxMxBcSTU3OyrGFqaJFlbsjuU5xrxp9UE9O56q1azTBsuD3LeOKcyScMUz?=
 =?us-ascii?Q?awqxFIKW7GhgydKauc9/q2sH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970d7120-7ad2-44bb-69ee-08d92a3e6399
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 05:29:29.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXi244J0FupORQL4M6eUfIDCzArJcWy0HLnSl4VNdQ8o2VZiA2xnBexkkLoWHUKuHVeF7fz/nmzBH1UywWaHgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, June 8, 2021 5:02 AM
>=20
> On Mon, Jun 07, 2021 at 01:29:58PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Monday, June 7, 2021 1:48 PM
> > >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > >
> > > Now that the port_groups data is being destroyed and managed by the
> > > core code this restriction is no longer needed. All the
> > > ib_port_attrs are compatible with the core's sysfs lifecycle.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > drivers/infiniband/core/device.c | 10 ++++------
> > > drivers/infiniband/core/sysfs.c  | 17 ++++++-----------
> > >  2 files changed, 10 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/device.c
> > > b/drivers/infiniband/core/device.c
> > > index 2cbd77933ea5..92f224a97481 100644
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -1698,13 +1698,11 @@ int ib_device_set_netns_put(struct sk_buff
> > > *skb,
> > >  	}
> > >
> > >  	/*
> > > -	 * Currently supported only for those providers which support
> > > -	 * disassociation and don't do port specific sysfs init. Once a
> > > -	 * port_cleanup infrastructure is implemented, this limitation will=
 be
> > > -	 * removed.
> > > +	 * All the ib_clients, including uverbs, are reset when the
> > > +namespace
> > > is
> > > +	 * changed and this cannot be blocked waiting for userspace to do
> > > +	 * something, so disassociation is mandatory.
> > >  	 */
> > > -	if (!dev->ops.disassociate_ucontext || dev->ops.port_groups ||
> > > -	    ib_devices_shared_netns) {
>=20
> So this is OK since we have the clean up now
>=20
I didn't review the whole series, but yes if there is sysfs clean routine, =
it should be ok.

> > > +	if (!dev->ops.disassociate_ucontext || ib_devices_shared_netns) {
> > >  		ret =3D -EOPNOTSUPP;
> > >  		goto ns_err;
> > >  	}
> > > diff --git a/drivers/infiniband/core/sysfs.c
> > > b/drivers/infiniband/core/sysfs.c index 09a2e1066df0..f42034fcf3d9
> > > 100644
> > > +++ b/drivers/infiniband/core/sysfs.c
> > > @@ -1236,11 +1236,9 @@ static struct ib_port *setup_port(struct
> > > ib_core_device *coredev, int port_num,
> > >  	ret =3D sysfs_create_groups(&p->kobj, p->groups_list);
> > >  	if (ret)
> > >  		goto err_del;
> > > -	if (is_full_dev) {
> > > -		ret =3D sysfs_create_groups(&p->kobj, device-
> > > >ops.port_groups);
> > > -		if (ret)
> > > -			goto err_groups;
> > > -	}
> > > +	ret =3D sysfs_create_groups(&p->kobj, device->ops.port_groups);
> > > +	if (ret)
> > > +		goto err_groups;
> >
> > This will expose counters in all net namespaces in shared mode
> > (default case).  Application running in one net namespace will be able
> > to monitor counters of other net namespace.  This should be avoided.
>=20
> And you want this to stay blocked because the port_groups mostly contain
> counters?
Yes.
