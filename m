Return-Path: <linux-rdma+bounces-13390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF27B58DDE
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 07:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7987AB5B2
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 05:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9B28D8F1;
	Tue, 16 Sep 2025 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJ36b35G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E9286435;
	Tue, 16 Sep 2025 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000354; cv=fail; b=QMYsGT89OOGBj+ffTXsIYjdvsy5oOieWY/VbakRwI83HzpZZRrsbAJVi2URWH0jixlZ1F0aULWZsiXEwlK4d1fjjzGf+4dBZM72HWnNK32leV15GkxbflI6n7yooq1KstzgYRHPFDojPVT0TzO/cOll0xUzh01P1qySpF244RF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000354; c=relaxed/simple;
	bh=z/CGSI9XzVurcyA+LwmmfkJHpAPD4+PuKLvab8feV8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PuIjr/h9ZFv9avMysFOzK0WYvjEhQMZV4Ulo6RSlvI16pl5EDr1B0GMgSkjiO2KilQCfn5e+u90O7pXtC/74a49ANix5Oix/pUhkroMjqMSw0c/0LbdnWCYUE2mGqDH/DOCpIKxLLznAGgbgk+HTeOY5VDx0zNq8/GnDE3jg1TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJ36b35G; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELPpWOicYOO6+vt0/owfVwLPLKlHyFZt+8Ci1fao/ghHBrgLICc76Vd/YFP8T+XpfVbSMUqp2YPFTyQ8zPvcOX4MBgATM4dlOGOua8xd8cMs37jSkg5nJ3n2N8OzOIdI3mQEy8jcoItxcvO0qtRpQ+cE288rUDaPlssdnTET9IRIEKp9ukeAjQY22nVX9ya4bLuttXpHUbKb86jkHHeEFmIEvQ0wbOyM9nCcUc4ncOPl5pnR5qqbVOuN1GKf6fl2buQK1leZTXlxG4niRDHwtvHWOszYjIiu7Bz9lsNBOGRxwsPsVq/YWxW6RdKE74sldxX1TbPxsEjLtXdAaby6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMI446Nq6vcqSIOQTBfXI6zhxj3aAZZyad4dYZ92k9I=;
 b=Vp/SnBZBQ0ewkurJlme3TE74sUKqxKe1gOLCBCKvfWywevV2tlNGLt4/UoPJc5S5I9D4h9vuSC8s4t9BgIV0jkQKuQ34O7tW7QUWUZG4ipSqa239NcGQDQfepczcF+msnzMQKxBRC41Cjc9Bh3O8/WO8CcIpzJbkwXxfpOoB54iUD32XAgg7pBSzfYHqxHk+OH9OelbY9eF3yEBlEOEoUUedU5MbSLR6MGMzoUrQkc/4NDN9+ez8GD+bhOYVkdtcni7G8E91e6L98WwxL3oN2zIYuzCGdA9s7ltwvtWTEqW9APy9z+LPCkKo822f40aLLoB4RybG5ZVVPJUivMNYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMI446Nq6vcqSIOQTBfXI6zhxj3aAZZyad4dYZ92k9I=;
 b=OJ36b35GwCIzLzJYmsdq6R+8BaJTUicP3GnZQYisjcoP+7zi9FqGVsBfgp11kZIMQyaHjb4JA33g4/RRjLDCqUklzgmtYesrztSQnBfa9MRS1AwEMX45NNIt+qLjbThtqBRlu8yMMjUEIhgMAWPpr6yp0/ZyyEF93vJzNWPKiXmnFT184xN33bzfRXJAwtX11A0w1Uw/A0Xeyw13I0GpPwizMr24pDK5I8svx6Rtnv84PPTMAfnYO7Rn7TJ3TO49rmdcc2CNFUa7mAVrXWSY0n2Sd5oj5VdkrjElkL2im/155ozinZh3fGsIf94qEDpC1dQ9i4FtpvPNX4ZtnK4wBw==
