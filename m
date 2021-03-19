Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08D53426F7
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 21:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSUec (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 16:34:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:42151 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhCSUeT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 16:34:19 -0400
IronPort-SDR: fIYdKi8FnRrTUJ5AR+pvfU4tSh6UjoeCjaGodsqdIVJAd2cOCt+P/Ndq1xwT9Ts1D2CIyuuJtL
 /uJ9Y//y9Yhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="209998562"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="209998562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 13:34:19 -0700
IronPort-SDR: mIU4FMatOSMlUoi6OffcdXM5A5TYsxKf+Ufioo0qLThneDp8T1yvD74xNMMZWbVkLkjRJkQbCr
 KHB5a40QK/Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="440201727"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2021 13:34:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 13:34:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 13:34:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Mar 2021 13:34:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Mar 2021 13:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMwQma7hy5lzgINX92aUH1+6qRxD5cK9R+iJ15VzwT7PGD6KrcbbXmmWQjZ5hGfabgLHZHQlz7IYxt8JPO20sWx+uEUEDseTs2eBaKkNOLQG6UfJJMN4xvcnEDEJP9jhb9iYUT7jqeJ6r0gnmy9YGYM5M4trqy+NKTHxcDCwCvWomiLIHElfcBzZ1+YtX428heksIOqMLrLGSsXXuNNhbUosiFjW50xHNVR1M+Sox2Tpq5l1DoPm4C9zxNfX4dek+8IEEr1QbKUYt2qwwdNFm4IAWqFsQjePEZGNbpkNmrkMiDr/XYLp+G6XowJVhQLO797kSCy81DUAIQeQu/QeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCyQnudR1/bmYwT96Ct5e8cQjdNQvl1ibZWhN7ID52I=;
 b=e0iqEGxV93aELVNTmCb0W9zEN17S4niEwi/ckcFRahvQehG4CkGmfTi4fgJYqiJUXutCB97S7mtROCE2W05ITUKDfKNWB3DQ376jsOPYpC2bRfJA4S7gznhdWKhVp9oLIEzagWcDYuV8RA/0WDvCYYQPkPy2fbSUM2bs9WqoUA8jl+rdkCUh+QY/BqHCe0gtmx/ci62fb597LhmTUqlolcxvdjfLoSQ6eWjhmXz9MvpSyllW6zoGVSakre0zcvBsu5dzWyeME6iFkIq5ix4NRS8kvCJcHjzhqzq/e6ZSHPvQreJcvq285vXqo0AYAg8udSaQod6XdO1gqsGiI1m69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCyQnudR1/bmYwT96Ct5e8cQjdNQvl1ibZWhN7ID52I=;
 b=vU2j+1kujeEBrG9w4cRnwbjsTFBT8XRY/iEgFanNjKaK7wG3ELwIAYHFwLI2OYLPOqmzduTdNl/a0cPkB62c28qokYEyz3sgw3Z31ArFj0CCrMN4sqGoIViLhEF1o1/BjrPzBaH5GazXPwNZrMnhzBebx1GxHhfAmbXJJdG9srQ=
Received: from DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15)
 by DM5PR11MB0010.namprd11.prod.outlook.com (2603:10b6:4:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 20:34:17 +0000
Received: from DM6PR11MB4609.namprd11.prod.outlook.com
 ([fe80::6005:3163:12e8:d988]) by DM6PR11MB4609.namprd11.prod.outlook.com
 ([fe80::6005:3163:12e8:d988%8]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 20:34:17 +0000
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Wan, Kaike" <kaike.wan@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9qv1xzuyElT0mxzSqxlVtvR6qLVNwAgAAPxoCAABBfgIAASeJA
Date:   Fri, 19 Mar 2021 20:34:17 +0000
Message-ID: <DM6PR11MB460924762347AF1EA22C1E8D9E689@DM6PR11MB4609.namprd11.prod.outlook.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
In-Reply-To: <20210319154805.GV2356281@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.67.182.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 827c5c0b-1e06-4b2d-7cd4-08d8eb165e6d
x-ms-traffictypediagnostic: DM5PR11MB0010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB00103590F87FC8320C0F6DC59E689@DM5PR11MB0010.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rwyK7d3agyx8t06Tk1s5Zlzl17Vd8h410hj7gFq72Gz+d3G/gx51RIfjAfHXatq63yUThzHlZS8RqfBJWY0H9FDepttvdMQsSVQuo9stxZWYYU5/6WEYcTUAehHe7k6Lhm4n3J9sd+L4jwXg9ELDP1alOm3lkf9s39b4yZQq7tIakPbZKoUqUXFmeQUGy/Ur47Fikb+CVODtMICaj6m/QPO6e+zreVdKd48ZYCgbjE6EOzg8jgJaO0nhczkCDmE3Kmm+yVdlh839r6/0tUf2SdmZ+EDUop+w4H+8Kaxw+FvmHmZSKbfTtico8W+RrnYED7vtEiODWiXzbi/Mj6XFtcTRqDixDEizyBbspkGyh9KDd8kQC0Shz3IJDbwhpBEVMqq8h93TBSKGXFt3A6FCicqhk3f8ujrOrP/1ku4VgnSVlbOenopcT1RjFGo3VdaTzb8ML1R/XArxqZMziI5C5vnyQ0VUcUUGJY5Poq+O5VPZKFB4QFm8bNrw7bx9ao1enrE1iukU9LZ9lMiK13gg86iS23MLXPiFbeXhCuHGQVFOS2csxuQ7xODNUiAz6XfQMUGBemi/DquQQUKtwI9g4EwH8Zt+ZgCdBH34wRdQqV3pfqOER1XMnBIJ51on9j3mLR5oqM+xJmNLmotmVF2E+Zmv0Z+2MFRTvJl8W9DyTF4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4609.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(39860400002)(346002)(52536014)(4326008)(66556008)(66446008)(64756008)(66476007)(8936002)(76116006)(66946007)(71200400001)(110136005)(54906003)(107886003)(33656002)(38100700001)(6506007)(186003)(6636002)(316002)(9686003)(478600001)(86362001)(55016002)(8676002)(7696005)(2906002)(5660300002)(26005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?E398qEd0FCsYeoLH/zGGLeykF2vIeZ5k7dqv1nRZUPqP1Q7NQ7puGffd?=
 =?Windows-1252?Q?BzQHdfToE+T0Ge+3ytyZ1caHWrm0APHQZSDuhQyn2HouCO/nRFXZulVX?=
 =?Windows-1252?Q?9Bg2FAC601rCdS2p56bxBW5F8AA+To5wWPLSmg/qu6UjTW+XNR5Eq3i3?=
 =?Windows-1252?Q?Bp+GgiP+GW6vJi3vVO/Tw5Tj6MOHHPcoE9SOqEFRGdcmJeD5L5tqZHVv?=
 =?Windows-1252?Q?Ba+wObpdmW3FCl3RBl2A/ia2Jipl5gxqYlbCkBlxHAZjyfGYLwWSpW6P?=
 =?Windows-1252?Q?lNTckTN036E7TkM7CYFkzFni7ISv+j0tVnedPjYv94Uk1Std1tpXE2ZJ?=
 =?Windows-1252?Q?ldSgcoYQzf0XCJUPDdAq+rCTG2u/kIK5WBFGB529wjYjCGCWMwHdyD0/?=
 =?Windows-1252?Q?O242UldaVfjpWgv37M90Xn4v6FBZk7nCPJUD7LUyva3Nl006pPENowPM?=
 =?Windows-1252?Q?ZJGrSYCsEC0WfZaFEEfZzWZTw2f753BdtA3x0GOpeqsEOkHI2Jp4FwpA?=
 =?Windows-1252?Q?QW+MVWmL7J0ZXHdxfb/aE7z/3nmXqrl1d/OmP+7zulQiW1R12s+fLDr7?=
 =?Windows-1252?Q?9Fu1nZNjjMdIrQ54qicOkfc0obopIvWScDNCImPTN+/QxfrEDOKxmjSO?=
 =?Windows-1252?Q?BURTXIxGg3xk1M/bu2+I5nC6GTGI92CpHVgL5JKUE5XL3FmtVj9c+nYM?=
 =?Windows-1252?Q?eVHX2llVXMlH/mPrAeNX0pjevpGq8mz/SjPmdgov2qWmFqjHM72dCHYO?=
 =?Windows-1252?Q?vg0tIswsXGq/yx5jn9ylK0YnYlkKFEsXqcLWSPYLoZZyn3ClbpSD7vhV?=
 =?Windows-1252?Q?vEWUeuoVXyvgkoPojH9tGPSiHRgMSt6RD+zcBSRb1n0LBp4MAKKiX/fk?=
 =?Windows-1252?Q?w79KDG0fwaRfdkP8S8Up+S6elE0wAF4SBHJbXtjh8AR2UBldBQdZ8yYJ?=
 =?Windows-1252?Q?Wl12DFHCb/+Y+Ze5j/oksKyAbr1KN8Li/6eQIRDRltlccIZFgJ4Fv3bI?=
 =?Windows-1252?Q?B69dmXNvNNA/C4Bky75THc+kBiY3UpeHKXpZtWCd0HGaiIbbZWEszQ0u?=
 =?Windows-1252?Q?opaHjm66KxKq8+Eytb7Nj9WY0unS+BDY1oyuXeuK7r/gy5MkPsz25YgG?=
 =?Windows-1252?Q?k//9PMgwnA2y97aasgeXUfxY6SY8ggA+zLd9FZTBJ3IyB1nO742V6AlI?=
 =?Windows-1252?Q?gd0zlVY9yoNlI34eHwn9ZCtIRKI+TMgA6s1Io+xvt59SSYwKkhsd50h+?=
 =?Windows-1252?Q?RPi/xBnT5lZiFETwTGrQ37yHPuMq245DDOfnLyu3L81N2X+V4ptH9MSZ?=
 =?Windows-1252?Q?SNCpuZ7D0zB9vNd8UnRrK836H2IsHkb3S+EowCJuu/5WsPCIlutvQnWq?=
 =?Windows-1252?Q?XnlIQ9eBXLG/wHm/cs6pchhEG0OsBApqpVlKZHlM2RH19F3yV4lKZACe?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827c5c0b-1e06-4b2d-7cd4-08d8eb165e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 20:34:17.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXoY6yfNMPckZMaqY4kPfYM/lu+ZkmSneOZpIyjx9UCl2+hQ9NMo0ZEM48TuGpU9koljB+4HeCAGYyk0yyxNtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0010
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > > I also don't know why you picked the name rv, this looks like it has =
little to do
> > > with the usual MPI rendezvous protocol. This is all about bulk transf=
ers. It is
> > > actually a lot like RDS. Maybe you should be using RDS?
>=20
> > [Wan, Kaike] While there are similarities in concepts, details are
> > different.
>=20
> You should list these differences.
>=20
> > Quite frankly this could be viewed as an application accelerator
> > much like RDS served that purpose for Oracle, which continues to be
> > its main use case.
>=20
> Obviously, except it seems to be doing the same basic acceleration
> technique as RDS.

A better name for this might be "scalable RDMA service", with RDMA meaning =
the transport operation.  My understanding is this is intended to be usable=
 over any IB/RoCE device.

I'm not familiar enough with the details of RDS or this service to know the=
 differences.

- Sean
