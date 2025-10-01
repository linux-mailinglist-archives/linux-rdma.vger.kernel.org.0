Return-Path: <linux-rdma+bounces-13756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C8CBB066B
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Oct 2025 15:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9237A19437F2
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Oct 2025 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A21E7C19;
	Wed,  1 Oct 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upWzUkYd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407F15B0EC;
	Wed,  1 Oct 2025 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323731; cv=fail; b=igkTOXBLZbnDMUNsX3rwdGBKwaUntMkYZPWHaatVFYElbtq0rJfnmIGDLlIciOoZfdlN9VrDnmIUYkqLvEuBbRkllmlxfTFaBD5Xny5e96nTsOrdClOmWfMz6yIxBHtjAixPIzF5Muz1kIZkrP8HKUkUpLpJWZpSCgAwlz/cVfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323731; c=relaxed/simple;
	bh=Pb0KXKIesafPEyjKOsR5g2Z3aLUZl1/F2j5JDAdpfu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MWr8C2weLQ/WfZ2Yd7QfZPywVTPs0+5N6ScK3hCWJEHvfBI32A3SazSApId04DF+X9WHY2JKYNLiTMwxl8koSCNJax2leUjd193joDIICNBIe5fBDMgNY8hyTRv/voIBeyncMmD+mj7+haF9mKZZiEZ2JESnMcOjReWY31W1TEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upWzUkYd; arc=fail smtp.client-ip=52.101.62.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUARnO8pnECHXYAhkjdRgghbSs2ydKZGwyl0lqZ6jU0vi0vqoj1rNUpYqjXxyzV+oEKPNBGGSTLcriP1IRLLVzhsR6sbxCygsS988LvjZeEWiKbTdyVukn1ge4D+x+Z7u+19tIF6//crj5PkCz5mDXFv/3tYK5lWlUptm4ae8Zt3ADJjjzS65kQyOfLfrHbQQH7ZU3k2G294jG0yb2+OFCu0L+8KFsrYnq2CcACKi9ldxvUZWCO/EGaWs1H3LGooZY0SZObsagyCEJvmezpf+5ThVW2fR3whtjt+4cTA4s2niuyzJV5JioThkEVY8MswB6zt9ZjoakdtBt9pq94DvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA7jMTiAWGnnGwxucmjHxFffWSVSeKPAEkyx3V7qvHo=;
 b=r9a1l30YGRHRNOOxTnOAMXZcJ413pSqSvZ9vRtK0iT/1zWQvCbbIGcTIMfLLJJNLPgQwdGx+XlHpoRYQRFHoGfog+eHSV/HQPse4+rJwP+mDi0k5JcTZt3C+MvxUMkz7qczi4UqHkolstIo7Z0zCyz1vlrDjMGiPszxzBcd/1xJLte5YBlpL2HUjzAmlXjHSmOjtQTT6tJGDlLjHhnErzBbehCj+bJiF3ynMJ8Sfan/O1UrcX0hogcDXIyhBG8al3AwO5Zx3g0of7WbbhLUF/NbAsYC1vsSYLvRHazSAefIvNBtO92CFhh7I3FeqLaNg/NeFzz8qfcAxgjW3GjUKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA7jMTiAWGnnGwxucmjHxFffWSVSeKPAEkyx3V7qvHo=;
 b=upWzUkYdwXMmxB1YdTQ7v+qatYAYnTHX7RxiTQ3F73bzrXZlV9YjePBPJNYiH4s651oVH3oSs4rsIwrgC4o6BvINazSMiq+zvfoyLw3BzF2mvlmNfCK3sy7AMgGSRSGdktetlNpDmnP2IjH+zebg2tmZA48m2gA3e44KN0bY/YvDs2zk3wZmJKIRhxJtyr/0gjNl8r98i6sALvd97hRLXAFWnjvVRuhp116GMtUdqXERUUFPMqC6SnGErY18HOySMlOQf6vU+A2XvUJGRSqzhK0O8sD6RRJkrGGxKzEQPKPrwxszvNHLf3TEv/01py/gUki7A34S3JrUeDfomNR38A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 13:02:06 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 13:02:06 +0000
Date: Wed, 1 Oct 2025 13:02:02 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mingrui Cui <mingruic@outlook.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	saeedm@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH net v2] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to
 page size
