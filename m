Return-Path: <linux-rdma+bounces-2791-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949758D8694
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B668282E9D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B11369BC;
	Mon,  3 Jun 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YpSB7wC1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057813665A;
	Mon,  3 Jun 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430019; cv=fail; b=igcwcfRZYFLza0ACxkZQGdr9a8W4KopgxzS0WbBMcVrxN9OxP31AYAJPVBgiPWM0l/wezBcJ1gpCCI1uJRQQ19Pd8i/A7HmFcfbKDqOugb3qd0hhJ/lu4sch1fTtTE9+romzjFbwg4Oj9+NcmjWnh6BTipng3Oen/aVcDA3CxFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430019; c=relaxed/simple;
	bh=X16kVzG2cdReR3SAG+0d93wDvcaggVw9r52ivFCFr9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OCdW6lxPfDn33QPWln5768mPdpeEUjAILRpwaOBB8wT/E3OTfpojGIhvUTtZb7XLwUNk8rwC+Fx+hOpxuMMOZice2kLLTLfSAaitRebumMydTBluRI2IXsCEbcq43NPw0xEHkL16Q64cb8O4/EkfUK8jCMS9K8nrVRzKJiWJ2dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YpSB7wC1; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xib9Np2+nImaCW5AhrqCBMWKutbdwYSdmwGOLTkgDdxETiJlPUHGMAz3Ha+swSbikgNHGVnCdKDVZcQZGIR+RxUtAPlMhuuZ58lJ+eBuhJmQ6sPK5bqPKT1TyKcxPL/777vJXT079mNkN0Am4ku4qQi4fMb7ilBz8oAiZ4mgxHiwQ4uZNwKVk7BzL3DnqmhY+ACNaeeCHpI0Heq2f8HsvCNpOtRmk0qgIcnd7ei4f5+thHoJxGgTeelD2zLUchTmh9STvIL2/TzBreTM82HoryiUIefA2kCOWRW/vs7fOOVPzs5Q8PzrnC2uCDNfA2eHalW06dE8ZNk5P+Y7GzC0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6sEPwWFly2zmU3fxNKK8dKKfoblwv9qH/vtv4HC76A=;
 b=Bs59E0XEp0HFqvaLa039p0hCkqDAvNYr5wTdN7NVZaHewnToklDIKUiVja8JPbJKmIgtk4GinMRiWIJnlFYzv1ZaTy3H2v+bNN38bN4GRAr2DbJfeet+tzFQkPHRqjVwloMjEWj0gwB7TkCbG8aq5vrKi5ZtfWx/0v5fCyeFded0uGFn/KAQ/91m9SEHE7pBkB1pyoye9f4sfn6C03T7rFd56PcE4WY04jzsOkj81vqH8OPtfJ+12zN/Qw8K3cXaujGcfN34oioGcR9YtLzjhpNb6Rbbcsck/NU5sFLr0pc3vZ+53iJjxnDTaxsod4fFym2Jaiz+8AIs3+QSiW0unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6sEPwWFly2zmU3fxNKK8dKKfoblwv9qH/vtv4HC76A=;
 b=YpSB7wC1EL5GmcSuRe38qCJjQJWH1zlX7LiGlDAeWaVNStlJP3WkWKHrTD1O5U/slZZku16JLyYxVMIWs23f0TNYtGdyaGSTIm01vKmgcRsjRbtrUpFixNs7xxZboRMMnL+M/1Tgqlp/V4+suZZBgoSAowVxermj6dVSOvQSD/iA1OQWv72Lp4alNDW7VvnFe2CarEPH0VmsEPTmKctnfQZMBiKl6/zPUnuGwQ8MIFdUWATbaeLbNnNsh/pJvDu5gSowvW97b/ju5xo/47PMnrNlLaCctSmI7sU2iJyGbZWNqR1ja+kV87OvbRAZDZF9+soMImBsKFvnSpS/IByrnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:53:28 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:28 +0000
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
Subject: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character device
Date: Mon,  3 Jun 2024 12:53:18 -0300
Message-ID: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0e1e8c-6e51-47f4-8004-08dc83e54ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OVAYSdzz6t9ffV7VUEaLFQnLRg2zeE9FOId+zAhYBh06EHRkvIhLRLWNpulz?=
 =?us-ascii?Q?DR7jyejaEE5fyEAovqudZ3cga9b+y6b6MpuSg9p2AHg+NJC5RguLTUCz7bp0?=
 =?us-ascii?Q?jKxK7nCEJshlYkzftUcWX6wy6r43G6hRSrLLn3XTNA4bLzxQQq2TJfzFiVKc?=
 =?us-ascii?Q?5lxEHcJuOv3HSCUl68CyEhRJDOYFookhqDrCR8uuewugJaSmYD+m0avH+jha?=
 =?us-ascii?Q?112X/g9LuBX0Q9H2v9cHDN3JSvtju+lt6N0P/zFEbF1WtFV1juyKT3qn9SOz?=
 =?us-ascii?Q?/VXImtZMOERL6hKxPSmE3y+i4djoqAEgsCHEsSg8ZSN2TxVSWv20nf0N0wCv?=
 =?us-ascii?Q?9psblWIRO4cpS2jKRM8l/FR3gBeTLBr2J2FiDWS4yUt4gxIgCvCQ5hB8ajUg?=
 =?us-ascii?Q?Kjl69WbhaU9hQcIrYT1HAaFH6xnJzIbZN/BtpaSrh7S45ur220mYWHLO0Fze?=
 =?us-ascii?Q?nFeFPFUrwloa7p73uOU5o2bwQ9yHE0aj1/ES6TTz7wx7+v3EU64xYf03BBKr?=
 =?us-ascii?Q?V/S1cifbTz13uv08cfPtyFo8fTnh+31nFodJfVc7cIMedh4lZ7uSMDIX0mBD?=
 =?us-ascii?Q?qmHNuuum9nnZMo7aln73eiN9z6jSQS6sJcw7Syyt3ac3Y+jlYtuI0tiQnufW?=
 =?us-ascii?Q?5kcRrsvp/4ZITMAksP0rEtIW2LJYh/0hltNLWF1eLV9DZyvYutXewYU7slbw?=
 =?us-ascii?Q?Mm//F4vCEzF1iIqiDFNRb42oVPPFWv/D7883WDCYC1KLK/AKnOMwkNRlewn3?=
 =?us-ascii?Q?ljwNFQiJrKtfMawN/Em9eZTzeSJMF7p5chzYjmTCqGK7tk1ugY+UiJLT8cUS?=
 =?us-ascii?Q?HaGoCe5GwqSEOqbjr4+4mpcPBq+n62j2GOGkVFBRdwFXGw0GAOlRMwXdMafk?=
 =?us-ascii?Q?GL1U9D5TUMNQ2NUQ5jc2HqmwH1rpdJ+YTKJ0a4KGXjgJHMrAbucVUeQnomHc?=
 =?us-ascii?Q?7pNYLLFNm6gYSmtbf/L3LoclhZ0YsrC/SXHq9csWF28NJPskJlc5PHkHodP7?=
 =?us-ascii?Q?aJ2YQIqBP5i4ftmuOvrsnbdUcle3qKnL2TZiAiVw2ftLIJJ84Sb2zpdBtNdY?=
 =?us-ascii?Q?iYSiU4h+RFyoFqPJvrVCwxAHexRFfLYM15kJnVuYKZcxUv8k9BtKeayvWoj4?=
 =?us-ascii?Q?dYqfrRAr3fDDYSz2HlTxwJMph2l75v2CQ5qcxog9RCGlqZdJEh4RuNtErKU1?=
 =?us-ascii?Q?qCLrGiVE7BTp5xE9TYuuX3uqghVUPcZlFItwbBf/u0WIMX3ZYjvyNuWnxXks?=
 =?us-ascii?Q?GjgqexIxd1AN6CwAP3j/4n/md0X6PV74K0KbUDZmSiy95VsepYYOdkjzO/Yk?=
 =?us-ascii?Q?eaFuYiLd7yUSdXQ3ht00r+6a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bqjl9v/xNE+cirxuUOJdM3B1Q3ViDTgpgtHD93agYTSIWBiXCJm76L8gSXFk?=
 =?us-ascii?Q?LF7ofHJpYOVdFv7Sxde5tLVH1IUJAhC9vs9HiPv64yB8qnNR2j6PSCvDJdxM?=
 =?us-ascii?Q?JBWBdQdlDARmqShwvExLwJEiaN77kYK63Cw+DiHjyWY9W9P68R2amIXYcpYv?=
 =?us-ascii?Q?K4QN/O0h6mTGztasCXD2izfbnLqHMfXEQwDqBlHAITqc3YzNfuinZKgkfT/l?=
 =?us-ascii?Q?1CpTrCJQ0tGDV675S3fq5DfwGwAUnH18PdVKkl8TLbrsPR4KnqZFS1Sdh/BY?=
 =?us-ascii?Q?/2S2S1fWoSGq4fJY+ox4CwfmL/Txq52NbpucB1KsT6svB1r0QieNpEz7BFEk?=
 =?us-ascii?Q?EPRPacSpTJgSBL1KfvshU4YoJtHJKzwRsQbsyuE1JSYYpq93wjfIH3RbyOoI?=
 =?us-ascii?Q?l8ih1p57p7Doei4ZMQU/l02qRSF70240clAbVNaYgZjWgEOeQNnkX4NuXn1Z?=
 =?us-ascii?Q?VbHRLH8ANARmZouYzpiBOadU15eXXZhfhua0bUXqm5/MHzrFZQCEglW/dYqZ?=
 =?us-ascii?Q?Yaz2XtRkrwh2uJY/razW8AWxnu1HhRh91+oTyiqmxfL+ynHlUputJCsX9MD9?=
 =?us-ascii?Q?LLgG8TemZwZ333geFPZPUwm61z5wBDRiiCuujDsC13qjas+evCqWfvgKxoRS?=
 =?us-ascii?Q?8L0th50WKcw4U3aGo3KSIWCv2RNhN/QJGlvFdPjRfHE3Xo9oQpJ0Htqt7sg9?=
 =?us-ascii?Q?VkGduz3yAHO0UU6ZxAX3wscQKsS2LSWTZKV1jo7k5NphAgN+CQuzcP8gpa9X?=
 =?us-ascii?Q?BeglMmEadSMco0l7DAFdPbIUTjeoeqe4xtQTn6XxUw/00oWe0Y9L4tAkvJsw?=
 =?us-ascii?Q?b1wq15NpejpDNLPfWX1GiM6t7+YHMgJxFi/09u7AUry+APGgyPf7sUQ6WJYk?=
 =?us-ascii?Q?ShQZcEwUKYNmauVywghGcT1M9PMHMhmVRIUBcpFiOrRPP6DSsZJ1MezIeREv?=
 =?us-ascii?Q?DhUOlxK21RPWiODH9Q/xRXssupsT64QULXLN6Oid8WB9M9DmziAwzR//qtM3?=
 =?us-ascii?Q?XqzVcmsZE7ta+SkdRFheSc9Zt/y0YZLlFgEn0gv3dolh/+QAdrGCD2i4/GNH?=
 =?us-ascii?Q?OtwjAy+4LarK6F88yoVAGTIgmmRnMHPrPFACrfTTMpuJY5eDVFFEmgA3QC1Y?=
 =?us-ascii?Q?VnF/nh+167hVL5XZ2+v2mtZmSw2ZKifkRYQbUZAGyJL0pfc/9H4kDuEOopMN?=
 =?us-ascii?Q?CikPA2G+yc1u8W6sQC8AbGyGmA5C+df0IAI19UTdZ9MHRkrBeUSHJppXh8Fx?=
 =?us-ascii?Q?ZvSH/3fnIw+cxZMvWgclsbvAJWr9ON9eXwuOmt7uUoVVynfuxoh59Yx1e+x9?=
 =?us-ascii?Q?jwhTzVsx68RP6jWSv/RouuJuveiNQl9HVXqI4EK0lJJaOnT+KAZgulYn1XC3?=
 =?us-ascii?Q?g+lOqeNFBxMxPQvDCGP93ClvyaMj4hkVKm+bTil8Y/lSVnfDMeBQF04bLdPQ?=
 =?us-ascii?Q?rpWhEqHaBKSy5yPfmqmZqMDwHK766YkTArSh1GA4JklomhJi6uiDI/K+h6B0?=
 =?us-ascii?Q?J/K7gR2OaadaAhhXrKCQLbE4X4+0jpK99s/NHXCJ2AYp+BlfTSaDxR0bLqpd?=
 =?us-ascii?Q?tYOMGItSSLJRGbOjdzgBRtONnU45E44oWRo2i2kq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0e1e8c-6e51-47f4-8004-08dc83e54ee3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:27.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Aj4GYdusCJKHiV/n+ZcM7irOJRHijwXfWPjT24uvqlZ4vE1HCndkC3bSS1qRRne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

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
 drivers/fwctl/main.c                          | 124 +++++++++++++++++-
 include/linux/fwctl.h                         |  31 +++++
 include/uapi/fwctl/fwctl.h                    |  41 ++++++
 5 files changed, 196 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/fwctl/fwctl.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d3a..4d91c5a20b98c8 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -324,6 +324,7 @@ Code  Seq#    Include File                                           Comments
 0x97  00-7F  fs/ceph/ioctl.h                                         Ceph file system
 0x99  00-0F                                                          537-Addinboard driver
                                                                      <mailto:buk@buks.ipn.de>
