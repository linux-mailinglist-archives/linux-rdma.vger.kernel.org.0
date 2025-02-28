Return-Path: <linux-rdma+bounces-8202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6A1A48D43
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F331891075
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E66313D62B;
	Fri, 28 Feb 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mTAR0FaE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C82595;
	Fri, 28 Feb 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702413; cv=fail; b=RwWrryvkBYWy/qc0kmFuO4ttM5MxK15lAYunem95Yy7bwvyW4+tbBSYfrmyLGj6t2kYtUQZRyrkNg8JQiQ6RQtVfj0b+XxnpIu+h1kJsRKQ+QZM3nihyCh0RQygongzumV7WfQyUnprdK3qu7eLLBebm1vsBUWK6N6P6U4k0K8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702413; c=relaxed/simple;
	bh=jD5w1lG2ntYGzWKqlACyCZpT9XzIXIQsc7zBjNWWwBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiAJf1VSGU1pJgeUWEAIE+0/3IeIyq6yvIrG4PyUJKwPlki0Nd4QX2qoaAi8ryth3JzLSrn/nJDz3dpT7I55FEnhR1EXpBCpVG+//KQBQwCwmlsCHo3rdwD+YN8fO3BoGs7yapsHTJf9JQaat60GUHtCptEEU60/Qns3NA/kWbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mTAR0FaE; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0dvJ1BZbuX2Wlm44ocWWuUpMxOIcpcCjgjn6cowik8vxPAUCagbWVzT/DwL4ixz/tIjd+lkU7G5sUWscRs0k6DOqBEWJhsCZaYF2p4Pyfy76C4i9MAfMJBad54XHg/gy/lwtVVV1li+S6GSn/438vP6X0/fpmrkrI+n90e5J2ke1SQWOMDnNPX14BGDfK2Xt2hO8kF6Fw9jRswlDe+8NgcSTTAP7ILGycI5/BX/PViw0SPWrp66W0ZKrciWQ745r2w6jUtXi7e3Nlfx0xShMuzMzPtrCNXRMo3HoegPflekEOVcV6y1JVsQ4D5o0v0MKNwVUeQ6Bl6wUboEqU+6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPPCT/kXOEOsQpYlc9xqw/ZNRaTSw9UZUIUlp3aPMH8=;
 b=XQHez5mjAoyfCfz66aYyMhzL1x6Y4PQPjMm5OW5/ruCKsLu0u9zfHDg4r/wBRi4umD/kw0Cql0y071fJX3tTHm9q/voz/eWcFTZ/hwRotzZUgAQDqu2etvvnVfTdVIC0/2gIU/c6J90SKsCC7SlIKnUQEI1DtW44zjovFTJbR3/7QPiuuyh1rBsl14+STuAa5jRO3OR4pKEMSNrtQ4km7Mb71HCqIfvbUuDQgJvpG0FLr42p7pMxm1xVY/xYHTGzcMxgyt3oQQP4RNc/a6xG7sFHgLBNR2HbSc0ddd+mK04I8jaUh0grNZ9FeSHGFSb1Erd1fwNU+ZTAY/HPlBMuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPPCT/kXOEOsQpYlc9xqw/ZNRaTSw9UZUIUlp3aPMH8=;
 b=mTAR0FaEdmStWS9QLy8EC3l1eyGQUKE1QtLFSUvw9flnXypZeNj+Oe3o3PTpBfIB3GaVFfv39diCQHrdS+HHoWuquA+2hC3UOaTIsoSfJwQCUVpQpjA0Sz0VPmwwCy28JJV5OOfiXzbnwF8fWY9/Tbg7bjzaXL7vH1Lo4eAJolr56QitDe7C9D/06GrvQNnm4dHu1xE/IsTCZrOBTW+ej7lNL0WWXEZS+jObJxzxW9RbHauNtyUU1tmPIWtfuhrRWP7Tsxsgrk2n2nHg9v7eMpqMvczgfAf82xqDPKeZLdKO1dFECnJqVqBh/w1i9N8DVDcR6l4HHXV8rIy9xQu0Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.26; Fri, 28 Feb
 2025 00:26:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:26:41 +0000
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
Subject: [PATCH v5 2/8] fwctl: Basic ioctl dispatch for the character device
Date: Thu, 27 Feb 2025 20:26:30 -0400
Message-ID: <2-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:408:ff::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2b6ced-8528-48eb-791b-08dd578e910b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2xHKelvjLf2kGRIWFHOOfkWCEsXUXJdcc0YpjAqqNiBiIVQ0kcaU9g6VfQny?=
 =?us-ascii?Q?j8MnqrfR8JqB+7uO6am/eRrkQEfO8B/9cusGjgpBwcr7jS97bqhKiLt5VAzK?=
 =?us-ascii?Q?Ch1conuEyf1Cd0KkSU2neNxzLS1hA3bEeuogO9GV6oiDHcboMFJiLv3qba6Z?=
 =?us-ascii?Q?wKzlij6j1FgQBXDg1Uy5kC9R9nARYKq/HSEvVpITVaTwnJAX4WlNbGOoa8Wq?=
 =?us-ascii?Q?URlfzinDkTc3gcugtKSgLluZ0J4TqJdEHC6Ge2HICK5Q9YtjoaexPtPU30i+?=
 =?us-ascii?Q?AtK/iZeThHSwiM6cdiLBYTr5Ivili25S3gz17g4X0LGrj15U+87T5pHFE9QC?=
 =?us-ascii?Q?bIhIXEZHnPuc4GgLvJ3zWEWef4knhBWuWvxt8P9xPvytAe/8+g8TT0ytGaGl?=
 =?us-ascii?Q?SPV+jy8rzS6vstN+4S9JSccgeYdgHk8pimk9Qx83PyccHREx6mVmV30yXdAI?=
 =?us-ascii?Q?NHYVCLc39sT9+SNRWbPMn1dySiHjD1zFCaGbUZVSTjiBtwVTdJJ665nzPf4v?=
 =?us-ascii?Q?+RcE+rtzaLzEfjvYgdU89hUng/UMVgq48tnnpB0/DCC+15g/HpUM/swq+NmS?=
 =?us-ascii?Q?qYeumXdGYrXzug5WHOPW8757apYHoo6cPcGlXlJRAyNMJlrtp9Wp8Mk8OAso?=
 =?us-ascii?Q?V8bO2Oyvu0oYMLmQ2NB4GRoqaHSPBfqm6uvJUxR1oR1Mxsn8c30fMmp083Cj?=
 =?us-ascii?Q?p0zKk43Jpgo7QNZ7L1RIgWf/4bAYnk8TeSj0kQxO3M2gr13BTG6/vfhj0tr0?=
 =?us-ascii?Q?WhJqd5YD0M91uVzpaEsnLYDblxLKDp+GpxdwX/QCqidmpk4BB3KIznQ3n0f1?=
 =?us-ascii?Q?F61jxAmZVxtRCa+3e5ldZxA7f/M+6N9z7ljeoNK8pWSuWq5lemgeWnbY6nh4?=
 =?us-ascii?Q?Wq1RO4Oi3TlXJ2hsiLIS/v4gnoN271y76P7xH1bMH7okN3YMHq8CBmV1Unzg?=
 =?us-ascii?Q?ZtXkZo+uZkbuKrd8A3LkF04L74uCFVM4tMy9HYwdZ1frVWpY4ugLb9EAxuog?=
 =?us-ascii?Q?S8aXm2Mb07a8WFxUVr53tDnJqgrsOE9JFFioDZk4lKGrn5m/TKmswGDqopFm?=
 =?us-ascii?Q?MtdWy+41eLT4SG1DOxMRtOLOgn5VtcIICMpCAz5A5M1pDyo3dtMOF9cz+0LG?=
 =?us-ascii?Q?5H0icg1q50SlQNtWmk+fCRc8s89qUFlJoZHHQQafCplC6WRvhld9Jn2l9u44?=
 =?us-ascii?Q?wu4igO6z1q2FxXRf9htUn59B1fx2rEeP0LBKjlOVtHUN2V/T7+Kb30ZVBk8L?=
 =?us-ascii?Q?5deKxCnedLRdc1M8w5psj/S5vng3xFERJwUJzN02wEsUdmJ+jivQW1r3f7Qk?=
 =?us-ascii?Q?i0LDYpDoVdU/elW12oXAmYkJsd9uK5jJsJ+r91+9u+jra6E3VhRMM7aeW+W7?=
 =?us-ascii?Q?iKm+86GCSOItLkcmJTNDam0J5KS5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AnDpTd70BACuLv/Uf0Ly+51A3wMkZHhIsmVVaNZw7Z3GWNRr+WGO5+jc6dxq?=
 =?us-ascii?Q?3qkz83e8/wyOh4cSz6WcwEk3Pdqi/vc0iP2lbdM6P350u3bypfazZmviKMdA?=
 =?us-ascii?Q?G4nE4RjMh5nNmfiLFRiH4BBjDqRdm2WvEoIeNp2JB0GfCS4LjaKIX9+pcv3G?=
 =?us-ascii?Q?dgbkPWu2hOJb6c4GMnJb6RzTzZIIUm2FhnUAr3A9wPYgH0a5QBN/Jsj757rx?=
 =?us-ascii?Q?6Ak7qbdE0Cw5Drmg2kIFVpjup94i5pIvoB2soBh55nPy1sBnor9Fe1LlbD38?=
 =?us-ascii?Q?ksdZ8QARw62P5XO52QR04pgLRdCKHuMc7UR/1sjyeszE1LZPCJ6YYMBef9EM?=
 =?us-ascii?Q?oudDXY3R2XgG5JtaQBoG55vyE9AyRvSdbhBIB1yOjXRB5HK1huQnarzsFUJD?=
 =?us-ascii?Q?bwG3GmWIh78Lfst6lk0g4bWaK9d5cPO8pssIUfmy8A3ReLIDFRr1GZVNkST6?=
 =?us-ascii?Q?KtZgnTDRABO3oAArIz3vh6sLIhXi6oHhicnWLzDhhIL2jcS+53ZzT46gs3sQ?=
 =?us-ascii?Q?8oebsEQvVvuPdg5ZPrfL7aQatREaaljai2RwwqQ+s92jcCqHsOO1M27fa23l?=
 =?us-ascii?Q?BTQjmboi0uvE2zxOS6ybqMm6nJHv4kkt8JNpuwa6xJif6GmKu5PmuuxPybPA?=
 =?us-ascii?Q?vyNEIMBs45bEPfK5o4N+UTglmJy/US3ADqTOqMFBGqRciwVQX0YvpF1XgP3v?=
 =?us-ascii?Q?Ju1qKu5aho7k1ZlB03GuqzYBFp0uqELpjBoF6rqSaVB+J8wl/xqd4wGKnX4J?=
 =?us-ascii?Q?WUK6LKhoM9MMeu58rRe7/qxjnxJsitSTiYVG4DBcuU2P7ZE9nlDTTzyiAcvl?=
 =?us-ascii?Q?vmiS9TpeojwM9K5WCWy4ulei/cgtREDhBiWLIaCDfUL7lVZWCYNqeHTDyvwq?=
 =?us-ascii?Q?6p+WJLScWUJgUnlT1p4Dg1SzIYOV1XUl3j/RZwnFiYExMhqvEgMFVHsF7aLl?=
 =?us-ascii?Q?is8Oz3eJ8N4lhYdyD24vGPeS8Av6gaf8xfaSqxNqh2pWUCfvj6dQcJArnSOP?=
 =?us-ascii?Q?LlBXnJ9Fvklkqc+O1thIc0204lRaIDVqo1Dl4KTlFRWO9dDaAAV7UPSBnzkq?=
 =?us-ascii?Q?Ao3OAVPABVLuvQG5HnjJBKa4W2igieiw5IJng/WbMO4mRHi01xYV/FETU0jG?=
 =?us-ascii?Q?LwMHn08ij+K7H2NwJs0orTNbzBeKNStfq4FjYHMfsDujv7WOJwTFPi5hCajy?=
 =?us-ascii?Q?ukCkTRQgbvRy6MknB8oHP9C0X6KEVMCz3ilNmhc0rGDTPQzkgbYe5GmyGH0F?=
 =?us-ascii?Q?vt3pZidg2hoKB7lSf7yHWVW9wnmGu2qPUNNKy4haT4i+EqRP2/0tBJnWSHKC?=
 =?us-ascii?Q?E4QZMfW5Y83Kq1yUz3DI41qkv475hLJnVOIMzz4eFx5FGiyEREw0ea13FQfm?=
 =?us-ascii?Q?z1k78/vbVkAq8K1Q/5c56vG3r434lCDRZZE0SMhXJWETaG27IPOuntOOsrpz?=
 =?us-ascii?Q?NwUApI2syejBkS535GmyuHphtADW3lbtLuqF9ud2ilRkRwH1XRCVMcikcXbA?=
 =?us-ascii?Q?gz/rQuRNiJgGuIy9kH6phN+oeg+Oot5DBQ5O52LJE60bk3AJWeNnXI51nHt+?=
 =?us-ascii?Q?pHv+svRaecvLImhdv4INfpOMvCeuQPPcsrDaM2Mp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2b6ced-8528-48eb-791b-08dd578e910b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:26:38.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RX5tzSVpcO6DmtvzSbgr7rSb3frSth5e4mjY+psks6SgOTSJMLmmhX43PfUjqOil
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

