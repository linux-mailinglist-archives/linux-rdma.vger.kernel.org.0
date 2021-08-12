Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6360A3EADA4
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Aug 2021 01:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhHLXdd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Aug 2021 19:33:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:5033 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhHLXdd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Aug 2021 19:33:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="202662020"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="202662020"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 16:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="469924267"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 12 Aug 2021 16:33:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 12 Aug 2021 16:33:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 12 Aug 2021 16:33:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 12 Aug 2021 16:33:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 12 Aug 2021 16:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPCX4qI+JBRbhk3fViTyP/1GtnF/WlPbF5RJd3D5f/+Z6zl4rs5shuqSgs4f6+uI+4174dDGqd1r7WKETFL2trVcu1ghZGSIgbHjJixEUmnGBmNTJkqaU2+omeSQkvUAb+FmnpcXOmG46UA9JrhZOhWMIVMUSbEQj1OdgbHPYnyZhAcHayjkcrL/nA2nsFD5MPB8TC0XRBcOHvv9Clnn9aiEFkFi60eOjBN35U3U2Qg8ObsJ7qcF0FscAUl6rnsQX9sg0cO8cB5ijrgmVXf9aYqF5j23xplscee5scT4r7CkR2GSxD7CmW3Ql33sMO31BXo6maqRa1Io4Tkq88joNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feOvbk+agkvUU8T1Dt7PyxdLBf3eIrY8RJ2uuZUk8FQ=;
 b=HGV0469jsL6lV//JGWNBNFIaJOnzQJ/CYAwWhjlIwOyff0pldNSJRWrMGYAYQXM0uXJfrpE8LQeG/jdDgdhxd5U60fU0cZYgcUYMcTjpmlyusmSuaLgib/LTwwcViCIxpSUAbEa7wquDWmoy37O701FJUYYnOOm+1WJtMwZCCDNV+pqfrHjnf0Zi/pcFnyR/oVaFdS6fFU+ffkRKE49Ju25jwywjVWgxwY1TB2hrPU53FS46cPtJelRNQJmmS1KK8kExwpE7aWIDaM3ugAGEWxHRn9xwyp55J1xNWKv2F1zZIjdL67Rd5ATCkhvmQ6Ld5klvHYiTYvrcWRlJPefIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feOvbk+agkvUU8T1Dt7PyxdLBf3eIrY8RJ2uuZUk8FQ=;
 b=UzC79Hj00QpzXeWfK5a41lsv7d8XurcoTXjM53remge5MdlRfY2mdm80vcdo664OvZeRCirlMHrZMfPMdTZ0kJOXFIiyHWX/5kPq5X5hicl1W8gIxEpfKI+GWdOIWjEvJMT5mtFxro2lfyvvj4Y3BAcCaJPhL8DWzzE8Kk2GaHI=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 12 Aug
 2021 23:33:04 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::a136:f190:7e89:d7c]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::a136:f190:7e89:d7c%3]) with mapi id 15.20.4415.014; Thu, 12 Aug 2021
 23:33:04 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] irdma: Add ice and irdma to kernel-boot rules
Thread-Topic: [PATCH] irdma: Add ice and irdma to kernel-boot rules
Thread-Index: AQHXiuy2O6WjqvACUkanT+uendkIz6tmy/YAgAnA3AA=
Date:   Thu, 12 Aug 2021 23:33:04 +0000
Message-ID: <DM6PR11MB4692C424F3B5AB513B0EBBDACBF99@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210806175808.1463-1-tatyana.e.nikolova@intel.com>
 <20210806182852.GS1721383@nvidia.com>
