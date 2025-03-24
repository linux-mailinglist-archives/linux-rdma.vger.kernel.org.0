Return-Path: <linux-rdma+bounces-8917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F5A6DDED
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 16:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6CD16B3C9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7442261366;
	Mon, 24 Mar 2025 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="icI5Ro0Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74E2A1BA;
	Mon, 24 Mar 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829243; cv=fail; b=NFZRQNRkxG9T3MESGmyqJRYhZyZ2ipjqiB8Os5G1kCZxyoGIjIhbLJ6iSIYjAMhpAFcRFEu+qRZkx8YeHmRU1IK6o5Shw7wW94OVyCRb8ph1wFq/E9RUpqU/UfZNdH4ePmsU1MH3enEiLMD2Ttj31T4FrEiIa4d2dUlunrDo5tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829243; c=relaxed/simple;
	bh=46TZk7oTUJW0VAd2cqnJ+KkgvTmqs0+CPJE+PGTr6f0=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EEL38N92UxqP2VDbOzU7P6ce/ZQD4BG5i0VHDGjL9GosAislLcMejCXeMD4kWMaxgzXGj3QAv8VP8d1ks1TJzudlIhyNJws17pAonmkrxRO8ajX42P+M+878n//sb+4fnp7YcN4refCm4ION/4qNAhgFniZmw4CpFR+avBKUw3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=icI5Ro0Z; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4+QSeqE0u8Vwhfb8gK71hqdrMWMIp+kDwttHJwc6tDihEqDHkSL/EhXO2B8V1EHuemPyvUMJ9JOHzJmcxxcydd49zSDWIMx5INpj0hMX3ZqX7RiG3cMDRCIAjNLccTYxBiOMUQD1qXiBKQfobf3mqbpy085feDg3CE77QUQmR/xftxrQ/l8IGwLJUdfOeIQKVRgXctpXYkzgtrQM5ulV8bAcL3ST3Zr5EmaR/vxSflZLr8pmklw8inpUEpluflKvf1X1okMcD7J6H47dexBMM76HvPM3VP8yhdGpnw2A2HipU9mVcnyjM8AMdt5p2Ht643UPpoJRHfngxhuPNJLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTXe7BT5TX2gefj/+MMC9J8Q/3u5+Gc3jVYUmd61YhI=;
 b=ibcCIfTHeui+xoDSEM6MYMEYeoiWtGcviutBUY5VacmVU+18PBnd0EyNDkZtBtrEuYeO6aox4dVdble5hSPbNoqXXsLzQzgHWPKJuM6h8DoFukxlETYV8HEO+fcbqnh2fzc8BmTEAZER5WwOT3gDDQYAxFBgUiB/uQ982hViJyWeadHXkfPQt7weIA0e3Jhk4yQWUOoVo47AGxtj2LDzW7hvcEqP+Bl29R7gH52P74vlTTjY2YTdBrzQSwa8eDuP8K6/NMDX9pxxWmrj3EjqksgbC6SacyxgJFnEji1ACc82RAdJjs97i0/NLfG2SWxJdEyHn0DGeJ9ygkoZA0gBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTXe7BT5TX2gefj/+MMC9J8Q/3u5+Gc3jVYUmd61YhI=;
 b=icI5Ro0ZLVhcVaNIXrEGqVf6iybUdF97v8ywAZ+8noAZSlTQ5ujfPTMVfR3b9G8W8gjciVLjVb4bgApkTImQfJ+vKm5RByypkSguKOcGUJR7NlHlyJ8Y9dsNwEW/YF6cSFWIOc1anSO/84MXKDNcV32vt35wWIW5FwEGdF4cPZN8LIdfq0wgQlUgsBOLD9FngeS1SSDZpud9DPoQJqRaA6aHf3KTzhim6W7LNvVhW8khLDE6BOnKSML2p69nF2j5dJY2FdIKz7aBWCjDZyDy0EWHEufqDisNHQ7Zr/bCy2SP+dg2G4QUUtwOnnmpSnVHV8hF84t7K2c2LPdkRHY7PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 15:13:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 15:13:58 +0000
