Return-Path: <linux-rdma+bounces-12949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F679B3820A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D4D1B64089
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393C43054D4;
	Wed, 27 Aug 2025 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KQjA+1Ak"
X-Original-To: linux-rdma@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012071.outbound.protection.outlook.com [40.107.75.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22C303C9A;
	Wed, 27 Aug 2025 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296919; cv=fail; b=uZnJzfCgRYQ+ZDYPqrJD53ZaA/ON0m0oyy83ua2bweNxnBOgmFrMlgseS7+sOcBbopmUaZioOS2fy/SgM9fUvPnjLfWIR6pdlNVRmDlGt1DJRH1u1F+AVlRVI8/j1TOex39mjWivkcCwLRHGANy+a+9pOyee0P8u9bhEFC0OWwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296919; c=relaxed/simple;
	bh=eeZep+1ooiYRCryIKuno3yWBGEj4taO9jFd5SOw/LXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nte5fZZH/eLFpCOLdMK5CphcApCu5X+lclBoADZxhnMPJpQvwHSwjuzVzhnHjSuIQd6a8JFeVAih6+O9xGZfuD3plooVcXOei9u5aUzWkhIJu83qKQpR9/6ar/4Yl5kGs1y7vMQGk9Kq0KDoTYeYAy/SxpOjv1wUC7uEEiL9aAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KQjA+1Ak; arc=fail smtp.client-ip=40.107.75.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8vTh7rz+6v9icJEUZTNq1ajvlTYym7n368nUjTuozMEVLVuxxby8a6+TgpkVYMw6wN/0JBZjgy8Dp3cg8rflTtoHlOajI27HLihw9PBGzcSvGuFOSp7WJa9xvqh4s8n7i1GIQ26S5evi1SX6qVeazNZnt8Bs8AeUfQQ9aPjADUsOLvEp0optKyQTiPjA8E0D4onB1vD/i62m+vUtIfdlvD43TZ8woT3n44U8WyhbBqHNH9zo7EgkuaCBv4kzn63FQiWhazYH2KER+MK9Fazx9ggX9cwgMxnEN7BUO8VkZPYH34uHGHKxawNrKy9zlmlDjnXRZDXWaBtqvB2o+MEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0G75k1Dk/bE6QZ+iqlffpzLduvAmGEhLrKlMpWaFc0=;
 b=dcYrFJjXODE/ohsLaTfbm+WD99+vjJZE9z9Y0H2npkDOM4yrxArlMFJqJK+iJVjrMMwrudtVOyAYeb6Pm4qFl1mbMnK7GOQP4WpFl0rVEUPKmJNCGTYj/6DIaw9z5tAeTvB/i7RPveim9vmBEQbKgzKekTHRCN4dODUM2LaNBDs/Rkhhabte3vau6l8EaVNVRSXd0ZqwrHUS6bBz7Ruw4V6jhapdFGWJ52++9X8Fj+rnPqzdaQsahx7wH3F+B4GokSvcKJJgNtQr50MJYBNwLYWhT1luz0sowWR6ThkJf1uC5jDEHxQOxnR88Jt/OA/1mnYidwflmtwaliy3H5Mwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0G75k1Dk/bE6QZ+iqlffpzLduvAmGEhLrKlMpWaFc0=;
 b=KQjA+1Ako3jnSW6Y5FpML5DUHMhz9Ic6mmGxqjqFOGRqx2ONIic5dFevi2MjhNJ7OARF6Odn+3qZD315TnBVwFpMMykxM3dLl+cArEZaNbPRsjVKFVCuFPxqJQcaDWO2EMiUcMDn84Rh2Tf1eSS6E6u4aeLd9NpfyyoLoBZ0NK0g7RUjKT+LMXXca4exzIicY3qMCIcYeyupPEDbVpGJuOMeZalQElTvW+THZuiQ3dkMdQrQqfbTP7eEkuuCYiqCb0LEacopJpSBNaJiaRXMWbRm7fbo6N+0LSpFOBdlBnbt0edTql5VtRqZ6JhP6JjyyAEvG5mF8FN6Bf/evUZudg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB6684.apcprd06.prod.outlook.com (2603:1096:101:176::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Wed, 27 Aug
 2025 12:15:14 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 12:15:14 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH net-next] net/mlx4: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 20:15:03 +0800
Message-Id: <20250827121503.497138-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb1d341-4d16-4632-7ea1-08dde563607c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2GOtlHA7Av6whfe0UepWsUQRejuVLevU8ncD0EKkMTFXWuzsxABFeB7N1pBl?=
 =?us-ascii?Q?n3las6HRm0W5Qfz7V+kIOidfUx/j4Y4vipvwrN9mPp0HxvvKG70gjcuQvpJn?=
 =?us-ascii?Q?rvXnN19lM6KsoqwBwQ25pjAO97DTdkBdsf5DEFT+N9ISf+ZfR2TxPNbu8W8A?=
 =?us-ascii?Q?aQZOcGBJXN2K+a1GAWtp0UcI6cWTOaSvg1ZSCVRDAKx3G6uRXVt5cTOCuMeG?=
 =?us-ascii?Q?WzNeBR9oY2IJHQ2IhI+8NII0ZM2TgX6l8p/7z7RH6zbg+ctWvqs2B1NLn2Os?=
 =?us-ascii?Q?uJ+sdd3SLR+wDmm+9wkhF5QN34M+XDkwn9pKTiEBZp+WaWUoQRexl+X04ds0?=
 =?us-ascii?Q?GGoZiuKYYZVbzQU4oKY1PnrG531MKZAwCQyDWugVG93ylmMaF+gi1cfltNEs?=
 =?us-ascii?Q?y5hXw5WHRGOslfPuoyUCsgImq91YMQYVjUk2Dbt5aAX4SnVO9kUVW8RnvNKG?=
 =?us-ascii?Q?SGGnP3JjnwNC4FSSTyu04lhbf11FMPCdojSCF3p8Z+b90bXD25FAGGSscJ+T?=
 =?us-ascii?Q?J4gPKbmbZZmiOroIX74cybRtcfVmeDUfSxNLFGMwzhgIsM8jTFdwVdDfU+hu?=
 =?us-ascii?Q?rkygw/fHHgUCnouxTXDT78lgRtqYw5hyIT+TTOcGI6oQ2OAU04wtjM7ofpJ8?=
 =?us-ascii?Q?IAWA3lJcW0GBux8jFcQZpOgW8lje8kprONNO39TdNAvbwtYcZ7CLz6qIOiaN?=
 =?us-ascii?Q?RjmoeOTF/px3OszJBstC1pVdTWko5jYgS12pcOkOhHYxXvxRzAfcYWe4J0Z8?=
 =?us-ascii?Q?rlPcKkHjBevKDguVSYeZfm6WZg4ULLaAhxBQpVvrYqZj1z4cXzF4a9pNKvKn?=
 =?us-ascii?Q?RjKr4NQsPltXUUpLyKmHoCLAN7ulUoVqDhUzEJ08cFTNN4aN/oj6/fBzEYau?=
 =?us-ascii?Q?IrpULYsSc4gyJDj9+k1oBxZ1Ca99CQ8TppaXIuPIoZV0R4+2Mldy5qsO2+cP?=
 =?us-ascii?Q?zLqDB/RCZ8ZXfA9iN0z6KtV6T44aIZS1VauXtHMbbvh6qcldX0+Llky/xN7T?=
 =?us-ascii?Q?OY6/J9jTobCMAQOiBPgmg+44tKEZTIUlk6fPNpw68olADVUMfvUg4qClw7+C?=
 =?us-ascii?Q?3C7osOraMyIZWt6TVad/l2kaT24eUs2URNcVHQ+LshWsZ0spM33fs60jGCxT?=
 =?us-ascii?Q?mUnYHnQBEMVVYbgTgmrSgc+/QViFE5AhykcAMnpucNxTyMqGPQo18OIdO1mA?=
 =?us-ascii?Q?k0hmeR+i/jaZd2tSJKOnxMzgFE1rpUuj+3JBAb7AzkjU5lElyEljUXVpeLzE?=
 =?us-ascii?Q?1K9HdNkvPl8MBV37B3AlVC//J2/xKdDeuKyrn3fuRQno9mc0bqXDq+yiIQCz?=
 =?us-ascii?Q?rFiCuE8vKUICNUkgycejXKUEzBvpyji5Ceg9Ma+u10NYuq0qCgzo1AS1FfFr?=
 =?us-ascii?Q?4iO9N7aXkfxisVDBD9b5mJJkuiqb6otG40/QAcnoSIq2i0kdmLG49Ce8A69/?=
 =?us-ascii?Q?w6RFhn2UXJ7bF9FaH8oPP13w0ergVfQ3Wytd6mHQsqvmAQdSX59H7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cn0w8xOrDBgubqCO5HqDVFhXVN9fZJint0cLg4akZ1vSOxjR0/eeVedfdj3l?=
 =?us-ascii?Q?gFYM0yEWN2r4d/vEJECYkIP6XK3BTb3iUwBWUzU9cJaIcxDsf7if34X1Ar7v?=
 =?us-ascii?Q?X3mIuGykD1AkDR0Gb6xDt/jwpeVJxbfo3ndIT5nrwxMZ2p2oSUBh1CAVbNQ6?=
 =?us-ascii?Q?XpPu4fXjv17VpGf0QTjqED7zwTSiQQdxHUGWiTzE3njrzPWJRZDDPcxbPfYr?=
 =?us-ascii?Q?Fz8KHWXWjfPkIUse6yzapu8cJYowsXvxSGLnYAgobJjfk2FX+7uT3FHK7JZX?=
 =?us-ascii?Q?77NIvw8jc5zQIMI7tcKnlHTmKZUkUMymFz7vPsCBDYYPjP+ot8G8o8JEATIr?=
 =?us-ascii?Q?BlJSAN7b5VVfhZRQ9UjVajQF4x/uGT0xwBSfBSHgB4imYOLlTxvz6t22sOzJ?=
 =?us-ascii?Q?gamahtIhpNqyUxRGDB9tJdf0y1X8TTnEHI7lkeQ10ny797d3ibiApD/WNvbX?=
 =?us-ascii?Q?DXIias0lA7GTowCnEcn+NZfq6B9/6trd9SzL4VHKCV0Zx/CcOb+lcPPyIg1d?=
 =?us-ascii?Q?o0k9WOB99SCVCus4XE6ULwcPV38YwwhCxf6Z3yBe0woNDFfyjL2xwHpa6C6n?=
 =?us-ascii?Q?d1HsEVeiDbg+raooIPfBKZiruncYtqY+jqeKqyllaxTeyQwHve5Wq/P649MY?=
 =?us-ascii?Q?bZuLr2+hinLBU4pH2hVlfixqT6s833RIvN7HPCHAxtGq4aqte1OZS5nFDaS+?=
 =?us-ascii?Q?9d5gF/itv4rfWsWc/lLP9iq3pAQbM+ZX6yF2tx4gDGBqDkjYhH+44EmsiztP?=
 =?us-ascii?Q?4GgGtGipNtBV7wReqZCowuoWPM2sVWIPkKpRtFzudBUIOeaTLsllkJsYYqJd?=
 =?us-ascii?Q?vhpIVcA4qAF6G5pesPz8ZzJmehuVIJ9rxEXwA/2UeIfNsj46ZuR/yxjyBdmm?=
 =?us-ascii?Q?9sfeXPgkSSdkeAx0IoE+MkLr/T6IoBd9mseGiGOFzqNbj0NByyo5ngcbFsHe?=
 =?us-ascii?Q?shQNinME971081wEpE4O4yE2K6TNNCOy96TBy0ogU6rOYnZp9fOnqZ/yi6lJ?=
 =?us-ascii?Q?9FeA2UMnfP8JQyzMhIWfdTb5zk/CxEwbg+bhnEayTOJAobFDpMywA4WAF6ZT?=
 =?us-ascii?Q?D0MbWj8vK+D8k01IJ6IgU+x6aSq2M8O+A2t2YV6heM6ClqvHwt5WO/sJJb++?=
 =?us-ascii?Q?wFkJ7GEWRp8tI2A01I+AzVfGAdDhVOF/6SqkRk3pMfiIAwgbZMQZKRaFVKu8?=
 =?us-ascii?Q?5BRCQta7br0g4d8xHAn4ksV3qbTFafwHVFU9G/ojRas0aN5Aa2ip4+FURl9u?=
 =?us-ascii?Q?lBAQ22eebG7k/EOmpjKrPOzQmaFnveonU+CVafhYkFStiGG5O0VRT30SlTSS?=
 =?us-ascii?Q?C+GQL5SAZBeuUoYVrmtr+tF5wz/oDvJlV+4hoAF9+7RcgE+3mrXqklHeJ/UP?=
 =?us-ascii?Q?8Eo7dKdMgGtuZIOH8R4lb5Ud/xZIhM4jKAkelHXM3iMFDtanVpjvsO12NNfo?=
 =?us-ascii?Q?dqkx4Vd88yy0hs4jkITSplKpGg//V2sMTrHkQEqflIOs7U6TTTy7FOzz9qQX?=
 =?us-ascii?Q?Xj4AkC9uOfotipoOoHxust3WLrbu5fUkvm8JQS0H63RYWJbwpSeEv90bRTG+?=
 =?us-ascii?Q?wgjN3RLXHHVYpTBtOOoogLz8WJNI1kuuoRr8DKey?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb1d341-4d16-4632-7ea1-08dde563607c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:15:14.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuFpyidQkTpMC3qxxGI7bnezJaU4NJKewNchGL8xDy1DA6EZ/EQiPVL2BdsnEbqeVxfczVYXuBe6vJrF0r5mzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6684

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/mellanox/mlx4/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index e3d0b13c1610..5abdb1363ccc 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -156,7 +156,7 @@ static bool mlx4_need_mf_bond(struct mlx4_dev *dev)
 	mlx4_foreach_port(i, dev, MLX4_PORT_TYPE_ETH)
 		++num_eth_ports;
 
-	return (num_eth_ports ==  2) ? true : false;
+	return num_eth_ports == 2;
 }
 
 int __mlx4_register_mac(struct mlx4_dev *dev, u8 port, u64 mac)
-- 
2.34.1


