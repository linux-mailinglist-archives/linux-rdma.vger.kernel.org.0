Return-Path: <linux-rdma+bounces-13037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3ECB401CF
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316407AC1DB
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B852DAFDE;
	Tue,  2 Sep 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mdrbwMKF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2010.outbound.protection.outlook.com [40.92.41.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF333595B;
	Tue,  2 Sep 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818089; cv=fail; b=rHmSBzDwK13P6fSPnYzfkt04qL1nsDtE18XZZ7aZ/9vWJiOHpCWUIrzKA+YFebbuh8BkG2RpUR4F1E2pa67JALPHCSM+qvFrYSQQabYPHaEr2TUunbOLiqKpTo/LbrIj46T/O2o0ccwFAYPwEbmWRedPJ9DU2mHH4ubuswHEuX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818089; c=relaxed/simple;
	bh=ORpBncNNI3pntberZB+6heq5UO4tHvtwHtFTLr6AX7A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lP5/uRGCCTObXiLoeyAP0AhrlB8UFLp1nHzx20oywL639MoZeCMR/gAO46CfT3KQQWwGvT43uycJ+7Uw9P0YJuhvphiV9aLuFNLKPXntyGib3XOIvYqTyCKmPhIxwPnTWK8giwZZRyM7S+60gTGcPpdhyew7lDoUKiXcUpGEuqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mdrbwMKF; arc=fail smtp.client-ip=40.92.41.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPs0GybGRTRKTGdnk4VOczIEWle1OeXXYubQu2ifWzAfOXTBeXgwmgmU3gGpizeZf+ppwwPVZQrrF+s4O1FYp0clbRA3xaa6wJZjfnWj1E8BedGmqyLLexWAJoNERnp9hzZnci+mMrSTb+E4dS7KmvB5lpdIXSbDmROMMsGXoq9fAMoqKtiKsiQgx559+VhjEv2yba8m5qGyarEA6cVSys7+IXVSsoVZ24aO1zeTTnSBGiyu9ajFXSaBd0icoS+vgxaj18vGdN6GvqAkFrn/gjb9gBZU3PIk+nGGM2nc9nrdPOv3aBRvzgkkevY1ZcK/GyyElQzURqYJjSYKKMr3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaCQj2d3Sg/LOaeGzzsKknEl1jKNda7n8Y5XfaAiWko=;
 b=EkjrMqXHnDYwXUyykRQAXXE+RpTJUiXfFRJX8JTSxZvqeIByjuzAT5P22u0Wu/+1aKZiuGNnmi877Qv2fC5snhDoVv4XVumcZaYyil3nUGTXSdLpdqCVN+EKDW+KqUSgPYrYDQz86HWECfH49SIE6Doj3zkfAMmMcSPYc3vBRpvWotPXliLRzIx+OrpQQhK1uRkurR4xf9pquKEGSRFnLE8P22xpd/FPssMYBrTjvH3hBZG4mmpe68hUrMqFB/uSsxcSEt+2DvR+2q8AYmlGoNFEl1y3iM8OCQ+i2d1uWSfywNVBYSmUJz5hME2fycq+nJ2r74Z1OykHTPOufDg/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaCQj2d3Sg/LOaeGzzsKknEl1jKNda7n8Y5XfaAiWko=;
 b=mdrbwMKFPJGQCQkFHZvfmcKXW4sItT4FA9I4KRTSEHhI0upL1tLdbluW+3yF3wbJgmJCu5zV/Hu66pg3SR7j+AeLugofJ9b5Kks69edlfankRXvvBlET2KPnnyPax/O292pEQUCeXPsiqogG8OKdNoCIDptdhtpLl20yV33LOBfCvk5Rscehs1Zb6vkSwn80m7BE8YlDgW9cSX+nnHg62UJCKoVMUvwz/0pDntwQwsTtTI56bZ7226wqKj9BdUG/u2VkyKirl12csEUPyJCnvnSIu3fhGqfBPcaTNrRvDlhEmmMboUKFuDniTDVr6qb8FdeGjqAyz24rsxcHuzTkgg==
Received: from MN6PR16MB5450.namprd16.prod.outlook.com (2603:10b6:208:476::18)
 by MW5PR16MB4788.namprd16.prod.outlook.com (2603:10b6:303:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 13:01:24 +0000
Received: from MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68]) by MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:01:24 +0000
From: Mingrui Cui <mingruic@outlook.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mingrui Cui <mingruic@outlook.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Date: Tue,  2 Sep 2025 21:00:16 +0800
Message-ID:
 <MN6PR16MB5450CAF432AE40B2AFA58F61B706A@MN6PR16MB5450.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0072.namprd17.prod.outlook.com
 (2603:10b6:a03:167::49) To MN6PR16MB5450.namprd16.prod.outlook.com
 (2603:10b6:208:476::18)
