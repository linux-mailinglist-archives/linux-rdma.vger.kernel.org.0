Return-Path: <linux-rdma+bounces-7494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929F5A2B704
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5212F16793F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A3A27450;
	Fri,  7 Feb 2025 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uVDMm3re"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F981E;
	Fri,  7 Feb 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887230; cv=fail; b=fi2vHNC6OEFczO3zmdqPME8L/kaVVEXcT/Y0DDYb6WnIgUWBu3500FerPIcEc9/G0KGhUb+xVX3UF7GtRw4LtVmergBgiomSTkak0g+QMXd9Cx8zgRRkZ4qm8E1KYhlGWNvOA3VYyJI0c4zrApFYwDgvgO+tB2Vy1PQf7xWt+EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887230; c=relaxed/simple;
	bh=McUWt/GgDfZGnllgv1yiOpWZQCd6tsX6rGc115aVd0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0Qj2HqJmumVKnWv6eAz1sn8bYuwgA0HJHulmZKeD0aXX9r3WtCuXuOCGAmfPnaddQQOQ4udD/lUoMlYMokz4jpMbn1bADRl9UYTkPZr2TVGGywXXbR+erhrPYpLn5gb/LYWi/Cw/2VF8/jJercAapwZA+Nr62SJtQfaSfFZjig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uVDMm3re; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNO1+oY+YfJsk76R4QgE1s78BCBDNW70G8PPALVEWHm6EtktXhXyCnpH+6tqQN1WJVtpIqjlbl5qyCji5vgrdxPNQP0r/uuTxKPSMi2CcDbl1AisnDGn7m9GYXyA34kNsfbgeXecPTmJ/f9BMnUy1T82vGbNSf57jWM9URaK74qauTsqLYWSpz70ukTAtK2+fyN2K+PT31verQ9o2g0maUer1ySd24a12UIJYUqqCBGZvKavg9UG8diuFFQGgtQIUx35t21dj1XJ9vkO6j0mBh1bZozEjguOtxlrzuptIf+lMEt5i7bHW3PdKDPUGeyuUUxGxgINAljA5JT0X2F66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDJfe+5IYpBBw0evCEcyO5+PggQl2LDL8zWDe8ALqQk=;
 b=cQRxbLWdylzDj/oidFiCIlNITgNOl5Rx4Ty+cmyHTjLjaU40ydiyIbXJ7bh3HkUOOMq3AEnXEFjJA9eW3HLqp66opX9PC1nfn0N1j0Jp0vQHqygJTPo6b8aaSLML8iAkZuT+Ue3nHtBC8iXazMcPxXoPLJwmIYU7OTAjjoylL9B1rLtMYOV5lbRf+OQtQ2EoRP4t5iKpZh7pecFyw/6zvRSUGYk09xltlx7yAIe6Odwj0R7SpWN/Y9sdtUmiDKbZZStctoGQyYoG0cR/FX6DWZUBm0nG9SHuQrs133gOeAW4M/u6p4i4+CK8n9IB549LXloxl22EA+JkWs0lZ68Vtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDJfe+5IYpBBw0evCEcyO5+PggQl2LDL8zWDe8ALqQk=;
 b=uVDMm3reQ1OSngsA12eGZnGEQWutPLi9yIgeIbb8AHpm99rItmiLwhooCxfR9JoZninbJ7myNd8gLex3J09sZ5Ir3vtu1I9YsEVI+GF8/EviKsz5EPOWrarH/OEtho4MyBVR1EZpHzgO6AzsyxxJW2m15swMfqSzZs+p9MIE4VtVm2hkdoWxjMTc+31yyIcF3Vx556AjqS1ShyTCmuhcQAjZR6QgZdthVETTU+7vUDjVLXTWyA1tRFqdC2pbxF84U1hKE/B5RoT6x98JqLmPbrLeGN+0JUM+sEFLw8XWwk1SuQ80XUAgVNaElRCBbQ6XOhgoxPOEkXuxqEeai+50rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:36 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v4 03/10] fwctl: FWCTL_INFO to return basic information about the device
