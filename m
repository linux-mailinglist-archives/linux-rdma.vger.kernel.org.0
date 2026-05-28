Return-Path: <linux-rdma+bounces-21447-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDlaCtuMGGohlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21447-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:43:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5C5F69A7
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B08A3008FD7
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B878D438FEA;
	Thu, 28 May 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AMnTAxRm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B0413244;
	Thu, 28 May 2026 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993438; cv=fail; b=a/WSzZz3WMO4lZUL3TQM2U248a70Fwqg8Dv/ri7D0gJi/BOHAGnWRzub43gDKx0sDgQpyBtL6tH1Q1mn1YsBYQjsxBX6e8MRG8rtjKDBEmdXcQIE00+kjQs+hpsbkd4BApos0KI8dzEr+6J1FE04hRkx08fQVtanWv8K8460Ygc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993438; c=relaxed/simple;
	bh=DpFoIxVbZ6B1yxfAQ92aifZPIx05logqPTGDnx0KvZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+1ID289IVnRL2mRP1GU3NKvzaObt6/0LxrTByaoOk75miA+k6OgzVPqXVtaMR9dD9oBz/9tksvrCBOrGQgGdqe4gXWokE5tSxikBM80stDoZCRYCwNxHn7T8HMz0SnTxuJrSlF9GbEWlOagmGLCtSQRe4NUEaRDr3MAJz0l/No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AMnTAxRm; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua7e6sTVCSm54T1w9qdeJDnJVDM1UKmI38S5EE0Ve7gurBHkPqe5m5nmkqBFJhe1xrxI6ZpEltPgPM/1FIora7hHeEnGlw5MeQxzuXHKLZXHFb7OAh6z5y2oKYCk2zo10btA2mUCkbXthGn54di9GoOWwiJyUV5fpa89Z2FqmRjN2nscYf26tePLAKKawqb+lgD31MTyV8Uj31gihc5r+tdcR3NDv9BfHEPUqvw5iV0rGzHyRS1IzTdu9U1h92ZpirNM57wIEUKMD8laKHj/4I9fG+PSyrqx1VJ9vCtEAYozzIEkEiMf/QNpaFwmkMKGNe+mRRySFu1ndmADTfg+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PQPTGgW+5jJ8MjCKXde+aOACcWcw0cA8alBghShV+M=;
 b=VPce/M+k7x6YMClOEg1wigZYAkHsDpQJ5ib7CIp/oFA30aNokutjRHgR5vPotFXDdABISd0Ivc3ktbI5a5AWA+ASpWCMbUsiPBRcJUIgSLsfcqIJbpG0zTOEzr0vnIs7oPKodyRMcERKFUM0tTqTekiHLl5GdJSuhbfcrC3QngSIYkPoQXYgde8Yabm4vuZisMrFiH93IBDBqz0GQy+WyvzEEyFWKvUi5k1+Dmx8x4WeiTkki+EMtO/vLj3bw5cF1zcbZRmNR1Z+MwUL1n+VCPbfUsJijTq+PGUmLHR8iPIDsUvUZAqZMypBWy71Aehonu1e5tQJdptQgyy2nAfv1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PQPTGgW+5jJ8MjCKXde+aOACcWcw0cA8alBghShV+M=;
 b=AMnTAxRmgDxOtlxapjpksGubJJgSq+IXWUTlcBoHJnnLx0oBqd+cpjEEWERQM5eAwzWYQEYejMj7izwPw3hMYZqUOLVfUvAJcipe4AsFcHIysOF9tZkMQiof11veoLF/vaNEM/gv8p4nD1VOlRuqKeNXfuLbU5bxzhWaEcG99y3k10LoIEgi+rGZVMDMyGxeOweQSwJI8V96neKSBPGTksKVTvc7pjzbUYrIWxIMY9HhgMOMjfUgxPt/xdpMAZBHlRAT+SIENrIdnkadUyNsHUB7bWa3GSEre5baG6t8cm0A7IPJHNWX+JqPkpWCsriUdkDUh/0uXmm6IFXk+JoNsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:37:05 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:37:04 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <ynorov@nvidia.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Linu Cherian <lcherian@marvell.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <yury.norov@gmail.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 10/16] RDMA/hfi1: Use sysfs_emit() for cpumask show helper