Each file descriptor gets a chunk of per-FD driver specific context that
allows the driver to attach a device specific struct to. The core code
takes care of the memory lifetime for this structure.

The ioctl dispatch and design is based on what was built for iommufd. The
ioctls have a struct which has a combined in/out behavior with a typical
'zero pad' scheme for future extension and backwards compatibility.

Like iommufd some shared logic does most of the ioctl marshaling and
compatibility work and table dispatches to some function pointers for
each unique ioctl.

This approach has proven to work quite well in the iommufd and rdma
subsystems.

Allocate an ioctl number space for the subsystem.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/fwctl/main.c                          | 143 +++++++++++++++++-
 include/linux/fwctl.h                         |  46 ++++++
 include/uapi/fwctl/fwctl.h                    |  38 +++++
 5 files changed, 224 insertions(+), 5 deletions(-)
 create mode 100644 include/uapi/fwctl/fwctl.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 6d1465315df328..3410b020a9d093 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -331,6 +331,7 @@ Code  Seq#    Include File                                           Comments
 0x97  00-7F  fs/ceph/ioctl.h                                         Ceph file system
 0x99  00-0F                                                          537-Addinboard driver
                                                                      <mailto:buk@buks.ipn.de>
+0x9A  00-0F  include/uapi/fwctl/fwctl.h
 0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
                                                                      <mailto:kenji@bitgate.com>
 0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 1dbf0f216f9936..1bc1f97934b6b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9563,6 +9563,7 @@ M:	Saeed Mahameed <saeedm@nvidia.com>
 S:	Maintained
 F:	drivers/fwctl/
 F:	include/linux/fwctl.h
