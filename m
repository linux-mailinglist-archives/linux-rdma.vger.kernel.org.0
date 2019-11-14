Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7176FC7F6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 14:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKNNkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 08:40:02 -0500
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:60755
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfKNNkB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 08:40:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpI8mu6XoFJ267YSSOpjoniaEpMe7l3HAQ4BGP1+3ls367tD8Njpl2sSEHq9svVv/pwPhltSC9Z2gQQf7kehW2NNGiwl2OyjAsFsM+Dlh1h2y/bJY8psUdAwFTH5wwTL6JwrdqfV0H67IVuu4CShxM6PGRFMNFryLQUG/pKm5bYemUqrlbtCeC6lUltyRPMTteSxo0RtEJ2EvUv8jsINl0h3h88H4N8KUNvj4t7MORtgYBdr4SbKzdGxOcsjedCw6Sz9IW8nqHpTmJ3C6wjLM2GCkEVQrvGx4B7rWS2l8NqNke2KbGjtT7OqpiSUsA5kVUN9RTpHRNe7RKhskheKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajSgxudTIeoxu03MDIIw5IUwFmVGLf7JV0PaY9iGmLE=;
 b=j3HsuJbkJeCu2PTYMd2mwJ5Lj+lDmYPCuYF3Be9tcLCsyRpr8pPqivlwcovQcCn5kxlDMlE1DxCRB2t69Djlph6MdxfHeir1PQhOuCeOu/sIl9GXYt3+TOP80qOQVqx+h3x5qmAkh7IGzSowRmbtIBOMAlyzID+gd8jR9f5clmgCshnRS3i4UL59sMDjZ2DQPENvYJS7DabopAXjrWpr8c3cORO0QCtpur2Xw34cuDrpVzyWrNYpr4SHKD4JFqQPzHCAHVLZ9qnObP60gRvaq8pjef694baQlm6PbkkB1MJMAnI4awWQbyqwepslAB13CdC8ZGjuULVfTCsWuDOAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajSgxudTIeoxu03MDIIw5IUwFmVGLf7JV0PaY9iGmLE=;
 b=kf0pF/W4jOBzWC4+VmSdJQeF8Stbhb5Hpph4P2qkDEtYEyt9JSWH+jST4gCq6B0KX53UN7ymwW37dqlMOh1n5B5Hs33BC9K0N6koALHQ0dOkcs38FvAQkBMFwEevhvxgCpUMJ1U1aHkcDQHItPFn50sB38deFWEimdu31IIGM1A=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3501.eurprd05.prod.outlook.com (10.170.239.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 13:39:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 13:39:58 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Noa Osherovich <noaos@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@mellanox.com>,
        Daria Velikovsky <daria@mellanox.com>
Subject: Re: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Topic: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Index: AQHVms8sIZmxpJN9xEuBJbuwT+tiy6eKrF8A
Date:   Thu, 14 Nov 2019 13:39:58 +0000
Message-ID: <20191114133954.GT21728@mellanox.com>
References: <20191114093732.12637-1-noaos@mellanox.com>
 <20191114093732.12637-3-noaos@mellanox.com>
In-Reply-To: <20191114093732.12637-3-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:208:fc::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 830edbf3-2cb4-40d4-0442-08d76908245a
x-ms-traffictypediagnostic: VI1PR05MB3501:|VI1PR05MB3501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB3501996E1A79154DE564163ACF710@VI1PR05MB3501.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(199004)(189003)(486006)(446003)(71200400001)(2616005)(476003)(7736002)(5660300002)(11346002)(71190400001)(33656002)(52116002)(386003)(6506007)(305945005)(6636002)(4744005)(66946007)(86362001)(316002)(76176011)(54906003)(478600001)(64756008)(66446008)(66476007)(66556008)(25786009)(1076003)(6862004)(107886003)(81156014)(8676002)(81166006)(66066001)(6512007)(6246003)(37006003)(8936002)(229853002)(2906002)(14454004)(256004)(186003)(99286004)(102836004)(3846002)(6486002)(26005)(6116002)(6436002)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3501;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N+uhW71jCdCSlirmgzwogv76LWV8RSPeS+c6N8htVayYFuSesueeDED2khbUO6nyVP2LKjWZgxQpTuwRvsQwnRi0UzBKkZvN7nrDpuYioN984jGCinTLL7B84Ep+/TrdKlOSl3o7kaJ0jc1nRKPvJLr4hr+7duJuvEEWTqjrJq2sbZgAwm1gr0O2EqSap2oTu7a0iSFWu2ISrYSjKAN73hLPonvHz3BfUYyt/jCCWbwB+At80YMaQzOzOBOKzf5uQUYtdvrkptoXx9p8ZU7EEhBDj9pR0ZCjH179WoD7Qq29Uw4Z0DXkrY4YLZDL701JGdg4FmZEBLLXeZ14ln02gp0cXnCEvGZ+Qt0fleHkc9hACDdGpevXM1SerPPehGLsTNbpSGkPE0n2h3kSwcEibqHHac8pdBy4wCK+OSV3zn3RnA0yLT5m/IUX2KbFHAU3
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A99C2D83ABAAF449AC667427301CE0E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830edbf3-2cb4-40d4-0442-08d76908245a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 13:39:58.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7di58SEnc+8DeIt4b2sQJNc42DSJ7fvlRp29k+xAIya0cALVXYdheCoQPxONlEWKT2pjgp9FLHEwOh4iSKvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3501
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 14, 2019 at 09:37:46AM +0000, Noa Osherovich wrote:
> diff --git a/pyverbs/providers/mlx5/mlx5dv_enums.pxd b/pyverbs/providers/=
mlx5/mlx5dv_enums.pxd
> index 038a49111a3b..b02da9bf5001 100644
> +++ b/pyverbs/providers/mlx5/mlx5dv_enums.pxd
> @@ -45,3 +45,14 @@ cdef extern from 'infiniband/mlx5dv.h':
>          MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_SPI_STEERING   =3D 1 << 2
>          MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_FULL_OFFLOAD   =3D 1 << 3
>          MLX5DV_FLOW_ACTION_FLAGS_ESP_AES_GCM_TX_IV_IS_ESN   =3D 1 << 4
> +
> +    cdef unsigned long long MLX5DV_RES_TYPE_QP
> +    cdef unsigned long long MLX5DV_RES_TYPE_RWQ
> +    cdef unsigned long long MLX5DV_RES_TYPE_DBR
> +    cdef unsigned long long MLX5DV_RES_TYPE_SRQ

These are supposed to be enums, and should be cpdef

Jason
