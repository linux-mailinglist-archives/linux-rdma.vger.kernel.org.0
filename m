Return-Path: <linux-rdma+bounces-3455-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6E79159FE
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 00:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D632D283661
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FB51A0B00;
	Mon, 24 Jun 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VZFe7Qdy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5747A64;
	Mon, 24 Jun 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269263; cv=fail; b=IaupgRUoIH8yM4hLWGf9KPJuD3C9rlXe7OSHcsqA85qC4jZcEYNTxOO4p7Qjnzf+3E61MWpPLCUYvuWDsLHh7WcrSuufTNNXLBrTfN+1taqUsdIKDMKvWgKw3JGswdSNXeZpyJLU++NNFXhY7eqcmDHbxaLWshVn0vGCMb8p4q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269263; c=relaxed/simple;
	bh=MGzSb58t0NKwPF3BEpf7kWtxmidBzRaytlUCxg6M6u0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hWc0QVQOJHAo2Xz+3V8b+6cJGF9tStHrtlmSLRJ17wYiNwL8vwvE1lAF8wBRvIANW5Re43o9C+9JVTysAB714+cg5ODrAdCFfjElqP9oKVQN3UN/ae7EDjyz0dt3rt2GgF2vnWRb13OaSQ10/oqwfU17dRV2mOZPsC3yP6ABOSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VZFe7Qdy; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR9fYB5Zgi420/iNtOX5S70cm4FVax1MAHGL3/B2rvXYYse8UmAJL9YnbKNxsKf3uwZ/vutf5c1M+NQWLa4R6KQDhw0BTRpLQPcNqlCq3rp6mu/SxyTKERPYfBfgSajf5Kl9g9+sbiXdRTXbln5KzwCC3P+jT5nG5lTMX0N1oWnDhYcAMdKKrJXv4ssx0QZxNSP6K/GFQjmIVtU2Y5E81cXAiOqlgqFvYvt8xdv9lKxjqnkkmGl6nG6NIcubVTYDPs+957wg5ol0Nw1tyQFNvIMO2MiNpfqTJOmKLX8Yoqwr7rPA48pBhJA/MTSmUmalcXg/7PdF/DtWF0QmbGpv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1U6K6TM2WFycCFUPvrzhwTmcE3dUuMNLHI2fFG3uII=;
 b=KiSlKgCpW1PreV+9dZ6z0z1lZm+uos6ZfbMwFd3t1nqK6Uu8Bqq49VqKaUcmOkAcFFJqE1Cdp4Dg6U2KkY+tZoduhA34h1v6vcM42Lj6IXiUPn4bFmUVRozu4ZUZe4U5uSrzxD5vSqf9RqYiKaPB7NZRfFTD+NSL9txrVvBQMWB1IwsUEwZlRGT69KNbnR6l+RibU0tSFv23U1BndBDi8pLAblbxio2MyfZPFq1/ZjCIK0+XELeI7eYKQpnFXjC9WBpLVkr4WymeiggK0mu3cVbNILc3ygXULOl4JfgHKA7J+jFEECYjbuLgUruIiCrz9XVAHrbsYZWTLQwdaMyUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1U6K6TM2WFycCFUPvrzhwTmcE3dUuMNLHI2fFG3uII=;
 b=VZFe7QdymqUlaod19U9sX6nYPDMLi+OeRPEHvflmnm2nMajlRaBKHwG5hoyvSaklWi1zIoEJ4bCEHjapEkyHs7fL9T7u/+qUzsLJoTxBtp8zySfBIsxSD2eyE1ckxAzfJON2r3QR+QzhgYnLBkXxCxq0kFV/TQzO+lw6MC/IKC22T9FrXQsvyCtoPjbYk+1EXR3mXCfCw83aCvIuI3xUgIAEBUEmuxQICGPIatYmxEGDgZOMSzuStWD9nTViReHJ8jVaalRyr2qxlrgoXtrcVvTUQLqoxSydY1MLV09tOZ6dIg1RAZRp02Akb4VYpCqyk8jkK1eU1A9J9iaGwQLh0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 22:47:36 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:47:33 +0000
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
Subject: [PATCH v2 0/8] Introduce fwctl subystem
Date: Mon, 24 Jun 2024 19:47:24 -0300
Message-ID: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:208:236::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 3167174e-eb32-4b75-2020-08dc949fa2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LjBaRFrrWbMyKWRQ76w/z/jemXOuR2CXD+uS5+gPFnxOKpaOUBj47YYzNNhx?=
 =?us-ascii?Q?yRxTiE6UhTR7HldHg9y9DYB8YJITAz494VGuJwT/B5v6AtZzTZ8L3fFXEqLa?=
 =?us-ascii?Q?GTZsHM7y+K/qjXfgqpA4snZsv0jaLqe+2rZ63fQ/aWv+syXf6YNz7xewD47r?=
 =?us-ascii?Q?xh6n8E2tA5nrwucnWiXNtaAhoN6rlXCBQK10yqjFbKiyPT1tYgfeaJ1fqI5r?=
 =?us-ascii?Q?HsJG0AAkvmbzS1cxyuHUAIohOkNLsJVmJXoh3X2oD1aVEvyniFOnlt4eKB9K?=
 =?us-ascii?Q?IywuStDx06lfdZkAYj0IoD4XiyLEhF/hF5jWEL/8P/JHGiVewKWo5GLCy3ll?=
 =?us-ascii?Q?KxjWPZErV3D9m0dZJzsAAmu1y5evhG56uPibc02Bhr1mfiaSpx/k0JJ8Tlss?=
 =?us-ascii?Q?VCzYvFcIrpESdEjoRBHF/+e+YozrqVmw3XdPOMUmkRtPtOQPOnCKN48NXuZO?=
 =?us-ascii?Q?M2oQ8S9+80a8A83tf/DzAsvs4SPZT467PnQoxfJJzFG6zBnKRv5JC/3k8pVW?=
 =?us-ascii?Q?IZVjzMgpH7aw24H8q7rE6B4C/JuAPq5SDA92x5AamL8QuSihjtoHRPnpmzH6?=
 =?us-ascii?Q?i+Kozv9Sj+aur4v8XLCeQWw/zxo50feu+4zQbVD6Qn2xc9CVGb2he5rtBu9p?=
 =?us-ascii?Q?j7NvXp88iouoSI8VqqNCistJpk4ILLviApY+KJ8fPqq98VqLEizNBmfVX0gt?=
 =?us-ascii?Q?z9YukLGIDa+gS7ucdykdkKsmFYYpcr2AHwmMYsdCOeM+302aDL3OF40RL4AF?=
 =?us-ascii?Q?UmjEoCq6Kk8ISNN2O7ZIkcRx7OBN7zJ1y+H4FmKm+lgw18EV6D4AAJiPmOls?=
 =?us-ascii?Q?rJ1cOrBiN/aDD//uzG/ipCes+ur/ivzl6hWTejNJ2FexRESI4Ld5Nu5JeT0I?=
 =?us-ascii?Q?C5Qx2I6sixHtY6pnP0jV3SMasTGYcOB0oxce2R78P64ibYPHTsJ/1Z9JbOPU?=
 =?us-ascii?Q?v2Gj+5rZA+RguTc8CbB6AnAwQBsWTXM0T1qLOstCyeN30zbXalLO1zsIUzRG?=
 =?us-ascii?Q?Xfrs/68S6uaokSYxFXJlohgNKHmiWqb6wS9U7hQuxwjnmSUlvLdWcl905eMZ?=
 =?us-ascii?Q?ydCoXJURm5Jini8IG2CsNxhisBpDan9l4ugEDGfV3jVgc52ZGccaa61N85QC?=
 =?us-ascii?Q?FPfvNIhJf5Ul9OP4Sh51RFbcoWevFCi5wOyX6uMkmBEUgyql6rLIVFk2fsCF?=
 =?us-ascii?Q?i5EJhhillEAtv/iNru+kiHbEGokTyVCups2NC/NMkgOo0i6xrDGRffC/9gHq?=
 =?us-ascii?Q?/Vl5AggCE306pIkJjhC0q1rjgP03kNtdf+trm43C/PH7Cy7t+ub6XNvFzwgj?=
 =?us-ascii?Q?6qHYjTMjs0GO7t6DEecGmh+f418wqfIZS8OTDkz2r4qd8Tb9zsPIxMOszyNG?=
 =?us-ascii?Q?mZLhhpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bYI2bDqO9AXhvWzqZH76DxOAKDFsFDApCI+/JXDQUW607e9P7mjAEXtzhjuv?=
 =?us-ascii?Q?Lq4wJcSWk9KDi4ZXYpEd9nzQAK124ajhm548/bIIyU/Fkai6eNZuGD8RAwVO?=
 =?us-ascii?Q?yzjdwvXVgcxO0TMGjirJub4CY/R+ULaN+wvsSDtI+nJtB6ELbGFi2aMCYl3o?=
 =?us-ascii?Q?sa26va4IDCsGFmTrTfnPIPAr+LcmdvUFQWJqYPdtXActjkZnYj4RkjcGbKsp?=
 =?us-ascii?Q?iij1UZ3uLBWpcxAhgOlhmyCaTazeq9PNfd6b4wmrSRF/Lk4NSskzI/hceLgn?=
 =?us-ascii?Q?60fbDb4uRqgQqwh5lFwavJryW3S+AO1SLg0W5Qs0SOXC5rYH0CCWknDP9MWX?=
 =?us-ascii?Q?ep70RTvStRC+PPtOnZ33HKrh7A/qIp5shHYnJOAZaa7sDJARAyoay1g28M/d?=
 =?us-ascii?Q?TPz4SktygNu83seQSAOvOqkPXCJvqC8eQoA4fkmyEAyRCeOWMLSjwj2Q51Vr?=
 =?us-ascii?Q?YxIOswavt+KfEP9ZZdtzFAVZH+vfJlE8lT08orcX/+Ac+9npySdsbL4fafD/?=
 =?us-ascii?Q?9uLY6wUFWv5ugybmLDEDnDmT5IDPSLQNgPeAw0Ho7paXzNT7FE0I9Lp3Cd6Y?=
 =?us-ascii?Q?+E3a8j4WWk5U2YewpIxzs0fUz555MV8eIZVFjpxwJw8KubUTgeS8oAFuKTI/?=
 =?us-ascii?Q?EFIyJmzDciayqXcDmWrdoo6jPKcQ/UJTkSfWUOE2o+MsQFO6EPdxs1UV25ba?=
 =?us-ascii?Q?e7vl+agibDC78rgThIraQf3tykqnv70nfDFJCXP81s51/QhYrOSffaJTABiq?=
 =?us-ascii?Q?cDVHlBwhuEFjiT1GZzAY9PEHXNOKLvTJSGKCqBz1IMX9tVqxs2k3/+REQO8T?=
 =?us-ascii?Q?YVLwhLNEinPH/Xm/CCRqiZmQkc9qzA7b044t+ZjL/x1yyhd94O2a5+LJfiK6?=
 =?us-ascii?Q?pWocT8A/vAO/8VvuD7zwCw/4XoYbzsz1C65VGR4Ny2kyH12JxbaVmBl5L4F2?=
 =?us-ascii?Q?CacVmMVoAaU2R+axu47zgvBC+ABSxxUYzhRb72+/O8rt0wAQPh6MLfviOrQh?=
 =?us-ascii?Q?RW2cXeOMETHDpP9GL7S8ZDrn6GSHUEaDw4/onkKD2bSJ0gtmq7HP2gZDF/0L?=
 =?us-ascii?Q?rKjbEddoM429NDZgMFdDfLGLKp/uoCOlYFOPdxyzbcUinyk/ER4nskJ6yBUL?=
 =?us-ascii?Q?FRBeBkEhB6m3u+C2aRCgc0Swm4sMNAc2Dr3h0wv5v2zY70ssQqJ+EtzAc1yW?=
 =?us-ascii?Q?oU+N/idYoCVis7zZW6tvLBNOeriY00XAUYE9bEF/bvBV3uQCuM5ApIZMi9Ec?=
 =?us-ascii?Q?QLDIhBWXs+yxl/an4RUan9LRYS74K805Lx8s7v1r9HVxkoMUU3LgIdLxf5HO?=
 =?us-ascii?Q?w76GI/DMZxX/JsxQyQpKj+bD5ubXOLS6udasxOIdwmkHcpcmd9qmlfMH74oL?=
 =?us-ascii?Q?CL4Eu8XL4rQP5wtzJlEM7jQdDaTUGRo9kd3S7iseuTGWh5wgReX597wii/fy?=
 =?us-ascii?Q?RUAzHzkwcp+9w95fBJBFBujWOGOTBGl+k410/nHsxYiCQXICZXJCBJ5tOvZO?=
 =?us-ascii?Q?KqeJrx0pu8uSZHAYQDfnuDH7nDWGamJWrXwtLxgLhGFTUoWudVGVpDsC/Cic?=
 =?us-ascii?Q?F9hlbQBIGVKGCUt4o6EZsD1AD1pMDlfyZ3lnXHHa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3167174e-eb32-4b75-2020-08dc949fa2fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:47:33.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9pnHkrG8Vx5/Ag3VJGo0HnIp2uqpFf03/ZZuPH9Jumg5XLV8H03P3hIRSn1FVQk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

