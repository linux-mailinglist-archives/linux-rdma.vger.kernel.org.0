Return-Path: <linux-rdma+bounces-15054-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB80DCC9800
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 21:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 493B63007B42
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64192853EE;
	Wed, 17 Dec 2025 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LcrCvTdh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185C14A60C;
	Wed, 17 Dec 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766003703; cv=fail; b=oyDtFLN98oN2+PXJ0oe1pCLlDdApL2zNfUQJyluRIM8gv7Vbah54Ovc+jTyDLESAAEzEO2ztNrAU9b0PBMWwM4bRNihihIupnMsb+7WRi4OppFvmrC4d+h2SNv3Q8wJ/rdIJP990Abbnq6xt0eUEjt7fBN2a0C2ASbAudUOzpGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766003703; c=relaxed/simple;
	bh=TN6pSM5IQnAXoyjvYUHe85b3S0zAzyGoyVlJjGT6mEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rKvrAklHkvqaigREgSXUVmiqqJqEz/l8LvnL6hI2Q0dwPgqyOSR5Emk+oBC2dPBaeJGpJ9rQ8+QVW15F/aKg/iV3pBJzIUlYEYOEEP1atbcGbFXvNxARjdKWgEafPkKBfVmc01xuZTPl5F01cKzoeGBuizAvIHHV9WJf1U8TA6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LcrCvTdh; arc=fail smtp.client-ip=52.101.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+mHVjg1cFTceywjoAVebuFQ7ktxGOp8Vu2FT+1czhIOVcMrx7tMh6zAGW5ysLp18XRVCR5hw1MtJqyalVv8nTsPPwXQaVqit8gDBw0IXdVj/f8tcobbMuiLcbLk2ef6izZuGizig9BLHlhBg88XszAfbmAxJs5RVJS5io8pGvqWD6Gec4IVcMB305YyoopVKxmfwS8TkQ+zo4B9M6MOBYBx7+aejdQ/3lqHuEdpExFqnXG4GFLBF9RNXu0PdGLAP6lh9UM4BbG708eOCs/qEL4Q025qoq9aREtPYYyXIXxv0wz4s1Gx3FJpYuTKqEYdLWKEbFb0woCBx37aVCF8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiDqdceTY988RCBdeYgbt22+2r+PCJIF2LNfCxLzvko=;
 b=Dr9IAN+fkH3/dkweb5jFllqXsJ7/U/l3Cj2w6TWtPUY04A1BRJab2vBcU7nZcpU4tFv8dfztFkuNpEi5yzTaUxvqh1109Jt/Xxmz0nY4nGLF+7soc2tFmBF0Rmb7U+alTpl02VzvllIEikYVu0UBUhPwl1K6OdmX7YsGzZkVtPawPVw12Q0Rk47zuDkdywnKt1ipKe1pVcS5+dWivaWmRWRO2LWoyACVk2Xv4yo/2ymSyMBG6LqLXVkGTQeK9hPSkPc7FokiubLA12cIFht1+uvRacNW/5dFVMyqFuYlzJIIoGbreEXsNTKwHOWsIlaYDQB+ZG7UY6XXQSOixjRDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiDqdceTY988RCBdeYgbt22+2r+PCJIF2LNfCxLzvko=;
 b=LcrCvTdhgX5hvEArC7XmxtS2+dccSxz8ACCIFnvlK2nteuUQiDeyUqE0eyRtmsdoY9HzQus3jfWUTxn6e1FjWRwEHLEsa6/LA0R6ubcUiixkTG/eZUYU9AM72lY+4LledU+nkwSBUoPUBEXRWrPpwfQIcOyUrdqcTjYiCtgI9bwFaAyDODtxAlQPQiHiUP27EGAng1JnrjEMSih1cz7R23dyznXHq6fMEzaRi0tioEsPMf6VyocXkhlXRfKQm36uxVBTM5XO6rNonVVgOGaQvxNfDQL3INvsx2NJWw1T9EqTPupnNDh03uVmntun8nbEPabG/UlclDZv/IR1W8Tx5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:04:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:04:05 +0000
