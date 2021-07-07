Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595443BECAF
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhGGRBL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 13:01:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:42449 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhGGRBK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Jul 2021 13:01:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="273185685"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="273185685"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="628086628"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2021 09:58:30 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 7 Jul 2021 09:58:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 7 Jul 2021 09:58:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 7 Jul 2021 09:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0ePDNAXgddPWjh0vEgTkkEGh3CEN7BJ2wIRMUTccjZ8iDd7MqVXO4TlAVoaRFDnjhRShplpWtLXchpTnoIfZoBduBHAvdDKvpITl12v4A35v804MktHd4z/Kf/cvX/KHdJ9qanxkgyo02CdQrRlu5ghjaO71JzI8hFvUzJw+Kx3O/5xFaqhMPxFG3qI3D1Dsm0TpHWXj/EjSerRwvtbJWEVkwbKJT1+Z5EbvisQwIgmFdLS0YV4THSkDm07S7DQ3xS8wLYmwtUprgdQ1gR/mpfiGNgpXIrjlWFc2QFX6z60AZM0ohkRCI0v+lvQLlZjg8f8BwZ3LU82Ort/P7R/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAxvlpHOXMdQbd40Fsr8smtUOQSFqELBAzXgG6ky/WU=;
 b=g/eIN72nugdHk53V04zYDJZzB88YEMRqcI4FIALWj9IT5HRrCMZGOoBNPon8lc8U1W7SAh33nB3Zusl6Sw1OzyNtbECYQhAZ7LCCQAHxPllldjSQFj8hw3obi004NZh3rDTKz3V8J46qHbVeLbWHY7DDqFUeVK837MARPxEXMGsBABEOsF0NS6nu6dx6arMfpgqY/O0iLmWJ3ms94fOgPSwRoDyg1x4tu+i5WSfhfi8HNGu/+5NFsPeoxYynI+cYSh9bggZP43acl0fDiFzLcyPU27niLTdCfJAju+OTe3YA6iQX992W+AoLOScaMURvilNqPjI/mtBslPxIUA1i9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAxvlpHOXMdQbd40Fsr8smtUOQSFqELBAzXgG6ky/WU=;
 b=GJTetFDJWcQ2uadlEXLkD+o3auM1NWCy2ZK305L99+SDUtd3QKEC2NmQR35QQ592KkjacO2boIlbeFLuqtrY8NzUnB/Uo+GaibCJV6pSXXCn12mOnnl2UglhbiUUH8/L1ejyese/ezwhU2pC5aUJ5f4yNfL5EyC8+bxQygaBqoc=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB4739.namprd11.prod.outlook.com (2603:10b6:5:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 16:58:28 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b528:9dc5:64b6:d69]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b528:9dc5:64b6:d69%6]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 16:58:28 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: make spdxcheck.py happy
