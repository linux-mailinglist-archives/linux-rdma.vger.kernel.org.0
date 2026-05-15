Return-Path: <linux-rdma+bounces-20779-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOWkIg1cB2oN0QIAu9opvQ
	(envelope-from <linux-rdma+bounces-20779-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:46:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F65558B5
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 496323028D08
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3307C3E833B;
	Fri, 15 May 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="udOWBEP9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4DD3FF1B4;
	Fri, 15 May 2026 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866222; cv=fail; b=BrqkV7c/dK2Bl2Mi1fZPh/VFXvqKnOIZZS26vryG1BZfFhf3Jb2XdMEn0EInT09OaQp7aFNZsn1gxal6ySfj3gt9ukMTznxr4H67WegLyt6FqXNcjtjG3B0ItI8mdRAaUaPYgy/l5VFYOMpfpNjBBCsAkJxHyWd3kl2Mqp6AIbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866222; c=relaxed/simple;
	bh=j99qN15SeQBC14aGGofgJTIUtx9It7wHPXLLqdaQZ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hrKC+0oojuw29O7rJv4esnHHJnBswUEI9250NoChjzuVgcKq1cLfS8nsg+CgYgZX9mUQ+sjjuVi292kaoeWvwU14PhnIx5iO1oFA+VBUtILunNtd24eXoaJfUt0AKtaPIOFlZgjFM0Ng7PxUNpTuiGwb57A/4t0TpdOcW4WaTcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=udOWBEP9; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDF94RgzdD0mhvjcKLKSci81dU+exbYusFAwdajgpmNTgwHmXH+Vt8e0fvCcEyE3mw97FYOXLzl435ebbC24sqHQBRUxRTiLl4bzVMUEwsZhnryHdsP3cOEUmXV5XVNPkaZNXimtMu+WtsTik5o0XfiDkcqKaBoNauQwEBm47VIdqQliSrfhpKUc0csFOHVC6uB+Q+KzLdKowokoHLgHS2PfqijM2e16PuhB5007DVyw/nXW7/rceaPyl+l5fXrBSibL1I3G/iMhTVV2kY8a05tPZu2eB30U6DmDHiZC5RPUBT2NzUpHJo+iud1bwqH8IDAyuW28Akvk9ePtDrkHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmYuxiN5ZZ/T+NTdwCrnkSS8mq90pNHhmRuiSSre+IM=;
 b=VmlytMeyksbw6LbvATJIS3gUGEKkSfDLmqG6dQwrstHnWp+wG8YFJffgX9yHmWeMGrfpcaMUogMyQMtXodCa46vtL25hK8I8srL2SzQBOOyjDZcJX29MSw46NB2BaOAGGwoUwBqxNr9JIGTAznwv7h82MBYeQ4Euz52k8/w0n00HfcFVopamIij+BK9BMe3KW5GffDJil96va9KUv2S9ualrMLcZR9cIbFBjwnDknaZ2QBg+z9G8PmuHgzMHaq8ZqkfwilJpeDfJF8k5sIPngUJdDvx94JuoleSIKCiMbYhgdHZq8JA8HPyjvCxNEzRtRfITkC511pF9Q6CUjvyNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmYuxiN5ZZ/T+NTdwCrnkSS8mq90pNHhmRuiSSre+IM=;
 b=udOWBEP9iCaDByrPZXVT3+0d66Ul3zlvi+IjYi153Swb7E2onghePh3LANMiFGjzgYeM+e02GRWiOI2GrF0+jBCEuOwkex+JYdHmoXE6kbhjyUNR4YfWnI7ydckb8hXuBhqlmK/TtuhshyPnM85cyrdx3hlK8dBmU7AQdTyLArnnJuiygDjEt6wBcEOzdAIrz21kk2AB+ytDi1whhGfiIb8fHCgXsMBdgBtEG54ZO72wlKQfmxHQ33UIkuLVWoWQNvCCdV+Ko8GUf40o9wvSXCC7PopO/rhU9Es4LIjoBGj4ZYLameGtl1o6XjZxkjA0h2c69XA312fmqJCySJMOGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 17:30:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:11 +0000
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
Subject: [PATCH v2 05/11] selftests: Add additional kernel functions to tools/include/
Date: Fri, 15 May 2026 14:30:02 -0300
Message-ID: <5-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:530::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be17fa4-8a5c-4780-c3dc-08deb2a79d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	7TjXhQGVagh644sSgMk3UXGLxZ/RCMjchusSqjzKzIiBGiTdz6ujaMK7BuLMKGY2jnr18wclOaZUd+cj86BHNwXRkUNOrA6SukN6y99BF6if//sCcStzQso4CKKIjN8UfcSwDtKI3iTqppgj3btPJHDXqbw6ZEEXtm1zww2E6UxdjVwqza2pL5LopHC1O6dnLngLoF0/Q4uA2KNaigc1nok2hVHFLklN8byogt0GSKEKHPWyZieLTtQMo+SwzWk00DcwrqFik0QRiGvMTaJnk8mrw+3pQNlkmlOopDtMy4TI6WoRzNb3GR41IvhdGfaQ6yjNJd/WqxaHdit+9QVatLv1XKDYoB7c9exTogaxIUmnYo3JYLWYHkhBTtNompcfH4Tm2QNH3ipB2HIi16PdL0kpcPYc91INR07VvgXei9SWnvLLNW8k2IJkAK5NK1IyNN5JXNTmWGeBundV914Mqsw8sORJ3VBR58lJ21XfyLi6d9bbwg7qC6fZ+yuNjB2r7bYxNzOY+HsHz3eYTcrds699UFRmz9LfWZ2vn6dWNI63/PCc0IsbMVyIRaOooyFkNRlhPjvQbRFkdBXyaCaRj7ZaJMq01FXxXFdDUySgUKKIGc8oKzaF3vmiF6dOrTx88QMtc9e21N7GfLMR7hoY/p5Umikyo2h41Y5v4K6dpbVJ4Zp47GtEVd+6x55IHqUq3NT14DONh09sFm/K20dvSWThA1Ok/Yjn2lS/VKdWdFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?36DbY6aNb7SM/ipKVFaygXfx6HFaPYGEo5oorOpRM/xtLsL3NVfQ9+4L3WRx?=
 =?us-ascii?Q?rCAbjEcnHrRmJcq7nxrEJdIegpFJJ0WRYi5tEo7V1YSkAZa9UalpbCvKGOEB?=
 =?us-ascii?Q?p9T4ZVKNZ+fysllVCdBKol0Jw9MDtklFwSnEaF127L+9PEEHS641RvNk/a6z?=
 =?us-ascii?Q?0CSycvE2V6oaKfzts+yWW2RnOtTExXJez60Oei0aIdSDixaNJOTNBFzZVZXj?=
 =?us-ascii?Q?t9qSHFCWJ6+PO9Qz4TeF0HOhEGP0z7thKP6H7+g/dwESONm7eaXDuF5yY8ug?=
 =?us-ascii?Q?XbddsvjDdslm8bw3SfnAHfN7pVxr0/ooLUcrbPDE4Ql44+2jS/QxXrzhDAc4?=
 =?us-ascii?Q?72IJoR6pZMG8gN1Ftk0xhxLdE5IFa3l7ooQHwP13IAsV00Aq9iwmKYtR3yp3?=
 =?us-ascii?Q?Sf2bNHnM0II/0io1xst68M3R9MPLixSPKP02sKZpH0gB6HfzHEmNPNgP+frb?=
 =?us-ascii?Q?LHgMVWjPG9vVCFeISXx/ZSwGfHlY4XcWW0iB8/J+T8FZegIa3zB9Xmf6wkiZ?=
 =?us-ascii?Q?23QZD0ECnmwkPBO5ecSqSiuo+v/7p0JhrkbB/JlgsTU6SZ5MJj6ozOC4PhMG?=
 =?us-ascii?Q?T9RGCwCVwapw7xcv13UK0qgx+gV8Kszx9njrw2ND1E6tCbI+bn+VZd/G5Jcy?=
 =?us-ascii?Q?teQ3oL34492M8rgcig31K2Tmt1p1g82qLjl2l0U1yH1KGdbLI9+FZGejNh8G?=
 =?us-ascii?Q?DfeFCfyyHwiaCDgzWFgpY8Dceo8pdIao09Kjps5b6L8asE3hobSPPAn4UT4J?=
 =?us-ascii?Q?dQFzAYVQg1NJ+jjqKYZjlH7lt3IbeR52TL/tMNeNquRf59HKWm8EY5514xJn?=
 =?us-ascii?Q?uO+WxqQ2+VQQbZF+o4FZnzA0SOlGYQREscd1sLOl9B/xO5OzypaxOTaMvkpm?=
 =?us-ascii?Q?Z4hyrQA5bGOxuTCExZhNIRAtUgAEqxG54zQ9YpVnWGGJu7bUbe+XnVKKtcjh?=
 =?us-ascii?Q?C/9jeduEZBO8LP1UitYTnbAyYT3c80Oztsl0Q3MoY2OjgxqrIiepvYuHmeSd?=
 =?us-ascii?Q?03FMKBlzeaTOLzcS8vb/7UaJaWEjRk1LMnTB0XLhLcZU7n/7/8LIbt3aM+4o?=
 =?us-ascii?Q?t5BBR0+axeg2Sd/n1EgTVa1+odivM8x5/m+pv+Dclq0ZgMBoH5UkjyyXdiNn?=
 =?us-ascii?Q?IM8oG9hemRYTokaKxDVBtkpMBCeLrGK9jRoYqNeN3PW8grIRBCZR7tmBeo0a?=
 =?us-ascii?Q?K/oZiksuQlGYCsZC+6c9a/+UUnFfS1UAD5/oVE35WKrKA0zOTg+q5EF7oNpT?=
 =?us-ascii?Q?NyWRXR6VwTpNZKIDbIbAaooTluqDeTQFWn2zwxeQ8R5zmlCrwjZFdGwhFi89?=
 =?us-ascii?Q?sq7qqFFg7/Wql2ek85pA+wpbEbu+kn1c7XCAdyEJZhOlIsE6k76KDbhWU+l7?=
 =?us-ascii?Q?A+hTwUauhRRrbgP4/7kAE/uhealuoj6QqRQnrFp/ND442vzHBxINHmjOuVPf?=
 =?us-ascii?Q?Xe1CmL3K84Nq8h5Tp0kxb+AmCCTHTAuijEsgUCslrpcIVds5iOe3YcTeuJrG?=
 =?us-ascii?Q?dp5jv2rnF7aicvvdgOK9fNTf8M29av7cYNgaCzDY8vQI1Iqn91sxfGS3nO2N?=
 =?us-ascii?Q?P3K6YvIwX6DuI4DjOZnyrdDV+bpCI8ynAFHwUfJv/qkn7LiE9Qb76zh0gvYh?=
 =?us-ascii?Q?asIMaYaxtVRyhARLCdixOUwCfw39d/zSEFK9+spWnnZi52r+GrKBzDwuXlIL?=
 =?us-ascii?Q?TOTu9/8C7UKMqU+h05gVfkrAOdtL/GaMN0vxXXvKDXwG/hUS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be17fa4-8a5c-4780-c3dc-08deb2a79d7f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:10.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZu53+prhzNlmlRWbB2nlYhOGiVh572BNy8+bt5XbB9L07pXl/9guPsUCd68bdzS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Rspamd-Queue-Id: D51F65558B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20779-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

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


