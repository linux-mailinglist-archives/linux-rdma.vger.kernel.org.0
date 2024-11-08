Return-Path: <linux-rdma+bounces-5865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0572C9C1B00
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 11:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95AA2820F7
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3021E22F2;
	Fri,  8 Nov 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oiziESvw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737411BD9D8;
	Fri,  8 Nov 2024 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062819; cv=fail; b=Iqbar1QzPPcFlUzO/YydIxwqBQsgJUz+Q34DsapzDWp3YeOE47RBUh8NAhYH0sNtLQ+zjCye0hTnzgtUCFPx6EquMcXSCwUw44ykblx5IlLuiji8mNvIwuHoetm9uQ1qXcUhyrnSW3YfZzHA9No4UL3Mr/yLKN5N2FDnC0iZBrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062819; c=relaxed/simple;
	bh=P4l8m6Z6jbme8G/qIVMt391JxQ9kVBJ48SS46cnsDW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AF/M3tN8E+IgJMYy/nQt8UXQk2Tach7kRdCmR18lBLiO0ulbYtY13odXTZIVpLduUMYf+xv3Ya7cbm60tw6r2defcUlebrv6Uecl/xnUR3ty6D/4PE7DKZ/1tTJGEiwPVPESjIrbRbrbSizUpGHG1Fiar8JqmX7gBrO929wg6U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oiziESvw; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1+JJrSFMFF3x1zFItWe22ZJVpDoDd2NDReXXIOfnfNUO2BPg1paeIsiC8RPGyU/70jZhjjM0wvecn6tqCnWUpP2FbpNzsVgwtVszSY3TK19O25Qi96WUdVuwd697sYzME+vgBF+2cO8WTFwc/xIntjBJiiFP4iefp1cR21T6CnkPGeF4BUjyW6YoGtPsGxGEdxG4UAcY+V6wAEPgqf+/2LJWi5NIhfkqWCw1bMQwCWGkRh6rDpOJv5EJz5iG5mxd9TlQ2DfOoJK6EKjOcrlzrXhd2MDFxjQlP5zdtl91D5rPovNmQ5zW8vCwiXz/7JsklN9jSb27VV9cW5c1OZl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGDkYsl0WL6oPtJFsEzwml9slJ2H95zsSrBXWdVR6fI=;
 b=ANGi8cPx7wIfNbgAvQu/3zMZFtloiqYeG8kbcxikoYG6vlUOX6eyyZq1+oARbXT78Ouq7GYxMaJw/3km0L+SPWpZPixTlK75NKt8JfLDxqwIcMG2U+ldv2xsjCPvfvx0QEFTFXItXRE/z9ZEYr7SdY30kOXO9JuOwjaWRkGCr5UiFUG2rWYZjTUAdfgAUGVSyivV0Va/ea8O8K7EUa8sMXTaf8GJAGUXvKzD8YlbObSaLhO82aD0LVEvQNZtu2Xq6bKXQEJRctypnEBUIr4jpbixUQZUYmY3rRJHvQR/HCxNPc+6MR1yQw6wnf2wIRVte5q23ZTMM8ZmkHtWPky+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGDkYsl0WL6oPtJFsEzwml9slJ2H95zsSrBXWdVR6fI=;
 b=oiziESvwG3LVQo6VYCEWUZhCD2GGs1x4LFKN6Nbfo4QnE5fmaZVURlUwB/Kxm0UBnVm8l+aaAFFjlZCQtEythzCigHI5jrnoyJnuDpV2uyk+nMkNwOP61rUdzUmJP8+OQseYLnjRoIZxv/QPszNTpPOvPEuATpEExwZm9XEL/IRqy2HCtt9Skh6DAvMhubVIQZOzwZNI7dHTVCMrJ1z41Jp7hBP1CSIDxuXSklQeNPR6hgc6awPiCyvchXkwrv9TV8SMLeiU03ARVPf++LZWz0wYyxbMYN0ifr/qbDz+bsg3fcjUAXIvgVJ+J880k86yH/2wBQ2Xtx4lJmoAhei6KQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 10:46:50 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:46:50 +0000