Thread-Topic: [PATCH] RDMA/irdma: make spdxcheck.py happy
Thread-Index: AQHXbmWye0HKNs2NCUintScoeMRIeKs3xaVg
Date:   Wed, 7 Jul 2021 16:58:28 +0000
Message-ID: <DM6PR11MB46925EAC1D28B6E62CBDB531CB1A9@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210701104127.1877-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210701104127.1877-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0b3e100-d654-409c-1522-08d94168717e
x-ms-traffictypediagnostic: DM6PR11MB4739:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4739D01662228D9D03A174BCCB1A9@DM6PR11MB4739.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0b9QajiQP0w9TvVaozKAzrZOAWyE6s8VTHKUuENJJht3M4lOPHaPf5ueI4eyjuRmG17Kr+swG/nmNHblfI86t8i4QoDJ0PE2yQZQiLW5y6lcyBjPzuypHzHf8375vCiMyHsFa9CLOXa20xy9RtJPe24YIk5qwroXCG0q190rB2Ek5vC69a/RMdMIsqPOSzJR45/3CExWT9DUDhgEsg1mfzwF3FICqfayEzQJNB4rOhhBfTkVlBob7d06qw0JbBWQy9jhTBd3Mum137TMrDQCN8sB+LCjFqW7F7zK4se7a5z3Al1763WjdVMg3sm5sWJ/WVUH7RIB96yUdEL+LlavkYMoB1EmjR+wlIlhvGUsPtnu6TvTFh0NQmohwh+fjReXdB+sYSeaRxn76KtiCb/IyvNCEkAdIMPYzguVQLF56NO4gzDt9B+3rSevkL+98zCW3xVxeb0WbmtGnGZZ2n1pTTDfBKMh6FNsGS3aO+aWPxp+c78bJcDw2aLqWUvSkJ6saJl3n8c4yz1U+SkVo+6BKWn7czKsLufC6vx471cWg5Q7CNS2/kL+4RcYHDqk3/cnXHENY+Z6OqueeNCUZtDoevWNEYir0/Q6TgBGDwDhj1C/UB75OSBtSBaM4artp6C/klYaUScThSLMQdN/B438Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(346002)(39860400002)(4326008)(478600001)(55016002)(9686003)(8676002)(8936002)(2906002)(66556008)(66946007)(64756008)(66446008)(66476007)(76116006)(52536014)(53546011)(7696005)(316002)(6506007)(86362001)(54906003)(71200400001)(83380400001)(38100700002)(110136005)(33656002)(5660300002)(122000001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8CpR8CxI9jFVu/JPB7k4uIrRsxr18/oaf3ymtMOsA84q6368boUNi25m7rTN?=
 =?us-ascii?Q?ZscHCFyVpiu7T/uRXF5I9YE4nKWee9BmRMaszC6e9tvNTRctwRznEmvmtLrs?=
 =?us-ascii?Q?5s1+1kDf4wx7zd7hWlITFeFrGeyzBk/BUBD+N6gMvErjL0oHh9LeiaokfhMG?=
 =?us-ascii?Q?UsfEZd8I5s3HudhudrpDmKDhisl5B8pIgnUnHRJCBNnu/rxz/TJBfpowFIgK?=
 =?us-ascii?Q?kxHV0joAY+MzreVERClkljqxnAdsJEb6B0+FZbNi23QRWFMRVVB9AJ5JzO/3?=
 =?us-ascii?Q?992zjX11mSo922vVpy9KBRJfhw66obSj+N/W7NNPPfo+xnLr+CuUg9df3VcG?=
 =?us-ascii?Q?KsqFaSb1meu504eaYaWWA6hCdQkjR4/KGPnfGwnKBLM+2I+w36xhf/kZnJWu?=
 =?us-ascii?Q?TQC+0MLz6lmcPSecmK/qIHQYsxila6nOkB2LpvAc81Uz6IrGCGc5rJEgdauu?=
 =?us-ascii?Q?O1X5dNR/OsjYuQ+WQaEjlo0crvkQNLrmDX2AyUArkFUnCNoIhsFtd55ocgIA?=
 =?us-ascii?Q?/l2l/lkfXTaSYHuZ1KT1jk4Je6GAHsvTWvKiwTW6wOLlBDQuhX2VRI5ppQxn?=
 =?us-ascii?Q?+ascfgUCf03uelzCVJymtUYNfzm8k6EZFvFQMoysMRCkCEEK3nE5gsTdHDYb?=
 =?us-ascii?Q?Y4u0dqNYX2WpTFf01pGAAHXGwLIEiqGTeIBLhI8dQgXVelMEa7iHqiKFhmk/?=
 =?us-ascii?Q?0Kh7IaMF8fL+69UzfDXWSFMQVCfL7uxMQzjKHIYcfRH00dd/7YeSBOE8fBZL?=
 =?us-ascii?Q?qnnSpcyZcPmye4SBYDK+ZLhTFnRqrBTIwLWugGx+aed7WKrHm2cmZ5arDBEn?=
 =?us-ascii?Q?ovOOvCRERhnOwZnQHExjFzNSYhyG4r8jvUruWIo66+aikctWkA2TLtlWrZs0?=
 =?us-ascii?Q?EQ7AmMOCZygstfGQyLu+EjhpdC3eIDQqExpX5hfzhCReP2MRvUrcsH3A8tUf?=
 =?us-ascii?Q?+mtbUfbaDuTWnEKhgz4YXay0ozu658UFtc8NnVmESSGB97LEQx3kIiSr7gwP?=
 =?us-ascii?Q?TlOY+tYK6Y5ib0Ne1e5V0q+SQMpt56MZHRPM7omoGnM74i9yUrOYxVsAVZE7?=
 =?us-ascii?Q?aq70v3ml359yRXm0yIXTC7vTgiluHP7xFzjqYj71fUWEV5a3OcMF0UP6H3Z5?=
 =?us-ascii?Q?Kjh/zY8SremrbGVArlyCrgIG/9T8UNb9QP9Lq9cXrrJJTi4fgHh0eMXwMTAr?=
 =?us-ascii?Q?H8LYKmEY45Gwc0I5uwI4rNk2MLHMIon2+XjNynyqRUNDJxtXxfkAktvcw216?=
 =?us-ascii?Q?BV1NejD+Gr7UIYcj587XXqNsKRj3gaXZWzyO7zyCB4u9OSx20ji8H27n3tbK?=
 =?us-ascii?Q?ktDsX94BplO+QTRIx/9sZh3drKvYpRsHWrroKvaoZnyKIubWT1En/crrpLhN?=
 =?us-ascii?Q?DPs7Kg0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b3e100-d654-409c-1522-08d94168717e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 16:58:28.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LeHRS/0tA5836xLzDsnwf+DBsXKcc59Ylz3p4qUq2r0C//v84x2I/eY6V8VCdyu3a4Rl0F3RShxXu6zdjqqGsiVCHxjY/xYFJk1kH2JpyRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4739
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Sent: Thursday, July 1, 2021 3:41 AM
> To: Ismail, Mustafa <mustafa.ismail@intel.com>; Saleem, Shiraz
> <shiraz.saleem@intel.com>; Doug Ledford <dledford@redhat.com>; Jason
> Gunthorpe <jgg@ziepe.ca>; linux-rdma@vger.kernel.org
> Cc: linux-spdx@vger.kernel.org; linux-kernel@vger.kernel.org; Lukas
> Bulwahn <lukas.bulwahn@gmail.com>
> Subject: [PATCH] RDMA/irdma: make spdxcheck.py happy
>=20
> Commit 48d6b3336a9f ("RDMA/irdma: Add ABI definitions") adds
> ./include/uapi/rdma/irdma-abi.h with an additional unneeded closing
> bracket at the end of the SPDX-License-Identifier line.
>=20
> Hence, ./scripts/spdxcheck.py complains:
>=20
>   include/uapi/rdma/irdma-abi.h: 1:77 Syntax error: )
>=20
> Remove that closing bracket to make spdxcheck.py happy.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210701
>=20
> Mustafa, Shiraz, please ack.
> Jason, please pick this minor non-urgent patch into your rdma tree.
>=20
>  include/uapi/rdma/irdma-abi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.=
h
> index 26b638a7ad97..a7085e092d34 100644
> --- a/include/uapi/rdma/irdma-abi.h
> +++ b/include/uapi/rdma/irdma-abi.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR Linux-
> OpenIB) */
> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR
> +Linux-OpenIB */
>  /*
>   * Copyright (c) 2006 - 2021 Intel Corporation.  All rights reserved.
>   * Copyright (c) 2005 Topspin Communications.  All rights reserved.
> --
> 2.17.1

Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

