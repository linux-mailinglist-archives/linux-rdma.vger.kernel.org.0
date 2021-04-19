Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8370F3642DB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbhDSNL7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 09:11:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:46021 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239484AbhDSNLF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 09:11:05 -0400
IronPort-SDR: jS1lWEQIISjMtZHGz+4zTDrPh2GDJwLSO6pujBecyvEhG1w+MY7hLlZwDApjmV0UebBpIHqzp1
 gVayOPcbqFkA==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="280646664"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="280646664"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 06:09:16 -0700
IronPort-SDR: NcsqJt+PPSn9q5OgYa+XOXd2FrtFs0ILi7l7NSCcmcPCjyQtegmm19QHIDjOjcd1K0pwusU8+1
 uPmL4nOgB8Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="462734229"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 19 Apr 2021 06:09:16 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 06:09:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 06:09:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 19 Apr 2021 06:09:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 19 Apr 2021 06:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSsD+gNyRjRHL+1cnywhpzotqeT7++WJBOPRhUvd1YEuZvTnIELcisv0ryd4xZdDpJ9Rx/6d7WPpLFLvoH0xG2zH3h0K1EsNfmkjPKnzEpyKM8I/KqkFNhIyQexWFdoi3Lyaij1I2KQ9HNK+YGDWrqi5y30TlYGMfinemvfVTBZoMjOK8hmHkh0nQTMU2FrvyEIFYYkOp4S8bx4UImiDoPxDQHzYvzNLupOpRF1skGyQsq48hT3KV5hZ7clMfuuFCwmgMyg/x7i9xHhDQ12o5OpfJc/l8W7tijkijOin9e0Y1qtz/kPe/eKTYUBBQSxV4kSRGlkHugRZv7sXRSU2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ggdq4cR/nI8S0khAs38PJYZPS/sje0bYsseCJYg2/xU=;
 b=Bz1l3+QpmDyW6qJMwrWz96RpNsqSEqPeEJcJLY95rHAaTj//hZXSqdgNEuEdRFOkrkfb5Y7GzGp53d8KdyAyhhhzONoKHN+XV+IXhVQqvuc+deIRSQxwaAxekM9Ehhxwvt8Nx+G+ZSMBllOsCeXOKxKaFxlX75WvPhNRf5GT6lWPn/TzDpS2lCMmQzkR9cVeyamtR4BhDcbJPdLzJIgZPZRz/1vLOyUo4HgR95BUTP7qVKAdJV9oHnqSB/hbZ1p3n/eiNizFUb94syiDsSiNbzStE7fwQMFuI1eywNRADX6vy8LwU22yjizgmLbM61lZ1o64Xz55u5vo3AYL9UCQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ggdq4cR/nI8S0khAs38PJYZPS/sje0bYsseCJYg2/xU=;
 b=uJBU2HDP6QMe/6b+G0Mk+sg4VmU1n44SnInufk0D6EIULTtIax/zMtmIFApuSlN+OtO5jFDrzhb+DyBPooAfWR4evkJr/XQb+rIqA4C6AG589GEqK1XAPx6PUxmUrtZ6T7vvYSLnIP+DPnBjJh1Kgr/K3YGXvxtid4GWkykdIDs=
Received: from DM6PR11MB3306.namprd11.prod.outlook.com (2603:10b6:5:5c::18) by
 DM6PR11MB3450.namprd11.prod.outlook.com (2603:10b6:5:5e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Mon, 19 Apr 2021 13:09:13 +0000
Received: from DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::c126:daad:3751:d0]) by DM6PR11MB3306.namprd11.prod.outlook.com
 ([fe80::c126:daad:3751:d0%5]) with mapi id 15.20.4020.022; Mon, 19 Apr 2021
 13:09:13 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
Thread-Topic: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
Thread-Index: AQHXJKMqFhnjP44dM0GAMJcJIUmVl6qfXK2AgAs5VwCAAAI7gIAABJYAgBFDTaCAAAXegIAAAgQA
Date:   Mon, 19 Apr 2021 13:09:13 +0000
Message-ID: <DM6PR11MB33060BC01328357BF1D9E562F4499@DM6PR11MB3306.namprd11.prod.outlook.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
 <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
 <YG7ztT81z8BZDkUj@unreal>
 <8d987675-09f3-542c-a921-072f19243e08@cornelisnetworks.com>
 <DM6PR11MB33061E82DC3C60F2779C87DFF4499@DM6PR11MB3306.namprd11.prod.outlook.com>
 <YH13p0zRz+M9Tmzz@unreal>
