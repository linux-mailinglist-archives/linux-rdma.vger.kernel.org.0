Return-Path: <linux-rdma+bounces-4470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D46795A481
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13BA1C228B9
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD511B3B18;
	Wed, 21 Aug 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cIEnmda6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11F1B3B21;
	Wed, 21 Aug 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263881; cv=fail; b=nVnyTPjDEjgiw1mFlmApeBcCALoKYj0YDRU4GysbfUzjuiu2U6yE9w3BMcCsnOjTz/8MIM7DNrtowTAN3+cUo5g2w8t9tpLxT9HmlEGMYvqNYhJj6nbuHogxxLTBNoP1ZqaW/Mj7ozq4RhPM2NX71P79p9oLac1s/fKVHhVuEMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263881; c=relaxed/simple;
	bh=nA/8nouje4cYhouLytNiDOUSXfCNAQDid1t77M3QiNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/4rdTSy+2sSz7u+E1gaEQYVi6RgUE7G35UxnbGSGg1LMiq0Oj311g8h7U4kf63iQebHNZE7GfkfN2nOVG2Bzf82018eO8kw72QxBV+4xCWvNjlVOxj/DjN9gtLlizQseQMG883uyoRL6Quf02OupWv02jqCSSBd9G/OgZg9bNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cIEnmda6; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gp5cKtinkozgIO5ei3N9hMRn8pPnPTZ4RmJdUx9GU7pjrbJxKLAkfEqi9oqk+/C5YZSzhcF3oHfuiVWGuS/jxF40BRAHi+YcL9/dRsUqUUGDZ/ADALdCznRqK5BRaPERRVn2lOdxCO/pvXc11N0SNNc5FI4aHMVfHYiPLXxzX1A9BhMpohQt26N+dFMnx98PzMCGu8kCl+6XKSk6MAxc1zapmMj/QDs/wJL1/FLK7abbA+JMw0UyUzHUlJVe6AxAa+sqr8ezwmPOGrC+GJInHefrZPOyS+FFxaAs38+LnCWolnoaSQ7H3DNdnm7ggpvrxYsHTrTFlITiqzAaO0EYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdIeS77pvw9NrmsbvLmJ4XgKIfAqyn4uFZsi3oNCQhM=;
 b=yPdQEB/jm27/IANMzv11sAQDh3djc1mZZFWgjjckkzMeOpeV1CZ1UAcD20g3Nq/vmdGwftC18lCJcGCdr0E3gWmld3Lc+Vt5XGslRBbfzjgm/bRCbebNgGtCSyzFZFEQHqBsHAWLg3rrr9Y+5Lq/zVcYjHW/m2og7Lu+gNfUCESpXAOwkl3zCQTTlkAGBOb8yu+usdSdBSbwT3974daSh8V192KhNN4mvPn6nX4Fv3knmhDQIb6P9utvtiX4bSwkmtMRoS6x9HZ3+GvbhGmcdvjt2u3nUYGZTLQelU1mlqLJgXBo2atribs51TzREC/v9Fd4RSCo4mZ0kFYS9Y2YQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdIeS77pvw9NrmsbvLmJ4XgKIfAqyn4uFZsi3oNCQhM=;
 b=cIEnmda6gGcMWLU9AU8ATX8sOyXgR21DQJZWHAWBGCrcn7FTCWIi9oSjO3m0+YrKsCRlY5lgJy6OrcgUgrIJtbDC1claDgh6vjK7QXBDIlq2XyjH+ah59VVo8C62wi3a3jodbV9KyvTdFUfvfLRG49maoQ5gfBqUyTFuBKDx55dE5gijGRlrqt9pkCFZxa1QwU7aZF+AwJb3waJ/ByVIPfrsQr21yhDgvN0wQRyym5VnJJvjMKAU+I2R2Ft3MIO4+dH4qwb2Mov6BkaQxA49YYVFGXtUrR7WmgAesc9mmbOBET3sFGbD652IpamWp01wyzCkmReGNh9jlMJkGun7Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:07 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:07 +0000
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
Subject: [PATCH v3 01/10] fwctl: Add basic structure for a class subsystem with a cdev
Date: Wed, 21 Aug 2024 15:10:53 -0300
Message-ID: <1-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:408:fb::24) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8560c3-eb1e-4986-7015-08dcc20c9e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cNcKkoSemlaGAJZ1/HpSPbkVjRGgDzNGgFQpMiYtVYasSyA7rVIi+ajSpQMk?=
 =?us-ascii?Q?688XWnhOIef4V6xMDv1P+pY9Xm+gY+nJFf/r1JydnXAh9p1QmyUPAqXOSf8G?=
 =?us-ascii?Q?lrrGyucuXv6pTPj8MGvn+ZxTMyY7lLQzm/MnIxtT4U/1Og2bRfpgRydvgPaD?=
 =?us-ascii?Q?92g9DGjc8A+1J2OZDwlmVjr1Wf1kyB8PpWXNAb5sHpmHm1RP27ESe49qJYDH?=
 =?us-ascii?Q?SUCOJ6ya0uKrSFiPKZQ9zACuqQZaVIZI8UGt0cce9SlGsXnObRQs82cqKkCw?=
 =?us-ascii?Q?RWt5NDHp0a0OOCtxbD/WTlKa/W6R3ea4B5qcLFy1Y9fqxcREfyLBUAOp6GDc?=
 =?us-ascii?Q?aB1CHzHBqAzLUqFpacrF+2RMcZtDFtu8oExXRPkpPpAiZUHJwNQBl8E2zECo?=
 =?us-ascii?Q?EfmQb7PbAeP7ElUuVBUneCSdTe9PWtnfYtYibIv+tZnD/+x7yEOzKa3aA7i0?=
 =?us-ascii?Q?nxIv9XNEl6RtdoIwOjNKTVgbUhpafg60cPRqPgnxWbMHa2/mU7X/R20zzi0R?=
 =?us-ascii?Q?AZNrkx/qOb39Xjhk+wB1mP7mAZ9zjMrrdVNR2xu2qMyhMJiEbgzwAaxKk8GE?=
 =?us-ascii?Q?m1bvdIf3esI8AjTgbEWJBDWgrjC6WfNAzdX1TLsv/WjxCrNbMLRH48DRfg+x?=
 =?us-ascii?Q?Mjj5Jwo2PExfem9CAfg78684VIL3Zv5NO7HOWqxR9zVzQnT5kkd0UFnN/L3D?=
 =?us-ascii?Q?3Yl27EjE5r7ehv1ZE3lcoT/lei1qQJeSG9uQUz6vF8RXpMcPRiyYmx7kAaMm?=
 =?us-ascii?Q?EHix8ibfApDPj7wrarE1tObqgFFM77WZU+U6RfskaKrl+aPECBPKF9omhhAe?=
 =?us-ascii?Q?DxghNxfO+/RTnLmGhAtxMMIRDW3QLtZLWBxjSLgfEvxwfL0bWqH09QAp3vhL?=
 =?us-ascii?Q?yRiDaJNRCFyBfRbokSUyRkxhQ5nta0usoMMBMkGGvsGD3t7lBRRGLs6qFB6D?=
 =?us-ascii?Q?jt5EN5VI+1WrxP4Qte5lm1CQRifijRlKVskBXvDX0sC9LYxA+j3D4BL2q/v8?=
 =?us-ascii?Q?xy0zftWepvau3RtlaHxKIOOD/OnyjQTWjMepJEdhl1SGPiBzjBEMpTf+bsqU?=
 =?us-ascii?Q?/i2ZtYDBhv2Rw5mcL11vdIrm/2G/KifnnZSgaYlrKPK1SydiC5NnHekdb+Hj?=
 =?us-ascii?Q?VrN4Qp+QZWUvg+MBmvg7yXqWBu/8qalFvGH5XU650U5uWlqgTmPXgfVtQ189?=
 =?us-ascii?Q?wngpbQ2AN3FHTMC5SiFGPtEmmfP64wV+VrxFxH0Z5TW69O24HDB1qFfxmoby?=
 =?us-ascii?Q?0xkJ8bb1udaP7+Ae7XAU6PcZeY4Zx5LsgQf/3xDsBpX0vk1JDIELqPiAnTjl?=
 =?us-ascii?Q?y6xUAKZgW/hx5St1ssi6N+wytEqV7SMydiPeRPrlTMMGgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jIHGQ6mf8WXfIUp8EERoMA/Sn8e5c1VQ5n8PaI7bj7LKUmABcsRog+g2bwC0?=
 =?us-ascii?Q?Cfh6J6mzkpDl0LPQm0BXELNv+zWWJxIcLwB2BBvP3bq3COsWaKAOZT5rBpJ7?=
 =?us-ascii?Q?+erXcEq7JpQEJodqIZLs5h/zFJfxSWwgvYerTTL9m45pIst+JTQHBNdLK9vH?=
 =?us-ascii?Q?glIoRDhv5CpuEiPHCKfAC0YamRFn45hUiL1sp4vWJfRdTT3NOo6Mgdn+dVja?=
 =?us-ascii?Q?4yQdww6ZfT2mjS87qz3osJjU1lkbGsOvLt39sdtve97aqLrLhxKnhFN/ogoy?=
 =?us-ascii?Q?V5cqHfN+Dq9VUQD6KecqyQ3GZF7K0hxZS3fj4H3hauzdCPqKSaXr8rSUey9w?=
 =?us-ascii?Q?IJR4giPftOOJYUiUVD+SR3cmum5NG871HzQ5HG03Wp4yxFC4BS27JzoHo5nd?=
 =?us-ascii?Q?f5iPITexowlBqfH1pKqjpm0t8iJMha2LR+GYiw5r6N+MWFLzWGuon9i0O5SE?=
 =?us-ascii?Q?iqDjcbgPyUAGFGqqKoxQXgtWWit70Xw5VSh6L4laUYdo5/W40l68A4AFH5/+?=
 =?us-ascii?Q?+ub2J0junEdw8UVf2//n5NmudT7E1BMyxWyJ42cVsNV4tNxDdtrU1FJk2hOi?=
 =?us-ascii?Q?69hjAmukOcInu4139k3w8zeLUk0U46VjtmiGq8ZB9LoVPN37gopetei+OCLM?=
 =?us-ascii?Q?4c3FXpwGVrvTR7ffJC7r/frleJhpZDs4SLy1BsAHTJxFhwwJHvnpGDsP9zEW?=
 =?us-ascii?Q?psFCi97hdq5I+jXKjfcWshZDlD5BEkfoRwXGvhYuXTEIwVFavT87tbGJJv0i?=
 =?us-ascii?Q?sRS5p24KTIXx/qJlPnPVr5+v+NHDPRpP8tEHSi9GSCBXse+k/9WVBcHDXsY4?=
 =?us-ascii?Q?bSuXgA1ONQchKXXCZa37SNJfF2z5hm5UL3MhUUS3Gi3xJrr6iawtT7ghi3Zs?=
 =?us-ascii?Q?ERDaErtt56l/oIVN3+mrpk6SafLWcSB+zLUrlQuwHrR+w+De3trk+ZekCRZQ?=
 =?us-ascii?Q?S8rjUeJr8+JvTYamxnGkeGqlVIysYhmz8s8BIbLWeEH/J++A6IApr5PvTJhn?=
 =?us-ascii?Q?m5CS8GzxM7kaI/6pAWUKzXlt2ChBABOIGNr3mWcgcSEuKFlDS4YtjNPF1hTz?=
 =?us-ascii?Q?ehvb6n61FU8C6LhVnhJ7gWOFatQvU9+AxesuPwC7QCZg6nsGyyUmfk0P3SEB?=
 =?us-ascii?Q?V0HeLd22U/2yuGEYju4IICYSuR2e4aeRg2n/s42OcvoXCaZRsAa29oTDlFxv?=
 =?us-ascii?Q?3h+m4/JJS+XxQUwNKelVxJExFQC8VYaWOqOLlGHHNaXqIBTdfywJpVkWmqOk?=
 =?us-ascii?Q?4/SWfjPlSX/7uieq1lgj103VH3O9Zdeabg3wBBYU3RCnS63eSVpBSOFfFfqg?=
 =?us-ascii?Q?8mDsa0Xzpr0a6hsvyq05msXBbbwZY8NK1NpKH/rNtbcdASYJ0ahQ6EOgTpdr?=
 =?us-ascii?Q?Qcj8x7SRlB1ZcXsgwvgSpxef+NaWIOFK2Ix6vHs63/pVJBG/5NNji/CRRjdk?=
 =?us-ascii?Q?fqdGu0nw5Qw26Q1kGMN8IQehmVZ+hBuGHFsNgGRt9wsjYKMjfo6k0qFXm5J1?=
 =?us-ascii?Q?CDFRpmxIB0p39eWhZEgFxQw9XKNsZDkrd33nvbh4tU05zydgEnh93kSZ3v2p?=
 =?us-ascii?Q?RvPd5/En+PW+6RV/fdINzqRuHNH64fHbFmNmluFp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8560c3-eb1e-4986-7015-08dcc20c9e94
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:03.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMWb9ck3nBc5mZ19LZTopNij3Zks5o+fDl6qH57KFDQXCX9RmAkZPSzKXs50XUdd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

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
 drivers/fwctl/main.c   | 168 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h  |  69 +++++++++++++++++
 7 files changed, 261 insertions(+)
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 include/linux/fwctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ff21a07589b51..2efd8d14495431 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9241,6 +9241,14 @@ F:	kernel/futex/*
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
index 00000000000000..37147a695add9a
--- /dev/null
+++ b/drivers/fwctl/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig FWCTL
+	tristate "fwctl device firmware access framework"
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
index 00000000000000..7f3e7713d0e6e9
--- /dev/null
+++ b/drivers/fwctl/main.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#define pr_fmt(fmt) "fwctl: " fmt
+#include <linux/fwctl.h>
+
+#include <linux/container_of.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
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
+	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
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
+	int devnum;
+
+	if (!fwctl)
+		return NULL;
+
+	fwctl->dev.class = &fwctl_class;
+	fwctl->dev.parent = parent;
+
+	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
+	if (devnum < 0)
+		return NULL;
+	fwctl->dev.devt = fwctl_dev + devnum;
+
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
+
+	if (!fwctl)
+		return NULL;
+
+	cdev_init(&fwctl->cdev, &fwctl_fops);
+	/*
+	 * The driver module is protected by fwctl_register/unregister(),
+	 * unregister won't complete until we are done with the driver's module.
+	 */
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
+	return cdev_device_add(&fwctl->cdev, &fwctl->dev);
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
+ * The design of fwctl allows this sort of disassociation of the driver from the
+ * subsystem primarily by keeping memory allocations owned by the core subsytem.
+ * The fwctl_device and fwctl_uctx can both be freed without requiring a driver
+ * callback. This allows the module to remain unlocked while FDs are open.
+ */
+void fwctl_unregister(struct fwctl_device *fwctl)
+{
+	cdev_device_del(&fwctl->cdev, &fwctl->dev);
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
index 00000000000000..68ac2d5ab87481
--- /dev/null
+++ b/include/linux/fwctl.h
@@ -0,0 +1,69 @@
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
+ * Each driver instance will have one of these structs with the driver private
+ * data following immediately after. This struct is refcounted, it is freed by
+ * calling fwctl_put().
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
+ * Upon success the pointer must be freed via fwctl_put(). Returns a 'drv_struct
+ * \*' on success, NULL on error.
+ */
+#define fwctl_alloc_device(parent, ops, drv_struct, member)               \
+	({                                                                \
+		static_assert(__same_type(struct fwctl_device,            \
+					  ((drv_struct *)NULL)->member)); \
+		static_assert(offsetof(drv_struct, member) == 0);         \
+		(drv_struct *)_fwctl_alloc_device(parent, ops,            \
+						  sizeof(drv_struct));    \
+	})
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
2.46.0


