Return-Path: <linux-rdma+bounces-8194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973D5A48D31
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7507A5BD2
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBBC2595;
	Fri, 28 Feb 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IjGUodcw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F31C01;
	Fri, 28 Feb 2025 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702404; cv=fail; b=tWHayCFkQTR/AT9hMLTgNQE8lceYXHfgMR24BjTcb4NVPre17dhI/plS2KS0fdL0Slxz26BuielmtV39p/WuSZAgx+nAj6y33L0PY/MTkIMnQOfFi9ywaBAs4JOmFalX6cQybB7QxC+4m06BK+n30cJp71QOLAWGf6tJCSU+di4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702404; c=relaxed/simple;
	bh=Z5Aw4wBTMv8MGkvVDyjiRF0SmAR5gxRFS/6bfShGojM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rcTZ4Gsfkotz3TM9A189csc0QXIPFDG/fWtPfYODjuKMqiGA9hvhcr0o6lCFacXrWgP/mn3NUDGGW5TlwP6J2g0NVLQAYq1cQvBXglGDPUqvA7sEmJw2/9WlTbeeizbBa+RaSTSdhDBplKr23krVoZnT8MrSGnXSKrdPi98Qj0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IjGUodcw; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyUlPXRoOJqJV5ixY47p15/B3Pjhe3e4COhjHDT7kmTdXNt/rRqE8snQ0p5cIf+zVNWmtAG9gaA++K2r64pstop1ZwnAIDI64v1fs6PCwcr0NdNlA0mpmcswNihTfHx5LkPgyypQERrBrAI7xezjM5AbYaC6iWyV25ddA0oS9ID5XR4WO/mWSULDOYfmb+vEXRDf/9MNycKbzMNzBdM+WqkQLGU+iqK3dfm8DoKsQ8b6/luEoh/y0ZBpkEgCUmxx+N07l01q/wxcpC3HRz2wv4tEi6DWXA2NVUFktzmF8vGuXxiI2wZQA4VGYiIPp0JWQIJydzvsWAcdHd3ihNRQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9wbkuGvqVbCw5Tr4oH5HrhEEdWED0ffMbEFlt8mTIo=;
 b=nh4tziJ6DCvWzZeAG20clZNjOj8zioBPEU+ZkH0IrbUe2JOrkg/gfUQeL1Lfk4cnc2tWggxwSDDRwFvtOl7+6EDrN/5MGwyifzINW9gBaLGTXSDtSazasCic9YPDEeQ5KZuPnoO1GivVtcDrvPC4jTLHmd3+t5TWqbkG6sTnqFiHqVzNXZPoOr6gKLyhLAjiNFdG6JoVfbDKYmwYnr9cVzcT47s818Vr6wCl7k2WFem92vpKqduFABfTLDHvHldswKL4iv3SQkC04h1qFihMojGqQgTGKQcPTfeWw61lABSSM2Pr6Jt+j6YnT86TsLzPIHExXazftuyqp/+l25cSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9wbkuGvqVbCw5Tr4oH5HrhEEdWED0ffMbEFlt8mTIo=;
 b=IjGUodcwbZsmdkBu6ll00QLlo4xY6v8zBJ+N3v87mXdb+vsaTicW97NebPVFKHBCW7QXjDNUtImIxifcg6kqqQ1EoiDYM6HhICkGxI8kP3SXP6fukxKse76kRMN955zraJf/5DOPOGcImFPEPPSL9QpQOVJq3BsARZUl+sGTesn+VYL8wHgxmqksSwSJG+nvyY75FzY9RU6brr/XK11KZ3ocDWmTb2/qPswj0UwknXHXpjVNmmUzLZRRVf7kwNJod/+lJCl+ygVVA5cB3y5C3M9esYAonwp3ufYWC8SOD1Qox8M3+OUC335qS0BVisSinAy0zzlyTbTlH/K0T0CLbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 00:26:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:26:38 +0000
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
Subject: [PATCH v5 8/8] mlx5: Create an auxiliary device for fwctl_mlx5
Date: Thu, 27 Feb 2025 20:26:36 -0400
Message-ID: <8-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0145.namprd04.prod.outlook.com
 (2603:10b6:408:ed::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6e6353-aa11-45dc-55b4-08dd578e9036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G6/IxJoxqvOTPy9troZpRihDJ+42VFEtHvnCil3fHRXQXoTD9PksKeSvyf2A?=
 =?us-ascii?Q?aGr94JB+BkOth6+YFZJyrjOV4FI29BkCUNISCXdHPuQxAiWrqUyK/9L+QOpe?=
 =?us-ascii?Q?jzMXbi0DscnxwhdIPHb1bfO8/FFHhi34c6g6IJuEf7DmKSc+iAphzECj+N0N?=
 =?us-ascii?Q?j9UcHyDgP0fRk0LlzMQ9yEwoJRUNkQZJ+aEixPMFL2TwbcxgnOK8sknd9k8D?=
 =?us-ascii?Q?qA2sjumocx7a8L2Pq1X3hZissK9yi762gtrjA79x3m1xkLFWcsTMOHRMNX9K?=
 =?us-ascii?Q?FLokNoG1835CUIe5MXu5vLGWRkttb8CAIsbdzihyHGpq4/Et2OWYhDBt4xJq?=
 =?us-ascii?Q?KzdSOwG6JUBNZSBHKirr78fC3xjsBOYhJjgTSzfBTU8nxAEn4DGrHGYWYdgC?=
 =?us-ascii?Q?Hbcsk5heTiaFAX8zoG3VZNSd4JHsAeH8HnFbvhC8yMM4nDe7HxDQHKcnde4x?=
 =?us-ascii?Q?FIqpEFPNUs9XkXczKgu3j7bxkWItsB393GnyicueRNn1r7jVgckbL8SlZBqM?=
 =?us-ascii?Q?ZukZik1s81yD6x5msepNGD1O0FHCueSuQn7SP5zg8cmJNOnLZ4tUZWsJD5cA?=
 =?us-ascii?Q?olCILi0JY54z+8gh3waFBjYm3/8kXd/v8V7ImPgb8bO6O1rzfc5+8IPRfA5s?=
 =?us-ascii?Q?+3YDynBcKcJB1KFSziQmkIB/sE78EEBrKFF49dpHtemCTO9Fgkjdd0iATFz9?=
 =?us-ascii?Q?2q2cdMLvP/ku8F9e/CHYxpHfMEA1GC1XcvipuNG7AB41WvqEdP/VXCqIjugj?=
 =?us-ascii?Q?StHU6pNDJKiMW+cnpJh/qTUwGsQgtbpDAcsZ5OmKP9NOkhzfBE6yR1fv96b5?=
 =?us-ascii?Q?QzmhfX7Xv0V+eFUw84M0fjd/RooOyMqFP/Tnu05kb7Ywnakx29tyCZaa85iR?=
 =?us-ascii?Q?GpleRnkj+A8W1yFHGAZWHxp9OIgsB0urcDjbn8iAMU7K7FZoHSdTKnx5OxZj?=
 =?us-ascii?Q?6fmw9OfV6UvgbBLvHm2vlqInd8HyZDO9D6IGmlbplDL/dOduVdMfw2QS/Tcf?=
 =?us-ascii?Q?G3SuWBaVlm9mytYVK5kovEyyap6UE6BNTTrEXqNMiDK4CodrEEAE13iE+QcU?=
 =?us-ascii?Q?BQrGfwZOl9RawGQIu3P6/BtxkCe2TE2HipWkJjzbI9MfMhV7rRJGHWAyjsMQ?=
 =?us-ascii?Q?8hYHLMG6Fc1HAt6fx+37VIlq2K/kGuaQfaMnjS4S6OFkrbJSQNzWeULaYWqS?=
 =?us-ascii?Q?NJ52zgtXL3BzS/IKZHZPcSiJ81VXnS9C2TO/YVNdk7396DfmmaV+5cj9L7/4?=
 =?us-ascii?Q?ZXfUXmfmNA/u/rLMszB/EMPk/+MD5SQBO5lo4+BLA6OTAJAvT9C3z676VmNk?=
 =?us-ascii?Q?QC62EDsL2n+qAGDZ4JjYq98hG2BYLTmrwTu5UcCnaCcuYJ0qq+xCo1b51SXm?=
 =?us-ascii?Q?PhBhSvcdYStyGlrr2gNky3SfB425?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tfb9yIsHK1UsVdt9PX0naSxYELsmr5NeikuKEygby45QQ3Da1/OPn52Gla81?=
 =?us-ascii?Q?jQuIwo1fC2Mh51FQM0gBKBMIfJp+Ps27legaRtnLXajF3r78KKqGjp8hAtS5?=
 =?us-ascii?Q?gIUmk6wNiiTM7UTpqRo0q5/FvBTvQ0mCOawmkE1tXrLoQObJ1dGK3fU+TCkO?=
 =?us-ascii?Q?6Pk4pQXLqFDx6ZAWRVIRN4TkHDqzgNIx86+wU3eH3pQv5hozh07lAZTJUQQW?=
 =?us-ascii?Q?lXom/wCCQjDGrYl9FpL0Bkasmd+f/RAPkL3Dw3Z1SYIWX+E8cCfCM5ePM6GR?=
 =?us-ascii?Q?yFSz7LjrZkOvopvnbYx/Zmr8QDm6f2fUUkIVI8mIjQn1Ll6x/5k2Bpyh6tlU?=
 =?us-ascii?Q?p80a6aR+9/grK/r7lON1Nl04rv8LegHmgFJH8Tcj3PlkL5oQw3I+B8oRZVhT?=
 =?us-ascii?Q?bh3ZeD1h5MEC5L0lftzQ9ldhHust3FL9yKBX2bcQ05foxrJmh9YHW7aX/kqQ?=
 =?us-ascii?Q?IWQlUBLKRjp7XAb15sLnAfl55V3zfljN6WCXdh6EcmKEH/0JlsvXYMM21Vyl?=
 =?us-ascii?Q?wizWEb1rBmPLXN1UaE1PoHlUxX6soWIIVyadtqH5oa0UamKfN6df+wB5oou5?=
 =?us-ascii?Q?s0kRX8FzoYKDq75DyMCHzAwJ12AzXV6F20cMGjIMNXG6jx/M2Nq30uHQ4qIM?=
 =?us-ascii?Q?pC6vjd4VZ55Gfzy1c2/rjvVVlq8IJ52lkeWLOnFEHvcf2BvGIhNbYdInIxAz?=
 =?us-ascii?Q?xM7tnPPUAEqeiV50DI8n23xdAypTyUQld7Xy2sNKiBOjSeZZJquzq1cdl69d?=
 =?us-ascii?Q?+WNZnwMkIf+SnNO1swEcGrlmfqQpwexFRErD9/K/FBB1IJ27FNG/yOX902m9?=
 =?us-ascii?Q?XynsTSr25TYAz+Aw1DfDKhqgcvq5U5tSAZQ1nepSm4PWA2mGU2FPAP4P3zfs?=
 =?us-ascii?Q?Cz0VwwG6Hdi0KvO7XJRbu/FNEjKIuvNXg8JpBio/GCQZGo2xlPVVXEZ++Ud2?=
 =?us-ascii?Q?5wCsHOlWHcWfhMupxDeeQOn8W6pqgPmA8sp+lYIzFqXD4ZcMPRbqQsKKiF2Z?=
 =?us-ascii?Q?6npD06ai2QHxQsBCbcDC1O6QuL6dSn9DFuD6bOWjKBarvlGYCGvUsXeqMflq?=
 =?us-ascii?Q?SjRI4Nc19t0lEqNQvsplOQn+H8DZd9DKYN13MNJIUx1Q+Di84OivZPoaW6fV?=
 =?us-ascii?Q?hJ/VCF4bZ8V7lbFJWuJ21Y4jI3hK/2TKJCD+t1ppk+nYZwyHJvup/ytwXRKa?=
 =?us-ascii?Q?Yd+VWgx+lE/H0Znw1O8cTjivI+VYWLkF6r6k9C2y5QYIfijMhK6d8b48kwQI?=
 =?us-ascii?Q?CCmg5wP2Hp6Ndjl6Hx+i5PHVKRfsx7aYaY1HR2yKDkVbQjmuuiIZ3HuJyzf8?=
 =?us-ascii?Q?8cVbzY/+nNTxoxJTA4sc9+vsjpv7husrjPI689+pt3ZAGXtcDQ+d7o/rn275?=
 =?us-ascii?Q?QV4+0EQ0XiAtSEvkjdkghmu+JZCsHHrfaPdJQzxVd+FuV8E2DT7lW9VX9j0I?=
 =?us-ascii?Q?Ky7kT/jwrMmyeeHKOUreB4q/1xZqdfeOG4/bJm/V4xCCQtqMF1dirY2ckUuM?=
 =?us-ascii?Q?Y4SyJ1X28L7yrXKkSxHPBIPFPbn7MuIbhy7+TfVyrghKsKSVyjCnZITY9SIU?=
 =?us-ascii?Q?pf/PxrvkG829BHULRl7TZA6EtCKh/CaldvIKvpAM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6e6353-aa11-45dc-55b4-08dd578e9036
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:26:37.5580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYd7vvJLMgybjFy30soYdDIIRBGYwaHFdnsVh8XQ4OzngEuC/iC6WDmS+yADvAF2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433

From: Saeed Mahameed <saeedm@nvidia.com>

If the device supports User Context then it can support fwctl. Create an
auxiliary device to allow fwctl to bind to it.

Create a sysfs like:

$ ls /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -l
lrwxrwxrwx 1 root root 0 Apr 25 19:46 /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -> ../../../../bus/auxiliary/drivers/mlx5_fwctl.mlx5_fwctl

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 9a79674d27f15a..891bbbbfbbf1a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -228,8 +228,15 @@ enum {
 	MLX5_INTERFACE_PROTOCOL_VNET,
 
 	MLX5_INTERFACE_PROTOCOL_DPLL,
+	MLX5_INTERFACE_PROTOCOL_FWCTL,
 };
 
+static bool is_fwctl_supported(struct mlx5_core_dev *dev)
+{
+	/* fwctl is most useful on PFs, prevent fwctl on SFs for now */
+	return MLX5_CAP_GEN(dev, uctx_cap) && !mlx5_core_is_sf(dev);
+}
+
 static const struct mlx5_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx5_core_dev *dev);
@@ -252,6 +259,8 @@ static const struct mlx5_adev_device {
 					   .is_supported = &is_mp_supported },
 	[MLX5_INTERFACE_PROTOCOL_DPLL] = { .suffix = "dpll",
 					   .is_supported = &is_dpll_supported },
+	[MLX5_INTERFACE_PROTOCOL_FWCTL] = { .suffix = "fwctl",
+					    .is_supported = &is_fwctl_supported },
 };
 
 int mlx5_adev_idx_alloc(void)
-- 
2.43.0


