Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C6544BD9D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Nov 2021 10:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhKJJKz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Nov 2021 04:10:55 -0500
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:3553
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229931AbhKJJKz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Nov 2021 04:10:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSLV7rEqJYeql/tBZ6d2jqi1J8LCHrmAXFtQMUR9F5Ua1ALkwGHlVAJI4DjJfI6Ui3JpSlMWIFNblkyHsiuriSQ5Xne0MvOteYIsOjXOlh3KAveyM9e3rHDYRBgzyYaq7ehgrgSFg5Lk5ex5iiBplEOEbgaWLsbNk/BUZl1Khy3em8pbdSnWs/G4ynw3m5tIqH0qpW6spJIaxWA/4raE4HhUeJAFrI4NPZAWrRe7fB0zob6w3O4aUNS3fasRl+fWxsKI2y6na/iPzj3BEe0aWUtq7gcV378oPO10wTvHfcsovT+DBPCI49R6FXtSM/qJK0DpuUsZVHRfTv68NaEmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RH3/vWFvOnMBOGnzRRTtS7DEDZaI884ezvTuy8Cp94=;
 b=Q9Gp2huORv8B1aQCM/oixRs1hhJ0R7LXJkAJR5lylqglw9lGj3iQbp7tGw/wxJopx8XvPhG9KAP88y4KkC7PXuD2a5lR6MqxcuS8a/p2byNlXb6erZNrJ65DUz+Fn3Qye3nGpbTK5Cor7/WMqbAgsw/sfGd2XtXSfmbMW0PC3b5GMbX9NX+bJZlTp0t3JkFPqQv7uGa7w4T8GzQU0txKtBV1dfh7Ptb4IaY1xLuCObQEabKGZFbs69iEM2z5KSIDtXYoCMhqF6De4Sa3A48fJVyfhcDEFUQfJQh9s/ylBJVKrpGL2URCe467LoHN2+aXsbRdbzz+JdoVHy2fzHOTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RH3/vWFvOnMBOGnzRRTtS7DEDZaI884ezvTuy8Cp94=;
 b=cbP5mmZWtdN9iZFWfadPDQaipmTJiW1nKoH4L35yjs+5MEdFMCdkVOetP+/msrctuMf0ywTWkneZQnmexLp4G5Q+WuvVnq0ZAsV22otvT3Qqm6DbaZ2E2PaP1K8YFsdBEGpDUtlfEQ8fPDiT964mgiXmZAgDqHWQy4ri2o6PYFdwaY0K2uuXA+MYqblG6iBlUM9UgNUcH9XGEpvBJxQ8QB3/3av8QQ6PnST1zFFnPaX7uKmGUsdM7mzwnt9oIYY8rnBld62V5cK1fBh8qyS3WHgoEzvjnwztAQ//htV75trUhIYzOr8sG4r8qPZe1xNTkCLdC7gPgDxDKHidNKSnnA==
Received: from DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18)
 by DM6PR12MB3388.namprd12.prod.outlook.com (2603:10b6:5:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.23; Wed, 10 Nov
 2021 09:08:06 +0000
Received: from DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::1835:a56a:3b3c:13ff]) by DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::1835:a56a:3b3c:13ff%5]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 09:08:06 +0000
From:   Ben Ben Ishay <benishay@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH net-next] net/mlx5e: Fix signedness bugs in
 mlx5e_build_shampo_hd_umr()
Thread-Topic: [PATCH net-next] net/mlx5e: Fix signedness bugs in
 mlx5e_build_shampo_hd_umr()
