Return-Path: <linux-rdma+bounces-19801-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GmjFRjv82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19801-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:08:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2964A9196
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 776A3301379E
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A882BD0B;
	Fri,  1 May 2026 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MoikjP59"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197DD256D;
	Fri,  1 May 2026 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594123; cv=fail; b=i/4CRSvF0YyJm8NTfCg2har6qUqfVymb3byFhrTXR+YBEsBGHwDeydF4qMHOiuJ3ZdmmaWxAM9ieUwrBTkAVx6f9+cP8GcFbmRNS7Rfznx/PHmSUy9Gn/F33CFEsVCnWt8eYjHMfKeJELXaW0TdBWHzXt7hE/5xPrJ6JOhYYByg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594123; c=relaxed/simple;
	bh=j99qN15SeQBC14aGGofgJTIUtx9It7wHPXLLqdaQZ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nfTppE+lIqc/NdjRcNPCKPyxl34BQUN62sO2X6ggwM77V8Yyaoaki06fGx2644aO/LAGenq7P1BJUJbD0kZdchRWhRkQ9NVSr6wmUvsugDCaQ3EGdk9N1WHK11pUkkizH4OcEcK1chYs+vlw0y6x98iBbB+ArXFW7nR3H0YC0m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MoikjP59; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoyaYb+knryz5+E5BbHtjsOiy2kItdBUdpUV3h9RYu1UavsI0laZWJKM/OxS0Cy140Ma0Dtsj5vzt3q3Qtl05oRsDG3iaCWu351gpvbgz2GMXy5Gm3oLEeyb7wqvf6HowryFtZRhf6HixQfbkQpqnpcr9JDePEJehbfOHKPg/q8Pn7YacQhz0wZSupImfNFq05KT9XqcfRMsnzimFktsC5+gNKveB+EAFSdgaDMxO3Ga6IwaWqrtocRNcp11u3paSplDQn5QfDt9QY7M0HpmrARwZ8y15NwbppekYpOX5wqUYMT7RWpspZznVLCfJfHv8CrlMa21zprjtYjxdZBgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmYuxiN5ZZ/T+NTdwCrnkSS8mq90pNHhmRuiSSre+IM=;
 b=AEzArhJkaBezjoYMfjVHmpfCTQEHJm8QMDVMEjDsZ6MMCrdlVsN5rDI/rUVBpP3+H18v4Cxx1H3PC1Be07nUuM5qNTeR3dr/FyywghmynBlq483xqe/vR/du45EyxPbY8mU1pXyNvrc5T3sCxYqVFs6Glh/TeBWSAR8JZqrZEZLqWMQJZUaZsrJmAAeW1rnLWx7usiyzHRAcTjnpDKVku3Bn5pErAu3ZaqBl7bts/MwgVqa24f8soMQvVVZlJB6nX6om03X/+wlRoydxKT2H5YpCJCPRt2Qgy2J1Jh2+f0sqynn74oaFFoDvGBjCPGzTiIRRnYe7k5+2/bGdMo0e1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmYuxiN5ZZ/T+NTdwCrnkSS8mq90pNHhmRuiSSre+IM=;
 b=MoikjP59/MhdxCL8jHsqKHcBKGFW6kwyW2ixaeyK/LA6Nvr4DtG7hmFf4FPhmeYaGn3iWsEID7kkeso/as/6oG7MqcooKfGe7IMkwpizE1hEVPCerrP56z+JNtfJVEejkbIsvnekhcU4iDz3Jxw9srsfQA8EKtxsNmlh3NajtvApNPk5Bw6wiGG3YOmnE4i02NgoYtUKn1kibjdU602VUjUSO8DKy3x2KzwmjqIR39q34y8Ek3cDOoXShAsQODu39sVX1FKq04FM+C/JbTSub2s/3HASMK1KRo1+9OaC3F82Pl/Ijd3fq+A6xWdYhHzAogIwA/zSu+D0ahP+EU5AdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SAVPR12MB999167.namprd12.prod.outlook.com (2603:10b6:806:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Fri, 1 May
 2026 00:08:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:38 +0000
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
Subject: [PATCH 05/11] selftests: Add additional kernel functions to tools/include/
Date: Thu, 30 Apr 2026 21:08:31 -0300
Message-ID: <5-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SAVPR12MB999167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e318fec-c3d1-43d7-231a-08dea715cb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TyJZuKRy1JX2pQRK7yVgiLmMUc1UuA/ecWyFuURrwZ3FjDm7doFOjARz1pcPC5a0P2aPO/dKwqFCUaDBmO1VqCYBhdWY1bCD9z1TN6TwkpE9jFQ1AarYfE0Ub8Ikz9CDcLqo9NqEKBXP2iSjcLFsC7DXxhuJF/twLuN8ksSc7miWp+4bmeZauR48ns9BAfb3e7BoLvmTdKwrDQdvz9AmSkOT0ON37Lz/ETxilefAySJb3e30y53z6wkoUp1x2G5/fIfYVZ82MTjZu4a4eh0rqLO+Ac7FwooI9lWpiuI0C8jg+Sk1MsvzR0ovfyApkOTZjZVWuvCLxIAN/NkIO00QaDVUivjBCP6AZPIIAlQlSQJPheqcZbeG7hFD8SbDsRRr5LGf/8SxnszogmOgPFqpCzAmAyCjntTMPJBNJMTF0HKOBghyhW9flW5PgiKhOdp5CU5lQSVkPuqiDOyipc//0NQJnthSRylR9hPIalfrQkFlQlCILG3A8ZcuNshHFdQfAzjRPpTVxrWp4+6icrLHr/9JTQFfE5XGa5ehVAbm8zvUaj72RUJJwS9lZ0B6VfR5ToypbyEYPmOKr4biLkwg1AQb1lrVYW7AOTbw2o1hEEdros9L1mZgkuwGfr5GkeRJ+gDpf0tsSlFzWuQbHWaznL5JOAAdZtZJ3JhNnJQtFnjc9ZMKT599NUpbZHgXV0lLPHAL0H5a2EJEDJU1jiZEt2VDi3Axu7uwKPHeB/BVWeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LQPz0oY+uvsFZpnxsKTquooCJXctvyRA6QhO+s6wvoW83FhuO6JPO98dyFOg?=
 =?us-ascii?Q?fgV0EhX5FaHijS44rCryhmQ8CeiMToUEEj80iKzi0Y4RfCdWLx/UujgmyTo+?=
 =?us-ascii?Q?MRsmEdrato9dqtFvFRjZq8BFJBA8HCjHLwgjnxegkXTzCexWm8xoRviRmhM2?=
 =?us-ascii?Q?NVtwSmICSrmQVlVc1pWqlz6apo0wCDQUse0zhOhxYc2y+HibshzGLulMJKJ8?=
 =?us-ascii?Q?wBFJX69PGszSulBda+JbnxG8/N3niAB/K/4ETnx1FiC4HfAOVU01SAb7jGpf?=
 =?us-ascii?Q?3PFlC/Ah6AFvxRW1m/WBK6T+pU0jpmH0zyfjpnhhpQYKrPw5DjBH6GWzrqly?=
 =?us-ascii?Q?jwpBcxySoDsAsWt/KFRj4OoAkCGsfXIZhHzt3lVYdBmYcuSp/OWKLKMtzCe/?=
 =?us-ascii?Q?64iwrzUX1KXeTsd2g1QUm3wOFvuyzF4mSsE2RNRh825LoT80uQt0p3+LQAO2?=
 =?us-ascii?Q?Y9kLV+6GwbYWMl9hXs1cve2DVc24SHdKERkFm6RL7uI/1LbqirEFbzgocktL?=
 =?us-ascii?Q?btjUPsnR+ypNpz8gfkU0hUxwHCT3veyI1gycjR330RCRYcPToHACr8U+u+HJ?=
 =?us-ascii?Q?dtUYX/KkdKJJ97QDPs0sgk2FFZE+q6t6OlDK+4RACJvJ8mQ+PPo6jnGYCKOu?=
 =?us-ascii?Q?MYvOn32D51lwoynehpA/xZKU8wlNokeiDu/Qrr9a16OA/rnKlyhBmyOOBERN?=
 =?us-ascii?Q?fuq/ilD7hnOdruAGDnyZeJgnCnfm44hqNuUYCc5V3+KbD1szr8sKkT1uuOfj?=
 =?us-ascii?Q?UPayRzOC3FZGC+Kn8hq0Jn2HQvelCtQ+NfiX2V0/sNiieCKYF7kJ+mObYHyb?=
 =?us-ascii?Q?c56zgR9/KRTG9KB8bdUUQjAYVLU5fK/wA3Z93Gl5vgCQ+fMK7EsMb3RkDnlb?=
 =?us-ascii?Q?WuFJa76bp6IiMFaSYNn5RldUrTRGhkgT3QTF903ZHxf8WeN0IpcpQXt0BXlO?=
 =?us-ascii?Q?C6Hiyznrl+Zmqs1Yf9cY/UhALG8id1F/kbAt8tsdQYRcaWj1mQYn+UInigW/?=
 =?us-ascii?Q?ieT73YFM9AixQ8mj/fFmBQC3/lCgi0Km7+DLfk0kOe4FPZOe0pDfSrjk0P3D?=
 =?us-ascii?Q?vH8XUHfj0dQFRT8O3rhEPjYBNYgHNv9L70LpM6bxlTcIpehGclViVrtgxeT0?=
 =?us-ascii?Q?FjX2VUo8IUhdbIBGW6c4dEZnjA1P8gVdTzMwsWs+hXsttF0Mwxdps+B9eC4X?=
 =?us-ascii?Q?/mprDp8EB1jzPpjUs8NXlE53bOCnQs0UhKhD00hrzaYe31plPUz+3XNQg7af?=
 =?us-ascii?Q?xCyurzjkT1JykmoW9Lzwxik1XxKEGixC21/qSSj02VpYZdP7FZGCIOGgIytw?=
 =?us-ascii?Q?C7AxmwRV3IvxzilCmKOHV9CQwXO++/gsm59nfS0vh5bLHGTT1mGQNX6Zb+uB?=
 =?us-ascii?Q?sc1ipN+6iqfUKRAOzlQZVtD1AbgD/4alC81G8KvDxK8MRCtM6dBGgijgifw6?=
 =?us-ascii?Q?GcFu3UNSkyeDUMfC5VZVwthIddTCop1e3EPoltLmEfR1IMO2vQGMqRsYWz+K?=
 =?us-ascii?Q?Gpoc72fNU6psQnQt2HW+hb+Lo0cKPNX+WoKcVkkUEO2v/1BtlEJUTxKSexvV?=
 =?us-ascii?Q?SY4IkpV/uop6t5nURo8pAOkUHKeraXLfabxlnc+iA9NpxaABh58yRMXREEhq?=
 =?us-ascii?Q?66p7Z1M0n56YuF1LdzYYQyOT0N4TdGre0+Hsh4NNEXiCb3Mtp5Fxc4NmUKkA?=
 =?us-ascii?Q?sPmrferZnrhSqy6m2OWErBJDtK0SwAfAmYGV5ZZKbAOgdPCW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e318fec-c3d1-43d7-231a-08dea715cb77
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:38.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBcYI+YkwueNas5Z3/7cyVgrKqRpV0U+75X2joOPUQvGd7RGEF+MxikNqr0q8Vm2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999167
X-Rspamd-Queue-Id: AD2964A9196
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
	TAGGED_FROM(0.00)[bounces-19801-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

These are needed by the VFIO mlx5 selftest in the following patches,
which includes some headers from mlx5 and also needs a few more
MMIO-related features.

- DECLARE_FLEX_ARRAY in new tools/include/linux/stddef.h (wraps
  existing __DECLARE_FLEX_ARRAY from uapi/linux/stddef.h)

- dma_wmb/dma_rmb barriers: x86 uses compiler barrier
  (DMA-coherent), arm64 uses dmb oshst/oshld (outer-shareable for
  device visibility), generic fallback uses wmb/rmb

- ioread32be/iowrite32be in tools/include/asm-generic/io.h for
  big-endian MMIO register access

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/arch/arm64/include/asm/barrier.h |  4 ++++
 tools/arch/x86/include/asm/barrier.h   |  5 +++++
 tools/include/asm-generic/io.h         | 28 ++++++++++++++++++++++++++
 tools/include/asm/barrier.h            |  8 ++++++++
 tools/include/linux/stddef.h           | 10 +++++++++
 5 files changed, 55 insertions(+)
 create mode 100644 tools/include/linux/stddef.h

diff --git a/tools/arch/arm64/include/asm/barrier.h b/tools/arch/arm64/include/asm/barrier.h
index 3b9b41331c4f16..abdc64fc3c70f0 100644
--- a/tools/arch/arm64/include/asm/barrier.h
+++ b/tools/arch/arm64/include/asm/barrier.h
@@ -24,6 +24,10 @@
 #define smp_wmb()	asm volatile("dmb ishst" ::: "memory")
 #define smp_rmb()	asm volatile("dmb ishld" ::: "memory")
 
+/* DMA barriers use outer-shareable (osh) for device visibility */
+#define dma_rmb()	asm volatile("dmb oshld" ::: "memory")
+#define dma_wmb()	asm volatile("dmb oshst" ::: "memory")
+
 #define smp_store_release(p, v)						\
 do {									\
 	union { typeof(*p) __val; char __c[1]; } __u =			\
diff --git a/tools/arch/x86/include/asm/barrier.h b/tools/arch/x86/include/asm/barrier.h
index 0adf295dd5b6aa..0b51431fa530ea 100644
--- a/tools/arch/x86/include/asm/barrier.h
+++ b/tools/arch/x86/include/asm/barrier.h
@@ -43,4 +43,9 @@ do {						\
 	___p1;					\
 })
 #endif /* defined(__x86_64__) */
+
+/* x86 is DMA-coherent so DMA barriers are just compiler barriers */
+#define dma_rmb()	barrier()
+#define dma_wmb()	barrier()
+
 #endif /* _TOOLS_LINUX_ASM_X86_BARRIER_H */
diff --git a/tools/include/asm-generic/io.h b/tools/include/asm-generic/io.h
index e5a0b07ad452a6..0d89decdafb818 100644
--- a/tools/include/asm-generic/io.h
+++ b/tools/include/asm-generic/io.h
@@ -479,4 +479,32 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 }
 #endif
 
+/*
+ * ioread/iowrite for big-endian MMIO registers.
+ */
+
+#ifndef ioread32be
+#define ioread32be ioread32be
+static inline u32 ioread32be(const volatile void __iomem *addr)
+{
+	return bswap_32(readl(addr));
+}
+#endif
+
+#ifndef iowrite32be
+#define iowrite32be iowrite32be
+static inline void iowrite32be(u32 value, volatile void __iomem *addr)
+{
+	writel(bswap_32(value), addr);
+}
+#endif
+
+#ifndef iowrite64be
+#define iowrite64be iowrite64be
+static inline void iowrite64be(u64 value, volatile void __iomem *addr)
+{
+	writeq(bswap_64(value), addr);
+}
+#endif
+
 #endif /* _TOOLS_ASM_GENERIC_IO_H */
diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
index 0c21678ac5e65f..e7e0c7de5a2ffe 100644
--- a/tools/include/asm/barrier.h
+++ b/tools/include/asm/barrier.h
@@ -47,6 +47,14 @@
 # define smp_mb()	mb()
 #endif
 
+#ifndef dma_rmb
+# define dma_rmb()	rmb()
+#endif
+
+#ifndef dma_wmb
+# define dma_wmb()	wmb()
+#endif
+
 #ifndef smp_store_release
 # define smp_store_release(p, v)		\
 do {						\
diff --git a/tools/include/linux/stddef.h b/tools/include/linux/stddef.h
new file mode 100644
index 00000000000000..99182ea4a1419b
--- /dev/null
+++ b/tools/include/linux/stddef.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_STDDEF_H
+#define _TOOLS_LINUX_STDDEF_H
+
+#include_next <linux/stddef.h>
+
+#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
+	__DECLARE_FLEX_ARRAY(TYPE, NAME)
+
+#endif /* _TOOLS_LINUX_STDDEF_H */
-- 
2.43.0


