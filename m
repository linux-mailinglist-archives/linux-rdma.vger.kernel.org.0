Return-Path: <linux-rdma+bounces-4623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA27963E2A
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6318A1C224C5
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C64189F4B;
	Thu, 29 Aug 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="G3+QcZEV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342318785D;
	Thu, 29 Aug 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919328; cv=fail; b=OAn97Fk5GCbaMz5SgyIJqOu7r0I3UnG2ATkZMeVwshmRp7abcFNQnGVr09cDQRa6Psv+y18P4y0UaxHlr/xjbhn8l5e+3aeDNtOgCIQgthtD7/qOqDg1oQFZCYIYUy4sZQPRyKwzln+3H6YZpWDi11N5/2CvWSyhEKwd6ms5HkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919328; c=relaxed/simple;
	bh=ebAsSFzjYXAFeCU8uJrtcD3w6gcJjm2piU27PVnI2mA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SXRFAtIdY+Q2t5LZLZga/dKaR5lc6naAzi+P8CD+bFJeB+vQITwFeo1GU5VvaGYPOZohAVs40R7/uwpt3AYXWf6UpFKYE1AEqDLd5uUiugALJK5RhEsDg9R4BQxwwEy5x/EFlcVf3uTk0bVH/o5yjURveUsuEPn0821oY8cThhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=G3+QcZEV; arc=fail smtp.client-ip=40.107.215.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWebLvugS82JN2QxmmqoNSos1PbTmZ0mAX8vSNq4RKWF0araPDU/pEFZwje0IiN8xDRhDJEFbq61wmWM/NQ8f9MYrUx3B9ySkwLecmOvHQaU+DsaK8haBtmi6blFxAFcMCDhK7ZwYyNZRYsa9sWZtL0m4j+YtZN9ddncyd6vbmAr8VXojZ+Y9fq55U9NJd8nK2064QRpDAApEaEvRBmrW0iIC4PlxJIDgzfKXXVUubX0DN/9xAxEEaXF3u+idBNdyktlPeUGMPmG4cGZqR149Yp0wf88OtwGgssdZpHp4eiSZyyGW0OoC6JaCQ39WCOqY8o3DDuAFkJMZQNeyWfswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggD5m7j+bIOHcBD0m8kv+7p9+U+HPpNJz5K6gSzZZLc=;
 b=okd2PKUEM3s3RBRj/0cxZDF2nNjeoNSquGBcQqkKLIkiZp1IeX4X1GlULDH0wphFA7WxfmNG9gm4zOTO+h/D9U85jsrgRs8PwasChoMBxrxsVgNht2UhJCXTKS4jOKeFBfEXzSwlzepHB89Ybhn52/9W5kzaiPvzOFaZE75qmet7wXIx9axV62kzSAQbu2B55Ve0DI/SbPxjPVgIyCXWPpldnoaptmwHY0j3hA9o4ybQmRYt3lNPYcStxqKxx0h4g8HbiThHOnS+9B+OkeI/m3zc8oYoLQOSwD04cure2QY2HaniEc6Sap8j93l8a/yWbtzdBaaD+lkfuMmod8Fpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggD5m7j+bIOHcBD0m8kv+7p9+U+HPpNJz5K6gSzZZLc=;
 b=G3+QcZEVadsK1TCHFd8PmdZJ7eRSl238OnogSZbxxtJjTYZPe2rdE6tuTNvzkZ3TOK0nivI8di8DIpfsOP4f2meRtOPA+NPBOX4fDVGzBYj/5V88szAlfEoPi8c5tX+O3+KhwlP2CuMWOzB+WoXdyod/MzKK3lQKAEmjSsL/rLV6c53jj8WzQ/hfC84I2hZFbdScI6Qz7xuUSVznlzeGGlbQ0xdYmdbMh7VLZewjz56T+bFvC1b/k1rZZTYLKYNY2JiDoFIS4uj+XRyqbxxIxuJLTvZegpqzZHLMYSQn5UvuEJFuXKJ9ZczgM7LOx4gtlYTOC5Jb2/LFf4TwqMnT9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by KL1PR0601MB5584.apcprd06.prod.outlook.com (2603:1096:820:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 08:15:23 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 08:15:23 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1 net-next] net: ethernet: mellanox: mlx5: core: Use ERR_CAST() to return
