Return-Path: <linux-rdma+bounces-6093-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B389D8D07
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7AC16A64D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F21C878A;
	Mon, 25 Nov 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aedR6iGH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920C31BF7E8
	for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564264; cv=fail; b=PC9+yGo9pN7xT3xn200RB0+w0KzePNpLL0bLgp0bFvOIW+AraEaJQ4DPupTRd/aZrrmQwApc/dR7ofYSQd3XP4a90xdj7MWnEn3s4+sKPr8nJm3y+CqiBXz/gep+PBdYeh/mPZuW5oAS7pVywl/cRfFAolPjWeJ6Gf03fYIXRsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564264; c=relaxed/simple;
	bh=Dz/p1LX7mcplGltXzli2v9FcnvCsv1nJjmLAs9W4JGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bltkHSh2TGjGIGLNVo2w9Tk/xXaqlz4MlrKXuIN6plM7q1/tfyTXpcmJOwtGW66BcNqhlFY9QYbtFbZp6wD1vy7adZoL2b1HxYVTbZN5ioxSmQsloW4wPd8DLlmyCYsj7dbLCE3Y0IC979FagUv6eqytd3WVz7xTL+jY1/oqGkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aedR6iGH; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMjhT9qHL+Iu6VRTdeq2Ef35xfM49zhTNZzitMJwqtW9nJINvHLwXTqW/5TgKBWKptiKgsFFGyhuFpGAKDVywgjnhfmtji4wE8zV0keE3/MPzJIpTMS6I+fJiFmcICULB7ITXd6SlnjFJKUi8gE+ZuQGZmDScyt3LABtT2zj7MCGioxCsdI/rUL60zjQLZ6ZlAi47lsAhSzgn0h+YW0UhuPPdKQDohRd0grWpOcgiJeAU3JvSQdGiLGemRML+f4489B5x1VzRwr2V+JQJxxJGtunnL25h1l5Io3IKYZdHh5Ym5ORzIg9EJUUU4gAv8CfkYiFqmG4UHhCIe7ojR/gVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E4xJh//N4ymZkSI864Xus866l8FO4J9RZp4tJzUjyM=;
 b=ocqK6Aqzz1V7CM7WVqWIGCp+GX4Y67jYnFCgSfrSonPvHYOAoSsGdOe6QcTsQFEyBgNlzu4n+6BxsP1+pG9c0ylKkxrtOUzbC55U+Em8hR8VwzF7ul3jD+Aj9k9s8BL8/gJ/X/+QjIljQ7s1kP5m15Y2gJCeG6hIrp+Xy126PLsPTXUVxkS9mVs/6hXkNeCTf6c5ViyEkxitGwNhDhRGQqdR7kQGpOujAEEIz8a/X4WM4r6qOEi1Um9j87dDQxt7yOpI7KXxslaf8UlmsRzKrdWZNnTPexxWgpxhYlQEufAwGPYQpA2R8GXUD1ex+w/jL94DsEHbMyEjjX5Pm/AtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E4xJh//N4ymZkSI864Xus866l8FO4J9RZp4tJzUjyM=;
 b=aedR6iGHIobe0feC4O9WBoEdUl4v2cGp+XVREsaA8XmDOMuk0PlIFpNXSIWjeJt/sBowsthZrtK4C4hV8g80krQ/V01TGOm4Zljc7JtKJ3Ga59HIN+cfsfNiim/0BGBo7SGtDdNN6JAO0obyTGjnhXk8o828rvuEfF/p10CxdRdxRotO3kc04N+Dciy5vjYw4gLmGCUP5R41XJPRxAbZFaj+5YOCZFwtBazgCLgMzyEc6z7JedtTPl/ggFce2+NZH0Q2ncz/FVE7XdnrgcAGZY8Im5Q+AXiQ84hWnyJvWYevHLaH43Qyu560pKZAoStyZq+9ZOopKrvAg4ly9UoWKA==
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 19:50:55 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8b) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Mon,
 25 Nov 2024 19:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Mon, 25 Nov 2024 19:50:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Nov
 2024 11:50:31 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Nov
 2024 11:50:30 -0800
Date: Mon, 25 Nov 2024 21:50:27 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: Anumula Murali Mohan Reddy <anumula@chelsio.com>, <jgg@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <bharat@chelsio.com>
Subject: Re: [PATCH for-rc] RDMA/core: Fix ENODEV error for iWARP test over
 vlan
Message-ID: <20241125195027.GJ160612@unreal>
References: <20241119061850.18607-1-anumula@chelsio.com>
 <578339be-b555-42cb-b7db-1d3e7b6c7017@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578339be-b555-42cb-b7db-1d3e7b6c7017@linux.dev>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 4180e49d-081f-4699-bcb3-08dd0d8a78c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVN0T09IODVSdERyb0NjU2FIeWgxRVdYZjRhdEp2VXNyZkdYV0hXdjBpdElv?=
 =?utf-8?B?c0gxM0d0Y0hnQmo5QmlRcURsWEpwUXNWaFQvU0Y2M1RaSlVzUU9LaVFjVXlL?=
 =?utf-8?B?QkNLaVV2R0tXcVBjSmFwVUlRRTkreG8wbEZOc293a25HK1RucXNGcXpWVjRw?=
 =?utf-8?B?K2NrRi9ETnoxMXdJanVaZzVWSGo3ajJwMnluZ0dYRFFyVXIzM1BMQmRudnJq?=
 =?utf-8?B?NWdFeHVqOGozTjJaREk5T1NDQzhady9NR3U0enlrUUFFTno2a0FPaDY3R1Fk?=
 =?utf-8?B?dDFHN3R2QWcvVk9EWDNmQ3M2cnorRlBpWG4zc1ZrMDhjM1N4dy9ucjNWWEtm?=
 =?utf-8?B?cHorendaYVZTY09QOEk4OFlEaHA3bERWVVdsMlNkZzBEelVodHcrcVNySlgz?=
 =?utf-8?B?ODZwaHZGRzNSL241OHFCeVVTU0xVY0dvb1g0M0xFZE8vUVJQM0JzOEtJbWh0?=
 =?utf-8?B?QW5HZk9zc29JOWN5SmhLdlcycTMwblFoY0pucUNmN0E3T2VhS0N4aVdzSlg3?=
 =?utf-8?B?b29Cd01wWXh0MkRscDlzLzNNMVN1aTJxcldLR1FlTEZGVXUxUUQyOEhpZWEx?=
 =?utf-8?B?am40RjdHNEVaRnFBZU9mb1V2UmI1cS8zeU0vaUt2NGo3SkQ1OWQrUUk0WmtJ?=
 =?utf-8?B?YTFCa2piRHB5WWpmMGU5NGhubUFsRmtUbVR6eHFLeG41NzJwcmZ6QWNzYmVM?=
 =?utf-8?B?N1JNYS9XMW9aWEYzazQweGhYNWxFWE9DeGlHUzVFVVVjKy9WNHNTVWpoSzRa?=
 =?utf-8?B?Zjk0RjZaOHYycVNDaGpEcHJkTTduaFQxK0REclE3TTJ0QnkvNldITHdwbGd2?=
 =?utf-8?B?cG4zTURjOUFMQXQ5SEY5VS9iVzVOTkZDdVNpT0h4WGRMQU1rYS91RHNSQU1S?=
 =?utf-8?B?YW9DNGd6eW9NVXNXSGQ0NGRvTlJyQmNGYWJ3T2Vxb3N0MmgzOEhtVjZJRng2?=
 =?utf-8?B?RFZ4anhxUVdkMEI3WVlhMmdHMG8rd05Tbk41RGRiaG1FSFlFVmZ0ZHBTVy8w?=
 =?utf-8?B?Z0s0azFsMndOVXpNVTNleUdiRStUKzI3Mi9NMU1nbDdqSXlEWGlYUGJZbTh2?=
 =?utf-8?B?QVREUlh3SE9nNHVHOXJReWZ5VmNZajZwb2dqYlM3WWFYUGRzQzYzU0IwMm91?=
 =?utf-8?B?UTk5OU9xTiswQUFlQ2h3WmdQemszSTdEY3dOUCtodlMzbjg1RTlYRkg3YWpP?=
 =?utf-8?B?blNlbDFMdjYvR2VXb1lzeHdON05yZkhsTWNZYVNMUjMva0JCWmtkM1FsM2RH?=
 =?utf-8?B?NlZpQTUvanRNb1F3QkU0dS91S0hwUkRFdXNFY0s4UGs3M0gxZVhWU0taYzFh?=
 =?utf-8?B?QWlhM1ZQcGRpanl3VEdlK2RRbkR4WUtVblU1RkhWV1FFVTdMb0VtSHE2eC9W?=
 =?utf-8?B?b0VRZXV2ZnV5dU1ZTXBVK0ZqYjhPNFh3akxZeTlkMm9VamVqdFNsU0VaMmhL?=
 =?utf-8?B?dnhaRytucjZiMjB3azVqaXcxdkJYY0NZMzVBN2ZJTlVMTFczRVNFL1JwOVZl?=
 =?utf-8?B?MmJyNVpJMUkzRklXNnZYOVJHRUdNT3JYNkNJNWVVc1R3MEVOb1hxc2ZURXlO?=
 =?utf-8?B?QWxzNG5uak1tQm1BNUU0VGJlU1VUclpTTkR5V0FWS1VVajlNSU85d1JXWm1v?=
 =?utf-8?B?YmI5ekxNQUVwTzIzREw5ZStPdVZlYVhCTWN5NEI3N1l2OXJiMjFwYkRoM2hM?=
 =?utf-8?B?RjlNZWtISkQwTFBrS2ZaWENIN3EyRlhOSXpzWEJ2Y1REQW83ZzN4YWtJMFBE?=
 =?utf-8?B?K3NBa01WdEF5N2RwMDE3bXZGN0pEMjhlak9FR1daSWhjRUpjWnU0N2g2VFZO?=
 =?utf-8?B?R2RvbEE1R3dHK3B3VVgyMWgwaWZ0NTRFM281N1NaSjYyV2FEK3A5U1dkcjJV?=
 =?utf-8?B?Szd4NnpBRVdpa2tkaWNHUzhEQWtydWtlZy9yQ0FlTHd6SHRHaUxZcHVUcTZK?=
 =?utf-8?Q?TIquIXHthD2exkwb1bf9bfbsZeSZl12D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:50:53.7410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4180e49d-081f-4699-bcb3-08dd0d8a78c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

On Thu, Nov 21, 2024 at 08:52:16PM +0100, Zhu Yanjun wrote:
> 在 2024/11/19 7:18, Anumula Murali Mohan Reddy 写道:
> > If traffic is over vlan, cma_validate_port() fails to match
> > net_device ifindex with bound_if_index and results in ENODEV error.
> > As iWARP gid table is static, it contains entry corresponding  to
> > only one net device which is either real netdev or vlan netdev for
> > cases like  siw attached to a vlan interface.
> > This patch fixes the issue by assigning bound_if_index with net
> > device index, if real net device obtained from bound if index matches
> > with net device retrieved from gid table
> > 
> > Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
> > Link: https://lore.kernel.org/all/ZzNgdrjo1kSCGbRz@chelsio.com/
> > Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > ---
> >   drivers/infiniband/core/cma.c | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 64ace0b968f0..97657e1810d8 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -689,7 +689,7 @@ cma_validate_port(struct ib_device *device, u32 port,
> >   	const struct ib_gid_attr *sgid_attr = ERR_PTR(-ENODEV);
> >   	int bound_if_index = dev_addr->bound_dev_if;
> >   	int dev_type = dev_addr->dev_type;
> > -	struct net_device *ndev = NULL;
> > +	struct net_device *ndev = NULL, *pdev = NULL;
> 
> In the original source code, the local variables lay out in the form of
> Reverse Christmas Tree.
> But the new code breaks the rule of Reverse Christmas Tree.

There is no such rule outside of netdev world. I suggest to everyone in
RDMA to stick to that practice as sometimes we need to send the code to
netdev too and it is much easier to keep their coding style from the
beginning.

However, for pure RDMA patches, we don't care.

Thanks


> 
> Zhu Yanjun
> 
> >   	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
> >   		goto out;
> > @@ -714,6 +714,21 @@ cma_validate_port(struct ib_device *device, u32 port,
> >   		rcu_read_lock();
> >   		ndev = rcu_dereference(sgid_attr->ndev);
> > +		if (ndev->ifindex != bound_if_index) {
> > +			pdev = dev_get_by_index_rcu(dev_addr->net, bound_if_index);
> > +			if (pdev) {
> > +				if (is_vlan_dev(pdev)) {
> > +					pdev = vlan_dev_real_dev(pdev);
> > +					if (ndev->ifindex == pdev->ifindex)
> > +						bound_if_index = pdev->ifindex;
> > +				}
> > +				if (is_vlan_dev(ndev)) {
> > +					pdev = vlan_dev_real_dev(ndev);
> > +					if (bound_if_index == pdev->ifindex)
> > +						bound_if_index = ndev->ifindex;
> > +				}
> > +			}
> > +		}
> >   		if (!net_eq(dev_net(ndev), dev_addr->net) ||
> >   		    ndev->ifindex != bound_if_index) {
> >   			rdma_put_gid_attr(sgid_attr);
> 
> 

