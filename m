Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E1318D5D7
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgCTRbA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 13:31:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:15956 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgCTRa7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 13:30:59 -0400
IronPort-SDR: UtCL9bbRHAdiR7uN4yDT853GVu9OZtsirr/nGhCqt+6IXM+5hfq+8j6baGawey4nBjJH8yYSb1
 XqLPfS/F/UrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 10:30:57 -0700
IronPort-SDR: cWXYmkKFPyz8SeRmG+Q6PuruxnOHG8BNtOOPQcoPPa3Q2kVH0xgdCySbfPa8wQ3mAttdHxXffU
 3ngljYDSjZjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="269161348"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2020 10:30:57 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Mar 2020 10:30:57 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Mar 2020 10:30:56 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 20 Mar 2020 10:30:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 20 Mar 2020 10:30:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LomvdnUIzte1IYBjgey5xY+uoSLhAMdBDKsNMuWhcImCfV7ABuRkhOyYPi9ahihid5Km4AH9+L1HfvZCq77ftK0aUqnLQDfwbuIb3gpBoixoe2ntZM2moaAT3nM3uvnxBlM689ivFX+7i+eAcwE5UZeffTjFqnaZmPzeyVHUI4aFlvWmAlg03nlRHkC3Gmvza/V1swdkv4o1YWBBp4G/g/PatxDot7V3E6xyUUA2gspgj2oSHrCbFWuRURUfRkuG61MnJI0IhvydonaQ5YtpFg5BpCR1xe/ouuaKzbqe6vkO5swZBSnlTyU8Kep6rqM6imIz9LX73ln5joWrfvo8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPLw9Bcv+lTU0A8DLHZs9xqgWzqhE6fQft0i8QypV2k=;
 b=Sidu3PjC++hsPewyQA7SAGXrzGQVtOk3jox3+zOPAKp/xBTBCpPJaN5/yescP6QbmzgAxnZ53l6o6xeygRyyjQYTfycGAQUQabDlmQ5NKWxMQUi1WdNIXqF0T84zJYcP76dnMMwrWCpN0MJDHCwkq6jFJu9ant4ShjfYdMz6UrZwZRzBG1hESSeXlGQCTwSio7WUZ96lIB5SpCRzxVIC03D9gqeWrgpuvcpZ7H56XToAP/dsr8v0RSCAmSDkY4yweDnIF7xyVA2PqQiWxOc9eZ63Uk1RcpmNtdLPbhSHO2Wv8dzGo6sIoFmxk+PR6rOmkhO9YBCxOo0UCt/+pERyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPLw9Bcv+lTU0A8DLHZs9xqgWzqhE6fQft0i8QypV2k=;
 b=D29KFAoGvh3TdJopMqmdqH8FS75wptVGA1RLZow/AJ73ZtM+bMoYp5i5MZ4g7fdFWa6Q1n4EnXqW9hXyOde2YtZ/o3ZDK7Zm/OP7QPi7/cjMrnp/Q7PISwbBzCahAx2wjAz5OXNGp083abIonWcoQ6pmiLLC8OIFAxQcvA+5/T8=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Fri, 20 Mar
 2020 17:30:40 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9%4]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 17:30:40 +0000
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
Thread-Index: AQHV+9aq9JxrAmD3GUitnjKGS5ypvqhO/2QAgAKnXgCAAAvZgIAADglg
Date:   Fri, 20 Mar 2020 17:30:40 +0000
Message-ID: <MW3PR11MB46657936C2E8286A3CB2234CF4F50@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <20200316210246.7753.40221.stgit@awfm-01.aw.intel.com>
 <20200316210507.7753.42347.stgit@awfm-01.aw.intel.com>
 <20200318231830.GA9586@ziepe.ca>
 <MW3PR11MB46651022C7EFD74C856675E1F4F50@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200320163227.GS20941@ziepe.ca>