Date: Thu,  6 Feb 2025 20:13:25 -0400
Message-ID: <3-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1a6e75-9ec3-4971-e6fe-08dd470c430e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0RBNppb7dh1ECcOYTdlWf1Ed0r72PU6VO1deXMkOFqn3ff2JyhFk1eO07PGR?=
 =?us-ascii?Q?PiY4BkKjnaJ3SWj/TVa1MXRFLM0gCE3sjOdrTPiMAColS0c9WFWBGH2Su8Yn?=
 =?us-ascii?Q?KchRtvwntdJ1L7kp4imJbPVffkJvwqVf4XNCV0Xpco0uVL7UcAWm2wfQmoMB?=
 =?us-ascii?Q?jneyKg3SbRr37pkgmPuQT9dwjzJvVa2Wd7eh7V0LmADCP9g2LzDif/Z8WlfF?=
 =?us-ascii?Q?Fv8PVFYKr3l3ENI1QN3nkLtvgX407v8saNntqV0++5MCQhfMajfhU9QceBel?=
 =?us-ascii?Q?KKx1+S0WKSdEH1L2ULFpLV60jPudFssqj7YroqLRbwEM4mPch47ndRsAi2Um?=
 =?us-ascii?Q?x0d9AI6GMnR+1phERcUAKptNr7V0l6D/C21QLdtt+soRhqblgTUgXFkSH5Qg?=
 =?us-ascii?Q?KBbaJcfhc5gAmBZ+hKmFH9KyNx3gfzz6twmM/LyQFDJGxbQAY1avI+ZUZAeV?=
 =?us-ascii?Q?1Gdh5jXrqQAvP0iyda9gxdF7mw5yb6q9aXwCOJkM5NkCIA0nt61nmJIY+JvC?=
 =?us-ascii?Q?/QZYZaLXOkBYSoFsBZIm+u6qiHNyQlvkUJmWAkXNVTUmyepPAa38Ltsi/z6K?=
 =?us-ascii?Q?NfkxT9BcJJHttIeSLxSzoQbzmPBTuhjxnmKk7ZA/KFjy2dz2FbEl3uSqMMYH?=
 =?us-ascii?Q?rGKSoFzXtfyNeM22LJ1RQW1gUNj+oTMi/tPPMxXsH4bFX1x9OxP1yWjTvElx?=
 =?us-ascii?Q?QiO0pCYZTlwcDknyBsk/lE3WQ1Bj5ECBsgd7XMG+Z19Sy5DzPaAyuK5bfHJ3?=
 =?us-ascii?Q?N2ezRIYsclWxcmj7MTep8EHNeiTk8CZvOg7Tc2xX8pLcyrk4JEL+LSTCzwTR?=
 =?us-ascii?Q?hBjiNvDH7rtvcIMC7+UlETXiHtSaU6XSjWJ47icderj0/HA4TTF04oyy+R5w?=
 =?us-ascii?Q?xtNy/BqKxMaNqLzuWDmYTHrrN6w9JqMRFT3H0nH8GC9IdmHwsN3Ij395TRdD?=
 =?us-ascii?Q?jU0N35g2btTVkC8N8ky8POYBH4qsx2K6hFZZPsvVaxXt7NMuzxFjpv/qiXqO?=
 =?us-ascii?Q?11FraeMSr8wMClFDFBB7hqHiqlf6yiHWI65gQ0jxfthCZac4NY44EE7Hmnb+?=
 =?us-ascii?Q?/D/Rpw2H+LDD1PnRgFsz71/ERo8TT07VVS4TLXa+p7e/WRaoZ8vSvBJXjDcB?=
 =?us-ascii?Q?BucXwQPy4QAY1fuBCO4blp52132KjwdEFdYWBEe6KbGn3w7NENhQ5B3tXQun?=
 =?us-ascii?Q?zM67lM2TUnieuy8Fs7Yk+wu1xLc+553viYHOxD9KGUFDvphvGcWcaCWqxtKk?=
 =?us-ascii?Q?joSwGVqitv42YSMK6hMNdM6SXtxU2ZDvqwEHBNUzAff0AmhiYil1rS/8ALGN?=
 =?us-ascii?Q?p7voUiFgMorQsaQw+imJxh+l3J6C92XEPiAUsy6MrQHRFRXa60q6JFUpSx9U?=
 =?us-ascii?Q?/N73R1WHsmg843iWUdVqHNaRF4Di?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5CP1wOE8QoNG2TGwBYzfnQSTJQqfwgkp8Q0xWmplY/FFZWOk463M5DT7SXZL?=
 =?us-ascii?Q?svDScFHit514WL2k9zlajQCNVuDf/0uX2QqlDfZwTL7dnbe8ESV0ZfiQVXfx?=
 =?us-ascii?Q?sqwMJY7pVTuz7pv+IUXxLI7BzCQ6hBMjN6yPL1Jlpz/G7g5BwF+bn+TngrJP?=
 =?us-ascii?Q?ZglxjIn5Cx5mb3WWFyTPa6x4TF0+sytOyMFKPY/wW2HTRcZY9HZaRkqDShFU?=
 =?us-ascii?Q?SOUjVYRlUZvFVnvXt0vB44SC9stci0jbXVc4wKwV3m6ZPMoPn729jBiN6T13?=
 =?us-ascii?Q?jZT7nuvJbfEqzvOzYvnUGwTMFSWCFE6a4FlAGdn2zBEqEEOnrBeQCDtY1ver?=
 =?us-ascii?Q?3dZsleuXTgYEEQB4h+1KF0HoucHUoUedbVrOYJlsCUsBeX2705y0T2PvXDWl?=
 =?us-ascii?Q?f1uIR2VeuHPnvQ8CU7H1w0vNGSxF/pt4JzOooP3tEDwRTcE3OTROXkQk17Fv?=
 =?us-ascii?Q?Tey4aMs4Uk0P5s4PQyVEpNaOn4fUtLejgnJVl4cdhWmLbTdI2zXjCiIQfrtR?=
 =?us-ascii?Q?dj6ALxdsoy9bWp3HdZtgPiZVXYekV+mWLIgvNicf1wDEndacCycT3uvIQKEh?=
 =?us-ascii?Q?O6azcCb/PgihPaOUSLLTXwX6XWiBOFwJafxbmRVIZudoK71haC0FAswRDs1j?=
 =?us-ascii?Q?Os+FWJG/VGNq3t8oLFlbNOIAitloXgCRI7DReKGyF+iSOwnlAC2QsQy3ZpQY?=
 =?us-ascii?Q?5RqBC8SrB2kx4UI4ilatSrg6Y1ZaExHoVKj+FbnGGUUQRppvsiNi/ysVOmsr?=
 =?us-ascii?Q?C19FGR8FSdQ7i7GDw6FymkMCOcoThfWbPr+FhHq4m8kEGfqw5cj7lp3ZPRnc?=
 =?us-ascii?Q?9qZLeS3If1pH4lcclQlBwfg++5JXDDw92Sf91apy5KI/bvt9uRjbfXovhK0I?=
 =?us-ascii?Q?RDCzXndgUOd8p+dU4RvcZEKK8pLwvLoIc92OvOsK2wR8PrNuk78sRAxRky2E?=
 =?us-ascii?Q?Qwl5nVOww3YYKeKUL40YfLvucFY9MURKCfeKMXtDCZyFkKFhaX08FJmeyDd7?=
 =?us-ascii?Q?4YSarBJPOZMt3a6SPeY4fNOgkVWl/OGgiGtAnGf9DdGk7/pumBCTRa/TG42v?=
 =?us-ascii?Q?51qPcJI5lKOBWM6/Wu4UGSKLPuBdQ55IL5lGUr49dWzJMencnbiwMFsRm9w/?=
 =?us-ascii?Q?J+WtSZhajNRqB7QFVv/xVEHblbTdUrLPjyL1WJ1AdD49cAJfQpbM6ejODRqC?=
 =?us-ascii?Q?Atfile6F7MhVCZwSS7Rzx29GfQ9prNBvK1IZ/tGnAa10j4P9vUUZmiIGNgmG?=
 =?us-ascii?Q?FJN0INi/22acHreJPjIFzXhqJQ95U99s+X0r6SjkS+qyhQ666jQEuXWmEXxy?=
 =?us-ascii?Q?QB5ThxGOmgNx1XRPCc/hP52bCKkhsAqesx8idACpEfx69vAcP5FgrGTuhp3G?=
 =?us-ascii?Q?wwU4EVMxvyn/IoIwKbDEizMqWCDzJmg+tdADCh93q5KmzLqNyvwksuLHZuoY?=
 =?us-ascii?Q?Ha8evjtneuNYNoEWhHgi0nrsas2I5PqtWaiZQSY4Nfz2yZHOD3Q4Ghvotr+7?=
 =?us-ascii?Q?kXZ6s+L/+HF03gjMZ7nhhPVfnR91QOMF47cLql0oKv3mJSK5aXiaSRWifrSl?=
 =?us-ascii?Q?JRJE9FF2PGlk5rgL1N2IU/1muT0hOtCru2BObW3r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1a6e75-9ec3-4971-e6fe-08dd470c430e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:34.8173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9isWcAjN5GGLtdg8DuM/fww7wVdJwkhI8+Q1q1+oSf2rGoT5EAXIJKVWmwtTCub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

