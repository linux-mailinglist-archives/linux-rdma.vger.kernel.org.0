Return-Path: <linux-rdma+bounces-8200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E4A48D41
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CEB3B0489
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01A76025;
	Fri, 28 Feb 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SMZnxa3r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323882BAF8;
	Fri, 28 Feb 2025 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702411; cv=fail; b=R0L4g7Hj5lh7LEqyDGxn57BDl9vwX7B8EEe2DDJF6lWtkdhbSacKzOUjjEsJLWURwT+S/d2i8OrLojuWT+wvHKMWR0b7hZ0vSr4pcQC3RaiuHfvYDXgQAJfgzqh2hQxz3nsTIVoSQzQzYyDwqNQlaoVUwyz4xBLqTxoBZbzDNqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702411; c=relaxed/simple;
	bh=BcRL340GfDF2O31raKp8xlzqXG1uJuialtZYdaAX61I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SH5qaTBlmdtJYeODWeOBtEM894uYu/Sxxz7MvdKC7d9aVOlk3ugrgJZeAhChxBKURPxqIYV00/wySralEfTmWkGVNw7bzRD2HmLt9dYeaSWSpIrtp1GSVBZduSotio/ACrnkbt4NCM+rnT59RMkVu3td3WXPR3/ZPzphYqLYwV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SMZnxa3r; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVl+/wjZZXwnSHUTHWWhcCjfjXc/dlkMP+/9ljXbHG684qFh7QNjQxRdnvxxvIlcucWvbbo9khsNAcwp5Wg5nQcVFd195czCZzz6fQbIo9p1qStten0EufTJddpY9ECUKwhUKwFdxNRwKqj7Cl0trNr4YnDdTMYwU/MtMbxm3Sd/atkhOwjZFQX3of2HJJ9b6mMoYf+1GF0KOe/iE9r3NY2Gdv2jvB9U6SMWe3gr/uXP1xURLEC5rHzsY4hYkNL5UBtnh3NfF3j0w6i0Rt43e7kJL7juaCcoFF5+b8yoEUxASv23IOalLUI4cUBc7fF33YfhKQFJUb7LnRajzw6VtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf0ZzZdB4XInijhMbuRoUauqMU8CvI+w0+sh2aLQp3c=;
 b=lJ80V/CL/+E3ERiL8092arMmFUyiJKieRZ53cb/1X3xTKdSlrElZ23RZB3ysqeioofUoCQDgWf+zhJYT7GrYynUbV3yJebzEKX7sKzsiWuMmZ+d20WbozCgLZ2v07LYVQc0Zsn5yMzYq2uLxiKkJpDavip0Ph+Q9o+/PZJaPBWJe77fBpE3Sj95/ieXaMg9xar0gUlqK+CnPm/27KADy/WnPXpaKlFdIwEmNIsXpWRTBWRLQgxQC4MZIbKhKMEzDkwISmgB4rg+fJmc1yjSvtzYOdZOlkME/rDdsspTKUfkzM2QXxogJBlNuo1/pFGyeu3f4PnI62G3NOZRrpytL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf0ZzZdB4XInijhMbuRoUauqMU8CvI+w0+sh2aLQp3c=;
 b=SMZnxa3rDkbVvPNmDOFoC6AmdV/y38gUjiCYBxJiz0eznUjAFXT1d3A8GpTIWweGMcXOsDGUjBS8AlLnEHMiawthdUfIFGQ9pjquiRIOvqOoKtFratYF6agg7AbEZLZp7mInDyszJMHkOK2RE2hg0MzuOz1Rs886DVQSgJSYDpH3OPprfO6bnZ5T2ur8Ye+zq1+239W0uuAfSI6hfzIG+lIfcQEmhE6bU2UZOlAYCqiBuxvDInQhseOzx36wQ89Vd3+KqW4vYqgVKAzPfNnNN8ADVPQGIn35S4YlOa3ekOU+8mXrrwtwSOsOLoqfQ2vSYuAIMX+1OmiB91SP2JHPUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.26; Fri, 28 Feb
 2025 00:26:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:26:40 +0000
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v5 1/8] fwctl: Add basic structure for a class subsystem with a cdev
Date: Thu, 27 Feb 2025 20:26:29 -0400
Message-ID: <1-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:208:15e::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fed21a-10ea-4edd-e5d7-08dd578e9102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PtbgVcenRlrfvMEzdKz+8RrCOQtykgtmP022Jv0xvIXhCIA6lGQZCHVT1CRd?=
 =?us-ascii?Q?IVpk66EgvGrFhjCZ7DdyBIiqO0nLqSpeqqncUISPqUlcnrUuHvaJIQOfLQ09?=
 =?us-ascii?Q?UdIfUzIT6S3klJrg9SQopoijt/0rG4aJM57vkoK4TDDPZjchjga1gf4m35Tl?=
 =?us-ascii?Q?vawFyzlx1kyQ3tpDIlde2TJUauf2EYikSprkuloN41NfV0anrw5I/LyRZPrN?=
 =?us-ascii?Q?3ULyOzHjFCi4PIEsY21/NME2u7vBfsEyVKGzTwyq6llj+gHXa8M+RHsAPbQh?=
 =?us-ascii?Q?2PViR+PDeTh8Vk61aMXnR3Tiag8rrYuN5syZWIWpHcUWxJoxFCVFNFflCEZe?=
 =?us-ascii?Q?QkdKMLqV5E7UXi55f/MYCDEBNoJWvAo6Eupq2ceyxXG6qfHEyTOme24gZzc6?=
 =?us-ascii?Q?3su0x9IihZfAfbFnV8qruYCdGkEsknRZqeCN/uBL/7qffpWtH6ft+LFO2moC?=
 =?us-ascii?Q?8YcjXnlIngXZ5AimdftaX/W38KVu+wowL5ccqvplA0GVCtVXD1f7l227gKcv?=
 =?us-ascii?Q?aH5h7CDkiT2t+ea771prUIqPOONNvKuLOAjRlS1vcL7rikGUZ2hiIoMQzGI7?=
 =?us-ascii?Q?MK9wrYyKDXP848eBX+Ou6tvZDNzUQ6iAubfX/v3iLjavtZW5ZJ/2Xd32pjz1?=
 =?us-ascii?Q?tlEPstoU+yjG17odXUynC9TMASpuIAJcFSYntXjsuqMzCEgXtpGg6rPSYNJ1?=
 =?us-ascii?Q?Y53eXwrFNlMBu9h86u2IYdM4QQ4SM7SgYeyG0/fVRLYjbJo2hufhayjiFZ9A?=
 =?us-ascii?Q?5q+5gcauN34V/o58Z5MARLguuDcnUVkIeDkdH+dm6GwY+iCfqWDbFuVLcoip?=
 =?us-ascii?Q?+RM7ocPMOpFmsyP6bTxTHRQYf9GIye6lRP5HWSTCJzD9uX3NeSPbq6tAb9gp?=
 =?us-ascii?Q?tiKb9yWoR6GSF/UDRY4IUS+A/LJVkl1xakf94XYbifW1p1g5iuK57GvJFYCN?=
 =?us-ascii?Q?wXKxoVdgnqB7YQ6yxOkjHj1zY62WTVaqCiaivcNunL8BtccCBh2HDBFsRsft?=
 =?us-ascii?Q?//TNtsQvoFOib0IOBetogOFdVHwIu09or/ke9WKJoIcBkzwoJ5VS6VMw8Hxt?=
 =?us-ascii?Q?qZXFTfsAw+EpxVCKzzhvX14XU333Y04Dl9+7Yoeh018noGqBUNz1ih2TNbs1?=
 =?us-ascii?Q?qMWpyg+57qmnR+16sovH7482anO4G58Mr7mBtYN9UAWDEbXuIihMpKr5Zj/3?=
 =?us-ascii?Q?k2MenIVOM5txNTO/aUBs5KYlVIDJJ10fJk+ldmlolaDHzdcjo4Fx4RyQ35kk?=
 =?us-ascii?Q?Ks0Lc30nnRrJhVwqjsDvrtpwpjdTv6bM/8/JeqclgokZhQ64V46KGwm4O0xv?=
 =?us-ascii?Q?iIdNVVzJdPDWL73irTbv+Jtqgfy28eIZtgN+hkGj5Y5acJ7Ooqxl7sfbOyPq?=
 =?us-ascii?Q?DAsFkEa47rAvR9qfyI1ZAtjeV7z0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3RzsPwIXe+kpFUEI7FrH2RN+LRcN1MqwvYAYRo0akjfQo8l7MWse/IVjYFs3?=
 =?us-ascii?Q?lxK1rkmqcXXuGCwrdbo/UJYtsSCeLQ8G+4HAsLnyI5VwPNiu0BdraJW8F3Af?=
 =?us-ascii?Q?JgW7YfiCz7akhTnvleSKrPZX16LUZwOerlzdwKUrkFWntBC4/5z7KK5Ez9Js?=
 =?us-ascii?Q?Vfszp/wyxaf89WgIv/Zc3BESBIaGkhN/zokF87NMaV3NteY8r49nu6eqFmwG?=
 =?us-ascii?Q?xPQVG1aZUDYttGwdNvAU3RFlX+0/C58+HnZNmHy9/rEViHx/BtyCYG/vG5qy?=
 =?us-ascii?Q?OEr09+HTMjN7tHKYOJ8WzGQ0MhLsLr5ZVmj6ftqCmqMeTgxGcnP/ZsyVPUjl?=
 =?us-ascii?Q?POq7JEGucMqiCO0VRyTgr1oaBPnN7cqW3vxmi3Kmrj4GPZa+M3Atq4vXNOyw?=
 =?us-ascii?Q?JdwpDJAZS2zVKjW7Lw2JYgFMs+cV2avr4IlGlrUjzekPayMi3sg1umbW9RLH?=
 =?us-ascii?Q?hE/N23Iuj51vxghftriFzqyvUVRY1ddNGxvJhhlcQvhs+pswW/d4HEyhnllb?=
 =?us-ascii?Q?8LhLwRO+y2pyRzUyE0sZU2nyQMPzWe5Qf/y3wnPS6oUNUji4s9oCFeJVvUY1?=
 =?us-ascii?Q?BrjZOAkR27IVBdG8P08XGfuJFKe+HZorOmyZWf6AXMSfKCzAg1IzAPlc4kIi?=
 =?us-ascii?Q?MEQjjR+2Yo95jspiV87BK1oR9yj5ofz14JcXMRUNrHurMGA8KAaQJIcsdZEX?=
 =?us-ascii?Q?NhEcbiiXRcBxSAZtZEGPw58Lk03xcGMh6MBL6S4W7ohae6kuyCOnKOKtGUf/?=
 =?us-ascii?Q?eXHCiybTNUVaPy5sS36XCDDHvfkh27hRc5jLcHKXbw/VcZ84QKOJq4OzTveq?=
 =?us-ascii?Q?++nLwmHFphi2oF3Wr3sPZ0+N61jkVty+gNZ9Ouc/Bugyn801VQwnJ3dgEz1S?=
 =?us-ascii?Q?v261u8OdLWZB46rKSNvzqT0DbEwyGsuSJCdXjciSk61Qfq2fSkp99WRozElC?=
 =?us-ascii?Q?c++L82mOd5YqviELFItiCzSXSsFejOnn1fz1HK7Tka1rdmoz+KdEo46lTB2B?=
 =?us-ascii?Q?CcCSnTPqpnT/585FQgZbDmJC+ukDDN4XyYcjkYLE+FBfLh/oci6iBL9EqjyI?=
 =?us-ascii?Q?xOT3wVA3JHE/FfSR6dYKOdjE8oJ0BEgV8EH+PfmVPCWCRG85tz6DYIpajSqW?=
 =?us-ascii?Q?8z8AWFP12ADcn5zVd2qmwk8bNDg7HwwHrD10Y/abaqQPMwf7NszL7XUkWuDj?=
 =?us-ascii?Q?Y1aTkLGexHgBR9PLYfDpuYmxOcZcPtBbGustO7XV7eR9D51fSJNmrkWaD69h?=
 =?us-ascii?Q?NYLLZZsTrIwstEakEde0MyIJrlgeU5hfEvcIZ9tOyusWhrhTWr9hzbEK6oSd?=
 =?us-ascii?Q?Dz2u8ZP5rwCaGySZxGZz4P0uPhae0bx56kcDA0RVBVs+IMD8oAye0Wah/jlm?=
 =?us-ascii?Q?/EJAtZZCwFyIuexoho6VTjHICWjk/HjSySgIEcCqx2NFRumnVFtQkKVKilFo?=
 =?us-ascii?Q?3ktkRZxmPzkkUbS/TTZDQOcZ2QfJYZLnAQSDYWxlXasiSWMgOKTRLIHb6LZ+?=
 =?us-ascii?Q?0W+eovIR0UeUsostLybeiNjzv5EQ1k7kgsSmUDQjZy29GhRxvqW7AczNvuKJ?=
 =?us-ascii?Q?ZYGH9/mxgoSwz1YYsMcTZ4sReteW2OZ0gd29in22?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fed21a-10ea-4edd-e5d7-08dd578e9102
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:26:38.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5i1md0bgQeomOUVctsiaZFofEXUEMfrNT97IMdOXxNIfQ9Pt1CC/NI/CtDUuD9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 MAINTAINERS            |   7 ++
 drivers/Kconfig        |   2 +
 drivers/Makefile       |   1 +
 drivers/fwctl/Kconfig  |   9 +++
 drivers/fwctl/Makefile |   4 +
 drivers/fwctl/main.c   | 173 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h  |  69 ++++++++++++++++
 7 files changed, 265 insertions(+)
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 include/linux/fwctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa06545..1dbf0f216f9936 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9557,6 +9557,13 @@ F:	kernel/futex/*
 F:	tools/perf/bench/futex*
 F:	tools/testing/selftests/futex/
 
+FWCTL SUBSYSTEM
+M:	Jason Gunthorpe <jgg@nvidia.com>
+M:	Saeed Mahameed <saeedm@nvidia.com>
+S:	Maintained
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
index 00000000000000..76c4edec20afde
--- /dev/null
+++ b/drivers/fwctl/main.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
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
+
+	fwctl->dev.devt = fwctl_dev + devnum;
+	fwctl->dev.class = &fwctl_class;
+	fwctl->dev.parent = parent;
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
index 00000000000000..39d5059c9e592b
--- /dev/null
+++ b/include/linux/fwctl.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
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