Thread-Index: AQHX1V7ajaQQ7rRI3UucRgQKpAqixKv8ecjA
Date:   Wed, 10 Nov 2021 09:08:06 +0000
Message-ID: <DM6PR12MB41886A79C79CC10EE5C4AC47AB939@DM6PR12MB4188.namprd12.prod.outlook.com>
References: <20211109114159.GA15855@kili>
In-Reply-To: <20211109114159.GA15855@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b03444f0-7ade-427b-34e6-08d9a4299bad
x-ms-traffictypediagnostic: DM6PR12MB3388:
x-microsoft-antispam-prvs: <DM6PR12MB3388A704711FADA0C9D70D02AB939@DM6PR12MB3388.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPsI/lAlaRkOlBgyyevybELGXKQoNvWdXiUlyrmG0AM0JU0JMg8F0bGygbLAbPBTtgo6JChLutDYtOyruT8ugsQldNOXPpXEMoKJTSB9SA801CJACaVroCnW8o/hUTuUM3d2rym+P5p83AkKD0m/q0ycOatENh1q7sTmwDWlXshN/0ZCIJ3gpElbyYHFVVxqOHge4kEyDK7DXM1i8D5anuFv6Cvy5RVlr8swyfoNYtzgE2urY2DRyrAdHUErBq9WfBLFFFbg2s1U/XuknpViFytYWL9+vwJuYBxWI5j3WmUTL2fJi2+o8A4O/9LBK8MMsW7E3MHZtFpUObsCEX1L179uR3vw8UMurgkC2bc8M7X2rg0Cr6Sc/ONRj/CLh5i8syuaUtkPuyb8mCKfHjbDgYM6C+XB0ApqtOB6O3hj6ypOahKA/rVBX4RbYiis1ccSZUPH4Wz37xLsdPfiYz3AIbo1Z2D0vlMQgT1nzS97M3DdyxWuc7k7+34iHjjbTtvh9ih7u6rwAqok/0ecwoE6b1y1NGS4IuIL+Fjr8Mb4vl0RGgjGxmg6p/8cMsiOa3K23VnEDl0RTTDtI7RLYvwoYukW41Iwu8nO0QX2vmxVl9Q2sBBSX180CUIZPvKAOziH8ntc7rr6uMoeP8/aiu1Kg7whhFfk/kL+GrnLzxKoGV5K7ZeoImQCbPuGZk7VBbuGQp+y8GxMo+lSVsBIH7xWWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(110136005)(86362001)(508600001)(38070700005)(5660300002)(64756008)(316002)(76116006)(53546011)(66446008)(26005)(71200400001)(7696005)(83380400001)(6636002)(6506007)(33656002)(8936002)(8676002)(122000001)(52536014)(38100700002)(54906003)(66556008)(55016002)(66476007)(66946007)(9686003)(4326008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uLm0YV5pDg+E2nuf/AecjQhHnFy46IQCJ7F39OTc1UfYeCRZpygcgNGEls+F?=
 =?us-ascii?Q?4Zopaak7hH/cvcSt55uCj8ZMOYqZOzX5QI57FQyeKsEpaXSS9DfxOJv6jd4D?=
 =?us-ascii?Q?jx9oMYxoSwQUKXEKaQkEc5VOGo0pAu8jy4nZdItXSlKlvIsj+0bn2o6RjoZ+?=
 =?us-ascii?Q?TWLB8F/8CdmZSeKM9j60WeWx2Flg8GDa7Rudk3WYkxf3oJk7u2POnTIlTh9/?=
 =?us-ascii?Q?sJvWMpSs03Y/lNnLpBIik8gSWn699VU9sVe4SWzvN94Rsuc3WIWk1kZBXfUe?=
 =?us-ascii?Q?dfD8eXzLhNlzfG/l3DkTUqWIapfqmFT4B8FIw7t8zD6ZM33HoPnvnznw2Jy4?=
 =?us-ascii?Q?4bg+gZu77CVZaJU3qCkCHQ6CyQozNgDXbdxOxEmLQAODnWKpgKCe8GRAwZsH?=
 =?us-ascii?Q?+7b83qHgwoE9EKXl7KwwxXzOiVvTl8ZsZpTN1WgLAQNID6sRQm+0oaN1nsB+?=
 =?us-ascii?Q?HuJHlSeGUgV3alFN185R4qM0rnr/k2LVSES/R+OF60oENe4o4Xd/vM26FXdw?=
 =?us-ascii?Q?znKaPme0RPhdDYZ66bseoeQrlTd7ELKTCd4xhB9/5Y9swKKW1qItQxBCOZgA?=
 =?us-ascii?Q?E+faUeV239DNdCoXY8vNrZBO5sUib+p6nl70LXx+mIUzYUKQ85tX0W3WrCVY?=
 =?us-ascii?Q?A3xnfsWD3W5YhCJJnNLg+cbleTV5wrP4N1FV0quSKjqzTIny48MAPLSkmaxH?=
 =?us-ascii?Q?QkwZVWb/Mm+/FT4puOF+dfdKZ4WnS6gXgV0F0F0Vgm8PAlDvcdvMnJpkbJRo?=
 =?us-ascii?Q?G4C8Z+kykQBn+MV6W7+j+dTTxH6OZoagpY+A7EoZOhB5ogZzProLYDPE6e8x?=
 =?us-ascii?Q?EdGghgLJTY6Ii0aJw7SxrAb1ol5oC7ASHU1iSsJoaFbmhoxPVduY0f36BZz+?=
 =?us-ascii?Q?AX1NdWUZZGp2bwx3ApzTi7UfJKyvGpC4PKuCG4aALbWwG3YgIxnoZ18m7LSa?=
 =?us-ascii?Q?9NfY50k/MpafwI+TWEGXspPsF3/ABXtTgQHN9VK2h80IL1TNLCBpG/kmj6z6?=
 =?us-ascii?Q?1UReANwMo5g81jxfcSlRV6zqq1kC+NZv73DR79fgXsvmwmV6+rmGsj60wk/s?=
 =?us-ascii?Q?ephhs0sR/A2Z4Q159EbBqP/JJMjm9oIzqyNqkaraedLw+d3Bt5AqHoqeCEVg?=
 =?us-ascii?Q?t7qWEC6UTzBxMA1XVci0tjxCm5F96XQ88uoB0QwlJvZXgtELNXteKnDzRu+g?=
 =?us-ascii?Q?cTcUhkT/y2NXnFM+EGQwqpdZjxkSS2LULxRQfG/ZuXP4PCDEL4UPyhbqfcMm?=
 =?us-ascii?Q?EqF29j254m8PJTGOoXe78HYGtMEA0M8cStqbf2VzKs1f7y7L2HkC8giZTQr+?=
 =?us-ascii?Q?lcBwe09eUyv8/iuXn5W/xKoanLSeFLFBKk+U7q68KS9yURuvyl0sOBot1SkY?=
 =?us-ascii?Q?3bewxCfxv5Ukv0lrL3xejcCScprE+XrS5XbiKPkn5u5FOZ6AEcrUp+InG6sD?=
 =?us-ascii?Q?IkNMPLONgF/V8RSi84/Pu4aePiZ9h0hrBV+qoIAhNVe+w7TxKfejdkxEkaxH?=
 =?us-ascii?Q?yX9QBLFFgmUiy1pQSfubFWVct4VDExgHmmmUWFZ/1zfhA9svHYX9ROefChFi?=
 =?us-ascii?Q?ARqwlmhw3n3e0pXEQgqtyEOEUwdwmmS3KbbzT4eqEs03M1xYEXxmIpriVtqY?=
 =?us-ascii?Q?h6bwF6ZU/CzO9dTRVIAA4yA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03444f0-7ade-427b-34e6-08d9a4299bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 09:08:06.1054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68h88TLV8/v5mq0rX60dsxnP7j+PbwRCVR/zWx+zA9qBc5WwlVi1lEbLl71sV1f0WLGq6cCELBuFny11xPO5fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3388
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry for that, I will send today a fix that reduce the need for the intern=
al(index) check.

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Tuesday, November 9, 2021 1:42 PM
To: Saeed Mahameed <saeedm@nvidia.com>; Ben Ben Ishay <benishay@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Ta=
riq Toukan <tariqt@nvidia.com>; linux-rdma@vger.kernel.org; kernel-janitors=
@vger.kernel.org
Subject: [PATCH net-next] net/mlx5e: Fix signedness bugs in mlx5e_build_sha=
mpo_hd_umr()

External email: Use caution opening links or attachments


The error handling has a couple forever loops which will lead to a crash.  =
Unsigned values are always greater or equal to zero.

Fixes: 64509b052525 ("net/mlx5e: Add data path for SHAMPO feature")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/=
ethernet/mellanox/mlx5/core/en_rx.c
index 96967b0a2441..8cd120666b2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -543,13 +543,14 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq =
*rq,
                                     u16 klm_entries, u16 index)  {
        struct mlx5e_shampo_hd *shampo =3D rq->mpwqe.shampo;
-       u16 entries, pi, i, header_offset, err, wqe_bbs, new_entries;
+       u16 entries, pi, header_offset, err, wqe_bbs, new_entries;
        u32 lkey =3D rq->mdev->mlx5e_res.hw_objs.mkey;
        struct page *page =3D shampo->last_page;
        u64 addr =3D shampo->last_addr;
        struct mlx5e_dma_info *dma_info;
        struct mlx5e_umr_wqe *umr_wqe;
        int headroom;
+       int i;

        headroom =3D rq->buff.headroom;
        new_entries =3D klm_entries - (shampo->pi & (MLX5_UMR_KLM_ALIGNMENT=
 - 1)); @@ -601,8 +602,11 @@ static int mlx5e_build_shampo_hd_umr(struct ml=
x5e_rq *rq,

 err_unmap:
        while (--i >=3D 0) {
-               if (--index < 0)
+               if (index =3D=3D 0)
                        index =3D shampo->hd_per_wq - 1;
+               else
+                       index--;
+
                dma_info =3D &shampo->info[index];
                if (!(i & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1))) {
                        dma_info->addr =3D ALIGN_DOWN(dma_info->addr, PAGE_=
SIZE);
--
2.20.1