Date: Mon, 24 Mar 2025 12:13:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull fwctl subsystem changes
Message-ID: <Z+F2tcBM1LJpTDF9@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HsutAd9tIALeo6cu"
Content-Disposition: inline
X-ClientProxiedBy: YQBP288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 144c2793-3717-4a8a-8ccd-08dd6ae68017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CS34VoovbDCGHnq/w+2nG4ftp9EekBX4LnsisYx2OWlgP3ZWGeodboG6vUYf?=
 =?us-ascii?Q?sBI+6qazm8mvkxMjIo7c9OFfGvBQxl+TjtfV0JK4+OBwjhJNNM2NAMBh7LYL?=
 =?us-ascii?Q?XcreWGbxkeSxSfUMwX3MiE17BFsKij0snxbnWf6NP7XnB19zlGcOlTPSR9dy?=
 =?us-ascii?Q?u+avcJGxslbZe+Pgbyy2vn/AwuZj1TWoQQ3AiuElbiHb4UZAYZuAymvnfvUJ?=
 =?us-ascii?Q?wMy6RFWOclER8PlqIuCCk3wdJQ2N2gMLBADK5HGIyqvLZ0/9bCIvsIrODdFF?=
 =?us-ascii?Q?CT3MnkE5ETU5enjG1N0E97T9enerLb10egRuXnprg406Kab+xKwbCHSoQPDp?=
 =?us-ascii?Q?tdIK8v8naDa1dCWDMV5PU0gHBrQGvL/e832fuv53BNWVfoPoT9FUe9/w20Rv?=
 =?us-ascii?Q?knKpTuGBuWyIiBAAzeHb+fVNYIKx7apbA+YEvxOaVpwo0JtI206175zL3+Go?=
 =?us-ascii?Q?PIx4ARloJ+2+BohXHCWRPOtRov4a4Hij17lwKAnFqf0wRwHiVN4dRPg9+Fug?=
 =?us-ascii?Q?OsEf2VYkwS7ULIsD1uNdQOoFrAYnRWJqG9fN4A8vOfBcRZTEr/oD0s6eAawU?=
 =?us-ascii?Q?yDUcp5/9+WwCWo4sb9oVErn8b2ki1/mpF9xguc0eQ4ef2105fsSllSwpA4ob?=
 =?us-ascii?Q?vhR/qfOlTWRlqg8tgiZ3oNKH1OBBAldSrNi2JgMuBBqXh4c2Yt8Bc0SnjtQs?=
 =?us-ascii?Q?uaHxx0PWYIaWNa66rRP/Qzbu9QSLwKEIz7WVnIaQeVLZBCyXPoPrJxbnKqez?=
 =?us-ascii?Q?n1HMz9D09tCvQaKRK1NW+2SMm43u6T6GLaZrx8cNDQi/Tt9brOlGp7zob3fB?=
 =?us-ascii?Q?+3CPumM3ZLuAJM2r2SkMAVKte9D+keoHCQkGkc9YQhyP5+AXjG+0KoBCWvh0?=
 =?us-ascii?Q?0d29VAkhmX7vjZc/Rn/dzk6otIfgwXJcIzvjWIIVFiZ/IOu7zZYzddd9url8?=
 =?us-ascii?Q?y30jbTlwWZFzx7GRoHe+E+YY/K2nC70vfjCQSilVgTUpws8++PHtSMtAAyHv?=
 =?us-ascii?Q?/vGsaMWfI1PnkXqB+luQi4wN+9TyGtNRzdlX4OTzzLrqL5kwk4G1yD36miv+?=
 =?us-ascii?Q?7M3xKv7rWC4o1z8UfArFWh02fBtEdSWN4TlBQj+nJi+RhkxzNRhNRvHO2VS/?=
 =?us-ascii?Q?IAYLi7uWVmdKikDVyvYkFBYkCwDabDVQvObZaq0wxp8x0FVxBKTDABNQmdiN?=
 =?us-ascii?Q?2i/f3geQtx9/RzsZ3NubpUzdpIn68IlVASGSb0IWi9EUNBrdTNOMTGgqkvWN?=
 =?us-ascii?Q?Uleb3QZYO5V1+gzvtDQdvf9ZBZCNI44qwOP4UEZ7D/gNbWwRwFBf6pLERIEJ?=
 =?us-ascii?Q?H+WGBrTF+UGcWfsZwbOVT2bclHcf5JEKLov3GDvWSibS8MgFKtVMgMRP3T7r?=
 =?us-ascii?Q?2Juqj5N4Jifk6cTVdNGXZs2EZvQT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWF9DZW3iGxPr1lIFH8EZKiOXhNabW2hZiduMXHMhjwTS13k2y4UcGsfVENO?=
 =?us-ascii?Q?VeOBWleIoWiH6LO+vgLkl5ZX75oEXBQYhgaXJiRdagCNNdJCM4vTPCbuCjyn?=
 =?us-ascii?Q?tcUIF5102lDYgAXAUjwSD5bayXyEwYL/koG/AQgQsBDtPXZUWi0ILSyHINIC?=
 =?us-ascii?Q?Z0w8wLv5MUXifegOOBJZZ1vFW62b6RjR0Ux52R5p628CTSag/mI7+2PPdggU?=
 =?us-ascii?Q?z5uXaGsiRCOHQS+esF+zPfRFdAg3KIhL2iZ58f8u71z3d0aT9gtA0SeOhTer?=
 =?us-ascii?Q?Lr4AQIpX34h2LdbjOukDQ7NQf7xrrQv0DoYLt6Wpc/1wVKpwPoZqse79VEx6?=
 =?us-ascii?Q?s+2bcp1EP8SqcgDLmhPORThh6tPszmGheKJahcipZc2ZC1NkHwla6mWK+zL3?=
 =?us-ascii?Q?WV17GurmLulCkZuudRZL47twQgsJT2/yuJmzDQumsS39IphnuFLjvDtapoQd?=
 =?us-ascii?Q?uWxRLMTRv6ORfLzzqKYm6wpJ900+ao58DYvZ2vyjUgLoN2Leh5kAh4ddCSaD?=
 =?us-ascii?Q?vn+9aBGBEk1DoX8bbxuVeQAWCnqefmwNrOkiAE/mHKmgzG0merodhPa4oh4Z?=
 =?us-ascii?Q?6RFI3ZUD/iCOxZdojTdS0cX2BKLxeTAMxugvaiE6FS4IoTH+0acDT55Dj6Dp?=
 =?us-ascii?Q?y9LFvAQzqU2udghk9Lp7j3fS2q70xHgutllEHQk8fTXRmfsHLjl5QCiua30g?=
 =?us-ascii?Q?exIB1Iq5bn3D99Tt7nRmBPrf5F0Fxmv6LtLAC7ppnJzXumbRpehZJkKsIczO?=
 =?us-ascii?Q?Knf1XD9uO2Ur0eUvjgl7cy29HfCKKeKTjQ2Mpe0XS0llz233WGTQgQwpDwfy?=
 =?us-ascii?Q?P7Y2jtX3OAbv30bo6Bm+deXS8R6EYgar04ujYP0g0XxxXUXU+hDKC3sF7yT0?=
 =?us-ascii?Q?iZ3vQwmHxztZAyZBaX6bcEqIuy5Wl1lr4TV41owtiejm3B+vum9rhRMBomZU?=
 =?us-ascii?Q?s9sWsSDKYaqP1IyXFwdSEQubv7ySqqT5Ur3TTu7yzWxEF0lkRgXbVx2Hizrn?=
 =?us-ascii?Q?rFeX1VVhQsgvVUYsinKX4R7q5O9PIpOJe7acO7CGHLXppzXnBXVGrmyneZki?=
 =?us-ascii?Q?6JCvS0MSYeoxkE724McURiT/WW0p0BTnzrs6rTXDYoqXdpgcvJMws0wQ0ylw?=
 =?us-ascii?Q?PlST7iOOa0Cjb5iVA70pldxhcpB7+LxICAmPOK1G7NpAIPc9uBZj/zrruM2H?=
 =?us-ascii?Q?V6Y5bcNfoTmKcensxe56sN7hGvLFYfMpfgPhiAgNZcA1CoPoALUe2ksmFKkV?=
 =?us-ascii?Q?K6dR8jdtyhdqX9aytc7mV751XwAlaPI/RZrO/nVSgXjVMld34QqhH1w3nxul?=
 =?us-ascii?Q?6SuSUhnJLsTlBfDCer3jCOrQopLwNJ2a8uNT8rJ1fVLfZOK+r+v+F0JCa4Sc?=
 =?us-ascii?Q?t/cnVHXbDRZdu5QqB53Cbm1WzOWnCuA2PfWenBaAzfuWjjBChvslSuamsQtC?=
 =?us-ascii?Q?T+WFwF/N1hLI50ry/GGb4EyArkDqt/xtN4Lhn1lfCDHXmTWY0mBAJelWaIYl?=
 =?us-ascii?Q?VI2TPZp7MPvwkkiGOe/9/wWpYs4TF7qRnGWeQTpo66be7pPNGp9qCFH45S32?=
 =?us-ascii?Q?bqTUMUmjn63ngft5YX0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144c2793-3717-4a8a-8ccd-08dd6ae68017
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 15:13:58.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8ZUmpJm6YFMTuQVMD47Hzx4oJhdAseFrnS9KCVFkC2XYZc6+CJ4p6uEy3Ki1jXu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

