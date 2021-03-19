Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615CB342276
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 17:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCSQvW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 12:51:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:40549 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhCSQu6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 12:50:58 -0400
IronPort-SDR: G/Nfz74SnnWLp0njUxwBkvJ7041WR7O09aH8sqFIa6MGHal1cFTvbFUQk14X4KOAdL/bxjw14d
 hTwb3rzWWDLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="251279723"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="251279723"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:50:55 -0700
IronPort-SDR: 50cD22beVn/K9YPA0yi0GOTThDtj4L1is/VjeHNyD7hwvLKf3mbwg+SsOZWdvk+oNZdaR5mFA3
 fMhqRtbOUvzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="603199537"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 19 Mar 2021 09:50:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 09:50:55 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 09:50:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Mar 2021 09:50:55 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Mar 2021 09:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2EZ4NjYasGh4ru6AFjlfrqIAODgCkI/gd87Xrex2caV7bzoSR0cmTvJoby8OR+PMmhnMzvVcYh2qnwY2RhrCea/gl2ZkkFQlf8f7C/13dsHsmqsJvvnRSMFIq6get5FaLSjhFn3UqBAWA7AOXWQBIQsYOQqR8prz7KzRBZ59GC1dIuOhfHAcfE0LOyooOoRMvhVzJpBefCpQrY1Xn2/ouvdytvJFuW95DSWR2GXjaFGiGhSsPj8KUceM5QMl4ut5lIRwQpzDM978uf6J0UqkXjQG4/2Kc3HXaHvTNXvYTj7+XmLTZrHQ/SN6xttGzKL9ev5wWFRz+lKmF95tHyGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOlAW2kDJfmBIQiBXuRzge+irXMkUItjqpvSyvqkpZs=;
 b=FBjvAV+LuqyXaYAPe6Q1ZG7F0cOxCpBQykzSsUUB5InDiiuK8ZCXbt9xtI7yszm01sihM+sdQXGAiVyRhFt0MICwktTHM0t8BzCDESRoprgHMLB4Zl3kvcIK26I8FIk2+CDbGxjgLf+Cz8vY/U5vcvimmNoJISWI7aqEuq4hynIOrvCSrEXLPMeCcfttS5p+ZVAYiEZ0S8bstadNflHDNwyBgwWttZ17meKJXL3ANnd30uF948v5fblvY5Yaw5Qhm4aVzMWMyKpG7i0K8yEDaDP1fwNDGq3c2FCN8kQN+wq32BfZXiooAn1/NTNJ3MFt0QU6ovgrJFO4+9I+9D9X6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOlAW2kDJfmBIQiBXuRzge+irXMkUItjqpvSyvqkpZs=;
 b=WmZ99JNlbWNtg84+Lee+2NKa7jKxeNJa7Ei6Gdm634OPCgB6OkyrKMfKlJzLTvpF/mV7iRJdJwTCMyNdlJho+nj9QHlhNuCvaa77s6G430OB0sIha0Msd121o69NWzwL8E18RlgQZ8SPN+XAi1ijCOAYcy6MAEKgl2jvlsQ2SRY=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR1101MB2239.namprd11.prod.outlook.com (2603:10b6:301:5b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 16:50:53 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ad99:f489:b817:d3f8]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ad99:f489:b817:d3f8%5]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 16:50:53 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     liweihang <liweihang@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [rdma-core] Compile issue with DRM headers
