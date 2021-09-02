Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01D3FF158
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbhIBQ2n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 12:28:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:17204 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234786AbhIBQ2m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 12:28:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198721983"
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="198721983"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 09:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="689200204"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 02 Sep 2021 09:27:38 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 2 Sep 2021 09:27:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 2 Sep 2021 09:27:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 2 Sep 2021 09:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0j9llxzmwi+1ZS80g7gG/Yb+MfrggGR72b5MEzmYRvi8qmfnmMaQTYGojaPrn4kIvbFTQx3fIsYjdbexWMlRJgvWnJmV/Fo1XyidF9IRhBDOyLbragm6H8y2Ufut5Buz7S5wcZbETB6/OarcevQ3MlZvBAk0W49u74Km6OcU8nJbjXRD8PXlGuj/XQWUCsKVFB3s162PXBQVvvReZwp4m7Ag/3vZTSGZ6qXtD4ovp+VbvC99E4TM4t6cILwYRbJfL90EE944qWm4H/GpM5y4NlYaFaKYm/icCIA9LAOEH9spBf4PxcZkhoPPZtC/KyHZAJL+S+qtQGezoXVvejkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2ZgMxu1R9nvS762ksbjq6hKm/ctlkZCylcUszHkjYY=;
 b=B2htEqHuidYAOn7ABH06pPj5YSZILtcJFGq6cbnsjOZbpdC5bq8LN+fie7zjIN+HWDh7w5aRhAonh//3BP5BAOExDUY/7gv/k4SgoU8Kj8p3HwHvDpwHmP3Zcxk+luzbRlNOIH/tLmVNkD7CvpSy3m+ROjhhcbd9EoV8oDoCXQB0QrW7kCB4eCd3zFVvl3vGrk3WhAFtGqZ1NnzIy+yCxpQTuagJorlFUGRlskBUFlfKIRVUFOtVJDoejNdRFAWrK8uL8sY7hVKkfvpiYxbirKJasDGZYdySHbF+pmyutAskXCbHK4cjjsogHerk2851y7FUVBNzCdxW9BHFwelbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2ZgMxu1R9nvS762ksbjq6hKm/ctlkZCylcUszHkjYY=;
 b=grX5SL57SfFeJoWHaQXpY7w1Vpw6eAjES68mEEjGP3f+3JTqGulz9DoxL1N4RGmGm76iZmHBAoGEyUQa0KzAzsbXSc6fLSXo+Wm4gOp7/y6dxH6rmg0cVtRCn/KcXj+mGkt+i07G5zmVjeoeK8zYmP074Mkp0+K0B/n6BmOocQQ=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 2 Sep
 2021 16:27:37 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::31db:f34d:bdc9:8f32]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::31db:f34d:bdc9:8f32%7]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 16:27:37 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-core] irdma: Restore full memory barrier for doorbell
 optimization
Thread-Topic: [PATCH rdma-core] irdma: Restore full memory barrier for
 doorbell optimization
Thread-Index: AQHXihS+EJKXfIrCVkG1+TWSsRynBqtlsKuAgAXsBECAAQ2EgIAFZfmAgAd9soCAAeKYkIAAEtEAgBWV4NA=
Date:   Thu, 2 Sep 2021 16:27:37 +0000
Message-ID: <DM6PR11MB4692BD4BB222DAA58C264000CBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210810115933.GB5158@nvidia.com>
 <20210813222549.739-1-tatyana.e.nikolova@intel.com>
 <20210818164931.GC5673@nvidia.com>
 <DM6PR11MB4692DCA80480234AAD298313CBC09@DM6PR11MB4692.namprd11.prod.outlook.com>
 <20210819224408.GE1721383@nvidia.com>
