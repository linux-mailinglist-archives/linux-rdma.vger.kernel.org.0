Return-Path: <linux-rdma+bounces-8457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D02A55EC9
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 04:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0001898FF7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 03:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D618FDD0;
	Fri,  7 Mar 2025 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F6isHy8+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5F18B476;
	Fri,  7 Mar 2025 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318895; cv=fail; b=J8C3YkKQaRz1g12Rt39YD5/yV7UGpuyF8S9jtAwnrnNq5i00oJ2kI4Z2E7NXEArO3hc8Zv3BpxUg+wq6wu1G2dzXPoVeQ0fUoD2+FNuGSCeIxOitGWth8cTxA/kzWcvmt0RHXPHWHTSXbVs5GMzyjstOxxRdyJyI/j9MESBeA24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318895; c=relaxed/simple;
	bh=M8BiimQ85kTN3MoV7UFNw75ZMpcKAjgaPlVcSrNy6+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f9094+198At1rLyY7RkI0Jhr6VhnhcDcFLorilLIEgZU6SyslWDf/W0utoLj2haLLbPkFfqQxMP6NFXkFDeQpRtNEikjf6nO/SsF2ZcWZF4AAFNs/j9QFXMdPwPI48/DsyjcScOcL0RNuo/+vOpsXaC6QoUstfiOX2EpUAA5dyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F6isHy8+; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/583hZT5a/Pn+ZuA12W7mX4VDH7WBjvMzePUUtUOwgXeL8h0NtRCZehwVEVGvDI/QPFRXxiJNyOKBHBkIJlYAEf1QX0/gOIpuu6gCjiKKihKMyDv5UZN02Dwts0dJFr6OIPvmWPLQEtlM94lXrALllXiCXPMUmY8ycKUwauizD8HmF/7yfc47+V5rqApxkx7jNWxy96Sh9aVKeNEJqtV3/GkkHF5wCGtYrb8sh7gMhp97B6w7gisK+iaxQKvBz1bssGDxPH2OFt5Qempjxxvoe9XEkk+p/fPTUJLeVWGwF8TYIAn6Z5jaLhegtER5EoHRkf6bpdZG8L4OL0+uta4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjlt68NpBEN0nkojnruvxSYZ9qRFh3pBXjPx7ri59Rk=;
 b=jVw/8mZqsKYi3wQnr7R0UumHqPTbDbyx7irxpFOq/hKXpAZJev7oUEP1/AvDkMvc0yRO4Yc/Y989uPltQQuBgKQ0VB99AZq9m18fhXZ8fFDd4ANXhW9Wyro/s+YM6xq9fIoEchiCrvh5OAeB4NrVlp3N/0sw7thBHGv56hJK2/aapLGDAMQdR26qb6inTf9nc562fcKZZZm1UmZCPcToVBZNBOa7Z2Puks0i8tyHeRuUqLVPnDE3UsMounpx/lJmMo14uk4nWNUktImozJxobkx7GZTgBZRSBHHGJONy6CDmwkxbq5iNgheDHt0WjfGghbERE9ru+Dwqe/IOS29mAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjlt68NpBEN0nkojnruvxSYZ9qRFh3pBXjPx7ri59Rk=;
 b=F6isHy8+NRSSwuasZBEi4oLwaPorIGLb3Uj8AtliGlVeCt20hM7gYiIiMOz61UGbi6DqQuZ6tCSmHhBSTVgHZq1c/fTYxlxneaLCAQku/w2dW6Uwhn1hCIKhVLAYPnPyFt8T7CwKAdPgzsL4NQyWiodApqVT8KioBZr/MGLPTBtR80eQhD4xJny66RWqjbwHKugJya7GD6SbYNM7UE3ZOF5l2RixsBSK82ITycqbLZ4BBDnjJL8ErkIGlhwABTI4OCkZozp99ovTM3RCtbqtCLDTjR7PPkfxiz9LW6rfzdCoE4mv9HbSw3hM7EhiRAJbLr51q2xH5b5aNmYegF0NHA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 03:41:28 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8511.015; Fri, 7 Mar 2025
 03:41:28 +0000
