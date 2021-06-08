Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BACD39EE27
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 07:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFHFev (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 01:34:51 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:47168
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229507AbhFHFeu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 01:34:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geDKltNmqeeEBJaX6VsdWaEgJljByqeao+htQbTtDQm+rCuzS3O0FSy5Phs+thQZx0TySetKmK2AShGHJxCUsJ/8geJBFf7C3hcw5sJc+TrFsOb0M2X5lHEyL77oXps9m9emvb1qipYia4a1httn+hqqahi+qgkmSBvvGMs2c0h20Fwheviqng7HVp5YAJucNwwB5mXguVKDx9josnQF4+ZSN3WPtToSoqIv6W0YRl3tLJcadjoeIJUvc1hh+pBNag3CZzW0xuEZvCiTooiFqdArEdrac2iUSb/v3SO1kQ1QqFTK0D6abvWJEJHRaSg/BX77Y2X3hz+TeBHWsp94Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaQsNOlJkspsYc+HawUSC5/4JjaX4ozLXu5BI920sYc=;
 b=WDYtbElGXaLWGTxqInKRX9Lsq0TXu2S24/eJgK989JvKZsFaJLXl7PO1irCoM+4aRMjl73AIaDb306yECbJ2oHKwHODj3AuxT5W1Zkwq9gKLAEqUBBeLIMrlk5PEMmdjRJxGy++4WISiF/vU7zSTfy9ORLYIb8R8/zUnE5Y/+huni0FnxTbmyHK+yjHI7P/MRRRfEstWcnFQ16uERMVTryV0Ke8MSGgBf366L6s6dkY3yOctw36JwcPbYriyLrtbXfJnh3YlBCFLKyLMJuX/IdqVdga0u0EM4RidrUtHmSaOj650La/eUfghZBPhCJsqRVINzMnh58ZrblviUkihcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaQsNOlJkspsYc+HawUSC5/4JjaX4ozLXu5BI920sYc=;
 b=MOIjcmZEXdQN04PXK4/9SHGoqXNI/1mHyQdECQ4R1FDf3d9yCRo80A+Tmw/gOohfVVQ+pl48OdkFxrgKQ4CnQQUnskvkDRgO4eCDrrxSBa3ROxz6JwJlvbTCmwLm4kdql3xzkA0xJo/AABL2OQyncxDiSy1By5LZpeYQa3dr63kGQPk6f1PTk0Fuh5tyLZ18aLDx49UOogfZ3LxibKQ/7euWPe60WxUlBCDlFrul8SNFu+XttQydEFYsZLyzYtWFwaxOLgkZDcobuSzkAOh5Ozb/uF8EXjBZdE9pbkeE1OPWT/q2cAQ38h3DpRrDyEw9Squ1/Toyc6nVHu2j/A0NlQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 05:32:56 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::b0d9:bff5:2fbf:b344%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 05:32:56 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Thread-Index: AQHXW3XTgmUrShoLP0aSfA0ttnjNH6sIiqTAgAEDVgCAAAmnwA==
Date:   Tue, 8 Jun 2021 05:32:56 +0000
Message-ID: <PH0PR12MB548195F3EC7E96C1ED2789ABDC379@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <a1a8a96629405ff3b2990f5f8dbd7b57a818571e.1623053078.git.leonro@nvidia.com>
 <PH0PR12MB5481C3DE73C097E938B4E5D1DC389@PH0PR12MB5481.namprd12.prod.outlook.com>
 <YL74KtkVOxVDT5u6@unreal>
In-Reply-To: <YL74KtkVOxVDT5u6@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.202.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 958506f9-367d-4618-0577-08d92a3edebf
x-ms-traffictypediagnostic: PH0PR12MB5433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5433833434F3C6850B25CEFFDC379@PH0PR12MB5433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5zBbBUy5n8GT2oXF/uerbLuYoJSiPME/GBgS9SqiRFqgw/rVJe5uILZp0jpk60/t7ab4A2B0lH1+qidjD2c/d/hwmb7VNa3s5wenJb3hi1N+Hx83/nBB/xSWxNPEH1aDhqVIBEPXjqPDUn9aZq86pnESim4QGC1BMYaBTWaGQC61PDC2nHtMBf46mzq39/M2CcW5uaaDg8pHuLf7LoaYiuuYv9VeFz1GwZac7l6e1bc3Hs4mo4FObkp/+Vrtz/wgvPgLoJakUVu9v8bhVlRtqIlFsWGTu+A2xHdCNOAtKkVh8V32+ZhL19kyp+A7b4VVtvTNTUPyq2UiWl1C2BdN8Rg7mzMrc1/4DtDDtAWxCqQ6gpjh4SPTqMsydlyDxI1U9l+CAQQD7ihAUImyCRGxZQG+V6y7L9lbd3QRIkA2OqnURVeAQNC4nq9btC+fRMzPaZvVorUZoW/2KFdbxIma65tdQCroWEJ3540NW7hWq01DYgx2Wdg4/Gr0MvEQALqzzsmyAVcQ+aqogzoiKa8OTkvwIYlUOO0wHyYlOEnwTGmR+odlVs7ljRqG+YyB1KWWLx4fr7MdB/yIxsn/JiDTwUwWKX7eKucAvfD7Ue5e08U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(83380400001)(71200400001)(66446008)(478600001)(66946007)(55236004)(66556008)(33656002)(86362001)(64756008)(52536014)(7696005)(76116006)(66476007)(55016002)(9686003)(38100700002)(122000001)(6916009)(7416002)(8676002)(8936002)(5660300002)(2906002)(4326008)(316002)(54906003)(6506007)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sFknw02CO9m06EJDtLOJ2pFTSuvqO0NuHY+fwk3wXsjFUGbQ6qpAyw6j+Z/U?=
 =?us-ascii?Q?sMuF48rHrgklYGLCttcb3E6zv8svQCYQ1EEvhPrraKgWrW4oO2a/6Tr7Un9t?=
 =?us-ascii?Q?iqxLUq0BENeekNX8olfU63/ht+Qgpk0o6+/3eG8PGb/xT8pM1i9fTUTiISDM?=
 =?us-ascii?Q?w8xEphacAu0bW/7a/wpzt0sUJ8+3maLHo/99onU0pvu2MgI2GrsdajXgRLnP?=
 =?us-ascii?Q?O8jq/bwP93ERc/T2REYfVMMX7tdvzFWlFkqhHs2AA1/tpie2yi+oylFzvZQn?=
 =?us-ascii?Q?UDPU8esfu32KsQtjd4ULCgIuZPZR+/FJwRHtFm6pgPuIZqHxMsIA2uYETxCt?=
 =?us-ascii?Q?WwmFIuWa8K3Ew2+1e467vK5+3BKnX1trwtMoQcciHIRLkyN4rpkXZkqsK0Lc?=
 =?us-ascii?Q?N9T+AvddKA1fAGXH70JeOGxkFpK1ZdSv0IccxWr5hWNVk+HFZ9+057M87akF?=
 =?us-ascii?Q?GGqpZ6gui6nK6CrJkzQXvvGKNDX1/L8nRRHYAaVOFzHzUm6wRIjxkKOX8adL?=
 =?us-ascii?Q?uGF/4jt4aLG46uy0D1xE/JvSOmRZfhOIEbeJuCKDZwPz/ynBCvBQaqpUHeic?=
 =?us-ascii?Q?JAczoOUeZsO3pp+VXztHNRHnEl00SOTpX442Evey4+euj6a8sOFsrPVrL83k?=
 =?us-ascii?Q?Or9eXQhJOVi7MfHMqCIYEx6tJZyCeFAePe8IoKAARQYZRFgHtn1NEGz2AK7+?=
 =?us-ascii?Q?dijKNYmcEqXmJMYZRo4u/W6UltFPv7oPG83fKO62DPtqXEGW6uZj2r4FOxgA?=
 =?us-ascii?Q?oI+6QDeMlKFW+6g+Fn4Hi9neSlprAYI2A9cT5GUybUSEQh7ZxAeSHRBJo9i5?=
 =?us-ascii?Q?mmG/LxCB1sKgFLkEzmX5J0oHuLQknCq6eceCZWExYzz5tciPIu7UXxMwBZjy?=
 =?us-ascii?Q?Qp42+OlLuCMRkgtspdDY9NTnX7zQePhzrFvx75ebITF9f7sREvDLcV2uxVHR?=
 =?us-ascii?Q?poy9Itj4cxmrtpz1v7N2Z7k/Ghtr7RLzWMdeL0sRR7OdisHD+QmC1BZO4Bbp?=
 =?us-ascii?Q?VheRMWRhUC0fMahQDWAsS5UAcTX/WKS2P3g9VYQNc6+Sj7wobrkM7t8E+9E/?=
 =?us-ascii?Q?x4oZUJOoAQ6pfxDvO2vWWVBpSW05q0r65edcmQy78cVnAn1cfUN0UgAj/Ute?=
 =?us-ascii?Q?lNw+6eTD3tDld7r6HAlGEtZ52A93vjl9uodUuGJ03lYrujRzAeVLxG6NgQfJ?=
 =?us-ascii?Q?u3gwdXgPAT/GSy2iC+M4GMy5cQQyB5GKsijMj9bsO5Di2BpUEEw2QIbCLWh/?=
 =?us-ascii?Q?4345jomSRSlmyY+kX3w2Gs3d9WMOGWjk7q3ELU2Fy9Y6R/Or9oRSOTbHArwH?=
 =?us-ascii?Q?xFlq8Hj8tBclQlF+GxjIGB2q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958506f9-367d-4618-0577-08d92a3edebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 05:32:56.1681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HzbOMrncOSKDsuOrWk8sHKp9sFs9PHfy3mv30XhlfL8ezluK8fS9omH1ugSF3pNLRTLqXU+lT4nTX/JQpbR3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, June 8, 2021 10:25 AM
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
> > > ---
> > >  drivers/infiniband/core/device.c | 10 ++++------
> > > drivers/infiniband/core/sysfs.c  | 17 ++++++-----------
> > >  2 files changed, 10 insertions(+), 17 deletions(-)
>=20
> <...>
>=20
> > > diff --git a/drivers/infiniband/core/sysfs.c
> > > b/drivers/infiniband/core/sysfs.c index 09a2e1066df0..f42034fcf3d9
> > > 100644
> > > --- a/drivers/infiniband/core/sysfs.c
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
> > >
> > This will expose counters in all net namespaces in shared mode (default
> case).
> > Application running in one net namespace will be able to monitor counte=
rs
> of other net namespace.
> > This should be avoided.
>=20
> In shared mode, we are sharing sysfs anyway and have two options to deal
> with the port properties (counters):
> 1. Show them in all namespaces as being global to port which is shared
> anyway.
> 2. Show them in init_net namespace only and applications that were left i=
n
> this namespace will see not their counters anyway.
>=20
> Why should we avoid "item 1"?
Because it is incorrect to show port counters updated by application runnin=
g in net ns 1, to show to application running in net ns 2.
Once/if there is per netns counters exist, than those counters can be shown=
 using more modern rdma stats command.
