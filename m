Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD7D3141
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfJJTVn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 15:21:43 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:41714
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfJJTVl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 15:21:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfINI3vQlS3Kft8fY1M2PLWv0EK/bv4gK5bNDDMl2cVt2IYWFbqRnQ+8ztlu3HAdQ2hDsz/s9GU6q5JkZ4Ou59efzzYvkBopWB4xaQc7ZPmLPpV3stIIXLpKNuS2F3+fdLW99MYn8xxhq6SkRsQoGWXDVOSkL2P71dzahw+Atm2LzO0MudbP/QTn4nOyi7mwYThXLxfczuJv6xchKvQG5KsHh4QZ477XpUN2hQJQhdWDaMPXbrFsrRMKKdMhWfvuSg6VYC9pg4PAg1d55ZmYVdSK4f9GwYTr2x8FBcLp596g5wkCQVvfRAmmmMpn2wS6L4EfFp/eX2/NOZsn8QsvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLvSMGR2m6sY1X7WXy9kmvKphpdrtiU8LW8ghvFI1Q4=;
 b=JHq0sREVQZRgS5ZFSTQmvVCqhnnjZC70KO35I1qrVcw6zWFy506rucU+Rq/fqjYGOzZlSK1oBn3ueS7Bus7lfY+WkV9KlB7SrtRIwXTzSTUZ113/brqNJ0p0yWXtTH0T0dMVjPP4UPAvXDjGDO02HKj30S+MbjoftStGUw052rbXDc58ZpsT83ASBGhelDtTnjDpgrwVSiomyz/fUHavb0hzIglY59t2SxTNH6O2L3U0Wr51BqIvsPKzV6xmrYBwbFj03tZ577mmTiSWILSQOtberMbXMIyrQaAPDc+NXKUa2A95yy1MM0A35OVgPfk+aNeqz9aOBDOEU28/HT38ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLvSMGR2m6sY1X7WXy9kmvKphpdrtiU8LW8ghvFI1Q4=;
 b=dMBE4j/cYIxYGHk5MtkJfMA9BdtQvtqth+/RggjCfdO6Um2V8uqUI1Shdp218hMUzzTcKZBW3fUcTCr0hR40KTROkm46BrqFLRmne7ugiSITN340f89v0dfszw0JYg89tFaebAqIKXryQx8T7r4zun3mS+wElMsHy3iWYq0nnUI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4464.eurprd05.prod.outlook.com (52.133.14.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 19:20:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 19:20:58 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/uapi: Fix and re-organize the usage of
 rdma_driver_id
Thread-Topic: [PATCH rdma-next] RDMA/uapi: Fix and re-organize the usage of
 rdma_driver_id
Thread-Index: AQHVf2MPvIQZqqf4tEaWjTkw/MQdJqdUQOSA
Date:   Thu, 10 Oct 2019 19:20:57 +0000
Message-ID: <20191010192053.GD11569@mellanox.com>
References: <20191010120541.30841-1-leon@kernel.org>
In-Reply-To: <20191010120541.30841-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:208:178::41) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb078069-50a7-48a6-5146-08d74db6f9fd
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB4464:|VI1PR05MB4464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB44644EBECAB248FFD5EA9444CF940@VI1PR05MB4464.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(189003)(199004)(25786009)(229853002)(5660300002)(99286004)(8676002)(6116002)(478600001)(3846002)(6246003)(66066001)(2906002)(107886003)(81156014)(81166006)(6916009)(305945005)(36756003)(71190400001)(1076003)(71200400001)(7736002)(256004)(14444005)(14454004)(66476007)(66946007)(66556008)(64756008)(102836004)(66446008)(476003)(2616005)(486006)(26005)(33656002)(6506007)(86362001)(386003)(54906003)(6436002)(11346002)(446003)(186003)(52116002)(4326008)(76176011)(6512007)(316002)(8936002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4464;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjvCUSw+/BRFpoXaUj4R+jiny4d5wexGPKg8hz1NjsvjbyledutXRV6VavtZMhdngqO22phjc8ewRp8WIENW5BfF9uuVbAYWy4HC8jzYiUUTo8TzYi1x9TayHalqzfcQmCYgxeb1ACYpJSwU2nRsOdXuxXKT9yNDax75EI4lq5SYoLGLbxnxp3C5TCbopNlcIXGGI8H9PcweBp16hNeDqSU9jJiImqBMk115Z1S5REUvN8Wigs13xXF1DYsOzgnVum141l5Vu1gXCll7ohrY7C/LmMJe58IlQPV8SURIgDdWSgwwp+PG1sZiqrJO82NYjiOvyzVwsdNafuWJqx/AX93JLfCf1VufS2GJSSaNZMTmVyeoydbBTs+LHmE9bqtEHWFZ9cKvG2C76uSBoxHAjRVRnBa/dq/YIE2Aslwh8DQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <368986A2D8B7E043A97DAC13B15CE7C7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb078069-50a7-48a6-5146-08d74db6f9fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 19:20:57.3886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcWSfMuz1tl43GWSYiwSkFxsYDf1jiv7y234ubJPjv/8wU3aTnIoHLMJzrrxOn7YKqF1jkvaTR2TBTWxWdm6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4464
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 10, 2019 at 03:05:41PM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
>=20
> Fix 'enum rdma_driver_id' to preserve other driver values before that
> RDMA_DRIVER_CXGB3 was deleted.  As this value is UAPI we can't affect
> other values as of a deletion of one driver id.
>=20
> In addition,
> - Expose 'enum rdma_driver_id' to user applications by moving it to
>   ib_user_ioctl_verbs.h which is exposed in rdma-core to applications.
>=20
> - Drop the dependency of ib_user_ioctl_verbs.h on ib_user_verbs.h which
>   is not really required.

One change per patch when it is a fixes..

> Fixes: 30e0f6cf5acb ("RDMA/iw_cxgb3: Remove the iw_cxgb3 module from kern=
el")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  include/uapi/rdma/ib_user_ioctl_verbs.h  | 47 +++++++++++++++++++++++-
>  include/uapi/rdma/ib_user_verbs.h        | 25 -------------
>  include/uapi/rdma/rdma_user_ioctl_cmds.h | 21 -----------
>  3 files changed, 46 insertions(+), 47 deletions(-)
>=20
> diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/=
ib_user_ioctl_verbs.h
> index 72c7fc75f960..3d703be40012 100644
> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> @@ -35,7 +35,6 @@
>  #define IB_USER_IOCTL_VERBS_H
> =20
>  #include <linux/types.h>
> -#include <rdma/ib_user_verbs.h>
> =20
>  #ifndef RDMA_UAPI_PTR
>  #define RDMA_UAPI_PTR(_type, _name)	__aligned_u64 _name
> @@ -167,10 +166,56 @@ enum ib_uverbs_advise_mr_flag {
>  	IB_UVERBS_ADVISE_MR_FLAG_FLUSH =3D 1 << 0,
>  };
> =20
> +struct ib_uverbs_query_port_resp {
> +	__u32 port_cap_flags;		/* see ib_uverbs_query_port_cap_flags */
> +	__u32 max_msg_sz;
> +	__u32 bad_pkey_cntr;
> +	__u32 qkey_viol_cntr;
> +	__u32 gid_tbl_len;
> +	__u16 pkey_tbl_len;
> +	__u16 lid;
> +	__u16 sm_lid;
> +	__u8  state;
> +	__u8  max_mtu;
> +	__u8  active_mtu;
> +	__u8  lmc;
> +	__u8  max_vl_num;
> +	__u8  sm_sl;
> +	__u8  subnet_timeout;
> +	__u8  init_type_reply;
> +	__u8  active_width;
> +	__u8  active_speed;
> +	__u8  phys_state;
> +	__u8  link_layer;
> +	__u8  flags;			/* see ib_uverbs_query_port_flags */
> +	__u8  reserved;
> +};

Probably better to move ib_uverbs_query_port_resp_ex, since it is
really more of write() style interface

Jason
