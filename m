Return-Path: <linux-rdma+bounces-12852-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F1DB2EF70
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 09:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2F7B5369
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD332E8E0F;
	Thu, 21 Aug 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BUkmIEIr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013015.outbound.protection.outlook.com [40.107.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D72E8DFA;
	Thu, 21 Aug 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760950; cv=fail; b=u0Yn7r5N1ERLavY7/rBplC9EscIt0M01sK8NV2uwwnAGhjyVOwZytzRsIq70bh1EtiTEMrF7Ab0njKOc2yWGb2fGW2iUNU20wzH7gtbQ9ftazKudl+b8T/65S6RjEbVKGEI0n+ZCdrffrxU8VD7h/vYW8yrmRWwnBY0dbCfkun8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760950; c=relaxed/simple;
	bh=Rb9YnN5z2Ftta0IcFV0cJv0nLwvuczOGHQvFqDbtNKo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bSoNeYVkfhdOpz71rKLk4w/2iSywgwgTlkb6KYqilxL3ZEHm58V7ToE/scXzbmV2e90t8hmyJvdauiYOT5z3+nQ3KQ/Mhy2uKVIdk1BY8bnCM5PIX5upYVOqb3XoBAi6Yb0/h0SyVQHdAL6c+6qv9IuUAmkq0blFuaPPFqWRuaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BUkmIEIr; arc=fail smtp.client-ip=40.107.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vt7gGNX3+7frPgBEhL+Q/nXXPW7qDjQilCTL7zNrl9hRVglpS1tNjx1oLXZtDBGbIcQVTdPCUmjCHFZznrwx6XWjv4HmO98YCq8lvSaTfC6p9j9HhehS7JCyF83DttMSbBrUSevFYZvtFNZfdo6txIvRfxdyPU68NzCPYtzfIWwVo2Cne8F+5zw2Hwna/LGQNJL7o5Z9U376h1QuRuoFY9rcoDTc2YqD228rcxtOoWf9fGduFcHVtKVbMMfEg2nbeE4zH0LaqlcWMR/7nqr0zz4jcul/sbiu4OhiVPgWKYm6UpJJs/3m9xmTzId+lu0vLQQG5KUUBcnkqFcF1NTk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhTS/UBprJ9k0/Z+W1bwWIugiQ9SNvLBed6DAyI+JVY=;
 b=K8bowXpO85WiZWYcBWNxRCwASKH2ZvYhB8eyJpG5v2r/z5hp7LMLbBKC7sHAIMFY98k7b2JyISSk6R0iQl53GPJeLHN9vUuUfXfL1yY1gLlh9xgAmVVNEMwbwPunXQGjD/kSQEoQICKwAkGgbEVu9idU/DMuRG3A7aDDuIyXLFXAnJG51dxJOOsvUe8aVavGpxDTsYhg0o2ZD+gCC3M3GFHIdHc0spg0CI0xSjQn4ux+t27e8nhTcuxeKHgcGAgas6ZzkI9lZyWtn1XscE+GWbt9oepzoYllc0Fdp1an5if2gYW4XIPSmDsGWgy6ovavcLzZpsa8XDGl19wRLL58Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhTS/UBprJ9k0/Z+W1bwWIugiQ9SNvLBed6DAyI+JVY=;
 b=BUkmIEIrUS4nFcbU3G8/Mzs3ER0uiSxEkVDB+4jbPls6nLc2JPLs6NQ7jqVljG3Gn0RLSbz1HUcTa9dQMHNJ2ALpKelxjUtv1ynyqNETlbPI9+JIn8t0SSKKL1MBw/0rofntpf7v03HWzXG4/bXPFl+CqVCyjJWNkKzy1WEMougzvoFmitm7vAygIkt0EWSsA0cxVkNS61E1HiWiG7+hFCq2vwO/RJ6Mcpmud1w9Hkfamay/80P3Z8qJ6fy/I88P9a2ECN2WvyIz8jXCvUo1fOnD8+LK3zCuBvZ6km5Jnea4hBqme+Ahn4dD+kidzJW6gD7qygvGBUva7wEc3D0eEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 07:22:24 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 07:22:24 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Markus.Elfring@web.de,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] RDMA/erdma: Use vcalloc() instead of vzalloc()
