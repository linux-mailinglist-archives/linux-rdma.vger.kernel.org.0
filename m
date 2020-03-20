Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF0AA18D397
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 17:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCTQJl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 12:09:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:60127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbgCTQJk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 12:09:40 -0400
IronPort-SDR: AIg1z4ZoOduSHpBggqL4D612RmeUip2fysHsnpYXX+/m+5KO20siGWyBpyt4TBRAuE0ZvNeQJ0
 fe1cMuu73qSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 09:09:39 -0700
IronPort-SDR: TQ/lPXklTnwrMBuPuou+MyMcQ/wERT6HZ471ZHWWH2iQfMmGhojtgjurAkFmvuA7pS8cVGdxAJ
 727TcmjCP8Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="446696218"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2020 09:09:38 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Mar 2020 09:09:38 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX161.amr.corp.intel.com (10.22.240.84) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Mar 2020 09:09:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Mar 2020 09:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOAyXq43zUh29IeiSRV6HMMRCnSNSQLg0so7d3f4yYjYYU1t9goi96YD+E4ggsUnxnNC5GWJN36yN7scH/HxEw0xEnIdSVFkNZaScHBZNQjuhw4oxf5701tRLs12bLIsebLybpgE2jRPTQEK0gCRfe7ID5W7F3SNDpIv9l0kqByUPWEl4qtegrv96tpz09vSo0TfLUqmIHpN1o3JiCck9fwy6pOk3XU3D2a+J9CaV5u50269ZAV+qZTJqLDGh6a90VZyb5aZ0NLfRTpkRws3IGCaZ0+tMcZtvT0nMmEGvYmoh7KWbmLb8SNHG9qbH4dcWTe/gv8eQD5IsMObyPeWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zw8HLsy2fgkJSqVwcTL6wddwlDCML48Rewrq9qTmgQ=;
 b=U6YCClmWqmYcKDrLphpTCuZFaqwumLo8tGVwaKMZ131sRpC4dDa7Tsv5rDYgnkY5HS+dys0FKJ29YnpQ1OBlvuYjqYI2NUzfSmYv7yNqwcLVUkNExYLGx82QdJDobyjaP5iYYE3c9fYEwdI9sTSejtecrBxiB22I5aml+geyADHZ3IfGGIjWGabrIsggf1BLanUlke1Cu08s/jqayxuEhloztiL3YgWtMy+Ht/dZpstENolhU90cAfH/utGYg9ZGzmtqLnYTx2EdcvV7oybBOVGPtUgwVxh2ZQCDuJnEM9x+X6RAjS+iq+BAPswDyNDoiAT0zQ7WbVCTVgqCtTIsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zw8HLsy2fgkJSqVwcTL6wddwlDCML48Rewrq9qTmgQ=;
 b=VTrunw9lsLap9tCJgO1Y/Kc6I+sGVDzXrIzSzB98ntIn34ZqGaCtsXifDt4j5hFOMNJRbXy4oxiyVmc8O1NJmoczDAo8wbNzih6FOBL9V/WGXBHg+I7Y4YYMZucse4LqskdIHfkQ9bjmdnftc/IsDzIndm+QVdIqCQGQeomjCcw=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4762.namprd11.prod.outlook.com (2603:10b6:303:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 16:09:36 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9%4]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 16:09:36 +0000
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
Thread-Index: AQHV+9aq9JxrAmD3GUitnjKGS5ypvqhO/2QAgAKnXgA=
Date:   Fri, 20 Mar 2020 16:09:36 +0000
Message-ID: <MW3PR11MB46651022C7EFD74C856675E1F4F50@MW3PR11MB4665.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: d083ef3c-fb2e-4339-1189-08d7cce915ef
x-ms-traffictypediagnostic: MW3PR11MB4762:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB47620288963814A8C23C1FF8F4F50@MW3PR11MB4762.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(71200400001)(5660300002)(9686003)(2906002)(53546011)(55016002)(6506007)(186003)(86362001)(26005)(7696005)(66946007)(76116006)(66476007)(66556008)(110136005)(81166006)(66446008)(81156014)(8676002)(54906003)(4326008)(498600001)(52536014)(8936002)(6636002)(33656002)(107886003)(966005)(64756008)(21314003)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4762;H:MW3PR11MB4665.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxsKYoSLufiBw39OdORutBA4xv6Ld+T0W3kGNS+HUmTp6pizZgPnU0xVte+zTgyyOe1XIxkaJAfjQYaW3SrxALX3Pe6KMUXKlkk1/edM6ae1okWbs81jPjV63oVAdeKIoHWNSd++GX5mYUBouaOIdtkPY4A1cKHFqtrgFG8iehsoXtWTiN3PcBaGBaZiu6G7l1lhGhZUj5NeqRWDADbU8TOH40wWsBiAtmOHZ0N0Nu1f8PGdVFinjSG/yUGayHEbkwh764JdlQ/uDyUvtp8sqQ15SbEmNBnd4+vcvC1NAguAmqvH7gqr0rTwqW6yEjPESO1kjA/8rpFyuNf8HrInHdUUo+RKwer6rd6fLi6TicP8RphmyYCliL7X3OaEpUlnXgetNitM5fz/t3FZ83tKvozbMbdn5gVVRze7sQ6JLlLWtTIQePQGA1y14ad4GgVyILpeYlOsE3/F0R6jgRUdILhI8j8nvq1qN8FRb7E55xl+zntPvPxDv3x8s4pwOuNRPL1rB57ghbX66kIikJKAKybqDuE6KV+Ql+a7u2lyjC5GUZKRU1kd5O3Hi4AOd0cje7n8Eqg1UFIaFZgsVti2BWZJGDLXNlKRkNZKrxgZV+Q=
x-ms-exchange-antispam-messagedata: M/1oZ6kUIFUrW+50V878HbP3rqefCx0aA/phwTivwWo2vF8asqJkA14sDOMi+ZHXCF/wG81tnjSbiORNXasJvFwmvB2vNYVHzDbYnXimqlJ53lqdlcCsk/A5eQ0/ZNDQyqlMVVAOzmTjwZEhuuR4ug==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d083ef3c-fb2e-4339-1189-08d7cce915ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 16:09:36.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rc4QxGbRcHwgsIhfxA1/HpLtYOn4hkus+8JuIv7fLSiHgv3jjfrTwdbmjhY98u9+P51xL8CE9SG1d4C5/EI1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
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
> On Mon, Mar 16, 2020 at 05:05:07PM -0400, Dennis Dalessandro wrote:
> > From: Kaike Wan <kaike.wan@intel.com>
> >
> > This patch is implemented to address the concerns raised in:
> >   https://marc.info/?l=3Dlinux-rdma&m=3D158101337614772&w=3D2
> >
> > The hfi1 driver dynammically allocates a struct device to represent
> > the cdev in sysfs and devtmpfs (/dev/hfi1_x). On the other hand, the
> > hfi1_devdata already contains a struct device in its ibdev field
> > (hfi1_devdata.verbs_dev.rdi.ibdev.dev), and it is therefore possible
> > to eliminate the dynamical allocation when creating the cdev. Since
> > each device could be added to the sysfs only once and the function
> > device_add() is already called for the ibdev in ib_register_device(),
> > the function cdev_device_add() could not be used to create the cdev,
> > even though the hfi1_devdata contains both cdev and ibdev in the same
> > structure.
> >
> > This patch eliminates the dynamic allocation by creating the cdev
> > first, setting up the ibdev, and then calling the ib_register_device()
> > to add the device to sysfs and devtmpfs.
> >
> > Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> > Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> >  drivers/infiniband/hw/hfi1/device.c   |   23 ++++++++++++++++-------
> >  drivers/infiniband/hw/hfi1/file_ops.c |    5 ++---
> >  drivers/infiniband/hw/hfi1/hfi.h      |    1 -
> >  drivers/infiniband/hw/hfi1/init.c     |   18 +++++++++---------
> >  4 files changed, 27 insertions(+), 20 deletions(-)
> >
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
Will be fixed.

