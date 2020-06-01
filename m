Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4C1EA435
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 14:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFAMti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 08:49:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:33638 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgFAMth (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jun 2020 08:49:37 -0400
IronPort-SDR: Od17eLTZgVpNkiWMFbvFTh8r7h8KAbvT6siZaZFPeQ7bc3pvQj6AVUaskTNghGfvjsf7EnPulT
 jIv3qoafXwmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 05:49:36 -0700
IronPort-SDR: CDeFQ5UX4UKQH3H2EsPJQUh+laBEyjvJhdx0Vgcu1iMLx9TnTcnSREaddhLEjbefQBpBL95+ro
 geflGURYmurg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,460,1583222400"; 
   d="scan'208";a="286266184"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2020 05:49:36 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jun 2020 05:49:36 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 1 Jun 2020 05:49:35 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 1 Jun 2020 05:49:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 1 Jun 2020 05:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyfmmtSY8lx6pv6MwCFGHbGbrKDmdDg9dKfNrpgx0tKeqjBYdeNqUf5r+6B/X/K8np6AYyRbAr0NrtI8X+LeheXApOtE2SVAs+RQx2eLR/RXfKfzvX+c0U4nYYSz+D6OLyAQRX8XcWvSH2hHN8zBnCAGGYo6bGT4Nlffk0WvCjEjua52lE7sfFQfPF/ycskXAxwIhRNf0DXCFRBk8F0M8A5awsSmt8KWDmybXX60vLr5hHrG8ChB8aDGJeCG+ZJKLs35dsRbUpFdJQ8Mnw6RjwXHCrV2T7LQaEWzZXbgwTAGVrUiLtP+mGxpAyfzn7wshD9SmAxBftytrQJPY4sZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKJwmPouZP6jFS+tB9bxfYRXXyeWs1iCGdkW/rnoZvU=;
 b=Me/ne+3LC8KG2gYF5J2pmy5Ql3onb911YWouqNCtx6r+hkENEZGQHhwb7mS55HBQWY6xFzRegmD2JYJ9Nb2+9kO+UUP5g90CZpy37jS2+r6DU5TISf3pmj0umQtbDg8qtdpDtWrR2VG5YM20UjlgCVMpHm93WUdHrIH5VgxYS0GF8jMDKQurlgpqKgqxC6VAiDUj4vYhh++qZflqPDYySFjtfzaAucbAZDLOPPbLKBe7IeqX3aoseDVRU+L0i2Zoyu5z5/F40FNg4ltzC7KrEULauOIKE/GHJDmRk0f1+3kbAII/rLvkbg9SkrQn66L0C1V732DkxMsJ0doN8lIhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKJwmPouZP6jFS+tB9bxfYRXXyeWs1iCGdkW/rnoZvU=;
 b=pd7zAJDRfTUO/0o95YvNXaOy1y5QkqnoUTz4oO4byvV3knqIIWgg1KAR9uN2iXw5lum5cqlgVNGCvrJgEq19xghQLTZ1HOKEub5Nzc0uVnrGKEEmeoxLy1wBXEdkxZJGFov70ccEqvBwFtZA4/E8omgDICVDkVL+bxRp0Gb0odw=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 12:49:33 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::4dbf:49cb:dc7a:5b3d]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::4dbf:49cb:dc7a:5b3d%8]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 12:49:33 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Andrejczuk, Grzegorz" <grzegorz.andrejczuk@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2] IB/hfi1: Fix hfi1_netdev_rx_init() error handling
Thread-Topic: [PATCH v2] IB/hfi1: Fix hfi1_netdev_rx_init() error handling
Thread-Index: AQHWNosMN8yfs/6uCUuZGVCcgIsI+6jB+NsAgAB+NoCAALTygIAAhueAgAAFdTA=
Date:   Mon, 1 Jun 2020 12:49:33 +0000
Message-ID: <MW3PR11MB46650C2EA914990C6549807AF48A0@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <BY5PR11MB3958CF61BB1F59A6F6B5234D868F0@BY5PR11MB3958.namprd11.prod.outlook.com>
 <20200530140224.GA1330098@mwanda> <20200531100512.GH66309@unreal>
 <20200531173655.GT22511@kadam> <20200601042433.GA34024@unreal>
 <20200601122723.GB4872@ziepe.ca>
In-Reply-To: <20200601122723.GB4872@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-originating-ip: [72.94.197.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18712247-2353-4eb6-c1ea-08d8062a3bab
x-ms-traffictypediagnostic: MW3PR11MB4620:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46201DE82F43AC57A1D59404F48A0@MW3PR11MB4620.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34keT0UUC9Q7r/oZl10JUJbxwKp48n0/VinkaXh5iL0zumcDPBLSyGGC/fXPxDcSZXt+iwmXmpAd323akv83gFShzl33vtLc3IFAxunsNDsX5WX7/XG/8Gi1zsGiLDqyanTR06q8TFvMWdl1yYBoFUsCbRUYIlI5V41RcbLTDIE89opMigxDS6k8GCPIsXtpB5Z4B/JEeO37X/vF88cHmh/aVv9rbvRuGGnOrDYgsOm5CxuQ5rbuCYPRKPj3XZO1TuJpQ8SenSctod2ovMlxKy5Nr/6PR8KOrSsALOqDzjvjgMJE1vgaFbiacMXXNkxsxcFBOaDzi72L66F4NbsJlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(376002)(39860400002)(136003)(6506007)(2906002)(53546011)(66446008)(8676002)(52536014)(5660300002)(64756008)(9686003)(86362001)(55016002)(186003)(66476007)(66946007)(66556008)(8936002)(26005)(7696005)(4326008)(83380400001)(110136005)(71200400001)(316002)(33656002)(478600001)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: u4X4uhO5CRfeWCO1T1v/JlLbA2Ifu3N2BtM8FzTnAktT0SD+Cg8NPvhCwg77/T+FRdYDbsgU+85jZq6gRF/YPqzNo8JKzWlh4sX/g7b/kqQcYOHsJKhazDR0vc+J6N+rKmXKj3O2bilem+l4ulos++5IQtatRYtcMe8+TiPViB7kcbh4Qvcse7rc2mQxOqDec0x2yiyOJdnjOA3/S2/U0Z5YPWPhWtqQENEMA4anxpeTkBuFYMrOdkV/ZPrQmLwfNvAiNI7dWzcAKlOGtVrFq6uI2V12ehORD+eX2QPkA/QI/dqyz0IMr/O5PGsITL9u+4zzaad2Plxbgpzgk0q79bIBQ+4vdBkXDupD724GkgFQr4z8mblaVqLdn6MEN6uXidWkfRDhwri2juOxNFHZoUR5rfJbE+kmFZmQIoQxgZ8r8+rfzXuRR+3UWkEn6WJyrK6oZgd6z6+UiqsnaolPdTKrZqwcMiHuLttr0xw/ytk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 18712247-2353-4eb6-c1ea-08d8062a3bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 12:49:33.0797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoQHxJ0X9HYsZ6af2tQikx73s+jM60/ExFrtci6JPJq7f15slHZ2hbfmQC5xfBeO6htQxxm6X/XM2O6JLw2hFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> Sent: Monday, June 01, 2020 8:27 AM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>; Marciniszyn, Mike
> <mike.marciniszyn@intel.com>; Andrejczuk, Grzegorz
> <grzegorz.andrejczuk@intel.com>; Dalessandro, Dennis
> <dennis.dalessandro@intel.com>; Doug Ledford <dledford@redhat.com>;
> linux-rdma@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: Re: [PATCH v2] IB/hfi1: Fix hfi1_netdev_rx_init() error handling
>=20
> On Mon, Jun 01, 2020 at 07:24:33AM +0300, Leon Romanovsky wrote:
> > On Sun, May 31, 2020 at 08:36:55PM +0300, Dan Carpenter wrote:
> > > On Sun, May 31, 2020 at 01:05:12PM +0300, Leon Romanovsky wrote:
> > > > On Sat, May 30, 2020 at 05:02:24PM +0300, Dan Carpenter wrote:
> > > > > The hfi1_vnic_up() function doesn't check whether
> > > > > hfi1_netdev_rx_init() returns errors.  In hfi1_vnic_init() we
> > > > > need to change the code to preserve the error code instead of
> returning success.
> > > > >
> > > > > Fixes: 2280740f01ae ("IB/hfi1: Virtual Network Interface
> > > > > Controller (VNIC) HW support")
> > > > > Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> > > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > v2: Add error handling in hfi1_vnic_up() and add second fixes
> > > > > tag
> > > > >
> > > > >  drivers/infiniband/hw/hfi1/vnic_main.c | 11 +++++++++--
> > > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c
> > > > > b/drivers/infiniband/hw/hfi1/vnic_main.c
> > > > > index b183c56b7b6a4..03f8be8e9488e 100644
> > > > > +++ b/drivers/infiniband/hw/hfi1/vnic_main.c
> > > > > @@ -457,13 +457,19 @@ static int hfi1_vnic_up(struct
> hfi1_vnic_vport_info *vinfo)
> > > > >  	if (rc < 0)
> > > > >  		return rc;
> > > > >
> > > > > -	hfi1_netdev_rx_init(dd);
> > > > > +	rc =3D hfi1_netdev_rx_init(dd);
> > > > > +	if (rc < 0)
Please use:  if (rc)

Thanks,

Kaike
> > > > > +		goto err_remove;
> > > >
> > > > Why did you check for the negative value here and didn't check belo=
w?
> > > >
> > >
> > > I just copied the pattern in the nearest code.  I didn't realize
> > > until now that it was different in both functions...  The checking
> > > isn't done consistently in this file.
> > >
> > > I can resend on Tuesday though if you want.
> >
> > I imagine that Jason will fix it once he will apply the patch.
>=20
> If someone from hfi says which is the right one, sure..
>=20
> Jason
