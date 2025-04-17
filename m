Return-Path: <linux-rdma+bounces-9524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28216A91F2E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 16:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BF73B26C4
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F592505C7;
	Thu, 17 Apr 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssE5GeJ1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C60224EF6D;
	Thu, 17 Apr 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898984; cv=fail; b=HR8wkhA2NAumwkER4JJ5+V/ajMGlYGLSNgwicy58jo59WwBraMO0HV8wnI82MHtLwBCHCbKTHBMXPmBiz7a7BzSLcAm22P0bojZrJ35tKNejpTvZSch7L8bVtAY4jIckZP526dGDINatFlqiu4bJMpYRpqeBO4jvQHUF6Bgm178=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898984; c=relaxed/simple;
	bh=/rbmkQh4rSRZnUmMpA6fiXO9OyZrfyk494wq+ellvGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DjBp5D5Mk9VIxUvg5Ok3smF2YW322AzzsC3zAD9XnOI9/6Sc9xRYjn4hewl+IA9N5uV58A32qdRPxBVCraosauhpQVAejKPndih0Syl4oC3facCjMDWx47cpw32wy7SgnuJU1Glnyt8phO3P0OkIy9wtD5thV+dodQCc7bSbliE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ssE5GeJ1; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxCXGYKm+SOdz0JfkTe80WusHasHhqhu1j1p+m5SHc9RYAfWKLohp2wCm+jtmy5UpsxZzE0UAlXo9G/FxY2WGDBJd0Inp8ZnmqqTeSv6RAUmgtiaF99m20LeU+uy3aXW7ngBvzaZqRr3WMpjV6JfHVrKDr/2DdJlYTpTE9LCqSArqJfYaeqyUA0WnaRlWMs0X0BBZa0q4jcQeS5Vh6ka1s0s3QsgyJiwbcFPQOHtqCSKGgRZLdZNQNNj+ZZwcqYCSS33+PJmnrx5E1Pfhh5mZWoqes16veB7tULC+t+poNAkSJNrBWtJen+b+953t2+KWWlpdi6/amZm07U0/kejzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2qOh/qjvHLcqAmOrrfp1dPsMah/mIpERRxb2/AYMMk=;
 b=ymcn/iWIwP16EXh9XSxnrGJj3l5+VWKfYnQkWWwxUvZZpcABen3NCsFG4E/yFqLBD0HoYT+tWE93Tnv3H5HtBjZ0NoZ3ySAm71CcFV1bZGlFDFht8ZoLuB/dwkXjLxPFYFbQibHJHT+f7JjThuKS3HS5WNFnAH5xSGHmRZDLOR+9M8/eLiNTH5R2ylHclVtosFb0iSN8/JXziIn6oshlM+AH15yuuwFeXAmVLyzg/aMjxt17XtozeYWTcNmgq5E9uU9zbWBDxoKJ5tGe3Z8OrXAERMxmm/T2G+RmUtvJr2RWS+xSsdRLt5UpcDJkcKSpa22AB3K88oIKx7+2qaJuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2qOh/qjvHLcqAmOrrfp1dPsMah/mIpERRxb2/AYMMk=;
 b=ssE5GeJ1HSHU0CIpBa5h/PaNEsf1wWH6Pnq3QVs5Lb6FJGIFLZ+KLD9lTJZ+uyM+Ee69glpoAUbKHoacFmCQomoNdQnQAW/c+QfAiRefx7csm8LQAXppx6R9Ko116InIHbCil+pGNnoPliUUckZQoKdDEiDNqxosSFPi4WUDjXUbj8j/EETv9MqT6TFnCV7diZHXP3RqNSzqPfXJV6DyTHrp5n1zwqtRGnuoFcrx2rRBThqMmSfsp62hV2Bd4vxFvhGNPM3kMGAG8/gwW0tF7LPJU9E3zT1fP5ABc0SYlkI90/wKLnF4kSUi5b3Qlv2+q9gS2gxFoTBDupVFrEw7Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 14:09:37 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 14:09:36 +0000
Date: Thu, 17 Apr 2025 14:09:18 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Kees Cook <kees@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: ethtool: Fix formatting of
 ptp_rq0_csum_complete_tail_slow
