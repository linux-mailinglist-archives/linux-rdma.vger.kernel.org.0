Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6786318C286
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 22:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCSVq7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 17:46:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:57430 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCSVq7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 17:46:59 -0400
IronPort-SDR: ro2qVkYcl+UdnRb5uwsUF+cmylnTVDpbwguQm8SISFVc1TwrW9zbAkXNQDCdk9B+gFazeA4dYi
 9YCbedDIpJ4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 14:46:58 -0700
IronPort-SDR: qDbr24q+fJ90Lb5uHK58M5ehhddqqNdxXGfr3Eoc0kZvguEG+jpvE6PU9Fhh/jmJYjFcWGtdOB
 KlBMX28in4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,573,1574150400"; 
   d="scan'208";a="239048411"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 14:46:58 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 14:46:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Mar 2020 14:46:57 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Mar 2020 14:46:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 19 Mar 2020 14:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oALb4hfKUeT90/7z69CH5b8w4yBt6E7wGP2N949Wyb01uOJ6wtOQA6n0eSHZVKCiGryKu8Z4imoDxCndldgGsGCHVknhQv7SLWSJk44Y4UzJX/vd2hzRj8CrLJGaasOYde2e/X31aOi9Zh5O8q+rO5QzKZlrcm2DKgB2yzkeIQjXbsszDgmCS5nMmSm+LKgTS+t2havwFyOzgXSrRStp0ukslawvgs8Zh6ZEu+b+RiPTLBMaLDakQc/DaQkXQvYNckIIvfTn1CAgQ85Pj96qXmWu3TgMCot++rJiH0ocrWXPaeHvig3NgHZ/KEzJ6jXX+M9PWb4JslEf33Ne7RR4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1XxGQHhCjjWrjmiAX5MRB9eTorBj3LVn5WMMMm/wKU=;
 b=eHOMKM3PX9j2KSzzZtQUW46fJ+wMjpkSOo94lXq5ZfZXAqd9xp+EgbV/KvRdgMq2Mt7/uz3dAOtwxMkqjJEXFnMxTL/J5t4Qi+pBHuBCfZ8Xr9Zikbrbdiw3hDYrEKEjJ74FcngP43ce7MhMgb3xH3nB4feH/8o+zB4cR4YZvR74BmQnYBb73Kt92IWVHO10NKSUTOSmx0ag5Wl96OnMpw036A2IO6/7UOlhomSUcH4l8Kg8R5EPKP3KFLf8AdjQFlC96ZFpBEaZbUNVhAgv5TVQAQyj0WLtMFb18Kq03AEoIFhCHsFyAj5o/pxcmiVd9nLAnbDU4V2aRqnhTz+ToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1XxGQHhCjjWrjmiAX5MRB9eTorBj3LVn5WMMMm/wKU=;
 b=i//2rvzU81ThLEhVX/2oDaKhbj9bW5fCEm524nHsx+xiqCdDFKyBiAGLdAs/EybcQBFE9q+7Ke4rhNRq+MvRbqW3IXxvV+TVCqdAz8vJtT0Ai7G4Y8KRX7q5E91Pmcnrp1vjV8VzNGT4h7G7xuAJ9DUHIHd6Zs7nXK+T2tr+1Us=
Received: from BY5PR11MB3958.namprd11.prod.outlook.com (2603:10b6:a03:18e::19)
 by BY5PR11MB4434.namprd11.prod.outlook.com (2603:10b6:a03:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Thu, 19 Mar
 2020 21:46:54 +0000
Received: from BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::dcc8:671c:82b1:5ba3]) by BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::dcc8:671c:82b1:5ba3%7]) with mapi id 15.20.2835.017; Thu, 19 Mar 2020
 21:46:54 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Wan, Kaike" <kaike.wan@intel.com>