+0x9A  00-0F  include/uapi/fwctl/fwctl.h
 0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
                                                                      <mailto:kenji@bitgate.com>
 0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 833b853808421e..94062161e9c4d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9084,6 +9084,7 @@ S:	Maintained
 F:	Documentation/userspace-api/fwctl.rst
 F:	drivers/fwctl/
 F:	include/linux/fwctl.h
+F:	include/uapi/fwctl/
 
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index ff9b7bad5a2b0d..7ecdabdd9dcb1e 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -9,26 +9,131 @@
 #include <linux/container_of.h>
 #include <linux/fs.h>
 
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
+	struct fwctl_uctx *uctx __free(kfree) = NULL;
+	int ret;
+
+	guard(rwsem_read)(&fwctl->registration_lock);
+	if (!fwctl->ops)
+		return -ENODEV;
+
+	uctx = kzalloc(fwctl->ops->uctx_size, GFP_KERNEL |  GFP_KERNEL_ACCOUNT);
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
@@ -37,6 +142,7 @@ static const struct file_operations fwctl_fops = {
 	.owner = THIS_MODULE,
 	.open = fwctl_fops_open,
 	.release = fwctl_fops_release,
+	.unlocked_ioctl = fwctl_fops_ioctl,
 };
 
 static void fwctl_device_release(struct device *device)
