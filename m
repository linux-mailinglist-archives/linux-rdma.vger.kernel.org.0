Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32D343923E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 11:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhJYJ1J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 05:27:09 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:22376 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230010AbhJYJ1J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 05:27:09 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P0E3k0015508;
        Mon, 25 Oct 2021 02:24:43 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bwhv1sjm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 02:24:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0pgpXXnH91Bkh83B6gAmIcoPUdCZnr/EptDqllVFGmjdMii8RGDzSpbJpD1DhXPtYFO1B7PtakVekKBmL3N00KLgnBxt5SrdB8jl481PHjhsnlEzHZgvUiDd6UePu9gY6+mU3r0hoYjzDzS9gKRV9tYk1NxbcCKpEvC8eOD/zrSRPzdBCz/6+DDopJZykThFKYRM/X5KExFb0Grjy6mvCYKQjo9I/RRhcpxBHPrOFeTNOfCqfGPtUoaJT+lbjMt6wjPfWluty8Zb8eHNSrIohBixk8ETIRaQ/RP6mtSaKy5F589IfkSkqqkyxJsfphpW3JvPrAn8SiKANDH++3ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Odjd2IGNERSRjxni7hRgYYRiyZ8i2ut/XNqNFFgcJfQ=;
 b=jlVqp+oD4HKwjnq6pgFLppD4H8xYhLEBs6hrad1mHJftQIwCBdxwT1HuGmdyu68N5LkIK8pH9a1AASFDu0pLhig5zkvOKmnr/4QPhaPsBuS9JOxFFXJY635YelMnVOwlCayhbATDFKekNRvuCvRQUeg8Tbq2R1sg22Elqe/GtNig/BrUJ0oU2E45Su9Y51UNY4vWKoT8/DN3/ROc7O3LFUi/AOZPSrUlYdLfr8dZQkR5Y6B+GSG3VBqojZeO31aEm49EGfBMcCd5a/MTMem+oCNyn6SNNcpVDZcL3lC6zXfUKwHQM/VLPAP1LAnY0DCzKkhecbkOolG9ph7INIrB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odjd2IGNERSRjxni7hRgYYRiyZ8i2ut/XNqNFFgcJfQ=;
 b=lbPhTGAIq21oH30CwAgg4gIGjKF3hCmpZjfoFaSiWeTN2V8nF/pBLF45yRvsAwYLGx3tH9tRJktmgnP9a2hxqfOHfQglX6y+ctP0b5ckp9I/p5Q9rUGSWFX58PVAOABNQeE4uiFeRFkKfYj9PGIlFIeJ1H/ef2MjP8zDHdjCIps=