fwctl is a new subsystem intended to bring some common rules and order to
the growing pattern of exposing a secure FW interface directly to
userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
exposing a device for datapath operations fwctl is focused on debugging,
configuration and provisioning of the device. It will not have the
necessary features like interrupt delivery to support a datapath.

This concept is similar to the long standing practice in the "HW" RAID
space of having a device specific misc device to manager the RAID
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

This series incorporates a version of the mlx5ctl interface previously
proposed:
  https://lore.kernel.org/r/20240207072435.14182-1-saeed@kernel.org/

For this series the memory registration mechanism was removed, but I
expect it will come back.

This series comes with mlx5 as a driver implementation, and I have soft
commitments for at least three more drivers.

There have been two LWN articles written discussing various aspects of
this proposal:

 https://lwn.net/Articles/955001/
 https://lwn.net/Articles/969383/

Several have expressed general support for this concept:

 Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
 Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org/
 Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org/
 NVIDIA Networking
 Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq

Work is ongoing for a robust multi-device open source userspace, currently
the mlx5ctl_user that was posted by Saeed has been updated to use fwctl.

  https://github.com/saeedtx/mlx5ctl.git
  https://github.com/jgunthorpe/mlx5ctl.git

This is on github: https://github.com/jgunthorpe/linux/commits/fwctl

v2:
 - Rebase to v6.10-rc5
 - Minor style changes
 - Follow the style consensus for the guard stuff
 - Documentation grammer/spelling
 - Add missed length output for mlx5 get_info
 - Add two more missed MLX5 CMD's
 - Collect tags
v1: https://lore.kernel.org/r/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com

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
 Documentation/userspace-api/fwctl.rst         | 269 ++++++++++++
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |  16 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/fwctl/Kconfig                         |  23 +
 drivers/fwctl/Makefile                        |   5 +
 drivers/fwctl/main.c                          | 412 ++++++++++++++++++
 drivers/fwctl/mlx5/Makefile                   |   4 +
 drivers/fwctl/mlx5/main.c                     | 337 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |   8 +
 include/linux/fwctl.h                         | 112 +++++
 include/linux/panic.h                         |   3 +-
 include/uapi/fwctl/fwctl.h                    | 137 ++++++
 include/uapi/fwctl/mlx5.h                     |  36 ++
 kernel/panic.c                                |   1 +
 18 files changed, 1372 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/fwctl.rst
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/linux/fwctl.h
 create mode 100644 include/uapi/fwctl/fwctl.h
 create mode 100644 include/uapi/fwctl/mlx5.h


base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
-- 
2.45.2


