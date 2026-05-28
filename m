Return-Path: <linux-rdma+bounces-21446-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MJ0ILqMGGohlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21446-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:43:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 093375F6934
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D9A53016004
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1872436351;
	Thu, 28 May 2026 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KEEvQxqo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456842EED3;
	Thu, 28 May 2026 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993434; cv=fail; b=C6EwNjzHS9mtecJTAD0d3xVZPBKR+ALaIcMeJLnRRr80xT+dEOsKHeoQspvOIIvH4oxlTmD2V29bGZlrwheEXuahf5TVA3v2QV5uHAMQ7xs9fnBFH9JODyNSNc0nP3eFxY2E1YpoguPsHGb4eD7uGmG4MTi6Z3Zs8U5tpHn16js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993434; c=relaxed/simple;
	bh=h/+NSpcns7u3kOOiWEcaMUXY4XSh68ncagM5FefDIpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NhUtHJVa3uBZGgxAtMlhj6x501vGdtv7rqI2WKr2MY+zdmL4d7RmDb3gRFblygfbxaanGDS7hBR5QbdjL01X2wwSMHk/zNFtWEM+W8dFbkOZyMprIQJmxnYfhRVgpjEJTDD4IarIIDe7utJ7fa6gKgM/+t9aeyuOAF95smL/7Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KEEvQxqo; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrlM+6wDDDb5SMZB4JiydMRlBXZdKTE6iHpzhH6/MWZe5VDT/RQXMzAuCEjh+M2xo0BqWI2o8njN8kTLOmv3LzxmvsqrVWahHA3bM9YujwvJ7ah2XfIJc+qK5vhTOCWOTrI06hm5vNSRgQmfHFv22jsyVGM9vnuzwrDpCIxb7l4J0mb399Fa+s4rfS+tp8oMM5C/15RfSeN08V/wUh0fCNboXxorFCS4ERfsnmxp4hF7SILY+G7L926sHzDohLrAtwJBnLBSQ5rvhq4YEuroXNEu9VDVzhKWTfwVYZ6n/S2E9Kr5LOFK01amdTz3A52lEnggscLdhShS4ZfQoe6l5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ3hDIhJ8hoQw7iIOCiM+9G/P4+gV0JwlvR8TogKSOI=;
 b=mUot0Gpsf8O4fou8eORaXCvhLYKc9n/QLWR6hece3W+y/GbOV66bwm0tW+kxY3cZEitrlMv61c+I1Q8GEbSZ4EVqu0nmFe55s/lS7DUWnyIEwQBazGgqbxmidSsBbKp5jeLsQZmfXv6qDbOJSQmXVwCDGKPqTqjTraNCQk+dPUN1kj5tDA9KSOU+QJXKhakrezWrbQdEb2W0fapdFv0PoRDQ/Ew6qctqXx4FuHMGiYdQi82UGbwTakkseiGfDZmkPvFy3Cy51pBMRiZT5fPTAUoa9utQQy3hb/lmSUcrX5IqByJjVo7UMLdW5ot5t+OOdZpbJ6KOzi24JxXD7JCP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ3hDIhJ8hoQw7iIOCiM+9G/P4+gV0JwlvR8TogKSOI=;
 b=KEEvQxqoNPTleX+iTVVBnGEvAVd0sC9s4HG9gQccSvZYsHXi7Z+xcS4ci7tls51HWyvw3JPIJkBgYnWr5nApTsvRuO+xM7+pmFUDYlAe0OM9jCaLHBr2NzNs215aWp0XYnVbOoSSHGbSIeI3qu73rxJ4NuAw+VZOntvtLIe3r7mP8Xvc4Ce2bpikyP9pIF2gVLGryz1TJ34P8R71gFlmuzOD63U6b7hrcTY6Y49NPHX/15SyfGpAPJRyTZ5K0T6VQcJ7OQvY480pgD7wXE0vPrNmQGyZQDzLzFjFhXBDvqr5Chne0XH9MZURbzlxIX4K5unYcOOzJfoNJtZsDNLgrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:37:00 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:37:00 +0000
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
Subject: [PATCH 09/16] hwtracing: hisi_ptt: Use sysfs_emit() for cpumask show
Date: Thu, 28 May 2026 14:36:16 -0400
Message-ID: <20260528183625.870813-10-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0046.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::8) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 381adb7a-5d15-4be0-a5ee-08debce81b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	T+RLQ3y81J4tJH0LC0W1xg4r1thAralxfdkMTwrbUGvlRvpCWF26QHmDwtrDdvDuoOxajxqZ0h2FU6YClSNI7kecIOyB48sTURIPfv5C4Wnn942FsLXq79hS0VDL4RKUKYiRQO075SmwlyI4451LWtB1pZIM1IM+SJLXaZ83LGKEtqXHoASH+3fQDTO6F5GC75yMB62YZJx57IOMjESgfeBoRe6IBYWfv1nwRFQdr5G80dhIGQtXcmgSssZbqWuxBh/eEG6TOks25q6XFo5hyG6LdREdy8tNtzzXcOgLNlQKXnNF6QciicE78xt+UeGuOQWVjpotpzd3gv9KUj5GQH8TO3E3T6gZJGKYuxp0jLdveaSJnxIG716+lsmVOt06+L/qeZKO7IPofSUgkXnfobKfcvr4saFxn/gqtI7lwjcGu4SUbiMDpf8RcmOiF1W/qvNt5yGmK+gFENfMWCS5CXkZ6nDOZdD9ZK3MQl5koBQMvyomfJFD/n9Bas5++wHwgc+7sIAvJ/ZRWV2xl3eyUoMFwOOfjuHpQC1KBOxN1DSH2PM8+/NGbakGZGx7t7ioZuuQsHJ1G5SRm2gTKDF2N7TwhZGRL0TqQLLBAZmkVHFlaqk0YDhivGXyj2akh3LzwELXoqFwq+4ob4qr9ufqH8prvSF5jhpqYdVPnKIzC7+Uqg9SHbQUfMYRyGy6yQ1P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rcS4XlISiYxy358ly3KWm09BYrGLiUWs1TDTrUPkxsB9n2HrOQDL+jq5YlZG?=
 =?us-ascii?Q?EsHTZIN4SAw/EEdItpiHadNWciYC9uOytk5lKI1sugxwZmFCzbqRFeHDUoAZ?=
 =?us-ascii?Q?paXNqnQxhD0/JpMQuGNZwsDuyGWynFJ37ue6oe5ke6dBW8F3uaFFsQGUmRYH?=
 =?us-ascii?Q?vSpR95QamAtuxL8IfRNRErzgTRo+1sklH/rU4CpI+0wjRLL+UtKII33NZDNh?=
 =?us-ascii?Q?NrVDcdbgoBcqJTFgVAbeu9XrPzafd3BQUbckTEtt2Hq9lk9bN5jPX+ZmMDo8?=
 =?us-ascii?Q?xOtE8BYl0ebG0iaehcC/Ci5naqpYknAb9C9zv8gJr9M5hVfie0Q/BqHs/+QS?=
 =?us-ascii?Q?eCpRNpCgYW75sfvaPkC85Ai1tZNuul+QSbzgaSpKE/Xp/OG9YCBY79QSywJ1?=
 =?us-ascii?Q?c3XGAW7pWuqQs2rPxEC73CitZQrM4LpLAOBMavvqUbBEJw/nRHHc/9gFQSOq?=
 =?us-ascii?Q?iM9yR0BN80bEyaZwb6aqAICoV0THWBCPPX/0b6n/4uFuOjj7wSeNZ7T5QkOF?=
 =?us-ascii?Q?05o2D2k5tMU5rHL3upBW9y9SeSkDi5RGT397ltXjNCxzhfBhAZyIFUyyPb8l?=
 =?us-ascii?Q?eHc2aLIxs+qiMvz8bLlsIOcx0I5yUuj4/sRLe4jJzp7NPOrSt+MznbXOZ3cd?=
 =?us-ascii?Q?ymPa60M+qBz7IaM2eWFwbIMEo7ECMnP2ZG4mn+O/dRFnLZ3aax7Iom7HFPpT?=
 =?us-ascii?Q?TaDFL2XLKsRkguaFkaC6wN/iwwZQvHVkL1C+WVOLNn+u0qRVu3JmQK4xJUCs?=
 =?us-ascii?Q?JTDqIPvncdQglMXeQ8iOy/Ap+chGmEQihGx7cryAYpJIBlAxz2Wlqg7CwQaa?=
 =?us-ascii?Q?ik6/XPt1ogNJCqOK9sMXX0I2qwj3GdsEhHusIim/qrROljTEvXKBpATTOB4F?=
 =?us-ascii?Q?0bP8RcGzxAaXR5/LD+8xmx9QLroGIkMhiAT++pDmLYSNNpfVNP9ceE3qXKaH?=
 =?us-ascii?Q?yaQgXNqGaK6zGnEfbxaf0zk0tRAl9ZavoezfNx3Gr3yap9bJyT2eHSaZ0fn0?=
 =?us-ascii?Q?vJFAEBzF7hSMRupqO+AJVFAiEwemFCCUEUA/biwWe7Sh92pDyuwj4jv/cVpJ?=
 =?us-ascii?Q?r0n6nWB2WBGn53M6nbjtpoXLiWhUNKs59+MfH1nnS5J9snguM8hP6HvfHw/B?=
 =?us-ascii?Q?W4k5BkU0yGLRpsKz0/BhWjF74VrigIv5tDU7BFs7bJN+ItxdlnCQwfiqzMn2?=
 =?us-ascii?Q?0zBFb2f0W4fcJKyVRXxsJ1Wd9d2OviDwI0WIPWqCpeLmzMeu++BBTIvmxhs4?=
 =?us-ascii?Q?6tcMn0/o7ZmYSZSHtzNhzpfbxUTuMyaqmIquy4QDWQ9nasaKMjetGEl/ALxk?=
 =?us-ascii?Q?Bk6l9ee5hTbcIw1EDMKJiD7z5uu/u/2uVWrrdseyzlpQm0gd1jCjDJCBWbzO?=
 =?us-ascii?Q?n7+f7+6tDvhr6Kym1hiqw0frV6o8brNT3prQUp1maMnErpe1gRQN0C9zFK5b?=
 =?us-ascii?Q?CYMZ/Iu6uNhQJ/RGdM+ec4/lK/jMMfLnAv7W6e9Lz/JHZjsRMF+QbQjfvgMH?=
 =?us-ascii?Q?CevaPzHEG7RQcbcBA8NLk1teBf58fl4QwUJKG2JPQTDFGR+E0JovyewyxDnd?=
 =?us-ascii?Q?L1U8qmPX/m+XmLg1g0dLka+AD0cuKPjI3wd32bwUB3VcelO0FXUMcTbeAEv4?=
 =?us-ascii?Q?fJkcoBp88ciGluU7R4S4gn3rWu7e14+BZrDhBgPipDvp1RoGwETphIT6uD4f?=
 =?us-ascii?Q?PWc0ERuVeSrPQ0GZ1gmzhWOifYlY55x3RPMQg2j3WwSwPVlKzJOOXBx8q0hk?=
 =?us-ascii?Q?+posDr+XjdjuXDJ27wDwmVO3BZ+/pNRvYVL8HbyIkfNOOi80D+K0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381adb7a-5d15-4be0-a5ee-08debce81b13
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:00.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjqYAESgIPDooObp1I4U+RAPhtRrR9M09cLrKq6nks2DRjYv/TDIt3nY2TR8+jQuBJnUFs+T2hgcDwUjeFDSvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21446-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 093375F6934
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cpumask_show() is a sysfs show callback. Use sysfs_emit() and
cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 94c371c49135..233c4c32513c 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -780,7 +780,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
 	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
 	const cpumask_t *cpumask = cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
 }
 static DEVICE_ATTR_RO(cpumask);
 
-- 
2.51.0


