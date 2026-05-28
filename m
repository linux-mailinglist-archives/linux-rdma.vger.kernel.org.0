Return-Path: <linux-rdma+bounces-21449-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAr+ITeNGGohlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21449-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:45:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A33D5F6A7F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CF563094B3F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C41143CED7;
	Thu, 28 May 2026 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="APfSxKsL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F041C2E1;
	Thu, 28 May 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993441; cv=fail; b=mLrd8WFQNGihSctkWmL6C6uA2IFLvIGBDnOzIVVogzFaNRsUpBQbEHnPTUZgP6GAU2p5ChelgKqvVzZR50raA26mUXymtmSXlsGoiCHKoMLPWEHXgKhj+Gsq2wJ4CKtukW1NIrX4Y8CWHHAz5q7iIwGWoiDifgL+SQcRe8iHauk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993441; c=relaxed/simple;
	bh=SjuQ3PGSniHL+Ma6H8tSXnSlCQ0a8wLH9mVXGp98yQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQRVRYWMgKQnKmOQTXK1l3PDPM86x1E5Df65gRxL58GHJ11AUrBJDEfrqEU+/wzSjyoGvsRv/wULhsUQGYpE2+UNoMfuc/NpIsNxCCRaJ0wLqj9pYwAtbjf6TFFKXtWmTaqgvRj3WxBcPjV/zzbO5XfdYyyN6hzsHSY+vfIuBH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=APfSxKsL; arc=fail smtp.client-ip=40.93.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhPgHH5XMQBmwMcvW/qPFtxhoJIScmacgPFECb7hv2ZhMi9c9XDI35shz6H3LDMnliSq2f3y16GKD1LbIlafz0n95hBZxUHohToQUusQq7EQ4sfaRYhF9FiBT12KNvRwX0hZIHN+Z5xAlEiFTEP03iU7yOMj/X0PeALNA9UleHFoh6UZyeciEjU/j7M6wavdrJ2V5UxuARbs5Zqs282VG+O69VpFcWxEke4ZI3XrwakIBqzqEMGavw7xaK1jmDkUHnRIvyMvR73dBMhEarojfq0RFw2CKO4P25InDWpWmzWqB+54pi2y3aELQlOGJGQT1KL1pY1pv2bR06iE9mmPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqgkZNX3y6ujyiIh4d0vDuqo+KKjPvB/uo/ll1lZqjI=;
 b=EgtnpOYGL+7Sxq2jWYUtglkg1RyZYHyFlMN0D7vCKdvmx83Zhd+azr0YZ9PcL8V2eV/1hiqGAvbCy9t/cFKXhwRvm9YrlFY4G7ltp5rVRS5CYsg2a/5mZ42BcgFRjdSMYGAM4TiFHbJqNGHtxOHLZMgwPi6qz+8UAB1UENM3wb+LBaq3RDeWTDuIxXX5NfeEgH9ay9tZDNMe5SULa0rcMZsOjfYgziRq9LmDUs/j1pG9A41zPDvwemkJmazpj7yGZ8vO2zJ6nmHpDV2LamFo9OO+Q0EDqHB+eYvol9IXH1pUs7bkW/6uQCUzX/xoKxN5ru4aGIp7yKKW1glAo4D+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqgkZNX3y6ujyiIh4d0vDuqo+KKjPvB/uo/ll1lZqjI=;
 b=APfSxKsLrddtTOWnCUJMRrNkNK8A86irsJ/y9UVrNfjKyu/s29ao0Xpsgaf0czdGIN5HVChLjfHH3RuACpsO5Z+fpusjF+2CiN/cC1ZBz1va43pNn//ufw1r+hrcUzfQHML2aNCkUMBNruYhMiGTBypwubfoQ4azentXrZOBSxPXoKs6NsPDvW9mk+w5murAgJPPJkGUoj0J6f4NO1h6548NWOjq+fX78epsYuyFOyCem7gA/bIAOxXuBRMX08F4XIivnIw4I296ODk6kZSc27YPiZeGw31iQPm/Ppu+N688E8xaYNaZ5in6qlmTFAr6F9TCxYTXidLLZyF7DETgmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ5PPF01781787B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::986) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 18:37:11 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:37:11 +0000
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
Subject: [PATCH 12/16] PCI/sysfs: Use sysfs_emit() for cpumask show callbacks
Date: Thu, 28 May 2026 14:36:19 -0400
Message-ID: <20260528183625.870813-13-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: a2122b6a-9453-4e9a-2c41-08debce82139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QCt6N3mE8JdhlVJeoAPCbGfX6Re0b7F8S/ZdGanuSTc96cdM8H2Rr9TpXzIfZ/vEjliy9Jd3Hs8UOBdt8z3gph8r1vFqE2XxlgH4x6ktDrBvQS2VcJIJq3QyVQqHq9vK76mYlo9L1rqLyi8Q7ntUKVoV+/aBsTR/Z+03mwnCmHE2Txu3u9zsTkJRZED6gmwnPl3b9012/ncUZntKsfNQA08TgJFEr2bzmWeAgCnZiFHHm5NPmL4zDhSpe+dxCgRUqaTvlSyq69AapDX5au7s3QwDGCo4CPhty9DzZBszZChkoKGNRaft3UQN8kT54N5zb45KIVWUp3TDRO6T/DZBDqmF3315f1TeD5d1wIoKf5ycs08fufrthvPUqJuviidltOOoHWd7LdYvp7xi5HFQtuHW6fZG4e/lilhPEI1C1NlAMuhvc8cfe3vV28O0fhV9nQyyboVqZBSCzuxF2ILWDSIKJbL9VYi1yWkg4K+ILGH2uymA3/V/KHn0s01cnhzeKdXC/tPEQdlSaRQeYMhkw5+naRDmTw5Io1Xd5GmQ0IWD/PQAUMLIV7FONNutroFar5sEEpOTOqjzwVIqB7fqMIiOsIUkbtel4jV7CLJmNPH6XuhswnxroVncaQ1Jst7uMFcBpIPkTrr3+YhMOCmbf+xc7Sd/D59gbFtqKG/5lCR6yVcYY50Ms79ytSFNgCZY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?47D7bvAeYg/xaFNyVqVbfB7F0+2/OFzg4oJtOkUrubKVL9MR7YIXSHXK2Uv4?=
 =?us-ascii?Q?lW6sWSUMV4M96E7xM2LFJCco1Lmq3CfSEcZA/qVq8FpDFRuffV8eM1uJciQk?=
 =?us-ascii?Q?jW0bRb+kRpeqDPGduG5cqwYtJDqB0e0lFRT10lAF4OuaKZPR2NOWd/3o7lap?=
 =?us-ascii?Q?vlKNOdBYfEXG7lJ6PzMRTv2QQKJCUe4nmG78iEIjRH/UVqvV8HaZtkCRt1wU?=
 =?us-ascii?Q?Nnc3t+VQ6vBEeOdyH3vgffChrgibWkU5bsBVyGYL/hNET6PBneD5yc47sc86?=
 =?us-ascii?Q?011DgQXyW4mwfl0aGyv5xIwiepDVSpOJVSC+dgnPs8IN72gC6zkQ8VuwQ6UA?=
 =?us-ascii?Q?M6+Eq6Ugl3CdUNv+nGG65ug6c9Rhv0sN/M/oCmtou9fCwiacpZSBeBH77PsU?=
 =?us-ascii?Q?xS3LlWF2M5FqXdL9/JVAUvyyDZSkJMRzhK+dp9fwWNXjbrI6MUZAFKXQRp4u?=
 =?us-ascii?Q?tm6jVenu7XgLPIRZfkLHmI/VrKcFZMJh8AbOsRU0Xk4YqARq1fYW7ZnLReNI?=
 =?us-ascii?Q?r07rd/Mp5OXbVGjm1vkYDW+SGqhcVEirenMr8h0WzygNFgXKLp1z7jrObGpF?=
 =?us-ascii?Q?DeUbsD6nR66E5fUpbmqIKwn1XvM60tACUD1kkuQdaYThtvv3K6X5r5B4H4yC?=
 =?us-ascii?Q?6ggTX/hV7YuEHMcbR+tqTKAehhTFJxlJVqhojnZkbGooFArqyDlJL2tgkOZV?=
 =?us-ascii?Q?l0SltkVj606QM/rgo/jUQl90b856iDtxxRBLya5ElRg2URYl/t6ZXiDeg9pq?=
 =?us-ascii?Q?5VkgVr4Pxh1z1tWpIKxN0kjumR0AYHB1GADmufLrPjGkMvPQkBsN2RgTizF2?=
 =?us-ascii?Q?puMj7qcdDJkr2iz0+ec9u7jgNJDrWkio1uIXYiGpdYKgfbbZPgxrK2+FVP3a?=
 =?us-ascii?Q?4hRZOVEherAbS0gD+9WsNSsgK6nBknBvDSShnyvYZjLTo4yZqmWZfJlibjcS?=
 =?us-ascii?Q?pOXCzVwLTKquZyzm7coMg2K2FJFbecLJ2OSyNCNyD+4+jSKEOXbDPo0aWXJH?=
 =?us-ascii?Q?WtjiomVosY8m7Z995ntDD+3R6lP5DqwBjrT/hvSp3SqhaAWfV5pJD/ut7STJ?=
 =?us-ascii?Q?M77uYZIRPQg9HjJr4SfTOinuLzsO4Yr5Tcj/nxuANAnyI7yY7lAo1wRYD0zG?=
 =?us-ascii?Q?GwSL/btbZEcbNbWLe9lZy9KYRExj+EMCIXLVl+0uaJLw9B8M4O9CJ+BjXE/V?=
 =?us-ascii?Q?GnQOWFkf+Ww54mnNIqkO6p34jIT/6hFvkM9bdjFolUfLJ2glEOdAOOcviBoT?=
 =?us-ascii?Q?8c7/k5mrmdY75JYhwR+RQjBGTJXGsWnGV/aULe/YYqULGvBdrkbKdeJd/NPW?=
 =?us-ascii?Q?tySizSauTY9cXXDs0TBwdbdbgbhsXPjNKuDO6hUEwuML5UNGldYdqZKv1Ibe?=
 =?us-ascii?Q?MLwtGntRNMBPyPDLwtfl2vYUQZPZ0pwDMwOzA2asoMJ4On0RQ1fTCBA0llkR?=
 =?us-ascii?Q?nS7VaKQpQscRPjtkgiKROL46e1rF9wVhMqODYZMYGrQ3fcYfN3Y+E2CJ1eXk?=
 =?us-ascii?Q?DkyGZX3SPDnagIDY476H7JLTJ97A+3tlNt9hqGKk5IrpdWIyeIOsz7sju55/?=
 =?us-ascii?Q?1L2HLM+9YxIBwXKJ/NAjOrqWjy7NQKYQSeoGIiMQ4yeaThfRI7hgGXqaqOEN?=
 =?us-ascii?Q?su6Z1mdyeiZQybIbLLtIBjf8iWdGlBGNRpzlTkSBk2Ws6IbZPkKwYVM1kpCT?=
 =?us-ascii?Q?nIW81wyicQ8jqAu8OMtJAKSt0tc2aZJ8BryaVdNaXMoHIhKeaHrYARYMede+?=
 =?us-ascii?Q?Q3swqINEjf3kX9JqiWJHPb6XFCosnD0Jii5ZswLjahdprLWawGBu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2122b6a-9453-4e9a-2c41-08debce82139
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:11.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qG0oPmzdwwQHQLFUv+j9k5Csl+I02b3oZZzOc4fiy0RSEEizwktF2Dp4/PIzSHtSucrdyEd+gB/kuafZZSTaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21449-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8A33D5F6A7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These callbacks are sysfs show paths.

Use sysfs_emit() and cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/pci/pci-sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..319c1d1459ac 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -114,7 +114,8 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
 #else
 	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
 #endif
-	return cpumap_print_to_pagebuf(list, buf, mask);
+	return sysfs_emit(buf, list ? "%*pbl\n" : "%*pb\n",
+			  cpumask_pr_args(mask));
 }
 
 static ssize_t local_cpus_show(struct device *dev,
@@ -139,7 +140,7 @@ static ssize_t cpuaffinity_show(struct device *dev,
 {
 	const struct cpumask *cpumask = cpumask_of_pcibus(to_pci_bus(dev));
 
-	return cpumap_print_to_pagebuf(false, buf, cpumask);
+	return sysfs_emit(buf, "%*pb\n", cpumask_pr_args(cpumask));
 }
 static DEVICE_ATTR_RO(cpuaffinity);
 
@@ -148,7 +149,7 @@ static ssize_t cpulistaffinity_show(struct device *dev,
 {
 	const struct cpumask *cpumask = cpumask_of_pcibus(to_pci_bus(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
 }
 static DEVICE_ATTR_RO(cpulistaffinity);
 
-- 
2.51.0

