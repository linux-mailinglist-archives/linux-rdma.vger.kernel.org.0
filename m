Return-Path: <linux-rdma+bounces-21498-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A4SOveXGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21498-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:43:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE14603004
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33AC430247E8
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC0331A4C;
	Fri, 29 May 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q82nc6jm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB3320A00;
	Fri, 29 May 2026 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061985; cv=fail; b=njZOOAb6YbWZbRNT1y+EbM0mt244ITS6DeMkJHrC+CaaSskIrEIVjrktWwGXGlZq+gnid5XW9gGPCT6mxyRXbeztPN4BMAkqrAJC52IQ0G5ThZSZGFi2A9KEVORo4TDoquzcILL+z4OdgNPwSEyIym+UciN4GDeg9HWrI8+1FWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061985; c=relaxed/simple;
	bh=Cwb+kUfnm+DMEzf/efRgE8TbTEII2+ULqgEJGjnrkSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GBbXsIp9MLW4RaBltJfmJEw/VfPXZMSq5F10aLV+W1HeLCx23QJ1Sa/WRvFM/VmXKtvy0zzZUMI/YDqXyjYoCexAQUfPa0EZTHvMZ2uzk5BtgHXRWuI3pZOKMgt47DjkdkNAm1zKsht+hzdo032BvEX6KokGYQZYopN5JOOMRN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q82nc6jm; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThWSnRWbppXQxwNONF8Vl9pO+GJP1tCeEJY+EstCKK/8hw6THjQK9BMdKhoGSDcMxeHNwlIfD5buiq1JnP8mrii3r95X9da3k2m/el/fghF4ipiBIqFCZ2XxRgcWRcWhACqv1QcIxi7SKvm2/kZIvnuIFqvAQH/3AQVLBd2axQZP0VhQ+k5vuW8BIgdb9KxZKj0/CbjunWPzCjSB5TIAkbDmRJgiRYV3QdguTAyuhMDqgtCtXX5u8k89qLrlYssxKiPo/12xXl3tIdZPfBaBIw7OqRKvfw+/k4unFLBuHYXZYa2J0B2j5vgPgdOM34yH4ZkrIiA4NJh+k9Qg+I4/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ry+QiyyjaNzmI+zWoA3o+n2oV8Egk52k2YdXD56sYA=;
 b=G8hzTfDg6IYthk0Z2qpmHd1s56MitXBVlJNJggDZiMgZcSvh1qFgdl/IDjc6+VuWqGI7lqD5bExUNy+ju3ta6QYIFgBSOQ2V6Yk/nrP+x6pI8vDL6KUe9VFFlafP/b3CwR/ZHtxsUn7hXPZU/ihotGI+ixfQ8Gzv7mZbEPcE5eu763LBsNO7fnV/JqyE/q/iaexCeMx1IxqQ0UJ3lsYIfTjp6msYK8VeO1Uu6WQv/ZrmYefzwKL8WsC1EhirdAnxNTIP4tdpXurXSIgXuBCZU/FqoYJJrPU4I9pUHz5cXOWPc7VEbYBuqGp3Bs07hmgzP28uxtoisPb2X2LkXTBeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ry+QiyyjaNzmI+zWoA3o+n2oV8Egk52k2YdXD56sYA=;
 b=Q82nc6jmUotRyWBv2QN1j+df3dG9serCm2WooFWldfi8ORvggeWfhj3dJEtYrkKhEkHjxGWEODrL7y6M04BJ0bc+9wJB4uvfmDEAadZXzmQyfSPvcUcB5FzKhFX5T//1e4YtZOos94FZoLUkalM67KJDLemDr4oKKABrMzL7sGmfVMrmLzgmK8HucJRYiQr+0PQZJWdMFgqOtGUGvWzNYZq66l/TUnFw3FncZWwn/5RRBhgLSBrR8iCJvVJljGpFkHPfeWcx20w7Z8Iv+rcmxpq7dBsWIoBrFtxDfB3+Dlj0FQ/q79un6PZxkV7K9IK60u4QV5faZEvwDzBAl0jPvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 13:39:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 13:39:40 +0000