@@ -46,6 +152,7 @@ static void fwctl_device_release(struct device *device)
 
 	if (fwctl->dev.devt)
 		ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
+	mutex_destroy(&fwctl->uctx_list_lock);
 	kfree(fwctl);
 }
 
@@ -69,6 +176,9 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
 		return NULL;
 	fwctl->dev.class = &fwctl_class;
 	fwctl->dev.parent = parent;
+	init_rwsem(&fwctl->registration_lock);
+	mutex_init(&fwctl->uctx_list_lock);
+	INIT_LIST_HEAD(&fwctl->uctx_list);
 	device_initialize(&fwctl->dev);
 	return_ptr(fwctl);
 }
@@ -134,8 +244,18 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
  */
 void fwctl_unregister(struct fwctl_device *fwctl)
 {
+	struct fwctl_uctx *uctx;
+
 	cdev_device_del(&fwctl->cdev, &fwctl->dev);
 
+	/* Disable and free the driver's resources for any still open FDs. */
+	guard(rwsem_write)(&fwctl->registration_lock);
+	guard(mutex)(&fwctl->uctx_list_lock);
+	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
+						struct fwctl_uctx,
+						uctx_list_entry)))
+		fwctl_destroy_uctx(uctx);
+
 	/*
 	 * The driver module may unload after this returns, the op pointer will
 	 * not be valid.
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index ef4eaa87c945e4..1d9651de92fc19 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -11,7 +11,20 @@
 struct fwctl_device;
 struct fwctl_uctx;
 
+/**
+ * struct fwctl_ops - Driver provided operations
+ * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
+ *	bytes of this memory will be a fwctl_uctx. The driver can use the
+ *	remaining bytes as its private memory.
+ * @open_uctx: Called when a file descriptor is opened before the uctx is ever
+ *	used.
+ * @close_uctx: Called when the uctx is destroyed, usually when the FD is
+ *	closed.
+ */
 struct fwctl_ops {
+	size_t uctx_size;
+	int (*open_uctx)(struct fwctl_uctx *uctx);
+	void (*close_uctx)(struct fwctl_uctx *uctx);
 };
 
 /**
@@ -26,6 +39,10 @@ struct fwctl_device {
 	struct device dev;
 	/* private: */
 	struct cdev cdev;
+
+	struct rw_semaphore registration_lock;
+	struct mutex uctx_list_lock;
+	struct list_head uctx_list;
 	const struct fwctl_ops *ops;
 };
 
@@ -65,4 +82,18 @@ DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
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
index 00000000000000..0bdce95b6d69d9
--- /dev/null
+++ b/include/uapi/fwctl/fwctl.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES.
+ */
+#ifndef _UAPI_FWCTL_H
+#define _UAPI_FWCTL_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
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
2.45.2