Message-ID: <cyashxbmwfkcbqscgyudij5yzkso2twpswqcf7ev2h7a64n67k@zvl3ht2pxc2b>
References: <MN6PR16MB5450C5EC9A1B2E2E78E8B241B71AA@MN6PR16MB5450.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN6PR16MB5450C5EC9A1B2E2E78E8B241B71AA@MN6PR16MB5450.namprd16.prod.outlook.com>
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 434b877a-bbe5-40e8-f406-08de00eab8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8nvGWYTxhzrbePG+Lg6/fYOoY6ybXvtMeWNRCbrybX71DKZREWdoNoaWpHHk?=
 =?us-ascii?Q?YF61EVcHnTmE7zeAn72eODVooVpVD5nI6WRhfsLsP6eRxFTrzNvm+UuU5msl?=
 =?us-ascii?Q?BNGv5/+yfsRsoandzY7s/KEaMwYNApqK6GnrBtxDHGgNQch3EpIYDQt3irOq?=
 =?us-ascii?Q?4bWTFPo5MgPdab8e3gO+JAGQ0nJ7d6FaLfbomSROmzq6oYAPhXcrqIECszdx?=
 =?us-ascii?Q?54NcZdzisQ2XGU7RIARgWbr0rSxThBg3EKbMRca6S8laoM15XfNz/SCAJ7zQ?=
 =?us-ascii?Q?FXZ+ocUsc6hJqOAKzWTfrTzyCMI/nhUtJp9cxiX+svQXTxXOX+uGngZWxU0U?=
 =?us-ascii?Q?hN9IYfXqKFzhSfuim1IccHfN7GmSOh/O3br6K7TXLXwuB76z5Kq7CQsOmp9D?=
 =?us-ascii?Q?aeCkzbznypQN9c+RcKIm/gTtU9/jnfaM+8acMBqfNPRWPeHn4PbIEtQLizBC?=
 =?us-ascii?Q?ySNCNyYcDN9R3uM4nX10WKbRvbIp1pFILk1yW7gOgPn4JstEIRKaToqJqivv?=
 =?us-ascii?Q?Vsd9gzkks4A0/EIIRr+a+wKLsxketLBEoHwlVXjxoDA3hNDsdxuJAZL+WFsp?=
 =?us-ascii?Q?5CDKUiCq3GxTARDXukM2ZEITjA9Qzr+SpRVr4SLHNi76v1wltgSyVcpVv61b?=
 =?us-ascii?Q?u+c+km8V0TSs9y7x0SMYjZSH9o7JSNHyOmF8xVtRFGUnpGfMLa9Ke8GGqoQU?=
 =?us-ascii?Q?kcVMXBgsltFULY8nUFWmQQ1706A0D1bPUpahnme77aDcRsYIJfji7cbg/e0a?=
 =?us-ascii?Q?t5nZ/oVcGR8mifJZIyt+TVO2I0lWmvnrIKzulJSN9vcbKXdWdd5IDNCFQvj8?=
 =?us-ascii?Q?3LObN+31LkYjeq7Dhwjrk2Rax8MhROFtNkDbtmPzXCR7PfwxYGZDvKmdlvaF?=
 =?us-ascii?Q?+8j47WX4lFF2CUqen53WXuwREspVqeUAGRRwEHFWOoTUulGKajiVbw+Kpsp8?=
 =?us-ascii?Q?E4EDtLeF0skEJJHXhJvIoIbkTyPdbB1TfZYnQvDornUWPjHyKnFXGr5oNHF4?=
 =?us-ascii?Q?5AQhujEJmf9Kkn7Z/9ZovntWzn2bmpUgx1wiXyYE02EUW980f8CF6TYyUaWc?=
 =?us-ascii?Q?reqmP6OptaJ7uu0/0h42cqu9XPb94zuRQOtjFTls1LuJnZEyZbOzqSIMWgK4?=
 =?us-ascii?Q?rZr4gChCh1iD0AiX3dXDJd6fMTDNhC4rMdy/juI5PxDs+yz2HwBPBPq/y+rU?=
 =?us-ascii?Q?Xc/PahcpddbQ0VIxxCqdW5NH60ZEDl4Dr17UY949/2AiN8xZsKCialriT4m3?=
 =?us-ascii?Q?R3Db9k66bm7PaZ60nUGVDWcG3FCoh6jPiz+ziwI/jvDJeIFrWx8C4jdjVuGI?=
 =?us-ascii?Q?vWDp0dL2DLde+MRVr5oEjynWmqm5o7hU/a5CStdHMOeP4O1dRdMVtgLAqDnT?=
 =?us-ascii?Q?Ma+TxfqhdbTbq+TdbJqVxKnwOofc7q2K77plnQj/Ao0SqTis8zxpLaqDGkkY?=
 =?us-ascii?Q?GVIqkkf0/Q1B8C29qoH3nFT7VLd2KLH0y3vZyce58iQ5yHZ9xEc3Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uRlJ+fBssMqwJhO7irxDKgpauh+VlSgajGrL8WR3sfsZoWvTkuo06MhKps/u?=
 =?us-ascii?Q?0zQCegt5NkaxCaUaXiSoxoBkJwl/23OXviqsqvEMhHGIfLnJDT65tVhQNF16?=
 =?us-ascii?Q?gnMj1V4RUp6dnewE6snoDOBq4xPk9gIulkW141rvOposu5HSBFu6sqBro3X+?=
 =?us-ascii?Q?mIZxAlg8U2NpSV1vls5i6nt1oUOJaV5EqD05hkg3x22ph2ID88vBW9fu0pfz?=
 =?us-ascii?Q?AYI/GJBKEl0RmTdKHsa/1qqUlAwTnEa+RYr2KscpPwXOy9BISkv4TduY3Oz2?=
 =?us-ascii?Q?t9sMDxju7dusMSgzGzIMQcgZw/Fkcn1sXjYxDDobP3sLtPp1sfUBk+PIGfaf?=
 =?us-ascii?Q?8ao0uKJDhiPuC6TNFKBaql2sEM2kHRW+69SSi3kZKtVPtaHLuxpOd+QtpiDv?=
 =?us-ascii?Q?drEQ4NjeCx5OFAotSSKzg2iXBPlX9XS3CcAwp+5cV/KaOQVN82iTsLsw8BUR?=
 =?us-ascii?Q?oJTrZ5TiRdRm/mu7V/uBP44v6NHVbeg6wu39thFC107mGxoeOjuGX53rd1om?=
 =?us-ascii?Q?TN95GrHEMGMA6f7YsJm5cDy9ugVvc7aVNG8uc48OwlUmnqqQwd0McbSOd//c?=
 =?us-ascii?Q?ph+v9Kcrlah7JsCv++i0/4WJOO8A9CsCI2kJPLuFLoSXC8QZ83kQDEkN1LZT?=
 =?us-ascii?Q?W9zHwQPzkjZFtHKrmvwXn2VLSUmJVpOxsPZ+BbqTO+reMZnk4dtBapQF++fJ?=
 =?us-ascii?Q?ozs26UfmcsDCRrnw4UuJy2O+7xINo5tZB+OHaTbe9FEbHm6p3WvLiKM0KO+1?=
 =?us-ascii?Q?h/N2URnJM0RvX1ALe4ooYlHKxV3lN/Rk+sHzG6UOrZ8d/2V7rrbTGsHT21fy?=
 =?us-ascii?Q?vyjFEb8emDlY4OgBhby47l0B3+6Vyd5NKlNt5wQ8bXCxeuIbhGY6svOIQo3h?=
 =?us-ascii?Q?lzrfcvgQ6iMaFJTKVJuS8ks61PHRZcmBOArXIhcKobyNvoQy/C0OTm2HOYQ4?=
 =?us-ascii?Q?WFk6cVM6iQo9b3Jgv7O5mnABX8MtBSDQuq+uzsnbM/bX4OQYx6g04+w3Aswt?=
 =?us-ascii?Q?DWETIGXxjlL8KIiCZ2XMvrCsOJDILSfylNOzcTgHVMgu1jW9lAbCu0RsjGlV?=
 =?us-ascii?Q?ZCxVxHeHYOUQJB6exW3mkmtg+ge7Az5SY+CzAsCEH0ZqfAg5+M8CaiYwF7/x?=
 =?us-ascii?Q?0WcPDr1laWfk/7UCR66mL2TY7AT1Zv88owiqGDzr34LbpxDrAJ7+Lsklmvx8?=
 =?us-ascii?Q?ZsPLMf2mHhVv2pEVdD6uWij18RRJXUyiQCMkN59nECKItQIga2ngBlce1xQ0?=
 =?us-ascii?Q?iQb6XZvpTxHSJR98e02KjhH3mmW1UfDPfvYBbMUftOg3/JnKGHcHBcln3h5p?=
 =?us-ascii?Q?mznkzlk+wNs0budEfuRKu+Krqoe+r0jrw6IfHHz7vKs3AC5zMpiqHZko5ZiL?=
 =?us-ascii?Q?ntaFNQRW1wB+tlehPRuB802H0zIbnt1sV7tObFuz68sJvJoQYey/GKUMXH1m?=
 =?us-ascii?Q?oYQi+/U3wroUxu0MzPBbj9MdsdHV7V86X/U4Tm3/ZHUD8PtwfQfq7TpO/U4H?=
 =?us-ascii?Q?RSshLyyoGtWeVKd14FCXl9yHzdxCC1+rZ+iZ7IlJ0gJH7NycD2NwhsAq6S+q?=
 =?us-ascii?Q?ca7XjFX0RC8bwH8WW+W2PMs0FChePhyLK0EPtwHy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434b877a-bbe5-40e8-f406-08de00eab8c5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:02:05.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiAkj0U9w4U+GxmQ/Gs8rX/rPTYcPyPo5eOD0ujA6PtlSZLrCUM+PdbkHP2LsUFDDYbZ8vdXX7ipShlE43vf1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044

