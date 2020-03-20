Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E918C441
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 01:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCTA0h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 20:26:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:3861 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCTA0h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 20:26:37 -0400
IronPort-SDR: XbHXIqqybA4ajeM4/mRQKtnNuOO8Xem0PWkHwViMXnwgDMuIRxaH3MAI+9gd3s4h5R1uht410I
 m7Seq1wnEybg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 17:26:36 -0700
IronPort-SDR: NUsCTO6baOoBhXmgmqQXjB2NvEfp5gyFVsG6sYG0+WndRHovzIenBNTTTO3yIUdhhI27AkCdUD
 bZ1neYqeXhYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,573,1574150400"; 
   d="scan'208";a="418539924"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2020 17:26:36 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 17:26:36 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Mar 2020 17:26:35 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Mar 2020 17:26:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 19 Mar 2020 17:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WisAsArJN2oz+GEuJeP11cRYhBTjQRjvsTl+kDDelqM4BXV7KwA+dIuMM2DjICSE/G9JKohMF0iaVBEC03vTRlPtMzp+05j8IbQq7VqF5GPUBO3qoL60Q8zOe0ata0AU7Hk474vJG/v2Aop3KmK6QT/fAQRj4C2AEw6V9dGYZyHfnQwf6rRWmudSdDMSTM3owPcYh4PgPrgbuHQh3Bkyi3smTfPcC+EYH8fj1q3Dzzm2ub4xlZ3pdJaULhJM7dSKsSUdpHQqkzqyVYHFSWEiIZGxxzB3WvVbV2tinlOEwbWwQQRoaQGcBbgiRAIxHBmf6dx0bLBjVBLbCCoxbLYG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0wGLReJukJb63V4iakiIrMYPerb4bm0qcGYjgY0C7s=;
 b=LcheG0zpoz2Zv2W+uLNEsPmVHzAgU1VdG22dCtZhb6pVVzW3y3iXa1IQQ6m93He0isDR3FgAJ6s1Yh/tbYiq1Cm/AF7CtcZK0r7xTxLv9/dZuweuXrFumK8v8dU0kmKCspzMPIOSzjEjYaPOD6h99jPonjwZ3gehWU9asrgSS0DiynDm7ys3rQVzo3nNohyz6EjRKNv11YqdtRGVrPgZzVN8aiPanD71EJWI2fQkitC2uPitphu2oEnaU1dUqA1XNBzMWexMnvR+jqO+sZmf2r/S81pd0Q8wqDNCT1QedJAVddKbZOjzdQ+547jl/VS1PrSSp0j+erEBCvGJPMV4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0wGLReJukJb63V4iakiIrMYPerb4bm0qcGYjgY0C7s=;
 b=RpwK5As1vdH8SBvQ0k3t3Aav0/QVQghMJ9V2FzAj/uSiVrYDlTIRfndeLGgokJeJcmK2koX44mpqRvFBN59u5J5IzZKDBeegOq6pwSylUtCHpoVMmA0snV9bUeunzucZoGvxv43r3OyleaRVGbLHQL5m/dYutKGMf6fbiefBZOg=
Received: from BY5PR11MB3958.namprd11.prod.outlook.com (2603:10b6:a03:18e::19)
 by BY5PR11MB3927.namprd11.prod.outlook.com (2603:10b6:a03:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 00:26:32 +0000
Received: from BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::dcc8:671c:82b1:5ba3]) by BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::dcc8:671c:82b1:5ba3%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 00:26:32 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Wan, Kaike" <kaike.wan@intel.com>
Subject: RE: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
Thread-Topic: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
Thread-Index: AQHV/IsQucSlfc77E0CRxCDuqAbtfqhPBq4AgAFvtbCAAAUhAIAAI2PA
Date:   Fri, 20 Mar 2020 00:26:32 +0000
Message-ID: <BY5PR11MB3958128AA68368EBC40F91D786F50@BY5PR11MB3958.namprd11.prod.outlook.com>
References: <20200317160510.85914.22202.stgit@awfm-01.aw.intel.com>
 <20200318234938.GA19965@ziepe.ca>
 <BY5PR11MB3958F9E412A2033B6293772686F40@BY5PR11MB3958.namprd11.prod.outlook.com>
 <20200319220403.GN20941@ziepe.ca>
