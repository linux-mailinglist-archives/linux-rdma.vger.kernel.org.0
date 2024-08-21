Return-Path: <linux-rdma+bounces-4463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092A795A47A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC401C21B8A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996C1B3B15;
	Wed, 21 Aug 2024 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FtR8rIPQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48931494D1;
	Wed, 21 Aug 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263870; cv=fail; b=IfYZFbyXnjB+efOOfcvVyLVbp3vY2SPopXFj/x39xtXeYFcOGZ0cqLhZ8xOrdLY9a6fnUygUs+f4WjafM7wJLfFvp8MyNtE8EWP98ayyQvcimNxPQb1FfWrpkjW8zOvMuaps63f7WIG5XZ8MDm6P3sC9jrheEPWDAYhkKYLp8HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263870; c=relaxed/simple;
	bh=e7gaNTLa62kj7XljTeVlxiPtsm7WHe3Q6ZKjl8xPqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cu2sAMW/zHdanEhoMmyNgar2wy144cAntKW89j84AjA2VU+hhpCMlvqdj0M7AvtymzuQHpGW+RXxRDp+VdOiukuKhP5X2viI8BQ6olFSLJfuggjMx7vsxpMRVbZc9SFUvVBBwcHL89e9GJ/oRQjDPXIsOLE1t+RA1Wzea7GDYlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FtR8rIPQ; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbHtYDYtwAve3QpB7uoCbHxQkZs3okmi1BURSLDfw0LUa9GXJvGmC3jSrvDN1fM7J722d8Wo7jCPtnPovlqANSj5LUvfALn2dEYen6VZelyL0ge0lxfUrmVmN6Fq017b6TBGN16cnVxuB8g9HO1XhAJHHwpKyQEtco+J/sji3y628jK1IviJnwoo5VA/Ag1Kfei572J97wBbNtthz87WePEyOc64y4xbxxQCsVnJaf0miixVQBePaM1PNHJP0ki2IBbY2O5dQgbelGrwUKKvMdlmM4foOSLj6a8NKr3OW45+xcX3G/TokMg/5EtvOptNuzoEAtKoDBVmYKlLaxfuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkDEv1ZGGlKymQP0+EBPxx3d2ZZyHnwTVxd7ws1J78I=;
 b=KqxjhjmvPGmfKVDJIeLPKTTKY1SE9vsRepdTDm3duj/MxjHrlfk67OPNzlRIq/nr8bTiE2uNF9MBO0AB9Vidvt1uOzoI+mV0a7Wc1CU/s0bmJqgxA1zX58TxokmchWLng1EfXFtfPsxV62EACoJlQSJ5DmZ0ILWRdDRsEL8uVVDJCOxKMhP89jWYq6aHQudNBk/uE9tW96Kl3mOzp2LmxW0XTzhj9hrDAqSo7gRgcMJj31/gJroe95U+2/9yEq+UhXoV2ySK2GaUWMLKCgu0xTA5/qvA9DVxmyS1+fYKA/ooPv9KXD602mtZ8L1DPGkIM6oI8ttoLzuS2EQRxNxsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkDEv1ZGGlKymQP0+EBPxx3d2ZZyHnwTVxd7ws1J78I=;
 b=FtR8rIPQ3vBzDoPc3YUssnt6cEup976GO6cHnvLb2mt6sfh4fnzbCb0GKUEf58mgbSxJdzZzeIS0QPAFhMWys7zOIFd8l/Mqe7fn/4yb19zW0F+a7Ng6vba1SRjCpwalFskAyPJ++QG++Z5klXClnpXjwec3Ddq65uPlGxTAQOaBVEj+gjdQGLN9cb+oV2FbayGTnwIoxfZ4o2z65ZvRnWve/tUt8blZ1d7A/NgKIrs/fr+79xXUNuAfM7mJYiShLuXeU8w9iuubrFdVfxY63b9oao9+gVceLbyIY62FVd+xbZU7riarKhICJPDo///OxMYgkLG9oimpCnUE76Qvng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:03 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:03 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH v3 04/10] taint: Add TAINT_FWCTL
