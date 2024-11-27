Return-Path: <linux-rdma+bounces-6135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1609DAE4D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 21:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D300F164218
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A63200B8A;
	Wed, 27 Nov 2024 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FMUZxdcA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779A12E1E0;
	Wed, 27 Nov 2024 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737893; cv=fail; b=YD3gEhBoZhqCHBEqDZkA2du/FgVyPu5XRTUGSD65bUb/0ueWt+D4d6FCB4grLCLzBomT8H6MfWohPNoAzZbZij+GHv2piypYHN5HvLn1rKrOEzKa9DbdioAZg1/8oE58dIaDNpTWFdIQANl1QJPaZmrJ5DqfNNNlti98Z2sp83E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737893; c=relaxed/simple;
	bh=woLzdmythulKbnxh1laHP+LFsqyq4HeHVUjW8FwApaM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4bNWl+Z0Agwv4/Q69ad9QudrULl5IPFWLxRmljBwMs5IRnj6wgiyhISBWW1V2rIuTCJf4Eo1UaX2Yi78nQgTOFDkwHuv6r6uDXLyv/H7py+HsVIgHT9NKF6IsuRbLghVfliMCmdQdEeQXJ7gNpqQWAjzAZFCyub4ObzxCl9Bdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FMUZxdcA; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iljPNFeX3VW5EpJ7TsiGfYI9HJlH2I7lxvRjT3N8l9UIOOhncXhaOHPfLWkI6ZQQhIXrdOHTYf/SjxOZjYbbbdsd+mW7WLnEBF74/bMfZeoUx4uCe0vpsCjT8yGdXwdl5FV/TKSJ0qe+kE9d5x6jBma5H7O262SV8rryYOAGXz0w72SMufQ2BIdoQ+8pHdlLvUHHKBj/c3czqHVw3I32XY4wGMrlAE5/FHcniNpLBaTWXpGVt6r98ZQVYyi5sptKUHVqrljpbt89x0e2SARHdivktQ6w1MjTEZRqVoPP+IrcITlpuQNLTuuXMV7DNuishwOknJ9FFB79AIYVgkw6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1udtZM4LhGGWduBEJl2L9PJHhZcwy7BAztB4ORYUTkg=;
 b=QgN0zY06h5wT4UWP2yzEoi7C73aCERJogD01ex24W3XF8UtG8n2XcIblVwFu5t8GERkzPmgTquBATcnG7oduYKjHb6lW+rOXoISeDAe8YYIPp7gqKVZKgfU52aTotfWuxQWydQAjSpXoY8EBsHPsOHnHf1W/wMVsfYm8B8811NIcceGKkvxbT52TNvdmIW/tk3pon3MtqPnnUXyHSh0neYH/+4QUjkwIacDg6KiS7pcJo1ge6WAPJXSMwmyMaMzs2Kh11qtjUYFHHq9NBLhl2acZOszQn7WwOcWnQZoJ6TXNoX9iwsA8H0kanB8X7J4rNASCnIg6vaVc1x17MmfdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=paranoici.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1udtZM4LhGGWduBEJl2L9PJHhZcwy7BAztB4ORYUTkg=;
 b=FMUZxdcAjWqYui1DK9cL8upVO1uRe3FPKZV+LvdhklWTRGV5W3N5InejGUTFjoZ5yF4jUQPqCwxygwLjnA7vmnTjXV+m/HGodCofdI78hati275Ri7x3WSE3rozA0GA0GYBYoQhuuCw6jU971nB6bIFGVZH1arN9FQdLq6EoHbnzexAV7PV0HvQqM2LH4iSodNUbgMxo3xizxczjoCEj1/COVl9w2tpr+BtqkuCmb/je7XDXNtpNjydZstXceNPouxvieHPWI+NGrNN5KCZVHBGk9oDMdQ0m6EhtWBGAE9gUmaivMZqtxV1Y3yiBWfyJyD4UEKKVUFOC2ETHdt6KBA==
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 20:04:37 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::15) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Wed,
 27 Nov 2024 20:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 20:04:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Nov
 2024 12:04:23 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Nov
 2024 12:04:22 -0800
