Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BDF70FECD
	for <lists+linux-rdma@lfdr.de>; Wed, 24 May 2023 21:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEXTzi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 May 2023 15:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEXTzh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 May 2023 15:55:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACE9BB;
        Wed, 24 May 2023 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684958132; x=1716494132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wY9+P+AjpRE+OTWAOU3Y3TTabUGILZsyZPyLBFvrjXg=;
  b=Hq2AudApnaOJxuqnHOCZnRelGdktwgqKPx4hRFi/7KxQZlLR+WqiRVaV
   Q5fX+jy8uGDvjww2VfPGZYGAkTzVpJckGC+TNpWbl6juepR3SETpGNcSU
   5iCL004bvPIx5fjoAxHpUggGlhA8lVfjdI7lCEOhcN6Tys+cND7nyBc+l
   M9M1t78ZE7pnjR1uLUhXmi9ZuPV9tiYEtCXAarlLHfLZS6I/DYSueQVuD
   khOmRUkBrWwfq+wdNWG/8EsxKVFtBcgZGVzAklK2KcKNyDfcWBDPSEB3W
   phrIZAo/uT4sTq2Jfz1eekhcospHd2ZfQOV0DcLewgkpJFWj8+gT19Oaj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338251697"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338251697"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 12:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="704489827"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="704489827"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 12:55:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 12:55:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 12:55:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 12:55:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 12:55:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+SFb4oVXawJuDwNHqw5k44tCTMhkfGRJZO8FhhPyPK3DZwlWGClsRMoNh1cf6lkDd7YI0TUD0OHDT61+vl5lf45+3ddiQmLi/8UUu2P57h4wct0lmknHOxprPbDz1JoY/e1NwR/EMfs7CKkfoFfFKshM4RvZakPQc/E/eLhf6gP5Jjg1EpmuHyUx2ZW6f2XRLImv7zQi6i+kJOZwIJP0y2wqX8o3GBlkvvZx89/T6cYZ0H2PAnjlN/P1mFXBtBdMfiUD8WHegJqysGHlGbAvp/YqE0XBmUO37p3In4WM1tZOOhJ2ogYu4G9O+mR/YwWlJAjQSGGmIRNiVo7FvpDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DdK54ruq7SXNg9svQQWMnoyfixkBPbmIOo9u4mlFwA=;
 b=BUUEQkSuT42OUn/N3fVYMFOpaDw5skc68/n6bi95sXXCSzsSWwFexbqOTIaew/OPQPJlxQk9+v4Oj0yK1L7BE6HidDLDxWT10LgfHPIxY12UAwGyB2JLPWALMw0CYEADNrSS57q5cAL1LTDUsVEn1cAZEcTVMD5S+qHlIhxiRKVY83CoAQ+oxyMerY7zoz6qi6xnPWX/tGjUGnvb7XNvpm0xbIKNZmB04DjyTRaVnXLdcdwYEg6RlfWu2F1ZKsg67gRPwM7rwihkbO7cS/vKrP/23l/gQAvHmpStwQLP+LVymR6zg6DxjmfY3MHXFjmy12jba69LldJVM7qb0yPAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 19:55:15 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::38a7:8228:6323:3db6]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::38a7:8228:6323:3db6%4]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 19:55:15 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "Devale, Sindhu" <sindhu.devale@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: avoid fortify-string warning in
 irdma_clr_wqes
Thread-Topic: [PATCH] RDMA/irdma: avoid fortify-string warning in
 irdma_clr_wqes