Date: Wed, 21 Aug 2024 15:10:56 -0300
Message-ID: <4-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:408:d4::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: aa405f51-4152-4040-523c-08dcc20c9e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mk6u7f1WbONNNfWrRTyttB6Oboe76jiNOxCR5wy49M7LOVgDT5MiGUkko2Ni?=
 =?us-ascii?Q?lTNuLlHY3KVMHcgoyKpC0W59B5klRhVke4juOXXRKExNxgJyx5PRT0iajuZN?=
 =?us-ascii?Q?txGW4KLgToDfKbWXK+fxGzwjKFPwHeqyBpTDKqpqP3RE/ebe9rDEvLwlmu78?=
 =?us-ascii?Q?mSfHXgwSzSonrs/Hv44f1D9D5aJLev79P9LOTwS7IDCtUpCwrf6c8JC7krq5?=
 =?us-ascii?Q?MquCD4zxOOqmw1fsd6N5HaGT4KwqRk2R+jjzfEJb0ecF7XBgsq39UmngMftK?=
 =?us-ascii?Q?e52YcK9ZqsV+/mEYMfRObd7KCWa7iI65lpTixQjmwK3k1PmXaQUK/uk4R2Rz?=
 =?us-ascii?Q?dGdwnJ6z3kwzNHyZoYSvqGqHgXZtKSbfsUYnpAugZaVzanZPyHghfa+p3m6w?=
 =?us-ascii?Q?AsZtd3R8Mlx7a3FkjlYpdsbd/t5HhiUt2ccBCqO+PAaA/syLmXn+bDuvwCHW?=
 =?us-ascii?Q?B+PVke9dQhaKXJq7M44q1f5pp67fRNzYwNovwvJlyX/b1kyC27o5KqySx8x7?=
 =?us-ascii?Q?AYfjBrIT9BqHS1o3h6Yhy7mlbxItBKQMsOO71qa5MQqvq4oNTLApCKWuf6eB?=
 =?us-ascii?Q?sDeIUW8VSjNPBBElc+B36N9vP6V6LUj89CCN+0BlaTWTmg85BoEqSGMcgRqC?=
 =?us-ascii?Q?6bJ9F++INpCq4sRcIWcq1ZNo1KKdJH86x5svsloJBDoT+qtJul9P6Z37De8+?=
 =?us-ascii?Q?9aIgXQlE2MmCivjOH56n4Ju4bt30DFQbsKqpq6qCZ8xVoPBtgnJJNuislifQ?=
 =?us-ascii?Q?LdkLTTGIE/NjVuW+yTYs4yF8auI8QM6e7xB588Gkjy4wF3aDz31sJXnFsoM6?=
 =?us-ascii?Q?h3dHBPRV888AXHAErl7Yi0SCaRNw/JckqolgyRtjHYK/WjBT5VZs3blPWj39?=
 =?us-ascii?Q?cNF1UU0yOlCfXs3Bm+xe9DoGCyVmZ13r+mfaiJ/eA9yTJnVY8FSYrD0rg+4k?=
 =?us-ascii?Q?OpexU7cKPfkhpCXvmvmSlYyiottFMB+BR5R+YIvfjCtupFau/4BlM4JyeF14?=
 =?us-ascii?Q?0wzGncYT9lox3ufAZma2jqEKVIhlP1LYOD4r2S8BB72AU2IRoqE/hEiCk4ea?=
 =?us-ascii?Q?ZVqYkyvzHm3xvcF8ULsQEs+ykbXQ2URFYm6c+P3HbZ1wfyA7J3gPLIN7ifMa?=
 =?us-ascii?Q?hUU1eeaMgJ1+b7b4RrQ6MIfH85p3aiGyD54QU3u4jyvkrB0AKW4KryePnabl?=
 =?us-ascii?Q?ewThWSpbiRaBSkgFpOaqg9cQiz0bz/mesixFC5PHD92ojAxyhudwWZEK/ZuP?=
 =?us-ascii?Q?Ie2eR6j4v5xc34QzH0TCrGRhfZOFJHsOgyWWme8zNFqiUf713n0HAqTehXVZ?=
 =?us-ascii?Q?fGxICw8WXQvXMXwvGlrmOwpmc3LM75NUlbrnesNXpQb+HQ0xefDCxC0l3BoF?=
 =?us-ascii?Q?FOzvCzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1GtjNDmPlEixHs8Pi/Xm0Kou3XZskWH7JWWLDf8/81oEeLy6WvMii41V8W8?=
 =?us-ascii?Q?tWD0XPNaYlVq55J3q95OCrGKsMoQEEbNilFY0s+tXO/Cr7S4F95/gU6I45Nj?=
 =?us-ascii?Q?PXvM5cw7cc9+jT771ljAMZkkItbM1k8AViAeeiWaWUO22IrQVjlc+paiC7Ie?=
 =?us-ascii?Q?W0y7qrAAfLQsMiCXwhNAV9kHR+JOPTRLqxnTy6JGWmc7NuHAAk57xk8HB+7w?=
 =?us-ascii?Q?FSbMoxCf5Gz/YZfv486NKxOOCTseb5Pd4fY5dtybfuOLtJDRF12RSlchAlA0?=
 =?us-ascii?Q?cXErdD+XKH3l5YPsQQ+tG7VpUZNTnshGkNS+kjOcCkGasXsgslflNxL+jPm8?=
 =?us-ascii?Q?HFcH2i4lge5om24EuYD9hRwOXreNiGPAx6pH3zca8+LE07Y9DOFzN0YA98FT?=
 =?us-ascii?Q?2D3DokjaZsc6Quc0/QT48IUAcRMSMk1sNiP6Kkl3IGJOxzIkKy7Bykf3SkN7?=
 =?us-ascii?Q?hn7xQJZDK3hpbIu5VVJbATvaskrapAd9K6LhS/nIU6BdtBepdu5HXCaF+MTQ?=
 =?us-ascii?Q?78+uPhHmFuDAgWcD6d95doUYk8xnqmO1MJEAnth0v6g4/b4fck2SPdHoIXKq?=
 =?us-ascii?Q?GM4ght+PFjigVlTtXPmYxaq3SBdJ98U+zLWH7W8V8Mosv0YYM3jXl3OcWYoU?=
 =?us-ascii?Q?HrB+y/LQnnuOL7biBFtzbx56OrQmLQOy3gYNfEnCeY3MvnzcfPaF7QnQQLzD?=
 =?us-ascii?Q?oxdn5/40/n3iu2kqlJdJiMPXaHv99jiUZra1lqi7ap89F6xwz/9IvIfAIiNd?=
 =?us-ascii?Q?nthilqA/UtzoBxQGXoAK0Tosgq3DetldqBbbF6jXnRmMD6iYPSi9fjiRHkKI?=
 =?us-ascii?Q?cfBGCDgrypJkV6ehp61gQVFn2B/Xt+nQgwZvAewxNOQPGj6rqp9YMR8f1JFL?=
 =?us-ascii?Q?YYmNE9cvrVynhuUj1jCi6WjDTZaardqIBIu/LGtW19E28p4I/6BUzdN8Uszg?=
 =?us-ascii?Q?OJUmgd3HFA71zFi1GP4gRnytDiC3EGFpcZc88tUdioXOGb0Oj+L70k91K5O6?=
 =?us-ascii?Q?GYUd+tBZ7YEjhDBY6GaUA8bIVkYjrSA4N9JT4v7duaW3sMrufcUJjnqdbphu?=
 =?us-ascii?Q?89x5JpEVweS0KiFn9VKl3CFp3EQOjJtKlSllh4uc5/lAp+JwOMw5395u+b0s?=
 =?us-ascii?Q?a8AprQd10OAYGGa7IzYGp6uwZDOFoaO/VNTH1iYQV4BACiob6VXQxaBgYKfw?=
 =?us-ascii?Q?aKaCkpuyiMmgOBViCmmjVSTZniNsVlo79M361AncDKrnpbWVpaQCfCKsPzIX?=
 =?us-ascii?Q?uxbLwGs9iCJyKAAYMURHz4nL6KfTmgmaTi8EFc2eLp/AG0inMnBRwmbTRchO?=
 =?us-ascii?Q?+MFNZJO9ofg/M9mh4JRVYhCuA2i3HhjX5lPB6OVw4FrjDER58crkpPPNHmf8?=
 =?us-ascii?Q?oiIE4Nmc4Ekwuaa9hx8csYHrZjqrN3vz9booKM3nH51njMx3mDSGA8X9wXh8?=
 =?us-ascii?Q?ik8aBS6mrRdq3VkxtOhLQOIF/3XCkPA2XjEaHxmk5so2bYKGZFOspz36Zci/?=
 =?us-ascii?Q?EbmGHZRGxUqBGB4F8qkK2WgMe37cLJd/sbnRmdGoXmkUWq3Sb2xptm05mf6z?=
 =?us-ascii?Q?/lRLIbrVcpCWCJRRDuOyvbUWf3JviDhi1vGJrAgb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa405f51-4152-4040-523c-08dcc20c9e3b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:03.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5cj59U7Ygm/Sy6aqXCHT/lDYvTRoGAriuTJgeGITQgHlf+/7izEQZntb9nscReG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

