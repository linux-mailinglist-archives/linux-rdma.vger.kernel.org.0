Return-Path: <linux-rdma+bounces-19650-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOLXLSvI8GmfYgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19650-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:46:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA748743A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EF1630E35A8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18044CAD0;
	Tue, 28 Apr 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gMud+Foy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E77441037;
	Tue, 28 Apr 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386261; cv=fail; b=iTJdhdoIijk6bniNwNtS4ghUqkjxoFjgvJSKphj48d73DiO86YVsgauHE2+SlMFjtXkUdKCa3XU1/2Ipt1EJg89PqSszgUrQTvTcIvZfo+q4uwpROI/jlkeBuWANl/5/S80JIBb4VDlH64asyavx+8l6F/FXM7hpraSGWwFdglY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386261; c=relaxed/simple;
	bh=qoc87RH1ffIcVnqP3aIKwPRfsA/w6qIAqFh3SNAyvMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SYwIRNtc93l/Xr6n+TNTeuM1H66KqRtwer1bCm/heokwj1KOlMCDppmNMtzuD+9OzecwRs/l9JUrwPOcPJYIHDDdZKmGlZRF2w04zrlVGD034j6uK1guqWH6OoWCn7utNwWnKBmjcPy5hQidCsf2hi/WFG63G2MWK7DcR5tCuwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gMud+Foy; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWPd4likUw8V2YQOi1q6gi4DojXF8kSe5rILQcWQD6sUq7cggXDR1PaAmP4NhYlKE2VX1h/RVH8tPyqaS/c/tW/1GEm4DshS/iQAhQDtkm4nff5EctiRtMcysDxGdfNAXdt9J5HaXvH4ZKrQBPFvI7Cf4+Cyxs7FF2EFEN3Y7zubbNKBMddYKZ1DTp5URECZIgZDmlnuYaSZqJ8YgotcLfe/RTyYn+xAMcydkME8ErSNNCiDYKQYK8ERJgv7i55WwwH7YOY9q3OOpJvIPqbPGfKHRnridJavcw337n/6hspry2ebpK/S9D1t0m5riajrAohu5FdB3lQwYGaRTOK9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuD7fDuBiGHrW5rIqk4/uGc+qFAPIFNLYxz81hDClEk=;
 b=VdbuMyESXzSvTwflFkBu1EJIxZ8G6PpqeYvhYrmtrTLon1yzjn5gVL7EU9Cwd8uCU5erA9JWwkhuhkFc4auh5gYNXbrmkIMlSn1kWbiwIBREJOiCNsz1ztIBfdiW5l2XMP9C0GVJxookO4wk9/6lY1X7TTM+Fs08muRgUuy9izj8p+Us45f+8A0QhuEz2VfqUmI8bmx41FryJ1SHlczWjiF6Vd1jFH0ojFokvey28ArCshZ0C/HvI02SsQkJTD1X96nEPRpIE87vePnrFjjFwc+BL3YTHfccYsKznPHEn4tB4iD6jOVWuMH1o5mIB9/3jrM6rsEl/iXKn2ouIXCVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuD7fDuBiGHrW5rIqk4/uGc+qFAPIFNLYxz81hDClEk=;
 b=gMud+FoyclD0L4NDpQRZdE6s/3gUqGyz9Em4X17WAfGdC7t/kVqgg6OXnRvhmqIac0crAzRfUokHu6WN4rlSFr1SpKRoHtRDen5gV1TRdszqUx5HKyoAXgfZ/itx4cm971huReeW7y0nVnlMHyApKHpBc0Qee4ckSElpTgS36te0NrlN7GnpnTFZtyyuXJUCh5p/bqZjnKbgHJ7lbO8jqDULWPXVwaLbnTXfJKZveKaHyoaftBQwxYAng4QbtnbdHc4ALSBU9hJ5Jsm+2kHUuLXqB0gKFrGUK7bL/7hGU58EiK1wunrx6OkXuH2WbpKwWZFEq6bKgnYN2WmzLdVZ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 14:24:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 14:24:12 +0000
Date: Tue, 28 Apr 2026 11:24:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kyle Liddell <kyle.liddell@intel.com>,
	Caz Yokoyama <caz.yokoyama@intel.com>,
	Sadanand Warrier <sadanand.warrier@intel.com>,
	Arthur Kepner <arthur.kepner@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Fix potential use-after-free in PIO and SDMA
 map teardown
