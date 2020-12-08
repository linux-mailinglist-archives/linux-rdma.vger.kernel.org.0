Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065CC2D2410
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 08:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgLHHLW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 02:11:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:44370 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgLHHLW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 02:11:22 -0500
IronPort-SDR: JnKJccvd6yUtGPyd8GWag6XrXusJWZv55cncglkGJsTdY76Y8FOs9FceDK29iaPWHOMT2UIee3
 IdLsFtFc5oAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="153653908"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="153653908"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 23:10:40 -0800
IronPort-SDR: 5LOyHzas+i97z7pzLLzu7+G5o/yWZQqgbMCyXOAKfpIwX0M1Rqz6OaKq5EmUPbrQxx/dT4UwGs
 LLq/zkjF6Q0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="552126291"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2020 23:10:40 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Dec 2020 23:10:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 7 Dec 2020 23:10:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 7 Dec 2020 23:10:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+y9wiSJkW1mq6/7yaqSEHZSTGDwVQNtYbowhGHPRDLwm4vEtqOVB9GOcBFtjwSODY4hCBQ2wSSpXxPPV/1ySFqWpbFqyHa4qkR5NTef9tvih/k56sXTxeNasiQUoxBap4hHeYCrXfW2ACWTQTkoSY5bJlVmkd7BnKRF7rzPX0bLFT0U6plqUcpGnvEwvs1Tvcc6pXvJrHm0+i/kF27Xt+kH4533gAMLrBUNS3R2eSRavyBlVFbeJrgHjUVRrVUKqxuWTKBdz9KuMP/rgkAiEGtWoQmCkb2YHfo2kPnp0IUHDSEJ/2lb+9OcqSEj7dMNfwBqynEaVvl33lyxYOHNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBx5rhYStir9Ob8qxmQQ9O3eGHWaLOvODjujXztz0Uo=;
 b=kMGyHbrDUMS8SQAx7zxIL/kIJJaB3b6zLY2f9iUo8Z054M7XWuOJFKVfhpJcQWwuFg0pFQ9Rn4528PRjan+GKC9KUAioDO3hLf8cAH/Z8kNxtiwH16CxmOPHidePPuJkBaOTfk2yMzAJ+STJOCfUpDPpCbr0rT25eR2A1JFcPQUvu/ZKvAG13lxS0vWWST22mav3iruIGFXhgqlC5A0mX0+kyBHS0QXRgp2O20qvlCMNweV11caWeUgiA/TZUfj/TNy1T1AqDUQ3OSMUZsGjaM6nD8Ful/eP4U0eONvnFp+Ff3fZLm6pg6DhkcLV1Ee334SdaenOI8HRy9P9EOUy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBx5rhYStir9Ob8qxmQQ9O3eGHWaLOvODjujXztz0Uo=;
 b=idIbq43gYxdnwK4WmgSCkYEKFgxmpiPDzuXouOiKMl6E/rr5AfGWHzqPcS9H8cE/GHaBzjeI7g3S2RhObii5yvhLAkcmVHN5p2GJdTTytdaF9l2IcdArWys5m97GPehB07vTNC8VJ2Ot04XRC98tPYhXcQ/DrwT0bFPAmON/TUY=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 07:10:37 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7510:71a5:3cfe:ab94]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7510:71a5:3cfe:ab94%9]) with mapi id 15.20.3632.017; Tue, 8 Dec 2020
 07:10:37 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: RE: [PATCH v13 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [PATCH v13 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWzORzAl0zVkuiI06perwGejvid6nsx0AAgAABM+A=
Date:   Tue, 8 Dec 2020 07:10:37 +0000
Message-ID: <MW3PR11MB4555D3BBC001668300BEFB5AE5CD0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1607379353-116215-1-git-send-email-jianxin.xiong@intel.com>
 <1607379353-116215-2-git-send-email-jianxin.xiong@intel.com>
 <20201208070532.GE4430@unreal>
In-Reply-To: <20201208070532.GE4430@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32c8206e-56ea-42c1-16cb-08d89b485d0b
x-ms-traffictypediagnostic: MW3PR11MB4683:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4683D4226EA17E3E07D51462E5CD0@MW3PR11MB4683.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /u/9qq9tse+Rdp9XnaSociQQr8/xXeB8/h9UQJLU9KKv8Mzt1emm2nCZzTpE0msyZH2b6FF6hS6BoGLm4wYNHoqAzSTo+c59bnbE0e5Gbfa5FyhseBQq6cTzYtHrHW2mylPxQ1oCAZU4PlCBtweTTyLmgkccLjJxUUkA+CaHRXcugrnyNfPhVSCc7vE+p/EpGY8eI7cTaH687YaCiK1Jq1trnDoMEtGVAxcztokIo7kNx428pXBRuVQBP3xp8zMSncOV8HiSvGDtwiEsDIYlqKDgjjlW0kNFxbElQ7Yw9g+lxzDRWO3KpdE9DK2EaPKBlYb05FxjH1S0wINEPHhRhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(76116006)(8936002)(30864003)(66476007)(66446008)(6506007)(4326008)(2906002)(186003)(478600001)(7696005)(64756008)(52536014)(55016002)(66946007)(5660300002)(107886003)(66556008)(86362001)(83380400001)(53546011)(6916009)(9686003)(8676002)(71200400001)(33656002)(26005)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OEksws05qi+eHTPvLi1RKJgcIP8uSopkLNiZEqU606T076TNz+1SJusjSS1O?=
 =?us-ascii?Q?bHssma/w+Zk/5v5xFypT1qJh+x2I0OT7kd03FQGiE0r0G8AQSonZIZrlPJT3?=
 =?us-ascii?Q?C3DbaG0wxsuiXR7dK6oYi67bx9Yyq7IrEXR8L7lV7oDkDscwLsyoRi22wMST?=
 =?us-ascii?Q?pVw2/3mGtcB7j57jQ8r6mvM/Li9oGoOdtlwomzr34/ay4AXNuM/fvvPqwtBO?=
 =?us-ascii?Q?sZoT+4jjMQDRkjuN65BGAmE+AJ45qds2IVk6Mhkm3EGUdYSblRKBvtj093AC?=
 =?us-ascii?Q?d5DPN/8W0nM2OWRmiAehELxNfWicF6652jrPWfe1HJNkfiW2rdzZLSyQmy7u?=
 =?us-ascii?Q?XZ7RxjtPgzWaUBWzoTtIDEmKyZ4GaFXHwH/+1NpPDqOgxkMX4FCTcFGa/sPm?=
 =?us-ascii?Q?ZfBa4rLwa6vQTkdhKBqlw8BXxHU5MZk6ao4C2EWKi0igWi2VUiTITck/HS/X?=
 =?us-ascii?Q?Fh0KALSIKr+yMwPAXX92CpXRdu7jLSlOyz1N6RjLfy8uAB7EgHkzGAtBWeCj?=
 =?us-ascii?Q?v+ZJWW+4dZRogveDIQpYQnaOQtrWYZVxv3ray5T5mQSVPJC3Wt0M25XoAu03?=
 =?us-ascii?Q?Nk8lwrT4iij1Pdds3pZck+Bp7oQll0Z3hSa42OiNMKVEfBQ6Ota7k+t77Fhw?=
 =?us-ascii?Q?+23KI3F6lySzE8HLKLL+G4qBn03AEZgqamiy9XUmk2GAVsk+iHV9uGOji4LW?=
 =?us-ascii?Q?PpA+uIukO5KWATfDfjwUbSlHvyMNqnnc+DuIIkJPkZLfjYMeurHfhceANRWw?=
 =?us-ascii?Q?YSTWtSIvwoZ1eZakFZYwkGBK0Hzkh9XLWJP0lQtcYCaYHuuJO/yJG7eCS4ih?=
 =?us-ascii?Q?UUbHrnt082mWHpVv13Y1XdGXeeAsKQ0xOI8DFIUiGKsiZTslmMetSqYqyQqr?=
 =?us-ascii?Q?QDSn/9Wtz1bWCWK/HKJrd0JLKvT1JHJYlMkGs5wakMp0bZHNxcNo1MYFb0cv?=
 =?us-ascii?Q?KuwE0/r7s1KAjeAqgcrL/njxpCrOby0UmbUlwEUMyPk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c8206e-56ea-42c1-16cb-08d89b485d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 07:10:37.2658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlvNJ5NqzCeKXm6qvch1MjSzTHXIJBAECnj80xnQ01jZSOs0NpHM+8xB3X9HbUhVwSdVii+3sLF+Ninog9vHcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Monday, December 07, 2020 11:06 PM
> To: Xiong, Jianxin <jianxin.xiong@intel.com>
> Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Led=
ford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>;
> Sumit Semwal <sumit.semwal@linaro.org>; Christian Koenig <christian.koeni=
g@amd.com>; Vetter, Daniel <daniel.vetter@intel.com>
> Subject: Re: [PATCH v13 1/4] RDMA/umem: Support importing dma-buf as user=
 memory region
>=20
> On Mon, Dec 07, 2020 at 02:15:50PM -0800, Jianxin Xiong wrote:
> > Dma-buf is a standard cross-driver buffer sharing mechanism that can
> > be used to support peer-to-peer access from RDMA devices.
> >
> > Device memory exported via dma-buf is associated with a file descriptor=
.
> > This is passed to the user space as a property associated with the
> > buffer allocation. When the buffer is registered as a memory region,
> > the file descriptor is passed to the RDMA driver along with other
> > parameters.
> >
> > Implement the common code for importing dma-buf object and mapping
> > dma-buf pages.
> >
> > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> > Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> > Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> > Acked-by: Christian Koenig <christian.koenig@amd.com>
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > Conflicts:
> > 	include/rdma/ib_umem.h
>=20
> This probably leftover from rebase, am I right?

Right. Should have removed it.

>=20
> > ---
> >  drivers/infiniband/core/Makefile      |   2 +-
> >  drivers/infiniband/core/umem.c        |   3 +
> >  drivers/infiniband/core/umem_dmabuf.c | 173 ++++++++++++++++++++++++++=
++++++++
> >  include/rdma/ib_umem.h                |  43 ++++++++-
> >  4 files changed, 219 insertions(+), 2 deletions(-)  create mode
> > 100644 drivers/infiniband/core/umem_dmabuf.c
> >
> > diff --git a/drivers/infiniband/core/Makefile
> > b/drivers/infiniband/core/Makefile
> > index ccf2670..8ab4eea 100644
> > --- a/drivers/infiniband/core/Makefile
> > +++ b/drivers/infiniband/core/Makefile
> > @@ -40,5 +40,5 @@ ib_uverbs-y :=3D			uverbs_main.o uverbs_cmd.o uverbs_=
marshall.o \
> >  				uverbs_std_types_srq.o \
> >  				uverbs_std_types_wq.o \
> >  				uverbs_std_types_qp.o
> > -ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) +=3D umem.o
> > +ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) +=3D umem.o umem_dmabuf.o
> >  ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) +=3D umem_odp.o diff
> > --git a/drivers/infiniband/core/umem.c
> > b/drivers/infiniband/core/umem.c index 7ca4112..cc131f8 100644
> > --- a/drivers/infiniband/core/umem.c
> > +++ b/drivers/infiniband/core/umem.c
> > @@ -2,6 +2,7 @@
> >   * Copyright (c) 2005 Topspin Communications.  All rights reserved.
> >   * Copyright (c) 2005 Cisco Systems.  All rights reserved.
> >   * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
> > + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> >   *
> >   * This software is available to you under a choice of one of two
> >   * licenses.  You may choose to be licensed under the terms of the
> > GNU @@ -278,6 +279,8 @@ void ib_umem_release(struct ib_umem *umem)  {
> >  	if (!umem)
> >  		return;
> > +	if (umem->is_dmabuf)
> > +		return ib_umem_dmabuf_release(to_ib_umem_dmabuf(umem));
> >  	if (umem->is_odp)
> >  		return ib_umem_odp_release(to_ib_umem_odp(umem));
> >
> > diff --git a/drivers/infiniband/core/umem_dmabuf.c
> > b/drivers/infiniband/core/umem_dmabuf.c
> > new file mode 100644
> > index 0000000..e50b955
> > --- /dev/null
> > +++ b/drivers/infiniband/core/umem_dmabuf.c
> > @@ -0,0 +1,173 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +/*
> > + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> > + */
> > +
> > +#include <linux/dma-buf.h>
> > +#include <linux/dma-resv.h>
> > +#include <linux/dma-mapping.h>
> > +
> > +#include "uverbs.h"
> > +
> > +int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf) {
> > +	struct sg_table *sgt;
> > +	struct scatterlist *sg;
> > +	struct dma_fence *fence;
> > +	unsigned long start, end, cur;
> > +	unsigned int nmap;
> > +	int i;
> > +
> > +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> > +
> > +	if (umem_dmabuf->sgt)
> > +		return 0;
> > +
> > +	sgt =3D dma_buf_map_attachment(umem_dmabuf->attach, DMA_BIDIRECTIONAL=
);
> > +	if (IS_ERR(sgt))
> > +		return PTR_ERR(sgt);
> > +
> > +	/* modify the sg list in-place to match umem address and length */
> > +
> > +	start =3D ALIGN_DOWN(umem_dmabuf->umem.address, PAGE_SIZE);
> > +	end =3D ALIGN(umem_dmabuf->umem.address + umem_dmabuf->umem.length,
> > +		    PAGE_SIZE);
> > +	cur =3D 0;
> > +	nmap =3D 0;
>=20
> Better to put as part of variable initialization.
>=20
> > +	for_each_sgtable_dma_sg(sgt, sg, i) {
> > +		if (start < cur + sg_dma_len(sg) && cur < end)
> > +			nmap++;
> > +		if (cur <=3D start && start < cur + sg_dma_len(sg)) {
> > +			unsigned long offset =3D start - cur;
> > +
> > +			umem_dmabuf->first_sg =3D sg;
> > +			umem_dmabuf->first_sg_offset =3D offset;
> > +			sg_dma_address(sg) +=3D offset;
> > +			sg_dma_len(sg) -=3D offset;
> > +			cur +=3D offset;
> > +		}
> > +		if (cur < end && end <=3D cur + sg_dma_len(sg)) {
> > +			unsigned long trim =3D cur + sg_dma_len(sg) - end;
> > +
> > +			umem_dmabuf->last_sg =3D sg;
> > +			umem_dmabuf->last_sg_trim =3D trim;
> > +			sg_dma_len(sg) -=3D trim;
> > +			break;
> > +		}
> > +		cur +=3D sg_dma_len(sg);
> > +	}
> > +
> > +	umem_dmabuf->umem.sg_head.sgl =3D umem_dmabuf->first_sg;
> > +	umem_dmabuf->umem.sg_head.nents =3D nmap;
> > +	umem_dmabuf->umem.nmap =3D nmap;
> > +	umem_dmabuf->sgt =3D sgt;
> > +
> > +	/*
> > +	 * Although the sg list is valid now, the content of the pages
> > +	 * may be not up-to-date. Wait for the exporter to finish
> > +	 * the migration.
> > +	 */
> > +	fence =3D dma_resv_get_excl(umem_dmabuf->attach->dmabuf->resv);
> > +	if (fence)
> > +		dma_fence_wait(fence, false);
>=20
> Any reason do not check return result from dma_fence_wait()?
>=20
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(ib_umem_dmabuf_map_pages);
> > +
> > +void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf) {
> > +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> > +
> > +	if (!umem_dmabuf->sgt)
> > +		return;
> > +
> > +	/* retore the original sg list */
> > +	if (umem_dmabuf->first_sg) {
> > +		sg_dma_address(umem_dmabuf->first_sg) -=3D
> > +			umem_dmabuf->first_sg_offset;
> > +		sg_dma_len(umem_dmabuf->first_sg) +=3D
> > +			umem_dmabuf->first_sg_offset;
> > +		umem_dmabuf->first_sg =3D NULL;
> > +		umem_dmabuf->first_sg_offset =3D 0;
> > +	}
> > +	if (umem_dmabuf->last_sg) {
> > +		sg_dma_len(umem_dmabuf->last_sg) +=3D
> > +			umem_dmabuf->last_sg_trim;
> > +		umem_dmabuf->last_sg =3D NULL;
> > +		umem_dmabuf->last_sg_trim =3D 0;
> > +	}
> > +
> > +	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt,
> > +				 DMA_BIDIRECTIONAL);
> > +
> > +	umem_dmabuf->sgt =3D NULL;
> > +}
> > +EXPORT_SYMBOL(ib_umem_dmabuf_unmap_pages);
> > +
> > +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> > +				   unsigned long offset, size_t size,
> > +				   int fd, int access,
> > +				   const struct dma_buf_attach_ops *ops) {
> > +	struct dma_buf *dmabuf;
> > +	struct ib_umem_dmabuf *umem_dmabuf;
> > +	struct ib_umem *umem;
> > +	unsigned long end;
> > +	long ret =3D -EINVAL;
>=20
> It is wrong type for the returned value. One of the possible options is t=
o declare "struct ib_umem *ret;" and set ret =3D ERR_PTR(-EINVAL) or
> ret =3D ERR_CAST(dmabuf);
>=20
> > +
> > +	if (check_add_overflow(offset, (unsigned long)size, &end))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (unlikely(!ops || !ops->move_notify))
>=20
> Let's not put likely/unlikely in control paths.
>=20
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	dmabuf =3D dma_buf_get(fd);
> > +	if (IS_ERR(dmabuf))
> > +		return (void *)dmabuf;
>=20
> return ERR_CAST(dmabuf);
>=20
> > +
> > +	if (dmabuf->size < end)
> > +		goto out_release_dmabuf;
> > +
> > +	umem_dmabuf =3D kzalloc(sizeof(*umem_dmabuf), GFP_KERNEL);
> > +	if (!umem_dmabuf)
> > +		return ERR_PTR(-ENOMEM);
>=20
> You are leaking dmabuf here, forgot to call to dma_buf_put();
>=20
> > +
> > +	umem =3D &umem_dmabuf->umem;
> > +	umem->ibdev =3D device;
> > +	umem->length =3D size;
> > +	umem->address =3D offset;
> > +	umem->writable =3D ib_access_writable(access);
> > +	umem->is_dmabuf =3D 1;
> > +
> > +	if (unlikely(!ib_umem_num_pages(umem)))
>=20
> There is no advantage in "unlikely" here.
>=20
> > +		goto out_free_umem;
> > +
> > +	umem_dmabuf->attach =3D dma_buf_dynamic_attach(
> > +					dmabuf,
> > +					device->dma_device,
> > +					ops,
> > +					umem_dmabuf);
> > +	if (IS_ERR(umem_dmabuf->attach)) {
> > +		ret =3D PTR_ERR(umem_dmabuf->attach);
> > +		goto out_free_umem;
> > +	}
> > +	return umem;
> > +
> > +out_free_umem:
> > +	kfree(umem_dmabuf);
> > +
> > +out_release_dmabuf:
> > +	dma_buf_put(dmabuf);
> > +	return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL(ib_umem_dmabuf_get);
> > +
> > +void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) {
> > +	struct dma_buf *dmabuf =3D umem_dmabuf->attach->dmabuf;
> > +
> > +	dma_buf_detach(dmabuf, umem_dmabuf->attach);
> > +	dma_buf_put(dmabuf);
> > +	kfree(umem_dmabuf);
> > +}
> > diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h index
> > 7752211..b49a96d 100644
> > --- a/include/rdma/ib_umem.h
> > +++ b/include/rdma/ib_umem.h
> > @@ -1,6 +1,7 @@
> >  /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> >  /*
> >   * Copyright (c) 2007 Cisco Systems.  All rights reserved.
> > + * Copyright (c) 2020 Intel Corporation.  All rights reserved.
> >   */
> >
> >  #ifndef IB_UMEM_H
> > @@ -13,6 +14,7 @@
> >
> >  struct ib_ucontext;
> >  struct ib_umem_odp;
> > +struct dma_buf_attach_ops;
> >
> >  struct ib_umem {
> >  	struct ib_device       *ibdev;
> > @@ -22,12 +24,29 @@ struct ib_umem {
> >  	unsigned long		address;
> >  	u32 writable : 1;
> >  	u32 is_odp : 1;
> > +	u32 is_dmabuf : 1;
> >  	struct work_struct	work;
> >  	struct sg_table sg_head;
> >  	int             nmap;
> >  	unsigned int    sg_nents;
> >  };
> >
> > +struct ib_umem_dmabuf {
> > +	struct ib_umem umem;
> > +	struct dma_buf_attachment *attach;
> > +	struct sg_table *sgt;
> > +	struct scatterlist *first_sg;
> > +	struct scatterlist *last_sg;
> > +	unsigned long first_sg_offset;
> > +	unsigned long last_sg_trim;
> > +	void *private;
> > +};
> > +
> > +static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem
> > +*umem) {
> > +	return container_of(umem, struct ib_umem_dmabuf, umem); }
> > +
> >  /* Returns the offset of the umem start relative to the first page.
> > */  static inline int ib_umem_offset(struct ib_umem *umem)  { @@ -86,6
> > +105,7 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem,
> > size_t offset,  unsigned long ib_umem_find_best_pgsz(struct ib_umem *um=
em,
> >  				     unsigned long pgsz_bitmap,
> >  				     unsigned long virt);
> > +
> >  /**
> >   * ib_umem_find_best_pgoff - Find best HW page size
> >   *
> > @@ -116,6 +136,14 @@ static inline unsigned long ib_umem_find_best_pgof=
f(struct ib_umem *umem,
> >  				      dma_addr & pgoff_bitmask);
> >  }
> >
> > +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> > +				   unsigned long offset, size_t size,
> > +				   int fd, int access,
> > +				   const struct dma_buf_attach_ops *ops); int
> > +ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf); void
> > +ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf); void
> > +ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
> > +
> >  #else /* CONFIG_INFINIBAND_USER_MEM */
> >
> >  #include <linux/err.h>
> > @@ -143,7 +171,20 @@ static inline unsigned long
> > ib_umem_find_best_pgoff(struct ib_umem *umem,  {
> >  	return 0;
> >  }
> > +static inline struct ib_umem *ib_umem_dmabuf_get(struct ib_device *dev=
ice,
> > +						 unsigned long offset,
> > +						 size_t size, int fd,
> > +						 int access,
> > +						 struct dma_buf_attach_ops *ops) {
> > +	return ERR_PTR(-EINVAL);
>=20
> Probably, It should be EOPNOTSUPP and not EINVAL.
>=20
> > +}
> > +static inline int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf
> > +*umem_dmabuf) {
> > +	return -EINVAL;
> > +}
> > +static inline void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf
> > +*umem_dmabuf) { } static inline void ib_umem_dmabuf_release(struct
> > +ib_umem_dmabuf *umem_dmabuf) { }
> >
> >  #endif /* CONFIG_INFINIBAND_USER_MEM */
> > -
> >  #endif /* IB_UMEM_H */
> > --
> > 1.8.3.1
> >