Date: Thu, 21 Aug 2025 15:22:09 +0800
Message-Id: <20250821072209.510348-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::13) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cb81ab-6215-4ef3-cac3-08dde0837961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rztstmpxjc90llxiN8DWMpLurZKfsSymiuIwpuRSyWjV/8YnQUKZO10T+qxN?=
 =?us-ascii?Q?kKc3mKtFy7B3fKWGxJayMZO9+kzTBnkqekSDVcPvjZvsU5jycIlYqPVTh8bu?=
 =?us-ascii?Q?eLLjwb8ns2qwoqrEWx1/eLwWXl9OW76VdKouqkXjcSgrC4hQHoD5AlxJM9bH?=
 =?us-ascii?Q?UBtvo6eHaJRodQhj6RL7a+/pb3nlbszzAc5KupBt+wXu0J90oG+95ueq8LlL?=
 =?us-ascii?Q?QdelZSwXYZll1rPyLCZVPiFfuL28hrZblLVwSMA2FOpsN18JxC7fQPx2gSVr?=
 =?us-ascii?Q?SKBHcSlG4r51VIc40YGAAM5jSVtSKEpfKc16C8idsp9zOiJ0S/e1pqofZtQ1?=
 =?us-ascii?Q?5kNOFDJ9UL7AJ/LQN/pQjmqhImm+xIorBY8628rvd6EHE33scX47ibgEvQMG?=
 =?us-ascii?Q?R7mDQsrXIVvbLd4fA12IdTNvRvpSIR+3tsocwfJ7riP+xiVBsGnuWZrUppjX?=
 =?us-ascii?Q?+aCy9By6b+RGXKL4mtTjfNUsmNtt5Msxwvnx1RtDESIPNcnmeJJbcoqc+Io9?=
 =?us-ascii?Q?rUngWwcP/PuHyq7jW7RhGpDXeg/oQ1+ONUUxwjKkNr4aV4YonY/W8sAyo4di?=
 =?us-ascii?Q?0Z2Y1XDEoYiLGMEkQpWggdz9px8sCyvhbG+LEUcEAwGtJ3ELZhTixUMKCXZA?=
 =?us-ascii?Q?TfHYCJYeI5K4HELTazoLq6GeQcSVOS7NkbfjlseD6GRGUm1Iv5gS0J18r846?=
 =?us-ascii?Q?CkNrhN2cRkyQsFC2ZJyOWZZHg5Q5AuSVpR3YpsKCeSUgoPDscE2jiXtQtGnZ?=
 =?us-ascii?Q?VNNwFUnhxLJ2vXiEM2gV0xD06eAVxkybS8vIShCUYdK6NyPCq5LcnWj1L59V?=
 =?us-ascii?Q?+fgOucyE8JRUla+Yy60RuCaSA4r6BjjZlyw+7yqjGC2mrB3yghJgZ7H8QF8u?=
 =?us-ascii?Q?S/MuXW3Cq4FoJItpAgZ3l14jaH3T3OF2wzffaJ+2LEDabQliKNBRut5dbT5i?=
 =?us-ascii?Q?kjgXFuGYrDNybe0s9IgNrbZ4LOkGwm+2jEmKKfqAiWE5G2zV+11QztGCOKCb?=
 =?us-ascii?Q?Xz6siF6BUMcn091L9dgcwWS/HLiFhjIt58PUaBLiqicZCHOBl+54YuXNSrGR?=
 =?us-ascii?Q?mocMoSLGcYiKSvW93yumQDXHd/3/+Ol5/07U2KangFiehPXIt5SS9E0lDIBF?=
 =?us-ascii?Q?aIjYTPDw4dK15SBuMh6WTK7Y5FGsFObRFi7hSeV7mc29T6hqet3hLugNm71R?=
 =?us-ascii?Q?E4CMgTvACQL2ucCkWl0Dn5uSrfVKRZwTOxzcar/0i8njK8MnYU/mPmy/pHee?=
 =?us-ascii?Q?M/b0y4K0bEMb573QND0iShNaxFEThvMnXCWrpCC2btJEnfC69WGYcn+Zx8TN?=
 =?us-ascii?Q?aHuNw/Zbq+cH/sH2LNPqFLukid7/nB8YQdjw5hbpNdy0Pr/ZbbpCQ5Ahoogi?=
 =?us-ascii?Q?qlbHC/xv4Vo9sA/zqA0njaVqLrgcUihvOQp7fGhpt/GCW3SnbqAwJTNKLjKB?=
 =?us-ascii?Q?b57w/7MxEjj2W6h6FlyY9bI9VbjE60AagDysFGu9SOu/hmqpgNxImWEMkcDn?=
 =?us-ascii?Q?Lex17VTEYZK76Nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2Lvo0hK9AGeE0iFKz9SgwqwWyUFskzg6RqfCAej/u9eZTrhR8PmDi3pR9LE?=
 =?us-ascii?Q?aKpvJXS9o+cNg9aBRNndKqrS6uz6mdoWOljSJO9QM9uyb/w+o6sbbnhlNj+u?=
 =?us-ascii?Q?vaeQL/zqrnHCqb0wmEiJ30Blbho1TpjVnLCaE0gXiCBGKi9rVdUwYRwdaZP+?=
 =?us-ascii?Q?nTKBkxenqN42Wn1ATbXv2E48mpIsNoaDCk/8AgYpo8by9X6qyku4v44gYDyl?=
 =?us-ascii?Q?I8T4njTKvr4soBUdCyEh5atJsG3KFh8+AHmle0OpUkTqvG3vNnGdkhedA1EB?=
 =?us-ascii?Q?NOLprOq9ndn558G+oQNXMe0Yu+uNi8moMbtndxl54cknPPwBsOKJwGiQ3JWD?=
 =?us-ascii?Q?KBtp+avpkv41OqzXHi21f0Kqjyq+kStDQCusuCd806c+KYxHkEPx18Dswvc6?=
 =?us-ascii?Q?lO8A6tfukLnb7xsR5jlW0ybsivoPMdvQo+xSxHZXbTFbagkACCDweasDzuC9?=
 =?us-ascii?Q?Yy+NgQDTVwzC/c+UCJNrcW89mFZsmU+eisxYQ1MhpeARVNCR7KRBT2Xt/dH3?=
 =?us-ascii?Q?IVL2r6SLxWyd6bDALICkGOSrXTgV8gFyCaDaeVV2z2e5C4uWy3AcUkaoGpfJ?=
 =?us-ascii?Q?ZTpJ5hYddjhS2kPxXEsp8fwauXrC8dE4lkh18vyB4e/LhY4Uz37pshPElYA1?=
 =?us-ascii?Q?4dD7etUB4pMWpeka2JoC8ZTOrZ8miQLM9Yvf0dkqe30U59V/Lwgeg5Mewkmu?=
 =?us-ascii?Q?97bzY3fgHD6tvhKU4bWheIPxduaMKSiwky0WjHKqbyIpmz1vdZ1eX8DWAs6W?=
 =?us-ascii?Q?dRoqv5zxNYEgb45LWiBkwC/+f7h6dTCLIECKYFBb5YenpwHgt+eL+qLc6xp6?=
 =?us-ascii?Q?Rb35RHZRfxUXhblyavymslTQfMFrXa/gXqINly8ggXps6q8tZfZedZUCz9aU?=
 =?us-ascii?Q?C0jDRKu/AtjAEzHCQrB0AY9e3h9F2Xzx30WA6yt3Qu/Co+HgoKG+5TGJywFb?=
 =?us-ascii?Q?Sy54QqpWRm5srwz90FLAh+sQgL9p9Ijzc84sitwOMju4UJkNP8JMdxYHQMU5?=
 =?us-ascii?Q?gViOzghJX/xd0J7ifDdhDOtR90wzFYAkCXCUsBoPt/jOHjOijeTboW9RLTDg?=
 =?us-ascii?Q?WMJ6RjjCtv/V6XMLICSkOcl8kprrnRQEgpO1eE6IcfKkXlG0SyY52X1hbtqh?=
 =?us-ascii?Q?KlDGStYaIjn8ZtrKuJH9Nmn3TwLVcsqqswkfSlR7cgS5T6KSydVk1wK8wjiQ?=
 =?us-ascii?Q?SoyWfc2mqRgl6VCw9zx/beVHB45Nx4kHSYTLvTp0S18oAqDownpUSlm/smcD?=
 =?us-ascii?Q?/WH7vpqe69AbQGfPWYruVHxeQHnHEPktmn8yDPfwo9qUFmeA3UWM+CmMni13?=
 =?us-ascii?Q?y2X6+RWS1OH8iCX49wSK712Me4vbUVDqeTgiXo/hc0prjzfOVnHsm+7FwuPy?=
 =?us-ascii?Q?nvsY/IeCYyjvgnu7mZ9G6Kk8jDD7DfnyRXMxVKvY9/rS8z76yR4TqNHnNTGf?=
 =?us-ascii?Q?UrcHUSH0tFPQJQiGXJFE8RgQ1wb7MGaPeiwD7QyapQiDteAHhAo+NR+Kyg5R?=
 =?us-ascii?Q?A1c80uz11HBKVq3T+EXjnhinKTv+7TB2a0OOH6iGpdD7pJto/bIECQ2aqwFd?=
 =?us-ascii?Q?WWEuFdFQ6vcSsuTOiwukv9if8aXzfTr8F9CdsjMC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cb81ab-6215-4ef3-cac3-08dde0837961
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 07:22:24.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zibvTZqB+YMv07VRkjp6MnTUAAvpdNYh+Tbpf1nZQpauDit0WKvyPqxoCRPFM9dj8dvWK95mzAnDEAXNhsL2Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5140

Replace vzalloc() with vcalloc() in vmalloc_to_dma_addrs().  As noted
in the kernel documentation [1], open-coded multiplication in allocator
arguments is discouraged because it can lead to integer overflow.

Use vcalloc() to gain built-in overflow protection, making memory
allocation safer when calculating allocation size compared to explicit
multiplication.

[1]: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: change sizeof(dma_addr_t) to sizeof(*pg_dma) to improve code
    robustness as suggested by Markus.
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 996860f49b2f..109a3f3de911 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -671,7 +671,7 @@ static u32 vmalloc_to_dma_addrs(struct erdma_dev *dev, dma_addr_t **dma_addrs,
 
 	npages = (PAGE_ALIGN((u64)buf + len) - PAGE_ALIGN_DOWN((u64)buf)) >>
 		 PAGE_SHIFT;
-	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
+	pg_dma = vcalloc(npages, sizeof(*pg_dma));
 	if (!pg_dma)
 		return 0;
 
-- 
2.34.1