--HsutAd9tIALeo6cu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here is the pull request for fwctl, this is following what was agreed
at the Maintainer Summit in Austria.

To refresh what it is about please refer to the cover letter and LWN coverage:

 https://lore.kernel.org/all/0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com/
 https://lwn.net/Articles/990802/

This PR has three drivers for CXL, mlx5 and pds to launch the
subsystem. I have interest and soft commitments for maybe as many as 7
drivers in the forseeable future.

There is a shared branch in here with CXL, but we still have a trivial
conflict to resolve:

diff --cc tools/testing/cxl/test/mem.c
index 9495dbcc03a7,0ceba8aa6eec..000000000000
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@@ -177,7 -169,7 +181,8 @@@ struct cxl_mockmem_data
        u8 event_buf[SZ_4K];
        u64 timestamp;
        unsigned long sanitize_timeout;
 +      struct vendor_test_feat test_feat;
+       u8 shutdown_state;
  };

Thanks,
Jason

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-fwctl

for you to fetch changes up to 403257070602fcd1512af6f24cecdb23da8a914a:

  pds_fwctl: add Documentation entries (2025-03-21 20:57:55 -0300)

----------------------------------------------------------------
fwctl first pull request

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

There have been three LWN articles written discussing various aspects of
this:

 https://lwn.net/Articles/955001/
 https://lwn.net/Articles/969383/
 https://lwn.net/Articles/990802/

