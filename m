Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB4E3B1076
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 01:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhFVXUW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 19:20:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:16444 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhFVXUW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 19:20:22 -0400
IronPort-SDR: Rvo/okpywQGIHOJz/8S9O4YF9YyIp1jN3+G7wyieJv3S/RG6zLRk+LNxqiA5BqV+zJBa1pYHVy
 aG+xrwgO6WKQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194299142"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="194299142"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 16:17:58 -0700
IronPort-SDR: JsRS5mvjKrM10SJRGS4DhZyP19aysM5yZltjBH2TsrQ1XB53L0Jg7/FQr4mP+JNde+euFRPWva
 VMmWRq+bWxyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="480961224"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2021 16:17:57 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 16:17:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 22 Jun 2021 16:17:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 22 Jun 2021 16:17:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz0DzH4bajS2IwkgxMWnVchYbPAqU7KhYImqhRYBEhDApdxhCLaxh0WOoAyUa2F+ZUPEf4wxpqZjjdSMCRR3n+lBd2Nfrg57kC7/WLt9DdvxattvwX/nhOp3BqAkbGY0Q1JrRBW+4AXAPKCzi8NN+K4xiOXIKnUgck+JypdzBE1d8NvENmOVJB0tiXL5wLl++XMMiNWTwemNZq5QbZjqoXBnZdYB5CFXMMGfq600H/O252FqueGtU4x6u40g7RaFfhU865fLraBKS8enf0BsykPWzbZIHGoLhI6V+SEEJxEuxkJPCZdD4lERNIJ0pAJKAM+cDGZA4PRmGm2q4fRpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zQXr7ERBxwTdDqo6oNTZC/9Eo4EGkicKKHGEcQY7yQ=;
 b=GwLsR2vnoe068nDM+GwxEadYwKqGkoadFqS5lVZ8rvGCoOs19P6vbtLFhXqpodxDa+SGrX4hjbc3De3hcYbwfW04E88ewLxpPdDCPyi1tTlgXyg/NabuPIj7R/VwAFKiPxekc93dDG/ZHKoAGCy7YAu/00zAP/D4oN2u1dn+0iM3NmCphTmiPdpGowyQ1K6q9pCW8eemVa0au+h/V0b0lAkFmcUpbLvkXUcr3z7iZrthZFq/aASJCfFKXsRRzR0rOdVMZS96QB8WngKeujOqKFeG+94qPVnuW4fqKh4UMiSKyJMyB3sTnSbI1zAAsL3c2N6IIRw8jIC2rY7fVUVEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zQXr7ERBxwTdDqo6oNTZC/9Eo4EGkicKKHGEcQY7yQ=;
 b=aoDMXEUEuNAmjISNrWeTiHSVJ7StNwi8WmYF26y/Z2sg3+LE3H+vBDkvsz5vrx+vHS5CJ3OLwF+3uf4Mntd993IDYpMo/YEEENOKMFnTMA0UuqQ5NT1gFNnptSTC5eUlcJ47UbI3yfn4O9NWT30Y+B40p0zWW7LidcDFCEmzHog=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB4625.namprd11.prod.outlook.com (2603:10b6:5:2a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 23:17:55 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::dd75:a3f0:5ec3:f7e7]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::dd75:a3f0:5ec3:f7e7%8]) with mapi id 15.20.4242.024; Tue, 22 Jun 2021
 23:17:55 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
