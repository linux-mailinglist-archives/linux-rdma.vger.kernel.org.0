Return-Path: <linux-rdma+bounces-5866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646919C1B17
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 11:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E69283667
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA331E3DC5;
	Fri,  8 Nov 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q0UjQfzQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61C1E32C3;
	Fri,  8 Nov 2024 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062991; cv=fail; b=jYyFmciqqnmXKXysUi5kUtJDN1v5z1Q6gU82EmMXsD8bUUGN0mjBP850AF7Z98ocjbN3cGobi1LJheqg6/vOCHF2O6HyJ2/52tkArWu+2T4THEVb0S1+47mc5NkMGX43JD7/0BqTdGiByxPchCeDmUYqucoNuX5x1ptGpdxM4mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062991; c=relaxed/simple;
	bh=qJOnAlHa3C0mS5sIav1MttGbFq3TTtKgPgMjcK+CXA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W1sg6S9h5Sv9NiF7552WpdkO9qqmGyHWP4spR6MHyVM2rPl/l1W0Z+2B90YVAJic/QtHDQK0CPuDVBl7O0gVLw94OLyLCghU6Ae6Ei3jhHr1jrA/q5dhvc7nVHVBnZ9VO9Kexd8F1FJwF667EVbp5iWLpjvuwXcHJ2KR1HH/CMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q0UjQfzQ; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/p1vvy9Beh+2bpkX2DO4fDZ+Ye9KD9SyUk1rMmDydNwcZcS/UVNglChEQC8fbPN/8RrrAu6IeuOtFeTa3axU/0tFovUMeMy7zZk85iutsILXWpgFwE9Yl4s4lxZAAFM10oGsHKET7RCrEFklxC/LPzf2Wh6EFEPZ/qPxDUWrG80GRpsw3sVS2GU/CyphGJ/IvhSGv6TWFTRgfTtvk/ZNKGDdV1TaG2iZCBX9d2OtKTP9jB2LsFnP4+pqLAXb5FF1AYsqMADBNuP8Wn8lgjnI1hcQ5rbNg86d+F4z/2XRM7vKJ5c4Ve0LvcXULpg6XAGDmgJ96FYzUUYetbEIbLviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rR71MoMKH3VX16M7nMhTEzhnZp0s/EeSYWzoiRfneo=;
 b=floTCOLqfFJiIyX3/MDABo+Nus51ZLSjkit+80aD/iE5X7Bn90AjnuyPDnH5qg2wE6bYBHxgtswZypaKFScXCUmaDP7J3uCIWzrp4Z3ZBDeE7yI8FA699T0r7dI/kDY7FcEnlLNyloFkHTLd7iMFF+cBVegAdIaALXZGnmjeEoESVo1bG1Np6n8Sif4VUf/Sw/8/gNAMVsgiHEOX2ZnzhMiKMoQ2Eh0et56vzT1XJ6pUvU1VWX9Ktxf5kP4bRFAOUDXd5oLVBhulEKoRh5TyvVAfihsDt5cvPvQwDSzYM8rMP2IUrxvQNk3W8ttT898n2Q3sgHBBkADQ9zrgSyTUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rR71MoMKH3VX16M7nMhTEzhnZp0s/EeSYWzoiRfneo=;
 b=Q0UjQfzQvJOcqB2mviZRAurL+czsX3u5Ed+YGN7ID5lxA5BfFqlpy31C7vah/57xjIcahJ8NdRCZzGfNFbHS4kim9KMazz5X7p2cZYxvyHYru4SBFC2wMFtoJEtf2++gjKfoFASPn8XZpXmQ4m3cwO5+JKqYCnOi/4EvydpdWkSYQqCpU7qxkHsALtSbsdt9ptRQvwWQI01U32uDxH/8f6hJVGjjj01Jikap17HhPVSKNcsFP9QPaVB7RA+OorNn7Z5mncAYgWtuu4Xrmgo8xSRbbRIU/EgbXtEUsfmqc2/2GNITdAvTZyWpviiJNfGrkJIsvb23Rzrupr7cTOiO/w==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 10:49:46 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:49:46 +0000
