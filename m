Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE243586BE
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhDHOQx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 10:16:53 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:9923 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231921AbhDHOQk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 10:16:40 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138E6rpo031852;
        Thu, 8 Apr 2021 07:16:19 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by mx0a-0016f401.pphosted.com with ESMTP id 37shqxkdyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 07:16:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/ajOMmcf4oq3wCYKxxmsyLDT9MWjjpPPx98zVViZycpDd3FPrMzIhV/qUtxtno8PUl+IgJkUOj0z5isG19AVUrYI3GKyC4+Qh3wVtq3SU/pEw21hNlIJwkIbIdgUTS4l7pSuzmlX/eCz6Dn8OocuMKMfFJ9/5UT7YaNref0zmWWhHCzV6vB0WSkJ3TY28lzkFqJx+Gw15ID0zv0Mch4JPf58VXruS4FNUKjmGLMOHr8bu+XjQVqpIXWXsVsn8xUPDbexMDFXq0l90CGNz4ewum0+3IeljCcwibsHQx9A2vbJqi1LSpXftmFbedShkruE9NrsKxjmHxN2JZiVP415A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWW6XiuBunEq2GOFuyWmq2Hl/6hgXGEfPPXyFXPM3aQ=;
 b=J9mILSoxSK9zsTSz3KBiMbRahbrm35xAQH86DWNI5abR8EAo+C8+GTg3om5kRRrBAePlLRRWu6BSfRm09HHAnJ2RwRBnxVPqYM0/2HM9kq5t0BH7WQmeWh5d8iejEjipyAQn/LNmzE6+v0wED7upe2zk/RGpLbW49L/ANx/LtTKqIDOKDCWzXcl6gkC04TGOPLddwAJ6fPsxjCj7QOd0MKqP5yXN9Es3aUL2WKnLRIIQ67QFpB7YOfY9wfkpL1mfRLovJ/6+HZdbU3IetDvlcoxvMmEe4147XgkeM+4cMnhLWlve6M7robfVfCfWq3zTRNjHa0tW1wnMzHQSj3QjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWW6XiuBunEq2GOFuyWmq2Hl/6hgXGEfPPXyFXPM3aQ=;
 b=Uy8SzrzZbK2lX64oDHIif/dbsWLySU9qLU6Xi/r+tvv2JRyN2IvBdlXQJKvbiADDzT3duSZyjiCLFIM9s2GcYsGuWUKnV9gu2jHmg+dVjGv8jBi4qVVsxbP3XgJLvLiFBVBB68aL37csgf/Sox5loZXUIwZYN8CEB0lJduNu8Ys=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by MN2PR18MB3493.namprd18.prod.outlook.com (2603:10b6:208:267::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 14:16:17 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::44d9:1b4a:df4a:7c5f]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::44d9:1b4a:df4a:7c5f%3]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 14:16:17 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Wang Wensheng <wangwensheng4@huawei.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "rui.xiang@huawei.com" <rui.xiang@huawei.com>
Subject: RE: [PATCH -next] RDMA/qedr: Fix error return code in
 qedr_iw_connect()
Thread-Topic: [PATCH -next] RDMA/qedr: Fix error return code in
 qedr_iw_connect()