From: Parav Pandit <parav@nvidia.com>
To: Caleb Sander Mateos <csander@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/2] mlx5/core: relax memory barrier in
 eq_update_ci()
Thread-Topic: [PATCH net-next v2 1/2] mlx5/core: relax memory barrier in
 eq_update_ci()
Thread-Index: AQHbMUM5eQM7ZgP+d02CLxegYYKj3LKtNGjw
Date: Fri, 8 Nov 2024 10:46:50 +0000
Message-ID:
 <CY8PR12MB7195A03D0F6C66D906354549DC5D2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <ZyxMsx8o7NtTAWPp@x130>
 <20241107183054.2443218-1-csander@purestorage.com>
In-Reply-To: <20241107183054.2443218-1-csander@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA0PR12MB8984:EE_
x-ms-office365-filtering-correlation-id: d6dccb23-4740-46d0-bc5d-08dcffe2a694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Igm1ULW+XOEmnow6LG9513uBaLbai4jtNdjytLegpfZCiT0J//VBt2QX+blV?=
 =?us-ascii?Q?/tk0+IL12A2CbptJ0fkkJVak7cWDwaFsfIsUwKznDv0SraGqktsbfvwH2Xcc?=
 =?us-ascii?Q?8o92arClfUaaskMVL+VsWQqPlVtdBtTOyyjHIl/zXlB+BP8ERxWPl/EE3/Qr?=
 =?us-ascii?Q?pP1X0Y7KCZ1/IEAMouxP2c4CEwP7c18CqprxuE7F8AgPq8e0fhAR8BayoDW/?=
 =?us-ascii?Q?BGCfhZDK3FJXL75gFHUtzAAe5cttcpFWrbzJVPD9rWKsjFTIASuBpXonx7TA?=
 =?us-ascii?Q?saUHChbHgnkm5bI1obugNwtv1X4UKKq3lW6c40n5MQ+qTRyl64kyN5FJuw0w?=
 =?us-ascii?Q?6rfGpPSZhtLiiACijARm1F4SXB5CFDxsvgiGmTqhARv5+RdKyJZkwYZ1Sd9g?=
 =?us-ascii?Q?6K6Mdkl61y57Edd6+nSNo6/IJKI8J6AHgoNAwBqU9JrqJQcvyF1icEKqRmE7?=
 =?us-ascii?Q?/G6bolK+Tb/jmp9ISZ8poXALqUeoBKZ2uJEJaddAonh6H3hWL62g+5Dq2ceU?=
 =?us-ascii?Q?CxecDyfs7G4G2fUQ+bbOIOQLlkOccee9nx5ryl5P4qWR2oax0bR/15xSt0Fv?=
 =?us-ascii?Q?8YEKNs0r6sfeFoKr4k64O8DkkEhXL27tDssfbPcymq8YiHT9nGAu2IZQoXro?=
 =?us-ascii?Q?PkjsQGhKsysD8F5WCC5rpkjwxgEv+TW8t2jTccCd3S05ndiCHP5v445TSxKr?=
 =?us-ascii?Q?o5kOhDOdfcSW4/8Z0+WooGmLBDdICMy44SXQbWrwigp5Km5fKc1Q95e5AL5H?=
 =?us-ascii?Q?5j0I4eL6586rRLbu81/e0WVa88v8wCUeNAN+bge4DJISTDnOZuqTmUXxftCG?=
 =?us-ascii?Q?lrJxYbOKYwiKfAzwgqaWc0LYvWnKJ0hbFMgQz+ce7IIs5zewDXpHBFtlBAA9?=
 =?us-ascii?Q?2JolwXulSQ6wo+XkSSAAoAvVw4aj+Liq1rOrvohPK8z4/FsmnfSFJGq9tC7r?=
 =?us-ascii?Q?Tss+SwwvNvfmJL2V13vktOeRqeUCImNte+sBH4VjfzmLBAk1vPKsP4TTXNWb?=
 =?us-ascii?Q?ApDCxalqK+2lTlPuK4NzgUzTA4aCf22uw+6mSVJWnVicDdUQKWroc/30t/06?=
 =?us-ascii?Q?pjdQzEfMmQACd7T81rOrDA3nSv3FXd0UywExxkwh/xaeE8dcBvvQCYKFJnzs?=
 =?us-ascii?Q?85/tNuASq5Rh38dXclB3Tjk82qkI9fsqHIDtC/g64i9AmisVYjIoiwx4wQf7?=
 =?us-ascii?Q?5HLqGFRYN8V4nXI+xKtpFv92lAGX/xceNuttSwV55gXwvXoSzog8NkzJCfdf?=
 =?us-ascii?Q?j+AigWVFPG5ZNfL6tTS1qwQlikKjUNT+eeqNIRNpjH5G/7wrp4ZFYi1pUMrL?=
 =?us-ascii?Q?vuS7PCho3af7K400qpMIpMjXrwy7J5vzhXD20V0NSZTNWhxNlBK4FJHHLbpa?=
 =?us-ascii?Q?18yftAA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rNmhowsMjw0FywFpN/ovP77RigMOqxsVfgTiK2z9wcLbpiqjbLxPWGIQCb3G?=
 =?us-ascii?Q?90G4B5a6ztc1+AjkVzR2ttG4YsN1TCEv/ylWLicgyGfQ8TdL1c0i88qjFN3o?=
 =?us-ascii?Q?S4NNsk/F832K/zp37C9spMq87b7oRaKO0hD+1wI7XR7hrprkMsDA8bbavd66?=
 =?us-ascii?Q?bctW6hNBrezDSJ7iaiAZtm9P+qcZVtzZ2q4DRBm8G2558khMvJdAuT+nFWTX?=
 =?us-ascii?Q?/FSsTb4TiDn81fLa28LRcpFRuzC1t6ZE5tIg6at5AjidGtNoxlfW+EbziEEr?=
 =?us-ascii?Q?OcsDUiwZFzkuBWrwtLJFHpfWiUbHZVKwo7rMs+3u/LoY1aghtL+NZqmUyj1m?=
 =?us-ascii?Q?OR9A1ShY2eSsXMdIvyeIZMUAIyWBcRGPhaLNy9YNfzQHBZrPiEYszXpnkQoT?=
 =?us-ascii?Q?cLF6K0UZ46M/9ez2fQi97Z+uIaaJWmUWzlVrfrSop4Rti1quaZdmTaWbbgRN?=
 =?us-ascii?Q?RxHjYjBHjhQ2oicxn/nS/+TdCYgUlVXZzC6QpdBfipP3q0VwOH4jKTt+E6gP?=
 =?us-ascii?Q?Qc5Ht3JELKXZNGiZ0XGTcuNVrcChdts/e2qTh0+OwMYg5QmxIMRLwndGKDL3?=
 =?us-ascii?Q?iN1lr1Sr3/TIcyyn6XdchHco3SWXtiMPe4DHD875fkDjU0+jLTZ6VcekuOMT?=
 =?us-ascii?Q?RnoHZ2SV1cHd3MSBszNVKSA9CyT5L1SKUZFwhLS/Oo9urmS1+9/u/TgYY4/c?=
 =?us-ascii?Q?FVz6TWO4fPdfOzmHGkZO2JyJuppiXLZHQG/rI+DvwjbNQyEBs1I6P3xQvgm4?=
 =?us-ascii?Q?58iwglqfe3omMobGFQmgZ3LwpSw4/xEPsk6S1ao8gk9vjE5JDGfV18NTSVPq?=
 =?us-ascii?Q?kr2yJfw+jcqOewH/nlP+JpCfoORGSBNdpnHUY7UC2QMDhd8eU3JW+wGTqcvZ?=
 =?us-ascii?Q?jo7MlTJhCxqSA6xl+PcKWXtSBWjCxY3Okzi49ORHsNqw3kuhDJNY1EofpfZv?=
 =?us-ascii?Q?imOGfX1LBQfVAgOel+4HXXfMJQqXFjAThkfHKW5Scm10XD+baZYgswHYuQ5B?=
 =?us-ascii?Q?aMKcpPvhF9qQMjouq99SdXIjUbDJ/sUnxDWL0/F18AV7zRA9tFbi4Y479P0I?=
 =?us-ascii?Q?dE0gGY+PTkp8T5F5Ql/9XT9Q6psWOwx6qlCPqUqkeFHwd5OCxj8jQMPwAhmE?=
 =?us-ascii?Q?C9IW2Q5es6PMLoijQYkCvUg2bTnppTQcSV0NrKtSK/FDtcRE8v4MQH7V0cwj?=
 =?us-ascii?Q?aOOtmr64dQioYTQUx52K/JTIgAC3BAi6yR7B4/ZNaiWUbNEVHp6vWgwmrUKY?=
 =?us-ascii?Q?5oyxCbxqb/zHGPBp6UxfdnQo5wQ9vsdF5+kbEJZtWHXu+RZ+Y9loahEQx/lV?=
 =?us-ascii?Q?BOolkW/M9Wy5Bo4Is/mT4icDJKwXYf2uUhMQfuwwmaNGvdackxS92KWesybw?=
 =?us-ascii?Q?ApAmhhO+QdCr28ptueltGo9tcN8jKLSikFHulIjx6q9+U8VX45oMPkqM6t5P?=
 =?us-ascii?Q?LYEmhV4yopq3NCt3EpUq2t1ybYDLKLmS3JGpQge1Tw1oKB5nIawV0sd2oVf+?=
 =?us-ascii?Q?Ca+2Dd4cpbbW769j+DLeCfgw+q250mAwToeSFz+WJq2ryhWV9l2hnDqQD1St?=
 =?us-ascii?Q?Wz38m0Y0XMS/OTnfOd4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dccb23-4740-46d0-bc5d-08dcffe2a694
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:46:50.2000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fcSuf2RJXfB4/WakMVJvB0zZyrJG0u3nSaswMX/Pgn7xJceZQ0FPqfZn/3yppEeG3FhzBJdAA02MSahtRRDIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984


