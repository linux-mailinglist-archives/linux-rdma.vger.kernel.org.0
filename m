Return-Path: <linux-rdma+bounces-2793-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7771A8D869B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF2A28179D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907C137759;
	Mon,  3 Jun 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ez8a4Gm0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71311369B9;
	Mon,  3 Jun 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430021; cv=fail; b=p66+ky5Zz89DBZO3Hk5dOsXA26hZqWolOOJYdXjW6TUnpShLOoa9ZauDu7/87LxytwCWFbyhTh4VX2JC4d4vrr730bNOYoQkBCcClTWzlk9p55cVN+oouM7+NK9SxHfpvS991pyrpiLM9mMTK4DvcdYTuxNfxK8AivCzeqH+6yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430021; c=relaxed/simple;
	bh=B/w8Xxl6ahlkPyMmOt3teiLon1egwfwQDSUl7nT3IhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JQAh42wCCmaQAySAnurzpcdgKCxxKO3jkzhqFLiAlN/8jSr9aaT3CeURqjDx+61CtcDpbzfAhlaF5F5t32eB07DuG/9YPRswNVFt1pOOhKl8OtA/n9i355ZfQiwSKTapNN77YUY7qC/aueDxPeDaoXNTX8zCOeOYB64GPI8YwH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ez8a4Gm0; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8YjDSsmzUcLX6dz4thHvaXm+ERC1xcRZnSCLHBYbjEL/onGycf08j4jAr/VGM9BJ8Ff8LTVCHhCXAIW45FRf5AeDjU090kqCfagC2//b7i3SMDi6W0BPGhLPKWw+A9TE+vR6gcjuDFjQuYp2wQkkeh5NwFdCuilj8fr2bi7tuYL152Jm+udH+0J4Y38QnnDEAVeRBaNOXAPQmrd0blvMU4f4jzjei4EkI9a2yoBowlcxVuHvPJg+JRAcUcf6czqLLaKkJBXlD0aBfOCZOwd9VseFOqrML3Zl2sIZE4dAu/+4wnUYTbs/NlrrpZOSz0vqLIfFx4Td3GysuDvyT2Y7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXbAZ+GPpPi0It5Sp5wSafN7Ssgy5hSKQTFJVJhh69o=;
 b=gJWQVlieq+Cp2GNrgoIaGFQSGZubZbbhUKHVoWe8ULBmhnGxcR7vUN1MZ6EazvChyaXFtUPwhUQsUYb0fOpNSu6Nz3OGtT2ss0zjHntZaekbQaKt95xOnEQO71Ccm+ZMHufj+mw9hTS2U9wasBe+8AEnhygvR16mYdo0qt6H6zgnKgW0S71RgvnmJp9OpKhiog5NbhQ/xTBEfYj26dd8lcdyIfWZlbtepHXrdWPO1IRnp3HYuXRuOxYffQNJRowDUfKLHcSqyuif/hYpFtVXbKj5tC1RrRA2JtZgN5xfI3OJcKZ02HK6IqLoB3wcKoHUcQvyzYTuwtpj1cy+pPjsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXbAZ+GPpPi0It5Sp5wSafN7Ssgy5hSKQTFJVJhh69o=;
 b=Ez8a4Gm0iTtizx8AtvRkmSUvImq903IpGqmjh9YVVh0OI/4FpJmmww8S4YvcQyHeahm+ebaANPZKkDbiFmc4uhh9EDIzLN2/9Enl/0kLqvAwqTcsSP0gw2U0H42vsX38l0YzXPRS3HDktQKPrESUSgesxK/J3DMKtmXKUwLqQD23N7/CxbX2Lqu2OwxDPgbtND1GWWL2VmVzgM24okJ6NEcgTaA9MY8Y5XIXTJqx20Sv8ThfWxClPmUW81+04d+eU1XdDfpjH6biI/ugVWzHgZ4EB0qdD9Faar69AznKIwHj3yNYAqnfRNT+aTNeWSYjTirbsxdx9qEK//vRzCArsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:53:32 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:32 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 1/8] fwctl: Add basic structure for a class subsystem with a cdev