In-Reply-To: <YH13p0zRz+M9Tmzz@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [96.227.240.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00e7a328-9e02-4338-7299-08d90334545c
x-ms-traffictypediagnostic: DM6PR11MB3450:
x-microsoft-antispam-prvs: <DM6PR11MB3450D25A7F3A89D573B4CD80F4499@DM6PR11MB3450.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cacC2EDsqDDm7YJzSDSufRqR6T81k6cOrHg4YbbiLfGVPUMzyTXP/lH18ClW/XgAIKbwZCFnWzrPP91S4/ZGswOO0mhhOn+4tuC6kT5C3lfbcHoLS3roaAs44wtny9xWjYt43cIvsHOOwcQsVm15MWkJUSoVoVcLJuKKyQvkHq8Sium/X8cPMvSa2HwZsVPayl6Unyu9nwe9Jx4HYA8Iml9x6lkoQsguIheWfQ1Thv+KS1lgkJ1/FTZ5QUN+sioDoC7zg7eGfjW650tsfznfnkC0OPkbEy4FmsRmT36vrRW4PzRvMuu8gPjK/YzN5mdHqyRyy1W4PT431QhLEFOiIIEzA1TCNDNpQT+R39SsA5evbQV/F/FfU9pPvHavzGiSOcTYbjpnP/ANmHUYtVnNgNle675IjhcY2IX3OpcjYgR6yovAoTHxjKRSbdi73Mg2BYaoqDmJgLiryF337QpjuIk5xvBOjt6dpwvb6GMWC5wyoVfeDJbQmGN2m2bomQTzTvunEoAgRXp61PtgI3yUAu4O05p7sbiQqTEf/edRqkrGozGgfY/2XPXf1M3t4/07mgVeByi+axBp9OQUL6xo2QO8GMJ+ZoS4xotIYNd/zlk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(4326008)(6506007)(66476007)(71200400001)(5660300002)(83380400001)(26005)(7696005)(8936002)(53546011)(52536014)(316002)(66446008)(64756008)(76116006)(66556008)(33656002)(54906003)(66946007)(55016002)(6916009)(186003)(8676002)(86362001)(9686003)(38100700002)(2906002)(478600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XLl3gYWAwXFnLKnuzgBNlIDJVWBWdED+ndKZOPSj0iW/QF9UbjwdtKrZz2uZ?=
 =?us-ascii?Q?sBL5LTo813QUra+WOqeij3PUc/MKBynZ88fgGT3mn6uw1rx6d0aKn9b1Cfq2?=
 =?us-ascii?Q?sxW81qWp911GzrnI95OsOWRkiUevSq4Q8LgBS/FkZYM4NWdyg+KqcAIM/oWi?=
 =?us-ascii?Q?XNKUNcHABmD808h94Xj2nSKEQdZfLhPKJE2KeXcaaBgCf7dNQt33t3SOvVyP?=
 =?us-ascii?Q?ZX1wbIpBqJtZQRZvv9KdiCid7lHJ6rRQ1Ott3kFbU+/90OP1c+FyPrtFZvLX?=
 =?us-ascii?Q?+AGbaW/4VWU4NWmTNj8L3Q30ranQnYAPB3nLQJjUqfbE5LfAKEa5a7+vJ9kc?=
 =?us-ascii?Q?HR6gWtIAyB6JSUrxs2vVZZlXDZAcll0GdR7BymeNzvzM3Bjay5xtYA1bIDpW?=
 =?us-ascii?Q?b/mHRkNmsTpV1gAs0/WvFAXL4Uwk7X844fjXgvnN14nn46ItJUqAxFWsjTnl?=
 =?us-ascii?Q?pJK4dFPKiLJc0XFs/vnJXnkLefBa2Ptp54VRO8cG88gAuhb3ScLQkX7V2lCY?=
 =?us-ascii?Q?UimCHETw54zjo9Lvyt/o398eisT9c8kUUDxFHW8EADUfNmjuGLPE92UV4ZOB?=
 =?us-ascii?Q?Pt+pYQ6Cq0B/Bs1ubF/T9WA5jnFjrEj344+C8kvkDC7WL4cxUGXI3ZBlab2z?=
 =?us-ascii?Q?LBXnRXHUM4dRi2Ss580pkwFr8C8pYOPfeczrJ6R6OJJVBwhyMikHUyjvEqpX?=
 =?us-ascii?Q?7XYouoq97oZrFIQae1HKYzC0dPIwshZua4/EJ0r52vmB2nXJyFXs5KP4GJ6H?=
 =?us-ascii?Q?0qqMDEduTkcldA4+atgNLCV6kSMlXazUgvxVOzMv499aYfERjkE4SKAtjlkt?=
 =?us-ascii?Q?FbxNaC/yBdV03jy2fl6Ql8Gvh6KfZneGO55fjC9aCc8CM68KQ8U706FucGe3?=
 =?us-ascii?Q?XOpvfsyxP0o8iau7jve4R7l7C79atVoLlhBfHPGNJ7xO+zOFJ6qn2kgEvEym?=
 =?us-ascii?Q?3DmsIWR5hrSk5nHVpoz5YxJTfyIdE0AZIxVK76oab3WeUlBTNKvUMHFilRFP?=
 =?us-ascii?Q?JilL8oWK65FXkwycXBo6wA4H82Ca7EyXZBFHUNdZbI9A3Epoc8JvXTGoxrJt?=
 =?us-ascii?Q?vJ3yV6VM6LP7OIR/KrH96EDlYbDmzqjVEsB1zbIomfmlXbnW0/hGpwIcWbZr?=
 =?us-ascii?Q?wvP9UKNeLAO5CoogAvmjk7JDkhg5x6rEqjvaJXFwvQ3qvkGdxKyqgVX7L0eV?=
 =?us-ascii?Q?4TQs7AVC4gGeAtjYqf4ZWQ8O078nDgKGIPpgjKcmkXAAvMLtVNL4RLWWhpC8?=
 =?us-ascii?Q?gnfIOkXXdcFIGu1V0JRoW67emnQL4PK9yRAo3SoZlWqJbzkpRRVFuHYoUNcN?=
 =?us-ascii?Q?pM4TZyPstyqUyYbysiKvqHD8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e7a328-9e02-4338-7299-08d90334545c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 13:09:13.7423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdOm7HO2Ojkd85qY7sCP/SQGb+tDH/2TNdhOPW709Mwg4OZ0Hs1eR38sOG7lHdcgNv3fIhShr+A+ArXW3A4SMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3450
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Monday, April 19, 2021 8:29 AM
> To: Wan, Kaike <kaike.wan@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>;
> dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org
> Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
> function
>=20
> On Mon, Apr 19, 2021 at 12:20:33PM +0000, Wan, Kaike wrote:
> >
> >
> > > -----Original Message-----
> > > From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> > > Sent: Thursday, April 08, 2021 8:31 AM
> > > To: Leon Romanovsky <leon@kernel.org>
> > > Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org;
> > > Wan, Kaike <kaike.wan@intel.com>
> > > Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for
> > > query_port function
> > >
> > > On 4/8/2021 8:14 AM, Leon Romanovsky wrote:
> > > > On Thu, Apr 08, 2021 at 08:06:46AM -0400, Dennis Dalessandro wrote:
> > > >> On 4/1/2021 4:42 AM, Leon Romanovsky wrote:
> > > >>> On Mon, Mar 29, 2021 at 09:54:12AM -0400,
> > > dennis.dalessandro@cornelisnetworks.com wrote:
> > > >>>> From: Kaike Wan <kaike.wan@intel.com>
> > > >>>>
> > > >>>> This is a follow on patch to add a phys_mtu field to the
> > > >>>> ib_port_attr structure to indicate the maximum physical MTU the
> > > >>>> underlying device supports.
> > > >>>>
> > > >>>> Extends the following:
> > > >>>> commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode
> > > >>>> MTU's upper limit")
> > > >>>>
> > > >>>> Reviewed-by: Mike Marciniszyn
> > > >>>> <mike.marciniszyn@cornelisnetworks.com>
> > > >>>> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> > > >>>> Signed-off-by: Dennis Dalessandro
> > > >>>> <dennis.dalessandro@cornelisnetworks.com>
> > > >>>> ---
> > > >>>>    drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
> > > >>>>    drivers/infiniband/hw/cxgb4/provider.c          |  1 +
> > > >>>>    drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
> > > >>>>    drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
> > > >>>>    drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
> > > >>>>    drivers/infiniband/hw/mlx4/main.c               |  1 +
> > > >>>>    drivers/infiniband/hw/mlx5/mad.c                |  1 +
> > > >>>>    drivers/infiniband/hw/mlx5/main.c               |  2 ++
> > > >>>>    drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
> > > >>>>    drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
> > > >>>>    drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
> > > >>>>    drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
> > > >>>>    drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
> > > >>>>    drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
> > > >>>>    drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
> > > >>>>    include/rdma/ib_verbs.h                         | 17 --------=
---------
> > > >>>>    16 files changed, 16 insertions(+), 18 deletions(-)
> > > >>>
> > > >>> But why? What will it give us that almost all drivers have same
> > > >>> props->phys_mtu =3D ib_mtu_enum_to_int(props->max_mtu); line?
> > > >>>
> > > >>
> > > >> Almost is not all. Alternative idea to convey this? Seemed like a
> > > >> sensible thing to at least have support for but open to other
> approaches.
> > > >
> > > > What about leave it as is?
> > > >
> > > > I'm struggling to get the rationale behind this patch., the code
> > > > already works and set the phys_mtu correctly, isn't it?
> > >
> > > I see what you are saying now. Kaike, correct me if I'm wrong, but
> > > the intent of this patch is just to make everything behave the same
> > > in the sense that a device could have a different physical MTU. The
> > > field got added to the ib_port_attr previously so this is giving it a=
n initial
> value vs leaving it unset.
> > [Wan, Kaike]  Correct.
>=20
> No one is using this "phys_mtu" field, except one place in ipoib.
[Wan, Kaike]  Since phys_mtu was introduced into ib_port_attr and every que=
ry_port call will  return it in ib_port_attr. Rather than leaving it set to=
 0, setting it correctly in each hw driver seem more reasonable to me.=20

>=20
> Thanks
>=20
> >
> > >
> > > -Denny
> >