+F:	include/uapi/fwctl/
 
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 76c4edec20afde..4bba6109712e42 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <uapi/fwctl/fwctl.h>
+
 enum {
 	FWCTL_MAX_DEVICES = 4096,
 };
@@ -18,20 +20,128 @@ static_assert(FWCTL_MAX_DEVICES < (1U << MINORBITS));
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
+union fwctl_ucmd_buffer {
+};
+
+struct fwctl_ioctl_op {
+	unsigned int size;
+	unsigned int min_size;
+	unsigned int ioctl_num;
+	int (*execute)(struct fwctl_ucmd *ucmd);
+};
+
+#define IOCTL_OP(_ioctl, _fn, _struct, _last)                               \
+	[_IOC_NR(_ioctl) - FWCTL_CMD_BASE] = {                              \
+		.size = sizeof(_struct) +                                   \
+			BUILD_BUG_ON_ZERO(sizeof(union fwctl_ucmd_buffer) < \
+					  sizeof(_struct)),                 \
+		.min_size = offsetofend(_struct, _last),                    \
+		.ioctl_num = _ioctl,                                        \
+		.execute = _fn,                                             \
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
+	union fwctl_ucmd_buffer buf;
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
+		 * NULL ops means fwctl_unregister() has already removed the
+		 * driver and destroyed the uctx.
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
@@ -40,6 +150,7 @@ static const struct file_operations fwctl_fops = {
 	.owner = THIS_MODULE,
 	.open = fwctl_fops_open,
 	.release = fwctl_fops_release,
+	.unlocked_ioctl = fwctl_fops_ioctl,
 };
 
 static void fwctl_device_release(struct device *device)
@@ -48,6 +159,7 @@ static void fwctl_device_release(struct device *device)
 		container_of(device, struct fwctl_device, dev);
 
 	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
+	mutex_destroy(&fwctl->uctx_list_lock);
 	kfree(fwctl);
 }
 
@@ -71,9 +183,6 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
 	if (!fwctl)
 		return NULL;
 
-	fwctl->dev.class = &fwctl_class;
-	fwctl->dev.parent = parent;
-
 	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
 	if (devnum < 0)
 		return NULL;
@@ -82,6 +191,10 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
 	fwctl->dev.class = &fwctl_class;
 	fwctl->dev.parent = parent;
 
+	init_rwsem(&fwctl->registration_lock);
+	mutex_init(&fwctl->uctx_list_lock);
+	INIT_LIST_HEAD(&fwctl->uctx_list);
+
 	device_initialize(&fwctl->dev);
 	return_ptr(fwctl);
 }
@@ -132,6 +245,10 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, "FWCTL");
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
@@ -139,7 +256,23 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, "FWCTL");
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
 EXPORT_SYMBOL_NS_GPL(fwctl_unregister, "FWCTL");
 
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 39d5059c9e592b..faa4b2c780e0c6 100644
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
+	/* Protect uctx_list */
+	struct mutex uctx_list_lock;
+	struct list_head uctx_list;
+	/*
+	 * Protect ops, held for write when ops becomes NULL during unregister,
+	 * held for read whenever ops is loaded or an ops function is running.
+	 */
+	struct rw_semaphore registration_lock;
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
index 00000000000000..8f5fe821cf286e
--- /dev/null
+++ b/include/uapi/fwctl/fwctl.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES.
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
+ * ioctl is passed a structure pointer as the argument providing the size of
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
2.43.0