In-Reply-To: <20210806182852.GS1721383@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 32edd4fd-289c-432a-75c8-08d95de98815
x-ms-traffictypediagnostic: DM6PR11MB4642:
x-microsoft-antispam-prvs: <DM6PR11MB464224482768E032E2C03DE6CBF99@DM6PR11MB4642.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0gdPzX92rYKdzEHf0nGSYKwjYv0SRsMZGH74W0FDuwlCMSF1XE7hUnHq66hKulPzAGU5sddQyDcIpfu0kuZOcj4iEyT920a1OgSFumZLzZMNiELJxWwrHevYxlkLUPG46HsD/xbt7jfU/hN7U5O/aObKP/wresV6xiUfOvOAKl8kLJAZi3i7a5e+svvFoA9mj+J8MwTnMGhSwF7Pz1ysg87KoZ32H7dAkUZ03XN7VXFuSXr8z70VVfDYrA1KQl+dqpdksRtDI3G0Q8Z+wimv2VKAFY/ebdgwK0maNlyHCPkffmfmIoUzaS5o2JNk3gYSTU73BM2vbQ8xVxrlp3D+BldtW/3hlF4LbJLO9e2FvvwzXfkbKsSqBcHUspOLXHFVkDU8qaWArT1DH8UM8dHkfhOvDs82B9AUpwoEtOfp879UL5BkkpVA4Dov4lA6+0oY2X+5xOw2ucaT42cddCF5rLimQNvaLB61GY9ZqtYJz/mkkMkTW/egE8ZW6XXd6KbQv16TVDII9Oy5U4Gx08de2IuAYB5wQwY0NtgBMcrH/vbz+ttSpfGuGvXSOb7AbJsLqh1lDJcTdDFd8tcOJHVW5iZmU22I2ReINpZCdB0Y/2HYiI9rUkQ2fUwyW7/RH8V2swsSPhBLYqU7bZ2KCR6/yOIJH5/MSBMQc+5GojSw9oVqX0jcqEHxhTwH84iT012sWs8Gb65MMGRb2dMmImze6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(71200400001)(86362001)(122000001)(66476007)(4326008)(2906002)(186003)(66946007)(53546011)(6506007)(8936002)(6916009)(66556008)(478600001)(64756008)(7696005)(8676002)(76116006)(26005)(66446008)(5660300002)(33656002)(38070700005)(316002)(52536014)(55016002)(83380400001)(9686003)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r2C36aTrwQxUgSGx377sx639CI1zuEHYmri1J46ma40AXAh6JnAUTGf9gezu?=
 =?us-ascii?Q?i4Ql7SmrPybqr2y2ePi3oH/+eGJGyOrY6WYAbJn5e4MNbNCPtC5N0k5iFtqE?=
 =?us-ascii?Q?7tC07ZC2x+euHYZoNsHv5MUXjac3pMorLHO5KTO0pKPmmEOdhNp8XsBdU6rW?=
 =?us-ascii?Q?LhUmL/qn+aezvGCAOLkZBIA4abyi4plCwhLqVJrY2j+c5TpDeg+J9/QurpoL?=
 =?us-ascii?Q?zhSf8c8J585QSvk1BhwZQeUQjAjniM8scFAWqtWURnIYPHMmogvurwzB5wig?=
 =?us-ascii?Q?Le39dh7Yw2kVJ0VLLIov7LqvnaUei5TSJ7W0Fgc1Il5fxpLhoCzaqpMHxFq5?=
 =?us-ascii?Q?SrGRZNZgEiyirhB2P6G5tYxfyH+7ZbxDfsDTkkadpZ9AF3UFtbWZfHqL+15Q?=
 =?us-ascii?Q?2OAqJueN2SqGtGkYZzONiAreLsunIGoQgaGUzmxOaFM+T+7JTdhdvE1nrYqe?=
 =?us-ascii?Q?Chg5cZ/VieUyIJKuelAC4UTWlLH0VCnIsQP2Agm055UkI8mQHanRymUUOwjS?=
 =?us-ascii?Q?LoVD0hGq24lb5TXRUAnM8TJvLGeeFrXK1WL3wTbhao1g3n0LvIkqXHoYDfv+?=
 =?us-ascii?Q?fKwKosvWUBI6VMbLLhZ9MLXBNxTzAhcUa68B+wdmPgVgUr129xKorIH6/Quo?=
 =?us-ascii?Q?uLQl9F/OdQTxkcw7wP/I/EZuaxZezq3beRLMJnxSPWy3jzhDbR3BkX78jfzl?=
 =?us-ascii?Q?THSRRI7sHUDtBOBaGqdPP4mfirpdXV0EwgrJeTMXLXcdHvBmDOu/dOY+tkiy?=
 =?us-ascii?Q?5sWL8VoaJrfwdK7hpFtoWORceND+FkbhDDNDs0jdE5G5OjQfbJeZ7/J5UQob?=
 =?us-ascii?Q?UeKSjjlFLQkdxdAmxeGGF0LDxqkbgGcZ073X9cGmqEuo4+UIjgfdnLRon6HP?=
 =?us-ascii?Q?8w60Rr9nmUyJfi4OZbLcH9kSzlEaVoOdb/m77VxeBcJPWXEa1Sx5Ez/vdLeV?=
 =?us-ascii?Q?pNnMR89fLOglX0n9iUVw63Tu6GYqtXWqtySzsnjZGfvNDKCdW/LLvA9Qgu4p?=
 =?us-ascii?Q?XrNNoSGWNBJmOhWohMjqXW9Gn46K+aaV7ikCLqPxaoZx1zUCbkVjGalxg65t?=
 =?us-ascii?Q?G3r8Ptw2GXGeSYGnHoMf/D5YnDYoehX9/9llyfE5rdo+Yk9ysUXEVtrHuf79?=
 =?us-ascii?Q?r3njT1oDPx8A3nhuV+4O5XrWo1fKM6vhK8CP1os/VqNay1xfawHgZmwpnbRt?=
 =?us-ascii?Q?usSV3T3HFxfY+AcBWfD2IFJYgZPlC9G86/Kvbeod/6FjZk1u4NgCvoLCL7bp?=
 =?us-ascii?Q?eLKbSZmXa0YD0NXKeB5Lmec9IHWib14VRtnE8043Nsj6Uw1DXYULTsJOGY5a?=
 =?us-ascii?Q?ASM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32edd4fd-289c-432a-75c8-08d95de98815
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 23:33:04.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3Cp5ALFJmVzRWgbwaKVXLPml/Mvz/5JfRm4vQGt8cEskjnDrrmMciuNRVBgdecUxr6dXfxpRM73n3hIApNWjYnjss3zkJ1FQoD5gfJ9t0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, August 6, 2021 1:29 PM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> Subject: Re: [PATCH] irdma: Add ice and irdma to kernel-boot rules
>=20
> On Fri, Aug 06, 2021 at 12:58:08PM -0500, Tatyana Nikolova wrote:
> > Add ice and irdma to kernel-boot rules so that these devices are
> > recognized as iWARP and RoCE capable.
> >
> > Otherwise the port mapper service which is only relevant for iWARP
> > devices may not start automatically after boot.
> >
> > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > kernel-boot/rdma-description.rules | 2 ++
> > kernel-boot/rdma-hw-modules.rules  | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/kernel-boot/rdma-description.rules
> > b/kernel-boot/rdma-description.rules
> > index 48a7ced..f2f7b38 100644
> > +++ b/kernel-boot/rdma-description.rules
> > @@ -24,11 +24,13 @@ DRIVERS=3D=3D"hfi1", ENV{ID_RDMA_OPA}=3D"1"
> >  # Hardware that supports iWarp
> >  DRIVERS=3D=3D"cxgb4", ENV{ID_RDMA_IWARP}=3D"1"
> >  DRIVERS=3D=3D"i40e", ENV{ID_RDMA_IWARP}=3D"1"
> > +DRIVERS=3D=3D"ice", ENV{ID_RDMA_IWARP}=3D"1"
> >
> >  # Hardware that supports RoCE
> >  DRIVERS=3D=3D"be2net", ENV{ID_RDMA_ROCE}=3D"1"
> >  DRIVERS=3D=3D"bnxt_en", ENV{ID_RDMA_ROCE}=3D"1"
> >  DRIVERS=3D=3D"hns", ENV{ID_RDMA_ROCE}=3D"1"
> > +DRIVERS=3D=3D"ice", ENV{ID_RDMA_ROCE}=3D"1"
> >  DRIVERS=3D=3D"mlx4_core", ENV{ID_RDMA_ROCE}=3D"1"
> >  DRIVERS=3D=3D"mlx5_core", ENV{ID_RDMA_ROCE}=3D"1"
> >  DRIVERS=3D=3D"qede", ENV{ID_RDMA_ROCE}=3D"1"
> > diff --git a/kernel-boot/rdma-hw-modules.rules
> > b/kernel-boot/rdma-hw-modules.rules
> > index 95eaf72..040deb3 100644
> > +++ b/kernel-boot/rdma-hw-modules.rules
> > @@ -12,6 +12,7 @@ ENV{ID_NET_DRIVER}=3D=3D"bnxt_en",
> RUN{builtin}+=3D"kmod load bnxt_re"
> >  ENV{ID_NET_DRIVER}=3D=3D"cxgb4", RUN{builtin}+=3D"kmod load iw_cxgb4"
> >  ENV{ID_NET_DRIVER}=3D=3D"hns", RUN{builtin}+=3D"kmod load hns_roce"
> >  ENV{ID_NET_DRIVER}=3D=3D"i40e", RUN{builtin}+=3D"kmod load i40iw"
> > +ENV{ID_NET_DRIVER}=3D=3D"ice", RUN{builtin}+=3D"kmod load irdma"
>=20
> This should not be needed, right? The auxbux stuff triggers proper module
> autoloading?

Hi Jason,

Our module depends on the auxbus, but we don't know how the auxbus could tr=
igger loading of irdma. Could you please explain?=20
=20
Thank you,
Tatyana