>  2) WTF? Why is it changing the devt inside a struct ib_device??
This is needed to create /dev/hfi1_xxx. See below.

>=20
> And I'm looking at some of the existing code around the cdev and wonderin=
g
> how on earth does it even work?
>=20
> Why is it calling kobject_set_name()? Look in Documentation/kobject.txt.
> This function isn't supposed to be used.
There is no need to set the kobject name in cdev. Will be removed.
>=20
> Shouldn't there be a struct device to anchor this in sysfs? I'm very conf=
used
> how this is working, where did the hif1_xx sysfs directory come from?
Yes, ib_device is the struct device the cdev is anchored to. All we do here=
 is to imitate what is done in cdev_device_add(), as suggested by you previ=
ously. The cdev and ib_device are in the same hfi1_devdata structure and no=
rmally we should use cdev_device_add() to add the cdev to the system. Howev=
er, due to the fact that ib_register_device() calls device_add() to add the=
 ib_device to the system, we can't call
cdev_device_add() (which also calls device_add()) directly. Instead, we hav=
e to set devt inside ib_device first, call cdev_set_parent() and cdev_add()=
, and eventually call ib_register_device().

If this is not desirable, we could keep the current approach to create the =
struct device dynamically through device_create(). In that case, all we nee=
d to do is to clean up the code. Which one do you prefer?

Kaike