Date: Thu, 28 May 2026 14:36:17 -0400
Message-ID: <20260528183625.870813-11-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e9a5fd-183b-4d51-ed60-08debce81d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	kg4peQ1ib+ftnFzRtF5iltOuNnPuxBCHQU4jOykuESpgpz8vXR50WTOCgjhujOgQLuG3pfkCEeh+cdfFWMH4asaiAVhdmMxwQe0kdjgkZB4T8UNYht+7xQRwvbybft8CFt6ukLyrXhkN1twTBNmNMYATBatjdhPAJ7VlSliBIyL4NR7fpn5dJCitOiO9Ggg3nmI7I9uVvzOSMwXIc3u8x1itDuJPnGASEtKHXbvUw07ZVS2fyYlVLSmJGUThkJaG/VgUK3mRvGJj8Hiq6+9iTEEMtHca6YtzsEuivfqJsMyZQYVJ25f4FX9wvVqeBiYaWoGyd56MJK7psdwqaP7yLULrnanhmoFYnNi0oqCj9euS2dzk5QpUg95SCHHYsc8qDe/sSUafeOcLdSDy1ymT/GkErMTAPbiDWPqNxuTf28gdrFSj/i46VPKtzYTAu8o+w6FGIZX3SQ2A4sBQVz6we3fNqQYC/CStpifGOeNmXOt+WRVKtWmIoc/pTE//uZlzjIq8DHrCMFmO8aomXn+KYY8gIPeLtTaXqbmihxlMwi0MwfVIyHr1QIBOnlIt7hnJF4CPnxeG7Q5afaGrwNsDLCvYvz1oWaNoVmiHmUeKP5/D8sdj/svAWawryI/DTNpu1QIXWv+Ms6ZVCM0fgIA5/rx/wBgP0ob+yeNpdYw4ivM/xtkpcnJPtgUhZ5sTvXzU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P4wnjR/kLY8rZorzRvC/U0sZnmZ0T5C738qU4h/WlBwGxja9RZAmGqeewJFQ?=
 =?us-ascii?Q?JbeuhfloQVDVgEkQEmmHIVAYiQWn4XwBU8eQ7/xy/eAJQrxDlTZ6wQheImV/?=
 =?us-ascii?Q?RLYwYvzPrfqyd2eI7wcH4ikiJIWoxJL5gryuh42oyYsXor84NFd4IuY1LHxj?=
 =?us-ascii?Q?H22GILq+Dsbwvfm0wqMv7zogqE6zrCvrhk1/xSKvNZIFTRAxVHQrJJk/i1OS?=
 =?us-ascii?Q?vlZvDMlzMnDQrm/gMjI4LM+eZV0BE22Soc9M1fhsMfrrrIhjGyS5FpRigP3c?=
 =?us-ascii?Q?CI1211Vhh2z6Zoh/CFyKO8i7cxq4jCdvyy3HXnS7P4bcMniBoav6BKmbTbLI?=
 =?us-ascii?Q?qKT5Y4U7/mes5feKpksvZuDa1HEQjZT5lkvF1KgRM6Kx2cgkTQvA1sAVJdvK?=
 =?us-ascii?Q?8Tqkd5pdJ0e+zZ+SPKufS70f4b402mlgQXDe+JjTBkEn3NvohDLoHJqnuJX3?=
 =?us-ascii?Q?5JQxIFcXczZNoK2BUb8whZP3WT67M2ZYU64yv+O2PrXAgHkNPYsv3XPsuWCo?=
 =?us-ascii?Q?+y1HrZsD6oO08i62Mu6tuYMnana7KM76w5a7MBUochFmLivDxZIN3tLuVNpn?=
 =?us-ascii?Q?sHq68YgNRVMPX+2YMeRcFlB65vNcZXZhuVjRy4VwvkV/Uer7KzZX5b4ZNrFz?=
 =?us-ascii?Q?YTx7kdORyK5pcyFU0zGyKVXruw4kLnoErzXWrEopum61aOMBjQ4XfD6uB98X?=
 =?us-ascii?Q?Z8ciu/itzgcFmNYeZTTygVcOqHXKiHcMM5PN3yu8DCY7Eqn1fLIqjLidBAq8?=
 =?us-ascii?Q?+OKiUfEZ6QGL5jZNyh/creZCysCFmWFKCbZmCE3KVzWuUSJfoKxj4a3Ei7MX?=
 =?us-ascii?Q?BQ6F1GAPp89Dob9hzXiY6lmWHlJ73AavpV3QOvQPtDFy5VwZ2Y8K6qhaNCcA?=
 =?us-ascii?Q?lksXKFUVcTLFJHFvGkDXbxG1yRmK20pk+sqcq3AysgMskAxIpLBkwH0eAMyf?=
 =?us-ascii?Q?p0is5MikX+tpjhTJqTYGGA/ar0pzzgiCGMWWlhiVzIYUQ8ZIbnoeLvqqZz1F?=
 =?us-ascii?Q?lcuC8uzSZgJQEZICzOcDpMkKIhuTBzoZ8WxgaueAeZjoTTKXhe2tvaJOOB01?=
 =?us-ascii?Q?WH/GWHRmzkmCk5T7EtWJpUsaZNdRi7FuBTb9IGOj3CiMRl6tn6S4bKwDTkq2?=
 =?us-ascii?Q?rMJAU0T6b6NYY4pxHiXEhiXLDF2F6O1DmKH57yLKx+LJNj699zqPxxk2CKnY?=
 =?us-ascii?Q?as3L/xuUQOBy6tTbYtAc1/GCnah5aKdTw+oRTKKgzhON2azRQLg6mm39mJ+Y?=
 =?us-ascii?Q?zESJxWalQAYQR30wAFH0C8ikaRvuEnZhPZ8c4lyap1EIk65htvjkmI4u7qqN?=
 =?us-ascii?Q?addt9imnFEdSgbKFHJILJpVx3Q2J08xXi6NgV4GowD/EbQcAQD9r+06af3jA?=
 =?us-ascii?Q?UeVtgwfIiGw2029mTkyE5S9R4AWWsu3JFOxpUpCCV3ZQI75SyWU+pTxFyJvi?=
 =?us-ascii?Q?f+WL0vumwvZ95cXaLLlDM/Ro1kwYESbqIDfOXlsHLf3DTn6sXd1uE1twaNel?=
 =?us-ascii?Q?RuMzJ66zKvoTFsGlvi5c5vOBmIp/aSK94qFFQzTesz5zx3k+DMPJyL9dKIR3?=
 =?us-ascii?Q?dpNWea+EdNy6ePF+c2UOovu07MGBN+ebT4A03+37ZNQkVVAiveLMnC+FbncL?=
 =?us-ascii?Q?QJrCIner7QdgqIvGMmsi1cnoBXcXy2by9xliD0BPxLGDd7zw158f7uwj3z6V?=
 =?us-ascii?Q?DafeiD5jKCYUmHn/na8YuAHuimM/YjV3mlhfDKW8JGyQoYpoG6Os9hWZ9Pi3?=
 =?us-ascii?Q?hoOltPkDTa5AwO1yC5FdqzdCXeuapZNiSEIlT2sLb9/3pfvdur5v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e9a5fd-183b-4d51-ed60-08debce81d89
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:04.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j79sjAWCsXvTZAC4YUScSF0hx1L5IKS9RpF8Ponw9qq9NsrJ/Fd1WuCqHrhuaNWu4/ns7XLeRJ7n6BjZJR6zvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21447-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[90];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5BE5C5F69A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sdma_get_cpu_to_sde_map() is used by a sysfs show callback.

Use sysfs_emit() and cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/infiniband/hw/hfi1/sdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index cfd9dd0f7e81..f253c8ee182d 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -11,6 +11,7 @@
 #include <linux/timer.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
+#include <linux/sysfs.h>
 
 #include "hfi.h"
 #include "common.h"
@@ -1049,7 +1050,7 @@ ssize_t sdma_get_cpu_to_sde_map(struct sdma_engine *sde, char *buf)
 	if (cpumask_empty(&sde->cpu_mask))
 		snprintf(buf, PAGE_SIZE, "%s\n", "empty");
 	else
-		cpumap_print_to_pagebuf(true, buf, &sde->cpu_mask);
+		sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&sde->cpu_mask));
 	mutex_unlock(&process_to_sde_mutex);
 	return strnlen(buf, PAGE_SIZE);
 }
-- 
2.51.0