Date: Mon,  3 Jun 2024 12:53:17 -0300
Message-ID: <1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::9) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 859840b4-0825-460b-e86d-08dc83e54fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m6v81c33ERpi4PD3LJOddQjE0ipoO+moaUxgt16Hb2N0rlMCx2d/vl/u3gIP?=
 =?us-ascii?Q?GDHIb4vT0dEXyqlEWQE5GwIc5vDB801Cr3vW/yZxU+SwD7Ep+YCKwfkxZCGm?=
 =?us-ascii?Q?dPo+Q083EACQGW3644Dxu3OWcGLOA0roQFiuwvU/FuOXRuDzYZHQaupf8VLy?=
 =?us-ascii?Q?9rJcrX76xRbIa1/bUNnL2K4JRgexooHx8hYyVw9AXXeyIl1FLJQDG5KPUP9i?=
 =?us-ascii?Q?fke3Tcc8XO2iivOn1KJVAxHabrjR0ziogqZRQdG5hnUVsJI880DweIfi8VZj?=
 =?us-ascii?Q?F3N1fH+NooRc6pU16bM24uSTm4Dxq+8nxDH5Q4rXMntc+YCEL9dxa8YETrZh?=
 =?us-ascii?Q?QK02eRUaU7asvsiVC0QECJj1Wv0Mf48I9bLX1PoNEZf8jw++8FLIq1BnsRtX?=
 =?us-ascii?Q?mAJyv+oz7D9b1sU4TRShnF8JWoNbJ1XO0P2nSTWKmQQlGSkPGNbpado2YFDu?=
 =?us-ascii?Q?3SqIfGpoPjtIfYzGP6DXkFDalv8zj9xE+9Y29gEVCVCk371ydzGx1Ua78YhL?=
 =?us-ascii?Q?eJ6OXWtv9GrsvAza6yYtKTEsmxHoAiL2LiKl9K5M8AGYjF7W2qxVyIeToyJH?=
 =?us-ascii?Q?XiC2zcczMaPWyts9wo592dQcTBkV9wE36oPvsGUUMHKJ5GfZGSgTHwYoWu5h?=
 =?us-ascii?Q?oGnZyqVGf/iKX2JTYSyJ2gMTPvGRHWJOisD2Al6C9yhSyHeApGmte8RfiGUY?=
 =?us-ascii?Q?E8p+Ij886e7Kx3c/mX0AOFS5DEU6Rq4pB0T0ahl2Ks8d9eSmJzZVeNkzyVUp?=
 =?us-ascii?Q?DCT5MybGdmP0KqGiX3yM5KlIrIcCZ5dvuras3nFAP9XO4F/fHg4nI+YXcil9?=
 =?us-ascii?Q?Wyk6/7RLavv83JUMo3wIZCoVw2V1hQr4ey3HfHWw+170Og5LaDm7JhPUepde?=
 =?us-ascii?Q?uwou7gDKwr0XiORZTT6Wzduu4FgfkNAyW8YIceDmi6Z9Qf3rFJ1W7FYri1Ha?=
 =?us-ascii?Q?BfkhYfBgb0X0/xTdjzUavPzNmV2bsJXXqkl5tMAprN6RzgFWE5gjbNgQK79I?=
 =?us-ascii?Q?jw7tkDPtkXaO/73Bnz8yRmc9z2UoyZxnUKdI9ezOlrlhRC6PiNjIHM0RdbuV?=
 =?us-ascii?Q?D95A7X+Z5EajtIB1mdRHoTr4UUbUM+qMLJBpaVG/tthBIRNw/IIWyjaYwI/A?=
 =?us-ascii?Q?L0Y2QXeqxBnPF78gTcdTL1ZZEc9zu6aLHoAiyS18NqAXREcG3ro/SHIUbQIJ?=
 =?us-ascii?Q?6hqHy19L//O8rJdQMlPc2cLDDex7jehb4O2MZ89vdGGP48xxhuHBYpDHz/Pv?=
 =?us-ascii?Q?xa+Ni+u/nUT2qTz3V0LhdBEbo8CDD60HTs0pwVAAxHDJlfDhWbTnrPMP9Nar?=
 =?us-ascii?Q?bBQT35oy/nG6cqI8lw9sqMt6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SHzBHd+hpb6Ku52iVsTWOxLK1rfL4pYwmBce7kESFKxuzBjcLB7JXxThKdqn?=
 =?us-ascii?Q?oVqueCwweILFLVHE3JET6ZuujatIpO/fSVLh1pHb/bcORffz3E5UymSmQt8T?=
 =?us-ascii?Q?wQD0vBhOXoYr0XLQoNIPQWIBT2FGkWUmEieC+nxmMjiUC6dPlU1Q+lFK6Oq9?=
 =?us-ascii?Q?wQGHOYKo43z7iW4ydR2m/CU5U+0qGH62YrX4+1yqZNbJluENI0pa1G6/XQct?=
 =?us-ascii?Q?KkCBK4EYCZS0uYPWqoy9bqfa+GMEIMXepbXMN5+qtfANfAxCo1TMuXbcDsn9?=
 =?us-ascii?Q?H3E59wOumdxlTJKZbnPv3DWFxykLGGl6dwYczNyDIdTGmMr0vDW7Lx/bBsTm?=
 =?us-ascii?Q?B4J10EARjdwMEd41Q4kfFUfAsP5nJO89cv4JsUXcHqkHwbpa5sEZclCqOCDp?=
 =?us-ascii?Q?itF+4OmAxUz+BaxksyP27R7jhUBVXNEsrfLd7ZJQ2S/TQd/1IpWkqKi7gXKu?=
 =?us-ascii?Q?oQOZbJhsTN+n00mm1rEBreO10jMjDyOUj5DRD1dh+9RvRyc0unLRBkPca7E2?=
 =?us-ascii?Q?rv1Uo31ex7EnDQki3vLnJHmmjTU7yOcclH9XIdMULNtD+GFhgAx9YvP2BRnQ?=
 =?us-ascii?Q?mGhczvOD8W3M+svjeJMh8jpwOA0oO8/hRDkprFtQ31eR2O3sciF0jECTnnTs?=
 =?us-ascii?Q?OVAUI6hSkcDtOR0+SPamFLI5Cdt7b/zUSz79HqU3ujwX+Tx4C0nB82IHb78p?=
 =?us-ascii?Q?iKb74X3KQ2pmTNZPOVNdSUkCYpTvt0PJ3wPEQSAxfBTkw5KjuHS060W57jwW?=
 =?us-ascii?Q?ZtETYAPR0qpZn13Ct+dAQ7YXt2C2zdj6x6VN/fefVPDMTUVdKLPvagF/eVp9?=
 =?us-ascii?Q?Y7rfGKa0H0YpGWjk/JbMMLm1xa05QUV7byU0W53MKiMunVZjq6XxVzO90LhQ?=
 =?us-ascii?Q?+uFINHLXcXNg9fP7yVdFzj3kw9KbtY9jq0N4mgbmjRg2A2VIaV6FBsQE531D?=
 =?us-ascii?Q?rSWcVS/dQoXfptn4pZ5giXWntHzD099cnuGh+UkkmjMHRHpbwrLpOYVqal/i?=
 =?us-ascii?Q?HaeaUITABSzpKzsI9sNo8zUuNAKHda5cxR6O66cl0p+AI96+w6yV5Y+HbWB0?=
 =?us-ascii?Q?2scHMkavvJCR6j4eG++BJMuxvhAbkAjPuvmOGOtyHbL5ra9w0Kbm9Oew2DgL?=
 =?us-ascii?Q?8mSst+WNfhN7oybG4rDxVYT/1YGk5X7YZg28Edg9Y9CcBezEIq/Z56LdmsKw?=
 =?us-ascii?Q?azBoYR5x8QgAyYFg2dzS/so34i9e4IvUOl0EdFCf+d3/aOECY/vGEGdEc/ah?=
 =?us-ascii?Q?cXSufYjEUf5Ay/VfbE62SrnosJZQgv5W8WVwSavV0I1xGa2mGDiQE3x3T8OU?=
 =?us-ascii?Q?KY+f14dfjnDHt2D3Pk80juc5wo3rbPkIdPsDEfw3hKEACznkj8UI3SSn3+jq?=
 =?us-ascii?Q?4hah34fKZONgKV7jQNE738nEdRYmKhLBJUhaTzRiBNOaPYxfXGZcvlm9LUUl?=
 =?us-ascii?Q?GTGb+xbX8oT7KRfJlY86lOJady2QbKcDm4rqWQ+Rm6u+czcyRFQGkss0CPTm?=
 =?us-ascii?Q?hQb0zuzajwJ5KNXOymjG30sesqNEmD+eu4a60h+5jRMLvFVfOkxf4UTQiTDD?=
 =?us-ascii?Q?Bzmgv15JyK5bIDXTtpb0/icbBlEJFfU1lRi9GlYJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859840b4-0825-460b-e86d-08dc83e54fca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:29.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3aSmVgjEj5MpSVSCpLqrFHBgJc1HZIQQ0dZg4xF5hqjP5oF5A9g7cIeKCA2Tdpo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

