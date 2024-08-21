Return-Path: <linux-rdma+bounces-4465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13AD95A47C
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AFD1F22E27
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABED1B3B20;
	Wed, 21 Aug 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oh1Gzt2X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1601B2EEE;
	Wed, 21 Aug 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263875; cv=fail; b=fxrTL22tgzTGmPcBQcKUIa/xZOHwi1fhh9R3ku36UFsPcO5GYU9U85kEmlQC2QH4G2P5nm6Ysmzp80KMnNEVj1At/khXx7dmEvlHMFveOlP0dyzq74yo9vBs1T7YjqKxCOd52puhtpDV/KvpkabOneqSU/XE63kvX6oCUTHpnms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263875; c=relaxed/simple;
	bh=GYGp/T9EfUE2ityxYAQtDdxdxyXWfnoiIhiDWurDZ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=So936qqHaZkOT9PCe1QEPu9oCNe8/pLqUSu34eWZ4hHmOl0a9Jw2TgMlp9mmKfPaJFIA0mvo92RboVclOpprSJrqgrmB8H3mXvcn4yXab3uBsQA39I9+PdD0iwSmGP8dxpPIkQpke/WzfEx41URANsE+AbA6uTbiPqIcGJlZTkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oh1Gzt2X; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki20pFgDyVA9UgUJQ388mF4142ytUiebg0rH94M60gmeWfue0mrWRYUTOTR44GtCDKMS06qoJSU1N5xuYjoXwmQibLAlbbl1dIFD8NiTEo4jezdG+3BVyrBQc2Gv8DsflFaFdU2rNIJX8Yr1pFTUpZ3l4LAG9yevTZn56Gk8UPChE9paeRpIceecGKD23MnspS15bAvLePCYzGIrHDahh5X2xhLzu45jJRP08Sud3AU/UTzZ+UTLFfdzzIKn9hH9SKP+nckVuxzH/CnUdmQHDyv2tjhQ0Me/wDnu+f1lxtuxY+uUuw4VsnawPAp3BzmnAS29b5nz0ecJ6GKbdrMaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2o3L4w/+KbG4jKblR2NFAvATq1v0LB+vLmU9D7lv2k=;
 b=SM2Ur1q1qW5tpziJzMABklZmg0FGBGaE+Tj4wfFChjec+aECFaNJDWuWZJF2cQqGXo3Tw/JzAQsZZ+LShPIa5xbLAp5DDSson/Mth9hHu0J54v1pJ2XB9vEo3kFt8mz9Ulmz/WF1zuBqmROtoznmdDbMDh0Km2xiWweas274cW77qrSDhwG7FmjcC/pPRE/otK1XpHmwyJzxX1fW2Yhw6wBuCVQUpC9Rd2VmF0kp+xMe+GRyvj6GPDr/CPccA0ALHyGBNLHPqKRuhZVxTzDKgEPAArzqpFyYbX3vqy9jH78rpcyohVj04fJipXg+4OHlVmXsrQCYT2ujfVxgiNjCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2o3L4w/+KbG4jKblR2NFAvATq1v0LB+vLmU9D7lv2k=;
 b=oh1Gzt2XYvESoSNt2Yk0t1oVjk/gLX2Q4cbgxB2k7bukO0pMFonxfXF9iarA7CU3DECPWVnm4a1JVNa2VUf9iSEIba+uiY8O2iv5osbbV54Y7e7f7YE5lwY21rp+kUZU8R2wvtgRDc2RZRXd9Id8ug5f+SZM/P1KZ+U17DGcE4c79r5gIHNoRqfRNNuXOebul4gHWUMr5AS9T+Xwx3DhZISA32h/P9owV++TSFV0rXHbh62CwwWgr/P3FWPnRpTPHoUcpMKzgc+rfRo55rf0B2Ew0hlyA63z2OPdrcHRKkstTD4rbGooXWP6jPkDKn/ZUdKGCMar1ptpn4i97Yl5BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:04 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:04 +0000
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
Subject: [PATCH v3 02/10] fwctl: Basic ioctl dispatch for the character device
Date: Wed, 21 Aug 2024 15:10:54 -0300
Message-ID: <2-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0927.namprd03.prod.outlook.com
 (2603:10b6:408:107::32) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ed9aa4-287f-4df1-c062-08dcc20c9e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tIQgqHM3IzLl5RUmBR8kLlEL8+plMFhhTic0cEIKdH1oQ73i0s+70gjhT67J?=
 =?us-ascii?Q?s2e2kYWQAh9KanpL2Hc0fgOKPnJYPK7I3HsoD1x3PKvFoAb0Aadyy6zZWEdx?=
 =?us-ascii?Q?L5aD2hptSa0XGdQPVA+VLPXsNvrh4z512Zh8/AKboPDnP5JwiOKn6jS7NutV?=
 =?us-ascii?Q?ziDRtUtLzRESjtC8ZpcTBr2XpFbYrBG+fuXAhAWuRuwZqbU2CwMKsdtdYQNs?=
 =?us-ascii?Q?zoCo+gtj0FETSq9ZgaDfjJfigtP6Pq4kb0FDF066h7voi7XD7reQIsM5XStd?=
 =?us-ascii?Q?rr9kML/u5IiQxtRUx5rCikeyk+ANRlVs+lNH6vdy6xLdErizYb36aigm4ile?=
 =?us-ascii?Q?goFBCLN7eOUq7umzyFz6XP2+C8AQ+EowrWLe3qYOcBS7sYCRDN4SuAr0a92x?=
 =?us-ascii?Q?TsQjgJfanL+wwcZMvJRq3APGQT58uvT78NaeO35aODP9zKkxqnw5KMIy+DyH?=
 =?us-ascii?Q?q+GK7s9wLy8B9f2M8uTD39OLEtahtwhREJ4xmXkMjV9y+4aXwwzqSdjMiHZl?=
 =?us-ascii?Q?girmh1txLT3lSDefvorR9caMA5lsdzb1Xxy4MZNsCd2vlKuK1K0+m+wzLclg?=
 =?us-ascii?Q?YN6Ix63Kf55s1Cy0YVPrQDvv2EUIS91NTl2SZj4pMf/arjW3byQNw33grekr?=
 =?us-ascii?Q?EvF8aqNoGndaT00ujqvXxzNxstcxAQNwPBnaqAzQI33Kry6b38bHF6RlriO+?=
 =?us-ascii?Q?KRbTLYT2OE8CWkwqE5rqGLDETJrsv4KAovvm/d94Tx/oTQKxmQHmbfTHQ+uB?=
 =?us-ascii?Q?83CQT8jGj+UhYFF0eOR/U40OiBfrzOFPapZW1myBv42jbdZLGw3LbFb6s151?=
 =?us-ascii?Q?sMNGb0b0f5mAV5Ddl0UIAS3kl4SQxnWxcQBefMgS5a+KZLAcpGJq4tRG+lVp?=
 =?us-ascii?Q?aZhOWdHuy3+55T6jSOakC7z8ZNghDDWjq4aRNYq0bXB6Fqy1NJ4H41gQ6tr2?=
 =?us-ascii?Q?mUAVnHN9v06r3IVt/FsQAcgIHdT5oaCgCa8i2E9CSl3NGkLmXl8tJoB7KLa0?=
 =?us-ascii?Q?sZTg0/BipoKkL4ovZbsM5chZMdd34gFyFk6sipcKyoJ/X4JkaC8/VaFHbDiA?=
 =?us-ascii?Q?qeKsB/m6sXit9PaWdtE1SzlZYyn6VetTfJnRihtNtyHABJOuJXM8tIKRy6Sf?=
 =?us-ascii?Q?jOWLN5i4Z5Ei5uu5nI0InVC961kAFsBngXOhSh5lBT+NEiaNojjq2UgmgTc2?=
 =?us-ascii?Q?Re21VZsXtROWla3vE1B4o1Vxx3DOuVXlvpTtphVqqOUbZFxuUS5PvPwjw9+5?=
 =?us-ascii?Q?ey8zkBN9WybjnzbABR6RTUyCANBhxWuqiFdzLqbWjdEtqxpcDOi7tp3kfjLi?=
 =?us-ascii?Q?KguQo2WrDPDGct4Ak/sY4kIFY91/ZZTY6Jnxu5IYoL7zUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9QHGM6LCMHEbV4hCFW+5051I+Ty0Nvnz1f2qD4Go3EGLK6neKLQzXx/j6OZf?=
 =?us-ascii?Q?so1DxWMmYMtiZmALy5rPHXaZe5dhJLLFgFHpcaZncI+ksZbTORYiUVJoUYqu?=
 =?us-ascii?Q?l0WGeWBNvyLKODJCz87B369TGx0FQabd9feltyv/tyqNQc3HzVE02NIJSrj/?=
 =?us-ascii?Q?2xdPoFYnYRQcelF8EMY1Z/0bEo4CqlSE3NqKNTmX1/hWSP8lBWHwnySmbfbs?=
 =?us-ascii?Q?2Pl9u0Znf7CvfDQnVlnRVmDmO3LkgakObmkeGC8UptbFJGe3aAF2atYrK4sw?=
 =?us-ascii?Q?PotXnhHgW8IUzUfNEqX5+cS6iStbuq+5j6f5/kgoKi+4hNCSc4ewwqBYFK+r?=
 =?us-ascii?Q?1yxzJwXyjowfK0w/I200MiADKYUAZb9DUq2kklT0mRB2PzBkF50JjcjiSEz6?=
 =?us-ascii?Q?5BzymsJ8cHNeqXeAlEpyIKcEdyhmfT3BnZmVieGyKpAgbbH99N72sQQGt2C9?=
 =?us-ascii?Q?lh39RRWV1XFDnSx6R6srmsc7FHaAKl9V0bwvjk/xHV+r/BiKDiFMchHrlRtJ?=
 =?us-ascii?Q?4zKYNqYS1b/KowpuyHWi1d6fNJrfyj68tygc4tSl2lX3AjZRvp6aRtQnJk8E?=
 =?us-ascii?Q?xmupb1M06zgJhNyR9135e7jkqVw4vzavQ7bJywsrxLlTV9DcfWxbPrS669GW?=
 =?us-ascii?Q?YQlP9M5UKpW9xYS+DGZireHmJnGKdK1vw6DTcJ9R+0Yn0HLPF6SXaLrqT2g1?=
 =?us-ascii?Q?M8C2/P/MzqTzlNav0WyXSm76GiPmeMoRmSmM84RI0qgn5VVDks6Foiyi1BjV?=
 =?us-ascii?Q?vqh4lCgrUmqHZhbuYBJ3/7DYeci4zhu87sTsHgZ4dQrjtJ5g7TfYdkctXUa+?=
 =?us-ascii?Q?0uQn+kjsymT813wAp2KUwoemHCajM9uhYx+vFAAM6ocSIu7MF4gRA+ML2mhG?=
 =?us-ascii?Q?epXea/61BuXKIqDPT7XbWGSd396SNriI1nyVz5I4d0BXzBNuAM95RG2CXJq4?=
 =?us-ascii?Q?oHVOqlQ4ngBhCQcmXl4nUZyYv1UoflcrSPVitdkLxgApW9GW8Zvau4rdUsAd?=
 =?us-ascii?Q?YAHNa2tYKRjhYdcpSru9+psv1ahZv6qtzA51V8XFmm82dabCQdsOR8+3L2JY?=
 =?us-ascii?Q?MbNdoQKD8f/ttHC4BzkiUnnDlELSw9qxGB99DiYtGBa4ypYKsmXp3BBEGTs5?=
 =?us-ascii?Q?vLvAJB5Bn+WAKVClejJZHQ0rC+Tzm655eckxUzp+hj7meU6g5wos64eVKV53?=
 =?us-ascii?Q?UQkmbMULLd5auuAgHF0Va+GbgMNnhBl6Tyq42FM2TRS4SEqxpPGvNi43qgmR?=
 =?us-ascii?Q?19lbWvxdyebWcmSwsb2F6wk3digg2OTviuZjAK4c5Ga7j8KjDwB/WlichEcB?=
 =?us-ascii?Q?B/u8E+tmNNLizAKNaUkifOqlIWqf52pvbnJ6vnrPQUbB7ACMP2TwQR48CPP3?=
 =?us-ascii?Q?X1Ia/Lan9sd4lT+/wPCMUZI8tT02M/WhAT9qYSy3Zi0p9QYgqpqo43H0TI2a?=
 =?us-ascii?Q?RXkZamftL6u406efRXKx+FDCxqAcx/ty8+Uka2c1EV/LuCz7IpA/sRZrrcJW?=
 =?us-ascii?Q?rRggp/vL4Bw9hKm2mx2VptNAOwCpjgeXFrsQkIFpEMa5k6Rx1cUuh2ZNDpIg?=
 =?us-ascii?Q?7wp+CPM22G95x6PavBAhDSQjckJKxAcTjDd6ZLoW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ed9aa4-287f-4df1-c062-08dcc20c9e3c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:03.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01MmbLfwzdYA278Riqvbswu5Z/hBWDaM/JREELsRNVWTkkbLkIgoHEBmVOsTzzGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

