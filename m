Return-Path: <linux-rdma+bounces-11464-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E55AE062D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 14:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31306189D2C6
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374B23D283;
	Thu, 19 Jun 2025 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="h5JkxBqp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013005.outbound.protection.outlook.com [52.101.127.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468735963;
	Thu, 19 Jun 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337287; cv=fail; b=m5VHeFs0vM/6ky9girDGkiGeeKZssHFXeiNXaekwPyxDxqSOgVS/Ws6+fEVoCmoaj4jWArheO0YRk3n8m012KNAbm84JkaCZ+hNZ/pz5V50pzIPVUuwyz5C1ai0sgudMNUKpc3grf0Jns8u7GlfZsu8QZ5trWpcjApZ8WVNP9PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337287; c=relaxed/simple;
	bh=kf8wTOtuLqoS4iUKIaJUynLsCTRV04Pm8QnzTkiX7/U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ktGNSknUo2SWCvx+Q1ubTO/dmZQwerO3NX3MqdnamvFmSXio77OeSHVKDxW6Zqp96PzTyoI5AszleOqMJb40j6WxJTfTVI98sFdgLTDiyn+qJ4fYja11snwBYf/z2gis1LLZ0ExRp+Z/BXuRx9MYMhgTrHzVzwf9M0lCuJTdL9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=h5JkxBqp; arc=fail smtp.client-ip=52.101.127.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYCFL3ec4DgXEi1GahWe4De4nPIht+epb+R5P0VmHX6T0yDC0MCTxPot9ZH2ZxIdxHV1rtgLFrZhI17mZATPkFTWB53Ev4i+ExGCrbVbChZ0MnF/L3Pewvf5kbCmXj0PiQ93H/AApeVACBXu3kuxhxy7GaW3MN4yg9vDBHcgooeoZIG/QAVcwuYrKWDq89BRtZGvTsTIZauN9sk4pr66wtbDsTprJb+uU6XKgvXJMWbjKf5wdGrK9382yGbUcv9YLoJc+l1mlsLBnW6IhFngS8Xmgn3jsFYErIYPA6ZOAjAVmku0ZVv7lxjNxMlq2W4HUHEhFnR9E32WrX7SZjLQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bORQrDJnELL0f0I5+pX2lnRS8128FfWIeMT0eLxiKuk=;
 b=h4njlWTnkd5dszgur0OlAOblom+uVz6yAtptGuFPwpB5EHVhq39If65QRIFtMDnvmJq9RnejMYhE0N6ZDRYlBQSYY/x2MXSVJVj99e802AIJZmjnmZzltiU5rt5n4Er8KYwsC4hvJgKWTZ9H3dv7mMZqNRUX39G4G6SqneVqM1ljegWWfSB8jCUrG+aOKfTsZ9DfT3uiSd0lcmeHYQRSl3AZyjaFpmQMG9yuRsdehZ3lOgm/D/XGg88ssgaTUaVkIP0X6umm/cpSkA5U09ZBGLfdLs6PV+5DR498CkC2MP8Lc3SmM35N+c/Vd0a2DDrr/g2DyE61M0VUa8e9xYzptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bORQrDJnELL0f0I5+pX2lnRS8128FfWIeMT0eLxiKuk=;
 b=h5JkxBqphZFqOMkYVxzMBM5zurGFwjGMTKe4KCw+3XQIXCmJMIV8+zkK9PSbz+/H3AhA6kQSg5O2BfR35DziL8TMFHfW0AV1+9FZ95kPsD+1SHRfzbhHdtDEUhzfV8YFQAHw1rpOLrC3guID+0Sh23nlUPuO9jTHuMOoLlB23PWCy5t0lkbWtEm/vXrKIzx2Tv5Uf+4E1k7mKTBjr1FRjHkBudZf3O5wQifoQBOEjt+1TVbihtBe27GYIIGfuKQZkWWaRow6LaHNx9cN7fRZp0WnljlXYYrQx+QFGeGNWF/5IjiYDa0aaP3gK7ZBpZ6jbvraKR2BFyRLlyiFmQLaSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SG2PR06MB5429.apcprd06.prod.outlook.com (2603:1096:4:1b9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Thu, 19 Jun 2025 12:48:02 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 12:48:02 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] mlx4: Use of macro ARRAY_SIZE() to calculate array size
