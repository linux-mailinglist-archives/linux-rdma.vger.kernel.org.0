Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4322896
	for <lists+linux-rdma@lfdr.de>; Sun, 19 May 2019 21:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfESTle (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 May 2019 15:41:34 -0400
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:3388
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfESTld (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 May 2019 15:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A8J5TqeYmr3XI+nDnssy8Iil/pcYyeZrHn/EnLRPwU=;
 b=k1VIbmKybNJb7w7Vr9YXDhHYmb6sJisvJP+UA71lMJXzHWMMZ+s/kRTI85nUNM5s+jGs5gbMr0fp7OIR9I6Y1L4BzkeCG45awE6qcL+672J6GWS7QPH+EcihByg6BDypyCJ2Yu0IomHPvToZdEdaDXkH7Yz/pwgBVoh/3VQl+BQ=
Received: from VI1PR0501MB2701.eurprd05.prod.outlook.com (10.172.15.23) by
 VI1PR0501MB2413.eurprd05.prod.outlook.com (10.168.134.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Sun, 19 May 2019 19:41:24 +0000
Received: from VI1PR0501MB2701.eurprd05.prod.outlook.com
 ([fe80::21a9:b659:2332:4e9a]) by VI1PR0501MB2701.eurprd05.prod.outlook.com
 ([fe80::21a9:b659:2332:4e9a%6]) with mapi id 15.20.1900.020; Sun, 19 May 2019
 19:41:24 +0000
From:   Majd Dibbiny <majd@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     Yishai Hadas <yishaih@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] IB/mlx4: Delete unused func arg
Thread-Topic: [PATCH] IB/mlx4: Delete unused func arg
Thread-Index: AQHVDmviRA8YSFokyka2LpwEvX0Aw6Zy2NfX
Date:   Sun, 19 May 2019 19:41:24 +0000
Message-ID: <B8D8E947-9070-484C-94BA-27B2AE746D87@mellanox.com>
References: <20190519153128.17071-1-yuval.shaia@oracle.com>
In-Reply-To: <20190519153128.17071-1-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=majd@mellanox.com; 
x-originating-ip: [213.8.204.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8101016a-15b2-4ae4-2c19-08d6dc91fa53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0501MB2413;
x-ms-traffictypediagnostic: VI1PR0501MB2413:
x-microsoft-antispam-prvs: <VI1PR0501MB24133293F0141E97C473C432A7050@VI1PR0501MB2413.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 00429279BA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(8936002)(33656002)(446003)(4326008)(107886003)(86362001)(6246003)(2616005)(5660300002)(11346002)(476003)(54906003)(53936002)(6916009)(8676002)(81166006)(81156014)(316002)(486006)(26005)(186003)(25786009)(6436002)(14454004)(3846002)(6116002)(66066001)(2906002)(6512007)(36756003)(83716004)(99286004)(102836004)(82746002)(73956011)(91956017)(71200400001)(71190400001)(66946007)(76116006)(76176011)(53546011)(6506007)(64756008)(66446008)(68736007)(305945005)(229853002)(7736002)(6486002)(256004)(66476007)(14444005)(66556008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2413;H:VI1PR0501MB2701.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yw1FabFbNMhJZEAdzoXdT9b2oWxiEym2g89LVxNE12d5dAkVeLDGmbrNJEU5WjI80YnS2QIwmJG6ruc/EiRZUNabfOQvPaFqLFIM1cvvQ28x/I6BuhGOuAa75xM63Q5mo4nPM4+6scIbRLaf5Nj271SaWnR2M2kEUaAhQW1dS/6rhgiM8+JBZ3ak/5TOy+IVrsnyLlK8wAFqoH2yAYH2f8n8dvCBpkHHDMafXO8QdDLrxzIZuxgrfDD1ciWExm4+j14zH86ykv3tnh0exjFKSpeWJOBF9j6FEKDJjLY0BtNCx0xySL7j+prJ7eb+x1tICgfxQiXp5khTVS5eBHYjlkcTaIBd+keHV1mghyPeWQMGnr8n0trcXV7qBmI+Gsyy/7u6nRzOlLKl3Di2q2e/0a0xFoX5AmbXLntocGHO5pI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8101016a-15b2-4ae4-2c19-08d6dc91fa53
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2019 19:41:24.6266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2413
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On May 19, 2019, at 8:54 PM, Yuval Shaia <yuval.shaia@oracle.com> wrote:
>=20
> The function argument virt_addr is not in use - delete it.
>=20
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
> ---
> drivers/infiniband/hw/mlx4/mr.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4=
/mr.c
> index 355205a28544..2e132883848b 100644
> --- a/drivers/infiniband/hw/mlx4/mr.c
> +++ b/drivers/infiniband/hw/mlx4/mr.c
> @@ -368,8 +368,7 @@ int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem=
 *umem, u64 start_va,
> }
>=20
> static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start=
,
> -                    u64 length, u64 virt_addr,
> -                    int access_flags)
> +                    u64 length, int access_flags)
> {
>    /*
>     * Force registering the memory as writable if the underlying pages
> @@ -415,8 +414,7 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u=
64 start, u64 length,
>    if (!mr)
>        return ERR_PTR(-ENOMEM);
>=20
> -    mr->umem =3D
> -        mlx4_get_umem_mr(udata, start, length, virt_addr, access_flags);
> +    mr->umem =3D mlx4_get_umem_mr(udata, start, length, access_flags);
>    if (IS_ERR(mr->umem)) {
>        err =3D PTR_ERR(mr->umem);
>        goto err_free;
> @@ -505,7 +503,7 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags=
,
>=20
>        mlx4_mr_rereg_mem_cleanup(dev->dev, &mmr->mmr);
>        ib_umem_release(mmr->umem);
> -        mmr->umem =3D mlx4_get_umem_mr(udata, start, length, virt_addr,
> +        mmr->umem =3D mlx4_get_umem_mr(udata, start, length,
>                         mr_access_flags);
>        if (IS_ERR(mmr->umem)) {
>            err =3D PTR_ERR(mmr->umem);
> --=20
> 2.20.1
>=20