Subject: RE: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
Thread-Topic: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
Thread-Index: AQHV/IsQucSlfc77E0CRxCDuqAbtfqhPBq4AgAFvtbA=
Date:   Thu, 19 Mar 2020 21:46:54 +0000
Message-ID: <BY5PR11MB3958F9E412A2033B6293772686F40@BY5PR11MB3958.namprd11.prod.outlook.com>
References: <20200317160510.85914.22202.stgit@awfm-01.aw.intel.com>
 <20200318234938.GA19965@ziepe.ca>
In-Reply-To: <20200318234938.GA19965@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.marciniszyn@intel.com; 
x-originating-ip: [134.134.136.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 566528bc-07ca-465e-f90a-08d7cc4f0a49
x-ms-traffictypediagnostic: BY5PR11MB4434:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB443405C8C9A69878D579EF3186F40@BY5PR11MB4434.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(66946007)(186003)(26005)(4326008)(81166006)(107886003)(8676002)(81156014)(8936002)(478600001)(71200400001)(5660300002)(33656002)(52536014)(2906002)(66476007)(66446008)(64756008)(6636002)(9686003)(76116006)(66556008)(7696005)(110136005)(6506007)(54906003)(316002)(86362001)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR11MB4434;H:BY5PR11MB3958.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OJ3ZFrYtpgkBS67tZRztPbarhtewAFiRyczb9Hjtap4DxVXky2fUK9ZWRrDPehQn5RYuEcyw13ssf5sAhmk76UNUVzH6hwgXHo/jr7LRC8XtsKc8JbcK4zUKed0ovicPnlotHO9mECT1VuHOWdc/grOd52QyuUFWxQkpX7JAiYcpMbzIgu32wc7Zy7rtHaJnapnnIBYW/AxKHyvBu8twO4QANaSR2zN4XUZbs2+B/hwJC824OyRNgJpvj1MSVoCWgJaO0r7AkQ0x5USsBDSC9b36u5y+Bsx6iyN6LNvVwyhn1N+IftXJTGXqnxpM94S4IZ1gBMWjoLeVjVnwFuQlZrUafoRlPf01Nx7gU6JGgz11hda4NYDNNnRTOsDwdtoBW2oWSpaxSEkPTgB8sbeRkteRNOzSeL8nlQmN5ZPpu3JJSztrTMITkK1FSf20M6E
x-ms-exchange-antispam-messagedata: PFgHG0H5Hh9sU+JwRKsUnPtaTg2Ait0F8VRZ06mJ1be9LzMOnpUjey9fHKAKHrktZeZ9bchxlFgs32r7VQBF2/xLd5wXSRNxVxZqLLKSJywTJKELJ16rAzDfvU23R7KD2d/MeNFYkqmMbj6JA4KHGA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 566528bc-07ca-465e-f90a-08d7cc4f0a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 21:46:54.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFPqEL6HrXWrs01M6b1hCdEAe44lHm2mkh0nZp5kzZLQO8eAjZ3ZVP9DT8AZsxpZguMiMKLOFZyQeTGIG2w0cg8IWiupudQUqCc7z4qENgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4434
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
>=20
> The only place that uses seqlock in infiniband is in hfi1
>
> It only calls seqlock_init and write_seqlock
>
> Never read_seqlock

The sdma code uses read_seqbegin() and read_seq_retry() to avoid the spin
that is in that is in read_seqlock().

The two calls together allow for detecting a race where the
interrupt handler detects if the base level submit routines
have enqueued to a waiter list due to a descriptor shortage
concurrently with the this interrupt handler.

The full write_seqlock() is gotten when the list is not empty and the
req_seq_retry() detects when a list entry might have been added.

SDMA interrupts frequently encounter no waiters, so the lock only slows
down the interrupt handler.

See sdma_desc_avail() for details.

> Please clean this mess too.

The APIs associated with SDMA and iowait are pretty loose and we
will clean the up in a subsequent patch series.  The nature of the locking
should not bleed out to the client code of SDMA.   We will adjust the
commit message to indicate this.

> Also s/insure/ensure/, right?

Will Fix.

Mike