Each file descriptor gets a chunk of per-FD driver specific context that
allows the driver to attach a device specific struct to. The core code
takes care of the memory lifetime for this structure.

The ioctl dispatch and design is based on what was built for iommufd. The
ioctls have a struct which has a combined in/out behavior with a typical
'zero pad' scheme for future extension and backwards compatibility.

Like iommufd some shared logic does most of the ioctl marshalling and
compatibility work and tables diatches to some function pointers for
each unique iotcl.

This approach has proven to work quite well in the iommufd and rdma
subsystems.

Allocate an ioctl number space for the subsystem.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/fwctl/main.c                          | 139 +++++++++++++++++-
 include/linux/fwctl.h                         |  46 ++++++
 include/uapi/fwctl/fwctl.h                    |  38 +++++
 5 files changed, 223 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/fwctl/fwctl.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e91c0376ee5934..c581686451fb1e 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -327,6 +327,7 @@ Code  Seq#    Include File                                           Comments
 0x97  00-7F  fs/ceph/ioctl.h                                         Ceph file system
 0x99  00-0F                                                          537-Addinboard driver
                                                                      <mailto:buk@buks.ipn.de>
+0x9A  00-0F  include/uapi/fwctl/fwctl.h
 0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
                                                                      <mailto:kenji@bitgate.com>
 0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 2efd8d14495431..97945ca04b1108 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9248,6 +9248,7 @@ S:	Maintained
 F:	Documentation/userspace-api/fwctl.rst
 F:	drivers/fwctl/
 F:	include/linux/fwctl.h
+F:	include/uapi/fwctl/
 
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 7f3e7713d0e6e9..f2e30ffc1e0cb5 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -10,26 +10,136 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <uapi/fwctl/fwctl.h>
+
 enum {
 	FWCTL_MAX_DEVICES = 256,
 };
 static dev_t fwctl_dev;
 static DEFINE_IDA(fwctl_ida);
 
+struct fwctl_ucmd {
+	struct fwctl_uctx *uctx;
+	void __user *ubuffer;
+	void *cmd;
+	u32 user_size;
+};
+
+/* On stack memory for the ioctl structs */
+union ucmd_buffer {
+};
+
+struct fwctl_ioctl_op {
+	unsigned int size;
+	unsigned int min_size;
+	unsigned int ioctl_num;
+	int (*execute)(struct fwctl_ucmd *ucmd);
+};
+
+#define IOCTL_OP(_ioctl, _fn, _struct, _last)                         \
+	[_IOC_NR(_ioctl) - FWCTL_CMD_BASE] = {                        \
+		.size = sizeof(_struct) +                             \
+			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) < \
+					  sizeof(_struct)),           \
+		.min_size = offsetofend(_struct, _last),              \
+		.ioctl_num = _ioctl,                                  \
+		.execute = _fn,                                       \
+	}
+static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
+};
+
+static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
+			       unsigned long arg)
+{
+	struct fwctl_uctx *uctx = filp->private_data;
+	const struct fwctl_ioctl_op *op;
+	struct fwctl_ucmd ucmd = {};
+	union ucmd_buffer buf;
+	unsigned int nr;
+	int ret;
+
+	nr = _IOC_NR(cmd);
+	if ((nr - FWCTL_CMD_BASE) >= ARRAY_SIZE(fwctl_ioctl_ops))
+		return -ENOIOCTLCMD;
+
+	op = &fwctl_ioctl_ops[nr - FWCTL_CMD_BASE];
+	if (op->ioctl_num != cmd)
+		return -ENOIOCTLCMD;
+
+	ucmd.uctx = uctx;
+	ucmd.cmd = &buf;
+	ucmd.ubuffer = (void __user *)arg;
+	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
+	if (ret)
+		return ret;
+
+	if (ucmd.user_size < op->min_size)
+		return -EINVAL;
+
+	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
+				    ucmd.user_size);
+	if (ret)
+		return ret;
+
+	guard(rwsem_read)(&uctx->fwctl->registration_lock);
+	if (!uctx->fwctl->ops)
+		return -ENODEV;
+	return op->execute(&ucmd);
+}
+
 static int fwctl_fops_open(struct inode *inode, struct file *filp)
 {
 	struct fwctl_device *fwctl =
 		container_of(inode->i_cdev, struct fwctl_device, cdev);
+	int ret;
+
+	guard(rwsem_read)(&fwctl->registration_lock);
+	if (!fwctl->ops)
+		return -ENODEV;
+
+	struct fwctl_uctx *uctx __free(kfree) =
+		kzalloc(fwctl->ops->uctx_size, GFP_KERNEL_ACCOUNT);
+	if (!uctx)
+		return -ENOMEM;
+
+	uctx->fwctl = fwctl;
+	ret = fwctl->ops->open_uctx(uctx);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &fwctl->uctx_list_lock) {
+		list_add_tail(&uctx->uctx_list_entry, &fwctl->uctx_list);
+	}
 
 	get_device(&fwctl->dev);
-	filp->private_data = fwctl;
+	filp->private_data = no_free_ptr(uctx);
 	return 0;
 }
 
+static void fwctl_destroy_uctx(struct fwctl_uctx *uctx)
+{
+	lockdep_assert_held(&uctx->fwctl->uctx_list_lock);
+	list_del(&uctx->uctx_list_entry);
+	uctx->fwctl->ops->close_uctx(uctx);
+}
+
 static int fwctl_fops_release(struct inode *inode, struct file *filp)
 {
-	struct fwctl_device *fwctl = filp->private_data;
+	struct fwctl_uctx *uctx = filp->private_data;
+	struct fwctl_device *fwctl = uctx->fwctl;
 
+	scoped_guard(rwsem_read, &fwctl->registration_lock) {
+		/*
+		 * fwctl_unregister() has already removed the driver and
+		 * destroyed the uctx.
+		 */
+		if (fwctl->ops) {
+			guard(mutex)(&fwctl->uctx_list_lock);
+			fwctl_destroy_uctx(uctx);
+		}
+	}
+
+	kfree(uctx);
 	fwctl_put(fwctl);
 	return 0;
 }
@@ -38,6 +148,7 @@ static const struct file_operations fwctl_fops = {
 	.owner = THIS_MODULE,
 	.open = fwctl_fops_open,
 	.release = fwctl_fops_release,
+	.unlocked_ioctl = fwctl_fops_ioctl,
 };
 
 static void fwctl_device_release(struct device *device)
@@ -46,6 +157,7 @@ static void fwctl_device_release(struct device *device)
 		container_of(device, struct fwctl_device, dev);
 
 	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
+	mutex_destroy(&fwctl->uctx_list_lock);
 	kfree(fwctl);
 }
 
@@ -71,6 +183,9 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
 
 	fwctl->dev.class = &fwctl_class;
 	fwctl->dev.parent = parent;
+	init_rwsem(&fwctl->registration_lock);
+	mutex_init(&fwctl->uctx_list_lock);
+	INIT_LIST_HEAD(&fwctl->uctx_list);
 
 	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
 	if (devnum < 0)
@@ -127,6 +242,10 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
  * Undoes fwctl_register(). On return no driver ops will be called. The
  * caller must still call fwctl_put() to free the fwctl.
  *
+ * Unregister will return even if userspace still has file descriptors open.
+ * This will call ops->close_uctx() on any open FDs and after return no driver
+ * op will be called. The FDs remain open but all fops will return -ENODEV.
+ *
  * The design of fwctl allows this sort of disassociation of the driver from the
  * subsystem primarily by keeping memory allocations owned by the core subsytem.
  * The fwctl_device and fwctl_uctx can both be freed without requiring a driver
@@ -134,7 +253,23 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
  */
 void fwctl_unregister(struct fwctl_device *fwctl)
 {
+	struct fwctl_uctx *uctx;
+
 	cdev_device_del(&fwctl->cdev, &fwctl->dev);
+
+	/* Disable and free the driver's resources for any still open FDs. */
+	guard(rwsem_write)(&fwctl->registration_lock);
+	guard(mutex)(&fwctl->uctx_list_lock);
+	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
+						struct fwctl_uctx,
+						uctx_list_entry)))
+		fwctl_destroy_uctx(uctx);
+
+	/*
+	 * The driver module may unload after this returns, the op pointer will
+	 * not be valid.
+	 */
+	fwctl->ops = NULL;
 }
 EXPORT_SYMBOL_NS_GPL(fwctl_unregister, FWCTL);
 
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 68ac2d5ab87481..ca4245825e91bf 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -11,7 +11,30 @@
 struct fwctl_device;
 struct fwctl_uctx;
 