Date: Fri, 29 May 2026 10:39:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing Intel RDMA ethernet
 protocol maintainer
Message-ID: <20260529133939.GA153998@nvidia.com>
References: <20260526205140.32714-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526205140.32714-1-dave.hansen@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0414.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a65224-0cae-4646-02b8-08debd87bba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bTWTxKJl0woWQaPz5UlJjq6EoubJUvNntGsHIK2jVdlPdRGAHwsbKK07SZ3Tp3VdTW82de0z7pmmB+8nkFi9GgK2QxZCpgbQTuZqLsITYQuGjw9vu8XK5Sxf8fiJYiZX7X586oWlt6It66sWcBv3A9kI19YT6sC6DeXBIlMAMMSh3o3KmTDZsY9PmZJsP2oWpUxv737Eb6AyTvtKHiwBL/kdjKHAEZu8nh1DPY5L3OZqrYUPbujKWl9fxhIdhIOqFnIyBuHM5mA5uk+iitUbxVu1UcoWfO4ul8nOvPAH1iI1iJRxG+jidYrvQKDU4BevhZ0semCMEICev0cF4x6EuJurVqLs1IEGU8HQMPrHSDz7rLuT02GYTXK1uLejuyB0sy5+Jtqnp9p3dgsNO8HiuWE9emhzDtFjPfC1WKVEmmCyOp1iPWaFbeL9K1tUH4m6oTX3nCJesZY63pUxbn4z0S2uBLRTx7nPbf5lQzll7zxfFw/Ocmf499NUWSrXZ/Jk5m9HPTrVikTkhH4S+rD6GZ8JvIhx3IVjWraW+bkvdBfi+sqio+JF7djSHgJy1ZKnKzYg33gRh5EiDlAqw1tE8hJaUS0rAF+3jZWopLhbSplkedh+9d5yvNVCLUUc7CdlhaCUf3OTzhK8cCyUkWMV3ECAcDAweLoHQT6Xv2Iyslr6a1722uP8lrOXxZ8Y7Baqe8tuE4PZNU9UXecC1MKsIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXfndh0uy33VEVBBr0w4OO6QsF+DQVtG/lfwON52d4GFxv8/Hu6ubcwhYGVc?=
 =?us-ascii?Q?LyYn5JJashGCPgvRVM4dMsKtZSWO5SJPCIRzdryrkoxKpqtbtN4A6AzwCeCm?=
 =?us-ascii?Q?V15ckWJITYFg/KeG4rB/u01YxF/N0R5in2wJKGnUY2resUKzI5nzG6yNqScT?=
 =?us-ascii?Q?zp7PTyg5z+XegOx7g9H9m0OF16JP6Jx+kWFCpqymUYyVyOpXu0LHPXFfcAGF?=
 =?us-ascii?Q?qrup5Lb2xL2VKEFD1dOpyeKBDsN6JLuhyg6tH+nI1hcSvnXcHbYbiDcrz/d0?=
 =?us-ascii?Q?hyecpJuiir+SAL683N8HMF55KS8+zVGuyepKsq56/4wa4Z89IcPEgMOj9DQl?=
 =?us-ascii?Q?IRvjv1HRVTp/DC9jmEQYdU2SdSWxryjpzwbotfd53OpTGqnD3ThjhvYD7uDO?=
 =?us-ascii?Q?ZcFWMBUbGTcXIuqT2zrUq2LX5Ty4K5kpA9KmWvsFGXyagXQtOp1FSHtUg4Z7?=
 =?us-ascii?Q?kCY4d+pQpbAEVgPSwGFvp6iRDvrU6tzsvM7VfgQK9xny1HfYg2f8QhwDAswq?=
 =?us-ascii?Q?VNhxCGJG0Nii5ApvopZlK6UShHwA9qIAmn/D7FLbhlfg6hO6zXwPtiyNydik?=
 =?us-ascii?Q?9TrZXGCyqdh/M5etBabcUsD3odGzVV0Hq0On4s962EU1HEVPwuigwmwt4ir1?=
 =?us-ascii?Q?hq2cxJlxDTE4zCdMwoIoJdKXASntN/WE9BIMrmQ/VpC/PQwbajszEXec9FRC?=
 =?us-ascii?Q?man/F+hPSDt2aRMeX+BeTXEZ2lB121UQkfbqxbgM1AAeeYgg61W/hq7aQmEk?=
 =?us-ascii?Q?/JLyxu1v6r4KNJRs4pwBBY2Ife1+SxtsXIEq67a6aZFeHYMhqcNndAtawdvS?=
 =?us-ascii?Q?X3uQxhRy/kW3YIRYeHna9M0ma2encTrJFykkq6Sl6gAePmal2VmvGrMpQgUi?=
 =?us-ascii?Q?WkDg6aSOhpjN7cIIMWB5QsudUP+fxk5Q7JkR7Lqmv+4vq9Hva3U68tKgJrtX?=
 =?us-ascii?Q?Q5Ogno11ZRdkmbv30MMU1o7UgKfVz4cfdmdonsVFVnL0LsjuYNr3t4WO5Eie?=
 =?us-ascii?Q?6/AnQy50qOF5Oqz7l4jxfwTZIaDISAWppJWART1ynjZo6n0MangaVCZMJUo8?=
 =?us-ascii?Q?T2swCh4SsYuSDGQRKHr3cbFUktM1CvBIDK2RM+PQgT2aTo4k/NOhtZa9gLW4?=
 =?us-ascii?Q?138RC9E/G0pIkXkV6odLYIbqDMtwws2VVoFAxaH235rkreAyLXemuA42Vy0n?=
 =?us-ascii?Q?xY8cQE5+93dL4ThtrnTdarIyxusFKFM4df3aZfZkBNfVmm6f3/+/YewdpI6s?=
 =?us-ascii?Q?Obz1XMe/vOlWptgb9Hdk2KE0pmtgaEI3SZXO6IWr/Q1BLAx0oTd4iRwsEXk9?=
 =?us-ascii?Q?jWSDI1w9m++b+pumUllV8Opxg+8bNIbOn0o90Cxm1jq3tKVSBFmZQnRP8PuT?=
 =?us-ascii?Q?2PbK1Yvu4NQjNcqTovfWXooLPxnIm5tRMk2cORgrt+dG7G44cOUBG/E4NqCU?=
 =?us-ascii?Q?E/EKbsql7R7G7IfxjDlf901vMDAGvxChD1ZMIwmxHfe37vY4zLqrpQo93nXE?=
 =?us-ascii?Q?TBjSNFSTO5sOY2SlKUA2Mels5NRZvWGlVHvjLQ7BEW3MVehj0KjnCXDx7zzN?=
 =?us-ascii?Q?0Ltt5aycMyjR4vickMYOgKY7Dauuxanwhhi8BIL2Z78wjtN4H2/tUccq1Jvp?=
 =?us-ascii?Q?63ODDhHQZ+X1CBofnwgzxHEHgne8vHZeRenYh1OmfcfvyrpN+ukf/Eq+vFfa?=
 =?us-ascii?Q?C9WcKgGynYmZUZns+VTdu2cWVagwk4uO+Dw9zbjZZSwcTe4b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a65224-0cae-4646-02b8-08debd87bba0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 13:39:40.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHCgQqNSIxhBsAVMHTYHNXQjlGuq8rXnSY7qcq2t3sPNtb6KpPK62JwFhm753a4K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21498-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 4DE14603004
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:51:40PM -0700, Dave Hansen wrote:
> The email for Krzysztof Czurylo is bouncing. Remove the entry.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Applied thanks

Jason