Userspace will need to know some details about the fwctl interface being
used to locate the correct userspace code to communicate with the
kernel. Provide a simple device_type enum indicating what the kernel
driver is.

Allow the device to provide a device specific info struct that contains
any additional information that the driver may need to provide to
userspace.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 51 ++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      | 12 +++++++++
 include/uapi/fwctl/fwctl.h | 32 ++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index d561deaf2b86d8..4b6792f2031e86 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -27,8 +27,58 @@ struct fwctl_ucmd {
 	u32 user_size;
 };
 
+static int ucmd_respond(struct fwctl_ucmd *ucmd, size_t cmd_len)
+{
+	if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
+			 min_t(size_t, ucmd->user_size, cmd_len)))
+		return -EFAULT;
+	return 0;
+}
+
+static int copy_to_user_zero_pad(void __user *to, const void *from,
+				 size_t from_len, size_t user_len)
+{
+	size_t copy_len;
+
+	copy_len = min(from_len, user_len);
+	if (copy_to_user(to, from, copy_len))
+		return -EFAULT;
+	if (copy_len < user_len) {
+		if (clear_user(to + copy_len, user_len - copy_len))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
+{
+	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
+	struct fwctl_info *cmd = ucmd->cmd;
+	size_t driver_info_len = 0;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	if (cmd->device_data_len) {
+		void *driver_info __free(kfree) =
+			fwctl->ops->info(ucmd->uctx, &driver_info_len);
+		if (IS_ERR(driver_info))
+			return PTR_ERR(driver_info);
+
+		if (copy_to_user_zero_pad(u64_to_user_ptr(cmd->out_device_data),
+					  driver_info, driver_info_len,
+					  cmd->device_data_len))
+			return -EFAULT;
+	}
+
+	cmd->out_device_type = fwctl->ops->device_type;
+	cmd->device_data_len = driver_info_len;
+	return ucmd_respond(ucmd, sizeof(*cmd));
+}
+
 /* On stack memory for the ioctl structs */
 union ucmd_buffer {
+	struct fwctl_info info;
 };
 
 struct fwctl_ioctl_op {
@@ -48,6 +98,7 @@ struct fwctl_ioctl_op {
 		.execute = _fn,                                       \
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
+	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
 };
 
 static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 93b470efb9dbc3..9b6cc8ae1aa0ca 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/cleanup.h>
+#include <uapi/fwctl/fwctl.h>
 
 struct fwctl_device;
 struct fwctl_uctx;
@@ -19,6 +20,10 @@ struct fwctl_uctx;
  * it will block device hot unplug and module unloading.
  */
 struct fwctl_ops {
+	/**
+	 * @device_type: The drivers assigned device_type number. This is uABI.
+	 */
+	enum fwctl_device_type device_type;
 	/**
 	 * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
 	 * bytes of this memory will be a fwctl_uctx. The driver can use the
@@ -35,6 +40,13 @@ struct fwctl_ops {
 	 * is closed.
 	 */
 	void (*close_uctx)(struct fwctl_uctx *uctx);
+	/**
+	 * @info: Implement FWCTL_INFO. Return a kmalloc() memory that is copied
+	 * to out_device_data. On input length indicates the size of the user
+	 * buffer on output it indicates the size of the memory. The driver can
+	 * ignore length on input, the core code will handle everything.
+	 */
+	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
 };
 
 /**
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index f4718a6240f281..ac66853200a5a8 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -4,6 +4,9 @@
 #ifndef _UAPI_FWCTL_H
 #define _UAPI_FWCTL_H
 
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
 #define FWCTL_TYPE 0x9A
 
 /**
@@ -33,6 +36,35 @@
  */
 enum {
 	FWCTL_CMD_BASE = 0,
+	FWCTL_CMD_INFO = 0,
+	FWCTL_CMD_RPC = 1,
 };
 
+enum fwctl_device_type {
+	FWCTL_DEVICE_TYPE_ERROR = 0,
+};
+
+/**
+ * struct fwctl_info - ioctl(FWCTL_INFO)
+ * @size: sizeof(struct fwctl_info)
+ * @flags: Must be 0
+ * @out_device_type: Returns the type of the device from enum fwctl_device_type
+ * @device_data_len: On input the length of the out_device_data memory. On
+ *	output the size of the kernel's device_data which may be larger or
+ *	smaller than the input. Maybe 0 on input.
+ * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
+ *	fill the entire memory, zeroing as required.
+ *
+ * Returns basic information about this fwctl instance, particularly what driver
+ * is being used to define the device_data format.
+ */
+struct fwctl_info {
+	__u32 size;
+	__u32 flags;
+	__u32 out_device_type;
+	__u32 device_data_len;
+	__aligned_u64 out_device_data;
+};
+#define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
+
 #endif
-- 
2.43.0