Message-ID: <d7cj5kz2xnm2wg475oqs6fyc77l2aictw5gyq7n5oogp3g4pii@bibogucg42s3>
References: <20250416020109.work.297-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416020109.work.297-kees@kernel.org>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8932f428-ba97-4e0a-a245-08dd7db97c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?11juNpc98OR/3ZmaB+UAv0TBNjk80LXEw+1b1eEkZl1wlr3zxvrCGbEjK5ST?=
 =?us-ascii?Q?Xy6WRbBPhCXFrfHK8G7cWRsNn4wCTimzKwIJK+Yo4JJUe+s1uFMKw21rNQ1a?=
 =?us-ascii?Q?HrWQdiOAzjVhcMohAID9o9mM1GFNRtgcjLPmChJaM0cy9aoEXoJkvSTh8/LP?=
 =?us-ascii?Q?IcYSmqsZGWzYLclhKivRZgbXR10I8xafvn1lNIZX4XFQEk6HhE9sFjw6DU0a?=
 =?us-ascii?Q?YePwJbyNowmSLwOniL2FALl40bqlD3h2Qide8nU++Q4m9N2CVQQqEoPTW6fb?=
 =?us-ascii?Q?bpgmdwhrJcgRdYg9Xe5tRjLMHh0EQL9JjMmUIPXKNDsiHt3seuBfMpNj4Mfp?=
 =?us-ascii?Q?SUqKf2k5IGYQvFk9ByKGxdryamw6vJuhEL9pxC8YfjHxAnDzSG3zqJPS51Db?=
 =?us-ascii?Q?kls9q8/TGqknUaR6VxRVBF6k8j2bt2AScPobmE4HKOywHYswNg/MBaV4gaWp?=
 =?us-ascii?Q?Mq94rGlK+1IAyMtC9V971KfuS84EVC6JTOJLFhhZLzqIPCV6a+Qh2JymgMKY?=
 =?us-ascii?Q?37pA35TcQcyET3uZYkLR/lhdHhzJO+i6zpsHoJT/rZG4x1saAyBHuXLsEnVM?=
 =?us-ascii?Q?vwp5Uhvef35GtEV3V0/Mxn5se7zqBf9MoO2VycTPvGlwdW975wcuytgr6Ha+?=
 =?us-ascii?Q?LyqFYUOINnZoMQaVfeeh1703wA7a3C5B8py4wPv3JqyBb6dKhoau8KldaOeh?=
 =?us-ascii?Q?+qn0zmm+AtybllXqpPIPqvCDItOKwfQnbUK2y5yTijM19IJ3h+CZfpfvcJBQ?=
 =?us-ascii?Q?kRYPxNBNGfVrpaG5/MV2vCDutlKW7yf2SZ7Yb5AnBUXJ3N5oy24vSBbXNG8Q?=
 =?us-ascii?Q?5kxhD5eUm2IuK6xA7bzo58rTVlZ4IMMiklyhFVMCMwWVxbbrC4nxL6k4oIME?=
 =?us-ascii?Q?ddjQviq/DRgfDwKr5iHX4I4IUqEGrF6Dqr7Y6k7qq4OKzs8GwIcmT2wIeBch?=
 =?us-ascii?Q?XXzPfXJPuCKSDCy5htbxzrXHghJjijHbHPRAkL1uAVQsHWzPeZi0lD8iKcVL?=
 =?us-ascii?Q?P08KqMxlx1654fyN9Yy3mBj+UAVX12pwF8bQ+fX3eJqcm3mMS0Edi/I7PwMX?=
 =?us-ascii?Q?to84lQX11LkVpGarslHeA90Eu/QyBU2XaCk5AjYmhpesSb56rU3K9VMRbIVS?=
 =?us-ascii?Q?yEQe5K3g+bqnZkPuJi/TJllEl6sVb0xZ3dGdXZvmTekdJoUJ9m+oHSNU5Hhi?=
 =?us-ascii?Q?cvhBXODzu3CUmo8FpgcNckOITZBZVtJL/33EkaRap3MpzHEfRYEtqF90Xbvf?=
 =?us-ascii?Q?frRyVwkVk/6ND0B5WN6CbGWbYLVuhzSDq3b5uu4cY/fV7nW602ltrdFKBXSO?=
 =?us-ascii?Q?04KH3kMdJHafvKVpCwX8fyQCkcwo9rjUZnseetRAYWvDdsBKXRfkPouinOwn?=
 =?us-ascii?Q?kHw8Tu7Qsj/toY21LN0cMnt5sNs3hXjaZEkdlk9ynW5wXpIkwLkJ/GVSCJjf?=
 =?us-ascii?Q?h7H/0V4MrgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHL4agGXyBD++R7lMErRBN1RCW1dmCvdf7piJBKbK2Qhj7Np4uXRMoV0J0zx?=
 =?us-ascii?Q?xo3AMC0AK3GAdsW8Zw2B0vZw3YBpz+cz98kuLv/ceHvHBr3LTVDLNUOo7BAK?=
 =?us-ascii?Q?V9rs0YxrLXqHVtp6xIV8OxHiXh7MxnaJVpUe5ZQlj/045Hz3rr7A91VYC0AW?=
 =?us-ascii?Q?Y5jh4OUn5NZVem8ArYiQ1qbAfDdEVWtUbu1KMGvezmGyg5XE+uD0SkodUlP+?=
 =?us-ascii?Q?DG3kMTgoWlAiHctj134aj7Og7YUe4OaVkPwC7deV+jAYazfLuN7yFFgu1N50?=
 =?us-ascii?Q?4FOBdiCJ+zM3kbYlgoxTrJx3aBATtWBrGFK+/A5Uaq65NaNR2owCpomZAIsR?=
 =?us-ascii?Q?EZ6Ikkt/eZMDZZ1ajEQq3+C4pkUDLaM6HD+xVVYraU2dXaZPz/PuExvQIgfr?=
 =?us-ascii?Q?7b4hH3DokKSiJTeR4ktsVubW7gMIWKkn3/YXxBIoztYQzusyChHnmzx/eRwW?=
 =?us-ascii?Q?2URlfZ5iO3UjIEgTf4n1iN47UDTHgT5NJpv5kjJpKhpoXPU3DW6i3+TPQrOl?=
 =?us-ascii?Q?tde0pqMT9/DrGdvhoF/K/XQMB3sOUWTwcLtxxOKHg1gEtnvYqr3OUw9kyxQC?=
 =?us-ascii?Q?VVOwKeuC/vEnzLQitIN5kuDoDcowvkyf8p8FossdLbYyI5A/XM3QsvC0JBz7?=
 =?us-ascii?Q?LpPtjqk7E7A4hq/Gi24q4/L87lHPxKE2BGyn+Sh6g4r6CWxR3LVLerZ/+XB7?=
 =?us-ascii?Q?EJXFp7TP19rsibd853jkzw3Zlbvt591RZhS/ro4QDH6qrWAPNgA/NspFY+c9?=
 =?us-ascii?Q?0b49OxUb18rUxdPS4SHA9tTQWGlZyTrNOWk69X7k+Lm+uMRXJePg7dH/yUB5?=
 =?us-ascii?Q?YkR2AtP5B3/8ITrrKpcMUM+o1zHV2mLvvnkP2JWjCyS451iSYlx2FvrNHXRc?=
 =?us-ascii?Q?uIxaTsM+YpM4jpow92jk1GHcAI3xp0rmBv1MxTzZaIaPnX3yPD6dF0zcsBYI?=
 =?us-ascii?Q?P7qgbKdoHnpox2biwM3cTSM8MGmuT6dGFgBSRKo2j0ZCGOh0FYAJw54dfUT6?=
 =?us-ascii?Q?1am2IuA1XxH/v4EDyF6Ga2jcXdtH3fXArzdguxmn9Ej8U+o9DQIusorv9KFq?=
 =?us-ascii?Q?B67zRbcvVnNc41jhw/v0OPFxJ6pIy3ru5zPc2xqm33Iafdo9BXRJUGDK0XQO?=
 =?us-ascii?Q?l14flloy4TtEUvk80wlzPiAnyyemcoUGyoAugEkXQx5ZNEzt0EPbZnOvNfDw?=
 =?us-ascii?Q?jGGpGlDhF6cn/q4vPazoIHjqxJKJfARupXwLyN4Y7d+bVHHuzfI3lEoeTdpZ?=
 =?us-ascii?Q?/YJuaQMJH6Hkk093qH7il9lboGWvciudr5enkez1EaRJIYgxfJfLACYmJl0U?=
 =?us-ascii?Q?5hDIrYw5FHSWHssymodY1JMO7pPAr1z5lmZdvbBQg87eu0X3hGfaqnqNyl7i?=
 =?us-ascii?Q?/DOEpisHEhBipKE30LKmecuVEgsc8ztt0Hah4RNCxkNx2TDG5X12yZZvTI6l?=
 =?us-ascii?Q?JftGXEF/Dk2a/zT0OMt7PXpOHr314cRZlmtVc+0PypADGTVgozNQXsyzbCso?=
 =?us-ascii?Q?unZPrAaT/STRh+dC7ooiTWdsgxJpig9muoIiirxJrZ/nWh9LUprBaiMa6KFA?=
 =?us-ascii?Q?ZDk2iNbR/AQN1Hvj7qDrYNvvU49MONJwks/5j26T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8932f428-ba97-4e0a-a245-08dd7db97c58
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:09:36.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2oU3lQa1Fo+2bML+SF3oI79PmWbBQU/u5fL20cCMGKPqPCyjg6b2GlBOZkg/3eyU+Y0xTFoCH3qcK4otcC+VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231

