Return-Path: <linux-rdma+bounces-8195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6CA48D33
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9BD1890B3A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A321276D35;
	Fri, 28 Feb 2025 00:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BFavWCQ2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E623DE;
	Fri, 28 Feb 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702406; cv=fail; b=E2KEHS7SWZ942NJDewVy0lQpJSxe3rEwR8YEqDk8i55u4CNVv6NkimkDdaFoUnXuzOAFKTOSoFIMSbqVHqXAc6PY8W1mCNzzZXGKTrapT5c0chiaFyyQvK0Znm/6qhpUkJBURwOnFdecvBJEJcrpWMQGDSjY6S6e3TEkTcGBpOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702406; c=relaxed/simple;
	bh=/u62GBFxaonVFbdocHrUQVyMZYnSA9u09bI+dv0giAU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e1l51iBHPkQHcvb438/J65W0XeetK7GtrcUKVuEeu2Ncp61PcFDZJAvvLVWdCZNxkpFEPHi0evkJ44SdTJKvBCXwdZTH6z8GdZMsay+ZWZSACMu5mG/14RHw+zxQKdOEV4SM+UJqnOT6ENcMTDEgiu5mU9snnj+iJnO5DHdM/vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BFavWCQ2; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNqp89uwqDnm1jrIM3H1XCTTov9BVgsF2Huh7MBw9Zz+3xhR5xE4rFsgMmifFyayd0vcxDreprLt+lxn1J3rDlgbwnSuhP3OXj6e8Ea6parc6qTA3XKP9GCssqJDPJqQtkMIAhW5s3AADFZogFQnsmwZd8S46JyCa5wHpI3n84vWrd2BUkW0Cu0yrTQ64qTJOqQoGf14f3Rx0+188AoC1YhZjfi64i0gqyyNXe3B1N0rh3oSgKPczWUqKTRsTNvTp27YWbwc0/KeHLXujGF77nOo1Io9HZ5rqNSWSICZVWG2ya+TVtI6lUiLmA58/A/nPA/OJWCHG8wF5Z/K8toSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0M13EQu2gGkH9fIoPRH6v1j8SMaka5vj+kSKLXmqlA=;
 b=Q+kSouz+OUbNZrX08Xm/6LyZ6bvEkq2kvs5HIPFyuZW2rR0A5Id/X2bOPpX2dvcIychPeiY6CFJr4UHjJKyOBQDRHnbP3ARg/SOULKJOtBnsnPmvGFPfww63NeqIiqsSDtugqtqcD1rw2J2Frj0hQsIaLcg3H9pZG+/cd12+o5YAZOBf9KtHF7YbvSl+HpLg0lSVxkXr7hzME6A7FOml2GPlr1dem/WcwsypJIyWGcB24nJEO68RmKYMGahh5h2Q/zP75cm/im+uX4nzCvE2i6H2wAE2Jiv1zdk2vB4epbQWImf/lgq2c23dGbRsmaEjnjbL6HgmBw/hLXe7Fi9Ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0M13EQu2gGkH9fIoPRH6v1j8SMaka5vj+kSKLXmqlA=;
 b=BFavWCQ2HnS5tGdn0bYErzNuRVQbcj14G0EPJSuNZl0WqaS7oHC2I0RCdVS+eBsSKPYsF2DQuSd1rrvU0hm24onbScKcx2muFdwrkofSJUEQK28hgQuM9OrWRxWxeXpTvKnMboMp5VMRn7+sdljKUQg/KVfNrWBgua/po4w8A7dW+qcUXdkhabNVsdEVXfW8bFwpWMmx+D67Xn07GaSt3iSRWtT9gEu+b9V/eutX2QNiPGfnw4bKFIv/JlpoXMGnzpnO8JFuLSqGm/G89muUXk6xS1w55XZPgoZBPOM1DjdTkrR0y1e2qdDSh/ESHRmdBsOBvXJPqTSON6cRatfD6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 00:26:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:26:37 +0000
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
Subject: [PATCH v5 0/8] Introduce fwctl subystem
Date: Thu, 27 Feb 2025 20:26:28 -0400
Message-ID: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:408:ed::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: b870a9c9-aec7-43d5-c0f1-08dd578e9032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6XMYMWmAHpg3l4kuvGq1XvQjimgkAE3l3A3lX3B1cw8Ul2kwk+g8oOUnsJRM?=
 =?us-ascii?Q?zqpHZ9MsqpFTXJIG+6VFRPF6deeUqsVrl3e+OVXXmKRow6+v+SbAtX1XaPO2?=
 =?us-ascii?Q?6hjLuwXhRsFCXqivBEis+hvx7OYgZcy53/Z7NS1IExxnjEuJDS6wVoudLByk?=
 =?us-ascii?Q?DZTJlfb2MZJCkruFncEyLMzg3b7K0Z1iK8SjK39m2Ol+FLTApl9zgOUwtmFN?=
 =?us-ascii?Q?KfLpxEiU87gdRAw1/Wmzh9KUWlz8AlloqgxfJt3Jv7XwmBjhwYLTfArbS2/m?=
 =?us-ascii?Q?X3tx82KjRwRsyjsyJIceTizA+4lrb04n7KXDFLL5MSGSqtNWI8GFmpJnX/fx?=
 =?us-ascii?Q?b9P1hnNx+Sgn5JSW7VqQmqyaKAg/M5G2M2V/nxuCd2epgkk7DwB7Byu59LPT?=
 =?us-ascii?Q?3rZZLnK1yo6ew6MQMMYFlk7Z3KLHCvkm1ld5Tqm/HHjf59iBoBvm/Qg3+pyD?=
 =?us-ascii?Q?abKgAmqqNpKcNQEz1Mb881vcmoqtvzhdtWHxQI3pgQTEoGIOd7jUz/apO918?=
 =?us-ascii?Q?RkrRw2V4Z3V6fxPRUy/zABeqJdxZP5XL8ZVwRuU4V/9PEHTgY98tNmIKFIuO?=
 =?us-ascii?Q?oo69PVX2KjJTra2vVqJEaSP0prk0lbmPuUJcv5U/G52QGNJbtZtHLJ7zXEkH?=
 =?us-ascii?Q?geDJu9O8t4mNCoqvaEWgOYUR9P50fu8n9JL8tmU9FTOPJ0xBAjkSAXdx8zMk?=
 =?us-ascii?Q?pmJZPX0Irit9x+Gx2v/Dn+YwvyNCbLUrp4Mca/V10i8QSlH15hB7I0C6ZO1w?=
 =?us-ascii?Q?8nl0LM368+WhXcABs6eaQW3LqR+/nzLJczRzYhyLHOgXDDUKzbrISzHVZbc4?=
 =?us-ascii?Q?loHGR15cwU2yGFaNEfFwGFbOCSoSDBGFAPU4BKHaXiKOOB+M/IO1onoz9G0y?=
 =?us-ascii?Q?4wflfp/TTuLgC0LTgqvvwyP7UoG+bM7CuuymOTBKHBfQg6eB7kR7Nd0RAzqy?=
 =?us-ascii?Q?nX0FOJdNM3tt2pHTvLNYUzJ3eKfywYLIdjtuF2covbEnqAYcId5W0YV9ootC?=
 =?us-ascii?Q?PyAajq3fsX5t5nFg5PfQA+jQMrQpYZsG/mbZ8wcw/CZOHvWeZek9+iq3IdnH?=
 =?us-ascii?Q?oYBUF2HEiqD5PRfM/vpwA/NfcyLSHDk/cgPa+kbkU2dsYVVGsbQawrziqXIY?=
 =?us-ascii?Q?sP5ifFrkmX9yjCfiH/ctVBi9Z5t/jlrBLBeuinzCFmKgBV+i8hm65ljHT1DT?=
 =?us-ascii?Q?oQgxR0KVWuSdz7Tn2jkIOcm2gM5j83qs+/47gPeu/ziYOQoI/zdxMgqxypaa?=
 =?us-ascii?Q?sUIXj9gxLrjeaL2/TqgwXJl+QfFHH8dijZDJNxVu8OueAmzcrlnvNL+k8NNk?=
 =?us-ascii?Q?qdOrguJT0Wta+W9aFFJJKovMz65EhUP9MhGF0RlIF8R2UOLdE0JZHkMM+oN1?=
 =?us-ascii?Q?5aL9Tup0H5u1H5r7blKXJWlyYGER?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1JpyNQO9KNMFC+OCjQyO6vrFZHC+eZBZqTDddAXroENBSDp9rY4N2xYZern?=
 =?us-ascii?Q?vDX5OAJATdvtNjsvGMAzoVLaMWUYEqtBCMRid9xeUjjmbnniYi/8+ihMj6Rz?=
 =?us-ascii?Q?idN9diZQvg9iKZJTHbedYRHCW6rhD5JvXMTeauuomP+qfu7FXVp9AoXNUWkb?=
 =?us-ascii?Q?rNKp1fbrHDczdnCAPwE3yktzOTenG4lnEYFHsAhSE4dvaCiAqQnRt4socnq/?=
 =?us-ascii?Q?561oEHejeXNVwoFRGymHKuY0UzaT+/8QQ/8wCug9ussdSugDIu/mcDEMU9Dm?=
 =?us-ascii?Q?W7J0ibosz2mY7oopQE5B3azmn0hau909G2Qw8RHOBDTyztZFVI55/MTK7DWn?=
 =?us-ascii?Q?MwgnKSatXztWR3og6nXeC7AwOnKoE6PJU0fmtM+UBuTFmHANedrTAZK7YB7K?=
 =?us-ascii?Q?9PfSYCC4abF7C5h1+91vVPt8sWriWsLD5CI+f2slEVuta29AJH0qiJ65DRi0?=
 =?us-ascii?Q?L753w4iUkKav9OozA0H25MdRFYWO+ALKOlqjGU0c4Weoj6thDHrhavUm/xjQ?=
 =?us-ascii?Q?xcySyqZbG3GPJ/GxtOGais5+lBdHZnClPlSdSxPxhEf0KvWW4i68V8U4tT+w?=
 =?us-ascii?Q?BWGMF3BU40P8zNhQQnt+/sQKztGmJzr03o/4KZ4eQfRl6Xle1Xt+zIgMAm2Y?=
 =?us-ascii?Q?YlVRCiL6ca+cpx5/Ql7M+lG4a+XnT82CbrIe342OijPI9OnKQCqRKgnxmtFM?=
 =?us-ascii?Q?kGmwozlwfhTsyqHrDYAuyC6mvblaAMuMtEUiO2DsyvMffpysLWcOwWJ2GfcZ?=
 =?us-ascii?Q?994kG8+NLHzMZ1gESfPy18IS8cIsUOO06zgxeDqErwfd/bKqbu02bQoUCWsC?=
 =?us-ascii?Q?tiutM++fixAXa5LfC/0eTl6fTnOo1TVmE9SsLprjPpSwXojfLo+H1t9lwBFo?=
 =?us-ascii?Q?RM1uHqRcjOuZlYstJK+aLAIKDVvzz8TFg/oMRF+Nfm/PbHn11fMqbfTfc7Em?=
 =?us-ascii?Q?nHew+5HW36xexdiXvEmopkf1knD2Akwav1T0c8DvkrLG1JaryXfSydlIAq4Z?=
 =?us-ascii?Q?rDooz6R+PO2V377ieF9ENeEEn/iJiN+iCCeZY1vIOODbguybbE8fDVaTHFfG?=
 =?us-ascii?Q?mXV9PVbdbqQ0pOoHswopPz85QUculQVHnpM2KAor0HluGFsCN0Puf/E45mpW?=
 =?us-ascii?Q?T6hqdhcvcxqWxbLZHTvhBoH7rdaU18vAyyvEaj92/16yC3zf6WuhM+bh2gy4?=
 =?us-ascii?Q?GBP3vJsqoY3AeZiFzKyteNLsh6g8eZmhMXuJvj+TGMeTPwp0M243BdvJlp1X?=
 =?us-ascii?Q?6K+Sf3XG6+nSob+oobzsEV1RcLKLr9DtK2C/ZXLewm8YoNiKaCVPwsXsAQyR?=
 =?us-ascii?Q?dqkk2+Do0zvHohbfi77CNxTiBPxDFzbeFVv4axC/8Wqun28oCSSNd+glfAsI?=
 =?us-ascii?Q?JfWIvvIG6u2bbb9Jhk44MBT2nUkyc3jkWFrENDvi9LzYaBUG2J8geTd2olon?=
 =?us-ascii?Q?/kwR0puWzJ8FQ0W1Xt3Iz/CKsN/mCggqQf6HvwTlfuoIuUmij6yBd48Mw92f?=
 =?us-ascii?Q?VR7HYoyXsS/Awp+XfOftD8lvzM31AtkvthHYaQsUqhbIpnzLm9aF2ZoA9Cig?=
 =?us-ascii?Q?w8K2BZKqKDR8TZl5iVwVj2k7eocBmbjHflSERs7E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b870a9c9-aec7-43d5-c0f1-08dd578e9032
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:26:37.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRIyAS7Srb/tNl0B+3ljq4eAGgMx5ZIoUsDbCIyvhgbiVa3vxudhOME5xQgDv+Fp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433