Date: Wed, 27 Nov 2024 22:04:13 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Francesco Poli <invernomuto@paranoici.org>
CC: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
	<1086520@bugs.debian.org>, Mark Zhang <markzhang@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
Message-ID: <20241127200413.GE1245331@unreal>
References: <jaw7557rpn2eln3dtb2xbv2gvzkzde6mfful7d2mf5mgc3wql7@wikm2a7a3kcv>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241113231503.54d12ed5b5d0c8fa9b7d9806@paranoici.org>
 <3wfi2j7jn2f7rajabfcengubgtyt3wkuin6hqepdoe5dlvfhvn@2clhco3z6fuw>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241118200616.865cb4c869e693b19529df36@paranoici.org>
 <nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
 <20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
 <20241125193837.GH160612@unreal>
 <20241127184803.75086499e71c6b1588a4fb5a@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241127184803.75086499e71c6b1588a4fb5a@paranoici.org>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe5ccd7-e17b-4ddc-c3f7-08dd0f1eb765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NE+QAi76bjzr8XQAULhK+upc2btX/onhCHU5G4ARwB03PRb0sTPVwgm/zP1F?=
 =?us-ascii?Q?uUjXVVswb7Me5V2EzpJMu3bhY3M6dYZnTKDtJavINMvrftCC9KkbRvlrNszf?=
 =?us-ascii?Q?ISs03vizb+ROW3IFQJaoaNGWe53yoE9RxHez0eTw0yyvbEjwqFW3I0c/f5AO?=
 =?us-ascii?Q?P0MaOPgz5qEX8ssVMMjWa3S10RWAoFNbcfqjTLxGy/9dLbzse7Jlid4Ga/oI?=
 =?us-ascii?Q?x1Y0Bpd/fDWNoDSsitmZovZM9AFSrR2T3V+gVzpDfsBaVjJqAAnqyk+iaxN4?=
 =?us-ascii?Q?8dUMPHM2biJH6PHdzVr23iRNBz3VXXnRW3QW5hbjrOYbuBUneUGTNsoc2pz6?=
 =?us-ascii?Q?K2MxP85U9uSn/QUpfhCvX91IgyWXw72q93FOBPQzDHiC8rtw9eNg35r0gdYG?=
 =?us-ascii?Q?KRxqeb2gQMLEpsQhghGdUK9USCuPSQJ+kICOcBSJpwKjwhoYKTa5E2kPJcqx?=
 =?us-ascii?Q?WPaCQJEtlvPhoxuNESxMDvVvubQ+oA39V6Xeti7alqryevuCO2fu6FunTfNf?=
 =?us-ascii?Q?i1o8L4fTFJP99heKWRMiggWHgEMlEdRWaE1hr62U12F/oBO7yCxuEYHRw77C?=
 =?us-ascii?Q?d4HU1b73Tge9IRjhXfH+CeC7Omvyj6sD9iqeYyjOoi1PbboKhem7iXLS6DZ9?=
 =?us-ascii?Q?yvB+c3w4w45Mp3aTPlIYVGU4+/poDWoajQ4c4q93hv1Fonz0ww8vXWKqjfAS?=
 =?us-ascii?Q?WWHLmx5aYH64xgjsjRsyEsJ5M8/QrGYJARqaXeyQ+6GSsjyKW5enk2KqjjZR?=
 =?us-ascii?Q?bn4sP83iMqvDM3a/uH6peP6JdkziHzqkV2MwkXqDd7gXbtTdV3Vq3S8csllb?=
 =?us-ascii?Q?VGcbzN/RzQJulQZwwwJ6hDXN7GqNkZbUFQ0DiMR5PibudLlbtCJCQ5ukdGkU?=
 =?us-ascii?Q?sIf3ozdtWjadPGAm+oKMhd2TJMoZuxEOj+EJGKgp+jTkBh+leAO1z8uKFfm1?=
 =?us-ascii?Q?70RIsAh3ct+AgvG+MW27mkszX3F0P93iiHuucuf12B1wJjNd7ReiJUkMdfON?=
 =?us-ascii?Q?Sq0fv/IDX0ffmyivgVhjroxScRwqisSgWDbeB6suNVof7LEVNYRmttgMU573?=
 =?us-ascii?Q?E5JoVB0AoJwAtL0W67KqJQ3C8v3HbGo8MGdeuGokmNJi7hbyg0r4TWoj9i/5?=
 =?us-ascii?Q?cZeNCqJ+UCrivAkHw8VXY2kA2JT4ENDm1urCEbuJ5q7WndsxiOIg8J6jaFB3?=
 =?us-ascii?Q?12oML0xMx2U2uyIaNOJVB/5qZfbn4R4UhVIlteoOHT67koCgvNFkZM7Z19qS?=
 =?us-ascii?Q?kpLtogRzgt5XvER4hEoPeIRjKYtjc+QdrRBBCirMCjzrRAiIXz8BCD8nUCm9?=
 =?us-ascii?Q?WvjCijrbYX+GdtxaHqLjPSTSnt6MAz2ag6HCjmHOnG4JV/HOog33a9Jv/w39?=
 =?us-ascii?Q?b2bOXMPHC0GF3+N0JODnePiNZmvVdL1CaQlWbFst8FeO5Vq8StQTIXaKWON9?=
 =?us-ascii?Q?kqQrPMVU323XpfLJ/LWzlLwI6TwwCMtl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 20:04:35.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe5ccd7-e17b-4ddc-c3f7-08dd0f1eb765
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679