Subject: RE: [PATCH for-next] RDMA/irdma: Use the queried port attributes
Thread-Topic: [PATCH for-next] RDMA/irdma: Use the queried port attributes
Thread-Index: AQHXZhEKBZ37+XWiOkaxufX9yiT8qqsgrJCw
Date:   Tue, 22 Jun 2021 23:17:55 +0000
Message-ID: <DM6PR11MB469296060D6ADE9834F77C19CB099@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210620201503.67055-1-kamalheib1@gmail.com>
In-Reply-To: <20210620201503.67055-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [136.49.218.139]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b543ada1-b17a-4c33-8fa8-08d935d3f781
x-ms-traffictypediagnostic: DM6PR11MB4625:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB46250E97C8640E68C7ACDB77CB099@DM6PR11MB4625.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVzWr2n0N/XIjG0rPaj4zdFGkjL2MpQ67lqK555lyQW1vnv9tDP29Pykaf0PtdaStelvaHBox1f7cBpmsOedCSGD20S7USWz7gKal61yDXIj3dzJzWkN+O/KyG0FrTEzrATK10dMF0mhmC6DqsMK9qT11Qb5m9XtfrX3MupQYcv+oCfnXUDMKW9rCxTucR53tQVcyDBbST08qAkrAlKuXDTd1csoEONoD9UngCy4QjNk2PT6zQ2tHCAB+VJr4LS1lmPF95UacyAbK3KSHemj/73Hq9LXlfubxYNEumOhn/DJuYFf96E5T3bF5VZKYSF/TF42qPw7yvvP1nxrjrKZYIhgV6jhhSs7HOrvzMq1qNJV0iyunXXTSUwHeZJQO3Za33stiLqOR0YxpMBedvsD18PzsjLuMuWkp1LpJjMjmbptTTs6DNZIdDmhUnPmg/kp6fKmGrpG48RmQYthJZyCnpHuk06ZCgFAlnPJf0HRHn1/00mZDum5Db8gDBoLRpa3rUdCbRH8enXdGThkYWxc+kbXOmYHv6UqaHi6FpSmTTWgZPXIF0dCkvn7Vj4E277EtvXF0i1Z55k+oVbp/+SVxJMt5Ps3Rtxhi2OR6dXslpup+lISnxfKnTmm0qsqRQCq+DnxOzQWsFABAKq2gF484w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(396003)(39860400002)(478600001)(86362001)(26005)(55016002)(33656002)(8676002)(71200400001)(9686003)(54906003)(5660300002)(38100700002)(4326008)(83380400001)(64756008)(8936002)(7696005)(52536014)(122000001)(6506007)(53546011)(186003)(110136005)(66476007)(2906002)(66556008)(66446008)(66946007)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ruKcyWptTNKsV9z/Ikjn3CSoPhaQ+u86m9nnqLR2GapYiT+PIToNNNSDJyDX?=
 =?us-ascii?Q?GB1Vg/ntj2w8Kbt/xiT3UQfighEADbCgjSkBzLuuQhesEB24+Gyzvv9NWW8/?=
 =?us-ascii?Q?ZywjAiSybuZOQVVIwSInxb50O1ZY2w9J8FUq5FNKON3UQNS0HdsAKM2HtDC6?=
 =?us-ascii?Q?BIvh0fwZqJwS3KRm/QkqkLsenmg0PSucolojdATUX5pNpEi5qEUrVXJQAuf3?=
 =?us-ascii?Q?S5LfBUNkQT8MO8N8BL9/oFdtlFamP/6t4rBhGq8uLbpY0L9SjCnM7OLJXDO1?=
 =?us-ascii?Q?KlCmzd7vYaY80DATOkJA/nQwl7uA+R0YbJMIs/SxsaTln/tltNutQhnKy0nL?=
 =?us-ascii?Q?0nitj1VN+u5cRTSko4etwN4WEzvZZJxPIYqfRLi+Ahon9P5N7u4wTdOjsMKq?=
 =?us-ascii?Q?vak18vnTrzpx4+FO5NgdJ8aBvz7TehgA+EJMbCAIYMUO8NLapizELy8nbSot?=
 =?us-ascii?Q?NZ4GTBInfoBxg/TSepcRW4CCMVQ9RlguVegQ0bJtJwVm1tXcsyXkX0EFf2zN?=
 =?us-ascii?Q?nBPCgAQ1OLsDxP9dONPJgaT7JJr8lznvbBI9HB2VKCGYYBUVeu46S/A9NgSh?=
 =?us-ascii?Q?a3vlzxyGGO4/glyC74N+2OSzuOjPwOEujaBT0s3Qo3PxNZR9VrmM729CoRor?=
 =?us-ascii?Q?8+eJJgnFRR8bAPbXGcT5OUSw9hdsj40po3m+zziLjpJhoe8GmMiX3yATe8cu?=
 =?us-ascii?Q?hWiv6eEvbhltmty49BUoxgaw9IrL3/GDLhrBibX4iZe7tARmm9aaZ0A9uTvD?=
 =?us-ascii?Q?FcAdloBbK5qBfmAn8sMMnCS/Ar/QMeBR2kCZ3jR5WQznGaJTJ2R5bjsQSvm5?=
 =?us-ascii?Q?lIdqTKJuyid7P6aCBLByPOmjLbJ5IgQsg1QpIxPPjGpe5a2zECmDBB92ZBfN?=
 =?us-ascii?Q?Y22HuQHgJ3YA0HkBkOo2ssI7DaTREF2DR0qh7/RMlThMK/xJ5PA8cM2x9IpX?=
 =?us-ascii?Q?ToicqywrUhyeKU3HRBjRKIMH0VjEQG8pf//I6PbEk2QmdbM/YM+pGExEVH7b?=
 =?us-ascii?Q?TBdwC1ke1dWZlAfsUwQ/5U/rkY0+xXzSYXx+xUonJLvRdIcWhN8T64gKorlD?=
 =?us-ascii?Q?/miN0NCq6iO10gf85ORpzUx4Vhav7kYQkhhnyXYXvxEBuONUo5XnuVSEQZtp?=
 =?us-ascii?Q?Pa4icxBaGAFBzprY7QW6gVAW2vatlkuSrbhklI+kboA7pNFhpnsAjQJXeH2o?=
 =?us-ascii?Q?cvNl8bYGADXMWB9V7yYd/GPFEg5RCx74pjzfMJug8WeZZc0jLFhYkik+0dgr?=
 =?us-ascii?Q?MV6Qnky2/klmSdRnRImgDgz+9C6esk9y6YbENgU76A0lx34qfVyzp8UTlk0e?=
 =?us-ascii?Q?XR2DG90/ApuqGor+sP5Z/XKE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b543ada1-b17a-4c33-8fa8-08d935d3f781
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 23:17:55.5156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: he4Jf6gJZdjgmjp0LDw9BcpWj1ZYSaRZJejz/AtZ6sXAppnqPbLJ7Dmf10xd9V8mXBzFMvUgpFjRBraz9Idzq4KrS3gX3n08CUNzCiS8w6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4625
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Sunday, June 20, 2021 3:15 PM
> To: linux-rdma@vger.kernel.org
> Cc: Ismail, Mustafa <mustafa.ismail@intel.com>; Saleem, Shiraz
> <shiraz.saleem@intel.com>; Doug Ledford <dledford@redhat.com>; Jason
> Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> Subject: [PATCH for-next] RDMA/irdma: Use the queried port attributes
>=20
> Instead of hard code the gid_table_len value, use the value from the
> ib_query_port() attributes.
>=20
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb
> APIs")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c
> b/drivers/infiniband/hw/irdma/verbs.c
> index e8b170f0d997..5ae5dbcbc3a5 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -3627,7 +3627,7 @@ static int irdma_iw_port_immutable(struct
> ib_device *ibdev, u32 port_num,
>  	err =3D ib_query_port(ibdev, port_num, &attr);
>  	if (err)
>  		return err;
> -	immutable->gid_tbl_len =3D 1;
> +	immutable->gid_tbl_len =3D attr.gid_tbl_len;
>=20
>  	return 0;
>  }
> --
> 2.31.1

Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>