Received: from DM5PR1801MB2057.namprd18.prod.outlook.com (2603:10b6:4:63::16)
 by DM4PR18MB4206.namprd18.prod.outlook.com (2603:10b6:5:391::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 09:24:42 +0000
Received: from DM5PR1801MB2057.namprd18.prod.outlook.com
 ([fe80::a8de:65b:4fe0:32e3]) by DM5PR1801MB2057.namprd18.prod.outlook.com
 ([fe80::a8de:65b:4fe0:32e3%4]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 09:24:42 +0000
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>
CC:     Michal Kalderon <mkalderon@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, Ariel Elior <aelior@marvell.com>,
        Alok Prasad <palok@marvell.com>
Subject: RE: [PATCH for-next] RDMA/qedr: Remove unsupported qedr_resize_cq
 callback
Thread-Topic: [PATCH for-next] RDMA/qedr: Remove unsupported qedr_resize_cq
 callback
Thread-Index: AdfJgSWJM4G+JcdHTbe+udu9aj7oqg==
Date:   Mon, 25 Oct 2021 09:24:41 +0000
Message-ID: <DM5PR1801MB20576F5ED830B11E8F83A037B2839@DM5PR1801MB2057.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad84b6f5-38e6-48af-b634-08d9979946a3
x-ms-traffictypediagnostic: DM4PR18MB4206:
x-microsoft-antispam-prvs: <DM4PR18MB42065355618FF54E0EA9260BB2839@DM4PR18MB4206.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j4G5xGubW1lmhaRYmGfWH0R59cBErsLoQSJf45LxhgM+ZExCt+0KgqA0c3LQcgv8LtuHHPB8LZQW+4pd2rlOXVfFzUtju/A5hkDU2AGGVbJBSYxG2vrXeKsmW7HhAvkWgiUVRMp0oGHYFRBV7dgAMgAaNZ9gSyTCYEmL4RoQGHN6gKtHdP2HuGubTpEKXz1mL+H3GU7Ciizx6xOB1oI0zqOFKp2ERwPtOx3aZgQXMPYKvuYGT9EMIOQpdfiJM0O6ZowOyza9HF9DoaiYbGPHcw31ngQle/MNmbtkPwnysitSNsnnkSZNtlqkVxmQSrZIaIBosAk54sO8ofj56GfdMUMJR/E+QbP6tQDsWNgobpYF5T5PB+R2XG+U+1iowZmBT7ndNJE4G5nU4TldcioFctcd4z2HFdCF9txwXsZJhaTzCd5NwFsAcyYpwnC7gKwFN7yTxuMiC4BfP67Kv7L/iIqyMViG2Z82VdSUEd5s7oxkyedxQ+nRhb+kNeBCMdrdGZxLOeVJPKG5234hPopJHbPnMg2hfuS92+HZYc9Z5LOXQSciNaTR2UGL3+dpE036CtXfKURC+gQM8I2C/YZU5tvRcKwivrMCBCnrILy1l5AOTHZ4FcHEOKmMbcUtgU4c3XOC+Ehc7Y9PAcYFUZx6Ba67mVZiSI9f/124i68ACgKfMsQQmus9Kump/pFD3BEl8PfdnOTyzhg8Ef0Snp36kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB2057.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(316002)(33656002)(71200400001)(83380400001)(53546011)(5660300002)(55016002)(6506007)(8936002)(54906003)(110136005)(52536014)(2906002)(7696005)(64756008)(186003)(66556008)(508600001)(66946007)(38070700005)(66446008)(66476007)(76116006)(107886003)(9686003)(8676002)(86362001)(38100700002)(26005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YlLyjAd3ByVPR5LMX/WqG0QpkH09D+Kq7m2eHB+5PHRHBIOL+cFNs9V4L9Vx?=
 =?us-ascii?Q?Krh1fPP4j7pf96MVU0jtQCxFZ/HCU9VlcQHuYVAqQQ/yuQKmgW76DJVvpoXq?=
 =?us-ascii?Q?0/Sf7maQqTuru7qgL18PMpU1w2F7OgJnd4gjY5lFSeHIRaRIAS2cRATW4DWs?=
 =?us-ascii?Q?NPof3cPbQUfTsf0b/gnP8TSjWGP1rq3wuxpn9tFxVRlqpeap/QHLBzvYWfj8?=
 =?us-ascii?Q?mtrJJwa/c3cKsfYr5Zs9urAUpLcqdqFX4Jvrb6b87DaGCuaekXvNkS96VOUi?=
 =?us-ascii?Q?ZNX72sGNFf77OOVBfeKANYQkJiFv9KlybRSr0jIql7AfAhchVMotty0YV9mk?=
 =?us-ascii?Q?RGEilmFe6E2pxl8iO17mwDuFQm0xMI/fKxa6MkiVl7cWLl6yt3Uh3exdE0Di?=
 =?us-ascii?Q?YP8anNmbTLwOoV2Zd9FL/rU14P5WEpXWGZHI2a1vUNx1IZfLb32HLAyizZce?=
 =?us-ascii?Q?R1291R4WNrJem2JhUBCreH9zJ5BywNEc5s/jFrX/oCqKpFk9ur8iT9NqgzSJ?=
 =?us-ascii?Q?FYXV12DNiZ5sLRuQNCX4e+7frpzdU/oTvSPhGlVcOaJd7HSUrA3jXfcT2n1i?=
 =?us-ascii?Q?8BRv3VODypLQ/muHhoaEggYV5bgJMz3+6+sJrmAKNsNStsvMX7UaBiZHtDdN?=
 =?us-ascii?Q?lnWcD8gSoRTPEl0L1KvZa5UfkF0rNhscQieJZEVVhBMstFDdqZj6Rmni3rh3?=
 =?us-ascii?Q?F8dMmBPb+vqDAiXvsCSX5IfG3d5uiT6zSs3xTG3XPZdVFJay+R+mzpjbTOaR?=
 =?us-ascii?Q?BfVbC901Thzdvw8mR3z7ALCUFpCqQuIGYytNrhMyPgG8mm7dBUx3G6HlFcfy?=
 =?us-ascii?Q?UrJabNyLLzq5+++B9Lii8M8vIFH+9xEu94UH+Xt+z3VULbLp1powSyxmp74A?=
 =?us-ascii?Q?TvRzoAk8iCECyJO/XmwdyVwHPF0vBX4EL36BPyuy+b78mb5DVbGgXdyJPU0R?=
 =?us-ascii?Q?roHcaQdwvH9fLcs2VKWXgRVFBui1sdXeyIZpyQNrzG1RQ+waiWoTrpSvvEdv?=
 =?us-ascii?Q?eDrr7rDEzntg1ztDDUTgZQx8s3/W0XJr23c9NxqbEjt+2dxjDgyvLpxZcAJ8?=
 =?us-ascii?Q?G+jJ3Y1ODayp6ikxAbNB4PFg1pvXZSYaa4nB6vm+z+bU0rb9aTuHs8N4qGTF?=
 =?us-ascii?Q?rZOUG3og5VklNo+OCwgD04SUMH476GhH9A580SneK27su01HyfjEdWvwqxwo?=
 =?us-ascii?Q?vnPZgTiWkvcSWBsEApTomAhg0en7DhHvHJtlZx66bVTLhkf2ylNJFF8G8k+o?=
 =?us-ascii?Q?b83etpRzODNRbuzd3g84Fz4Ds9689TdVuQt9t+7Wg8Py85iYolaupgYtx4N5?=
 =?us-ascii?Q?CaGHT94n50LT+E6jRtLwMYlh/qTuIT1pqLMA8DzGe3c+XaTO3mrBVa+67c/U?=
 =?us-ascii?Q?Elwqf0vgQnaZUKNc4XvVr1TCWONvcb/I+yH+tPuyIlA8eP5p5hEEOX2Al6T3?=
 =?us-ascii?Q?Qhy6gnqTycVAPeayhe3am2g0fvMFQuOlV9rC0TXZRIKZHqkrT6AD8Cj9eH+r?=
 =?us-ascii?Q?0pI3Wg2tGIyBBuK69YI/7WEnqiDzjLW0qvjJRDjUffd6GdhkO8I84pnvGQiS?=
 =?us-ascii?Q?C8L6aCfsKCEoKCMzEqfhhjV2TJ6fkR4GJJ39RkcBvDoowsg8Z9WJpoUXW3P/?=
 =?us-ascii?Q?KyGFw+2iRw6VfBu5aqKWJA4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB2057.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad84b6f5-38e6-48af-b634-08d9979946a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 09:24:41.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwSgku4ywpTIL9dIDOIeYCRnIr8qNwbEPNXDrKvNZBl1mOfzUDA+yJYjFacyWXqS/BKgmJq9TPPJ7MlSOYiDiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4206
X-Proofpoint-ORIG-GUID: 7R7EW9Xdk5OomAn5a_-D71F1OqT108HZ
X-Proofpoint-GUID: 7R7EW9Xdk5OomAn5a_-D71F1OqT108HZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_03,2021-10-25_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear Kamal,
=20
> -----Original Message-----
> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Monday, October 25, 2021 9:27 AM
> To: linux-rdma@vger.kernel.org
> Cc: Michal Kalderon <mkalderon@marvell.com>; Ariel Elior
> <aelior@marvell.com>; Doug Ledford <dledford@redhat.com>; Jason
> Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> Subject:  [PATCH for-next] RDMA/qedr: Remove unsupported
> qedr_resize_cq callback
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> There is no need to return always zero for function which is not supporte=
d.
>=20
> Fixes: a7efd7773e31 ("qedr: Add support for PD,PKEY and CQ verbs")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/main.c  |  1 -  drivers/infiniband/hw/qedr/ve=
rbs.c |
> 10 ----------  drivers/infiniband/hw/qedr/verbs.h |  1 -
>  3 files changed, 12 deletions(-)

Have you tested this patch? I afraid, there may be a crash because of  this=
=20

static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
{
<snip>

        cq =3D uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs=
);
        if (!cq)
                return -EINVAL;

        ret =3D cq->device->ops.resize_cq(cq, cmd.cqe, &attrs->driver_udata=
);    <<<< No check for NULL.


--pk