On Tue, Apr 15, 2025 at 07:01:14PM -0700, Kees Cook wrote:
> The new GCC 15 warning -Wunterminated-string-initialization reports:
> 
> In file included from drivers/net/ethernet/mellanox/mlx5/core/en.h:55,
>                  from drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:34:
> drivers/net/ethernet/mellanox/mlx5/core/en_stats.h:57:46: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
>    57 | #define MLX5E_DECLARE_PTP_RQ_STAT(type, fld) "ptp_rq%d_"#fld, offsetof(type, fld)
>       |                                              ^~~~~~~~~~~
> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:2279:11: note: in expansion of macro 'MLX5E_DECLARE_PTP_RQ_STAT'
>  2279 |         { MLX5E_DECLARE_PTP_RQ_STAT(struct mlx5e_rq_stats, csum_complete_tail_slow) },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> This stat string is being used in ethtool_sprintf(), so it must be a
> valid NUL-terminated string. Currently the string lacks the final NUL
> byte (as GCC warns), but by absolute luck, the next byte in memory is a
> space (decimal 32) followed by a NUL. "format" is immediately followed
> by little-endian size_t:
> 
> struct counter_desc {
>         char                       format[32];           /*     0    32 */
>         size_t                     offset;               /*    32     8 */
> };
> 
> The "offset" member is populated by the stats member offset:
> 
>  #define MLX5E_DECLARE_PTP_RQ_STAT(type, fld) "ptp_rq%d_"#fld, offsetof(type, fld)
> 
> which for this struct mlx5e_rq_stats member, csum_complete_tail_slow, is
> 32, or space, and then the rest of the "offset" bytes are NULs.
> 
> struct mlx5e_rq_stats {
> 	...
>         u64                        csum_complete_tail_slow; /* 32     8 */
> 
> The use of vsnprintf(), within ethtool_sprintf(), reads past the end of
> "format" and sees the format string as "ptp_rq%d_csum_complete_tail_slow ",
> with %d getting resolved by MLX5E_PTP_CHANNEL_IX (value 0):
> 
>                        ethtool_sprintf(data, ptp_rq_stats_desc[i].format,
>                                        MLX5E_PTP_CHANNEL_IX);
> 
> With an output result of "ptp_rq0_csum_complete_tail_slow", which gets
> precisely truncated to 31 characters with a trailing NUL.
> 
> So, instead of accidentally getting this correct due to the NUL bytes
> at the end of the size_t that happens to follow the format string, just
> make the string initializer 1 byte shorter by replacing "%d" with "0",
> since MLX5E_PTP_CHANNEL_IX is already hard-coded. This results in no
> initializer truncation and no need to call sprintf().
>
Thanks for the detailed write-up!

> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 3 +--
>  drivers/net/ethernet/mellanox/mlx5/core/en_stats.h | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> index 1c121b435016..19664fa7f217 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> @@ -2424,8 +2424,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(ptp)
>  	}
>  	if (priv->rx_ptp_opened) {
>  		for (i = 0; i < NUM_PTP_RQ_STATS; i++)
> -			ethtool_sprintf(data, ptp_rq_stats_desc[i].format,
> -					MLX5E_PTP_CHANNEL_IX);
> +			ethtool_puts(data, ptp_rq_stats_desc[i].format);
>  	}
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
> index 8de6fcbd3a03..def5dea1463d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
> @@ -54,7 +54,7 @@
>  #define MLX5E_DECLARE_PTP_TX_STAT(type, fld) "ptp_tx%d_"#fld, offsetof(type, fld)
>  #define MLX5E_DECLARE_PTP_CH_STAT(type, fld) "ptp_ch_"#fld, offsetof(type, fld)
>  #define MLX5E_DECLARE_PTP_CQ_STAT(type, fld) "ptp_cq%d_"#fld, offsetof(type, fld)
> -#define MLX5E_DECLARE_PTP_RQ_STAT(type, fld) "ptp_rq%d_"#fld, offsetof(type, fld)
> +#define MLX5E_DECLARE_PTP_RQ_STAT(type, fld) "ptp_rq0_"#fld, offsetof(type, fld)
>  
>  #define MLX5E_DECLARE_QOS_TX_STAT(type, fld) "qos_tx%d_"#fld, offsetof(type, fld)
>  
> -- 
> 2.34.1
> 
>
Thought of renaming the stat but then it will impact current users which
is worse: csum_complete_tail_slow is a regular rq stat as well. So:

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos

