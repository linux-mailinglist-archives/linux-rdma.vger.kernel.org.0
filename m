Return-Path: <linux-rdma+bounces-7497-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7DA2B70C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC17818894EC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE5D78F58;
	Fri,  7 Feb 2025 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2n5CQxc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D22940B;
	Fri,  7 Feb 2025 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887232; cv=fail; b=M4kAkSizcwh2mBcbnSdFy0S+9VWJ4zU4hB44LnJKJ/5tuHRNvp+8g9o4WiZYsIFOK0q+Cl2LFGF9lUFHkSC8mRoq1J8NGRIZ0pIqSfyYVGQbrcwRT9WP2r2RZkC73OmFOUjtgYevHCtVjFAW2mgoTdkUC8EDmxEq6CigZ36Cf+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887232; c=relaxed/simple;
	bh=JCtrr3QV60lugRVbas9zvDL3eMCUbMqWiRTTZC3fncU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZS6YlJjyd9y/TbcD3cbdvHSN6uUcCue+XGD6WXSKfmEhFN2kY6yUYS5mG2ht8V3I8GiTQdr2qKNQRTllZJ6NwFfKu46/U8JcvbE/ajfFupwXmlrE5LROA2cY/Ttqd+RvahI+ZdiTtI7enO0zgQ/VHrZgxUCnoS/PLKHgU7Zanbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2n5CQxc; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1rXxmlVYGNE5/cWwkNUvzEXCSVctT9gvaN3m5GT58xDUspmBhL3kZA6kEmc3Ac9cLnKsAVROlLvxxDZPpb4A8cYnVypTWBHSOtDtVqpU3Hx5LsEu62xs3/PFMvhfcOA00X8YnFpbyRb9BEVAEcZv1VIUXQuu+FYnUHiWVKCduRIru/Wb2Q4cagNrJuExG72sXdNhCuGb8d9Z/uaBeYl4jOET+SyApqvhsvyrIEyF1cMCldWQR37NllfDfkh49T/gLOQSzolk3bNtkBk09FWEWBfwbkMWHUXzCi46nF7DtADy6W04eLgG4OSWYlsojV608rdTQopOVCZzXJGdXtysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhAUyoxc+nvwo6BDt8pwkxuGo/r2ZFQ7+uRwuBSVcpk=;
 b=h2p6OroJJSki8u/mXmBkXLAI5sTVvewGDqU20WDm7UpNvynjEPHD68MXjmrqMmCJa+5usmxjfIgCTKAGP4AxpDje4e6pjjjHua+M6uulk3X1ibk9YJgSbNFJkR/rPiDT/IX8N3iEWRVI/dItIkzCpYhvp2+9xy6GZqLsg46TR/gZqZATvb4qhcUNe3wdWw4b4zfHJha7pShflai5ZmtvP1XKnOeI5cojRFtqMGhku7LvDZPsOt3MhXDNwtheYgQR75eUEt2vbKdQZ0GrwGdFhoglAlRWCJWFSi/iSN2vvNxAvAzI2NT7XlM8IRt60b7bMZp1N/ZJfCnsFrGAckEtjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhAUyoxc+nvwo6BDt8pwkxuGo/r2ZFQ7+uRwuBSVcpk=;
 b=F2n5CQxc8xsS9GZb+VUBMKBRcJV6PPha4twnggT2f61mVYiyXMhBCX0Znjnqe4r9FbG9L5FIz2iVv/OwavZrR3WVPzJYleRNCrTn/0Uuwzsu0lfUW74vweME3n+B9/f+9PDmpQ7nKNFgHASGqao1l7kHpgdj4XlgeLcdA7QhLM6Js7hfTpLeGpK/gTg04PKyAF7XA5VyiYk4BhlmHJ+jeg2P8b56J51efpPPd4IFOAdOCYGIz/ODJtjXuoSILipXZVniMcgY0tkJ8YYJ76Fwj0NC4v+CEPmNjPc39erFBpv3NHN/fIv61mYMLrNWK7v9Pjf3nXZdcqWQFHc4KqN+Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:37 +0000
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
Subject: [PATCH v4 00/10] Introduce fwctl subystem
Date: Thu,  6 Feb 2025 20:13:22 -0400
Message-ID: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0674.namprd03.prod.outlook.com
 (2603:10b6:408:10e::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 224ae87a-e2f7-48dd-c381-08dd470c4349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EzZBBWN/kGlAQjRpIBjwoA/E41iMepr+7AczrCjgI2fZDIEd5bI2s25HQjuK?=
 =?us-ascii?Q?kMi8OJqOgWd6wKezbUh5vjD9FZoZUlxM4v25bO4QFzjLZargTLh7gHfGpgow?=
 =?us-ascii?Q?t71NNOQdyAz3lvp6z6Osh8fhuljFpxn9drZkpZKVlyQe/dA/NtghNhjRpsV+?=
 =?us-ascii?Q?D6cK+VgyrvIO7uej+lSmUEbcTYdLdARGuqOc/ex/lGXxXoPec7f5yTxvonbl?=
 =?us-ascii?Q?qOSwqhIz+4w/jKgJ+DzpKHUf5hKJz43XFR6VOh3kvh3Oxooiwb0Sf5IpvNeK?=
 =?us-ascii?Q?hegCurkVTH6wVnoE3eYNimB+MvsQeMoDu1TVqaAh77XbV72CoUIP4OFGPMUt?=
 =?us-ascii?Q?7JPeZWYlDMZZIfen5/d2cazQFii6ry1aYjtduKnlaEO/FYwPmZ4XnJa6kY8W?=
 =?us-ascii?Q?WDUai1b8+zUXRWNYFGfB8P7TTHgF4WfuZDV338uxfa0lzDne1vWPtatjNP8j?=
 =?us-ascii?Q?qNmpSmfnUZkmEVG2aP387WbiaS4mWxhHoK+5xZAVb2ZQdP8yJyzDSPU2DUIs?=
 =?us-ascii?Q?Mq7uXKw/ylSR27EiPcUnYkNfZELpjx6WpuqZIePKFnWvz1/I/MthiBIewZgE?=
 =?us-ascii?Q?GPDLJZ+jyxeNOEB4Mz89DAzp3gl9+a3IRr5QkKjxlGGKtra4bq4T3XYdhBz/?=
 =?us-ascii?Q?bC+TKm3hM/QT6kps5CUAVuZoOdi120k5SDlSQ5ONUFrdQpbg0MpTW2LsUBvF?=
 =?us-ascii?Q?roZJefN/8exGxV1AsFYT2NIc0rDJN9uLCGqzKuECY/BIur1ArCd+AQYwZ+4v?=
 =?us-ascii?Q?u9+Zi5u/X+UO0e4ViUH2Y7XRkJk7l1IYUhU/qECTU2MZYS6IaIbjcaH3G8L2?=
 =?us-ascii?Q?Ye9qEArlvk3qI1hRBLlHourLUy0U+LFypKo6q8KrUg7OHE6zSrrbaq4yiaCU?=
 =?us-ascii?Q?MS7pUFWnfrRNT75TvV/kmIETbCbP0PIKLeyXMZmU6YP1xpK2wjVDTi3KBEWR?=
 =?us-ascii?Q?xRFffYSonuYgKcocsMXXSX7m+DgC4IbFO4SxpUDQPAtwvLez2BMaQMh6r6tU?=
 =?us-ascii?Q?Dak8muhPtzGVlNB8WQAWqExIBPgqEYHphKBE+Ya+WqpX6wFZF5mz+GMVysQV?=
 =?us-ascii?Q?whRRiwkyx54V/vkcKLtQOQAwZ3PG9Exf6LiU2XHcARVc2WL5oZbB3Qmnwfde?=
 =?us-ascii?Q?AF8MQS5PlMwTXOzcYGtcYRm/9r4Onb8eMggkCN9f+GVMpxWwGKEvMlEXvb9l?=
 =?us-ascii?Q?ib9A9L+Y+MjmrWtpPsDO60nT2AwnoY+vGU+UlFuj8H7iPJJiDK4DRiZ51kei?=
 =?us-ascii?Q?MqtROFNpgDf2iP/FBp/3X1f3Uhvwt9knDbx/CXUyJ0v2jbW/QgPFYOQ9yFJQ?=
 =?us-ascii?Q?442bGvDfdVMFllOjOiEfMxDDDAzYp70mOMHOKyhvqg5NBhgvihvibpn3v8TR?=
 =?us-ascii?Q?zli6Ftk+xWpsE7VNtVgwUNSoRU2O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgC3UavjxykxNaMCCkhkcOn52lu8DqlrWn6L6TTYWBvXlq7qGYyCjFe+/0Z9?=
 =?us-ascii?Q?c6fW0AArVqnVTOYcCeZ7W2UwbEZGqgyBcKIgymcoMO+LnAxZ0C3eteK/C+hd?=
 =?us-ascii?Q?jO0pjJcHmt2dCGLa76TbTaKGpqSvtBK6AX/2fixusXK4NIARwWKAoDWWxqS8?=
 =?us-ascii?Q?y/Y8PlhToaFk5jLaU2Epo7focIxVtjwjB0XyTJRQmrbMFSMFxDGySPaETXqA?=
 =?us-ascii?Q?Lsj7jz47yEblErVOIB0KcvuQubXEYIbftO5yzUouI+nFZDfmHwqdWO+OHzR+?=
 =?us-ascii?Q?cVU3jTFaxshF5tLSrIqs6oEllcm0Nvzoap6Ou2PyPAOhpERkrcmdiOBHkHUQ?=
 =?us-ascii?Q?ipnOc3MF3cB/SFZBif/5F8HxDX9OGMWMNwPAUG/42Ia2ZBh2Zb999vGyKs1W?=
 =?us-ascii?Q?uCIgLjRhViCiQ5CqCTyQrcQySxWrxrHR+2ZU78nuxNpD41QrXIcoyoS56Cgo?=
 =?us-ascii?Q?uixSI/ZF/6tkaokKNexXrkda8WRS3Fye3mzNJZBP1ODpkMLFchgxgLHXCDfl?=
 =?us-ascii?Q?Hh18xKpzpIe/yXO/cq1Mh16c+6G/TsDFLV5gYHTYPZX04vqtvFb9wVz1hfAb?=
 =?us-ascii?Q?yaw926ETJ6/544BGWLweRwBCeuNAb/aTVkEjJZmUxj9/1vWDB6dfLsbswWJT?=
 =?us-ascii?Q?ZXbwEYCtDWnsyP6uN+OM1YbPf9MNGccAhEjCz7p+fFCMnsx8I9Tm8LLOqPDb?=
 =?us-ascii?Q?RU3F6q0819ZDJgi+0l8BCPor6EfVGFgT20nHQXLw+Bs6rkm1Xdb3DEFei7cU?=
 =?us-ascii?Q?nsTAmFvPbbFzaz09Si+n6Dy8nIkcFUtQNDsUQkOjCzjvqwr7aAuDOOsbhCLm?=
 =?us-ascii?Q?8vkPBKwFt06OUlJkp07PRuQGdZLobk82PUjpsP62QfpGRRnrI4Gq4KpAkkSz?=
 =?us-ascii?Q?7NwOGTcuP3BvFNe1lZvpK3YzhEZW5IQkjqKUHvrvBzdwHMYHc1oRxybtdL7Q?=
 =?us-ascii?Q?ROw8EoMWlamKt08Gf/3XQJf//Haj1NdGHvOxLzkpCZFpnPdTeyxfjgQWPAu+?=
 =?us-ascii?Q?4eEgmTrBCvJz5IVm2GnymcXpS7OTzxrMi9Ypqh0jkJicqy3anKm4QYg2NKmg?=
 =?us-ascii?Q?uBO/gbEwp6pKfT+NoWmNasZAtpxfPZNIbfBkntYkESDZtD1+c82XJKDrBihs?=
 =?us-ascii?Q?G+JP2Vzi1iKwAYBqofV+sh+GE70FodMUHIG+JezpfQDebgQkSOygQD+AEL5h?=
 =?us-ascii?Q?SFY25LN7WmsXgbf7phvuabyN9Vzak3+15JmyqbxhgMOARvtd8sTFypReLhb9?=
 =?us-ascii?Q?HNwhr9Mu5HzImOUERDZqODuZrZVB7YIv7HInmNudjw/G4r1A4wymbvjg+h1u?=
 =?us-ascii?Q?JEV9vRq71dMl/Yfy96ZFDJNci1eeoxPsirf9J5xzwjY8eG1G74VdH3E8Mo86?=
 =?us-ascii?Q?JIXGe1cGp7EOMxrnNKt1yWsslQUMZZ43RyBMGK7SHnfe1HvgD5yFFVQu601t?=
 =?us-ascii?Q?l7AyW1KbPA2ry7PI6dH2LoAqe6AzVeVuoU4V9no63Cp8Wbsj/zu/YuHfV8Au?=
 =?us-ascii?Q?89KV4BmNjN7eORLJAPy0556arcu3TuQd5JNOwW0JT78l56zSFE+kg16cEkSK?=
 =?us-ascii?Q?txoypOphMPhgvUwYRcE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ae87a-e2f7-48dd-c381-08dd470c4349
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:35.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgrluBBX0/TsOBozq/lDKAnXC3ivU7TzuxEay2kusgdqbt7oVHlw9uZL48ddW0gC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

[
Many people were away around the holiday period, but work is back in full
swing now with Dave already at v3 on his CXL work over the past couple
weeks. We are looking at a good chance of reaching this merge window. I
will work out some shared branches with CXL and get it into linux-next
once all three drivers can be assembled and reviews seem to be concluding.

There are couple open notes
 - Greg was interested in a new name, but nobody offered any bikesheds
 - I would like a co-maintainer
]

fwctl is a new subsystem intended to bring some common rules and order to
the growing pattern of exposing a secure FW interface directly to
userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
exposing a device for datapath operations fwctl is focused on debugging,
configuration and provisioning of the device. It will not have the
necessary features like interrupt delivery to support a datapath.

This concept is similar to the long standing practice in the "HW" RAID
space of having a device specific misc device to manage the RAID
controller FW. fwctl generalizes this notion of a companion debug and
management interface that goes along with a dataplane implemented in an
appropriate subsystem.

The need for this has reached a critical point as many users are moving to
run lockdown enabled kernels. Several existing devices have had long
standing tooling for management that relied on /sys/../resource0 or PCI
config space access which is not permitted in lockdown. A major point of
fwctl is to define and document the rules that a device must follow to
expose a lockdown compatible RPC.

Based on some discussion fwctl splits the RPCs into four categories

	FWCTL_RPC_CONFIGURATION
	FWCTL_RPC_DEBUG_READ_ONLY
	FWCTL_RPC_DEBUG_WRITE
	FWCTL_RPC_DEBUG_WRITE_FULL

Where the latter two trigger a new TAINT_FWCTL, and the final one requires
CAP_SYS_RAWIO - excluding it from lockdown. The device driver and its FW
would be responsible to restrict RPCs to the requested security scope,
while the core code handles the tainting and CAP checks.

For details see the final patch which introduces the documentation.

The CXL FWCTL driver is now in it own series on v3:
 https://lore.kernel.org/r/20250204220430.4146187-1-dave.jiang@intel.com

I'm expecting a 3rd driver (from Shannon @ Pensando) to be posted right
away, the github version I saw looked good. I've got soft commitments for
about 6 drivers in total now.

There have been three LWN articles written discussing various aspects of
this proposal:

 https://lwn.net/Articles/955001/
 https://lwn.net/Articles/969383/
 https://lwn.net/Articles/990802/

A really giant ksummit thread preceding a discussion at the Maintainer
Summit:

 https://lore.kernel.org/ksummit/668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch/

Several have expressed general support for this concept:

 AMD/Pensando - https://lore.kernel.org/linux-rdma/20241205222818.44439-1-shannon.nelson@amd.com
 Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
 Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org
 Daniel Vetter - https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
 Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org
 NVIDIA Networking
 Oded Gabbay/Habana - https://lore.kernel.org/r/ZrMl1bkPP-3G9B4N@T14sgabbay.
 Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq
 SuSE/Hannes - https://lore.kernel.org/r/2fd48f87-2521-4c34-8589-dbb7e91bb1c8@suse.com

Work is ongoing for userspace, currently the mellanox tool suite has been
ported over:
  https://github.com/Mellanox/mstflint

And a more simplified example how to use it:
  https://github.com/jgunthorpe/mlx5ctl.git

This is on github: https://github.com/jgunthorpe/linux/commits/fwctl

v4:
 - Rebase to v6.14-rc1
 - Fine tune comments and rst documentatin
 - Adjust cleanup.h usage - remove places that add more ofuscation than
   value
 - CXL is back to its own independent series
 - Increase FWCTL_MAX_DEVICES to 4096, someone hit the limit
 - Fix mlx5ctl_validate_rpc() logic around scope checking
 - Disable mlx5ctl on SFs
v3: https://patch.msgid.link/r/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com
 - Rebase to v6.11-rc4
 - Add a squashed version of David's CXL series as the 2nd driver
 - Add missing includes
 - Improve comments based on feedback
 - Use the kdoc format that puts the member docs inside the struct
 - Rewrite fwctl_alloc_device() to be clearer
 - Incorporate all remarks for the documentation
v2: https://lore.kernel.org/r/0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com
 - Rebase to v6.10-rc5
 - Minor style changes
 - Follow the style consensus for the guard stuff
 - Documentation grammer/spelling
 - Add missed length output for mlx5 get_info
 - Add two more missed MLX5 CMD's
 - Collect tags
v1: https://lore.kernel.org/r/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com

Andy Gospodarek (2):
  fwctl/bnxt: Support communicating with bnxt fw
  bnxt: Create an auxiliary device for fwctl_bnxt

Jason Gunthorpe (6):
  fwctl: Add basic structure for a class subsystem with a cdev
  fwctl: Basic ioctl dispatch for the character device
  fwctl: FWCTL_INFO to return basic information about the device
  taint: Add TAINT_FWCTL
  fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
  fwctl: Add documentation

Saeed Mahameed (2):
  fwctl/mlx5: Support for communicating with mlx5 fw
  mlx5: Create an auxiliary device for fwctl_mlx5

 Documentation/admin-guide/tainted-kernels.rst |   5 +
 Documentation/userspace-api/fwctl/fwctl.rst   | 285 ++++++++++++
 Documentation/userspace-api/fwctl/index.rst   |  12 +
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  16 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/fwctl/Kconfig                         |  32 ++
 drivers/fwctl/Makefile                        |   6 +
 drivers/fwctl/bnxt/Makefile                   |   4 +
 drivers/fwctl/bnxt/bnxt.c                     | 167 +++++++
 drivers/fwctl/main.c                          | 416 ++++++++++++++++++
 drivers/fwctl/mlx5/Makefile                   |   4 +
 drivers/fwctl/mlx5/main.c                     | 340 ++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 126 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   9 +
 include/linux/fwctl.h                         | 135 ++++++
 include/linux/panic.h                         |   3 +-
 include/uapi/fwctl/bnxt.h                     |  27 ++
 include/uapi/fwctl/fwctl.h                    | 140 ++++++
 include/uapi/fwctl/mlx5.h                     |  36 ++
 kernel/panic.c                                |   1 +
 tools/debugging/kernel-chktaint               |   8 +
 27 files changed, 1782 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/fwctl.rst
 create mode 100644 Documentation/userspace-api/fwctl/index.rst
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/bnxt/Makefile
 create mode 100644 drivers/fwctl/bnxt/bnxt.c
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/linux/fwctl.h
 create mode 100644 include/uapi/fwctl/bnxt.h
 create mode 100644 include/uapi/fwctl/fwctl.h
 create mode 100644 include/uapi/fwctl/mlx5.h


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.43.0