Received: from BY3PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:217::13)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 05:25:48 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::bb) by BY3PR04CA0008.outlook.office365.com
 (2603:10b6:a03:217::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 05:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 05:25:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 22:25:29 -0700
Received: from [10.221.203.222] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 22:25:21 -0700
Message-ID: <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
Date: Tue, 16 Sep 2025 08:24:16 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, "elic@nvidia.com"
	<elic@nvidia.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anand Khoje
	<anand.a.khoje@oracle.com>, Manjunath Patil <manjunath.b.patil@oracle.com>,
	Rama Nichanamatlu <rama.nichanamatlu@oracle.com>, Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>, Rohit Sajan Kumar
	<rohit.sajan.kumar@oracle.com>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Qing Huang <qing.huang@oracle.com>
References: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: ad589519-71ca-4a45-3d57-08ddf4e17e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzRhZ0hQU2tDcnRUTEtrUlJFb1hEQlhoTlpGS2tMNzF3elR5cHA2dXU4SnpG?=
 =?utf-8?B?K3hPTnBBQ0w2MDNwQ1NIRUdxQkg2SWpmdjZCQlRaZXI0UUZKWWFaVTkxYzEy?=
 =?utf-8?B?bHNvZm5PVE8rN0lzR0lkcm8vWTVmNFYyNWxuNksySmFqbmpuaEt5YjJ1OUJ5?=
 =?utf-8?B?VjFIUE1vaUhZZVluWHlHVXpuQkNuWHZVZE1VSTBIUWwyZmdud2lTYWFudUtG?=
 =?utf-8?B?VFV0NDhYWW83bGVZM3lTZnVzUmd3UWp6ZG40U2pKUTdPcE5Da3M0bnRjR2Q3?=
 =?utf-8?B?WW4yNGRpSzlHUGhNZnJhclRJNVRFVW9sT0FLYm8yOXNyNEo1OGQzY3VTY0NT?=
 =?utf-8?B?UzZYYnhCSXlSUEJvUWk4ZTg0aDc3akhPaVJMT2VkR3N1amZDbGVDYmwydEd4?=
 =?utf-8?B?UW4xOUZITW1hNXdrSytjeEVhWTlsT0M4dWtEa0NRZ1M4bmNtdEkxcVZ4UStB?=
 =?utf-8?B?NlV2QVBWK1c5ZWFDVDRWK2h1bEpQaEE3eTdGY00vd0gwOHUzTGh1MHVIbjRD?=
 =?utf-8?B?dDFHQVB5UCtiaEw0SnZ2TUNqdTNnTTcxWFJwMnduQjlLQ3JvTmUyV1Jmbmph?=
 =?utf-8?B?dXgrTkNiaklmdGxmV1JuNGhxMDVsSkd3OWNGVndVVDd3enlzdE5iY3NtV0Vq?=
 =?utf-8?B?YkhqOGR0aStXOWZxdzByYXNpUWRhU1dkVklqU1hDYlJFTGQraThCTTdtcWZj?=
 =?utf-8?B?M1dSQWorUExNTlJhUjBHa2JWSE9FYlNOK2FPN2pyQVFNbnNRMGtPdTdkc0N3?=
 =?utf-8?B?ZEs2TXpSby9SVmpsYzk4OEh2SitXaU5LSlF2dk1xb2hzSks4czNHUkkwVldV?=
 =?utf-8?B?U0diT1NhMlI1a3gyZEkxNjYzSnRBUHRRdVFFRUNJb1FNZTNnWjN0bnJhRXBK?=
 =?utf-8?B?b0I4M0pJM0p0bjF4MTRMT2tRT0FrSlBxN3M5aUcyMFRyQzl5MEtGNFpTb0c5?=
 =?utf-8?B?MnlaMUg0SHNVa3hsNG85dkNsUy9pTzY2UFZwdDhlT1JwSk45RmFHS2o5VlB0?=
 =?utf-8?B?blN1RmVmN2xWTXJ0VEtMd1RBN29xdkU5ZSt6bHR0OFZKdlZTRlJZRWdEZU90?=
 =?utf-8?B?VW9ITGdZTXhWVnlPSjdQWVNJdjRhdlJTNDRPSUFUSGVVOExFbmQzU1pPdGpF?=
 =?utf-8?B?NUk2TDVTMENscUljL25FbUh6YXNoeFB0TUx1TUt6SG5LRUVSRnhXVFRtM3J6?=
 =?utf-8?B?RGx3MGd4YkxZZzBWb01pdEJ1U24vcGZ4KzU0OFFiWEUyOHRYcnBobG83Q1J6?=
 =?utf-8?B?bHo0RHRFeGlVUHFaS0E2NlBka0ZBbW9mZjlKaDhOeHE1ZTliWmsxMWdQZFB2?=
 =?utf-8?B?Q1R2L21DYXJtQUxQN3ZhUzN2NTIwekVXWUc2dnNXVndUSTJURHQ0R3U3MFFs?=
 =?utf-8?B?VzhSR0Jqem1nNkhyQ0tWd3BvU0lYQWdqSWNtbHFpREN2bFpaTXF1em1BM2dS?=
 =?utf-8?B?YVVhaHJGc1oyTSszMWFKZkZaRnBucnZubytJMjYyS3JueHlMbE1kempBdng1?=
 =?utf-8?B?SEdJR2hBZUw0MTUvU25pVGExQUkvM2huYmdiNTNIUldHOGU3OW9QUk1oaTYz?=
 =?utf-8?B?djV0S2d0NllvaXYweHpFTFdWMC9KRkUzWHNOZWx2UXlrRkRvWXZGSXdoa1B1?=
 =?utf-8?B?SFpHZDVYdzdyZGM4bko2Q1BtQmh5RlRvdXBVVTYzZ1puRlQxZWhRclpXd3Yy?=
 =?utf-8?B?anFHcGJ6U0t3SS91dXFnRUp1bWJMUFpJRmlUV2Y4TVBaVXJZOVN6VUJySXcw?=
 =?utf-8?B?RWZSL2JlUFMxc2hCekJvYWkydVRmZEFGcE9ac2FibHJCelkrdkRqc2xOa3Nh?=
 =?utf-8?B?K0hjNUo4V3EySWpQcDI3b3hzbS9uZVhndGd5dEo5bFZvS1BDMkRqcVkybEw0?=
 =?utf-8?B?RjZDbFZuK2N1YytPTDE5VHFSNnBCbnoxZHkzTHJKcUNNZnRHd3ZyY2I4U0J3?=
 =?utf-8?B?eTdBVnhmRGQ0TjhHVGNHTG9WZVE3Z0FFNHA2SGQxbGVFZkxvcFBoREhiSzRC?=
 =?utf-8?B?ZEo4MXZQTVBiRkpoNVFPRkIxaTljNFF3cGR2QzAwUnRQM0prV0k5TW4yVGhj?=
 =?utf-8?Q?E+WLIP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 05:25:48.0533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad589519-71ca-4a45-3d57-08ddf4e17e5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

Hi, sorry for the late response :(

On 27/06/2025 9:50, Mohith Kumar Thummaluru wrote:
> External email: Use caution opening links or attachments
> 
> 
> The mlx5_irq_alloc() function can inadvertently free the entire rmap
> and end up in a crash[1] when the other threads tries to access this,
> when request_irq() fails due to exhausted IRQ vectors. This commit
> modifies the cleanup to remove only the specific IRQ mapping that was
> just added.
> 
> This prevents removal of other valid mappings and ensures precise
> cleanup of the failed IRQ allocation's associated glue object.
> 
> Note: This error is observed when both fwctl and rds configs are enabled.
> 
> [1]
> mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
> request irq. err = -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
> trying to test write-combining support
> mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port 1
> mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
> request irq. err = -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
> trying to test write-combining support
> mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port 1
> mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
> request irq. err = -28
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
> request irq. err = -28
> general protection fault, probably for non-canonical address
> 0xe277a58fde16f291: 0000 [#1] SMP NOPTI
> 
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Call Trace:
>    <TASK>
>    ? show_trace_log_lvl+0x1d6/0x2f9
>    ? show_trace_log_lvl+0x1d6/0x2f9
>    ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>    ? __die_body.cold+0x8/0xa
>    ? die_addr+0x39/0x53
>    ? exc_general_protection+0x1c4/0x3e9
>    ? dev_vprintk_emit+0x5f/0x90
>    ? asm_exc_general_protection+0x22/0x27
>    ? free_irq_cpu_rmap+0x23/0x7d
>    mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>    irq_pool_request_vector+0x7d/0x90 [mlx5_core]
>    mlx5_irq_request+0x2e/0xe0 [mlx5_core]
>    mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
>    comp_irq_request_pci+0x64/0xf0 [mlx5_core]
>    create_comp_eq+0x71/0x385 [mlx5_core]
>    ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
>    mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
>    ? xas_load+0x8/0x91
>    mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
>    mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
>    mlx5e_open_channels+0xad/0x250 [mlx5_core]
>    mlx5e_open_locked+0x3e/0x110 [mlx5_core]
>    mlx5e_open+0x23/0x70 [mlx5_core]
>    __dev_open+0xf1/0x1a5
>    __dev_change_flags+0x1e1/0x249
>    dev_change_flags+0x21/0x5c
>    do_setlink+0x28b/0xcc4
>    ? __nla_parse+0x22/0x3d
>    ? inet6_validate_link_af+0x6b/0x108
>    ? cpumask_next+0x1f/0x35
>    ? __snmp6_fill_stats64.constprop.0+0x66/0x107
>    ? __nla_validate_parse+0x48/0x1e6
>    __rtnl_newlink+0x5ff/0xa57
>    ? kmem_cache_alloc_trace+0x164/0x2ce
>    rtnl_newlink+0x44/0x6e
>    rtnetlink_rcv_msg+0x2bb/0x362
>    ? __netlink_sendskb+0x4c/0x6c
>    ? netlink_unicast+0x28f/0x2ce
>    ? rtnl_calcit.isra.0+0x150/0x146
>    netlink_rcv_skb+0x5f/0x112
>    netlink_unicast+0x213/0x2ce
>    netlink_sendmsg+0x24f/0x4d9
>    __sock_sendmsg+0x65/0x6a
>    ____sys_sendmsg+0x28f/0x2c9
>    ? import_iovec+0x17/0x2b
>    ___sys_sendmsg+0x97/0xe0
>    __sys_sendmsg+0x81/0xd8
>    do_syscall_64+0x35/0x87
>    entry_SYSCALL_64_after_hwframe+0x6e/0x0
> RIP: 0033:0x7fc328603727
> Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed
> ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00
> f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
> RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
> RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
> RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
>    </TASK>
> ---[ end trace f43ce73c3c2b13a2 ]---
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00
> 74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31
> f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
> RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
> RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
> RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
> R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
> FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range:
> 0xffffffff80000000-0xffffffffbfffffff)
> kvm-guest: disable async PF for cpu 0
> 
> 
> Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
> Signed-off-by: Mohith Kumar
> Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
> Tested-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
> Reviewed-by: Moshe Shemesh<moshe@nvidia.com>
> ---
>    drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 3 +--
>    1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 40024cfa3099..822e92ed2d45 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -325,8 +325,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool
> *pool, int i,
>    err_req_irq:
>    #ifdef CONFIG_RFS_ACCEL
>        if (i && rmap && *rmap) {
> -        free_irq_cpu_rmap(*rmap);
> -        *rmap = NULL;
> +        irq_cpu_rmap_remove(*rmap, irq->map.virq);
>        }

now that the condition is only one line, you need to remove the
parenthesis.

other than that.
Reviewed-by: Shay Drory <shayd@nvidia.com>

>    err_irq_rmap:
>    #endif
> -- 
> 2.43.5
> 
> 
> 


