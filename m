Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609DD18A01F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 17:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCRQCr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 12:02:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:36700 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgCRQCr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 12:02:47 -0400
IronPort-SDR: ByH5jNjEcM0ynv01x6dfHQEo3P4TxVppZhiuONMgpUHdG7dzXtT8WH3N4Qqa/CtUpeqIDRHKol
 aY0T9DRfc6fA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 09:02:46 -0700
IronPort-SDR: kPoEoIOs+irffI8Ia9y8/TkDPBTJm4fEC8IDdxVbhIvHSTSnTVnfGByKffNc+gNdPqAlEHBQs6
 +Fp5i1cXSL4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="324230295"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2020 09:02:46 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 09:02:45 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX161.amr.corp.intel.com (10.22.240.84) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 09:02:46 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 18 Mar 2020 09:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA5dBdazqYruwmd2n1a+CWkE0N8IYGvHkr1VIqVMReNXKwk8q2J866KU5Q4AI9mkE8ng2sGmG2ePqCC4AVK8J4sczHgwEpiUnUl7RwoOnmgtWoNn1B/xfgNZuwixxtjynNrrWIGaqlBMzGU+dMeXMc//7AbRv3b8Lkq1HhqC+G83mt0fGkPf7OEDohXhxYv/2v1fkq+hbnf3xW51nsmp5HRbDTky5aFzhs+Ly67d4mjC7bElJPmh6xBrRspjnM/rgf9FwH5WzGEAwf/3ZHu9OJVREpf6VdoEf8Lu6eZj5h+Vn/iKJNL6CR87709sl2egBB/+N8ZM7CdmARXMG9kxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40BqQAUUmA/IUy+1UY5ksfd+v+O3ABRqQ5QeP7u9Phk=;
 b=h0ujtWuv8brSw5YIDv2m4Na6ifyvN3njeTW1svfUbU5WAS/o9ojxoZ6EsSpfO6AtIrjsN2J12E5vczaG7+a4+U8cfVwLWuBHtnpfogF4bDFOndpYKXh66ikRzwJOl4VNDqsvaTVg9zJHUI+AGTEeSwG9P5dUaF9P6ezn29zEjdzjtr3sv0cDwRG38oileX98128xs+y/2YgoWn4QZlyk6uI4WNaYgCc1C5o+0TwYnTToGh8xk02LWjLi/jcJG4dZ5BioOOMyWWV6RE1XS7Mfl7C5PNkOh7aJ+seAMZ48WFwNJ3o8rkTB6TOaLLJFWQAPEO6dU5IN+cRldobngIu7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40BqQAUUmA/IUy+1UY5ksfd+v+O3ABRqQ5QeP7u9Phk=;
 b=YL5M4ZUG2kkK/SbcZ7a1UBkrbuHoytAIp0ILmiTOOwHBtv2zfao7kurrjqit4pPbH0mJ3TwIbqwuaMGXorbZMvf+VU53qeJjfGinMUuPJMY5ZyyE29IlZIALQK8CBUaItJ+cJKGBogffUGF4FKFRLKIn6HG/pS4E1kblANUE+LU=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Wed, 18 Mar
 2020 16:02:43 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9%4]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 16:02:42 +0000
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
Thread-Index: AQHV+9aq9JxrAmD3GUitnjKGS5ypvqhOW4GAgAAm+8A=
Date:   Wed, 18 Mar 2020 16:02:42 +0000
Message-ID: <MW3PR11MB466582BEE0315ABD0ABEBAB9F4F70@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
 <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
 <20200318133155.GA20941@ziepe.ca>
In-Reply-To: <20200318133155.GA20941@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: e5d58af4-50ba-4a1a-b56d-08d7cb55cab2
x-ms-traffictypediagnostic: MW3PR11MB4652:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46520C4E61149931A5CAF921F4F70@MW3PR11MB4652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(136003)(346002)(199004)(6636002)(26005)(186003)(86362001)(66476007)(52536014)(4326008)(8676002)(81166006)(66946007)(9686003)(66556008)(76116006)(55016002)(33656002)(107886003)(81156014)(8936002)(66446008)(64756008)(71200400001)(5660300002)(2906002)(53546011)(7696005)(6506007)(110136005)(54906003)(316002)(478600001)(966005)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4652;H:MW3PR11MB4665.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cod2dmU58NYwTvA49yHAjz6JlpeSiO5PhrdIk2mmbk5G/LdDPijQK+vK57FpQxWHvfe/vm4zyZTj4o28aVOedVcnx3b558IbWlcXRYjtqwN3O7FrrX7JVwtJbYHgRuBVggzA1Pj5o3xsxdGHiOuzkNsMW19QjmCbWX0CHshDAKmNZF7AWIcKUwWO3v+pwuYCwQ1i80Oh0YAfEyhNrMBKtvA/NeMMA/4fJr5spRikqXh38Nfid78SGRh5HT6DpYxV/68CuEgiO347TbRdbQE5yqd3uanalqeHWWhtbslP2CNRxrkKX2ujqW3soHJBJKGUaAANa5w5JjE9jZQx3H8hwDCbKvVqQu8hhDP2OfOjtYM5+J9TpUghFu97wjqh3vkMtcb8uSAX1UD5Fw5XgfC8wuVbhcv6ogBO9A1oQ40vX+sqNI2C3A45qK1EXUPFxaF7n06hyki4H6TTJZ25RHpaIiBr5wXOYb9Gjo1lF+Kq0UEZ7dRHmuN6+YvBs+oOQnXRIzO2ThgPl6B9kT5F2SVUWxExm3okH40Q+vttqqSE1FgE+RrIvP4mGFn56nHmRaMH
x-ms-exchange-antispam-messagedata: fqF6DeE9kldkU8DDm6e5WANQfsA+vHlEmGPkWO17/yq7NoPfK7AFzsvbwqU4YJy/n1D5VoISc92ZIVVsGJDR0HvANnPBfsX9VxHdsN1H2u/PlTVhGL6c71vW27F3hP6nOkL1rWPfQqV0D8SNfhDi6Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d58af4-50ba-4a1a-b56d-08d7cb55cab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 16:02:42.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O16+IPG8WEZwlDyuAy4ulGHZYwqy6av2sFH2HT8XaFju2LIQseGEtcWUTGaNxMytwnIHuhK6xc9ZfvoFF4mTIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, March 18, 2020 9:32 AM
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
>=20
> What do the sysfs paths for the cdev look like now?

ls -l /sys/dev/char/243:0
lrwxrwxrwx 1 root root 0 Mar 15 14:30 /sys/dev/char/243:0 -> ../../devices/=
pci0000:00/0000:00:02.0/0000:02:00.0/infiniband/hfi1_0

It points back to the IB device (hfi1_0 ).

Before this change, it pointed back to a virtual device:

ls /sys/dev/char/243:0 -l
lrwxrwxrwx 1 root root 0 Mar 18 11:52 /sys/dev/char/243:0 -> ../../devices/=
virtual/hfi1_user/hfi1_0


Kaike
>=20
> Jason
