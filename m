Return-Path: <linux-rdma+bounces-19805-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CwUJHvv82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19805-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:10:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3141B4A9254
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A26BA304855C
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27625B1EB;
	Fri,  1 May 2026 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gfFDWnLM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20013C9C4;
	Fri,  1 May 2026 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594130; cv=fail; b=IO9uFG3giKLQzLkMcaKEEAaiVOktsXFVrloNaPmCMSTCy9yTP1kj3oVAWfH2ckvA4ovThfBBCPjBgbLBcq73wvRScu5c274J2OtlzDRGebESBpytRGhMpjYq7QoiDUKlS+WoCBL4O8WceenB6E6tEnDTq4jfYpMx3ftApQ9ZDw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594130; c=relaxed/simple;
	bh=Mbhc5FqBMEz9A2ZtOS8W/XS0cdye92wc+QHmjzDxrxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmyYw+WHuXtKibPV1MNP5TbyxIFy1lO85L4ciqbDf9jpr6/UUl7avtYuN17KGMX9o5hDbqzWj6lSISESux5udQRWJRBdU7BA24OzbVu6jmvwIYZRq+WOSc+2uV0ciAUWrrEordWh8kUWViM/EUaKWDY6u0FiTL34D46HNerNmnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gfFDWnLM; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpSGxD8cI8jtmeRVb7YAm+2YkAHIvvNGn8PE5i1DiZzfy3dWqfgw2hCL1168y8H85LJAU86aUxStDDHGvNJ3LC3d0FoPskOgcrlA2h8K1A204SRjZ9UPS+fPThWRs7RWG7iGTFAUXvEGpM9VF1QPuwhE1hqpNbzoNBqc4r3h2yCXB73ml8gABZQ61Q//HFrvKtMLu10rSUfmW024mX3Z0tdospjSkBhnPYmAfsNX9TZfasEUokRoeHX7mggNwlW4M4onVMZy3iDri0Gt5sULxTwPj2rXtx5C8drMxPCcsUsq32HzaGQIOaO8qwtSEa/Mi+PsGIeZ2nKlBwR67A+HrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbuLwKdcj94ghRoxb8IF5qCmxobWHZ7gWtYvZqSrY8I=;
 b=WUxJZV0OFb154FyTYi974Iqoquf3XTXgl+QTJEKDEFXIP9xzmKV1VcFLONvkgZGFH4dKPMGKu8vu290QohJGG/oP2x7eEz1hAgpLgxysi2uBWS4O7kggo3rjbHtyfilnv8ChQPbhPP212SaEOt+zLQW5fCyDyDqH+JcTuu1VJwwuLeGQnUeS8ncWLFtZcp6EZBJQk+8UloHujx4Qbibw/6lMjTSwgBFkR+ENrxbNvuCC7IoeBAP4XRiO89n/gcIHsMJxmrxg2fb2LBpg0LF75FuJ0XWuNv2x1AcsUkqfV7O2kVqmaQS7uddgpK1uGL9VCAyG5MaJKjdv1RVW2LGUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbuLwKdcj94ghRoxb8IF5qCmxobWHZ7gWtYvZqSrY8I=;
 b=gfFDWnLMaEn3ULgCs75ZvcZXgjR1QitkESJ/o2UNnes59w7fBMEO4q2nlTJrHUaogO7SOMmwHoAc0gIeNDOl4rffIbesUzL5cVFi7GahFNGZuRrUHTgw6yqDnYXzjA9UM2hM/LG3H5qYSzQ5vUozbg/jrw9T7bL6PBewT30cMXkP1B75mEJrEsvoE+SZiuFGViZfjj5rj4l2cnNnvUC3DiyXE6Ux879s+7dsKZxp7MDnH7qsSTbPaHKoKhMpHJieW+/1k2a7y27Cf6tRY/mBZNJ39Gk7QOb+1NGw/J9ApuCcoEQWb7Mr+6AvzRp0TrFm9dBnXpd+iokKD5bHBrXoqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SAVPR12MB999167.namprd12.prod.outlook.com (2603:10b6:806:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Fri, 1 May
 2026 00:08:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:40 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 06/11] selftests: Fix arm64 IO barriers to match kernel