Date: Thu, 19 Jun 2025 20:47:46 +0800
Message-Id: <20250619124746.175934-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0280.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::8) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SG2PR06MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4cdac9-9244-4a9b-daae-08ddaf2f86de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?80Eq/x79hClqq5KiaACO3/1qhCZHeBLHWPKyc9Yn7FjT7IwXB0WjcM8FdThP?=
 =?us-ascii?Q?xABB7Z+6FCRlGoeyV+Me816BnD8cL3nrpKcX+cfD5wwd/zL+d4nIx1x+vGaA?=
 =?us-ascii?Q?+o3DYeupuyw3fB/XaKqip5lT87eT1sNABkq+diNnDeyCI43/AoaLUHMHlC4S?=
 =?us-ascii?Q?IHg45lUttjDOnIYtk8oBOxamAxWteKh14qislmXJXC0BurTAdSpEmCOVSnQY?=
 =?us-ascii?Q?t4H4ygV1O49siU9Rr5wc3Y5XNdtSfLUbSDWWqk4lnwlEpx2PfSedCy6DzFKc?=
 =?us-ascii?Q?dTz9kOiZoR61GkEN+8Y/k5dPWBpJyxfSNzFOqTHQgIwXU0LYztZfJPuWkJpJ?=
 =?us-ascii?Q?EOQw19rBuQ4vuVDG7ID5b0aK9ENaFkA9xC4eB+J0wVYYnHd+0Ew6Pdj6cNvx?=
 =?us-ascii?Q?jVMoslhrAQZEfbSBlgZCTuGXIm+r4yEEKih5pGS1kl1s2O5JEZsgubWZA0dY?=
 =?us-ascii?Q?PD1lWa71+XOpqYEKyHSzbvC91jB1Ue3hMkGBDfz0e00MMyi/ngZy5Vvw9jaI?=
 =?us-ascii?Q?qWsZNHS77ogKXV0yvBDMgaEuEBopI+S0lQDcs09dzSxjix17D3iM89Uy3O6r?=
 =?us-ascii?Q?lkQDXjFBNYAsINclfhDycmiiyF88KATC4VWgsCziJKctjn75cVPu2K09WGqS?=
 =?us-ascii?Q?iPZj8Rp+j1iPltTdRl5A9wnuFgV5NNEGmUNWztTT2IODyN9cxHU2V6ApsY83?=
 =?us-ascii?Q?xLVLiVGAr9UQTibsx2UKKt/kkXE7g4/IJu/w1EUqGXLZ/+HKWaoP3WBWJt1R?=
 =?us-ascii?Q?GXpMi04aOW8XjU70LAy/9mcsIA9BwxJGdT/lNNm8fgeFHON1WU+eW+9G3IA5?=
 =?us-ascii?Q?IOawckDXUu9nyvavpNPCXSWIkJDQynH3+5kPhBvCAW1YafauV21yy0TXhjXN?=
 =?us-ascii?Q?/2KD/VQY8WHkbA4nhyhVchy3stLjBPxfcZKC1+FoRdPETfD641nZi3gx3AAR?=
 =?us-ascii?Q?gQ33AG2e5EgQpTfm9KlZSarTnWPjXiQjkY4Wll41lk+sRtALFIrK1v6U1G3M?=
 =?us-ascii?Q?MrH84aGupV/cip6DSACsUURgn78Xk9HtuJEN6H7g8uJ/noS3yFyOpovHY3np?=
 =?us-ascii?Q?PH6vFA75DkoB5cmPBMu8SmVy+rxub+1trMFBjzmsFHiqOnEeWyDQ/maK6M0s?=
 =?us-ascii?Q?NXynvG7rxxwyx2SFZYqCf0XgkEpS1A1wjR/1FosUjZMNPBWf6FUAaU3dItOO?=
 =?us-ascii?Q?ViXXAH7PwF8BmsQtEvNA2v7YLCTTtLDZtTzbyUaoPVFJkbyEP1L/Gm1L8XB6?=
 =?us-ascii?Q?eBgQzGqwHukc/9j5JRfD5xTUJeH3YV/oMj5xWx/kdkoZo8+xc2qiXuKpWcVD?=
 =?us-ascii?Q?Hg24VF2B8NNrh2ue+SdyhZFo63LIm3vZJyTSA+ZZ6nzHOaaDhonkcQ/NK5uR?=
 =?us-ascii?Q?DCywv2s6Bv2r3s3Qn5902VEd9wPXjq2P4G6/QpkyfTL90fNk+f1LKG+uoDTG?=
 =?us-ascii?Q?wphTsM8B6TTB9uwkTsr01DWNlSYntPqNAU4c4e3KTgw1TcQ4IFZ50Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kK+D04c700vKWN1U/ipEJqsdk5ZKccq6igpUJOy911H/zv/Y+2xmI+Bv03S6?=
 =?us-ascii?Q?pAKRGGdMfGs8ej4+VKa9iPLetxK8qADpg0F3BMZK1muzTIqMZ1ZjN7cR+nM5?=
 =?us-ascii?Q?RRexFcUMBKRUSHa/1SYcEIGpYZnFLhPRTeDQcjF2zvdORDiV/XyOcSMHQV0R?=
 =?us-ascii?Q?jarSDzws7ZrW6EmJ9HP+E8VzAHdoS51LZ5H2VvcSU8qkfY5S2f8m4w2Cx4gS?=
 =?us-ascii?Q?jK5F6Hpgovi1Sfzqktbh02ETI6DrG2ewBOkeb/Zq4DIKnvH9GpWevleYzrg0?=
 =?us-ascii?Q?3lbrRn9OT0F7P3RW9wzNbCLXxVkWR75juWEkd4DctNNnoS54+YhwEzrhWIz4?=
 =?us-ascii?Q?2ShTgYQlhDQA4ch62Azj6VwhHcuVmerbPV0wh6dHxQuEkCNx7zpAzSCRRwaU?=
 =?us-ascii?Q?ATTUAjM2kyQ7MPXs9bE6p8g29AwyzWp7I2R4iJXgK4XqtmlKPYoYF6LnGQAu?=
 =?us-ascii?Q?sZnhDlfSJHkQnxMZNkfPHK2bXlLOENXPVUWQkQuDuGOHcOeqWCnwcdqjoL3z?=
 =?us-ascii?Q?PJkirKN5oZNiU4vjIcp5tfKPdXhzx9SXAGQvLC/yvda8gIT2nLV4yXpwN/zv?=
 =?us-ascii?Q?Wppp9AufGsVmWYWFRsQxBPacLj3pFxaykbAKKi81MgcTtuRdN96cIuM0VCbp?=
 =?us-ascii?Q?K0le3Lj+rEbO59tCF9l+vzCQv7FBZIKiANkRDwZeLX319K+M4GMJZHjqBbyo?=
 =?us-ascii?Q?3VyG5JuJWrrM3+Fg+MuJpqcn4V+KKvQAGTg6y+GPe6Nza+EAmNmM7s4LY/dk?=
 =?us-ascii?Q?VqIHPG+TXpxpof6B2aPNYASQRmaZdRenZvvAkUeR4+onCGJgBCt99zBWTXml?=
 =?us-ascii?Q?bhLM6wub90N7okwuGZp4AT3Y0V4n+apWSHzKLItpdQ8fFOMPeqCGz1Zh8oZP?=
 =?us-ascii?Q?I6OIZpwDLVWJRSVUshwrLyIlxeCcODtDE3XzNDwehFnOkhQ+LPk/LRcfY6of?=
 =?us-ascii?Q?8j042gkA36eHgYUMEcQXaAhk2rWgaP5NMG+ISbMcCJBlJpowJnUF5Khf6x+r?=
 =?us-ascii?Q?Kjzi4rhqLBZ/r6CYsHbhAlIsTlD9Rb4iQN2VYzbRuhAKkXZx/VlJKrcFfx8D?=
 =?us-ascii?Q?3kOdIOZeIiFvnfysmIf/2aK/EBjnIYvBxDxOSRSV7UN+mAM/970pSh61xHrz?=
 =?us-ascii?Q?4MiAaYVe41tYJl7NrElzsVEcvaJBhUsBeXYwvWDPEHEWV5qGP6k2NUDNc4+b?=
 =?us-ascii?Q?iypzjy/EIkclQI652ayo2ckwL5Seq1d8nN4CLyoq2t+GzFev5nW4Hlixv8Pi?=
 =?us-ascii?Q?FBX/mu5nk5//L4Xz6BP5MnzvkADjvfW2vG9cCS4MRQSIWYQZJKaYSybVxcfE?=
 =?us-ascii?Q?G0XrEIqEc5LXgWiXTU4mlEjubithEOg/6nlIr9KkR2o89y5LoorVriCXgfGz?=
 =?us-ascii?Q?yd0XPxsHZu2WI14Zx7eivTqY7aKT+YXgRBhW1x2juANtTkDNZavRrfpq1l73?=
 =?us-ascii?Q?MHJilyRjexQ54W1urjvWO3pLplCxlYc1u4IvOiF6URxYn239csufVt4Q1HnF?=
 =?us-ascii?Q?IIskZuNT8ELfCCkPU/jOqzy08Hcu6yX++LRWDEwlbdXDMt/UlMdfw44TKJt0?=
 =?us-ascii?Q?CI7xnCZvXx2b1VRp/97CCyRovwSGISBcoo0lSXqw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4cdac9-9244-4a9b-daae-08ddaf2f86de
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 12:48:02.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vK7fhvo+h1HFSKwDthfLpHVyedIwjT0e4P401QBxPjm/apLUzWTZf91lsrkAbJhF9pI5S5NLCPRP6PtYBqr39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5429

Use of macro ARRAY_SIZE to calculate array size minimizes=0D
the redundant code and improves code reusability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/mellanox/mlx4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/qp.c b/drivers/net/ethernet=
/mellanox/mlx4/qp.c
index 913ed255990f..c2c837187c29 100644
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -617,7 +617,7 @@ static int mlx4_create_zones(struct mlx4_dev *dev,
 	 *  and A0 steering area size) are such that there are only two subareas =
-- one
 	 *  for RSS and one for RAW_ETH.
 	 */
-	for (k =3D MLX4_QP_TABLE_ZONE_RSS + 1; k < sizeof(*bitmap)/sizeof((*bitma=
p)[0]);
+	for (k =3D MLX4_QP_TABLE_ZONE_RSS + 1; k < ARRAY_SIZE((*bitmap));
 	     k++) {
 		int size;
 		u32 offset =3D start_offset_rss;
--=20
2.34.1