From: Parav Pandit <parav@nvidia.com>
To: Caleb Sander Mateos <csander@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
Thread-Topic: [PATCH net-next v2 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
Thread-Index: AQHbMUNNUQUBUfLoW0mUeZiggSxqP7KtNTsw
Date: Fri, 8 Nov 2024 10:49:46 +0000
Message-ID:
 <CY8PR12MB71954BBB822554D67F08A1CBDC5D2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <ZyxMsx8o7NtTAWPp@x130>
 <20241107183054.2443218-1-csander@purestorage.com>
 <20241107183054.2443218-2-csander@purestorage.com>
In-Reply-To: <20241107183054.2443218-2-csander@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA0PR12MB8984:EE_
x-ms-office365-filtering-correlation-id: 419e636b-9e28-4f98-44c2-08dcffe30fd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2uFQTr9DOXX4M+FkHn93HuQguqi9gR4P8Yun+eAUuLjcAE4mMb6X0KKQVq4B?=
 =?us-ascii?Q?MbKM4QHhmNLJqaTs/M79JP1xycxCX7/QFTGIxxWt08SkTh7giZLqwDJqByYE?=
 =?us-ascii?Q?zCC1K/1ZDahnQGcRNPY8tlMm0MhV91B9mIkCYTCpmWGgsz2xZrn74xlHeR46?=
 =?us-ascii?Q?c3nKIMwj8RUCJI82d5acRBhzMAPTOrutsCPR/x4Ox0T2qW+bRcg5AKBMyGo9?=
 =?us-ascii?Q?UPffDv1ruyjqQYOzCetN0F0CmW6RHEWc4DA5pDUH0ujbuMFrLGLV7E1t+hZN?=
 =?us-ascii?Q?3XAFUzpJHO6qFvp5zgqdO+KoSsLBAUBscqBRxUL0ayMv7u4dXPKqiceRmZCl?=
 =?us-ascii?Q?Ab6W4yb9orm+rKxB8IMhzFnuYP2QZQ94JjzPCiWxFNGObOkbKoFGa34cYvb4?=
 =?us-ascii?Q?U5m7AEhzUQomWxg7Ucc6pUEY/oCsmB2T9gX8xIWIQYeqbmNmtEU4ZNxLGpZZ?=
 =?us-ascii?Q?mWRWOsgP+Pr82sd+pH9wk6dDgyAGWmc+eWmYQVlo7q7aTXUcFOxBfYrXPlC/?=
 =?us-ascii?Q?3jvm7F8oaOJRsDjEJDV5NA4vqPG6VQYHMzSJ7wy7gbS9WMhHu0oW3yR019B6?=
 =?us-ascii?Q?X09jQ5/4pLiQ+8N+i1hIn458fyM5rF/w3d5qPjP7c04CNFPFNtBmEbx4/J0K?=
 =?us-ascii?Q?OrOTXLFDQaJRCkgWVurtfkVHhflpAXmXUzaSxemd21II/lzE0BRgrJbCmK7X?=
 =?us-ascii?Q?5WHEptKHqcjWBe2TKhxgPr7B9Xa+5WWXc6Ey/tNGJNPuggho4bg7p0i4WYDm?=
 =?us-ascii?Q?+BBVK3QHY6vML/cN8t+tHAT9T9lah6Rw14KLj6wHFKp91blGjwitOgIHZZvQ?=
 =?us-ascii?Q?5kkdFyzwI4g9TAPLUBYg0iYqjIdljMTFRk6el4wKa07PkfcrccPvXCfApKDh?=
 =?us-ascii?Q?UtRw5mEhocGM2cpYxB7LOIFHSLX7L6ZOLMOFYRse808QrR/e8JMtieaocUw8?=
 =?us-ascii?Q?AODfsjvMdHPBqmdhzkrB+84npWjb/UlttC8ODmDTh+JRz47wFw34O25ZwwXQ?=
 =?us-ascii?Q?fLN8twpwAGr6QT/Nh+QkZa+TNG7kFXG+EWv0aoiKLbwZ6S2ExaDrsbuqfmro?=
 =?us-ascii?Q?I5CXlUVIgig0HxgMznoG8jHG9OJuIjLz51y6+kbg9JdaaGRP2ZIEYxHQTdDG?=
 =?us-ascii?Q?3Hrgz90quAXrbUhgPZ6TxdsToHId5Tr7Vc1Be3E/XdxPPCpABdF+r1TIX+XH?=
 =?us-ascii?Q?NiTwGJCWdLjwFp0xdok0+DW8yU+93htqyBVnkNMcfPqATryskOM1uOKnu+ww?=
 =?us-ascii?Q?N7eP0c09s2wgh1qs5q7EPS1nLrgc5/j8KRMzk2FSBeRPmWeoBLOkLNGQZ1Uz?=
 =?us-ascii?Q?oUdzi4zc2b8ZP8aXfk8kl46nkhZHZ6O8ESlqIGUE/w7u3zey8OLVFEFtUzLP?=
 =?us-ascii?Q?nA72Qy4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uMQ7NanqrQy6mWeoj5EemgwWe1IZnk/WF/S5RCkhtVvB1Q6Ier0Dw/5hyTql?=
 =?us-ascii?Q?Z+Hd/XRbkxSmfxVoYx/Avz8CROwv2EVCi1Y4N1TDZ7HTRlRa71TorK8usroC?=
 =?us-ascii?Q?X9xHKjjAoFNHltXPaPWBwE+n6r+kZMvfNzw/Jrk5fZUJl7JV1mvtNaikzR20?=
 =?us-ascii?Q?XlpMdVxX6JCehTfQeJ0dY3ay7DUXVbgOd9CErE+1fyH1s0U5MqNAVyWhtlbA?=
 =?us-ascii?Q?iAfp7G6QhzI91T40oXOwSONIT5Th0k1ofzYWN+w8BP9cik3QsBV4Ff0ARzjh?=
 =?us-ascii?Q?lhfR0jLAbBhXpxU0HoIH7QNweYXJNQ1oXlRYqnAWJTw9aXP9vlOGAJTEx0wh?=
 =?us-ascii?Q?apJZJO/UiE1iNiQMazFGweYKuW0cLwC3AcP/N5O9LFH6ZHr0ayE5H1dNPVa6?=
 =?us-ascii?Q?qljPU8ZmO6bYTtq6VTm6pPjIT0heIoFWxQOd4kvigkUP9h72WkwSkywJMYYX?=
 =?us-ascii?Q?IUkYwsGkNYQ0/puLGvRN6bCBmwonpMnP5tYNW/KlID2RMUwp+6e/hv13b9oB?=
 =?us-ascii?Q?kBjX2htTWthWNpPmsKP9b5KFEMqkSlhw/xGhS7iJ0dmIUcD9pfGr+t96OyjO?=
 =?us-ascii?Q?/C/WwK1UWCPDiaelgkKGGt85bLLNb7DtepuabY6bd4+VUO6bO8iSeYUGIVRu?=
 =?us-ascii?Q?qowcO30BiidCwHrwnLYmYRloZ7l6fy3x8BXs/BHUsGPxeRvOjfCxYZtlnLxL?=
 =?us-ascii?Q?z2tlMOob6D32vcxFgKBYEdbKdw0H92X3UxPMe4qFYmsbbx2Pi5iwnwti+fIt?=
 =?us-ascii?Q?5zCcCv+QM+6Th6VTfDl9XzhoHKLlgSBmoUIBJ5sypFv23OSvjDGoZVAnPf+h?=
 =?us-ascii?Q?3XW2X9fO/aL1Vsv6jrlzEqFTi9taIkYnX45birQTK+/sn4N0P9Ef78+BNk05?=
 =?us-ascii?Q?klhN9Py+Ktfde8tcXQBk1Z/NSc+3oOASnESpmSXbgDztkK4VR0+snPx1046D?=
 =?us-ascii?Q?VmbwfJqvHO58tdpofAF5Pkhz6C9vXltrARsKxBc/3KtDBlYTpT+qmJtEwIvv?=
 =?us-ascii?Q?l8MXJawqLJ5UTL4CcMivZFeG2GTd3SVeDZB5wHbhw5wAFrOs0aKFuW3cIyMW?=
 =?us-ascii?Q?J40ulIu15PZJ6J1YlnY7xRrOblWqtOkHTKTDJiC+3Q1S7CPkqxNoCE+DbQwp?=
 =?us-ascii?Q?F7I5xBaZyXO4HHa8KyjbxIjLN8H7FUn+Z4O511j1C85akRKtLH0sFg6aeWrA?=
 =?us-ascii?Q?I1dddMo3dzT1Q8q0sGtZbNfHAijZPOk0ManrcpMfpw8+DHFbdm6LnZrWop/u?=
 =?us-ascii?Q?v34BLK1O7zl/ME8vd9Ysf/v4hsCb81BRkrCp7oCr4FfFy2CSR6oqUdeMlBjN?=
 =?us-ascii?Q?09ayL5+jQmkt4qLXPvf1VxpeUGdyIHHVpwzlOwYlFFDOhx+qS6BlHW/sLfMV?=
 =?us-ascii?Q?zVgYips64C+bVMSAxrpe7yu4LXNx6vzkKYRVLgA21EnYy6ED6LMnv8wqAejc?=
 =?us-ascii?Q?JvAkLPC7FwlO59mJKawEUDnrqLOdCTPkdOQM2sf4C2F36tHEf5BNLp99lCn1?=
 =?us-ascii?Q?UEsGMws4hqD7LxUbCjgVflKib3vf0HMtxFNTmRgN20VZNBWAoYZfh/DdZFbx?=
 =?us-ascii?Q?NvvS+rni6xAF2ahFWYE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 419e636b-9e28-4f98-44c2-08dcffe30fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:49:46.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qt5h1UMOBDARYDy590DSNep5YbvyBRdEWq7Djnj5zfV+/Fe1ddL6aVR+r7rRVzZKZB543by296Y6+B/mUGwTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984


> From: Caleb Sander Mateos <csander@purestorage.com>
> Sent: Friday, November 8, 2024 12:01 AM
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
> @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct mlx5_eq
> *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
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
>  }
>  EXPORT_SYMBOL(mlx5_eq_update_ci);
>=20
>  static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx) =
 {
> --
> 2.45.2

Reviewed-by: Parav Pandit <parav@nvidia.com>