> From: Caleb Sander Mateos <csander@purestorage.com>
> Sent: Friday, November 8, 2024 12:01 AM
>=20
> The memory barrier in eq_update_ci() after the doorbell write is a signif=
icant
> hot spot in mlx5_eq_comp_int(). Under heavy TCP load, we see 3% of CPU
> time spent on the mfence instruction.
>=20
> 98df6d5b877c ("net/mlx5: A write memory barrier is sufficient in EQ ci
> update") already relaxed the full memory barrier to just a write barrier =
in
> mlx5_eq_update_ci(), which duplicates eq_update_ci(). So replace mb() wit=
h
> wmb() in eq_update_ci() too.
>=20
> On strongly ordered architectures, no barrier is actually needed because =
the
> MMIO writes to the doorbell register are guaranteed to appear to the devi=
ce in
> the order they were made. However, the kernel's ordered MMIO primitive
> writel() lacks a convenient big-endian interface.
> Therefore, we opt to stick with __raw_writel() + a barrier.
>=20
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
> v2: keep memory barrier instead of using ordered writel()
>=20
>  drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
> b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
> index 4b7f7131c560..b1edc71ffc6d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
> @@ -70,11 +70,11 @@ static inline void eq_update_ci(struct mlx5_eq *eq, i=
nt
> arm)
>  	__be32 __iomem *addr =3D eq->doorbell + (arm ? 0 : 2);
>  	u32 val =3D (eq->cons_index & 0xffffff) | (eq->eqn << 24);
>=20
>  	__raw_writel((__force u32)cpu_to_be32(val), addr);
>  	/* We still want ordering, just not swabbing, so add a barrier */
> -	mb();
> +	wmb();
>  }
>=20
>  int mlx5_eq_table_init(struct mlx5_core_dev *dev);  void
> mlx5_eq_table_cleanup(struct mlx5_core_dev *dev);  int
> mlx5_eq_table_create(struct mlx5_core_dev *dev);
> --
> 2.45.2

Reviewed-by: Parav Pandit <parav@nvidia.com>