Create the class, character device and functions for a fwctl driver to
un/register to the subsystem.

A typical fwctl driver has a sysfs presence like:

$ ls -l /dev/fwctl/fwctl0
crw------- 1 root root 250, 0 Apr 25 19:16 /dev/fwctl/fwctl0

$ ls /sys/class/fwctl/fwctl0
dev  device  power  subsystem  uevent

$ ls /sys/class/fwctl/fwctl0/device/infiniband/
ibp0s10f0

$ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
fwctl0/

$ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
dev  device  power  subsystem  uevent

Which allows userspace to link all the multi-subsystem driver components
together and learn the subsystem specific names for the device's
components.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 MAINTAINERS            |   8 ++
 drivers/Kconfig        |   2 +
 drivers/Makefile       |   1 +
 drivers/fwctl/Kconfig  |   9 +++
 drivers/fwctl/Makefile |   4 +
 drivers/fwctl/main.c   | 174 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h  |  68 ++++++++++++++++
 7 files changed, 266 insertions(+)
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 include/linux/fwctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8754ac2c259dc9..833b853808421e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9077,6 +9077,14 @@ F:	kernel/futex/*
 F:	tools/perf/bench/futex*
 F:	tools/testing/selftests/futex/
 
+FWCTL SUBSYSTEM
+M:	Jason Gunthorpe <jgg@nvidia.com>
+M:	Saeed Mahameed <saeedm@nvidia.com>
+S:	Maintained
+F:	Documentation/userspace-api/fwctl.rst
+F:	drivers/fwctl/
+F:	include/linux/fwctl.h
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7bdad836fc6207..7c556c5ac4fddc 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -21,6 +21,8 @@ source "drivers/connector/Kconfig"
 
 source "drivers/firmware/Kconfig"
 
+source "drivers/fwctl/Kconfig"
+
 source "drivers/gnss/Kconfig"
 
 source "drivers/mtd/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index fe9ceb0d2288ad..f6a241b747b29c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_MEMSTICK)		+= memstick/
 obj-y				+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/
+obj-$(CONFIG_FWCTL)		+= fwctl/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-y				+= clocksource/
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
new file mode 100644
index 00000000000000..6ceee3347ae642
--- /dev/null
+++ b/drivers/fwctl/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig FWCTL
+        tristate "fwctl device firmware access framework"
+	help
+	  fwctl provides a userspace API for restricted access to communicate
+	  with on-device firmware. The communication channel is intended to
+	  support a wide range of lockdown compatible device behaviors including
+	  manipulating device FLASH, debugging, and other activities that don't
+	  fit neatly into an existing subsystem.
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
new file mode 100644
index 00000000000000..1cad210f6ba580
--- /dev/null
+++ b/drivers/fwctl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL) += fwctl.o
+
+fwctl-y += main.o
diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
new file mode 100644
index 00000000000000..ff9b7bad5a2b0d
--- /dev/null
+++ b/drivers/fwctl/main.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#define pr_fmt(fmt) "fwctl: " fmt
+#include <linux/fwctl.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/container_of.h>
+#include <linux/fs.h>
+
+enum {
+	FWCTL_MAX_DEVICES = 256,
+};
+static dev_t fwctl_dev;
+static DEFINE_IDA(fwctl_ida);
+
+static int fwctl_fops_open(struct inode *inode, struct file *filp)
+{
+	struct fwctl_device *fwctl =
+		container_of(inode->i_cdev, struct fwctl_device, cdev);
+
+	get_device(&fwctl->dev);
+	filp->private_data = fwctl;
+	return 0;
+}
+
+static int fwctl_fops_release(struct inode *inode, struct file *filp)
+{
+	struct fwctl_device *fwctl = filp->private_data;
+
+	fwctl_put(fwctl);
+	return 0;
+}
+
+static const struct file_operations fwctl_fops = {
+	.owner = THIS_MODULE,
+	.open = fwctl_fops_open,
+	.release = fwctl_fops_release,
+};
+
+static void fwctl_device_release(struct device *device)
+{
+	struct fwctl_device *fwctl =
+		container_of(device, struct fwctl_device, dev);
+
+	if (fwctl->dev.devt)
+		ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
+	kfree(fwctl);
+}
+
+static char *fwctl_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "fwctl/%s", dev_name(dev));
+}
+
+static struct class fwctl_class = {
+	.name = "fwctl",
+	.dev_release = fwctl_device_release,
+	.devnode = fwctl_devnode,
+};
+
+static struct fwctl_device *
+_alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
+{
+	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
+
+	if (!fwctl)
+		return NULL;
+	fwctl->dev.class = &fwctl_class;
+	fwctl->dev.parent = parent;
+	device_initialize(&fwctl->dev);
+	return_ptr(fwctl);
+}
+
+/* Drivers use the fwctl_alloc_device() wrapper */
+struct fwctl_device *_fwctl_alloc_device(struct device *parent,
+					 const struct fwctl_ops *ops,
+					 size_t size)
+{
+	struct fwctl_device *fwctl __free(fwctl) =
+		_alloc_device(parent, ops, size);
+	int devnum;
+
+	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
+	if (devnum < 0)
+		return NULL;
+	fwctl->dev.devt = fwctl_dev + devnum;
+
+	cdev_init(&fwctl->cdev, &fwctl_fops);
+	fwctl->cdev.owner = THIS_MODULE;
+
+	if (dev_set_name(&fwctl->dev, "fwctl%d", fwctl->dev.devt - fwctl_dev))
+		return NULL;
+
+	fwctl->ops = ops;
+	return_ptr(fwctl);
+}
+EXPORT_SYMBOL_NS_GPL(_fwctl_alloc_device, FWCTL);
+
+/**
+ * fwctl_register - Register a new device to the subsystem
+ * @fwctl: Previously allocated fwctl_device
+ *
+ * On return the device is visible through sysfs and /dev, driver ops may be
+ * called.
+ */
+int fwctl_register(struct fwctl_device *fwctl)
+{
+	int ret;
+
+	ret = cdev_device_add(&fwctl->cdev, &fwctl->dev);
+	if (ret)
+		return ret;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
+
+/**
+ * fwctl_unregister - Unregister a device from the subsystem
+ * @fwctl: Previously allocated and registered fwctl_device
+ *
+ * Undoes fwctl_register(). On return no driver ops will be called. The
+ * caller must still call fwctl_put() to free the fwctl.
+ *
+ * Unregister will return even if userspace still has file descriptors open.
+ * This will call ops->close_uctx() on any open FDs and after return no driver
+ * op will be called. The FDs remain open but all fops will return -ENODEV.
+ *
+ * The design of fwctl allows this sort of disassociation of the driver from the
+ * subsystem primarily by keeping memory allocations owned by the core subsytem.
+ * The fwctl_device and fwctl_uctx can both be freed without requiring a driver
+ * callback. This allows the module to remain unlocked while FDs are open.
+ */
+void fwctl_unregister(struct fwctl_device *fwctl)
+{
+	cdev_device_del(&fwctl->cdev, &fwctl->dev);
+
+	/*
+	 * The driver module may unload after this returns, the op pointer will
+	 * not be valid.
+	 */
+	fwctl->ops = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(fwctl_unregister, FWCTL);
+
+static int __init fwctl_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&fwctl_dev, 0, FWCTL_MAX_DEVICES, "fwctl");
+	if (ret)
+		return ret;
+
+	ret = class_register(&fwctl_class);
+	if (ret)
+		goto err_chrdev;
+	return 0;
+
+err_chrdev:
+	unregister_chrdev_region(fwctl_dev, FWCTL_MAX_DEVICES);
+	return ret;
+}
+
+static void __exit fwctl_exit(void)
+{
+	class_unregister(&fwctl_class);
+	unregister_chrdev_region(fwctl_dev, FWCTL_MAX_DEVICES);
+}
+
+module_init(fwctl_init);
+module_exit(fwctl_exit);
+MODULE_DESCRIPTION("fwctl device firmware access framework");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
new file mode 100644
index 00000000000000..ef4eaa87c945e4
--- /dev/null
+++ b/include/linux/fwctl.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __LINUX_FWCTL_H
+#define __LINUX_FWCTL_H
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/cleanup.h>
+
+struct fwctl_device;
+struct fwctl_uctx;
+
+struct fwctl_ops {
+};
+
+/**
+ * struct fwctl_device - Per-driver registration struct
+ * @dev: The sysfs (class/fwctl/fwctlXX) device
+ *
+ * Each driver instance will have one of these structs with the driver
+ * private data following immeidately after. This struct is refcounted,
+ * it is freed by calling fwctl_put().
+ */
+struct fwctl_device {
+	struct device dev;
+	/* private: */
+	struct cdev cdev;
+	const struct fwctl_ops *ops;
+};
+
+struct fwctl_device *_fwctl_alloc_device(struct device *parent,
+					 const struct fwctl_ops *ops,
+					 size_t size);
+/**
+ * fwctl_alloc_device - Allocate a fwctl
+ * @parent: Physical device that provides the FW interface
+ * @ops: Driver ops to register
+ * @drv_struct: 'struct driver_fwctl' that holds the struct fwctl_device
+ * @member: Name of the struct fwctl_device in @drv_struct
+ *
+ * This allocates and initializes the fwctl_device embedded in the drv_struct.
+ * Upon success the pointer must be freed via fwctl_put(). Returns NULL on
+ * failure. Returns a 'drv_struct *' on success, NULL on error.
+ */
+#define fwctl_alloc_device(parent, ops, drv_struct, member)                  \
+	container_of(_fwctl_alloc_device(                                    \
+			     parent, ops,                                    \
+			     sizeof(drv_struct) +                            \
+				     BUILD_BUG_ON_ZERO(                      \
+					     offsetof(drv_struct, member))), \
+		     drv_struct, member)
+
+static inline struct fwctl_device *fwctl_get(struct fwctl_device *fwctl)
+{
+	get_device(&fwctl->dev);
+	return fwctl;
+}
+static inline void fwctl_put(struct fwctl_device *fwctl)
+{
+	put_device(&fwctl->dev);
+}
+DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
+
+int fwctl_register(struct fwctl_device *fwctl);
+void fwctl_unregister(struct fwctl_device *fwctl);
+
+#endif
-- 
2.45.2


