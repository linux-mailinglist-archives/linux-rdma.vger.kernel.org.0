Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD1618CDC9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 13:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCTMTh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 08:19:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:13563 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTMTg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 08:19:36 -0400
IronPort-SDR: TtoAPtCJl64JZhl1YlQ6rJ8LO5tBr5XFg8AHfWkfmiMmpCkxnM7fOYMMc8BtRIww/5OWdvx6vY
 1YLDf6MOVBYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 05:19:36 -0700
IronPort-SDR: 2dXJgpsXsxc7xAyMd2GSEHXYUYvgJCSLHWOFJ+oM3wQPGRfnC6qytIV4j44TwuQgo7SkiDICkS
 IvGBD2qW6cnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="239211741"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga008.jf.intel.com with ESMTP; 20 Mar 2020 05:19:35 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Mar 2020 05:19:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Mar 2020 05:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igJLSZpXMdn3XxDtcJ+csnhEfUHEM6QUdp/1nFdaV6OYfzJwBJtjThPLZUc+KyAFrQAGQliOeyUhrvnr7s02is89yOpX+nJDtzCbT2TzjSloY+zwMzrmma2H8/+odl0y71Ko8A0v8Iyd6o8cjUkAluXenAYcI9kzlfjfjgCcsBi7ex2X1V8l2CfkMmLH87ac8JSd5fsY1r4Qi8vOhERYjupYf1OkS+V6/lm/AlRt6npPvpJlacCFgNqD5IIfZYu06/38uPU3oCRdRz+W2t3tiTpcY4/Oukoht7C7ZBk/HB5HfjcqhCOWKF40glQvByvXZmyGpjGQPCKSumEVXXZPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg6rCoYk7WueTlW0XrlA1FNyuVIU0P9g6q7Iq6/HZis=;
 b=jmWg+UT/eqJ7gbKmq4/Y+jBGJYdW0a/vOoglOYldM/YLTY9GEEGYqdNssrwdY0RsCPUcyaOOMbpmwpIyHna9oFI+0S5KiVrHV4w4+UPSqzVzUZgg+jFmvvL8fm7oi9+McLorSLHo13xhcNK26lkYQkv+55bNnJq3y+4+ZDKPB7x58HXEKeZpWXYOch02Yzf8gQLwq1Q3wO4b/uIO4jx1FgHWFlfaR+zP9sTvZzVSYrprN+VcV5HhaiOt9Bc45JxBtD+QRwFLh/WOHjMoHahFRHga6gpK4pawN7cFhpKabbs5cd2meDg1ls9ay8FGf0HjQ7hXtzsKcpdsgVMjWqNG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg6rCoYk7WueTlW0XrlA1FNyuVIU0P9g6q7Iq6/HZis=;
 b=xZlDsOPPv2PxXgvSUDCLxi8vBa1CyEdRUZM1yfIZutGPizDvRP9vsznX1c288Kp/SFHB0gTuAQd2a+49zRk1khYz5f4ifOyd72s7E0dc1If8ycSiWs5S6XOWnmVGWoKmIpaMbh4/10lG34BAD/z82rvEvhAhKICSAW2otoUESLc=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Fri, 20 Mar
 2020 12:19:34 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9%4]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 12:19:34 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: RE: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
 the parent of cdev
Thread-Topic: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
 the parent of cdev
Thread-Index: AQHV+9aq9JxrAmD3GUitnjKGS5ypvqhO/2QAgAJq9VA=
Date:   Fri, 20 Mar 2020 12:19:34 +0000
Message-ID: <MW3PR11MB466555A168C395D92DC86511F4F50@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
 <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
 <20200318231830.GA9586@ziepe.ca>