Message-ID: <20260428142411.GA2606586@nvidia.com>
References: <20260206050836.5890-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206050836.5890-1-lirongqing@baidu.com>
X-ClientProxiedBy: BLAPR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:208:32e::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: c5638041-5e9e-4a4b-7a71-08dea531d1b9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7a06Fb2z6KDaG83l5FgFSlZ1j6qgL9jk9tejn6S5cj+4Gpkw2Y6cfagOosIveJG2Bv6KcSBsBeEmU/lBYbXVsM9Siwq805JhAsY6gdff10PG9fRWq9E8KIUOzgA6tYzz2C62pvSxvffuBzJMMUUcM2woY6775SIqyJKYYls6H9pr/DRwLVtzMz8Mtd+jvmNcDNK6G35G7szl2Kk4xr1CjFNwUI4yPFafU6tvlTTYqbBhTka/1Ld2J164OBtPVqMoFPqoonDXW45HXw0lsLa6fVxF87IRkm3ntahkwdCwJBqSH083O+J2L/FE4+Z/x0i95u3Dt61+Z3ESR33OOPtvrRFMDvhcGqWCy7H47PoOy18NiZXIvHM+mqDx4vpzNQ+09KWYa9atAOFzwcLCUxe8Y9tZuWMoLtqX8RGy0mP8Bm6iWnwozr2d4M7pemc4EGe6liPxs30PznU6fCuOTdBrSofGJGpt6dZ5LckndfDpeIg/0/eT1iYdq2iplqSO/Rahq97DADRCOHTigTCV9yYxwivnta4azq5H8hMypnV4BPkfhEDQN38p36stZxV1PFVdsCA7MzpCC8Cg5N7NzCI5dzsT1qsPt+zQbiO0BhkQ3Jb8RJxpN02Dt0b/vIsozJf42EG5C6ajGTmK4J4dnFSAh8Bugc/R6vU/Q/LsJq/H4vLUZ9f6twV7kF7aUZ2x7le6q9EasdjQhuHR0gCB08gEn3U4eZz/7hy+I4K0TJbps3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WQXTHJL0Sz+godKo9L2lK8ZVjxdB0HtJv7Dxs9940MgkhN3JA4rUDL6HtDRw?=
 =?us-ascii?Q?Ex7Wt2mEl7BCWS+X4XOxdyyy1jfQ6boEiMZYfd37HpsJDRk+u6TqL2C7myji?=
 =?us-ascii?Q?zzMwm8GTOl/CCKtmZ98nWev2lnh3XMngrkewXGmZ++imt3WOs1Jw2T1PLMUo?=
 =?us-ascii?Q?xkP6AcPL6SBpTW7KQgBWdTAztHo/97iYiDgG2THlPSQZYCxhWs9jvNOtZ1oX?=
 =?us-ascii?Q?B3WtXhQYxWtCqLq/r+ly3EYUD2yF+26rLt3jItH0oG4i2rLgE425dYpA4+FB?=
 =?us-ascii?Q?Zdz5tgPmS5PsAmOIpk8pQaRTI7x+hMEqI3HIMfSpHUc1GtO+GG34h6FEyrYK?=
 =?us-ascii?Q?eHuNd2vKkeWKo7mL4mGO6oIR2BEgrdsK5ogYA3KduhTDyRQPAghm4NFrWNvI?=
 =?us-ascii?Q?nGHBvC1WhxI3d4Lnmq2AWQjmsRGU0sUhliBOckWKv9dWG+juvAt4DIjEav9Q?=
 =?us-ascii?Q?8ZQF0QFEUFBOaUshfWloitMQEPkPE8SY4zjpeUYkHOPZz2il0FyS73gkQvuB?=
 =?us-ascii?Q?kbLMsQoYQGJLS0p2P5VHJ39h+lH8XCZ269+uOjMh8EtsAfEHWlIjauoxse2e?=
 =?us-ascii?Q?tGrndkFR2qW/RN6TLGjHiD6Tthob3/g4ZM0GS/PKBax3qOBb3EMUoQRLRwbB?=
 =?us-ascii?Q?weP9thDIjaFO9rjESMYDjyS8y5Z6Sk4EsRPlqaLiNvB6QkclkxLfvDyZOtIl?=
 =?us-ascii?Q?WI0VMr9QeWA+TMa8UBYM/OjoniUpbS28sFiUVqv9/IT8jeKGmsjg2Kuf7v5y?=
 =?us-ascii?Q?ygLdJyYPO+m1jz/tRjPM3bYAKWu9vugOl4Y6dxL7zCtJ/Q1lxzf691y+Ql19?=
 =?us-ascii?Q?IGYq6d9LXMDSG8IJEE09ImLHHJi40+trz7mapu1qS3DHviI56Wq2qYS5FQSj?=
 =?us-ascii?Q?dh/t7f0NZXGZdnaH7jt0rD+QuZzcUzVmKcaVTZC3oMR+o1tXfdsG9142bx5K?=
 =?us-ascii?Q?IAMCYwOZf0fJSWYtIWWmvWuaAYC/96BkCDPbwu6vgf+s8CMlNxiZ2yYMkOXr?=
 =?us-ascii?Q?u1tV0zM4ZtEgsBoLPVSeW0/95YgnQarL1FIC1eFS41if5uDxRnLUKYuC8LWF?=
 =?us-ascii?Q?uhxyHS/qXkfrXWUu+HkPY444tm7JqVWKXIDrTfUIUThLs7iAGBa2HfGDb8+6?=
 =?us-ascii?Q?PD+rUrBEOFDzEIEKIq8EGI4o3nfaw8axBNt/GAkVJW/rvpAfjPmXBrgHp0HF?=
 =?us-ascii?Q?5+H0ZrHcGrWHzxEJGlV6zBNF+kPzIaOHDeu5G+jpWnoNP19dmVBv/jA+kie7?=
 =?us-ascii?Q?g/pMi8bEwLezFZohMOMSp0JHe5YXY8+VQVGnb4l+zTNoFrMK5bE5VBEoe6Wx?=
 =?us-ascii?Q?C+Ao2raEsgzKqTsAjIDzemFIGAepaNvKBgAA80cnE8up0Vy/+AIXwC62MZ6F?=
 =?us-ascii?Q?DgPZy+HRa56BXonKweeszr77xplZrmaBa1XEsu3EbYtbt9O5uzlVZISPNecs?=
 =?us-ascii?Q?f+ruej9bEQCzQC8EyPMcz5eX+x4tS0kNToXklRzAhoW4J/LnCrP85QxdA3h/?=
 =?us-ascii?Q?rbQlBmwJKSDLzB9O+WYM2flCYei75bB5ND9LtBUb1JYqK9E61pBRhgYtFazn?=
 =?us-ascii?Q?bOB6AHpHDbJbYGcCW65X2JVw3bgpWxkKM89RBgeTfAHv0WkDL9iut7e9CWb3?=
 =?us-ascii?Q?7maaG8q/qoQ4QhkAn88pq8wBHBOiB3WIkDuhiO7a9/ae/r3ij8dQkocf+AgQ?=
 =?us-ascii?Q?u07MJ4PKciE0QwJ8zaARkFO6yOVZwnQ9Qvz096bIam4lQ3YJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5638041-5e9e-4a4b-7a71-08dea531d1b9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:24:12.6089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrQ/QeHdbFSxOxOmN6cSpi676QPkGe7aS8UarMu1lVzX5rk3hlOz8JCd6UFwE2p8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
X-Rspamd-Queue-Id: 9AFA748743A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19650-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, Feb 06, 2026 at 12:08:36AM -0500, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The current teardown logic for dd->pio_map and dd->sdma_map frees the
> structures while they might still be accessed by RCU readers. Although
> the pointer is nulled under a spinlock, the memory is reclaimed before
> waiting for the grace period to end.
> 
> This patch fixes the sequence by:
> 1. Extracting the pointer under the lock.
> 2. Clearing the RCU-protected pointer.
> 3. Waiting for readers to finish with synchronize_rcu().
> 4. Finally freeing the memory.
> 
> Fixes: 7724105686e7 ("IB/hfi1: add driver files")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/infiniband/hw/hfi1/pio.c  | 5 ++++-
>  drivers/infiniband/hw/hfi1/sdma.c | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

This does seem to be a legitimate mis-use of RCU, applied to rc

Jason