This pull requests includes three drivers to launch the subsystem:

 - CXL provides a vendor scheme for executing commands and a way to learn
   the 'command effects' (ie the security properties) of such
   commands. The fwctl driver allows access to these mechanism within the
   fwctl security model

 - mlx5 is family of networking products, the driver supports all current
   Mellanox HW still receiving FW feature updates. This includes RDMA
   multiprotocol NICs like ConnectX and the Bluefield family of Smart
   NICs.

 - AMD/Pensando Distributed Services card is a multi protocol Smart NIC
   with a multi PCI function design. fwctl works on the management PCI
   function following a 'command effects' model similar to CXL.

----------------------------------------------------------------
Brett Creeley (1):
      pds_fwctl: add rpc and query support

Dave Jiang (14):
      cxl: Refactor user ioctl command path from mds to mailbox
      cxl: Enumerate feature commands
      cxl: Add Get Supported Features command for kernel usage
      cxl/test: Add Get Supported Features mailbox command support
      cxl: Setup exclusive CXL features that are reserved for the kernel
      cxl: Add FWCTL support to CXL
      cxl: Move cxl feature command structs to user header
      cxl: Add support for fwctl RPC command to enable CXL feature commands
      cxl: Add support to handle user feature commands for get feature
      cxl: Add support to handle user feature commands for set feature
      cxl/test: Add Get Feature support to cxl_test
      cxl/test: Add Set Feature support to cxl_test
      fwctl/cxl: Add documentation to FWCTL CXL
      cxl: Fixup kdoc issues for include/cxl/features.h

Jason Gunthorpe (7):
      fwctl: Add basic structure for a class subsystem with a cdev
      fwctl: Basic ioctl dispatch for the character device
      fwctl: FWCTL_INFO to return basic information about the device
      taint: Add TAINT_FWCTL
      fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
      fwctl: Add documentation
      Merge branch 'for-6.15/features' into fwctl

Saeed Mahameed (2):
      fwctl/mlx5: Support for communicating with mlx5 fw
      mlx5: Create an auxiliary device for fwctl_mlx5