In-Reply-To: <20200318231830.GA9586@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kaike.wan@intel.com; 
x-originating-ip: [72.94.197.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57b8a4a8-bb93-43da-65f7-08d7ccc8f354
x-ms-traffictypediagnostic: MW3PR11MB4651:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4651E8D30CAEF4A3480DD6B0F4F50@MW3PR11MB4651.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:207;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(396003)(136003)(199004)(64756008)(52536014)(66446008)(76116006)(9686003)(5660300002)(66476007)(66556008)(26005)(55016002)(66946007)(4326008)(107886003)(71200400001)(186003)(6636002)(8936002)(53546011)(110136005)(316002)(86362001)(7696005)(2906002)(6506007)(8676002)(81166006)(33656002)(81156014)(478600001)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4651;H:MW3PR11MB4665.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZuC47kk1deuOa7UhqF57f7vRe6gxHSyI1yhWP63sUa0gRhpKFFoFhu0aRnpZQQ4v8uCPJSg14a8onMyqmwSFsopLSkI6Ef+vMHCm7FnoY+YjR4GEeN2F5AU5fJhP2l64uk8NNv7k3J0Xm+pfHAMbAHOr1tt8hibmnY5sqIho0CBxgth4P+IFX5i6AVil6Xk5oHWwZMpS7CSWeVfPMU+DQQNZpjhXDG7u5ZbNyW8koBAWfCDlsSbpgcXtFUV1MnDQ+UAqUouNIF4IG38BeERAGkonZ7iArSPbsosbS+xswOGA2UzaVaLDZU22aty3+TsX/3K+Ip9p2/0EC/XsJlRic12Y5xLwr+zoaBXJFHm76PBbAE7hObNW4geMFjfMVj8TJrxozlT4n5Svxs0kzRwgGISn8guAWgYj0hmO9g6n3IVnzJKgUxH3cjaPp7dOUAX
x-ms-exchange-antispam-messagedata: 34QRW1xa3GXIkXLzBlEnPi2NYbNoQX+Y1sMIsQxgvRz16DWZZ679yK43Gpubtrcom5N8heZm+d1XI6PiaMEPRlPMm2A8DeKRzEuMgLjBffhHlS0zQ5+sitFt5/l/6pxNPrWBMxfb+Y6ikAvLO5flPA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b8a4a8-bb93-43da-65f7-08d7ccc8f354
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 12:19:34.2586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oH43vCTOyQUryYED5WVGm4UMH9KMSAt5PoUUdrXWQ7vGU5kb1E3dC7+ni0QIwB7mRzbONYeRgX6iyX14SFnJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4651
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, March 18, 2020 7:19 PM
> To: Dalessandro, Dennis <dennis.dalessandro@intel.com>
> Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Marciniszyn, Mike
> <mike.marciniszyn@intel.com>; Wan, Kaike <kaike.wan@intel.com>
> Subject: Re: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata =
as
> the parent of cdev
>=20
> > diff --git a/drivers/infiniband/hw/hfi1/device.c
> > b/drivers/infiniband/hw/hfi1/device.c
> > index bbb6069..4e1ad5f 100644
> > +++ b/drivers/infiniband/hw/hfi1/device.c
> > @@ -79,10 +79,12 @@ int hfi1_cdev_init(int minor, const char *name,
> >  		goto done;
> >  	}
> >
> > -	if (user_accessible)
> > -		device =3D device_create(user_class, NULL, dev, NULL, "%s",
> name);
> > -	else
> > +	if (user_accessible) {
> > +		device =3D kobj_to_dev(parent);
> > +		device->devt =3D dev;
>=20
> What is this doing?
>=20
> The only caller passes:
>=20
> parent =3D=3D &dd->verbs_dev.rdi.ibdev.dev.kobj
>=20
> So,
>=20
>  1) the kobj_to_dev is obfuscation
>  2) WTF? Why is it changing the devt inside a struct ib_device??
>=20
> > +	} else {
> >  		device =3D device_create(class, NULL, dev, NULL, "%s", name);
> > +	}
>=20
> And since there is only one caller and user_accessible =3D=3D true, this =
confusing
> code is dead, please clean this up.
>=20
> Actually this whole thing would be a lot less confusing to read if this f=
unction
> was just lifted into user_add().
Will clean it up.

>=20
> >
> >  	if (IS_ERR(device)) {
> >  		ret =3D PTR_ERR(device);
> > @@ -92,20 +94,27 @@ int hfi1_cdev_init(int minor, const char *name,
> >  		cdev_del(cdev);
> >  	}
> >  done:
> > -	*devp =3D device;
> > +	if (devp)
> > +		*devp =3D device;
> >  	return ret;
> >  }
> >
> > +/*
> > + * The pointer devp will be provided only if *devp is allocated
> > + * dynamically, as shown in device_create().
> > + */
>=20
> And the only caller passes NULL:
>=20
> drivers/infiniband/hw/hfi1/file_ops.c:  hfi1_cdev_cleanup(&dd->user_cdev,
> NULL);
>=20
> So why add this comment and obfuscation? Delete this function and call
> cdev_del from the only call side
>=20
> And even user_add /user_remove are only called from one place, so
> spaghetti
>=20
> > diff --git a/drivers/infiniband/hw/hfi1/hfi.h
> > b/drivers/infiniband/hw/hfi1/hfi.h
> > index b06c259..8e63b11 100644
> > +++ b/drivers/infiniband/hw/hfi1/hfi.h
> > @@ -1084,7 +1084,6 @@ struct hfi1_devdata {
> >  	struct cdev user_cdev;
> >  	struct cdev diag_cdev;
> >  	struct cdev ui_cdev;
> > -	struct device *user_device;
> >  	struct device *diag_device;
> >  	struct device *ui_device;
>=20
> And I wondered about these other cdevs.. but this is all some kind of dea=
d
> code too, please fix it as well.
Will do.
