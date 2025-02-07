Return-Path: <linux-rdma+bounces-7489-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875F1A2B6FA
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAB918893A4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E233EC;
	Fri,  7 Feb 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iLc/TLsF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312097F9;
	Fri,  7 Feb 2025 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887224; cv=fail; b=NoP1knTjpUuXY2hHrmr5/Poto+IWH2XLvqnFeMpX+56xQyiM6pVRGTDxUvv0AuW2Oe+qdAha+LM1Lispp2M2+7jszysqPhlDKmFIvl4GFRd9n1h3jnqLEm5gq7tfqHIJetn9p2ehR7bcuRd8cY45p2h9RBW4pHo390vUDQb2pqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887224; c=relaxed/simple;
	bh=+BC/8/ImRIRnnm7TTdOVwxadA/2UDW0kdds/jiWxfTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C2kvpqYluGAHhzUh8+XGsSk3gn5scykVqQO7Oq+W4mZjStG62UpIQA9ELRbvkEybqMSDUtgxjueSXHxtqmMVUngfPxnOSDD/uq/ajnVvktGhweIWNsShfM+radMQ7XVck6e2G/BGGGeMce5i12WvZkYWRA7JvL6a6am8zaUz974=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iLc/TLsF; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBy20uUAydEDRx7pygtss64DcnnZWtHiuB9cDh9fcrGUlyw+MUbUxTq3JIJEZ5JS9ZRyhdfR1RKXH4cnC39HgDCOsIfhsDIjIzNers/irioLz/Iurr20G59rtSgyM/eWXSu2mHXmDAvvbXzObLBS7BspqWd8tbiVl0I75VbKrEleApZqroqByPUXqKJyu6g2McMLCVnbPfN4pWEf1mlt2mLzHLdEcaAbFzkttKhtc0/821gT0ooEeRE7AJgic3r+hiw2KZWrQM262/6OkoYeU/K/mvaBzpWCJeXUFRp4rEYry6igG3d7aCBruqn9zjg5MvXC/So4qFGha29/8Gz1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYTmE7oSBd1YEuwQtZvZxVT9s/kAKDyI0BExdar8Z4I=;
 b=P6yRfauRwAJRNuwqmd/8uuIuLJfWocjkPaxlNg/wFIQve3G6dXxoC7EZMZ3ezTVQ7ullMohjOHNOiMqk4DxkyjY9GlMLAUUT1Cc6vG2cMxOZ0fsZgtiJXWcgm+tr7E2tzOVW8waGuNxAxJUrhvvSfVa5n285ZkVTOHDCT5Xr+y+8hbB2IlwFg7MjbM+5Pkx/L0GzyFjGaeJ2e7PYLm2oMWgs3kVY6tSTe2tjGjQyef6UNfdV62TjjnDHk+H+2/BsNWd/EeaCQtCKofsBbraVWu19dXm1dR9duHwqpIZ69ZgIBkhBE865AfB9O4TJ+OklrP17UgVolu2R0LBGIdfhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYTmE7oSBd1YEuwQtZvZxVT9s/kAKDyI0BExdar8Z4I=;
 b=iLc/TLsF6WNy9fHTHEyCsaZuhGlfMw38uiB98nCnmyX0sh5ASyWWAkR0Pdkw7GOniCjYxXARRswPEknmG71CPjlZflW63cZTkcOIH652pDcSkCDJzTNSb4t35JtGA6EcRsVJJbHhbuDioHpKAimM+jlb8Xj2QhsS0XpOmb3zBheT+vBhilG3lRRp6xaP0wXIVsHyDPOgnXbTbuS025cWOZfWUA4JkHxiLQPTHOOam1QoZc4bnZ9XhjxpKvpr327ZaWn7x3TcNe6Y4P6Xngy5RBPwrjoTq+dpDQpJpsq7cCFeaKWYvVgr4oLqW6kr5WMRe+6hJOftAIJZJpKtnGQDRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:34 +0000
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
Subject: [PATCH v4 01/10] fwctl: Add basic structure for a class subsystem with a cdev
Date: Thu,  6 Feb 2025 20:13:23 -0400
Message-ID: <1-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:408:e4::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c276fc-a0e3-4570-4527-08dd470c427d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xe1YaJUCcTes5UwmjXGX6848qjepo9Y+pXNuZVPlO7OE2Tm2NiunShGAig+E?=
 =?us-ascii?Q?zTo/K9aXMuhVsXESj/n3adSN+QT4oZwWOoGhtsnotv6C6g6qWpnggl+4Kvrn?=
 =?us-ascii?Q?tMo4lNqS8lZGIjhz3qM08PZEnevYhgdAi7rfmQ4m209D74inH5t0cMp5UQD2?=
 =?us-ascii?Q?/tdXGTQEYZcEBve4MobqbHDuVC2rwKBAZNluHFhB3ytPTfkAw8Mgtrcg0f7X?=
 =?us-ascii?Q?Da02WprrihwLvk0iA/WzVG6Y51YrXTLN79bukkrn+LQHwQbX5dJp59Oi66Ak?=
 =?us-ascii?Q?nIHfB99GAPNyvef0er/anuu+DhAzm9JrlYtd1ANI/xcOY3iNE43kXGQVRAzP?=
 =?us-ascii?Q?M06yS9O8rnVqCdlJD3R4LdJnToZu48WJrr3zrhkTRP1Lf27Kke609h1MLs9K?=
 =?us-ascii?Q?hh6PnN2mf8eZEAO+C+D+P56n7LIIfXmKAtdCx7WPAlt0N7dUmqE5IrxGmsxD?=
 =?us-ascii?Q?zbkIEkkEfPFljpuYydarj8l044W0nC14F+BClp+cBB7/xqdsjXoFzywMS0Tz?=
 =?us-ascii?Q?WuNYh6pBKZnZ1K6Eup9yVpAlyoSXMLqqTz7lcnL68ae83PJg13v7hcAX4DTM?=
 =?us-ascii?Q?Z76SMhpct11WSnj7CVhobN7KWTTSY4jys4rWVQpnn/Of7nSnkQCYNldOFSYx?=
 =?us-ascii?Q?RDrehuvaPD8pC0fQc6jUyP1GSkFTjzHwql8BKzdDVTxpHErc1gaizFsPBOVo?=
 =?us-ascii?Q?AyF1KKSsizHJs7S6RqZonS/KmzpX4RteRXgIuR0NcICtAXNFXRtA+oBoKN2o?=
 =?us-ascii?Q?ZjNtQEVXC86/1nHSs+L8FfmT+oOcsneM7wyvB8kXhJnKaQGUnTFTCj532sZ8?=
 =?us-ascii?Q?zdjwuZfMNlJuYzc89QWhsCjrn6hw+QPy20ocaxuIAD7bOyS3o16h0LVOddlT?=
 =?us-ascii?Q?U7ynRlP8cT1hyB+ZnTRhuNeTiG/YMVw50DG2JiZJm/Mey5FSbE6jwMyz231J?=
 =?us-ascii?Q?nI9TNO98IO4SzYCUeND62Vd8GRGrEn4/2/Ix/+Neyy+QQbhTH9RpdryVicKY?=
 =?us-ascii?Q?fZe9wq7PLiXS99PF43+sCQLQbhe4gFzfGWo1qyAzGyOBt+kECXIQQFtRXZ7H?=
 =?us-ascii?Q?73MAULm8znRaQf7M5OOdjZecleLe2LxQv+p+rVNtsvkiAZpZ0x7EPneAZDPX?=
 =?us-ascii?Q?0ehDC1LsPWy7kuvwCYoplgIsj9U20Pr5j6MsVeEwSUZXXE21ketI2WBMDFjo?=
 =?us-ascii?Q?1OVHPowFxf0mVfXAJ4UyV79SJAGeFnXQlweB0XprXnQp+j6MDrl/SuDPEHVP?=
 =?us-ascii?Q?HoStuJVKHZ0t8gICqt+YhfSxA5ShSrZT95edZ3/k5xMWiZI6r5zMVk+cOwt1?=
 =?us-ascii?Q?5nnGoiczMpGO9hA9dUma1MKzdX1BV2RKoHjv22TsCEEx40q7r4THQvHXfSX1?=
 =?us-ascii?Q?5dz1nVjDZyKMhOni4dYC4GUE0cb3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6+cFqZMmOkDIurufhPinoR7J/6S61xzujbZpoGrAQORBsYmFY7+mAr7rSpY5?=
 =?us-ascii?Q?zVusqjs+ccJFl2fitTmPtXSq23EH8vYcMz41Azic0pej8uQ+o9HKPUkEXUQH?=
 =?us-ascii?Q?YOdVJQA52pfuPRdJAFxybHD/Ky/sIAPaYAfvcVWo6tAopyg9CTgDW1hI09Vs?=
 =?us-ascii?Q?vto45w9d1BRt6R8wyU/ZoJnwRreHBKuBY3etaqYouHxLz0W/+pQqDUShUjN3?=
 =?us-ascii?Q?ucNxXqM3SJHR8U9oSMSql02z9oNDc5Dr4uAsaGsf7wsPt+hCCkELT/mqG+Wg?=
 =?us-ascii?Q?YqzllngzbqbGw3GD9Je1QVJXzNo0de1jH7EFQ5xkXs5zJ/iHtAEwFqQ4MSfJ?=
 =?us-ascii?Q?phHRA13R6/g6UA8NlUBRXRnV9xxxqd7M6YVYO/JyLyo5OFjlI2nET5ctlSpl?=
 =?us-ascii?Q?l4BqfeB3+AIIQG00drKwKTVqaFZeGXojwQNAm6XeNJGKlAfXyojKiJS8P2VZ?=
 =?us-ascii?Q?8Bo+qtSjRoxbxoBnuwvme7YTA7x7cbd0ZtsmMVN83jVNzyAgqh8Kklmyd8te?=
 =?us-ascii?Q?khyBFLYaMbyFHKX2HG9Xt/1BRfo/5imN9LFIHTaDzVNWhR4mCM+ac907Eqpa?=
 =?us-ascii?Q?1gDQb3p9yET9SGcPyU6joUBRIyzMUDPzYUmPdJwb+ER5fYpI8rUi6ASCjxgL?=
 =?us-ascii?Q?bSFvISzVOBrkmYGtbBAei9X9qcMMBNLE+Gt4K1cu6UYwUx5JcZ65fXu1CgsL?=
 =?us-ascii?Q?HTdB2/f6jpXENamwoeUTviIp6PQJFcRunlyIlnSAZ1gUvd+OA/py+yx+FJmA?=
 =?us-ascii?Q?kuF4ioc6BKOlCQuvZmDio1C9kIZsLrZwqDEW8g8qpXtLyT3y/lKioK0Iunzo?=
 =?us-ascii?Q?jn+R8DEGicQFD/o/JmIJ6WNIb77hYrG7/23Cr7mm15Pt6L9PJqNbGlTJ8wYy?=
 =?us-ascii?Q?J8uJvbGsuSKYV/nEtSgZ85HUCzjTtqh90uThmF/yHtcMSjNIqCyqgfqiykyL?=
 =?us-ascii?Q?YxWd2X6/Lgl58oSOYemjSfot+22N1m6KQ+p6xnSri0qn3z1gs20aEw113VnL?=
 =?us-ascii?Q?ZfquIpoRo440tPrSJsXwdKTiz6en+eMTftSjBGkIkmEd4Qgdnj3P33HZ7XMz?=
 =?us-ascii?Q?K3qQpdWsKgmVbrQL95MFDv9bMTFYiyyH7W+0CcD2Gu0dkKS301i+oX8GSDMR?=
 =?us-ascii?Q?Iod13UZPVGjm1bK9y85gHWJc7iewopQfUE81BtC5Y4L1Cob0QZD/UHjQJX3I?=
 =?us-ascii?Q?PNcNDoBitTBUwkmP5p0WpgFbBqALwEfcrIGM+cdHHcgqZq0qYpx9g6qu0D4k?=
 =?us-ascii?Q?EKVIQawzTNwTRGF7hYQEcx6h92LUqEZTOSU8bbueHAftKoG+UGP6qYwrb3pU?=
 =?us-ascii?Q?AUeUuZ0N6K+SK9hbfbXgjxTCxCcjsO/qzAXcwGJAXBpp02FEqC50YCzwCZKN?=
 =?us-ascii?Q?8esAUh32ecVlaQEZSqsbtPC0qTHax4ZOl++rjQ1fM10Mtvw6hFGCcv0C9p+l?=
 =?us-ascii?Q?StAVUp1ELOStG46a3aTJrhequw2YPLJHM4nTiixUrXMxcWhV1oaMWtKEoAKk?=
 =?us-ascii?Q?SYFU5JwugsWT0uyY1phUUny+ec1mRgP09vhMKt6E1lIlNvw1Do13iKumhsWl?=
 =?us-ascii?Q?o3+uNdP5D1ItBjJ4/3rnrluZvBTziLDsQ2l0f88g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c276fc-a0e3-4570-4527-08dd470c427d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:33.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvFygVDlpZrtyYOdkIQyG/1CIQ3tANohL33uC7uKn87/w0LXyebjDc0zT7WG43tT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 MAINTAINERS            |   8 ++
 drivers/Kconfig        |   2 +
 drivers/Makefile       |   1 +
 drivers/fwctl/Kconfig  |   9 +++
 drivers/fwctl/Makefile |   4 +
 drivers/fwctl/main.c   | 170 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h  |  69 +++++++++++++++++
 7 files changed, 263 insertions(+)
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 include/linux/fwctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa06545..ff418a77f39e4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9557,6 +9557,14 @@ F:	kernel/futex/*
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
index 45d1c3e630f754..b5749cf67044ce 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -135,6 +135,7 @@ obj-y				+= ufs/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
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
index 00000000000000..34946bdc3bf3d7
--- /dev/null
+++ b/drivers/fwctl/main.c
@@ -0,0 +1,170 @@
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
+	FWCTL_MAX_DEVICES = 4096,
+};
+static_assert(FWCTL_MAX_DEVICES < (1U << MINORBITS));
+
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
+EXPORT_SYMBOL_NS_GPL(_fwctl_alloc_device, "FWCTL");
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
+EXPORT_SYMBOL_NS_GPL(fwctl_register, "FWCTL");
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
+EXPORT_SYMBOL_NS_GPL(fwctl_unregister, "FWCTL");
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
2.43.0