Date: Thu, 30 Apr 2026 21:08:32 -0300
Message-ID: <6-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SAVPR12MB999167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8fa1ae-7ab5-4516-3be9-08dea715cc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FDWN9jXkFPZ8N8rapFKUS95qALRAbn7VXWYTOT1v+nKi9rzuXYZSC1zNWZU3kbyZSWQ5Qt/7ra4nRuyW20mn23xZAabBNfaHIStvskyw1w7lCpbdsZEBMbtmcQZY8EASWmwg6Mip6M1dqqVJg4r56lvaMeI/myw+86aqmjBG8N2y0VU4Dx4kAoXQBebAqOUfimB8ynVaVvUiEOzPWtG5LZQJVuiDIPir3vJ2FU+6zVKIWJAMKZvKAdFZHzS7Zko1y+/FP5r3SeuuRr2vsPtW7k3yidIO2juu0olnhCdCb1upJojU+k57NYEQnYAmogpqivdxKEhMUKo1hmazF3rf/1CXfyRyycHB6QEZTNRYYe9qjfKdKbGGOJoR8Rk/SKMB7Yb1X1cfra+czcGBAgAVFBJ/p1mM8Vx863RVk8C1d86sFMMEV4Mm5nUROa3tNa2m2KgS2/LegWPBvXtgot4uRzSdYnIgUJp7klhDNpOhEMTpV/ocoWXfJI5RAsh3fsDQWaiIqAU6sCU1gQPw1LO4QGknrbTKLpoFm5+iT4XWBhBzf+BdHwU3BOXjBuxPM6AXlKmnQp1GqwqDr4IkZ/XI3mDUJxH0GiWJLe7faDXPUfjxLI6zCaubf1hgVH5nRwmHg4YRjdzM629Y3jvqHfciSGGVntNBZ/IdYaGmSjkOSmTXeovmNtkH4bv0azykRvEqK9HzrFcNLrbEYT+dvtTTCyNXs7xU+Sfc4LXdY0BI4Dk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pme8CO7gi4N0x77QYD0hP6YH8JnXIm4V2wtKgR0KSdyzSANi+ObdnKyCKSFn?=
 =?us-ascii?Q?0SST/NTYM79mkjBYJpHFxNoYQALRUfilfvRaRUCx5OBV+GX7VPjJrFxlnsyS?=
 =?us-ascii?Q?jB+5FJWNDcdhDypJTvfTkOpAfuonFygQRZMiXQkYiYc1sBMs2a3YvWX8NvAy?=
 =?us-ascii?Q?LNpTo5RX1jm6UzC0r7GWieLFcNIbziwYkBvdTrSnJ7RznK5l0I187LctP3H5?=
 =?us-ascii?Q?vARlrGIn0MvnVTss6wUyCkzz85izsi76oSYeE2pBbOFuLvzIdbaBYh+j7PUw?=
 =?us-ascii?Q?wGZJEcGwQELVEpTUvhYi37/pyqEHZN7wh2/OCpf/SxxWS51PBuBuTOuQg9Cl?=
 =?us-ascii?Q?c3AQAYOwp38fRnXaBZbtx5ZqWrLAarvMXC4loeX2+BK135Aj2hykvcdCtR4m?=
 =?us-ascii?Q?MRiZskZYwGiJZ3OJm6QtxS+OiVhzRmNsoUvvSKecZXqqP1z+N+Bd3vC0+wnB?=
 =?us-ascii?Q?j+QzldZM15NZGyl5oz1rSW3RWAYn56WxYBSp4X7X0hHxpnckDOD2JKZHTkvr?=
 =?us-ascii?Q?gATb9H/hPzVlvyx/ZQehslD/oSxrprZ49gzyu/+QqJLN8z7TNifUF2rh014B?=
 =?us-ascii?Q?J80yIeE8E/ATjkXfZeWiuEh66Lf9OIghIfjvwejViD9/Gmh0Gx91ed0QKiEB?=
 =?us-ascii?Q?gyg3UWjKsBQkUAng+LMvXpPj5bafOlblNAYZqEC9sNPLtL1soqwbuYlRMq8C?=
 =?us-ascii?Q?KTHDha4BbrtmAxktkfFMGR7Kv+KWbDiBr3TBifC7vxPU8m8bGQuW0Qu4S7d6?=
 =?us-ascii?Q?jnl0oLwVIGcXsfM6ZZI6YNlsiDI1vp1QxmMU+uGKycdgv7qzZ4SZZ7fGhhzM?=
 =?us-ascii?Q?Ytyn9gCYu579Vaoy98D6Lwmy9mBtFzotCCYvSA+/uIQYgjHAwbm/hXx/Hohu?=
 =?us-ascii?Q?mZhEcGpftNus7MpcnFQTC3HTU9AF/pP87nUesi/piIK+G7HxxB98Fza42ChM?=
 =?us-ascii?Q?CUQH7KNC+X6L1+niWDNgtC+Tu8qE85FP2w+KKxmQl99CtWnty6UJlMZdSXR2?=
 =?us-ascii?Q?cfBTnKAuJywdVWpM1NR/wAfTvJvDALq3tPCez9guqdHVjkTmU8D2yv5fXlnY?=
 =?us-ascii?Q?Ra8fo8hwJAdE+Odz3icbqpFaKlLtGW4HnQRcjGwyHlbYLG3fIiB0VLlEOO1J?=
 =?us-ascii?Q?xpD90/Llo4iYvfiL/0pi2AD6CFxjSmWW7SVAJo3gOHzN5gpdCHr+4NAql7gr?=
 =?us-ascii?Q?kZHzwYyQwg9FyC92MrW/zLMdrNR59rY7iE/Djtu5IS0yP8KGkG7sF9WJq5YK?=
 =?us-ascii?Q?vdaT45OjBukm7/4R4mDT691AJ/Ydoaeyjp3y0FaIiDH7MFxNJfOOpgmsaCbJ?=
 =?us-ascii?Q?1aVwjcCwweqBDIofLzEQsWsfVXynqu+94Ii/P9Hz2zXiPDwyyheVM414/YnY?=
 =?us-ascii?Q?xPJXuzc6KyXp0D7OiItHgYl5jWY2kYP5VeSaY4Hgy6P8glUFzfQXb5am5LTV?=
 =?us-ascii?Q?4baV/4xF4qvV02hVxA2G2/fms9GwAuEdsqQzp/SW/IdVKREv3JYp+OiSefxN?=
 =?us-ascii?Q?WVFlYL06NTNGBp5PdhXkX6ez3wo+fK44pmiIoh8DrSLq1HhpHraLlVe2FsLi?=
 =?us-ascii?Q?cBN2NV3I8d1BzvB3j2ICU+k+TKN2NCbp7VaJNr1cVruMSo1JW+SMBGvfLSLN?=
 =?us-ascii?Q?0ehskldi5f81+kweG9SzoXkcE19IP6QutuCoyxfKovfM/LuGHnJOSvjG30Z8?=
 =?us-ascii?Q?Wm3Euipy365rfLmEyceYRtvx0N4oWLrWb+V7iX2IibdUomH3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8fa1ae-7ab5-4516-3be9-08dea715cc2b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:39.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNV4pcqmq0HwTkSza2CD+pAPoUEFYBG/B9lOuGsTz9r0peL10ZvHOfvTrExpMZbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999167