Shannon Nelson (5):
      pds_core: make pdsc_auxbus_dev_del() void
      pds_core: specify auxiliary_device to be created
      pds_core: add new fwctl auxiliary_device
      pds_fwctl: initial driver framework
      pds_fwctl: add Documentation entries

Shiju Jose (2):
      cxl/mbox: Add GET_FEATURE mailbox command
      cxl/mbox: Add SET_FEATURE mailbox command

 Documentation/admin-guide/tainted-kernels.rst      |   5 +
 Documentation/userspace-api/fwctl/fwctl-cxl.rst    | 142 +++++
 Documentation/userspace-api/fwctl/fwctl.rst        | 286 +++++++++
 Documentation/userspace-api/fwctl/index.rst        |  14 +
 Documentation/userspace-api/fwctl/pds_fwctl.rst    |  46 ++
 Documentation/userspace-api/index.rst              |   1 +
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 MAINTAINERS                                        |  26 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/cxl/Kconfig                                |  12 +
 drivers/cxl/core/Makefile                          |   1 +
 drivers/cxl/core/core.h                            |  17 +-
 drivers/cxl/core/features.c                        | 708 +++++++++++++++++++++
 drivers/cxl/core/mbox.c                            | 124 ++--
 drivers/cxl/core/memdev.c                          |  22 +-
 drivers/cxl/cxlmem.h                               |  47 +-
 drivers/cxl/pci.c                                  |   8 +
 drivers/fwctl/Kconfig                              |  33 +
 drivers/fwctl/Makefile                             |   6 +
 drivers/fwctl/main.c                               | 421 ++++++++++++
 drivers/fwctl/mlx5/Makefile                        |   4 +
 drivers/fwctl/mlx5/main.c                          | 411 ++++++++++++
 drivers/fwctl/pds/Makefile                         |   4 +
 drivers/fwctl/pds/main.c                           | 536 ++++++++++++++++
 drivers/net/ethernet/amd/pds_core/auxbus.c         |  44 +-
 drivers/net/ethernet/amd/pds_core/core.c           |   7 +
 drivers/net/ethernet/amd/pds_core/core.h           |   8 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |   7 +-
 drivers/net/ethernet/amd/pds_core/main.c           |  25 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |   9 +
 include/cxl/features.h                             |  87 +++
 include/cxl/mailbox.h                              |  44 +-
 include/linux/fwctl.h                              | 135 ++++
 include/linux/panic.h                              |   3 +-
 include/linux/pds/pds_adminq.h                     | 277 ++++++++
 include/linux/pds/pds_common.h                     |   2 +
 include/uapi/cxl/features.h                        | 170 +++++
 include/uapi/fwctl/cxl.h                           |  56 ++
 include/uapi/fwctl/fwctl.h                         | 141 ++++
 include/uapi/fwctl/mlx5.h                          |  36 ++
 include/uapi/fwctl/pds.h                           |  62 ++
 kernel/panic.c                                     |   1 +
 tools/debugging/kernel-chktaint                    |   8 +
 tools/testing/cxl/Kbuild                           |   1 +
 tools/testing/cxl/test/mem.c                       | 185 ++++++
 46 files changed, 4054 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/fwctl-cxl.rst
 create mode 100644 Documentation/userspace-api/fwctl/fwctl.rst
 create mode 100644 Documentation/userspace-api/fwctl/index.rst
 create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
 create mode 100644 drivers/cxl/core/features.c
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/cxl/features.h
 create mode 100644 include/linux/fwctl.h
 create mode 100644 include/uapi/cxl/features.h
 create mode 100644 include/uapi/fwctl/cxl.h
 create mode 100644 include/uapi/fwctl/fwctl.h
 create mode 100644 include/uapi/fwctl/mlx5.h
 create mode 100644 include/uapi/fwctl/pds.h

--HsutAd9tIALeo6cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZ+F2sgAKCRCFwuHvBreF
YfjjAQDo19KN0DkLLPqoUhArL7u5goqgPnm6sQxEQo5jl4rJRAD+LQDz+chY97S3
vohFkN/099D7XF0zrU9SAkYOyE790QM=
=TTOr
-----END PGP SIGNATURE-----

--HsutAd9tIALeo6cu--

