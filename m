Return-Path: <linux-rdma+bounces-5702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C89BA3D7
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 04:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4229281B2D
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 03:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1387081C;
	Sun,  3 Nov 2024 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gnu1eYka"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799E33FE;
	Sun,  3 Nov 2024 03:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730606147; cv=fail; b=Ai/J7irXHB1NiNxz+j8iDKQnCCxwg7MolnwcbVy405yZPrpBnf6AU3FxwTl/4S1+7aN0UMU+wF8wlMArMOrqQWaPcWYGwHdKJowH2/eWg8gt6IqeS2KvTjBcRtWXKos8Ni8FE89+CnUyG8pvf7YU/TWWWkAg0kcIOlc8G/tvU30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730606147; c=relaxed/simple;
	bh=KVkg5jOPH6tARvykFEdBpyrDazfOdh4hMx/nzheTFmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awDnnPQtNLEBaoBlvouXZizKGIRTo+nTL0vyJCxIqyee4PVjI8i9fXLHVyFCEPLENnRIZHcn/UhCrBmQ3W258uouupue6uHyRoePnWRkI+nhxmG+zXLsFRcRF96j8wmm1HF6kuHGuV5fSkzwCu8YOppsUr1PYUVGgMy191s86mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gnu1eYka; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2+AS2L+sp35yjyQdvuiT2zQq1OhoVsNMqxk0bKkeciE5/b8312A7ZM57gx7aRNsXNiULBQPhWLh900ue+EOHKV2SxWXnRxlEFbjqT7ZCWAJA2vUGFkLGITy8BLPqmdKPhwkPpAjctUbVCryDiF5U3wUBhG9obhsx5YZWbHy9iTUUoZYG/0BuT8be+61C2kRQaGjyNuCIEDVQN0gTk7UNxoALy2bHCvmXoonIEaWJofVEXhlQhBlGlPfoeNy2b0+6krLHcc5kHvU2RqNqyosYHWztqImHTFCX8jD8WEZBSyG/9zhOBQjeSXkHnNgm8HtL+OaV+TlkqAhuQNX1zpGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pZDoe/2HXIt26+u4p4+8y2bMnip7hzoYxo/aWzOpq4=;
 b=UYaylcYSwYaMbrN0l1oEXcq3nmLzCYrP3VO628fH2zTrj+QgB7OxfjdQ1yehEmMovk1tuDXTrcLc+l1gQ1gt9M8zGK31sboO7+wHKsHH5DoYb+sm5A9RL23lzpL2B6h8i17uSTaa9XsG1pwXsKmXBVuPkHRbIAcni3gmq3BY4XLI25jT7LeqFEhJUlHXEhTRkRaauJuTO6Pi0zCMQ3nKpYCXTnj8J4r45ZNeGtI8whSd0D6Yit3ud/Phdc3Ee0azxHikE+8mKLsr7x1TCGTq72PNzhGOOAT62tNbI0skIBxOVBwDTLpPe+2M14Bsw/Q0c2RIQc6jkR72sWIIX0ckGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pZDoe/2HXIt26+u4p4+8y2bMnip7hzoYxo/aWzOpq4=;
 b=Gnu1eYkaZ3VA8cgJFZ59q/B01MT6Ou/GEtEtUKbPfCydxYSHAOXJdoFlsRkK1HeWyNjr7jgVhj8Gcl1Tf7ypy/wJdn7zuTntSow3lrr1boLEUQvf21sAZtYJKSYJF5cCvgGJP1CtzehBs5PG/K9oeeDjtt5/2W4CG1OxT4JLAQeFf6wZGoAJL0KuI5wQkZy0RcVHdf8JkBCwUREm1yjsARlzkeSQRsJflF0ezXaXhKmTlt3M4S7w3Hj1PL/OGSLuZQZ5MmK54hlBFJmOnsFAMWVTCfUrW+2dcj8IR6bcMxHCvswL9AqprRBRyds9WcQPow5t50JQ1nIjXD/vCBi8uw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Sun, 3 Nov
 2024 03:55:40 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8093.027; Sun, 3 Nov 2024
 03:55:39 +0000