X-Rspamd-Queue-Id: 3141B4A9254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19805-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

The tools/include readl/writel MMIO accessors on arm64 use
inner-shareable barriers (dmb ish) while the kernel uses
outer-shareable (dmb osh).  Fix them to match.

Add __io_bw() and __io_ar() definitions matching the kernel's
arch/arm64/include/asm/io.h, including the dummy control dependency
in __io_ar() that orders MMIO reads against all subsequent
instructions.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/arch/arm64/include/asm/barrier.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/arch/arm64/include/asm/barrier.h b/tools/arch/arm64/include/asm/barrier.h
index abdc64fc3c70f0..3f7fcb2a27541e 100644
--- a/tools/arch/arm64/include/asm/barrier.h
+++ b/tools/arch/arm64/include/asm/barrier.h
@@ -28,6 +28,20 @@
 #define dma_rmb()	asm volatile("dmb oshld" ::: "memory")
 #define dma_wmb()	asm volatile("dmb oshst" ::: "memory")
 
+/* Match arch/arm64/include/asm/io.h: use osh barriers for device MMIO */
+#define __io_bw()	dma_wmb()
+#define __io_ar(v)							\
+({									\
+	unsigned long tmp;						\
+									\
+	dma_rmb();							\
+									\
+	asm volatile("eor	%0, %1, %1\n"				\
+		     "cbnz	%0, ."					\
+		     : "=r" (tmp) : "r" ((unsigned long)(v))		\
+		     : "memory");					\
+})
+
 #define smp_store_release(p, v)						\
 do {									\
 	union { typeof(*p) __val; char __c[1]; } __u =			\
-- 
2.43.0