Requesting a fwctl scope of access that includes mutating device debug
data will cause the kernel to be tainted. Changing the device operation
through things in the debug scope may cause the device to malfunction in
undefined ways. This should be reflected in the TAINT flags to help any
debuggers understand that something has been done.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/admin-guide/tainted-kernels.rst | 5 +++++
 include/linux/panic.h                         | 3 ++-
 kernel/panic.c                                | 1 +
 tools/debugging/kernel-chktaint               | 8 ++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index f92551539e8a66..f91a54966a9719 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -101,6 +101,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
  18  _/N  262144  an in-kernel test has been run
+ 19  _/J  524288  userspace used a mutating debug operation in fwctl
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
@@ -182,3 +183,7 @@ More detailed explanation for tainting
      produce extremely unusual kernel structure layouts (even performance
      pathological ones), which is important to know when debugging. Set at
      build time.
+
+ 18) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
+     to use the devices debugging features. Device debugging features could
+     cause the device to malfunction in undefined ways.
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 3130e0b5116b03..bf4f276be661b7 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -73,7 +73,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
-#define TAINT_FLAGS_COUNT		19
+#define TAINT_FWCTL			19
+#define TAINT_FLAGS_COUNT		20
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index f861bedc1925e7..997b18c7455cd4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -502,6 +502,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(AUX,				'X', ' ', true),
 	TAINT_FLAG(RANDSTRUCT,			'T', ' ', true),
 	TAINT_FLAG(TEST,			'N', ' ', true),
+	TAINT_FLAG(FWCTL,			'J', ' ', true),
 };
 
 #undef TAINT_FLAG
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 279be06332be99..e7da0909d09707 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -204,6 +204,14 @@ else
 	echo " * an in-kernel test (such as a KUnit test) has been run (#18)"
 fi
 
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "J"
+	echo " * fwctl's mutating debug interface was used (#19)"
+fi
+
 echo "For a more detailed explanation of the various taint flags see"
 echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
 echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
-- 
2.46.0