From: Parav Pandit <parav@nvidia.com>
To: Caleb Sander Mateos <csander@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
Thread-Topic: [PATCH net-next 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
Thread-Index: AQHbLBDvBoxTaznD+0G3MAKMk1HOTrKk6zPQ
Date: Sun, 3 Nov 2024 03:55:39 +0000
Message-ID:
 <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com>
In-Reply-To: <20241101034647.51590-2-csander@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH8PR12MB6868:EE_
x-ms-office365-filtering-correlation-id: b7c10a7e-c1ca-4780-1cbf-08dcfbbb617a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PYBz0tBs9VaUFcLxDF4HrparJwtG8IWRvepiSWvCU/MDSB0EwfS1UHGroCWt?=
 =?us-ascii?Q?cBMioVWEO5mIAI9cm3pzMQNH14LcTPt4ihBIb2hxj0y3LWOYLGiufBbgzM8t?=
 =?us-ascii?Q?Q/uKRlQh3PxOTHkeWT5uENPD177Krc5dwAvQB5O6sYKdeAxumqRf3N+wJbq0?=
 =?us-ascii?Q?Kmw3kQXCsqzB2ucGwsFIJSLSI2e7kcaaRxOVb3PjI96TsU/5twP+ZvlJe7vD?=
 =?us-ascii?Q?FckqFQLvBd1Nrbp/87U3F2EiCeBn8HMjlrKhWMvfMMapOJ+Qhbtk8K3dYrMo?=
 =?us-ascii?Q?odiP/eBNr9ssJ6QtJ8ix/1AG7yUwSl9zS7jC+3Mp3d+pAXTOv24ef3BuCOtB?=
 =?us-ascii?Q?N68cLdRM9VOHJQPXMl4878BaAZ/zFYuzb8YGpExk605FWwXlYosz789T05gs?=
 =?us-ascii?Q?dcOJHaskVFmlXiuWJkc0g1kS8d0HcOQDhikO+rRF8u3730qx7WxellhLM+hW?=
 =?us-ascii?Q?Vr5xw9/O/rRB1YQwlhbikLcDgOS5dsEWNUbyxub9o7ji6Tv3jTs5QHKU4KPn?=
 =?us-ascii?Q?fNYWPpekWGyjen2C2lXhCV0Vkj0ABUjUF/C1CCsRAn2ODW5C9E8VidSa+5/j?=
 =?us-ascii?Q?TUGqI7qnsxWxDYoaQw++jkX68dyYf4pLucm1DSabWoFNnUmrho6XCuTAGTNC?=
 =?us-ascii?Q?WE5J+0VjKDkSeVkqrBwqIpKfjNVsrzCpR9WZSqWukjCdlIGWViYX1y+OF/FZ?=
 =?us-ascii?Q?N4xhJb+qip/54MQ7u8u4nOTFJFg5FqjyIiKkgdfDk9gN1wSD6B0rAe7Gl62X?=
 =?us-ascii?Q?Otg5NaB89A7LkB1iocnHJEWay30ZxYHYT7PN99c4ILQEcZi5Unk/DcIwOM7H?=
 =?us-ascii?Q?q97ly55ZpMCG3g3Jy+b+FST8RO9gC1id6Dq/yIm9qUvV8xZvTgl4QTB6BcwK?=
 =?us-ascii?Q?MltHkkKwJ0tlMoFubi1lKKT1OMShDJfCxxRvh96jdDS7CE2fN8dXYIJ33oZU?=
 =?us-ascii?Q?XiOY7xFH4zuShMJ6Xq1XZvS6FxLr7rZAQZ21cPRxEf00aSKv+pKfuC+K6qdh?=
 =?us-ascii?Q?maPuUuE+K1gkf48AS6O2Q0lPwfZ7HEeaT46IsSw+czIU3huXGUBva3Kz4Jfe?=
 =?us-ascii?Q?tsp0BKFtk0RUXEImLMPCBEYZLypocFRoaIJDd9KOlkkCzpwcCwS5VLIn4vdr?=
 =?us-ascii?Q?hAp0ISnnDzblDiLryai6OoGsduYAvCZnt9w8OGPltdqp6ZCCVhoo0ArJSwPm?=
 =?us-ascii?Q?mxUkomtMnkJ7IIEGqQ6LmW6FYNKQXVs4GOho8947cQfWekl5z9im5iF4KiSu?=
 =?us-ascii?Q?jyd0HRx17/QXn4L27zlzAKLmRdxZ6smGTKZVM5N1KV8ixYNybCAvmaVZIaMo?=
 =?us-ascii?Q?bf8OxuLOZ2VxkuwP4fAvjDZtAWvoSWR+f2iHb+QZmJHNQGu6os1rq30GMzjc?=
 =?us-ascii?Q?Ttu9fYc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ANvslPhyH8Ef1vzixsQB+ZStsdg1pWvgTPbOC0Te2VatNcD96c/S9dmCq4g/?=
 =?us-ascii?Q?1x5PuAQksdHC25LibhrqUJJCjirmCarmTadm/p1sTXzJUQxG+me2H0s+ZXlP?=
 =?us-ascii?Q?po4xF4WqPlyyPjA9H/MNH4aW+K0eZP7gqiauHbINmziZVuz7+qxfP322zL38?=
 =?us-ascii?Q?nnRnwPNihRDyfHA0TtTiyrMjazqHjzvHggJU0M5CQcJ6bUSxsaYBBVbwVSDc?=
 =?us-ascii?Q?yC0IKpw2prdRiUGKp1ikgUV84N/su5jqQ0W0kYdlQTqxIY3erS0qSscTvbEQ?=
 =?us-ascii?Q?mxE8ITsYEgfuUW37c8jaid0s8TiczWugX68awWTRlva5fEirsoITzvkOMRDB?=
 =?us-ascii?Q?L+IqdWSx4SpD7VIRaXF8A+CxLVK5lZbih+QWhHtPtDxeJyTL1uYUxlZ9CoZz?=
 =?us-ascii?Q?ANyMbt+WPJmVw27HxssSKwJ92DyBg46j52gp+U4fKG0BJtUquPdG5DBxVY4h?=
 =?us-ascii?Q?v/l3mRj1Oh4kGcueZq58e0utHxEzughuO0HT1ieAkEQJNP58unpxHcH646UW?=
 =?us-ascii?Q?6tnJwDHAoygdH/U9r6ZAidDP83MS5qAKh0pZ7K+bjkJtYfwyQCuPAIyPTqTU?=
 =?us-ascii?Q?TaVWKGpP/GvY6R40X4ZBYvd4W1H8xNSjyy1GLP0aJZvu9MFnHctM4yNbAQCC?=
 =?us-ascii?Q?X/mCHBXUiLHX+BpLx0LDZ9rV8BPw07EbaLQQRDRudm8vOXMxrBdiNwUjdpmH?=
 =?us-ascii?Q?BZtuLwFb5JBcRIiZma2YrMDNZbF+yP/WMf+d9M3AfJNWIda88EuUNLsn0n2K?=
 =?us-ascii?Q?2poV5sGs4Fzwr1T5KUoe8pvh/86ALr2lQJQl/ityrphaxW/oZnF3oC2MN6Ya?=
 =?us-ascii?Q?BD1M9aeZaIrH4Qh1XFlPF2Do5njT955S6XVHhVzHKclBtWTwue5qIRgn3i9s?=
 =?us-ascii?Q?xVphfv4w9fscWNizuVL8TNE6enJXILhAa1PiPBmimSzBagtN4wlMy4++s1QN?=
 =?us-ascii?Q?F/Fevp7aBLdtHFqbssoboj05BOlP9xbeWkTbl540lh4ZLsDeKlX01FxxFvx3?=
 =?us-ascii?Q?8alBFi+xvXer8NINf+h/oudxRuYE8bLDfhybkxcCGZUEqB2CwqZbWP3oovkK?=
 =?us-ascii?Q?YCy6pnmqQGhTCLxH3MbQ0QLxiyfZJq1Ib+Orvs9uw5ZzEBZsrrB8+6lCE3JH?=
 =?us-ascii?Q?lyiMmxYo+VfDmRY/2KkoCXbjWJF1k/NJ3xz2fg6DTo4xnsd8eJnzZWogyH0Y?=
 =?us-ascii?Q?wWUitDsGvAqP+HY6uv2lJUH81jM1eZn+rhysDgvwbUa2bXI6RmKpAxrESeKQ?=
 =?us-ascii?Q?x6GyZ1XPLowoeBVFTuY3KV9pNtKKkZ/GSwrWv0LdmNFHHOtf5pIxX/wE6S0S?=
 =?us-ascii?Q?uboEsl9NWWQuadjpTULbFkRUaWXClI1xpzccISIBSZ6kfq3tdAFnhIEb5E8B?=
 =?us-ascii?Q?h5GEO7tldUY+uNbjJuPO6LzCrrHEqje22Ko3AMVxESWu5oC+RM0a12TrGDc9?=
 =?us-ascii?Q?MDtfnmYeuEmuj2OFWo5y0ZmRnrPaBXuQjjLen5eZSxSLjpDyXhgHMdagB0ht?=
 =?us-ascii?Q?YrZ9AW8oj8adYpuRiZxeUXyJ7uMtGEazpg3uay4Mm6UNbd5MCKk+TzBvBnk6?=
 =?us-ascii?Q?puuLuvRH7pOvkVreCoo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c10a7e-c1ca-4780-1cbf-08dcfbbb617a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2024 03:55:39.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2NOPOCHdsRLJMJwjpR/9Q2dmuoy+1LtlD7GEMMwL4TAt1aXzkcWKXeOafSD1A0Fu6LfoAITn+xIurZ1YyIXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868



> From: Caleb Sander Mateos <csander@purestorage.com>
> Sent: Friday, November 1, 2024 9:17 AM
>=20
> The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci(). The onl=
y
> additional work done by mlx5_eq_update_ci() is to increment
> eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to avoid
> the duplication.
>=20
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index 859dcf09b770..078029c81935 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct
> mlx5_eq *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
>=20
>  void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)  {
> -	__be32 __iomem *addr =3D eq->doorbell + (arm ? 0 : 2);
> -	u32 val;
> -
>  	eq->cons_index +=3D cc;
> -	val =3D (eq->cons_index & 0xffffff) | (eq->eqn << 24);
> -
> -	__raw_writel((__force u32)cpu_to_be32(val), addr);
> -	/* We still want ordering, just not swabbing, so add a barrier */
> -	wmb();
> +	eq_update_ci(eq, arm);
Long ago I had similar rework patches to get rid of __raw_writel(), which I=
 never got chance to push,

Eq_update_ci() is using full memory barrier.
While mlx5_eq_update_ci() is using only write memory barrier.

So it is not 100% deduplication by this patch.
Please have a pre-patch improving eq_update_ci() to use wmb().
Followed by this patch.

>  }
>  EXPORT_SYMBOL(mlx5_eq_update_ci);
>=20
>  static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx) =
 {
> --
> 2.45.2
>=20


