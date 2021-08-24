Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF33F5816
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 08:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhHXGUX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 02:20:23 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:61544 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230038AbhHXGUW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Aug 2021 02:20:22 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O3rrkk021164;
        Mon, 23 Aug 2021 23:19:36 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-0016f401.pphosted.com with ESMTP id 3amfwj2bph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 23:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzjbHqlTYbFnpVjf6bGtXboIvOYB+ybU8I/ihCmNaGW/3fBwqQ7kV3vrbBNiHRMilNq8UmEzX2g2mnRkUcJ5D6eqU/d5Bk72/UCQ0RPktap1aMG4OqwydyXIB2KQ/08wHUgsx5l1SKnbPFL09osdi9WghYa+kpE5KoIxXjfcbouQsfEwJDjd+38RBqcFd22p8WI6QhS13z0BSDg79AwcbVY51U/O+CP6yx++9mpOUHWkD90ZFgJMHKdk4ghJODqTtG122zHCwWsCFvQhLaarq0pQp9oLnqL1ge3tMaFkqGBQXL8ix7q67xHzYekAI5DwFkTRortvdUeXIw0cWqvAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2TrB4C9wz4jOM633qUFrzLxTZnHVmKX+N9uj/MxZcI=;
 b=eJn56HT8r3uU4svtKrJ9ZNkeAai25NrmTtoKmxgBmUo8ZJ6Urow/gREDRuLwz65ixMnLpP6SWe9urKK0AljN5TDuzdtxm26q1VTNTZm6GhK/xrejqExlJnJsqxs3rR1vQyXl0qWQ4AROqn+mL4o/jSRpLDn20fgiyDdvMz5j8gDqw6ThaQAJkBdZ1Z5XfLIM8YDACAzEG5OHD7vMg6m/3e1xzewjfsN65wNstMdD3wphKiX+4FvzT9cRwKRvn5fIWcTiV4hzFnP0U7nFZA43863XMtnr6tAe8fAX/Kf8f1oH7PN4FOcSwtS7juHGzu8cy8Ft5Acvq0rpzD2FRZ39dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2TrB4C9wz4jOM633qUFrzLxTZnHVmKX+N9uj/MxZcI=;
 b=KQbNezoe2MRnyeFhi9xo62sO9ByyBrt2gXB3ljbTLA6qgn4BlXGrAoNyEnvSYghYU03qQGgE4QIL2YttriXwtSQPxcy03zYDBc4KFxbAnzoQZ5LkY0y8P88IMivTA/LY8YVXf7T3UA+oqNal9xYxWpGX++CABkpNGtzkn8JypCk=
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com (2603:10b6:a03:2e4::9)
 by SJ0PR18MB4107.namprd18.prod.outlook.com (2603:10b6:a03:2e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 06:19:34 +0000
Received: from SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::b5c8:592e:d34d:5f6]) by SJ0PR18MB3900.namprd18.prod.outlook.com
 ([fe80::b5c8:592e:d34d:5f6%8]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 06:19:34 +0000
From:   Alok Prasad <palok@marvell.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Shai Malin <smalin@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [for-rc] RDMA/qedr: qedr crash while running rdma-tool.
Thread-Topic: [for-rc] RDMA/qedr: qedr crash while running rdma-tool.
Thread-Index: AQHXlmBGBRsMJ3OmxkGy5CMGsVVjGKt92iiAgART0wA=
Date:   Tue, 24 Aug 2021 06:19:34 +0000
Message-ID: <SJ0PR18MB390083F8ADF0036D6647F75DA1C59@SJ0PR18MB3900.namprd18.prod.outlook.com>
References: <20210821074339.16614-1-palok@marvell.com>
 <YSDpuTIsM2gL1h7e@unreal>
In-Reply-To: <YSDpuTIsM2gL1h7e@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d9212fd-2af7-443b-1f67-08d966c72492
x-ms-traffictypediagnostic: SJ0PR18MB4107:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR18MB4107CE6681701490FEADC523A1C59@SJ0PR18MB4107.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6y1W/UtCjHhxW2k6qbXjyxQS9F1U5NZjYuRfvuFGBKxw4bu8i4cc3ZS4Abahj8ne7Ln5mn7UrHBCSRYOd9M//5+Bw9gRNK6e9thtczbKs/QMtpWrAkyJQ+5fp48WEAtA/IvxiKggR1faTuD4evESwvwTYKsC/zYi8Jj1AhkTtF7SI5mRsix2a3lCt4HkowQI6141Y/CFY+/oXR2Y6Td2UNzyy+Um1KSK2s1MUndUMtjBDd0aoyFofoYg4CWxDYsvyB+TAFPdspEeD31hywX4RxsEPm9pmGfgWeNLlw5+8GPc2fN6IFpfcCGY2L+3Da1XHs6rucuxEcM04/JuXaHCxo/Sml1wRU1ei+mFPMr9KXlsJtC9AnZrv3lOJXjvbo2Y7htxXmTIsJjNnc1jnjOIU0QABv6zoQ5NJQn1l0qN43siSRtVJlxdNdKizKHQcOz7zxYa4HindqvaCs+8qxGTB1AO0Xl91RozxZLsFHeaoRSqZczEFbLDZlY8ZZHWoop8Ja4qSV65emUnaHYYxQVfn2ESSUHeMM5CiogAq26tpmiENP9ne0xrMEpozufGgmyWj2DIMICpt8gjC6x764c9/NVYnGcENJnn/aP4gx8seUrgK4m0hRRbDAZzzgA2jKyYsxKEN5OeH/LgMDS5Nm6J5K6UgMuX5w4fqR9kBAyPSkLV6JIu/B/Zj9nOh4U6Afzq3sxdVY/b6A8UztzpcqbHJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3900.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(6916009)(26005)(478600001)(7696005)(33656002)(316002)(54906003)(107886003)(83380400001)(76116006)(66476007)(52536014)(5660300002)(6506007)(38070700005)(66556008)(64756008)(186003)(55016002)(8936002)(66946007)(71200400001)(86362001)(9686003)(4326008)(38100700002)(122000001)(2906002)(66446008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QKkwgc2zFXRE2dSo2dORVWaEVoAiD3gYCZVP1oSoIY3YOfVDIVTDp+AElcqP?=
 =?us-ascii?Q?E5HTJlYQUHfGuPdBXG9lJ0lRyggMj8GUkHFewD5cCmzEbWzRWxYg17QVGrlu?=
 =?us-ascii?Q?fHBDbDmu8GsjCsYexPIjDaUQAklZX+diN0n7xieAWaEXZSRm+WQlcrt7YI8y?=
 =?us-ascii?Q?3WzmbMRo2fhUm1xthvzGHiz1gbK7XA/quE5dp6h1Wb0gzVwKUmBWYB8F/2kN?=
 =?us-ascii?Q?IXgRw56J/0DV/443BESv6UYjKi3cWWGaFdp5P+4Tvz5Ey8KzQnnWL4y1vPU3?=
 =?us-ascii?Q?dOFB3LXZpPfbkJq8kxqHBj0vamaW5adj23ndLaTVh10ftQelHUH45GFe3wcE?=
 =?us-ascii?Q?Q1qddt4Wk51voh2k8UkSyPU5wStJ+4SpCh4nPa1E50yUFV+IwSPlizqWZeNf?=
 =?us-ascii?Q?UmCIys5QB0gi6643sgU1MQpUF+x5Jec2qTyUBJ+ZJBBaYKha+J+ViTAAB74A?=
 =?us-ascii?Q?Day00+1mJfnZtuFXE0KYJVbZ+YMYcyUOfR214FgQ1x/XsIpUeIt2eUr3iKtj?=
 =?us-ascii?Q?yDDWiIcmOkyI9sSUtxNumbLKXqFkE1tibbE6UT09XuiN1iCEC9pdSpgc11ho?=
 =?us-ascii?Q?Ql75OshDIItQ1WIEHlXt8bM0AJuLV/ws9Ai/DmobZhSARIEkTFMNEaiWFJ5t?=
 =?us-ascii?Q?NZzekLI6CSEFwgeTUsorY6yw+4fTPOkWtAkSbY4RP+4VV5DiPiKKnOj65sBh?=
 =?us-ascii?Q?mJqagYkSJyHwlvhupvGqeXkwSzSjpweHC5RzE0LHe94ptLpS8Thdbgbp0vb6?=
 =?us-ascii?Q?LG1qwlbKljkpKE8AjsaiuAc8kgiuc37sPxTDQCwwzzYssVpjRTo6kr7il5+P?=
 =?us-ascii?Q?eh1BOMoD5vvYIuamGc2qhQ23GIWtVHCdnkHAh/bUbx24xD63sLoATmopMIK9?=
 =?us-ascii?Q?ksl9KYxpUtgcUsMhEAmPybtWk/YuSrkgrVSQEKrFH0JHs6WMX8bdRl+azq+b?=
 =?us-ascii?Q?SuyhyOF2ytRg+wiHg3PoRVWgcA5O/6ItMqGEL6mkmfp+mw7UPK/l/CSDvSsB?=
 =?us-ascii?Q?AP6BuXEf8yEBgyNIWMnZPkjWTrj/0Ebig4NMaPtD9jUIoU/YE3vTMcEDf9ze?=
 =?us-ascii?Q?pQtPcJ30SfarC8TPWT9AFWsD2Hd8+y125ArMvvvll7FCB6yPdmcYNu4MZ7iy?=
 =?us-ascii?Q?fAs9E7mIxoM9wdFrYO1t8DMIEQczm8XHbRZ5BE7hXMoVTY75uALoUtmKYmJ2?=
 =?us-ascii?Q?DEpBkj/gOfhsfL1+RS6e8gCsSJ5vAG0HBlArJJvVHytHw++iiFOiJ/+sk27C?=
 =?us-ascii?Q?2OZ2eulHC3OM9NrVFsOd2RFTasTgyBr8XJkAEjuGDUstdWWmYfMM0S8AeGKw?=
 =?us-ascii?Q?tUeEb73v2W1UwFsMh/jndD9A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3900.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9212fd-2af7-443b-1f67-08d966c72492
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 06:19:34.5427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgOaoHo5PMXK9C9ipuWDkopr7rYb+6lejbl5es8pyjf+4bpNU8Wz/iJf4LAnX8aixEO1qzuOkFB5njEwlZKLYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4107
X-Proofpoint-ORIG-GUID: zqSyzYANRdPiBS1RqSX156tkMMTjvody
X-Proofpoint-GUID: zqSyzYANRdPiBS1RqSX156tkMMTjvody
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-24_01,2021-08-23_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

> On Sat, Aug 21, 2021 at 07:43:39AM +0000, Alok Prasad wrote:
> > This patch fixes crash caused by querying qp.
> > This is due the fact that when no traffic is running,
> > rdma_create_qp hasn't created any qp hence qed->qp is null.
>=20
> This description is not correct, all QP creation flows
> dev->ops->rdma_create_qp() is called and if qedr_create_qp() successes,
> we will have valid qp->qed_qp pointer.
>

In qedr_create_qp(), first qp we create is GSI QP
and it immediately returns after creating gsi_qp, and none of function=20
either  qedr_create_user_qp() nor  qedr_create_kernel_qp() is=20
called, both of them would have in turned called dev->ops->rdma_create_qp()=
,
hence qp->qed_qp is null here.

Anyway will send a v2 as kernel test robot reported one
Enum Warning.
=20
> >
> > Below call trace is generated while using iproute2 utility
> > "rdma res show -dd qp" on rdma interface.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > [  302.569794] BUG: kernel NULL pointer dereference, address: 000000000=
0000034
> > ..
> > [  302.570378] Hardware name: Dell Inc. PowerEdge R720/0M1GCR, BIOS 1.2=
.6 05/10/2012
> > [  302.570500] RIP: 0010:qed_rdma_query_qp+0x33/0x1a0 [qed]
> > [  302.570861] RSP: 0018:ffffba560a08f580 EFLAGS: 00010206
> > [  302.570979] RAX: 0000000200000000 RBX: ffffba560a08f5b8 RCX: 0000000=
000000000
> > [  302.571100] RDX: ffffba560a08f5b8 RSI: 0000000000000000 RDI: ffff980=
7ee458090
> > [  302.571221] RBP: ffffba560a08f5a0 R08: 0000000000000000 R09: ffff980=
7890e7048
> > [  302.571342] R10: ffffba560a08f658 R11: 0000000000000000 R12: 0000000=
000000000
> > [  302.571462] R13: ffff9807ee458090 R14: ffff9807f0afb000 R15: ffffba5=
60a08f7ec
> > [  302.571583] FS:  00007fbbf8bfe740(0000) GS:ffff980aafa00000(0000)
> knlGS:0000000000000000
> > [  302.571729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  302.571847] CR2: 0000000000000034 CR3: 00000001720ba001 CR4: 0000000=
0000606f0
> > [  302.571968] Call Trace:
> > [  302.572083]  qedr_query_qp+0x82/0x360 [qedr]
> > [  302.572211]  ib_query_qp+0x34/0x40 [ib_core]
> > [  302.572361]  ? ib_query_qp+0x34/0x40 [ib_core]
> > [  302.572503]  fill_res_qp_entry_query.isra.26+0x47/0x1d0 [ib_core]
> > [  302.572670]  ? __nla_put+0x20/0x30
> > [  302.572788]  ? nla_put+0x33/0x40
> > [  302.572901]  fill_res_qp_entry+0xe3/0x120 [ib_core]
> > [  302.573058]  res_get_common_dumpit+0x3f8/0x5d0 [ib_core]
> > [  302.573213]  ? fill_res_cm_id_entry+0x1f0/0x1f0 [ib_core]
> > [  302.573377]  nldev_res_get_qp_dumpit+0x1a/0x20 [ib_core]
> > [  302.573529]  netlink_dump+0x156/0x2f0
> > [  302.573648]  __netlink_dump_start+0x1ab/0x260
> > [  302.573765]  rdma_nl_rcv+0x1de/0x330 [ib_core]
> > [  302.573918]  ? nldev_res_get_cm_id_dumpit+0x20/0x20 [ib_core]
> > [  302.574074]  netlink_unicast+0x1b8/0x270
> > [  302.574191]  netlink_sendmsg+0x33e/0x470
> > [  302.574307]  sock_sendmsg+0x63/0x70
> > [  302.574421]  __sys_sendto+0x13f/0x180
> > [  302.574536]  ? setup_sgl.isra.12+0x70/0xc0
> > [  302.574655]  __x64_sys_sendto+0x28/0x30
> > [  302.574769]  do_syscall_64+0x3a/0xb0
> > [  302.574884]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > Signed-off-by: Ariel Elior <aelior@marvell.com>
> > Signed-off-by: Shai Malin <smalin@marvell.com>
> > Signed-off-by: Alok Prasad <palok@marvell.com>
> > ---
> >  drivers/infiniband/hw/qedr/verbs.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw=
/qedr/verbs.c
> > index fdc47ef7d861..79603e3fe2db 100644
> > --- a/drivers/infiniband/hw/qedr/verbs.c
> > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > @@ -2758,15 +2758,18 @@ int qedr_query_qp(struct ib_qp *ibqp,
> >  	int rc =3D 0;
> >
> >  	memset(&params, 0, sizeof(params));
> > -
> > -	rc =3D dev->ops->rdma_query_qp(dev->rdma_ctx, qp->qed_qp, &params);
> > -	if (rc)
> > -		goto err;
> > -
>=20
> At that point, QP should be valid.
>=20
> >  	memset(qp_attr, 0, sizeof(*qp_attr));
> >  	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
> >
> > -	qp_attr->qp_state =3D qedr_get_ibqp_state(params.state);
> > +	if (qp->qed_qp)
> > +		rc =3D dev->ops->rdma_query_qp(dev->rdma_ctx,
> > +					     qp->qed_qp, &params);
> > +
> > +	if (qp->qp_type =3D=3D IB_QPT_GSI)
> > +		qp_attr->qp_state =3D QED_ROCE_QP_STATE_RTS;
> > +	else
> > +		qp_attr->qp_state =3D qedr_get_ibqp_state(params.state);
> > +
> >  	qp_attr->cur_qp_state =3D qedr_get_ibqp_state(params.state);
> >  	qp_attr->path_mtu =3D ib_mtu_int_to_enum(params.mtu);
> >  	qp_attr->path_mig_state =3D IB_MIG_MIGRATED;
> > @@ -2810,8 +2813,6 @@ int qedr_query_qp(struct ib_qp *ibqp,
> >
> >  	DP_DEBUG(dev, QEDR_MSG_QP, "QEDR_QUERY_QP: max_inline_data=3D%d\n",
> >  		 qp_attr->cap.max_inline_data);
> > -
> > -err:
> >  	return rc;
> >  }
> >
> > --
> > 2.17.1
> >