Thread-Index: AQHZjWho5Oj7NPLsJkKF1Bo/FzhlHa9p2E8Q
Date:   Wed, 24 May 2023 19:55:15 +0000
Message-ID: <MWHPR11MB002962E159ADAB9F2195FB23E9419@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230523111859.2197825-1-arnd@kernel.org>
In-Reply-To: <20230523111859.2197825-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|SA1PR11MB5803:EE_
x-ms-office365-filtering-correlation-id: 924134a3-ae5b-46eb-5aec-08db5c90cb26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YcuUNq9bv+/+KM4UyyN/+sEOXDYwc36GERD0QqVYuo/g/GaPSp6jZrFNUdSXTnHVyl4TgbTDLCqJGjlsAfSXxJArRc+YEHfpaj0t7ZIxYB9nytydH9htiHjnDSEiJX4grm4dFUabl/qG1l9Jw1Mt/5Pdcio7qtq7pE7diZp/HJJl41z6aO5xLK+1zJzXZMlsqmlYL2ildt58dA+ZK63KSqrG4ApeV6WI061kx00m/eAxEIHD1Lib6VYbvQKQljm+3/OBgSsFx6KViiD+f4lnWY5YZNJS8bmSytc0RTFHpWyKR+Vyx7U5fhYe+RGHEF2htfUaweh3N0nIz9PPEAVi9T7pnz95xuBk3Kvcv6AdBpapaIxcV6rWYIpte5tL1Xi5vaw6gfkHee6rIsZnBAWtfLDH4A0lq+/blZtkWfCP+PmwsjO4UQ/KCwd9MfsgY/kQeLFqGeRjOn36nE+1IvGDjLoB/nNOJbj+PPcXpXC9LpJfwq9PZIXTBd7IgTckLnZ8nKzPaihOZMzGxjTlvF7W0iyX1yv3bTqYR+hEDaJ51nmgc5HaypNXJtry0n9fEUxdK/YFGn+X1VkmpQllEuNhBzK0J1g2RzWpLrQLD+P9mbOKyaWtAOK583RS7Drb7+0l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(110136005)(2906002)(54906003)(5660300002)(52536014)(8936002)(76116006)(55016003)(41300700001)(7696005)(316002)(66556008)(64756008)(66476007)(66946007)(66446008)(4326008)(478600001)(71200400001)(33656002)(26005)(9686003)(6506007)(38100700002)(122000001)(86362001)(83380400001)(186003)(38070700005)(8676002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MGZFSQ5HrpYQrGXCnG1FM9zeCgb2QEkdDzUFIpUCb0/i1/B6m3r1zVDF6n6I?=
 =?us-ascii?Q?H0jLk0Fg4h2fCbOI4Y0jP8rtiUNx5Sg/3ttd/FmyyD4Mo32H0aN/ujkbagBC?=
 =?us-ascii?Q?N90k4fs0eU5gMxNtEKRREXmjH4ezo8GOj7apxtYvv9dZ8lfQCmLtx42QNJ9F?=
 =?us-ascii?Q?ToJyaAzKSr83LRcmQtGQsEXy8vk13YSVF3kRW5mYnlaAwaLbGqm4mobpIjqp?=
 =?us-ascii?Q?nB700eMTajwimULffxhotUlnT4xxdCqaEH8t+dt1XpGOv1m6f9LbM2ksLk8U?=
 =?us-ascii?Q?9rd8lyCmL4Zyj74Z7Ahz9GAjGcQ/SoEBZHrje8HgRvQZUWpeINwx4x1HcP78?=
 =?us-ascii?Q?4RxHGzzSQZXSdNDugtXE3W/rOyWStu2XrW3DsTH+HMOUU/n9FA+9CTlAo3Fn?=
 =?us-ascii?Q?Oy7/FyuPG+2y6Vliz3glARhxF2mPL9+0D2UsotOxWRQbwsKA/i6GXsvaEDjE?=
 =?us-ascii?Q?7vdJH1dBgUkAtsIrbWWurXaVOaJ1l7keTk02flo2Lw7F7nITT1Rogd2zEpfK?=
 =?us-ascii?Q?qZF+jpDct9g+76FrUfIEUU9ekzV0bsWoPR2CnCRjS7zzZ4nezuS7UmOwCxB9?=
 =?us-ascii?Q?896E9nHovd8ke9A7HlcMBQn2NQNwC81k7FDYSLLlfIlBXfIdypeAFYNPQGjc?=
 =?us-ascii?Q?X805c50hv7ECXN/1AkNFgjHq5BeyBLsRRxWm8BCkf49TXF4EBmr/tqBa5T44?=
 =?us-ascii?Q?7kchyRxu+RZsxhd4yCiEKz2aIOH0rjYmVpRwrlTcRO9vkXA3eXBBe40Hs7YU?=
 =?us-ascii?Q?LaIwU4vbHTMwJzLepQYmt/bPbaFNxw9w0IwZwBgc8JxHmGIWgM21qiI04Iei?=
 =?us-ascii?Q?xpqUXvm87j6XfZWvn0IMRYvLcBrW8fAy/VWWlUafBwpiR+MrRjaLm+5XfTjC?=
 =?us-ascii?Q?A1WlK0V21mIwsIgvExyECi1/nn26MWcPXINgs9HTuHroAgLXS+u5PWW5YRt2?=
 =?us-ascii?Q?E5Wn0k1piUZ2s3WWhWZuXNVvnfdLuztlwmgJRrhITyWu/sKOW8gmuh9k74GR?=
 =?us-ascii?Q?2EwQYXDJStG2s3u74Oo8q5Lrcys3EmQOIyc33fsaX/Lj2r0yGqDXVAwIclRJ?=
 =?us-ascii?Q?HcFOyWjUWxpkMKv5mrxgDtg7JaRL7fVfZWvaj99n0BlKrf0/hbBovC3eu/gD?=
 =?us-ascii?Q?A2l9wnNTOP+auHcOfCo+c3xMhs8G9lKXR6fxIK8FPUadXaKvGP8KDMNRfXZy?=
 =?us-ascii?Q?TbkDVydKuTv6pap76G5jAqXMY4sYBpWYh/38C8DxA6ffYmHZCvLcMFpk3r8L?=
 =?us-ascii?Q?6ZniA2qgxa4Fj6jpKOXjwjHKax8IAmBlP4s8/cmQZ5TQah0Vm2eUuqJxm5uE?=
 =?us-ascii?Q?CJWRH8SyCXBsTMRZqbXiwmzymqwQ8w/C0rkO22AbBa30l7BZpwxUVPCKGGZs?=
 =?us-ascii?Q?eBZlE1RRp0RyUv1hbupHdDhYJEc9zGZk5PpPBVwlrONnaw+1pJhMrcxyVEyr?=
 =?us-ascii?Q?vJ7B12az4rPF1/8X4RN4pFjMY3PiSREEMmlqzIU0voUNH8dsLTUymtQp6FlB?=
 =?us-ascii?Q?XGR1mzepFOW4o5y1m3kXFEzYZgwKtZ11I9tLSU7oBlZaBEvtxJApWctnjwDR?=
 =?us-ascii?Q?832oxslQgLm27/OLYB6ShTBufOfowAV6Pcm8yzcE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924134a3-ae5b-46eb-5aec-08db5c90cb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 19:55:15.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqLxh06IlNA2Lp5eKnwlYqCYv08B0XK9MtpsPyUh7IWrcCvWrnEFQJ2cOL2V81w7gj9FbePwPxANNyelO5vuiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/irdma: avoid fortify-string warning in irdma_clr_wq=
es
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3D3") triggers =
a warning for
> fortified memset():
>=20
> In function 'fortify_memset_chk',
>     inlined from 'irdma_clr_wqes' at drivers/infiniband/hw/irdma/uk.c:103=
:4:
> include/linux/fortify-string.h:493:25: error: call to '__write_overflow_f=
ield' declared
> with attribute warning: detected write beyond size of field (1st paramete=
r); maybe
> use struct_group()? [-Werror=3Dattribute-warning]
>   493 |                         __write_overflow_field(p_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>=20
> The problem here isthat the inner array only has four 8-byte elements, so=
 clearing
> 4096 bytes overflows that. As this structure is part of an outer array, c=
hange the
> code to pass a pointer to the irdma_qp_quanta instead, and change the siz=
e
> argument for readability, matching the comment above it.
>=20
> Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/irdma/uk.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/ird=
ma/uk.c
> index 16183e894da7..dd428d915c17 100644
> --- a/drivers/infiniband/hw/irdma/uk.c
> +++ b/drivers/infiniband/hw/irdma/uk.c
> @@ -93,16 +93,18 @@ static int irdma_nop_1(struct irdma_qp_uk *qp)
>   */
>  void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx)  {
> -	__le64 *wqe;
> +	struct irdma_qp_quanta *sq;
>  	u32 wqe_idx;
>=20
>  	if (!(qp_wqe_idx & 0x7F)) {
>  		wqe_idx =3D (qp_wqe_idx + 128) % qp->sq_ring.size;
> -		wqe =3D qp->sq_base[wqe_idx].elem;
> +		sq =3D qp->sq_base + wqe_idx;
>  		if (wqe_idx)
> -			memset(wqe, qp->swqe_polarity ? 0 : 0xFF, 0x1000);
> +			memset(sq, qp->swqe_polarity ? 0 : 0xFF,
> +			       128 * sizeof(*sq));
>  		else
> -			memset(wqe, qp->swqe_polarity ? 0xFF : 0, 0x1000);
> +			memset(sq, qp->swqe_polarity ? 0xFF : 0,
> +			       128 * sizeof(*sq));
>  	}
>  }
>=20
> --
Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>