Date: Thu, 29 Aug 2024 16:14:04 +0800
Message-Id: <20240829081404.2898004-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0156.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::16) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|KL1PR0601MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba66356-30cc-4a6d-a2a7-08dcc802bae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4B5bBPu1gC0QrJLp40Ge9Nz9VkgnPgmdNLQqVDckJKJK0LeHsNvL8d6qwf4o?=
 =?us-ascii?Q?o9MvhZpwd3u4ER7Z5UYN45Y6gJ5KtcxHTb77eyTzG/n5HjqlcRpDgk+8GGyO?=
 =?us-ascii?Q?55NSKPNZemeUZwqVlP3VxhAqao3a9mIWTmgZG3AkkOGteGKrUqn0zK1ATYYM?=
 =?us-ascii?Q?hF2UdOajfmgo+c6UAf2MD87SdO3+S3HoDx9OlFlR6hSqElCLZWD6xyfdgc0a?=
 =?us-ascii?Q?bH+rwFqCYaC28pQO0/V+PXME2CWsiivtPZNNeswe5FtIssj+C12lLEILVPjB?=
 =?us-ascii?Q?NI0rcZu2pMtlSEbHdWbWIPAWh55N61XyZCXx6GJQyGWIZl2S1iTLNUKs8aiZ?=
 =?us-ascii?Q?kEc70scylETX5wGMM97tnguqgVRp6Bv045qXdpuH4v1H5pL6Nu39kbSwcPiT?=
 =?us-ascii?Q?DqeCI7ZiDw06OBUxcKK8JtP2JHQvvk/VTMpNt2olivoAy17vHFoHZgtaAb0W?=
 =?us-ascii?Q?Z+BvhEtLA/nVs3vkbxYsIQVXdmubjiOcbvDNTPHkU+UMhVvR9Yj8P5fzX5pf?=
 =?us-ascii?Q?vqF5zNaKDqZNXdMmpzHdiiQzyw+pI15wQ0IUx8qFJysEz1FBTN2MkGcGoKyp?=
 =?us-ascii?Q?tCIhICCUwlCtWgvszi5xPODdY27t22MKQVKL4qcaTQOAoq2Pa+GWLnP94tVh?=
 =?us-ascii?Q?vfHdHUGCpSJJYwuzd3D9rWvxZos3N8isNuOmctOKB2n4Lxs5u0YEpfcdDlJW?=
 =?us-ascii?Q?1FoDmmqe2e4eU1DosWJs7zEEbTsPRxdHKIn3OIU9Vhq2KnQL0ToDCnFbfIiT?=
 =?us-ascii?Q?WSx08IMdxBh//cn2/vhchUotKB7OxJLtJlXcfnwLovIn7Uu24AYcZBXy7HcO?=
 =?us-ascii?Q?xOFfekLHF8sjs5N6jp0QVg7FVA+410WcgY5t6XaFg6QioN5K6u+yrDoU14fT?=
 =?us-ascii?Q?yEzuIO4mPRuSGso3VDSvH5V4DybkdozG5JHxqGq2r6xjcp7sek55nPOJ9uPA?=
 =?us-ascii?Q?V3x2YYA7xAsWT2wR1uT+y8sFJNr3F9SXPjg05TrdMIn8Gex8gKzko1Re1SR9?=
 =?us-ascii?Q?5CQ2OryWb9Cu0Ut4cemly2zmyS0pd/j7zghbDhF7MgQNE/xzcf2LOOo3IRC1?=
 =?us-ascii?Q?T3Ks9fgFnflC405FIGoDSNSkzKguUvJineV6URw5y6nrfLxLrTmDO9OrxHdb?=
 =?us-ascii?Q?uW1tcECGI1izcr11zIivZdZ0qvsDl/eKCowiNsdnK+PxhlsH5T9+ixMMsr58?=
 =?us-ascii?Q?ZgLyLCABWPesB5MfNrQWo1Yiwgjn501Sl2uqKx/U+2g6yyeFnuvXsKLUpr5M?=
 =?us-ascii?Q?i21ndXEMEVWEZu34RPeFORpSInmJHOR20wVTqe7ZJQCgI6rM9WCeAUTZIz4s?=
 =?us-ascii?Q?Hoqa1ubRTRVdCWRtp4R5rx5EOgF8tg6l/72wXxKUeErLCsigdoDcgGldLvW+?=
 =?us-ascii?Q?DQHAHxQ0m6GVLv/bLs1NMgrCrW7K+NArrGDM7BYci71AtthA2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6M2EbmOrbQ4ZX1mL3yJnll6kv3OV7cCpbNUj+mXs84YJIVU5ENLWk0n2C4JJ?=
 =?us-ascii?Q?sZhfrYvMFbgPHI9OTSWba7/KirI9tw2nBweC6mO9WPQeAFMS1ENBPuLaT0/I?=
 =?us-ascii?Q?vqtLEf8nwj+J4Arh1fMsdGcJE6cWlPeqT9gduBJGETBbbVhHWULyaIh5k1sz?=
 =?us-ascii?Q?oOZuv7+dUQU6p9FJq3e3lQ8iLcajXSLvvMjRyMX83InJ61vuFQ8JfVgM1JVi?=
 =?us-ascii?Q?Po9U6ZSuneG01YUqHe6JN9XgEeKlgkaWfiKX7ElzUlAgr1/b5Lt6fX9NUyf3?=
 =?us-ascii?Q?eIyb2npTpZbkipXJwIhn+UJI2hlumwH1vRCCaCZB1HqFJRvCrwKRAH7qQMh5?=
 =?us-ascii?Q?s7tl7krBOgQBY0Guv+zg7VAJAd6/JfXAB+Fn1l/5XnZNBXrzy5woncVPtuN/?=
 =?us-ascii?Q?AMSCX9B4r2A3u3oXtSbxNDkUjKKpeYAhvRNNv4aklon9whIcyUyyAm5Fjr3y?=
 =?us-ascii?Q?dRTzNnOInw7lyyySdA86gAfawJVYx/1K8CINj4sICMv1Wfk4JcvVR53cO6NE?=
 =?us-ascii?Q?BpBQMNhoxnYPbN/+S8dNLzquLqQsadT9zCdDC6bsXATzPs9lSI7S+px2sLve?=
 =?us-ascii?Q?uQWDmKcfrY57QcW7pYGgEbY4rk7MR9y9F1Tyc2BIpzSw38Xn0lF4it1hlTP/?=
 =?us-ascii?Q?dChUNDpm3bOKYAjXEgzktqYsnU+KLvA8iDi5bTdysDMIZp2NevDuzR0aYs3e?=
 =?us-ascii?Q?o+4xFmUd1CFh8m3PT3VBp+Sw9OpHbSyYvHnxnXJBywKv7yne37c4zmdwkpxw?=
 =?us-ascii?Q?zcd8ioN7KTfoW28GDjUmS1ZG0FOtDe5P5B6ks5XvFgV0nwQEqKOfE71sfUG2?=
 =?us-ascii?Q?EDgXJkQRMzkYtpwjQ26q4+nMLH0bqNY/E7VEHA76S3O5M1jmgRmrz0RX0V9l?=
 =?us-ascii?Q?p6PR7llrLmOuvA3yUIU1LEjSIImDbA1GB8Ywg1KRJ63126TU0gylj/aD3sYg?=
 =?us-ascii?Q?yZSoZBXBLRlxdyS5Kl5Ej4vZtHiS4ZcKUgLF7dfvhsZDMGJnqIpUr1nTnf3R?=
 =?us-ascii?Q?I0UrTh+ziIzFq4r73WSnN/5WgzibQeP1NxfRpw70DgMvE8HUpO43Muno454N?=
 =?us-ascii?Q?z7WSBQHaTe5tVtwcGOWG1yHcXZDGM8BCwjp6cdrH9zONbr/LL+YhYosI9Uur?=
 =?us-ascii?Q?DYIHmz3DanYPVtO3lXfGCE+gAbInIQ/F+DQbB3z91qvl6d5bxG0Okflmwc4R?=
 =?us-ascii?Q?FKRCVCeeWFbP6KFaoLRIMcSxrk7+YbqGmsfPX+zyHXGrY0vuSxw3CyHAXRG8?=
 =?us-ascii?Q?eQ5S8qK2vhgOoskRboLczd7IFmkLlOdgGTWAy4ubpt0fa7rv3F3KDpXVdtK/?=
 =?us-ascii?Q?tT/A7cOY/6Xmbyf7/O4fE6i3y0qEKXr1AEHovOpGX3Sh66TqPycPTzEw6egC?=
 =?us-ascii?Q?hA/EPiVtCiOnGxs6PJe0iRSQ6GO3tGi7xjnzZPxochopB/rXEKe60MiVB5Xd?=
 =?us-ascii?Q?MNmqhVoU32opYI63XbwApf7Hq++9J11AJeDqupfp2iuup7IOaw7qV1VkTLFt?=
 =?us-ascii?Q?r+73Mx+heFrbp3a+/kY+Psrl3htQgSfygyOEQHKI9iKWF/aDIS2alXw+bplG?=
 =?us-ascii?Q?K47Gz9eG36FBWoLsYNbBBt14ZmOtqFw5Ej2b4sXx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba66356-30cc-4a6d-a2a7-08dcc802bae0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 08:15:23.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NytqpZn8vMVUv8mE0gI5FNcmgLU4ro3AfVu4yat1W9GjQD9drAXjLgXTMs4rTmzwQ+7TSmlGR/1ePNXqP+Mzng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5584

Using ERR_CAST() is more reasonable and safer, When it is necessary
to convert the type of an error pointer and return it.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index 773624bb2c5d..2a0f70987749 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -130,7 +130,7 @@ static struct mlx5e_ethtool_table *get_flow_table(struct mlx5e_priv *priv,
 	ft_attr.autogroup.max_num_groups = MLX5E_ETHTOOL_NUM_GROUPS;
 	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(ft))
-		return (void *)ft;
+		return ERR_CAST(ft);
 
 	eth_ft->ft = ft;
 	return eth_ft;
-- 
2.34.1