Date: Wed, 17 Dec 2025 14:04:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RTRS/rtrs: clean up rtrs headers kernel-doc
Message-ID: <20251217180404.GC211693@nvidia.com>
References: <20251129022146.1498273-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129022146.1498273-1-rdunlap@infradead.org>
X-ClientProxiedBy: MN2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:208:fc::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 53676aff-b450-480b-1846-08de3d96aa91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?GvX8Oe5KLZZDwPbkT9NMq8I7IIbxB7rDoYoXedfjNJ9Xw38k/LhAIvhqHwrz?=
 =?us-ascii?Q?C9TJSXiCLzI6BECOkfiYcHpD6i1JcK9A2wAG4uJ2qEPec8DcMcKfKnlPeSVV?=
 =?us-ascii?Q?jEz0N5SarTBB6jcTjxpSOHsxItUv23cD2X7LXWU5kGmrmHk2xYXPZpxwhN79?=
 =?us-ascii?Q?wP8KxNqzNApsc8GqvAEJ0DqT4CNwsL9q1kWsrNIqvTwmXm0reszsX+8uIud0?=
 =?us-ascii?Q?St2CsrQwE+Rmrhr12g3yjoUYKfrsmLb5rE7ulsJB5CK3+iQ4LnoA+TTOh/kh?=
 =?us-ascii?Q?VyEcTXuqnOe53ggNXqTHcHI9KTU9B49AAWw4JQ7y+FMK3YT3FTLvtkVSwVRm?=
 =?us-ascii?Q?QP05vGS0LKIoPRwe2gsSzaOFt+rhMamKVnB21i1BaSPvBo9mG6qQVr7IpdTI?=
 =?us-ascii?Q?3H3TsML9k+HJCy2O7fhhxV7O6MGKrAHAZoGVt6AB36SyNb4qhXphcihSCi6f?=
 =?us-ascii?Q?4TUi7y2CuIxDbIgqox39YzxkWq9SUpAHRIz9q4QQ8dBu3RHU2vK2YDfW5TPU?=
 =?us-ascii?Q?G4Bjkm1UdSj/O9dldD6dkAdgFtGqukATPsr+b9e7HQtJZK3KPdm0QtyjSIuN?=
 =?us-ascii?Q?yZ5pi/dbjFtx5hblFklRCnoWukBWF4GpqTjd88HoIOFgm7qv1Y0wfm8uff5k?=
 =?us-ascii?Q?qmNQTFMtnquUbqOi7FX9jDMYOyENtcTD0P2f5HEJLHzSctB6I+GPTpk7kaZO?=
 =?us-ascii?Q?PbdwnxZWHxQOtU41ssniX4IKktC3F0XMUlZRokYF7EG6GA6sa86PwR/KcD5d?=
 =?us-ascii?Q?UNBwOb6dx0spqChx5eh2hzb1Lb1McnS6DSQwX6TYGa3XT6kJhaV3UNMnMw4n?=
 =?us-ascii?Q?81FNid0lNDXU2yyIj41KMn7EG/LV+Y2K1bh1bOd/7CFZDLqKWyRoIM7FtiqW?=
 =?us-ascii?Q?vfqq24L+V4SSHYPaETAI4J6FhVMeSfhm+V9WAfSBNHMA+Oz94As/meYS252Q?=
 =?us-ascii?Q?HlUwwYYgCmFfy1eSrISyn3mcPVtkXwUb8djKiA9XdcbJqywufkLXL+UzDEzY?=
 =?us-ascii?Q?Hdc40Kq4u4C9Ut9tt6BSEYu2i+VTqALqBYtnChFB5AXXU2ofWXJz0PRFAo5e?=
 =?us-ascii?Q?mZTbN3Pn8xRfUIJn71fAcrJ+8zFC1B5oZ9KA15Y0/A9011iEn/QByPFIKbzG?=
 =?us-ascii?Q?WGOEjoGGCJvmNWApb18FDuV4qEjEfZqjf3Ok7CYaJJpeiFpkpgw54+5a+DfL?=
 =?us-ascii?Q?7lk4uL4TbBL95X4z22IwBAKMed7RSB0R1riYMseFBDtUijadKQiPCICFlIjW?=
 =?us-ascii?Q?gkaXB6ZuxccZDqS+7VdxlLfzlPS98p+HdR1qxWjFTPrr2efiMNj/3X+NDCfk?=
 =?us-ascii?Q?OIzaTT1FDOnxd/AA0wyfex8EoZHewI2kpYHlymOIieBpPrrYhiwpaSx1iDpy?=
 =?us-ascii?Q?PqS7R4Fv/bYsMHOiPDqLlqkOG4xYzYrbYOWreSrOXZ87uTUFA80NJ6YsfU8o?=
 =?us-ascii?Q?cHdjokOIovShtuaF7hQoCznm3aAbAm+k?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?kAFHKcLC5U8F5kc1s9qitehB8y1TQI1JvP1zWmUDTzsq00Kdnsf4YvUlhViZ?=
 =?us-ascii?Q?D3iZAY6m4kVL2O5v9Nm0sKcE+ULSIqoKQZWTKxh8/Uifh+ZD1nqrDaW3uOoc?=
 =?us-ascii?Q?+eNM4hGO4X5Ix40MWXHYcqUfDX+jxEmSPolX7Y8wGIXF3WAw2pycM4nof3zf?=
 =?us-ascii?Q?BekvEN7RBY73Lj9yrBfSi78pj9HzZJEJ3ofnG4cj4in1m2AaZiWF7Qx6SfXs?=
 =?us-ascii?Q?g0+lsL6BgQptrjOnv7bhneZCyXmIIvHAFbGe3VUaofu1yjdbRi88oqvmk7x4?=
 =?us-ascii?Q?n37vNopw7FpY1FBS93n/DoIsru0TSv+5Tze0TWmruNodrvS9l2TMBSYd+l2V?=
 =?us-ascii?Q?51xkGzAehN1iX3FOYiFg+yi3pH8yLQoankSB64azLrCiuPVKBSs5ZpbQsg5Q?=
 =?us-ascii?Q?djeNxRtlcKqZ/sUb4KZ1iI5NdlsaBL/Az2xgJfU27gZy16piH3VinY81R8I/?=
 =?us-ascii?Q?/SQBCmoVW6hx0e+eYH0eaSRf7QLtb1MXIQzsOFP7/NGiAILPZ2d62JsZkoOj?=
 =?us-ascii?Q?XFQbqAy6Kj5Eg6pe1UWWgxd0/SpUXMNEzdwl2JbxwCXoG9haXDtVkcRQD0GZ?=
 =?us-ascii?Q?coX8DFPCAPS9rN/pdzWJgJ5Ju8ZtcMbUDSdtADFX65KPEF1i7TjqxBK/u8z2?=
 =?us-ascii?Q?E3csRAObTeKQeCaMKAsozzxMzGodvvWV+k3230LhAFmKls0OX1C7mAhI80LY?=
 =?us-ascii?Q?CvXQQbnyXoTm1Eptzblvb/iLNksJa2ZX/EOMhb6KcHyjX5S3QF5hQik8SSMI?=
 =?us-ascii?Q?AeDXQf7EArYNRGg0avS4XwrFUX41Hm1Qz78IEpvkdhdqv9pCh4EEQDu3wg7A?=
 =?us-ascii?Q?qvMvg/izyEMPZFeTE6kbj+Fb1vDdwXUR+124M4GgWiKISGkS7J6SSHyvCM+M?=
 =?us-ascii?Q?nL5EffFIx5R4KHHS6RhCc97jHoE8S83MHXRWpFqI1uhbVWtwxGKqe3uPHLtT?=
 =?us-ascii?Q?6zPyfw/aCqaojiGMBJi7xM/5rqTIqNACAXepGJrFDJFOMMFOVWuFRIOPjpL4?=
 =?us-ascii?Q?/QEqeQiEp+NjNxNybcJKxoJwhDxpJySNzKfS0HR8aa0LYw41VSAQscJ2ufu7?=
 =?us-ascii?Q?DjksJOTqb1WBAkraRx6QGhizgH4kpZ4MC5wkW6YsUKnG/eHgrUa32RRfVzuB?=
 =?us-ascii?Q?zM4jfxL/PdY83zW8B8q6qFZzgSZPIoEm96yqLEjN0v+hcHRL9qIS2P1s1sae?=
 =?us-ascii?Q?BxuW/+FXoOnCGRrBbMpwbFe0ZHCoTiqmg+BnPIvW4sqe/a6IfrU1SO30Ir9D?=
 =?us-ascii?Q?fHoysJMMyWQAuG/STC8k8/zCO8hKTCutNWqH6HQ0T5OXZ21gmSH8lYevm76r?=
 =?us-ascii?Q?ZZfgUuHHJgaVX9sJ6n8yAkQKPpZMhwxzSI+nVsCLVZHsDs5tpwGaIsIXXMRs?=
 =?us-ascii?Q?RdCuU0DnSQikyGn1BJc60xMNLRcf0Sns9ompG7xhRye3nVns47jz4Ml6oTvK?=
 =?us-ascii?Q?VNwzQnBbT9vgk3WEpxDE85CUqXq97pHuSm4YHAmzf2CuRTR50KwpD1YAuETP?=
 =?us-ascii?Q?5bcBdAjSsFKO4h0dt8d2XcSSFZhKp/RA7iavWkOd+Mzl8+i4COgMwQNrhi2j?=
 =?us-ascii?Q?5mMx8u9ui2D/ZdYKfVA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53676aff-b450-480b-1846-08de3d96aa91
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:04:05.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/j8beRSZnvr7ITg7/X3g0uYdTHaiVKAReO8ueGOT47PqeJ2CNDlXoXXRZH7lEoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519

On Fri, Nov 28, 2025 at 06:21:46PM -0800, Randy Dunlap wrote:
> Fix all (30+) kernel-doc warnings in rtrs.h and rtrs-pri.h.
> The changes are:
> 
> - add ending ':' to enum member names
> - change enum description separators from '-' to ':'
> - add "struct" keyword to kernel-doc for structs where missing
> - fix enum names in enum rtrs_clt_con_type
> - add a '-' separator and drop the "()" in enum rtrs_clt_con_type
> - convert struct rtrs_addr to kernel-doc format
> - add missing struct member descriptions for struct rtrs_attrs
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |   32 +++++++++++++++--------
>  drivers/infiniband/ulp/rtrs/rtrs.h     |   24 ++++++++++-------
>  2 files changed, 36 insertions(+), 20 deletions(-)

Applied to for-rc thanks

Jason