Thread-Index: AQHXLGspSF2afC7wvUK5itgV43n7+Kqqqnxg
Date:   Thu, 8 Apr 2021 14:16:16 +0000
Message-ID: <MN2PR18MB3182F093EC99B0B676CDC677A1749@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20210408113135.92165-1-wangwensheng4@huawei.com>
In-Reply-To: <20210408113135.92165-1-wangwensheng4@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [93.173.219.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19b42242-401e-480e-f4db-08d8fa98dfde
x-ms-traffictypediagnostic: MN2PR18MB3493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3493EF63C6945D1C4EBB5CAFA1749@MN2PR18MB3493.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLofuaJETFTnSL5b09YEJq9A/2fAfhc92KrAC4g/b59AEPW86MMFKQNJhvWmUcsHxaZyfCAufYdBVFhitw5jygJLfOnO/KDpzdvZ88/5gzFyAFqIg/1YaJADytDG7gDtDk1wzWFRXU2+F6r3Oddb478tu2PIUw+0nka9tyV3j0o8+1bw+3I9UYumby+LLy5Vo2x7paZurjZ7DF+MmCuEoqJ2jOj9ioErELYGz0leibx6ou0o8uXVzzjkJH49CvYv1MzgJORlP7b41l11C0rZCL+amvJr8g1gZsE2GMeBtthY9DDfp5tkBBWU4uh2GpSYmMshnib5H+UhvW8OShV/1Geja7M0GyF+vuzybfxTE6qNazsZGc+QV/LMj34XpxQO+KeuCBcGg1MM06uWYu6eDeMU4zCIBORDWshehxJXDhw8W/tnCmGS266gqyRvqClpHncfdHtiqpKjW8fRyEt2FDS75bqORu3RW5yjP5m2mKcjhjWTM/QqGaV2rugM9xIh7d7b/X6pS9+0Z9pRSsPyys3wyQYOidbq/nLnXKKvabJ49MhKd1URrcNtpIJp1+VrRfZE+n4/OPZYeHIDLjFa65CpOqLp1JgE7zWd2DU4Z+gtNBFhw+bmm4i7+yNorMR5lCKpnwA6py45hn9DCezcTmL0OOtfZx9SCVxNlNQjceA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(478600001)(186003)(7696005)(86362001)(66946007)(9686003)(64756008)(66476007)(76116006)(66446008)(38100700001)(2906002)(71200400001)(66556008)(83380400001)(52536014)(8936002)(55016002)(316002)(33656002)(6506007)(8676002)(26005)(4326008)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?V++7Y+H5LXySZcxrAqWXup/t+8W58AZ+Ad7/wS49iI4sJ7Q/auBnlAdiV4?=
 =?iso-8859-1?Q?Ly0HMQeietccL3VVrAJdcVoIS88gIgu+VLCsTMRwpVl6d5lmb9wYAiw/T6?=
 =?iso-8859-1?Q?uwaL9S/xf8DYdmL+8GwlueFO3UUt6Niwugxro4JjodeW4E5cMwBkWnKndF?=
 =?iso-8859-1?Q?aOgTnGJoHorpGZ4qex2s+zbeZyu3qIU5NjqhfrksVGW48Rq2zXZRnEKnsx?=
 =?iso-8859-1?Q?LkC9th+E4qrPcc9oWPIn+1FFc2SJM6dKcaYYQqn6PhVuVPlVeA9iFf8xr8?=
 =?iso-8859-1?Q?9GA0rbYzQErmRRVh/rYdbtM2osnN5uvFV8S8VU96k28IL5wf+5vPKO2dby?=
 =?iso-8859-1?Q?FfwkpdlopTycPh3WAphn3oFX5luTqeaLIpp82lV5g4uLEdxtXXHZjwBbAo?=
 =?iso-8859-1?Q?axWT87DNhNX3Dw6Fi+3ihREIpVwa7VoZID7zqz4BSJIjf9WmIeHWIiq/JE?=
 =?iso-8859-1?Q?lH4ZWCDNQk70B7wEyNmpbGwGfEyElooEE/fQyrqMi6e4ZdoKXrVSaqqKBX?=
 =?iso-8859-1?Q?IgZB76Dhk4rxnXVDnj05X8D/UtY9xPdoeaTJ8EPBSRd68SxkJ+cw0Uc7rC?=
 =?iso-8859-1?Q?RRIip2hw3cGz/ALdGZKwQcBLJypCLDNfnW87bJV/d+dpAfnOnN2MmB1T0j?=
 =?iso-8859-1?Q?Kx2rX2FNOmLQEDAYZRrgeRcDB5yvxxBl0Ywit34VF2PqGAj98wUFWJHTaZ?=
 =?iso-8859-1?Q?ZZ3qMUvIVaqsWOIiYIFn0r8nzE+p5hLIfTL0MEI4PW97Jilnca+Mrqji6m?=
 =?iso-8859-1?Q?qRz3FQUm5Wo9P2qJ6JjGUV78tpKb20WEEoyduw0EFJHbc8P4cgIdHW7WGH?=
 =?iso-8859-1?Q?zOQOIl3j7Z6lB1/T9xBSbZRDaG7/nhGvuE1N3SkbhuWp+T7Yrfqyvc1IDp?=
 =?iso-8859-1?Q?OAOWu5plPMc00Xj3xe7+qg5tyfwi3l1xCD5Pt2EykO+c1NcMVxPsMQ+I6A?=
 =?iso-8859-1?Q?oI6jg6A6zy1JWuEDcsPzPulkD4qyKOAj4fy0drrgFKMbbLH33wzAzDZaym?=
 =?iso-8859-1?Q?Oac3xIsEh959pxhD+NyvA/gG+EAy1aRRia3r76zhzvxhWHucC81UUV4+xK?=
 =?iso-8859-1?Q?Sf1AfQxg9L8vnSrwO0LWHPIWLooiAcT7bettbkl8SsistU2cAkzN86rNEA?=
 =?iso-8859-1?Q?slkqaXRweJ+1EQcLGPggw39Pcm46EgDWrFJRMM4mBSGLFhT+TTL7UVc3KL?=
 =?iso-8859-1?Q?jlmFpKEZYFcoUj7Kc68NzmmZfJv87KnyCA3Kb3CuUKqUZIMYMQawPYZVW3?=
 =?iso-8859-1?Q?DnbgOKhIueAaG/grMx05/KN6wjGej5Q3R8PacEp4vH/lqHmxXuCg2wu2E5?=
 =?iso-8859-1?Q?gE8XNsIdpr69K1PV5YnaWKdxFTRujGydRdt6mu5k2+naJ1zxuGWLgbPtAg?=
 =?iso-8859-1?Q?O2LNQLfHdJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b42242-401e-480e-f4db-08d8fa98dfde
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 14:16:16.9299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVScd9zFCm/iYTRXhHe3RVv3s6QLi+6GTsZm3wc0TT9sm7wO1SRaWrKGazEAI0DvcAPGFBJfcDGcOQvdm66ihg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3493
X-Proofpoint-ORIG-GUID: tRHJDb0gvHdJ3sUJSlV-9EjoAPMi8hkc
X-Proofpoint-GUID: tRHJDb0gvHdJ3sUJSlV-9EjoAPMi8hkc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_03:2021-04-08,2021-04-08 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Wang Wensheng <wangwensheng4@huawei.com>
> Sent: Thursday, April 8, 2021 2:32 PM
>=20
> Fix to return a negative error code from the error handling case instead =
of 0,
> as done elsewhere in this function.
>=20
> Fixes: 82af6d19d8d9 ("RDMA/qedr: Fix synchronization methods and
> memory leaks in qedr")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> index c4bc587..1715fbe 100644
> --- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> @@ -636,8 +636,10 @@ int qedr_iw_connect(struct iw_cm_id *cm_id, struct
> iw_cm_conn_param *conn_param)
>  	memcpy(in_params.local_mac_addr, dev->ndev->dev_addr,
> ETH_ALEN);
>=20
>  	if (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_CONNECT,
> -			     &qp->iwarp_cm_flags))
> +			     &qp->iwarp_cm_flags)) {
> +		rc =3D -ENODEV;
>  		goto err; /* QP already being destroyed */
> +	}
>=20
>  	rc =3D dev->ops->iwarp_connect(dev->rdma_ctx, &in_params,
> &out_params);
>  	if (rc) {
> --
> 2.9.4

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


