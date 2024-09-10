Return-Path: <linux-rdma+bounces-4854-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025689735EE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 13:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FB91C24302
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353BA18C32F;
	Tue, 10 Sep 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EETjTMqx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3323A6
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966583; cv=fail; b=sZ+ISdlFDvNIrPYhfo9DmkRNILjw3uNc1Q3qJpXY6Swllqv5Z1/ThEs3ZnNIR7RshQx7mxZVb36+nAY+pSAT2jYHw+/rkGk2WlMHmNsjtM/54q1B0EGx21HfM+iMw88TIEbQP57HvWqsP2tvoDfGBBA8UCxU5On+rdn+tpz/2rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966583; c=relaxed/simple;
	bh=v7lyJQCamD6x/UVk8rBfpr5X8pdw9YwOYmMfTdZHI60=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK+8FSMedcbjTwSqysty3O/Vs1kNqnfVK2pn4g/wf2T5xXZEQzWkN17AugeSFhah4/JDFmaGIhg58O+rmwxtPB2H7/swTnCMrU0/eQzS8VbLzOUmhFPN2cP6PA8HCoBoMXEj4XFLKKw8b/tkUwayjdMOt1J16XTNqPlRmPYh0II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EETjTMqx; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wATxgHX9/oF3QcPEaBr39tLpQMtF3wpjXiWklGfwX4ISmn1IJtQk+ZoTjdRSHNgeZ3hhQGJo+hL+Y30O5D1pp/efi1nBfDRX6jOgj26LF221ckLe+oQyf+Ir/detz1YWxn4gAged1YjrhnwIrktz/NduO18EjDHoZudN2x2RJi06V4o1jq0JTIvG9NuUzAI3ZnTEqOYa50XXJXNeOWdzNDpcmhN0+PLyhjY4LOpLjBmVau89xuqOzAh5D8fISX27I/Nqab4sfRO6XQ5TRSz222Nbx4YHr2920QvHB3H58BugNH27ycnIUW3wVjhrRvYobjL5AsXqhFV12QUKCgl7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq9Ced8bK/WuRgOWYhV2UIqqmhm/uKDxDamYufb9GZM=;
 b=WhHFZCnZHR3qbOxVzgL5gyCHgoValGRliHLv7s0EpMr8ggt0b41UUzChJIkvLtuPJclI30IITaygWpaDN3Xg5H/MotmrwsqOtbhRsvR6FqQzMfuGzyHqj0TnBXUhEzXi2PXY7UoApiD/1xB8DytAnheFfElQuqeQ2Ii6ZKt4NJ+puKtOvpOViBy4l2Y77+5S0afYVagn82RDmfLdxVfYM/5+7FX6bO01YhD9CghYexXL58Ad+yk6pVCFGAbKBVt9Q3DzG8thafxFAVNeW4Kr+X+VO/dZUvRoCE/7dNoYEjodNw2Mmrt8A/gS6+Glay41rzKMPL3GxEaeKKQs87aTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq9Ced8bK/WuRgOWYhV2UIqqmhm/uKDxDamYufb9GZM=;
 b=EETjTMqx3ek38RnYRK2NXtoioHWm6QpeJwxWB1VC/jCrjG5HyUNC9wZ++MBtLLjYqpqVEIUfHwSw4sgbJlZOnQXlMdsy5Lx0B+d/R++OgsVNP6okzEz4hb9XUqMzePNofCQI8/iZhxj6puf2mlQ/uwOeMjcQjfnXjDwgExsSwjaBhJCHwRWUq73BgFOcODOKIAokqt4Smy2GOELSENhf5g5wS2B/h/3plTDG8g7knEK5RcGRmWmPnmyFTgaS+kwt3bsdMQGR7fie2t/CEn/isoZHZt6nLBg4IJ+udli17o9OS1kdFEf3HhkMTr68uCMlNeJoI8Y7Q/BP+lyF8Q853A==