Thread-Topic: [rdma-core] Compile issue with DRM headers
Thread-Index: AQHXHJv3XGIQP1y/YEuHT1qgEOdOZ6qLgRCA
Date:   Fri, 19 Mar 2021 16:50:53 +0000
Message-ID: <MW3PR11MB4555FC2C195C0AAB5D804326E5689@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <d204d1db15844e45b946125a5452ab19@huawei.com>
In-Reply-To: <d204d1db15844e45b946125a5452ab19@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c1e78f0-39bb-40ee-42de-08d8eaf728b6
x-ms-traffictypediagnostic: MWHPR1101MB2239:
x-microsoft-antispam-prvs: <MWHPR1101MB2239ED5A1B195CE9F078201EE5689@MWHPR1101MB2239.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qrAaJSvkAylijhDnT9g3Gt2iyoRGac/kbEOQ7hicO7FcZ67PvxglWHEKp901c9iiVKQq88UHJMlONh1d9CRcW3dwksj3LtdrVJFy+kv1At3LlcNj4KX2cA4WtbIAS0OPIG5AWIIKInCXfSk3YKEy11NotAdrWmvJ4Uz/OFbBryYvX5KyvAgqATsi52IlrkzJwQH50EAitwIopjdFsdnioMfbZP80SwLad52cB5qqIwnTPK1/pNoJVmKHo38KdNSfmJfRmWN66Werez9+TSUUeDGEeimby73ji8ZutmjjhpgY07DsnzxrFeimNJ2IY4zB0b9BQQD4uhhQ4PGZm/dL3l6GsElMf0SxwDvonQmZ3mW3VOkTP6UjOytmqgNzAtRlc8OnwnSeJtDeES8ISn4kZt2e1J9ZCj0iHGduK5/Y+SRMoeng7Z8LCgh66ziSDdDRR+of6LFTmuVzrlg77Sl4WQFmdILltgbyx1/hPsj89qnLCM/G3QgGv59h7cYd3/np5V+zs41DDOuJizwy1PslDBRgUaJhvLu8EmGLUQowkAeOjwuR6o2QpDzKINFbjRvxsN0ryHq1Ru0ItLnipePQuJH1ewXKEMbjB7JI8KO7MV/+bqJwVF6N1t7RkRowlWdA/IHorwHL2yXJrDc8nEqWiPKrHlRIVN/9wGJ47a0q/k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(66446008)(66946007)(5660300002)(66556008)(26005)(8676002)(7696005)(6506007)(66476007)(186003)(478600001)(54906003)(71200400001)(53546011)(52536014)(64756008)(83380400001)(76116006)(33656002)(4326008)(55016002)(8936002)(86362001)(38100700001)(2906002)(316002)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eRSUIGBKMyc7OFvtqVCrxSLLNMtx/SumOyAd2hqGg249/bgBFAQ/ofh9xOKG?=
 =?us-ascii?Q?/JoCRGjP3kW0XMr7KvwT5WEHbk++mAqJbeWPbTVl4qY67IozarQKXPGP0IId?=
 =?us-ascii?Q?Vn9RyObxD77rJy315NOPqWfsCEcBdZJ3wI+c/ZffSHpEJbyC6CJL0DMrQS8r?=
 =?us-ascii?Q?w57Ihjbh9ySkQChld/ZZ7Q41Q/NUaIKegQhUa88n7wm/HiA3QI6S4UfKfUYx?=
 =?us-ascii?Q?E+VV+WwvNK/BBJsqOYCAUPH9hviAaj5/H/VM0lyCcWRYJOMqr3fj6m0kxD4d?=
 =?us-ascii?Q?tM0ycxLeqcACsXu8yfHVKnc5fiouzBaz4JWLeNkgTYp22yFVcYgN2khQsxGG?=
 =?us-ascii?Q?nLutjAs7QrdqBPnvbMvSHUzJdeeuyUpPZCRJDLzeOwJGPCou0wi53+foDHLa?=
 =?us-ascii?Q?tYypldoPdYcMz/UnDJ91bSWzVGJrv9/U0YiLWCdBXbWzUxE8mxuuN8ASOi8e?=
 =?us-ascii?Q?EqIHyudqxsItpHa0aCA5R11zyUrdwPzIbpufy8xOHQq/yyJZxQKGIWRHjPp7?=
 =?us-ascii?Q?ohWITHOsURCsLIy252ziL+U0+2QMR9tjMUuakd/L7Inz0+nft3e8wz8K+/lq?=
 =?us-ascii?Q?L1NB2cZ04EcUNPYk83n7ssLhJRpHJbsu8VE4jGgoqkrd2hqMl6Vd6Eqcg8tq?=
 =?us-ascii?Q?+iA2zGds9MPZ5bf7xiJH0prhsYPlKlJtO9ILQknT3aM6W8rnRP31xA9EFCpq?=
 =?us-ascii?Q?l5/HulHvCPg0v9RcsNR9Fl4AxedKaEZP40hopJE/kTa5SlHwu6aCTA/j1XUM?=
 =?us-ascii?Q?299mL9/8l0YemO1zqcQYc9tr+EYR+JxcKPJorJdRWLgjX/Q+LKtgMXT8B7PM?=
 =?us-ascii?Q?xtdCslgttaFhUnjWS43x+5cCmv0OVYiHZ+GshhnpAogSfnexcERDIAatHB8g?=
 =?us-ascii?Q?QAyruz/Jk/66wSBLig47ROm1yc0ropBTDcohj44K6rYyGDY3cUnxwaBIDREU?=
 =?us-ascii?Q?NyNv6g6t7ltIr9I3Ki3zhbf49XIbmGbOo88QxNZ3es5ZwSuwlADrnE2LzKCi?=
 =?us-ascii?Q?rPNv/1DmI0XYd/8m+Y6TMkK6/FUVzZe2gGWGMFhvx7qnCAs33mokBQ24oyS+?=
 =?us-ascii?Q?vT2B3V8PKPDp3DIyHcpmJV8wQ1fwcb2HSi/QZNpAb4Rm+egDTBZyz79mFwCL?=
 =?us-ascii?Q?bT6TYK6r5QIm3CQqPASXzMZZTEp2x8MD8/Q/JzHLrtrh3AZtSbXF57Wwixiy?=
 =?us-ascii?Q?uRhbVC/x6SJ4uRpJLKFlKUzygTNtpsoV8s46mp9JVBSDr1tRRsMIHv8T9nbc?=
 =?us-ascii?Q?p+wRrlIVSAM+DSuUuknk1C8qYxstCwucO0ZMnV6a7WCYncreHskf7NMzsqnY?=
 =?us-ascii?Q?Wok=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1e78f0-39bb-40ee-42de-08d8eaf728b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 16:50:53.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjbzhBOUQa0Ic7KYoiqECeE89Jbl0rmCrbVuBun9noABTf4lqb/3DeIzY6rr6ntS1odL4gt9MgDO11vVwXdHbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2239
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> -----Original Message-----
> From: liweihang <liweihang@huawei.com>
> Sent: Friday, March 19, 2021 1:44 AM
> To: Xiong, Jianxin <jianxin.xiong@intel.com>; linux-rdma@vger.kernel.org
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>; Li=
nuxarm <linuxarm@huawei.com>
> Subject: [rdma-core] Compile issue with DRM headers
>=20
> Hi Jianxin,
>=20
> I met a compile error with recent version of rdma-core on my server with =
Ubuntu
> 14.04:
>=20
> ../pyverbs/dmabuf_alloc.c:16:24: fatal error: amdgpu_drm.h: No such file =
or directory  #include <amdgpu_drm.h>
>                         ^
> compilation terminated.
>=20
> I found it is related with dma-buf based commits. And the commit 3788aa84=
3b4b
> ("configure: Add check for DRM headers") adds a check for libdrm headers.=
 I have installed it but my version(2.4.67-1ubuntu0.14.04.2) isn't
> new enough, there is no 'amdgpu_drm.h' in DRM_INCLUDE_DIRS(/usr/include/d=
rm).
>=20
> So I think we may need some check for the the version of libdrm in CMakeL=
ist.txt or something else :) Could you please give me some
> suggestions?
>=20
> Thanks
> Weihang

Hi Weihang,

The simplest way is to replace the check of "drm.h" with "amdgpu_drm.h". Th=
is is=20
reasonable since dma-buf based MR won't work with old kernel anyway.=20

Alternatively, we can add a check for "amdgpu_drm.h" in CMakeLists.txt and =
add
some #ifdef's to dmabuf_alloc.c around the code related to amdgpu.

-Jianxin

