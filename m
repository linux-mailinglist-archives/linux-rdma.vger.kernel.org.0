Return-Path: <linux-rdma+bounces-12829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25A9B2DDA3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8A61C44317
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6AA31DD8F;
	Wed, 20 Aug 2025 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H3N4cxoo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013053.outbound.protection.outlook.com [52.101.127.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7BC31DD82;
	Wed, 20 Aug 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696110; cv=fail; b=nyFOvEzN2yEFcFzUOk5Bjpz4u10TOcUlNBHgMJ+yUA3QOLDNo99ZYyle0z0QUNUvWK8uo0sfGSSJftyjuOG1fA/4yJUED4WZeylPMP7TtGpmyBGEUW0JYfhMBET0RkT6tjw0rIpmzMg/htjRv8VY3L7zNxpgdw2XZaXzmaNIWY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696110; c=relaxed/simple;
	bh=oTD6ktVSvRjxUL06kJX8RxE/InfSL3efQYT4X5dTjP0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eAMnVQ7S3R7ZTzGMaBZTPa/HwZGlpBkaA6K1pB/nukGYO67xygVanGBzIXyeoQJtv5h1l3FqUtEyGchLDvdDS1WcFuNAJfS1+9IzgshyqKvnGBuic5v8mRWpX3wNQ3I1+T0Rm3BZnZ95nCa3dsL4ZhJAKxWeN5m6RDyRbMz+QR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H3N4cxoo; arc=fail smtp.client-ip=52.101.127.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wreaFEvFe8lmvx6KTLUaZYkgG3vbHJxiXHiiF6PV6q2hkMI+Gw+EqzznndT/8S9Ursi53+fhckg+N2Yw/u0Hwh/BBhpubJTXfydV0+hlE4sfZ8It6NROaWtHU20TVOjlCM0OcTAdRK3Pnztf389qgcCZTR9/NiOOAUaiUFa7ZfEkTYohT6iOtWGsiwEAReDk8ryrMVtK9YudXuijs3mXXEoXLTNn/R6RDEM5BhO3tls1VBom3rbLEmZGunP2Z+IuOBA3FuxXtGZSpHOtHqCSpgEr2CyFXc7O0niFVc0Fu6a4mztS+kfzCU6JfHtADFH1vE8Fk+56kMeuqeaOPi8oIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWwTsGSNponE+08AWt+PnSi92Z0oMHqECv8Bbl3D750=;
 b=hiXHU+CVB496SD6/4sjwyQwxxOmf5L/KYZGoUsTFqAsvU+g9T6+Ufc8GGRUPwnVbiKx2P4LsqbAKlOGE9X9Ijc3cZFke62vKUw5hSKYUTQD+mQ/b7jo7OV7dx0LsiqpenRMzGtEJ8hTvuw1cS3B8RrdsdnENEYlV1rJejoFwbVcJTbkHF8shcp/N4+gvOTJymRTutVXxGIMedGMYv89R+nIORRiGu7rpq/5Nlq1deymwqizBABLGH2Ju3l2HrU40rPr/3zPqe0Tux9Wfb8DnaerBh63OMVBtf2qCWNLBPgc6Zms0FZE0EnKrzdEkoQUPpoXH137wVumfTtJX41L7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWwTsGSNponE+08AWt+PnSi92Z0oMHqECv8Bbl3D750=;
 b=H3N4cxoogIuHejiMuRm7za0yAKoRlkbHHBUQ9f/qUnb5u1GLfAjWRKUEDdJ21ISHduUsSPfjxuY1i6AkDzgJM2tKfzZLx24aYk3SwboTrKvMpv4w3l4DfcQyveKy7E1ClDj9w/PGo6PAwqF60rIACmtNwjvpFaR+pCDDRRUbOJRAHpX1qV7BspvuV/FCawi6UQ8PUqJ6Ri/xWYNA/S7vw4a7g+n8kjfEeUytD3m1jPf8xVAKbBT/o43rgsHC6yM5/qSlVtVFp0XtZ6vv1zf+3aWJzZpuQSdIGzXCEmdVtc+48oyubnK0pueUMlDnNL0jlVrOi1F2oCLF+kHdSmdnQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 PUZPR06MB5772.apcprd06.prod.outlook.com (2603:1096:301:f0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.13; Wed, 20 Aug 2025 13:21:44 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 13:21:43 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] RDMA/erdma: Use vcalloc() instead of vzalloc()
Date: Wed, 20 Aug 2025 21:21:32 +0800
Message-Id: <20250820132132.504099-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|PUZPR06MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: de152533-de75-40e4-344a-08dddfec81a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CgQ3Vz6gRg/Dyfr5YI3MJtns4ypE82Y2AEYdCl5xpsf8OrbUgEpwRAbgKnaF?=
 =?us-ascii?Q?0m8ZfUeneXpTOVq7YVZRULThq5BJge6UKI8xf9Yf4DypXGLVuMMp2EstdSUl?=
 =?us-ascii?Q?+JupioHAdzQOxb70RQ/mT6FNGpvBlVNpR7IMtNiLYk0zzB2HRiCNriacM8X3?=
 =?us-ascii?Q?e+e3Yn05sD55jLWenGa0UN5oCpAw4sOfg5OEr/Og6t5qlw8mI6PXVsT8wrSR?=
 =?us-ascii?Q?cUbgOhRYGj6yImgq8AjHMKRvy3y2pdrNju16H0VqqBs00CxPlq/7wmH1XcRw?=
 =?us-ascii?Q?lMqJWS7dNe+HRot+N8wNbl8Ilh2WFHCxOp/nQPqt8j8x4dk0olTvuP33H8iI?=
 =?us-ascii?Q?V1xnA2VSCD82UAwRIb/+OMdbsP92kK/vSjKiA3hMZgEA7RQxlII6htn1EYkU?=
 =?us-ascii?Q?LIypbse7Y1zNbnJRVpFHtRkC+8spH3gLWIrzNbDSuLMDJkxmIozk1/oMGo/x?=
 =?us-ascii?Q?pDh1Hx6Guk8giGUklyESD7D+e8KEghOd4yL0OOcrvFEoINQg9ozKf23vAHee?=
 =?us-ascii?Q?+OTL8v/C+9VJaekJUgvseEcDyJ6KDat/f58xrpTpcGyiOTrS11QlSENcedv9?=
 =?us-ascii?Q?DluTxiCYHkUEuUgmXz38IBw5B6fTY1NeBfuQGzSHzpEi5JdfY6NV56cv923S?=
 =?us-ascii?Q?vnctDUPsAWHcfjapqlqStfJF+c1Ymt8jcpJBPV8us7adVB9im1MhAVzJIqOa?=
 =?us-ascii?Q?EbK47z/caY3uBOiEMwSXGuwLUqg3tYa2GEiz1bHBuvVGRssmPhDqsj6zeEc1?=
 =?us-ascii?Q?gBb5dCego1yQDtusmUMEdoKZbSXmWJDmqXcLvzH6QS6yF7vRU5bIav0ryLWt?=
 =?us-ascii?Q?Ye7wm8TiuS6pGwnhRFJ6aqAXFWF4exJ5Kl3WHpERgF7WvYsvqybGj8FBiM6L?=
 =?us-ascii?Q?VqTxLmkKcOUmDulqH+ut8A/We1nSep1/mET3+zEOf4fuKhjEOQnlZNviDqlZ?=
 =?us-ascii?Q?Jp/iAgVqG4dlFxN4lvkP3KPEtYPadkKWore8GDaPuzLpHt9JptYSsX167IMG?=
 =?us-ascii?Q?yBQV29Kn1pkwPfIiMnxSfyIvwRizgU9zb6LWhsAkUeicjfi4bfUz0mkFz6RO?=
 =?us-ascii?Q?XK0Sn/sVfL5U8fEa9jJasJh7RVaziRxjSTvTAJhg7EgfXoqnj52lUN5e29Us?=
 =?us-ascii?Q?7IbCXentMpBh1cXlEWbUBGwTB4S9DVICIV5H7dpgKaPaw6U+1E4pDEEBJpM4?=
 =?us-ascii?Q?0eLxJ4MWMhqAJZI/E1sREpNvLYDL3L+Ao6feCWa0LghX0rKQn5/ynGmQKQbh?=
 =?us-ascii?Q?g0x2rG4MK6SqL7vsFEy5TYCivZ0Q/HHdVbotOQKkofGDnrIC8tx2CIghlhDU?=
 =?us-ascii?Q?uq8vZ1wJHc5H5kRYIEzXQpkBbHenfnQMloaDZhMlmxaYbAVAfIlZqBFAMZWc?=
 =?us-ascii?Q?l1fAviW0J/F8fQ/6+eXPCjaON9r0K2z49vQFlkm6jbqkyR1OTxJ/j33ikUxs?=
 =?us-ascii?Q?2MYmwq8S82OejBXkY3cpzGgnYSlKvdL0wQZF90CNVd41Q5Jd9A7uO8Gh8uXq?=
 =?us-ascii?Q?GPv8UK33x6t1QSk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vzqnm2WpHb3DJ6WsVbk1aRrmdQoOP2BHXCG/Ia+jsjDzrjcvTx76K/VFjGTM?=
 =?us-ascii?Q?7vz3/aQa3tGHT/1UEdKip364HTnyt7DaOJnItMBU6/AZEri6sG85laaxqIuZ?=
 =?us-ascii?Q?14G0nDzXIL/+43/2a1T/JJRm/2pvUFFIojqmzUinj7nB5VtXym9YHbL9vGow?=
 =?us-ascii?Q?U+VgFluSaF9uU+R4K5YK91vnEu121Vhnt6T6s/6jcvXiAWTR0PmN7slvTDuL?=
 =?us-ascii?Q?SaPZFpDutCw32lzcaLZ1y4j6goYN7ucvQCs1Nm5OkcPusyrRB72QlYS0da3n?=
 =?us-ascii?Q?TuueAw8k5xjvTdc8K1FgyaNigZoNO753LMQNeURoyhKu7z5uw03NQe1rPdWj?=
 =?us-ascii?Q?hni6Df7bm8LcaQOtz30YcuIdvOPpSp2udV1DMfJSWn4M04FzUHq81XtXggtY?=
 =?us-ascii?Q?BeiX7pXTGxcmCNxtKj/nQEKl58yyxCB7Tx+ZvNhE0SIfi004pl3l52dMSddm?=
 =?us-ascii?Q?79CYz1E5WyGeH6K4EhHLH1mFYAIN2yyWFX7CEpKYP6r1L7mjA/JL2j9Q6Bn9?=
 =?us-ascii?Q?S95XnSTh8R6nvsC3cG/0zugwBKhes6QJASWESKux6P7C+N76cp2+LojEUGSv?=
 =?us-ascii?Q?os4Yyt6IiIVzIpyA6HSa8E0q9FZbxtJbm0y/h771yGiYEfUN+jNvSWqeHlmO?=
 =?us-ascii?Q?hRxCPSZTsGvEKTN/YUT4SZ20/8Hxs/KDvkuLWYROugVh5uhLIYLJpdEBG3Zw?=
 =?us-ascii?Q?i5Nuw3iMDT1zTUh2dDX/txeQitVRKJJNIqmgm+cP5/KhCxVMfYg+W5nzgkls?=
 =?us-ascii?Q?Wm3bGmTCCMwPBDRZxIRAzydk8pH7oIB5vOU05S1iCAGC3udNgCSEKODC1jQI?=
 =?us-ascii?Q?jNip5qzqPIIOMyocwZkwt8kydYJxn9PDyqHG9sGo3NrhbnMb4m3sbtr+5sUL?=
 =?us-ascii?Q?i1FIEI7bi7Kqs/r5WZKIwzMcd7eWUO9FJa3Yr1xZ14cjuQ99rlZrfqObzL/p?=
 =?us-ascii?Q?lioyw3B/w5bjnISumiF9Hyua24kdvjMJNM99eE0e2utAKvCGzB+uwVhLGMqC?=
 =?us-ascii?Q?YH6XnFMtLEtnz5t4svVq/3Lf3wlYGMWC3UpxH3UsrR9NCEIf2JkxhE5eEo1f?=
 =?us-ascii?Q?dDgTRGlHmmLsJGvtuthCfypjUTtBDLis0+aep1shjldDI0FdaMmj/0NjGCGm?=
 =?us-ascii?Q?ausNTy9KuT3KA3dsa+U2vSDoLYkFiGJDkvPnAhbDguHAw5ZmUMwYrqx/Ksy0?=
 =?us-ascii?Q?gT/sm+ghVgSU5LKmXBDOp0MIoN4OviVnGzmNtSPAlS6iJIX1UH6f9soZuxum?=
 =?us-ascii?Q?SMWcqizg7t0b7PSvmPVce1Ke+Jmqin00yq6PCHNgqhfZf+oO3Y/CioCEuTR9?=
 =?us-ascii?Q?SkhZctdImG+m1kTngxmN4u9/FfNuOKlXqFdOmfoudSxy5FdfRgDOnCkdOGPF?=
 =?us-ascii?Q?dorfEarXrlrnbesY0L+49maNK1/nwd8QzLaBJrksvc8oF3yR3iLFDdUnc3M8?=
 =?us-ascii?Q?IbPVOUaTE6deZN08PL3EiL+hEdIc8tdRnbTogciKwTFF/rLjPvZQf8y8Bs3M?=
 =?us-ascii?Q?XX5XU2PPoVo0q/LDUf42n8iS072uPr1zjFxMVuILk0ptIOyVTkEmFH8TOlOR?=
 =?us-ascii?Q?oz5D6FM1z0NOGM0v/YWc6lSX9gfAjmF7cyoVqAyZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de152533-de75-40e4-344a-08dddfec81a9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:21:43.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YF+SZFN4QALPtxzdTTLXDxY2BNod3FKWYqoHZpOon2eJmvvyt7ZqQUe8VL4bOi5iHuTVdEcTtakblKdh35NBEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5772

Replace vzalloc() with vcalloc() in vmalloc_to_dma_addrs().  As noted
in the kernel documentation [1], open-coded multiplication in allocator
arguments is discouraged because it can lead to integer overflow.

Use vcalloc() to gain built-in overflow protection, making memory
allocation safer when calculating allocation size compared to explicit
multiplication.

[1]: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 996860f49b2f..63cabb8a6d96 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -671,7 +671,7 @@ static u32 vmalloc_to_dma_addrs(struct erdma_dev *dev, dma_addr_t **dma_addrs,
 
 	npages = (PAGE_ALIGN((u64)buf + len) - PAGE_ALIGN_DOWN((u64)buf)) >>
 		 PAGE_SHIFT;
-	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
+	pg_dma = vcalloc(npages, sizeof(dma_addr_t));
 	if (!pg_dma)
 		return 0;
 
-- 
2.34.1


