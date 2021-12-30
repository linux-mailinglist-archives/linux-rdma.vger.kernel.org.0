Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0A481FCE
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 20:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhL3TV0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 14:21:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:34238 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232719AbhL3TV0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Dec 2021 14:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640892086; x=1672428086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=4LCnN3/m6zwqs4zZ7dHfyHiTT4P1w08T5TLlQgr671o=;
  b=avjZk3nb17yk+dYtnYskTPl9DZaAiERJ5RTB5OKoZFlsPZ7m8ye43XyQ
   yf6Wrzf20vIzawkn4kjQA/8AI/j8am/kr2qKZCqMCipceVTmNA+8RUmgP
   3gLZDVoT3WcLfO+Q9QlLWMtraNk0+VBe1VKcmXPp4PGBkthdKGXiIXZwu
   o6PiY39o9Jurvd2mrqZooEMCLFHR9RPUk0BZySdl5a0788Q12/W5ITQ6Y
   RZ/r1lPnwtQgaNsKPPm2t4RV28YYzf6LRtV2YdRymavMuVJxXFzCruKlV
   bMvSnh3ByNKPLcyQaKlX7THpZMUL6EmLOC7kpm4CmAc1dUMbjF+z+ygv4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241931110"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="241931110"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 11:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="510981961"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 30 Dec 2021 11:21:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 11:21:25 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 11:21:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 30 Dec 2021 11:21:24 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 30 Dec 2021 11:21:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhSEem+od8Olr+Pm5ci34LASwmqreGytLG7LhZ6tPZyS8rN0uq/r47J1GNUCbOXzkgF0tecXaJShXBndC1ttk6c8o7vuSIRIgux4MtPpGFtyuckOTqp2JNyT/rDKzIV/yrhAeM7yltLcoP4VH3kJlJTX/dSH72ThBYXIbUfXPBMHkTKZ7I1hOHi2XrjQGivCoE0bXLtANSV0TQKGhJPc6+8HCWLNuaXHHqj+y0w+dhz4pJtPqMmt5IEp8Oyli3q1/hHht7TThX/6rWZhqsbuHEW/n1sgCYhv/J+3Y2xHDkDAinzv00eJYv1l933CjmYt79Kri2nvC877RbPBZc43AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLMvzJyPYwpnLW/1aRLAqRlqnyAFpy7fa+mR6Ny5HV4=;
 b=MdNl7UWxscg59mCgzn3Zcewt1gKficrOvo2v0H2Lxqa29QdAV11ilccgJb87dnZoIHDMCdMmFjI1O0inAkMM6Y4lFkjHPdRLw0Xn9QAdwd7qtAOZ7P0H9dGK2Fm4t7sMPxads7U8oYnmNQlH9p8E097Wb1Odg5KyFUNnA1wGmLVRgRVl9kWnviG/fPnAInn2VPDXP+DEn4J5S+FL2ZBFAi1wIldeZfs+bXfc0NUaLIX4jlPENv3v1BsFnOlVNu2mF7KaURSKLVcDh4dTfjl7KOH5MYMb7WyYjDmqYs6oAwaezTszsvgoVjADTC9nTF84FRtH/kSqSmndwb1ysepRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR11MB0017.namprd11.prod.outlook.com (2603:10b6:405:6c::34)
 by BN6PR1101MB2130.namprd11.prod.outlook.com (2603:10b6:405:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 30 Dec
 2021 19:21:23 +0000
Received: from BN6PR11MB0017.namprd11.prod.outlook.com
 ([fe80::bd34:c6b1:1220:baf8]) by BN6PR11MB0017.namprd11.prod.outlook.com
 ([fe80::bd34:c6b1:1220:baf8%7]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 19:21:23 +0000
From:   "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: RE: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbzX1EESQbPR0e1EYeMIahx7KxLZgLA
Date:   Thu, 30 Dec 2021 19:21:23 +0000
Message-ID: <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
In-Reply-To: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc60ffc2-d271-40b8-7cde-08d9cbc99108
x-ms-traffictypediagnostic: BN6PR1101MB2130:EE_
x-microsoft-antispam-prvs: <BN6PR1101MB21304C17EC916D8D854D45DE95459@BN6PR1101MB2130.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ur7cjnrhwlJ0LwEXIGNdtCZqxS9sR3UCkY8j+OfsShjMeSCUtxfGp+arTeD81+liZAkbGkjBEXkmREs5fdGYcnR55Z36upr6523gnXRzRd0yT9EYmOjTaWFbRC77NGEGps40BuiHJIlX1uadfr9KfiHymoMVE2ZQosuDwIhWeVNejG//vmL7p+dI65aGfj+bgRj8XV/GS7eM2FG0BXgIYfG4R1mqM3rKA7DqxBysrryDor3dL40FywEM8fpi6wZ8b7g3/ZPnD2PfTp9nVNp1Gl97iMes9oGK7oh/nC/l8UCsbMWpwLwL5pjZH9bKzeBDhxZJ6cBZvaLydvJqWeVrfJ8HiffZrZIwmOx4YcAN/Cyap7k8F9ibC/6HxKk04fCWev7+bAmVH691anLQT8Faf5Ld7KATtXXRQl6Dg2U+4c/iZP1wnJrHjaLyKmx9oIbV3a3OHHaQWETXjRVHvjzNwRpPVBW4mjNGVaMoPag5f3/coGxkC+Rb8OAQb3PudiJAMTq3NWSJ8quGJNDoFH13LDC0/h2oJzwjuCsm4f0+VNCKxniB4F8YtcSyCeeKGbTU4L/4ijFjZu4zVSu8lCSAR5C0dqPk1/3/Zl9jgG6CrjeZJH+8BQcdp1GAL64LATVRvLmviAyA3LSNRN7DQ6DCLIG2dZ8qbQFHIreqFwr9PcbPbN/UtueyMaXnE9MxlQmRI8kdmGS95jEfn/E6K75zqfoYSyJfpG/NG4RJAD3vwaBLiZPDYMbrONccKxcZWuQv0gfEQMh7Ij1QkCb0vKSSmP7d2FS+KRph2iJbLaf+Yl5jTtDEauJG0hBhUkH2jyhDz4DMrxwhE6XXsmGk8RFtDmoDgVFzt2KwxIOxZ1xH+TWKdMF7APX8yEqr8nlEk8G2AVqQQTCcLdDSuIrh1AqGNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB0017.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(5660300002)(55016003)(6506007)(86362001)(52536014)(4326008)(508600001)(316002)(64756008)(33656002)(66476007)(8676002)(38070700005)(76116006)(71200400001)(38100700002)(110136005)(8936002)(26005)(186003)(82960400001)(122000001)(54906003)(7696005)(83380400001)(2906002)(66946007)(66446008)(66556008)(966005)(9686003)(15398625002)(43620500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0/rtrGm/Eo8kekuA8WU87Tt/R8fyvAeuaC7Ww6PRW2KTgYWYgl8a+sCd3amo?=
 =?us-ascii?Q?bun7JU5b3G40TxkwmS5sgVCvmuYkpEJ/kxMtg7joRlD8Z6aXdJLj5R/RqeCw?=
 =?us-ascii?Q?A43/eJX4shu0YkwEXU64C/LtrQdHDu86HLhJrT/5lp8w1LC+Nt9tho+IVxI0?=
 =?us-ascii?Q?ZbaGS9jF9GKddeCatS53Bzi2IlD1DDBwuTn3h/Wh5l/qUxvXvV4PXzH0nkkl?=
 =?us-ascii?Q?Bm9KsHmpEUVp+djCNuuEvoiUxHUeBwqqbGlB0vk7xDz8A5iHkwfrZD8xNs7J?=
 =?us-ascii?Q?UrvMo3S0QuwEhJQpjogteFLeP8qceD3DqkLKf+25M1iZ+p7RU6Vz2Ie4D49k?=
 =?us-ascii?Q?oXxSa6z/B3w+PD8SsrG6Tfq1RGH3KvwW/pG44vN8gWaSNtc+5T9g/xCYbVZe?=
 =?us-ascii?Q?YzGxBE9TBxSRbALZunaGLFT3SLoUwDr7woMebVHVJTdHu8J4+TVXv7N0cNXS?=
 =?us-ascii?Q?AauYA0WEZ3h0IfeBv4lV3GMinxiYl7xdhTIX2LvRZADGh1a6LBa2J6ttgmt6?=
 =?us-ascii?Q?ryVgQUHGlZQZax2sWzVUHM7Ja987dL/yTDK3wHgU3urwWVhFTR2VNp6tGdDe?=
 =?us-ascii?Q?Q3zOvz1ITMZ4xpJvaZPmWL1MbriItvSPCh+B2S+65s6MrZFGyZPs7KRHHurU?=
 =?us-ascii?Q?BxjkN4ZeweozNvntlbD0iWCD+cLlQqPJQn+kT054kulGhQQQTGnICCfM6Sdd?=
 =?us-ascii?Q?mBO6ptwTPv5SQz6hgLwbVisTGLCivnLmKtUKbXn7APkMcT9/XT3WyUKOvBMM?=
 =?us-ascii?Q?LaPj5XeKenHeqPue52juuIHjb8tafDKDADTwGSZ+x22AisyRkfie3YXnA6e5?=
 =?us-ascii?Q?sHcW/Yk8kDHYoTWAvAIOygmoB+iIRCmZ8nVN/j/pIOoQDiMHIRPKXdRXSMVM?=
 =?us-ascii?Q?loOJVU2mcJcw1XUD9BugNfLZ7kuRFM6EEsB/NhzNOsTCp5QGX9bDX/quWz5M?=
 =?us-ascii?Q?3O5dop3RWe0F3jnD5Bxro/T9yYEsT5Qt0R8mHFPD+AJHSScSQYqC0OeZ8I2X?=
 =?us-ascii?Q?nCgnfY+uUIrv96+IMCt//DNeusREnAqspyyP9pwcnZIStu5f3k6SIA8XZZBz?=
 =?us-ascii?Q?mrTTZX2B0VwRhtPwUSkXxL5k0zOJ4cgyhk7U5ay6wa+ws8bS48RDQ9E2Q425?=
 =?us-ascii?Q?1Z3GzLiKxfeOOOXBjb5CQQ0VQoF42scx+VtQMPo4Py2aLvkCQYrPS4At5Hua?=
 =?us-ascii?Q?yPA8stE/d9DdhcclTdHzvw3a1AXdP7IWCgID8MKgAp1Z5Rj3DVXWOKel0+2/?=
 =?us-ascii?Q?0jG7zl0kHlE8dR7RjGb0k/KGSsmbyGtTY76BLkUoHyewjb2SperxiSOllk5j?=
 =?us-ascii?Q?SiFFcevZeI3FLAgV6QtUYF3hejeLuB89MT98ex2VY4UjXu46a/EyNjCZ0T2l?=
 =?us-ascii?Q?WoDYawNkfbJQJSfp0AC1m23bjfCjAjGYkyCHWxjEuK4DJ99W9pO5059wxs6k?=
 =?us-ascii?Q?2Oy+Xz0Q+wubyD1W1anOLJxlAiEwGggGGw3Zo7wRgArZG3ep4Lxh33MqxEdH?=
 =?us-ascii?Q?ebiN1tFeeM1RhR9Oj9JodazCInilMT3oPWgIg52a866fMYSoqWvTV22XUfV0?=
 =?us-ascii?Q?RhsFoVFHYuCDenihr7IaLmd+Pa7ScAeZRkjbwPN1CxNcFK1wKBvINZYKj5jn?=
 =?us-ascii?Q?mu5eLUXScHnE/xsOwr9q9bjxmdPmTOkV8+isCNUG2xO4eKgV9kmYTCixy3/X?=
 =?us-ascii?Q?XQMvYQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB0017.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc60ffc2-d271-40b8-7cde-08d9cbc99108
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 19:21:23.0816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKrCR2iQCXuzCHp0ead8ppLzdpNZ9FjH7SSuBCxfyb5lzNSaR7bmwavaWBKVKzfemGU/rCISSb0fCnI8euoU4Ru7m+om3GoES3P+S7ksCIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2130
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1)
> rdma_post_atomic_writev(struct rdma_cm_id *id, void *context, struct ibv_=
sge *sgl,
>			int nsge, int flags, uint64_t remote_addr, uint32_t rkey)

Do we need this API at all?
Other atomic operations (compare_swap/add) do not use struct ibv_sge at all=
 but have a dedicated place in =

struct ib_send_wr {
...
		struct {
			uint64_t	remote_addr;
			uint64_t	compare_add;
			uint64_t	swap;
			uint32_t	rkey;
		} atomic;
...
}

Would it be better to reuse (extend) any existing field?
i.e.
		struct {
			uint64_t	remote_addr;
			uint64_t	compare_add;
			uint64_t	swap_write;
			uint32_t	rkey;
		} atomic;

Thanks
Tomasz

> -----Original Message-----
> From: Xiao Yang <yangx.jy@fujitsu.com>
> Sent: Thursday, December 30, 2021 1:14 PM
> To: linux-rdma@vger.kernel.org
> Cc: yanjun.zhu@linux.dev; rpearsonhpe@gmail.com; jgg@nvidia.com; y-
> goto@fujitsu.com; lizhijian@fujitsu.com; Gromadzki, Tomasz
> <tomasz.gromadzki@intel.com>; Xiao Yang <yangx.jy@fujitsu.com>
> Subject: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
> =

> The IB SPEC v1.5[1][2] added new RDMA operations (Atomic Write and
> Flush).
> This patchset makes SoftRoCE support new RDMA Atomic Write on RC
> service.
> =

> I added RDMA Atomic Write API and a rdma_atomic_write example on my
> rdma-core repository[3].  You can verify the patchset by building and run=
ning
> the rdma_atomic_write example.
> server:
> $ ./rdma_atomic_write_server -s [server_address] -p [port_number]
> client:
> $ ./rdma_atomic_write_client -s [server_address] -p [port_number]
> =

> [1]: https://www.infinibandta.org/ibta-specification/ # login required
> [2]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-
> Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
> [3]: https://github.com/yangx-jy/rdma-core
> =

> BTW: This patchset also needs the following fix.
> https://www.spinics.net/lists/linux-rdma/msg107838.html
> =

> Xiao Yang (2):
>   RDMA/rxe: Rename send_atomic_ack() and atomic member of struct
>     resp_res
>   RDMA/rxe: Add RDMA Atomic Write operation
> =

>  drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
>  drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++++
> drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
>  drivers/infiniband/sw/rxe/rxe_qp.c     |  5 ++-
>  drivers/infiniband/sw/rxe/rxe_req.c    | 10 +++--
>  drivers/infiniband/sw/rxe/rxe_resp.c   | 59 ++++++++++++++++++++------
>  drivers/infiniband/sw/rxe/rxe_verbs.h  |  2 +-
>  include/rdma/ib_pack.h                 |  2 +
>  include/rdma/ib_verbs.h                |  2 +
>  include/uapi/rdma/ib_user_verbs.h      |  2 +
>  10 files changed, 88 insertions(+), 19 deletions(-)
> =

> --
> 2.23.0
> =

> =


---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydz=
ial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-31=
6 | Kapital zakladowy 200.000 PLN.
Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata=
 i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wi=
adomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiek=
olwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the s=
ole use of the intended recipient(s). If you are not the intended recipient=
, please contact the sender and delete all copies; any review or distributi=
on by others is strictly prohibited.