From: Parav Pandit <parav@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Pirko
	<jiri@nvidia.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: RE: [PATCH net RESEND] net/mlx5: Fill out devlink dev info only for
 PFs
Thread-Topic: [PATCH net RESEND] net/mlx5: Fill out devlink dev info only for
 PFs
Thread-Index: AQHbjt6HRYszW9Ygfkqxpr3u5v6IirNnB5lQ
Date: Fri, 7 Mar 2025 03:41:28 +0000
Message-ID:
 <CY8PR12MB7195A3B7FEB628BEB03C7B7EDCD52@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250306212529.429329-1-tariqt@nvidia.com>
In-Reply-To: <20250306212529.429329-1-tariqt@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA1PR12MB9466:EE_
x-ms-office365-filtering-correlation-id: 76c04a25-e7d4-4b90-71fd-08dd5d29f1a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0broleKhBHJdGwlidasd2wjxLEDazVL4rP04XsP3Ii47nFiJtEILgx3rJ8Ii?=
 =?us-ascii?Q?QF5+mmw6g7W+3buHrl/Nv57nMYfA8nHSx/hzRjSrd/N6KUHpI6bO+ax4TNKz?=
 =?us-ascii?Q?TedKPIWQpf9jN0Esb5r/rRixjCra4SpLmOzBFMmAMulgnUVH12hoY9MPLTFX?=
 =?us-ascii?Q?G1pHqRcPQ9zCMTX3IWdNdefl0kqJ9jV9TdMmPe1j68YnA5A5GqFS+qBwEFAW?=
 =?us-ascii?Q?vmqEOZrliORiDYzInHpAtHzvCVvx6W5kVlvZlTYBRrD7VbJdgqtu0F0gIDvl?=
 =?us-ascii?Q?QyOKzCZfvIB3fXCC4xHT25AdMr6TSl9Aa7YrV+2OWuFXUUFRTdQpYnecvY5/?=
 =?us-ascii?Q?WGHF5/UF0dfB2RxM69wcdPqdD8yzQFpoK4vP55Pvgnab6gEKyOmIzlv7Y9HW?=
 =?us-ascii?Q?Bp5vb3kwIgKwImyIVSzShlcIQ5FbXxeucc/6FnI2/jAP2kVXltV8GgpiMasT?=
 =?us-ascii?Q?dimM9n2/LW43OJt6if9cwSSERLGYuyJNqHJEjcR97l60L0IKIdkWrCz07wXG?=
 =?us-ascii?Q?cGbaM1E57XEX4KYqidBLpz+3wS6ekX+TAso80AHcjwhUeurxjx5ajo5BTeDG?=
 =?us-ascii?Q?BXjCDtC6ekUgny54IFr9nNryhPmsX1SGOqCU46p17V7FqtcihGAbJYXAcRHj?=
 =?us-ascii?Q?CXA8Z7YiB3zQz2nhYlEMqv67NxLnGCwMHGIYsTeAC01XQuHkrlXFvou1SMY8?=
 =?us-ascii?Q?1q9g5IPJZYatFEumfHgH2b1QPBGJTnkZmZV5t4KmYu9vJvngEBQjT9qb7Jih?=
 =?us-ascii?Q?vRlFyOe+KF9TGb+0ECgumWcIMwt89JLfvmpnFSOAKq2VxDlGwUFCXS+ogHgF?=
 =?us-ascii?Q?rRnw3eFkoWrriIhiQYzYEWas9hTuumEKHWvO1ypXhBF5Ye2LYwnHvsP6+9iR?=
 =?us-ascii?Q?0ruBW95Z67JbrC4N6uAQ08b3mFm1xKSD8WyyuMmq8McCdaZKLoJ1rSJ0RsK6?=
 =?us-ascii?Q?0SrbcCm2vsQ/e+igAb9NjM8m9r7iY2WgjkzsTY2wO5QHuz69HH9uA5fWqbbf?=
 =?us-ascii?Q?99WzVWrWDsHhsuNhPF8lWradJyHDSytYb06rt3vGgv/ffmKUcj9Jpz0y5q3x?=
 =?us-ascii?Q?DJYfLnENipd+zdSNxLW+dzbHd896uv4N3VNo74wkP3O23rKlzOpzZUAS97V7?=
 =?us-ascii?Q?sEc8+bk+em2ACKZRuTTF/pcvsEPROuXKMz9ZgTC+FZQV4rXVRvaaJLHIzP8h?=
 =?us-ascii?Q?gvw5OvI0Ou2jdcMS9W4D67z2mUrwK8v/yN1PFfQhf2Jkq79ZriBuvE6Za1zd?=
 =?us-ascii?Q?dP7q9cCAwg5GfTC9jOXaxWKUMDj+OlKBTJ6OJjhaXgfc4uiKW745+BjU/FsR?=
 =?us-ascii?Q?uATdSgVlhmbGTdYrm2fIdbAHJimCM12FxSKdk2BtdM0OmP8mQRSgLT9fqIjz?=
 =?us-ascii?Q?zuAg3I7fgJ1EQcbYrfllMup9k+PBu51/u8mLIzWRahAlnPpGcfgk/5l1tHLj?=
 =?us-ascii?Q?jd/ZDzv0R6ekGzZN7qQwKH2/j3F5zzkU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/l7wJd8FDgGpdZByNhYZYIp6PE0BTbpwtjHDMLVt/2Mhy16mM0f2UOp8bq6h?=
 =?us-ascii?Q?RQNOb7CJdXgPBkXy5O37MHpFWm8LcTNUW8vK7SJHX7WxPTwbQSCI3ghkiRgq?=
 =?us-ascii?Q?bAU6vp3Ih4D4Vx1MR46At5sMgfME4d8bXI3dqHqMIAbvQO2KxiY2Po76kSQc?=
 =?us-ascii?Q?wZg84YsiJAdG+9GWlaS9iZkeopUIIoNem2AjPwZe/eDVboJ6aCSbwQ+JKW6h?=
 =?us-ascii?Q?/CY4rXe9hUmC/oeEjrhiRmf23uT7l1JzvuirKNl0j/9MAvuefgjbcW6W4OhP?=
 =?us-ascii?Q?hLARHLOyHrQC03sXJwNN2fHPy/HTqgBgp1+Pnd0fqP30WER5VXIpHF45Icth?=
 =?us-ascii?Q?WQC/J1WiNH4ixrpkLxHQwvAnCeRfz5VYdzCO9XSxO5hhwTAX8WHaiu4F5Cub?=
 =?us-ascii?Q?f2F3X+8OwPG2XtUomNt+FWHo5apcQVndT3uaigWzFPd0XR7IKseo/dKlnyjb?=
 =?us-ascii?Q?iOVd8wqvpY+F1v4eCmeJZJpfjGBchOEk2hiafG4Ed3YSfs1MhaVmrP1S1ieQ?=
 =?us-ascii?Q?xaZ4U0T3eaxcQqgKVuxzM3apI1k/BYdnM8oRuZSRG/4GD0uv6ZHgYVtv7dy6?=
 =?us-ascii?Q?YPZ14fkAFmPv+9AXTCq0ensD4Py3XjNsSgy/ETrj9jhvkGEDphScdzVMX0nj?=
 =?us-ascii?Q?PAJChH/2x75BKynf4jusQyKwlKJaPANIUCSk4eAUH8FlCyYyQOHuopmSkLJA?=
 =?us-ascii?Q?0ggRl4J7qOO8GFzTgEDowKUISxEbbBJjggdvB7VULXpOmCu3ibWk5CyE29yB?=
 =?us-ascii?Q?A+ry+wO6geogv24q3v6SIhTImaCTEZidvE5KFrqV39Jwqx0aW4UXHf+F6kvB?=
 =?us-ascii?Q?JzYdXYi6tMtV20B660fNJLm2qB3JTz3kPd2Ksj5xIFztcHHYg2y8+IteSDbi?=
 =?us-ascii?Q?yb09gYBKyo4oB/fN9YN5pgfxTh0Nt3Gr4BjscN6OUdXqTHaXcnXKC4IJwn9j?=
 =?us-ascii?Q?JV+rjMF4ymPsk2p89Jl2tnilTxPjsWYPwfPngkboaCpxGz67C61IesnqGVhH?=
 =?us-ascii?Q?7mUyuIGZZjlv1yCL0lt53EukFZXtbiQeBdNSGWl5x0yOF1dvZa/g7NKfdqZR?=
 =?us-ascii?Q?9lu4oFeVEd0/Qo6Zwp5YTN4UajAKdiuLkvXdQIozISLngOvmjcf4o+O2f2Qc?=
 =?us-ascii?Q?efcAJiQmX/M2DUxPk7NVlMkIzGRb0cItBQgPpcEb5s+uWb9KS7adL+n1ms0q?=
 =?us-ascii?Q?agRotiV72chOhn6h0PxNz1qa8tyHnOgycacP89YJpd3U9KS2biKTEvXEfR0B?=
 =?us-ascii?Q?psa+fzrPm9RPlZlsEZhBTwlaRDjpWteC0qNg9SdjgnAagRTSBa0FdVJ0/6OM?=
 =?us-ascii?Q?2nZVX3qvQjj/ZxHKMVpCi0R81CnZ9oIwmUmfeRcPkjSptdd8Mmj9ALZTDJjG?=
 =?us-ascii?Q?RFzdq70EYRy3cRUBN18O/w30cx58n8IARfANGwJW2ydR9UqGkSAfGgyBIpVh?=
 =?us-ascii?Q?2WJW2qEOdsLDq7etpfbUxZ2cpAk9iWltUPU2U95gzsVl8dPLeAytNLEMuGcU?=
 =?us-ascii?Q?PU1EUeKD6mG1hkyNvEUnsFBafM6hLdGzKgQ8+Sxc8Nl+dkTff9UvQvOJoduU?=
 =?us-ascii?Q?wQMx1VXMVhJo3MIB4+Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c04a25-e7d4-4b90-71fd-08dd5d29f1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 03:41:28.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c11Q0XfIYRi2/gx5Gn3vslHv0fYfyRVC6u925kuSTUCKUTYpiBcg/RqWuIIvCq4nV+AUFnKKn5t6sTpZhhcO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466



> From: Tariq Toukan <tariqt@nvidia.com>
> Sent: Friday, March 7, 2025 2:55 AM
>=20
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Firmware version query is supported on the PFs. Due to this following ker=
nel
> warning log is observed:
>=20
> [  188.590344] mlx5_core 0000:08:00.2: mlx5_fw_version_query:816:(pid
> 1453): fw query isn't supported by the FW
>=20
> Fix it by restricting the query and devlink info to the PF.
>=20
> Fixes: 8338d9378895 ("net/mlx5: Added devlink info callback")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Parav Pandit <parav@nvidia.com>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> index 98d4306929f3..a2cf3e79693d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> @@ -46,6 +46,9 @@ mlx5_devlink_info_get(struct devlink *devlink, struct
> devlink_info_req *req,
>  	u32 running_fw, stored_fw;
>  	int err;
>=20
> +	if (!mlx5_core_is_pf(dev))
> +		return 0;
> +
>  	err =3D devlink_info_version_fixed_put(req, "fw.psid", dev->board_id);
>  	if (err)
>  		return err;
> --
> 2.45.0
>=20