On Wed, Nov 27, 2024 at 06:48:03PM +0100, Francesco Poli wrote:
> On Mon, 25 Nov 2024 21:38:37 +0200 Leon Romanovsky wrote:
> 
> > On Mon, Nov 25, 2024 at 07:54:43PM +0100, Francesco Poli wrote:
> [...]
> > > I will try to continue to bisect by testing the resulting kernels on a
> > > compute node: there's no OpenSM there and it cannot run anyway, if
> > > there's another OpenSM on the same InfiniBand network.
> > > However, I can check whether those issm* symlinks are created in
> > > /sys/class/infiniband_mad/ 
> > > I really hope that this is enough to pinpoint the first bad
> > > commit...
> > 
> > Yes, these symlinks should be there. Your test scenario is correct one.
> 
> OK, I have completed the bisect on a compute node without OpenSM, by
> looking at the issm* symlinks, as I said.
> 
> See below.
> 
> > 
> > > 
> > > Any better ideas?
> > 
> > I think that commit: 2a5db20fa532 ("RDMA/mlx5: Add support to multi-plane device and port")
> > is the one which is causing to troubles, which leads me to suspect FW.
> [...]
> 
> Thanks to your guess about the possibly troublesome commit, the bisect was completed in a few steps:
> 
>   $ git checkout 2a5db20fa532
>   $ make -j 12 my_defconfig bindeb-pkg
>   
>   [install this version on a compute node test image and reboot
>   one compute node with that image: the InfiniBand network was
>   working for that node, that's no surprise, since OpenSM was running
>   on the head node, but no issm* symlink was created; please note
>   that, surprisingly, the Ethernet network was not working, I mean
>   that the Ethernet interfaces were not found by the kernel...]
>   
>   root@node # ls -altrF /sys/class/infiniband_mad/
>   total 0
>   drwxr-xr-x 60 root root    0 Nov 26 17:06 ../
>   lrwxrwxrwx  1 root root    0 Nov 26 17:06 umad0 -> ../../devices/pci0000:00/0000:00:01.1/0000:01:00.0/infiniband_mad/umad0/
>   -r--r--r--  1 root root 4096 Nov 26 17:06 abi_version
>   lrwxrwxrwx  1 root root    0 Nov 26 17:06 umad1 -> ../../devices/pci0000:00/0000:00:01.1/0000:01:00.1/infiniband_mad/umad1/
>   drwxr-xr-x  2 root root    0 Nov 26 17:08 ./
>   
>   $ git bisect bad
>   Bisecting: 0 revisions left to test after this (roughly 0 steps)
>   [65528cfb21fdb68de8ae6dccae19af180d93e143] net/mlx5: mlx5_ifc update for multi-plane support
>   $ make -j 12 my_defconfig bindeb-pkg
>   
>   [install this version on the compute node test image and reboot
>   one compute node with that image: the InfiniBand network again
>   working for that node, issm* symlinks were created;
>   Ethernet network again not working for that node...]
>   
>   root@node # ls -altrF /sys/class/infiniband_mad/
>   total 0
>   drwxr-xr-x 60 root root    0 Nov 26 17:31 ../
>   lrwxrwxrwx  1 root root    0 Nov 26 17:31 umad0 -> ../../devices/pci0000:00/0000:00:01.1/0000:01:00.0/infiniband_mad/umad0/
>   -r--r--r--  1 root root 4096 Nov 26 17:31 abi_version
>   lrwxrwxrwx  1 root root    0 Nov 26 17:31 umad1 -> ../../devices/pci0000:00/0000:00:01.1/0000:01:00.1/infiniband_mad/umad1/
>   lrwxrwxrwx  1 root root    0 Nov 26 17:36 issm1 -> ../../devices/pci0000:00/0000:00:01.1/0000:01:00.1/infiniband_mad/issm1/
>   lrwxrwxrwx  1 root root    0 Nov 26 17:36 issm0 -> ../../devices/pci0000:00/0000:00:01.1/0000:01:00.0/infiniband_mad/issm0/
>   drwxr-xr-x  2 root root    0 Nov 26 17:36 ./
>   
>   $ git bisect good
>   2a5db20fa532198639671713c6213f96ff285b85 is the first bad commit
>   commit 2a5db20fa532198639671713c6213f96ff285b85
>   Author: Mark Zhang <markzhang@nvidia.com>
>   Date:   Sun Jun 16 19:08:35 2024 +0300
>   
>       RDMA/mlx5: Add support to multi-plane device and port
>   
>       When multi-plane is supported, a logical port, which is aggregation of
>       multiple physical plane ports, is exposed for data transmission.
>       Compared with a normal mlx5 IB port, this logical port supports all
>       functionalities except Subnet Management.
>   
>       Signed-off-by: Mark Zhang <markzhang@nvidia.com>
>       Link: https://lore.kernel.org/r/7e37c06c9cb243be9ac79930cd17053903785b95.1718553901.git.leon@kernel.org
>       Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>   
>    drivers/infiniband/hw/mlx5/main.c               | 60 +++++++++++++++++++++----
>    drivers/infiniband/hw/mlx5/mlx5_ib.h            |  2 +
>    drivers/net/ethernet/mellanox/mlx5/core/vport.c |  1 +
>    include/linux/mlx5/driver.h                     |  1 +
>    4 files changed, 55 insertions(+), 9 deletions(-)
> 
> 
> In other words, bingo!, your guess looks correct, the first bad commit
> is the one you mentioned.
> 
> 
> Now, I will try to upgrade the firmware of the InfiniBand NICs, as you
> suggested, and check whether this solves the issue with the recent
> Linux kernel versions.
> 
> Please confirm that the procedure to be followed is the one described in
> <https://docs.nvidia.com/networking/display/ubuntu2204/firmware+burning>

Yes, it looks correct procedure.
If you didn't upgrade FW, this diff will achieve same result for you:

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c2314797afc9..110ce177c305 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2846,7 +2846,7 @@ static int mlx5_ib_get_plane_num(struct mlx5_core_dev *mdev, u8 *num_plane)
        if (err)
                return err;

-       *num_plane = vport_ctx.num_plane;
+       *num_plane = (vport_ctx.num_plane > 1) ? vport_ctx.num_plane : 0;
        return 0;
 }

The culprit of your issue that in some FW versions, the vport_ctx.num_plane
was 1 and not 0 for devices which don't support that mode, while for the driver
everything that is not 0 means supported.

Thanks

> 
> Thanks for your time and patience, and for all the help you are kindly
> providing!   :-)
> 
> 
> -- 
>  http://www.inventati.org/frx/
>  There's not a second to spare! To the laboratory!
> ..................................................... Francesco Poli .
>  GnuPG key fpr == CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE



