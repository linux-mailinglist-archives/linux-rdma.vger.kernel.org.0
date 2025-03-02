Return-Path: <linux-rdma+bounces-8235-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFBA4B193
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 13:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC9188E647
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58A1DED5A;
	Sun,  2 Mar 2025 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oA2lMdw8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C48BFC0E;
	Sun,  2 Mar 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740918899; cv=fail; b=kZunpdkUvLymhuA10RjPsJ5GIDxX7+5JZYVOkdImPF9rOrGRxDTIbJ6Dyv1wWkdGdbiZI3IXRa/ct303dD/XIw+fIK347+Yspl1kAGSeZ6AmZ/7NN+4GEmwcoOafnAKAeDFW14iS+miP+o0gsY+TXG5nAh0d3ceTUGqCsAAlBrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740918899; c=relaxed/simple;
	bh=xjoYyvnKPX+WQHzwRqdIppZZogehZctjwy3jEIpDCVM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIDQOhZbTzt1J07pMkXVSIzcoQkZnd34zEsT0nMjuZnefZg2/Ia2QUFExXA+zz03sljuPh76RSzQK7qTcwu4ebUqhTtRVI9KkJYXw1jBh5oML/LlCGjjPrIPwMHtthRDjXAWaSCpMuUp1LJ5AHU2PjasZamcKpe2auK3AGKJTiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oA2lMdw8; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAa7dPLXZDRPPy3ffDqlbdc4KNTdZNE2aXjbMQp0WWFbFNlUt+Ak1GVTz1QhyqIAEIF4ovsVrYDHYCI/Hj+QULz417xyJw/KugBA7rghZz7On6XgoPs5KYUSALRYg19wiQ+c+7hItBWZaX3TezyATKGDbZLuu2EE48OTv3MwFAM5SzBmjAwtNTRBmFtNqGCRrW+bxP7csz0Ay1mszemCtydXsykszIOl1e9V5HyKVdyFrzMjfVx641PaP3ShGT7AzdLIx5TFvrAO5Q7MP1SOoNh/f9QGRUQT0gPxNkSEattmLzTo+vRVJ5MpWc6BmVJgoumHDbPwA+L6m2zrEhDN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUwyjZSvM/tYRMoOXdRoege+tE9RiRBjrXLKI0fMzHY=;
 b=A2y0u7hPo8OH5sOGCExZC5gtI8nMOOUIwpgdm9Rcqno5Ns1oBA3o3uNoYDQXHtEQd+49CO9c5CpEUSiCDnYxQ4VD+rMpNifca+mFg/i5BvZc1m3iOq5eonqtqFS0CFFXAB87XoMeXUhKPHZ5hDy33/ZpSnWJA/Iq3XIUeXLuv8JEXo6GUUNY/4Gc73ZKfP9+do+s97AY8S3T/j5lz56YtrazsOsh5hgFyAG5CSKRSXbrv8jeNwfnqkL/AN3OqriSrQ7spAno8SuNLHRObwryasaTy+fNh9Z5OmNrVfkWgCGlYxXO81e9TJOvqo0kSpe5ku7o+04XTIlQJMusXikKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUwyjZSvM/tYRMoOXdRoege+tE9RiRBjrXLKI0fMzHY=;
 b=oA2lMdw8mDQKrBrNnWFcHitsylwdBuLV/M7AsO5Rw/Sz5Q0PmNYhK6M72Jt9EI4SR/WEcgIpom4ip3caHsEwBGC6mXD5GL2n4o/HAYusuM+5tctiBHMe9PQR062KYFWp8McOVW6LneV7era16skji5XMg5hR57f+ZnhBKMLnANADQuExiIuvtdKlbGTh7EbwRkgOlF+y5fJOutQLubRZpoxiYpC/3hGAEddYv2KyTwdu2u9peMdHVRboTQlSvLZ17Heoqz0ZDlJJGbg0ktirt2gMzFjVqds0ajiZVaJrkU0ZhgCn5Lj0Or1g/Tqg5IvrpiWn7/fri0QVf65dIWJLdg==
Received: from PH8PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:2cf::17)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Sun, 2 Mar
 2025 12:34:54 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::99) by PH8PR07CA0037.outlook.office365.com
 (2603:10b6:510:2cf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.26 via Frontend Transport; Sun,
 2 Mar 2025 12:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Sun, 2 Mar 2025 12:34:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 2 Mar 2025
 04:34:42 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 2 Mar
 2025 04:34:41 -0800
Date: Sun, 2 Mar 2025 14:34:37 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>,
	<brett.creeley@amd.com>
Subject: Re: [PATCH v2 0/6] pds_fwctl: fwctl for AMD/Pensando core devices
Message-ID: <20250302123437.GD1539246@unreal>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250301013554.49511-1-shannon.nelson@amd.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b238f9-a611-4570-284c-08dd5986a25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqrqxDLQcZbj+ABrUEOt6dyWnXdfU/lEnnMJR5DJFJi7fCeHJYNovcfHs8mn?=
 =?us-ascii?Q?Bs31oD2QIE75GPRDI9bfKzT3ag+CuchJeCqGbI0Du8DpK0p9QUjkOSwDP3c5?=
 =?us-ascii?Q?gB9KZ+DeKVQSsqoisDjexQFN03QuWwiqhwB5VUR4x8fo1wfG03H1jomS/KPl?=
 =?us-ascii?Q?a85zU+X8bOLhHtUcqhqUBEB3q2cXwcQGmsyVyLHllPcSpTtZhWMG+BA3MK7J?=
 =?us-ascii?Q?EPYZgUDhtE9pzLEbCic98VUQ6AvMkueK7fwW7mJnU5uiYOwC+G1Xm/mkG2oM?=
 =?us-ascii?Q?KU/+f0NAhzQy2TpX+JpayanJ8b5mj51snLF6s+rpcLrnPJwHdSRrYKgdq8pR?=
 =?us-ascii?Q?Kw0EuyeWOZkUFZFWJwrfUtiJ+/qeEkV1h5Gomt6eEsnJXeVGpwcKoQHobEVh?=
 =?us-ascii?Q?TBJnUh8v1bTqQA7QbZWm0zCPBBe92KDbkaj3QDlTfVdOWg40fH1qpbn9EsOb?=
 =?us-ascii?Q?e2Gn8R/bczKZy1DbyJPO85I7S/gQHeTHAOz7qRT4lqWlIIs8ZoXEeIbhUMUo?=
 =?us-ascii?Q?6DTM4AaKr1TRsObeAfdu4Bp6XXhOSuMKCOuPcdYwirrrdjEPd/pDlOY3JPtW?=
 =?us-ascii?Q?jUWrYXHavaY5Mffxg1P18oqnuELFQNvNAkkAA7gG6vnpQOYQdEiL6CUbUKEa?=
 =?us-ascii?Q?yMbC7Lnxb+5KrpYH6c6WtLzBfeTPSFKPEUtIeFw+QnBAY7QNJDfIemrYgav0?=
 =?us-ascii?Q?249NU0WbGRvKQ8/TaZNXiDNM09h9CoZFgnBJeK2pkh8rD7aDqzysFMJx+E4/?=
 =?us-ascii?Q?XvOH6OwNB8VJOCY/tdIkqnf7wXLEhgfaflFUT1zOpR1vuOimbD9js0p1eySp?=
 =?us-ascii?Q?yD0/duwiAvuk7EF/apGsA3tgfvB+ilgKE/1QYWGRrakujXTwncQJHgt08ZnR?=
 =?us-ascii?Q?9Nm7kl6lTA2bk5az8pgqKXhEAO0YuzjT9ryP66QYk5VQCs3NnGXfpM1MwL/M?=
 =?us-ascii?Q?SSAC1lM53LGhIaVPOYhzPN6vjUlFKgoMSbpZAesCyT9yNimOHjYwqJsz6H2T?=
 =?us-ascii?Q?4ZuQhGQUAbvnLo/UKfhgNt4bqddsegRcEtLulQqtAbShpfuaLS95cdVdLLVc?=
 =?us-ascii?Q?FsOQUwuArSkp5rIZ/5OzbgbLDptGfXMGc1nmvgEFnLNmUgqmyeoBHC7h5i1f?=
 =?us-ascii?Q?yOyJDTmtu4rHXxtIQhi+HdCOkAEO6RPAmIAFTUy2v1YlgDonIbbbAnYTd4I3?=
 =?us-ascii?Q?ssGILoH4W3mLmyEwveQUzSzHwxOdWDQIIOeplIQaQAirTIs5i9duYr6Aunnu?=
 =?us-ascii?Q?7vJ0rYX/CRAh81skU5u6TfpJEVlgCnh8dJ9MB0iDOQrcbnO8cI7Wphej0/Dc?=
 =?us-ascii?Q?G1LtoUhDw9Dt+F3IDHxG+W9LNwIvK8RUUzoIOXQjt5DYx2wbiGSIWzGOraV9?=
 =?us-ascii?Q?yfrlA/BoqSOe065J3YLNdXfpTzqDsjo7BZgz1f9DMrY693hqpkucnPKRq26D?=
 =?us-ascii?Q?DNAJAkuWyreBwofhzfMcDERZU0vTYE9/yKoRAfpTjj3PUDTd+04ALEH0XpCM?=
 =?us-ascii?Q?Nl9jq47rKcAFwMg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 12:34:53.9132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b238f9-a611-4570-284c-08dd5986a25b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003

On Fri, Feb 28, 2025 at 05:35:48PM -0800, Shannon Nelson wrote:
> Following along from Jason's work [1] we have our initial patchset
> for pds_fwctl - an auxiliary_bus driver for supporting fwctl through the
> pds_core driver and its PDS core device.
> 
> The PDS core is PCI device that is separate and distinct from the
> ionic Eth device and from the other PCI devices that can be supported
> by the AMD/Pensando DSC.  It is used by pds_vdpa and pds_vfio_pci to
> coordinate/communicate with the FW for setting up their services.
> 
> Until now the DSC's basic configurations for defining what devices to
> support and for getting low-level device debug information have been
> through internal commands not available from the host side, requiring
> access into the DSC's own OS.  Adding the fwctl service allows us to start
> bringing these capabilities up into the host, but they don't replace the
> existing function-specific tools.  For example, these are things that make
> the Eth PCI device appear on the PCI bus, while the tuning of the specific
> Eth features still go through the standard ethtool/devlink/ip/etc tools.
> 
> The first two patches are a bit of clean up for pds_core's add and delete
> of auxiliary_devices.  Those are followed by a patch to add the new
> pds_core.fwctl auxiliary_device.  This is only supported by the pds_core
> PF and not on any VFs.
> 
> The remaining patches add the pds_fwctl driver framework and then fill
> in the details for the fwctl services.
> 
> [1] https://lore.kernel.org/netdev/0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com/
> 
> v2:
>   - removed the RFC tag
>   - add a patch to make pdsc_auxbus_dev_del() a void type (Jonathan)
>   - fix up error handling if pdsc_auxbus_dev_add() fails in probe (Jonathan)
>   - fix auxiliary spelling in commit subject header (Jonathan)
>   - clean up of code around use of __free() gizmo (Jonathan, David)
>   - removed extra whitespace and dev_xxx() calls (Leon)
>   - copy ident info from DMA and release DMA memory in probe (Jonathan)
>   - use dev_err_probe() (Jonathan)
>   - add counted_by_le(num_entries) (Jonathan, David)
>   - convert num_entries from __le32 to host in get_endpoints() (Jonathan)
>   - remove unnecessary variable inits (Jonathan, Leon)
> 
> v1: https://lore.kernel.org/netdev/20250211234854.52277-1-shannon.nelson@amd.com/
> 
> Brett Creeley (1):
>   pds_fwctl: add rpc and query support
> 
> Shannon Nelson (5):
>   pds_core: make pdsc_auxbus_dev_del() void
>   pds_core: specify auxiliary_device to be created
>   pds_core: add new fwctl auxiliary_device
>   pds_fwctl: initial driver framework
>   pds_fwctl: add Documentation entries
> 

Unfortunately, you didn't remove useless defines :(

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