In-Reply-To: <20200320163227.GS20941@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: b2a9ed4a-2664-4485-dd32-08d7ccf46903
x-ms-traffictypediagnostic: MW3PR11MB4651:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4651031F6145F4B971C235C7F4F50@MW3PR11MB4651.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(86362001)(2906002)(7696005)(53546011)(6916009)(498600001)(33656002)(54906003)(81156014)(8936002)(6506007)(8676002)(81166006)(66476007)(9686003)(66556008)(52536014)(66446008)(64756008)(76116006)(186003)(107886003)(71200400001)(4326008)(66946007)(55016002)(26005)(5660300002)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4651;H:MW3PR11MB4665.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ro5Ac793HzUm++KfCcKhhut16cqkbJivDmOqM1MnRprT3PeBkPBWE220e8TCen0IcaWZRJkZgAn96LpLZAM7xPKUxmAX2/P84qoWz780hFk/wfZV2xTyAhGBBdLDtvqBmRa8Nz++y6V/QWFFj+2puKpO1IducKIYfRmmpRSLA+/Kss4fua+DJKFPMT/AGOelSQw6vRr3M18R2S0TW1HmutglW+SZ4UJ5UB8/aX5pIMdzhVxNWJaP0lnlBcmC3LDcn6KHy888UdjpB6bOJJfdlw0/7hRuW99p8+Tabh3ugcdsW0rBkCfpcyHEHAVa7M9CqPezzsZiZf3SF5gydFKcIyVRHgNWl3zfi9ZXfkSxgvXXb6pb/6UGlmKO/LJMZ8PNlCuSKuWozYRwKotG9Q6xzwlh3WOY5UdGU0Ri3nFK31a1Matz1hNq1IBGDWlI5p01luZxlkMXMRfHIOdwgyp1S/Nxz98mwG5gwM3LLhoBuc5tTid4hxKRhxxrDz0FLJO
x-ms-exchange-antispam-messagedata: 7+VZwbJE9WHcNoIGKtBGCXWXVu7mB3r2LOLPbX4nvNu8f887hc40p1lezqz54Ry3M07QwpkufrjX8g1jS7cUK3TOnkpTipsB1/pNuLa4PmUvj+cgWLocvpOVZrDyuQdhI3WqddnNvqgX3deogzn0kA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a9ed4a-2664-4485-dd32-08d7ccf46903
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 17:30:40.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7Lo029Cby6ndIl183jrVLV0/AIF/oSMcpy1txLUt/UhP1aSDLFsK1ssii8SSyUJ64eZxst3dRpw1cgbAyYKbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4651
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, March 20, 2020 12:32 PM
> To: Wan, Kaike <kaike.wan@intel.com>
> Cc: Dalessandro, Dennis <dennis.dalessandro@intel.com>;
> dledford@redhat.com; linux-rdma@vger.kernel.org; Marciniszyn, Mike
> <mike.marciniszyn@intel.com>
> Subject: Re: [PATCH for-next 3/3] IB/hfi1: Use the ibdev in hfi1_devdata =
as
> the parent of cdev
>=20
> On Fri, Mar 20, 2020 at 04:09:36PM +0000, Wan, Kaike wrote:
>=20
> > >  2) WTF? Why is it changing the devt inside a struct ib_device??
> > This is needed to create /dev/hfi1_xxx. See below.
>=20
> Well, you can't do this, that belongs to the ib_device, not the driver.
>=20
> > > Why is it calling kobject_set_name()? Look in Documentation/kobject.t=
xt.
> > > This function isn't supposed to be used.
> > There is no need to set the kobject name in cdev. Will be removed.
>=20
> So the hfi1_0 name is actually the name of the ib device? But that makes =
no
> sense, now the name of the char dev is not going to be stable in sysfs af=
ter
> the ib_device is renamed.
>=20
> > > Shouldn't there be a struct device to anchor this in sysfs? I'm very
> > > confused how this is working, where did the hif1_xx sysfs directory
> > > come from?
>=20
> > Yes, ib_device is the struct device the cdev is anchored to. All we do
> > here is to imitate what is done in cdev_device_add(), as suggested by
> > you previously.
>=20
> I said to use cdev_device_add because that is the right thing to do.
>=20
> > If this is not desirable, we could keep the current approach to create
> > the struct device dynamically through device_create(). In that case,
> > all we need to do is to clean up the code. Which one do you prefer?
>=20
> The issue here was parentage. There should not be a virtual device involv=
ed.
>=20
> The hfi1 user_class device should be parented to the ib_device, look at h=
ow
> things like umad work to do this properly.
So all we need to do is:
-- Change user_device from struct device * to struct device in hfi1_devdata=
;
-- Set up dd->user_device properly including setting its parent to ib_devic=
e;
-- call cdev_device_all().

Correct?

Kaike