In-Reply-To: <20200319220403.GN20941@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: e879e078-84a2-4c87-7564-08d7cc655756
x-ms-traffictypediagnostic: BY5PR11MB3927:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB3927906A865471740D59219486F50@BY5PR11MB3927.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(39860400002)(366004)(199004)(8676002)(2906002)(9686003)(52536014)(33656002)(5660300002)(55016002)(71200400001)(6916009)(107886003)(186003)(316002)(81156014)(54906003)(81166006)(8936002)(4326008)(66476007)(76116006)(66556008)(64756008)(66946007)(66446008)(6506007)(86362001)(478600001)(26005)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR11MB3927;H:BY5PR11MB3958.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTHSygMKXp3xW1smQFlbLrWjv8YRelKMlE7zeMfXf4A3O7NBR0ONvPie7J9lDQaiOinVRWoOGL5ElE2bXNe1GneLPfTp7g3VZ++nTDJxP+jBawa7LVzaVrINcxx2pup+eBrxkY78+BN7K/T0TyYwSD13bDiOg1kWd6r6k6zQqg3GPi4DruQsXxsQno/wlDbB6suQZYIWdb4wGQ2kzLpTGjLDmyeS3fZ+MJXfU8t4BMOWgk8QGBNTg7hW4dmyeFerLCH5wohF9Az0aK/k4FdEqjutbxRIZfYHkxeD/3gebTIbiuTWMtH5oyakRQDlswUgawPYqLvZ5b4CKhTEmPHFJaK50G/wEHC1j8mYkeGWjNsuOXNfLm60ZuBleet5fjW2nJQZf7tUvQGZ/M2yk6CCpj/rDOG/YdWuDiKGq4dHfJ6nISfmO+e9DJGL+oD6HYXF
x-ms-exchange-antispam-messagedata: Ftqc0MMrje1++7MOP33BlxT/c+nHwdibNwrSXvn0EyC7aMWkkt6x/1upys0b98MYT3W92Xz/hoxePVHqI7OUJHo4fIfDpyoiKxOT9NhaQQBXhHiB5uIznM9h1+gGCo/zO7EHCoRVGTZdOp7x95j0Uw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e879e078-84a2-4c87-7564-08d7cc655756
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 00:26:32.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nqBTcFKARkYSUjfG56xrf7TWacynKVnFCDHi9IrCgN+T0znU0iS88WNJqqBOMCAiOb6DwoVe+fOb1ixBt0i+EoWKKfItVaBU5oZQ7HLIE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3927
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
>=20
> On Thu, Mar 19, 2020 at 09:46:54PM +0000, Marciniszyn, Mike wrote:
> > > Subject: Re: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlis=
t
> > >
> > > The only place that uses seqlock in infiniband is in hfi1
> > >
> > > It only calls seqlock_init and write_seqlock
> > >
> > > Never read_seqlock
> >
> > The sdma code uses read_seqbegin() and read_seq_retry() to avoid the
> spin
> > that is in that is in read_seqlock().
>=20
> Hm, I see.. I did not find these uses when I was grepping, but now I'm
> even less happy with this :(
>=20
> > The two calls together allow for detecting a race where the
> > interrupt handler detects if the base level submit routines
> > have enqueued to a waiter list due to a descriptor shortage
> > concurrently with the this interrupt handler.
>=20
> You can't use read seqlock to protect a linked list when the write
> side is doing list_del. It is just wrong.
>=20

It is not actually doing that.   The lock only protects the list_empty().

> > The full write_seqlock() is gotten when the list is not empty and the
> > req_seq_retry() detects when a list entry might have been added.
>=20
> A write side inside a read_side? It is maddness.
>=20
> > SDMA interrupts frequently encounter no waiters, so the lock only slows
> > down the interrupt handler.
>=20
> So, if you don't care about the race with adding then just use
> list_empty with no lock and then a normal spin lock
>=20

So are you suggesting the list_empty() can be uncontrolled?

Perhaps list_empty_careful() is a better choice?

> All this readlock stuff doesn't remove any races.
>=20
> > > Please clean this mess too.
> >
> > The APIs associated with SDMA and iowait are pretty loose and we
> > will clean the up in a subsequent patch series.  The nature of the lock=
ing
> > should not bleed out to the client code of SDMA.   We will adjust the
> > commit message to indicate this.
>=20
> So what is the explanation here? This uses a write seqlock for a
> linked list but it is OK because nothing uses the read side except to
> do list_empty, which is unnecessary, and will be fixed later?
>=20

I suggest we fix the bug and submit a follow-up to clean the locking up and
the open coding.

The patch footprint would probably be too large for stable as a single patc=
h.

Mike


