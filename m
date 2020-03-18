Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FB618A144
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 18:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCRRNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 13:13:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:14761 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCRRND (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 13:13:03 -0400
IronPort-SDR: jyWChC6wMK3NyreGyujnmtrAzJgDz0ask1IFDymPvdW4msTqd+7XhaGy3nDtURJw1yhOD1PA0Q
 Jm/DeAxUOcbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 10:13:02 -0700
IronPort-SDR: 1xG5k1epf3OFfNHJPaoPZIW12VDiY0m8JmR+wuUjiLhmy442qNV8Qzbstt18Ff4nUkaUlBnlPt
 1cXvA502MD6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="391516407"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2020 10:13:02 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 10:13:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 10:13:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxQqeTChaMMoZgpXGC9DU3YvJukE25dsXOQ5FKdpAX0B2hyr7B2IrV7BoCfw7uALfOz/uTW8+sLbvl/Acts3asqDiuxezRcis2zUC/EKvHdKEiJkGxdg8szAkqMmY/LaA2pQHlMc2v7gcQ3WOmID8Sfqz9mwdjTtR/nLFrX38B6TBJAKZjB7MP1b1tE9M48WHYGjW5ZSGS2m52E4qnvWHAJVy+ccao7rc6bgpRw1b7Lt+/HHaitE4EA3WEzuJULGGDry3pj7Z8ogZjQdUVZsHmc6bKo82iBDDwdt9HqN0YNeVQcBa1WCAIRyyjsbmTWBJLwqLULo+U9ku8Seg40RRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbmHmAFe5NdxmiB5+16RTBDzLVG/LTr9uZFM6jU05Ek=;
 b=RdOofazOLGs8ua0xEVVKjnMKR+sN4Y+RxO3Oo7Fi+7hjZ4mM3a620OSqgxfofVv0eLG3qbI7Kw2s/hB3Xw2hsa6TOheYgkxjoMNJQqOYerPpSBuw/6hh3gkqXXgUzii5L/CjWd6SKBwsfWwp5E/2EiXRrB/hwI9csNJ5jD7lna718iwziDUv9cYCPcYSVmnoz+5Z2ql1ktcqzbg3Z1+qfVEVqPLwvXqAfcF9QKg492nFOjdS2qooe6GhXa3kLBIRIfYuVSJATIJN8tQy5hRoXPaztMUlbgwcf5GCT74aVkZWNGoxoeCWH1v2W0OPLMpPWpAYTg8CETwbfSuTR0Irdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbmHmAFe5NdxmiB5+16RTBDzLVG/LTr9uZFM6jU05Ek=;
 b=QJcLEhsQenT0clV86ew6l9mi1mYZetF6ZP8JoPoUm7aZbQafWmI/ezenbEoxUiOhZZUYy9xGf/5tARbfIXBlHtjXOMbstmExBd8AFbdXHf6wuJPBHXl/4KBuoJZj/IErZxjev/Dlx49SJ3xaI2oNbgRTJQb6vgcpH3LTgeodcko=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4747.namprd11.prod.outlook.com (2603:10b6:303:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 17:13:00 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9%4]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 17:13:00 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: RE: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
 the parent of cdev
Thread-Topic: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata as
 the parent of cdev
Thread-Index: AQHV+9aq9JxrAmD3GUitnjKGS5ypvqhOW4GAgAAm+8CAAAwhgIAAATeA
Date:   Wed, 18 Mar 2020 17:13:00 +0000
Message-ID: <MW3PR11MB466590C498DAB954B4CE3999F4F70@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
 <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
 <20200318133155.GA20941@ziepe.ca>
 <MW3PR11MB466582BEE0315ABD0ABEBAB9F4F70@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200318163451.GC20941@ziepe.ca>
In-Reply-To: <20200318163451.GC20941@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: 836acfcb-a660-4063-b277-08d7cb5f9c6f
x-ms-traffictypediagnostic: MW3PR11MB4747:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB474783E06FAC3B94E9D6CC33F4F70@MW3PR11MB4747.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(8676002)(478600001)(107886003)(55016002)(81166006)(9686003)(26005)(53546011)(186003)(6506007)(7696005)(86362001)(4326008)(81156014)(33656002)(316002)(54906003)(66556008)(8936002)(6916009)(64756008)(66946007)(66476007)(66446008)(52536014)(71200400001)(5660300002)(2906002)(76116006)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4747;H:MW3PR11MB4665.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Om6hdcv1e8GpFhCKW5jOiGKo1D0FpnbOxUq4ECCwiZa5oTJgRu2ayAiFe6t74c0Jq/45FrdakniCh69J2FK0dwintvQZS3gyS/iF88Na7LLd25ehzH3B9HEJLcbbDZ8uJJZEVtfhbCaDkGDbvMfgWyyWczZng5UFrPOPz3LNJdrI6cMsr+1xrdOnBARr6sicdS6jaUZ/rDEArcAVprk88R2uJqJbXN0R0Nuu3juNHLDKBGTJooTC5mIoxLUPlrafPSL3f0H+kU+aeUTKd+Ste1IZDaMKSW//2tDteZCXNIhMehNLtGnaF7vfuFvUn4fBUKs2JWTEbrcLLsaOlcPl19MWWmxVBaEyaxRV+bEAewT/h7Uy1SYaWDEOgE69o8ERJuk8NxFFNxPGVIe4Wyg8WsBXirwP0YfKKK+lwfWx6GEEZq/Cy9+wkOyqph73RBrkdgQ73UuMyzuh4omQisIol6wBdo9y3MYuMsERR+S7flYdEJfUnVDgRKfAjCanV40
x-ms-exchange-antispam-messagedata: mgoHwVxsVBEkcPQeNFy+MdQt0UlBR0BCV8NdyfBVndYjQQoh4rgpp/xlHhIt6QWX7EIVzNhzHoedVdSN/wU0na12sBkAt8txZPX4n/RtVj1FdXeOi7HkGknwVd8UBGv1III3cclZaA/lgx78zXQqMw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 836acfcb-a660-4063-b277-08d7cb5f9c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 17:13:00.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5O3tNyhJxMIigku9H1UiuTdqZXpZVQlzmGdkqFbeqL8wYLUaHfSfzcP29KWnPZtHeh6N79sw6l803f6zHzwwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4747
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, March 18, 2020 12:35 PM
> To: Wan, Kaike <kaike.wan@intel.com>
> Cc: Dalessandro, Dennis <dennis.dalessandro@intel.com>;
> dledford@redhat.com; linux-rdma@vger.kernel.org; Marciniszyn, Mike
> <mike.marciniszyn@intel.com>
> Subject: Re: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata =
as
> the parent of cdev
>=20

> > > >
> > > > The hfi1 driver dynammically allocates a struct device to
> > > > represent the cdev in sysfs and devtmpfs (/dev/hfi1_x). On the
> > > > other hand, the hfi1_devdata already contains a struct device in
> > > > its ibdev field (hfi1_devdata.verbs_dev.rdi.ibdev.dev), and it is
> > > > therefore possible to eliminate the dynamical allocation when
> > > > creating the cdev. Since each device could be added to the sysfs
> > > > only once and the function
> > > > device_add() is already called for the ibdev in
> > > > ib_register_device(), the function cdev_device_add() could not be
> > > > used to create the cdev, even though the hfi1_devdata contains
> > > > both cdev and ibdev in the same structure.
> > > >
> > > > This patch eliminates the dynamic allocation by creating the cdev
> > > > first, setting up the ibdev, and then calling the
> > > > ib_register_device() to add the device to sysfs and devtmpfs.
> > >
> > > What do the sysfs paths for the cdev look like now?
> >
> > ls -l /sys/dev/char/243:0
> > lrwxrwxrwx 1 root root 0 Mar 15 14:30 /sys/dev/char/243:0 ->
> > ../../devices/pci0000:00/0000:00:02.0/0000:02:00.0/infiniband/hfi1_0
> >
> > It points back to the IB device (hfi1_0 ).
> >
> > Before this change, it pointed back to a virtual device:
> >
> > ls /sys/dev/char/243:0 -l
> > lrwxrwxrwx 1 root root 0 Mar 18 11:52 /sys/dev/char/243:0 ->
> > ../../devices/virtual/hfi1_user/hfi1_0
>=20
> Great, yes this looks right to me
>=20
> So this came up due to PSM having problems.. The right way for PSM to wor=
k
> is now to find the hfi1_0 devices under /sys/class/hfi1_user/* and then m=
ap
> then back to RDMA devices and the physical card by doing realpath and
> learning the '/sys/pci0000:00/0000:00:02.0/0000:02:00.0/infiniband/XXX/'
> path
>=20
> Yes?
That is certainly one way to get the device info.

Kaike