Received: from MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) by
 MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Tue, 10 Sep 2024 11:09:37 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::39) by MW2PR16CA0032.outlook.office365.com
 (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 11:09:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 11:09:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 04:09:19 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 04:09:18 -0700
Date: Tue, 10 Sep 2024 14:09:14 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Michael Guralnik <michaelgur@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>
Subject: Re: [PATCH v3 rdma-next 6/7] RDMA/nldev: Add support for RDMA
 monitoring
Message-ID: <20240910110914.GX4026@unreal>
References: <20240909173025.30422-1-michaelgur@nvidia.com>
 <20240909173025.30422-7-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240909173025.30422-7-michaelgur@nvidia.com>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: e20f917a-c3a0-46c4-5e0c-08dcd1890ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?etKwP1v/pUqeKRJrZU6/ikna9Ytbp9DY9Vbk1NmmqjwGOZs6lkupJvYKdCds?=
 =?us-ascii?Q?ZmpWolUXQHvN10g6jrxTP6SSGSJzb4GFHjclhuQewKsNDjGVnoGHnj8LuS9a?=
 =?us-ascii?Q?xHeoZ9rl7jTGi7Xw0SWHBCJlTHo4EasQhmvYzeKwDN+YPrZC1N1XX9Dvjr+m?=
 =?us-ascii?Q?yXcarsF6oIHciiimrJW1KEmdi59EazEZJs/EOlRnMWyqQWMUPVNbcrjE/uJf?=
 =?us-ascii?Q?pAbxxInObPK76FVscki9Kzj/TJush/JFQMer23Ke3YuI71HJU36cN75SjNCg?=
 =?us-ascii?Q?W+qizb7U4JnL2RPuBlU3qSnrh3oIzJHqTkoo66zu+xIY25AH2Gbc9xeRFpAp?=
 =?us-ascii?Q?nTgbHAUXqhHXt/fSs/gc6HvQlaVMNjPVhJgEWMln6P+CYWqWlzbTRkMV0UuF?=
 =?us-ascii?Q?ht4zQ3GeC6JdLQoIfAvzRdq35Ka9S6vYLkI0z4eAYYHmdHiBLkzAOlMpXh9V?=
 =?us-ascii?Q?fLVLCWnGlYlFCnaV4V8phDZ3Q1SW9Gtz5TI56Hh8J89ybXvMeXZeGAzNJwtm?=
 =?us-ascii?Q?pYRYxVE4bUPAqRJt7sX2nUQD+M5+4O5egbzir7zHpyl8FKvHXXl9NGoG0w7N?=
 =?us-ascii?Q?+ZyS0xxX8meH6dR3YQbvTEZ6I3YqtaVgsGSLiSPCr3fUwV6mTcoYTLIWzTQu?=
 =?us-ascii?Q?0ithzrnHS7LismbQgeiVa8vU0rqT2vrSUFUK4+wdzGiYKiNlJRG4e2ljS+9E?=
 =?us-ascii?Q?PSh3hRFQWslkb3RmN5Wx02m/dFG3K6c/SqcTX5LpUWGUeGBj9bM9hHRqDt9T?=
 =?us-ascii?Q?69vZN4zzVyJKkc3dlR0ZLROUworL8nZGaMZBafndXUCkVGfDQw71OOl42zRp?=
 =?us-ascii?Q?i7qUEmfUlXaEV6i/5vmFt50pt/DGcT0QJbf3GN1RDfm/Q/osWIbOWjwkPkdj?=
 =?us-ascii?Q?i4n5QmG4aW5bVavnQDbokuNkXstbvVaV29w3LKg3N6IjOcmA7efvgeeM7j20?=
 =?us-ascii?Q?NOkfz92EqBk30N+n7jlUpzXcyy3dXgKKVvU+19JodEGYUHdIb2wtURfZ/1VD?=
 =?us-ascii?Q?j8Di0nAjSMzypKvbOp12rdiuUyiOk4aijbUYxyc5suUoFw5dQJyN03n7d+vl?=
 =?us-ascii?Q?CGcJZojFbJRdDJ/Owtuhnp/6SU/WbpH2+MeaRblxpCv2Y63Ck76IqYwzpNk7?=
 =?us-ascii?Q?d5Scuj6/HXzqi8+lrGQJHc5XydB3otrxn+2mWx/2wr/T97gjW4xuuekZSSLD?=
 =?us-ascii?Q?Oj5o4hRG7t+cj83sgzWupp8a+t/YxLwSa1aXTayRt6uKpAgCVALPRqdOy2d/?=
 =?us-ascii?Q?7wNJS/J8G9j1fuEaMmvZekTIxVivAAGLOwW+CCSohyziltA+fEsdP+a90yJM?=
 =?us-ascii?Q?2RYbmgYRrw49Gel6wCybgJHCbYzFGXopCzlOpGl0ME5vAWHVcN43UzxIHa8Y?=
 =?us-ascii?Q?U6dYueNW1IXEYDE3xEjNWuqcIu36+u3hFHoGyKwNBFEtcDue/TpA4Uzb20Qo?=
 =?us-ascii?Q?UAuPzsL+QgXtf8BzXc1A/OdL+mYlnr3n?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 11:09:36.9997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e20f917a-c3a0-46c4-5e0c-08dcd1890ef9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429

On Mon, Sep 09, 2024 at 08:30:24PM +0300, Michael Guralnik wrote:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> Introduce a new netlink command to allow rdma event monitoring.
> The rdma events supported now are IB device
> registration/unregistration and net device attachment/detachment.
> 
> Example output of rdma monitor and the commands which trigger
> the events:
> 
> $ rdma monitor
> $ rmmod mlx5_ib
> [UNREGISTER]	ibdev_idx 1 ibdev rocep8s0f1
> [UNREGISTER]	ibdev_idx 0 ibdev rocep8s0f0
> 
> $ modprobe mlx5_ib
> [REGISTER]	ibdev_idx 2 ibdev mlx5_0
> [NETDEV_ATTACH]	ibdev_idx 2 ibdev mlx5_0 port 1 netdev_idx 4 netdev eth2
> [REGISTER]	ibdev_idx 3 ibdev mlx5_1
> [NETDEV_ATTACH]	ibdev_idx 3 ibdev mlx5_1 port 1 netdev_idx 5 netdev eth3
> 
> $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
> [UNREGISTER]	ibdev_idx 2 ibdev rocep8s0f0
> [REGISTER]	ibdev_idx 4 ibdev mlx5_0
> [NETDEV_ATTACH]	ibdev_idx 4 ibdev mlx5_0 port 30 netdev_idx 4 netdev eth2
> 
> $ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
> [NETDEV_ATTACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 2 netdev_idx 7 netdev eth4
> [NETDEV_ATTACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 3 netdev_idx 8 netdev eth5
> [NETDEV_ATTACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 4 netdev_idx 9 netdev eth6
> [NETDEV_ATTACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 5 netdev_idx 10 netdev eth7
> [REGISTER]	ibdev_idx 5 ibdev mlx5_0
> [NETDEV_ATTACH]	ibdev_idx 5 ibdev mlx5_0 port 1 netdev_idx 11 netdev eth8
> [REGISTER]	ibdev_idx 6 ibdev mlx5_0
> [NETDEV_ATTACH]	ibdev_idx 6 ibdev mlx5_0 port 1 netdev_idx 12 netdev eth9
> [REGISTER]	ibdev_idx 7 ibdev mlx5_0
> [NETDEV_ATTACH]	ibdev_idx 7 ibdev mlx5_0 port 1 netdev_idx 13 netdev eth10
> [REGISTER]	ibdev_idx 8 ibdev mlx5_0
> [NETDEV_ATTACH]	ibdev_idx 8 ibdev mlx5_0 port 1 netdev_idx 14 netdev eth11
> 
> $ echo 0 > /sys/class/net/eth2/device/sriov_numvfs
> [UNREGISTER]	ibdev_idx 5 ibdev rocep8s0f0v0
> [UNREGISTER]	ibdev_idx 6 ibdev rocep8s0f0v1
> [UNREGISTER]	ibdev_idx 7 ibdev rocep8s0f0v2
> [UNREGISTER]	ibdev_idx 8 ibdev rocep8s0f0v3
> [NETDEV_DETACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 2
> [NETDEV_DETACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 3
> [NETDEV_DETACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 4
> [NETDEV_DETACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 5
> 
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/device.c  |  38 +++++++++
>  drivers/infiniband/core/netlink.c |   1 +
>  drivers/infiniband/core/nldev.c   | 124 ++++++++++++++++++++++++++++++
>  include/rdma/rdma_netlink.h       |  12 +++
>  include/uapi/rdma/rdma_netlink.h  |  15 ++++
>  5 files changed, 190 insertions(+)

<...>

>  	/* Expedite removing unregistered pointers from the hash table */
>  	free_netdevs(ib_dev);
> @@ -2159,6 +2186,7 @@ static void add_ndev_hash(struct ib_port_data *pdata)
>  int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
>  			 u32 port)
>  {
> +	enum rdma_nl_notify_event_type etype;
>  	struct net_device *old_ndev;
>  	struct ib_port_data *pdata;
>  	unsigned long flags;
> @@ -2190,6 +2218,16 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
>  	spin_unlock_irqrestore(&pdata->netdev_lock, flags);
>  
>  	add_ndev_hash(pdata);
> +
> +	down_read(&devices_rwsem);
> +	if (xa_get_mark(&devices, ib_dev->index, DEVICE_REGISTERED) &&
> +	    xa_load(&devices, ib_dev->index) == ib_dev) {
> +		etype = ndev ?
> +			RDMA_NETDEV_ATTACH_EVENT : RDMA_NETDEV_DETACH_EVENT;
> +		rdma_nl_notify_event(ib_dev, port, etype);
> +	}
> +	up_read(&devices_rwsem);

There is no need in this locking, let's rewrite the following code
without it. We are in -rc7, I'll add this hunk when applying.

Thanks

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d571b78d1bcc..3be66dd7b226 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2219,14 +2219,12 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 
 	add_ndev_hash(pdata);
 
-	down_read(&devices_rwsem);
-	if (xa_get_mark(&devices, ib_dev->index, DEVICE_REGISTERED) &&
-	    xa_load(&devices, ib_dev->index) == ib_dev) {
-		etype = ndev ?
-			RDMA_NETDEV_ATTACH_EVENT : RDMA_NETDEV_DETACH_EVENT;
-		rdma_nl_notify_event(ib_dev, port, etype);
-	}
-	up_read(&devices_rwsem);
+	/* Make sure that the device is registered before we send events */
+	if (xa_load(&devices, ib_dev->index) != ib_dev)
+		return 0;
+
+	etype = ndev ? RDMA_NETDEV_ATTACH_EVENT : RDMA_NETDEV_DETACH_EVENT;
+	rdma_nl_notify_event(ib_dev, port, etype);
 
 	return 0;
 }