On Tue, Sep 30, 2025 at 07:33:11PM +0800, Mingrui Cui wrote:
> When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> fragments per WQE, odd-indexed WQEs always share the same page with
> their subsequent WQE, while WQEs consisting of 4 fragments does not.
> However, this relationship does not hold for page sizes larger than 8K.
> In this case, wqe_index_mask cannot guarantee that newly allocated WQEs
> won't share the same page with old WQEs.
> 
> If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> page with its subsequent WQE, allocating a page for that WQE will
> overwrite mlx5e_frag_page, preventing the original page from being
> recycled. When the next WQE is processed, the newly allocated page will
> be immediately recycled. In the next round, if these two WQEs are
> handled in the same bulk, page_pool_defrag_page() will be called again
> on the page, causing pp_frag_count to become negative[1].
> 
> Moreover, this can also lead to memory corruption, as the page may have
> already been returned to the page pool and re-allocated to another WQE.
> And since skb_shared_info is stored at the end of the first fragment,
> its frags->bv_page pointer can be overwritten, leading to an invalid
> memory access when processing the skb[2].
> 
> For example, on 8K page size systems (e.g. DEC Alpha) with a ConnectX-4
> Lx MT27710 (MCX4121A-ACA_Ax) NIC setting MTU to 7657 or higher, heavy
> network loads (e.g. iperf) will first trigger a series of WARNINGs[1]
> and eventually crash[2].
> 
> Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> size.
> 
> [1]
> WARNING: CPU: 9 PID: 0 at include/net/page_pool/helpers.h:130
> mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
> CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W          6.6.0
>  walk_stackframe+0x0/0x190
>  show_stack+0x70/0x94
>  dump_stack_lvl+0x98/0xd8
>  dump_stack+0x2c/0x48
>  __warn+0x1c8/0x220
>  warn_slowpath_fmt+0x20c/0x230
>  mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
>  mlx5e_free_rx_wqes+0xcc/0x120 [mlx5_core]
>  mlx5e_post_rx_wqes+0x1f4/0x4e0 [mlx5_core]
>  mlx5e_napi_poll+0x1c0/0x8d0 [mlx5_core]
>  __napi_poll+0x58/0x2e0
>  net_rx_action+0x1a8/0x340
>  __do_softirq+0x2b8/0x480
>  [...]
> 
> [2]
> Unable to handle kernel paging request at virtual address 393837363534333a
> Oops [#1]
> CPU: 72 PID: 0 Comm: swapper/72 Tainted: G        W          6.6.0
> Trace:
>  walk_stackframe+0x0/0x190
>  show_stack+0x70/0x94
>  die+0x1d4/0x350
>  do_page_fault+0x630/0x690
>  entMM+0x120/0x130
>  napi_pp_put_page+0x30/0x160
>  skb_release_data+0x164/0x250
>  kfree_skb_list_reason+0xd0/0x2f0
>  skb_release_data+0x1f0/0x250
>  napi_consume_skb+0xa0/0x220
>  net_rx_action+0x158/0x340
>  __do_softirq+0x2b8/0x480
>  irq_exit+0xd4/0x120
>  do_entInt+0x164/0x520
>  entInt+0x114/0x120
>  [...]
> 
> Fixes: 069d11465a80 ("net/mlx5e: RX, Enhance legacy Receive Queue memory scheme")
> Signed-off-by: Mingrui Cui <mingruic@outlook.com>
> ---
> Changes in v2:
>   - Add Fixes tag and more details to commit message.
>   - Target 'net' branch.
>   - Remove the obsolete WARN_ON() and update related comments.
> Link to v1: https://lore.kernel.org/all/MN6PR16MB5450CAF432AE40B2AFA58F61B706A@MN6PR16MB5450.namprd16.prod.outlook.com/
> 
Thanks for your changes Mingrui.

>  .../net/ethernet/mellanox/mlx5/core/en/params.c   | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> index 3cca06a74cf9..00b44da23e00 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -666,7 +666,7 @@ static void mlx5e_rx_compute_wqe_bulk_params(struct mlx5e_params *params,
>  	info->refill_unit = DIV_ROUND_UP(info->wqe_bulk, split_factor);
>  }
>  
> -#define DEFAULT_FRAG_SIZE (2048)
> +#define DEFAULT_FRAG_SIZE (PAGE_SIZE / 2)
>
Reasoning my way through this code as I can't test it on 8K page size:
- 4K page size: nothing changes so looks good.
- 8K page size:
    - Smaller MTUs will be using linear SKB, so frags are not used.
      Looks good.
    - Larger MTUs will have a frag size of 4K. The number of frags is
      still below MLX5E_MAX_RX_FRAGS. This is what this patch fixes and
      it looks good.
- 16K page size or larger: as max HW MTU is somewhere in the 10-12K range
  all MTUs will result in linear SKBs. So looks good. But see below
  comment about keeping the warning.

For non-linear XDP, frag_size_max will always be PAGE_SIZE. So this
looks safe in all cases.

XSK with smaller chunk sizes is still an open question. For 16K page
size you could still get in non-linear mode.

One thing to note is that mlx5e_max_nonlinear_mtu() will now depend on
PAGE_SIZE as frag_size_max and first_frag_size_max are now MTU
dependent. It wasn't the case previously. I think this is currently not
an issue as this function is used only by mlx5e_build_rq_frags_info().

>  static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
>  				     struct mlx5e_params *params,
> @@ -756,18 +756,13 @@ static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
>  		/* No WQE can start in the middle of a page. */
>  		info->wqe_index_mask = 0;
>  	} else {
> -		/* PAGE_SIZEs starting from 8192 don't use 2K-sized fragments,
> -		 * because there would be more than MLX5E_MAX_RX_FRAGS of them.
> -		 */
> -		WARN_ON(PAGE_SIZE != 2 * DEFAULT_FRAG_SIZE);
> -
I would still keep a warning when reaching this area with a page size
above 8K just because it was not tested.

>  		/* Odd number of fragments allows to pack the last fragment of
>  		 * the previous WQE and the first fragment of the next WQE into
>  		 * the same page.
> -		 * As long as DEFAULT_FRAG_SIZE is 2048, and MLX5E_MAX_RX_FRAGS
> -		 * is 4, the last fragment can be bigger than the rest only if
> -		 * it's the fourth one, so WQEs consisting of 3 fragments will
> -		 * always share a page.
> +		 * As long as DEFAULT_FRAG_SIZE is (PAGE_SIZE / 2), and
> +		 * MLX5E_MAX_RX_FRAGS is 4, the last fragment can be bigger than
> +		 * the rest only if it's the fourth one, so WQEs consisting of 3
> +		 * fragments will always share a page.
>  		 * When a page is shared, WQE bulk size is 2, otherwise just 1.
>  		 */
>  		info->wqe_index_mask = info->num_frags % 2;

Have you tried testing this with KASAN on? As your platform is not very
common, we want to make sure that there are no other issues.

Thanks,
Dragos