X-Microsoft-Original-Message-ID: <20250902130016.75864-1-mingruic@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR16MB5450:EE_|MW5PR16MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 69960b43-5f7c-4117-b59b-08ddea20d22d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|5072599009|461199028|5062599005|23021999003|15080799012|39105399003|3412199025|40105399003|440099028|41105399003|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OApxSQywUsgLAYjbE7UyQjSCPc5gkAtWErTu6H8Peq5lD4k6pBMCCHiQMAio?=
 =?us-ascii?Q?3ZR2Euqqu231EhNTGmoK05TS7tCQC2yCEYgwDCeGKZjzvktb5vFVNW9EBjDt?=
 =?us-ascii?Q?QiRTVv9JVqy6+HxJSMg9gga2lVjpdvyb84SV3Mg274BdACAGHWx7tL5gFmR4?=
 =?us-ascii?Q?ktikE6KQukvp6/cct06i+CKZRR/U0ITSWKRlEItK1aVRvCVPSDiJwZMf6H6r?=
 =?us-ascii?Q?vqAyazW/b0J0ypa2Q9lGaq0NiBpybflp2+mn/glBtkKpbahRlJEXkSI15w9k?=
 =?us-ascii?Q?4TWoywSn2v+8Jr/UGRAienbZcozYdGSGYo9DaNk8DAKsVU8uiE8AowGuZjLv?=
 =?us-ascii?Q?sk0LqcANXF101OnAW/6zPOp0zYYckQwM2B2lkE1EeNO5j4T41PFJqNyQdubS?=
 =?us-ascii?Q?UihVqMj+NEP4rnwgI+xbkf0C0NLhVYEdF1+2AnD9xuF0qFNlZbiWORChAfaq?=
 =?us-ascii?Q?R5i4VootAKbybKIqR6bkzRuJ7t+c/0PMS5FThGukkzaWNLZTC/f5Ca0i3FDw?=
 =?us-ascii?Q?F4OViw+rlYiVhOyTBKS0wRteh6dhUePC1FxGFC2vNRGMoS91fL1FLM6dX0lI?=
 =?us-ascii?Q?gJNq8AQgM9gHSYd9eJcDf9XmQ+KT+cNdZpAvGqZYFC+Lg4Y9Y9snBc2maWDi?=
 =?us-ascii?Q?L3nysWDGpbT2kzKYRquAHqRPFGbTfwq6UItJT7Rs46hqjylcIg+5A795kDZr?=
 =?us-ascii?Q?kteMxwb5BYQc2Xn2Yk+PnTfTN7NK9tgFKs3m6CBsLvFSY9Fckb9jzA9fc3Eg?=
 =?us-ascii?Q?wix912DzyEEKO2ahhUa/Qj7vI1gYZPV5rZffkov95ClvtAVFpO2Wla0WhwP7?=
 =?us-ascii?Q?D69aHEiq5M36KbWPaPzmmPouDdBguJpCB0hm7nS42FLI6IPBvWiV+2ROy+bx?=
 =?us-ascii?Q?o6VcXCKCmeaU1bX/IE1i/bSC8oGsXIpb1LAf/omNotc4hCWiH2QIPTV12Xc3?=
 =?us-ascii?Q?ES1fsJD8d1Okq0V0VsQ9K0IUIG36/GCNb/v4Gas8sgP2OpamP/IKhzKnW7nP?=
 =?us-ascii?Q?fPiY55WpB8eER16HtUHL13DI4L/WWkNiRnoaX/lYHdEw4QUm/y4NAXH+SDoZ?=
 =?us-ascii?Q?xRbmRhvjV8+/qgDYI8QJmmH8M66WV15UYCZVeYI0k/0VBCrXa7oUFia424n8?=
 =?us-ascii?Q?9GjjQOL0BCJAqDNiKOWEpcqyvGpLMtTQ3mIxzik6nAH+zbDFV70IVG1jPuj9?=
 =?us-ascii?Q?CIcBUX1me/N4ogpLtwXkYMgkxBc/9iE8cqmatPJsHCbmRt7fOuo17phUxSN6?=
 =?us-ascii?Q?l2tL+59EjvAyrShfV/YKMPefCKhEKKHC86dD4t5L+A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izONaf6Xx3E78Tu6YBwFBYz0BVVhPwHMbMwyzfw7rR7buFcfSLLQodcD8HK9?=
 =?us-ascii?Q?1+Ya0xPWoiAFgtT17RZ+1mz8SINRxG63voYWqaCpc9a/JaN9LeRobyk6RB8l?=
 =?us-ascii?Q?pwliP989nt3JMj1/MA5IukOV6a1oBQlbdbNKgG9Gr+5D1+18Y5vkBi1gJuoX?=
 =?us-ascii?Q?ilYaTONk6lgOIGVDB4jgcUA1E75CYto5ZSP1NZapa2gC5i6CrasfHYVwfb5z?=
 =?us-ascii?Q?x/U3098acwvMzjkJpecCIWOiwi7PjV2zMdpEKz0OFms3QtdYshAkkl3DsaH5?=
 =?us-ascii?Q?rJEDzA5QPPuAUPS8+VvPyty1/pQLpIMmDLj3tG8ItnwjkP5W/FFW3uNU8zNs?=
 =?us-ascii?Q?/atps5XrLiCrb9x4w34BMhUpOHXQkpI4PI+SeE7s5L+OU7ueY+oCKOSA5VaX?=
 =?us-ascii?Q?9/UZieaAfgZtwo9LewaJ+73o4iPQSf8A51IYYERsVnokjLG1ZtxxFiC8OOZM?=
 =?us-ascii?Q?nvvQa3hdt+DJvX7swfl3MoPtd2M8bfsdPSVbaW08ZQLZbiGFnJcp7fH5lcRC?=
 =?us-ascii?Q?eERTR3GJf6WIInDGim9UyfGh04LDuir5D4Zm+Wq89ofcFVVn55PLZr43rdcx?=
 =?us-ascii?Q?+Sj/EBn64BPoKThg8dCZwZbc6DZtVa7wn0+YjVSxIo1juYXEJe3rNgn5y2Ud?=
 =?us-ascii?Q?k6oqNEqrO7SAd7UZmJpnjW4uw6fJAEz4cuZ8FK+9s/xoR+SEC3pz4uEMLfew?=
 =?us-ascii?Q?ld9TXCF6iFkEBDNkuP/ukUEbh8FOwzizYbm91acDo/SI7iLXfI5jGttcvjw8?=
 =?us-ascii?Q?o/77Eh5boNzSEzErtijOv45gmoLgTMSt3aEr2xp3JXjZtJCW9yaKGQgN10Co?=
 =?us-ascii?Q?A8ndChcGcon9VpfZjb6KA3tibrTvFWtWVb+zIeEGSXo1KmCUpD55vkz+a12Q?=
 =?us-ascii?Q?p5awDyz6ZDyor249TZhTZToy0MGWzgu2EJEabAcKaogqJenMcDEa9lTI5w7q?=
 =?us-ascii?Q?TEafmNIiu9P+s7fWdhFtesIlSm81aYtQGugUzVJHmQz2CJhHgsKViaYJRUgD?=
 =?us-ascii?Q?Pk6VHA4Pc+QROVW7Zr8X4QNN/NwZAB636DOa+jwcVt6zUv2vJJKOlyb4oXW/?=
 =?us-ascii?Q?FTK2R6QzAfqwP7IZhIvRcHQ1syLNGIizBNwP/pKrTMeBkSmCAAis9kfEZAdP?=
 =?us-ascii?Q?AR/v93+2XpRcQLhcSSMr8gxVBSHg5j+nc8i/RLbD0wKm2fxsjk428cgCvBSX?=
 =?us-ascii?Q?s5PvZa7VXoA+6d/64GyEjNjr8vo54cZ6Y2IR0SCReDbhX+sGU2hO6UCfU29o?=
 =?us-ascii?Q?pAIHJVPwtwbREKM8vOoczSvS3jtFbvtVRh0X4BfQLA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69960b43-5f7c-4117-b59b-08ddea20d22d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR16MB5450.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:01:24.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR16MB4788

When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
fragments per WQE, odd-indexed WQEs always share the same page with
their subsequent WQE. However, this relationship does not hold for page
sizes larger than 8K. In this case, wqe_index_mask cannot guarantee that
newly allocated WQEs won't share the same page with old WQEs.

If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
page with its subsequent WQE, allocating a page for that WQE will
overwrite mlx5e_frag_page, preventing the original page from being
recycled. When the next WQE is processed, the newly allocated page will
be immediately recycled.

In the next round, if these two WQEs are handled in the same bulk,
page_pool_defrag_page() will be called again on the page, causing
pp_frag_count to become negative.

Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
size.

Signed-off-by: Mingrui Cui <mingruic@outlook.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 3cca06a74cf9..d96a3cbea23c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -666,7 +666,7 @@ static void mlx5e_rx_compute_wqe_bulk_params(struct mlx5e_params *params,
 	info->refill_unit = DIV_ROUND_UP(info->wqe_bulk, split_factor);
 }
 
-#define DEFAULT_FRAG_SIZE (2048)
+#define DEFAULT_FRAG_SIZE (PAGE_SIZE / 2)
 
 static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
 				     struct mlx5e_params *params,
-- 
2.43.0