+/**
+ * struct fwctl_ops - Driver provided operations
+ *
+ * fwctl_unregister() will wait until all excuting ops are completed before it
+ * returns. Drivers should be mindful to not let their ops run for too long as
+ * it will block device hot unplug and module unloading.
+ */
 struct fwctl_ops {
+	/**
+	 * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
+	 * bytes of this memory will be a fwctl_uctx. The driver can use the
+	 * remaining bytes as its private memory.
+	 */
+	size_t uctx_size;
+	/**
+	 * @open_uctx: Called when a file descriptor is opened before the uctx
+	 * is ever used.
+	 */
+	int (*open_uctx)(struct fwctl_uctx *uctx);
+	/**
+	 * @close_uctx: Called when the uctx is destroyed, usually when the FD
+	 * is closed.
+	 */
+	void (*close_uctx)(struct fwctl_uctx *uctx);
 };
 
 /**
@@ -26,6 +49,15 @@ struct fwctl_device {
 	struct device dev;
 	/* private: */
 	struct cdev cdev;
+
+	/*
+	 * Protect ops, held for write when ops becomes NULL during unregister,
+	 * held for read whenver ops is loaded or an ops function is running.
+	 */
+	struct rw_semaphore registration_lock;
+	/* Protect uctx_list */
+	struct mutex uctx_list_lock;
+	struct list_head uctx_list;
 	const struct fwctl_ops *ops;
 };
 
@@ -66,4 +98,18 @@ DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
 int fwctl_register(struct fwctl_device *fwctl);
 void fwctl_unregister(struct fwctl_device *fwctl);
 
+/**
+ * struct fwctl_uctx - Per user FD context
+ * @fwctl: fwctl instance that owns the context
+ *
+ * Every FD opened by userspace will get a unique context allocation. Any driver
+ * private data will follow immediately after.
+ */
+struct fwctl_uctx {
+	struct fwctl_device *fwctl;
+	/* private: */
+	/* Head at fwctl_device::uctx_list */
+	struct list_head uctx_list_entry;
+};
+
 #endif
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
new file mode 100644
index 00000000000000..22fa750d7e8184
--- /dev/null
+++ b/include/uapi/fwctl/fwctl.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES.
+ */
+#ifndef _UAPI_FWCTL_H
+#define _UAPI_FWCTL_H
+
+#define FWCTL_TYPE 0x9A
+
+/**
+ * DOC: General ioctl format
+ *
+ * The ioctl interface follows a general format to allow for extensibility. Each
+ * ioctl is passed in a structure pointer as the argument providing the size of
+ * the structure in the first u32. The kernel checks that any structure space
+ * beyond what it understands is 0. This allows userspace to use the backward
+ * compatible portion while consistently using the newer, larger, structures.
+ *
+ * ioctls use a standard meaning for common errnos:
+ *
+ *  - ENOTTY: The IOCTL number itself is not supported at all
+ *  - E2BIG: The IOCTL number is supported, but the provided structure has
+ *    non-zero in a part the kernel does not understand.
+ *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
+ *    understood, however a known field has a value the kernel does not
+ *    understand or support.
+ *  - EINVAL: Everything about the IOCTL was understood, but a field is not
+ *    correct.
+ *  - ENOMEM: Out of memory.
+ *  - ENODEV: The underlying device has been hot-unplugged and the FD is
+ *            orphaned.
+ *
+ * As well as additional errnos, within specific ioctls.
+ */
+enum {
+	FWCTL_CMD_BASE = 0,
+};
+
+#endif
-- 
2.46.0