[
We now have the required three drivers on the list so things are
looking probable for reaching this merge window. I will work out some
shared branches with CXL and get it into linux-next once all three drivers
can be assembled and reviews seem to be concluding.

There are couple open notes
 - Greg was interested in a new name, Dan offered auxctl
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

The CXL FWCTL driver is now in it own series on v7:
 https://lore.kernel.org/r/20250220194438.2281088-1-dave.jiang@intel.com
And a driver for the Pensando DSC (A smart NIC):
 https://lore.kernel.org/r/20250211234854.52277-1-shannon.nelson@amd.com

I've got soft commitments for about 7 drivers in total now.

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

v5:
 - Move hunks between patches to make more sense
 - Rename ucmd_buffer to fwctl_ucmd_buffer
 - Update comments and commit messages
 - Copyright to 2025
 - Drop bxnt WIP patches
 - Allow a NULL ops->info
 - Decode more op codes for mlx5 and the sub-operation for
   MLX5_CMD_OP_ACCESS_REG/_USER
v4: https://patch.msgid.link/r/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com
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

Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Aron Silverton <aron.silverton@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Itay Avraham <itayavr@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Leonid Bloch <lbloch@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

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
 MAINTAINERS                                   |  18 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/fwctl/Kconfig                         |  23 +
 drivers/fwctl/Makefile                        |   5 +
 drivers/fwctl/main.c                          | 421 ++++++++++++++++++
 drivers/fwctl/mlx5/Makefile                   |   4 +
 drivers/fwctl/mlx5/main.c                     | 411 +++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   9 +
 include/linux/fwctl.h                         | 135 ++++++
 include/linux/panic.h                         |   3 +-
 include/uapi/fwctl/fwctl.h                    | 139 ++++++
 include/uapi/fwctl/mlx5.h                     |  36 ++
 kernel/panic.c                                |   1 +
 tools/debugging/kernel-chktaint               |   8 +
 20 files changed, 1519 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/fwctl/fwctl.rst
 create mode 100644 Documentation/userspace-api/fwctl/index.rst
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/linux/fwctl.h
 create mode 100644 include/uapi/fwctl/fwctl.h
 create mode 100644 include/uapi/fwctl/mlx5.h


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.43.0


