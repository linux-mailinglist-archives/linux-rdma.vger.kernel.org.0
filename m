Return-Path: <linux-rdma+bounces-21444-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jz9NIWMGGrCkwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21444-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:42:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 520615F68E0
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F073311AE7B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0DE428473;
	Thu, 28 May 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rfD439K5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755D425CF7;
	Thu, 28 May 2026 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993422; cv=fail; b=Tc/LRYn6IwtshsT1jAb5rV8zA4mcoNhAU/Z0amH0OcjJwwwQtbFpwMqxPbF0DcJFm2a5ewhrSqp9j8MbZxAJ7G1c0tzD7dB1rtrv9R4roIsiCks4WWE09T8HWP+067l0qFuFqIWApJI/hjPhVQ9ZWgJHmTfmsEhwDs48WZCQkAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993422; c=relaxed/simple;
	bh=PazfyIQPH/A0Jv1QZbjw12Vu+X/SKHr2UXWnHInaX7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WKvrfNJa0Rys9tKJdMuao6VkDccE6dn6bG7ewoL1tti9WZeapgJtIPjt9ATrma20SQTuqMHatJQdAUNhtWuNFfNu1iTCQfEXs2TCMvLMicR8aVe5dsNJg9DS3KCOVSGC9XzECAMt+4Ba7/XtBE05wiqrKy+n+fNFI4NWsXlw0dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rfD439K5; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUxmGt/EXlewu+mcNoAaCTSeKn26fNaDPWTcuistAX4qoJxIL0uB2rt+WSwTYNccYywUeeP8HRPhJxlWYIw/6w4hXeA3XLOARd7TzBSSCUTrOmFZbr1S8lsHjkOmj4aomoNhLdH6x1H8G0HuRz6Bf8hE0k2ouRljDsQybynEFMklYBknn1Hp6IAA/pKUx1/BZg0s39UBMtXzwphVauTdjIXzOL75FytcBD037MVCliUtELd9d0ipceksgVZQpTfBtiI0eh4mDhIyNq+nIniLODDLqV6PRz6fpSEV720yk44gZomOgP1LU5KIkgUMPmZTs4H+G+KC5TTXrEBStNZWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A4QuTVZbTaHIhqOXP0/TP//2LEKtt9iowZYNB4FEHM=;
 b=HAjJfxm0BVRCEB2HKfmYxh4h103BSQL6scQ3oCpCUwDtnK90MtuTdZRZOrUTrgsateBJda1SYhD1PBkFOPhvpG4qF+tj3bGTa/wQeim0z21XNB9h2ZYaH44ZedZRCHVGwGdgkz7ILSXRLm6PhgELiwpvqIgDLPSDWmUgm7z/zb3QRtJLm8GFETWXv8ddW4ZVhiCmGqQ5fB834JXU7l+yXW/yg3DnPDYvke70YK258Ufp3bmGg++M52QiVHX9cNAUk0uUURH47IHjZBs1KBqiBr3X1XawKBmShDAJkQ7Lxw+4e+/TrsuUW0sWHcCEhaaau+cs2COFL0h+xPD8iXF2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A4QuTVZbTaHIhqOXP0/TP//2LEKtt9iowZYNB4FEHM=;
 b=rfD439K5ByW29CF5R5TvRLYL5XoCAwMk+D6//13J4FD38nXPYa9xTxTUqkFHv/BlDTT/8w0WA6/nSUk6UpLGPShpCf/KFxAOvwXpRBScIyJwNSh7jzAxeLMO/V3YlehWHf9IHk75lfDPm2c5oH9gwraC/Q0GNvJTghJHuHmXk60dAuRer8nUHw/NUIiyN5QY4xUQ3eTGhNpkW4p2POGaN1FPyStD/sLrATTwYunIPj8ZE+UYrzE6NRGX7DMn0L6GTWU0WEsnoYSrbnEph/e9JmsdmyMCZAz81fGUfd6XLIjmgkv5mdY4KX8Ouj+4ffT/YUzLpMDMPGMGt1xBOfrCcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:36:53 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:36:53 +0000
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
Subject: [PATCH 07/16] devfreq: Use sysfs_emit() for cpumask show callbacks
Date: Thu, 28 May 2026 14:36:14 -0400
Message-ID: <20260528183625.870813-8-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0040.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::16) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8e7110-019a-4463-6e0f-08debce816a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	1aDjbQ0hD7xYcvJOoZKKrnhH2SXyf0rX9XZ31R6kcAnqfIAa+w0XgGkAodPaafgvPFMF/eryEB8071f07G/u+CttjTM85PZoSoY5cfES8cW4NwUyD2hQCGQ4Yut9B5EaaSAFb8PS4Wat8bTGvKY2Kd4P8eK3LOAAq91qwAGwv8nA7pA0QHNTVf7GEw3js2F+kk+8Y4P9ccBYVwu5cRRLHAXwiJkcaoNpcl/DaL8z4mPYX1O6CTgTYBLmoB+3Bz+m+DREw0sTWO93F8iQgq+uT9198oMNHlCcyfVYeooU8RcZRBWCSVcSTPXPTlT5SqMCIuO5EJcTe3Msn/2hkCcEbpZwx7TXcAmRA8I8gkit62wTyj+Utv0Jv8onyyMFRm9MibeKPHSkR8bW2WaiFAo6HrJoQ+LyeqKls1mLYeXKXt1x8pPQFVbYYH3hzTZAJNAyJRhAHIQIFMt1Rrxk3MJpAhPukM6o3kaEACaR9bH6Oi3yIb/TgkOjg64fyRImYayj34eFRswjVPRYgpdX7dkxY39/muNZRq/jElEQVuILJnX6x68F0zD1bkdgPli/Ar6q2Hb1GWCMVmor0jyb73jCmEIffd/izZA2JSwc16fmMdPKq/xmZfGJerF3m8Sh107eDmhvEXu/q+Z2SBYb8wz+p8/+m7mXQGro9b8CsGtuclz0b3CRvJySn7JKWa9c7Np3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?98Wf+8Jw5+2NBJGvwzIJ664aubNfMvVPmzS+zDxCxjdclo+NLGQoNzjZqCXy?=
 =?us-ascii?Q?sdEFBEHCUpu4wITZEmB6PFriyoJHR+zm4vt+O/ISRU+8rz/BIQaYoSsuYyLy?=
 =?us-ascii?Q?BXQYSKYwVunSVf0JEOL/imw6U/fk74488hxpp86ITVoLYYj9+KiiexpbgibV?=
 =?us-ascii?Q?OTlPdOjbSszZh3Z3xBob2wX70U9+cET/sL6A9jBmRJSn8jzdRy0POzuIDs+f?=
 =?us-ascii?Q?CON+7Kz3W1L1aLA5+R+j2aefd2poDOdH1LyASOJs/3Pe5HkeJbnYozLmegu+?=
 =?us-ascii?Q?/OciQqpX7lNWE5a/oGMHfeBnB6K15RKz1L60caVG3yvEDVBDiY2FLpsKbfIy?=
 =?us-ascii?Q?girawdxcNBTItqUagRFnOmhrwlDGLXmmUU4/zXTts72eWYmeBKVp6Gp0ZgUr?=
 =?us-ascii?Q?YVKskjJ+t5gkGqT6gXPlXK3kbo6lv0I6+k4SYCi0BAul7i+q1UJYgg2484m5?=
 =?us-ascii?Q?esK+NWNvPvKqQpKemqoSUXCbkRpM1s+SKpnKirX0AGeCoa71iOOhdJYCldlT?=
 =?us-ascii?Q?AdaqP6sSFWGuBnvmHgaTpix53LnNmwUP50yGZJFowS0/pOxKzVmZkgdIgDwM?=
 =?us-ascii?Q?ZEh498DSR1DrRkLNN9ZCxc1FdyOxi+uPoZakjpqIiK4rvW5DmrKy9/eX0i+w?=
 =?us-ascii?Q?qSKvQqzdPnz9b16bME7Q3VJ+8NVfHQPWkvzQ8WNoYikt6gQCZeol5Ex46oLk?=
 =?us-ascii?Q?UtCUctZQv8RtAk7cUfGKAxCtIt4i/Maoq/oORVgGdgRRZzVqg/ipasGmz+PK?=
 =?us-ascii?Q?D5p2um55xWgJ9GFjxV0v6QRzMdrrI9hYbOTvf3WkRKrwntK5P1KB1Cb9KlBW?=
 =?us-ascii?Q?+ItAf8EJLMSAf8OcXn37hqCc7IoWh6e8dH6Hlma+kr2gAAbLOwyXSGQKXK20?=
 =?us-ascii?Q?YIP//DLuSm5/ecSAFBw36rBiedFYWrUvHANizYqlR6yqt1e8Hh0GkvzFxPvt?=
 =?us-ascii?Q?KE4lXqKKc0/LJ6tsmB2LWwSpYFHl57VsEixBgguwdoe0nElpM8gkIcPBZ9TV?=
 =?us-ascii?Q?C6y2/3TcRN6zZyzLd6yZFmPuOBqrA6rzcngbEITOSWnQMQ1KJhJSfV6KiN9z?=
 =?us-ascii?Q?TO4cHWsNY6LhG32as3Hs8yIKSUfHnW6A3IMjht7xzWuTReIIdrxJNbYBK/1z?=
 =?us-ascii?Q?Dl7s0q3X+OdZ1K6iJ3KQ5mfuza5svEoZok/emyjeE7PfGVBAYCKTM2pOxPZp?=
 =?us-ascii?Q?B0X6AZsRh+vr9Yg+lgdvUUzuFkp/UUdWcSQur/D1koZhMdEuCWG56JW1oEal?=
 =?us-ascii?Q?lNkgeoO1s5OVNvGEhTlG8OMI95koHiMpNU2p+S29SJ1oaRmNTJzmE2vEIml7?=
 =?us-ascii?Q?vPUIl8+XRsVmSu86BlZ4Xgi54u/jdvHgx+eBEXWWcfKmf7KUQ1Vdf++D0yOR?=
 =?us-ascii?Q?ftnGE7W1GBwolXamwGAxgI9ovtQhJxoj/88RvH7YFc/1mGkCOgqGVA3aJq/U?=
 =?us-ascii?Q?sSJ7N2QPeUsBWrvSJ4tbQqnrFXNjGTD3Ppb55MV8WmTuIufkcKW5ZVm54O8Z?=
 =?us-ascii?Q?0XbRPwBevLe6VohpXwwwHJ3zbGa0n18p4Gv01K/vRj1wBy17KKt/vRbwJcJ7?=
 =?us-ascii?Q?S2b1yd6TOmeDLJhvmHa9KmaVtD7Z/oT3aJtP/8zLYv4Ke2DYWi1xC0HZsobm?=
 =?us-ascii?Q?m+ngnJ/o3a3kwo1x+CmllrIuBYeFJqn/OtC/nAG/okaosBl0JhI7vREpTvu3?=
 =?us-ascii?Q?yVCIxUlQ23vCPg6FMx0DcwfmdjL/NHVah2Z44UbD2q0Z8q2qoiW9eqYro/M7?=
 =?us-ascii?Q?eT/Oif8d0begEeQlD9OrEKXqqS8JdHbvJ55AgdA36fzlOwmzbBdJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8e7110-019a-4463-6e0f-08debce816a8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:36:53.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8PziAEnThAGay94+rGLZz7FzthLJcdtNqGGui9kwRvHaYtak+iStqjbaa/hXmGwwlx6iLfmnckTvA+cjMmizg==
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
	TAGGED_FROM(0.00)[bounces-21444-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 520615F68E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These callbacks are sysfs show paths. Use sysfs_emit() and
cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 drivers/devfreq/hisi_uncore_freq.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 5e6e7e900bda..255aee1bdd91 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -354,7 +354,7 @@ static ssize_t ddr_perf_cpumask_show(struct device *dev,
 	struct pmu *pmu = dev_get_drvdata(dev);
 	struct rockchip_dfi *dfi = container_of(pmu, struct rockchip_dfi, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(dfi->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(dfi->cpu)));
 }
 
 static struct device_attribute ddr_perf_cpumask_attr =
diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
index 4d00d813c8ac..23b262d23a66 100644
--- a/drivers/devfreq/hisi_uncore_freq.c
+++ b/drivers/devfreq/hisi_uncore_freq.c
@@ -541,7 +541,7 @@ static ssize_t related_cpus_show(struct device *dev,
 {
 	struct hisi_uncore_freq *uncore = dev_get_drvdata(dev->parent);
 
-	return cpumap_print_to_pagebuf(true, buf, &uncore->related_cpus);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&uncore->related_cpus));
 }
 
 static DEVICE_ATTR_RO(related_cpus);
-- 
2.51.0