In-Reply-To: <20210819224408.GE1721383@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca57c937-3aef-420d-68ff-08d96e2e9390
x-ms-traffictypediagnostic: DM6PR11MB4642:
x-microsoft-antispam-prvs: <DM6PR11MB4642BA1DE227C97402B398C5CBCE9@DM6PR11MB4642.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x0DKynGQyb2KboeIJpTQAcE8XKSEqSEdsyiavdQwAPZfvXpsz4yvSsS19xeCj1W/Vu7P/IxP0/z22zp7KQ4ZE+V9haG/SncqVTRtAgGi5X2fMuKyCd3TDnzmMsFcQIiOCF61cOMogdRSYh6VXzEEEz39udpJLNp6DTkOtJvcU4BtipEGYMUpOzCmMvMdJ3O8FMiqLy3VZbK0Gr/mihJInZRX7T9JGGCkAd/1IEIPhmX2R2W60sJ7b24Q7NifNyckvuulQEuAcJrZY8Wn5tFHMR2PkYxkaEpIx3DX5CBD0BTAnE4SsvnlCuhmg2YvWVF2SIeM+JJxENpNTV3fHRPdPtJi8I7wnxmu3F+PUGRRDRf3N7/BLX40fu7ZUUz0jFecEyKrzONYniivVMd6odXa0CsMvfJysiWdnMlnz0iBurUV9qi5XGK6LdThefuDyomzrDy84kWZl/3m4onlCZnrwDvhaokR2uo1GrPufRPvJQYuo5IxyhNrpNJyaX9xnP00gF96FP9QvwtmEcRUn+dUT5mHgRqISlgb6c+ZzUACSZl+oY3sB9221HScO1IjF72Da2vpBF5bq6RiSt5zqBz+KbDbMBnhYI0hM9160InMieVCkq6JeKBlo1zSzemx1RnfIc4xH8c6sr4xGsZIJIdkpYh9sH0QjCMQp0/ywZwMETGvQuvAOliLgh9HSPbay9k7gtKxcHVIFcbKjQpZPyU4uA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(2906002)(71200400001)(186003)(478600001)(6506007)(33656002)(66556008)(52536014)(66476007)(53546011)(38100700002)(38070700005)(7696005)(8936002)(76116006)(316002)(4326008)(6916009)(5660300002)(66946007)(66446008)(54906003)(9686003)(55016002)(83380400001)(64756008)(8676002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qkyHl2m7rcwyM6mzFmy7IxSoDmVISQt3Ii1wf22j7QyI75bqYuqe8A0XbIL1?=
 =?us-ascii?Q?49y3gOZq2kvyN4HzPBG7Dal1Ke0Zm5Ewm2hl0Z/W9LGzM+i/iGuPqfGDJZxO?=
 =?us-ascii?Q?dmU/L1L3kjslLw6y0WO9Gn8p5q/BPVuaP4brzMk649rb8z7N4Hci90PpBD7Z?=
 =?us-ascii?Q?EUWyXToUlB1sQXwNwt3YouHJvgCKR2A1z+ma2M5X9Xk0aMVezkOhJEwn7kGJ?=
 =?us-ascii?Q?INujfRsQXeyVrr+CIdOcIu41ClyqfDFi5+XGxlokUBSR4VR2CRWpW89a6cht?=
 =?us-ascii?Q?gH56BNxwej9KhDlnUawYC0a5+9nhvQF1RrEbKqAvuyB+mXrwIOFWVdSSNJz+?=
 =?us-ascii?Q?Qoavq2JypBk8HfjBJ8tIxeB4VM/d4fxiy5K3xRr5kF9XhPFL4PH812OI6PQC?=
 =?us-ascii?Q?s7LMarJ+ojwc9yiY1RLoJBBQrv9XTOHlYNeTgQrhR98FdB20xn3qlgst6+zH?=
 =?us-ascii?Q?1A4q0R1DvsKMKXyF1SjHtXfXYjm0herClsJMSGCJTWoPU7/6Y6DOdeCpecGi?=
 =?us-ascii?Q?rvIMEMR/QYsn4va1z51L4te2bouKYwVv/W7tLuc2S3cXCpjQ9qmhrPcybj0n?=
 =?us-ascii?Q?y2bdDfsoSAkq1/DHi6nE9xV/5urPfT1i1SHgHlgwUwwA0qrJLkdN7SPJySBA?=
 =?us-ascii?Q?l2lFdrL8sa5Zj34SS9TU9Bd0z02xo41Q1Ys8PzuNDkbMrK+/Q9tNlfHzKVHG?=
 =?us-ascii?Q?S8tyce5R/fEJilOz0pYgS8YU7S69bbF53u5l6mOoMxKAaGEwtHPMex/ZPYqW?=
 =?us-ascii?Q?nEIpN9qsLw4vxdDiir8W2RiKfQoUSygg+NanofpMZtyWfavf7wmL9AF+rG6I?=
 =?us-ascii?Q?sLsh+kjFtUzkVWtCJhntD+SOSQi5WZ3quQeoMj8zUb21dFGcoU3Z9V4Msi02?=
 =?us-ascii?Q?RqLn+gBNfW0wlyGz8EkfZnxlNsnxU23vh84ZPPnLsHd2Wh39SviNtrYX3aJ1?=
 =?us-ascii?Q?BU2gPVifS+zUVsew9HfkFapIevPpU2WwAESKZWYAPlAGViuf3zQCe53LxI9+?=
 =?us-ascii?Q?ONrDS6JTCaVRIHt8OhIZAQoe32aZBAD4rCtDKM4lv0p/3JlFSnKi+1T3p5Ol?=
 =?us-ascii?Q?uheXjZqTUIyBquCjZNZ7ssSOZpeCJeIEuSL9cUFiLv6FiIJrioI4pIK9Hz+B?=
 =?us-ascii?Q?E50DeiCRFovg3efEcq6g1SrvhSi3lptjka6vRrRwgmsOUQe3L61ACj8+lvvT?=
 =?us-ascii?Q?IEOTGMCnO78f0BxXFxIp2JIOgH6ByMPiyzE2oTICX3nU1sya52gVdMdbFejH?=
 =?us-ascii?Q?tvQ5SiCnZ44JuR7n0tCvWNsARH/waWj5v9zcohtD6u2emeJJDBl3nC8cany0?=
 =?us-ascii?Q?R4PODt+PELCI4omAsH0olHoOT4FtuOGAlgXLfOjsvB81/+BW3luPJ5HFNniE?=
 =?us-ascii?Q?VpyCIy5xDXpSInD8Pxi8F76hdGfc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca57c937-3aef-420d-68ff-08d96e2e9390
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 16:27:37.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djhco7IHhGv4HV7umFpkXh/9g7LWjEqtoX5Yp8n4dW4Xzyk9R6MkS041QnpEQvwZRvzEHGJZzedK7guzN5EAtQBDij0V67yOT3zAFiwQJGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, August 19, 2021 5:44 PM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
> doorbell optimization
>=20
> On Thu, Aug 19, 2021 at 10:01:50PM +0000, Nikolova, Tatyana E wrote:
> >
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, August 18, 2021 11:50 AM
> > > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > > Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> > > Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier
> > > for doorbell optimization
> > >
> > > On Fri, Aug 13, 2021 at 05:25:49PM -0500, Tatyana Nikolova wrote:
> > > > >> 1.	Software writing the valid bit in the WQE.
> > > > >> 2.	Software reading shadow memory (hw_tail) value.
> > > >
> > > > > You are missing an ordered atomic on this read it looks like
> > > >
> > > > Hi Jason,
> > > >
> > > > Why do you think we need atomic ops in this case? We aren't trying
> > > > to protect from multiple threads but CPU re-ordering of a write
> > > > and a read.
> > >
> > > Which is what the atomics will do.
> > >
> > > Barriers are only appropriate when you can't add atomic markers to
> > > the actual data that needs ordering.
> >
> > Hi Jason,
> >
> > We aren't sure what you mean by atomic markers. We ran a few
> > experiments with atomics, but none of the barriers we tried
> > smp_mb__{before,after}_atomic(), smp_load_acquire() and
> > smp_store_release() translates to a full memory barrier on X86.
>=20
> Huh? Those are kernel primitives, this is a userspace patch.
>=20
> Userspace follows the C11 atomics memory model.
>=20
> So I'd expect
>=20
>   atomic_store_explicit(tail, memory_order_release)
>   atomic_load_explicit(tail, memory_order_acquire)
>=20
> To be the atomics you need. This will ensure that the read/writes to vali=
d
> before the atomics are sequenced correctly, eg no CPU thread can observe
> an updated tail without also observing the set valid.
>=20

Hi Jason,

We tried these atomic ops as shown bellow, but they don't fix the issue.

atomic_store_explicit(hdr, memory_order_release) atomic_load_explicit(tail,=
 memory_order_acquire)

In assembly they look like this:

//set_64bit_val(wqe, 24, hdr);
atomic_store_explicit((_Atomic(uint64_t) *)(wqe + (24 >> 3)), hdr, memory_o=
rder_release);
                     2130:       49 89 5f 18             mov    %rbx,0x18(%=
r15)
/root/CVL-3.0-V26.4C00390/rdma-core-27.0/build/../providers/irdma/uk.c:747


/root/CVL-3.0-V26.4C00390/rdma-core-27.0/build/../providers/irdma/uk.c:123
        temp =3D atomic_load_explicit((_Atomic(__u64) *)qp->shadow_area, me=
mory_order_acquire);
    1c32:       15 00 00 28 84          adc    $0x84280000,%eax


However, the following works:
 atomic_store_explicit(hdr, memory_order_seq_cst)

//set_64bit_val(wqe, 24, hdr);
 atomic_store_explicit((_Atomic(uint64_t) *)(wqe + (24 >> 3)), hdr,  memory=
_order_seq_cst);
    2130:       49 89 5f 18             mov    %rbx,0x18(%r15)
    2134:       0f ae f0                mfence
/root/CVL-3.0-V26.4C00390/rdma-core-27.0/build/../providers/irdma/uk.c:748
=20

atomic_load_explicit(tail, memory_order_seq_cst) - same assembly as with me=
mory_order_acquire
=20
Thank you,
Tatyana
