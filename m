Return-Path: <linux-rdma+bounces-8781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC00A67278
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 12:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CE217DF80
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4B209F30;
	Tue, 18 Mar 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2q/3QnS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE232080E8;
	Tue, 18 Mar 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296858; cv=fail; b=d0hAyKZjH9gMVagCKJsHeQaK2FqtnEK4THA45CiAgQWQ9MrP2tFYe6zAEYK0DqL1K4zDeQtplNyLlCSF+PQRucWXR0wifVcDdGsd4M24zHV5XYCemZ8o6c9JCNDRpltCCVklMhpmQZ0Hj8edp29pjYeWfXH9njCU5MlaIntBQk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296858; c=relaxed/simple;
	bh=FxPP+u0L9MTopCtIDOv0L1k5pjPmUs0XMayWMaLkrn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dGjHuKGSVwGqLOhYXLyVaTYCAVBMMNDw2HpyxVFXNNleKe+bEuWTTmwkH858QMJA+fZusCQnSQ5Sz2qwhZtweOz67lqGl30WzDHx5quOoobCSXSjqO1bjjh5z5Ds0bdcpBcrRLZYxynI1NiJnx8twBx4i4BBVKSglU449p49Asw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G2q/3QnS; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj4Cl3K0P4TABYPunic2ebGR4KRlOUT7XKJIgXGPWqDEponPABM2kKOpOj2YSLMpHfE+GA94i5RmkNFv7cPw5ISqQKY81q9TFuydlwLICtstfIgEQsBONIDyWZRlpYa+UMfA4Dn5oNMulSE5tXFHy6cDzdJdwaPHZ/FenNEGD+X1hzQFJFPAVroEwvwqdWOXQjllcuquNSlAshTqX6a7vrfsgeDmEAfbs/ocHTMEHgbqTWGYzAUEY7MKEIgzy/VdguXZI3IvHZI9BtyvWBJh1XQrKzmBthiwaal1Z6VNf8DiQf2dqmqBr9Vn7OIePSAEloasBvtWF10feOkmAWoYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxPP+u0L9MTopCtIDOv0L1k5pjPmUs0XMayWMaLkrn4=;
 b=JRCKggJZSTHd397G0gAOwL2Ng1e1V1tuWBTu9FKt8ZW35MCvX0U7KcDb2OED04ur8In6conPKYlI9OseePxVTTlLVMjlk5Lt0JxPCIPB5Fn7HqyjRVGT2QhQRHTdUV3J5WNQ+kn0602d9c3P+jVdV0OP7gLvkJ0TOGyV/YiOuT9W6oLdLIw+CYb13ZlPBXlNVQZr/NXWlVHzSNyVYfqvF8RDBd8mwDyMViohqr0xD/kieDDSd69Mqyxi10KHtRjJ0rxvHoAaRjGLcJkM0wYBW52gtP8v2ehTqEOAVw8ycgVXnarLWwiVebqiOfnBYQ+Wl/IXpp7U3Tj70Dd18N4bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxPP+u0L9MTopCtIDOv0L1k5pjPmUs0XMayWMaLkrn4=;
 b=G2q/3QnSQZfbHfu4hSshkqC+ARbrcxwSNII7YbHuZNVkzBth8atZ9cTfUSPY2IsAAOh7lXFh2YQzMtpEBFJD6zVABcbHQOVEOF6C75wIJbOf3MBjv1MJuQJVatbS8/Ea6jygLgD4hM1O5Lytl64s18OM/aDydgJTAjGUoQPmoVD5zFzzd98wLPpf/9a62In0b6upyQ8ImR1JARtok/Yuv3C4SIcBAtl6OAuDnEa68Xwy55LMR/eP2EINcpefYdJDBqKOJqShcjhfvHg1kR+np4hNuVD0A/p9RbBCA9ht7/zzwh4lQsB9w4rvQ5JYgoAootC04qLwsA7nRARYwfrihg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PPFB6B4D32F9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:20:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 11:20:51 +0000
Date: Tue, 18 Mar 2025 08:20:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"serge@hallyn.com" <serge@hallyn.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250318112049.GC9311@nvidia.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:208:23e::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PPFB6B4D32F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 3097ef5f-9215-4655-5d20-08dd660ef09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZLqrIySxbCR62SqVaeRacoZk/EeeIjVHM3oLLXOq9J9ZV1Ecn1QFl+wW0YD2?=
 =?us-ascii?Q?gGh6C/ynIQqnR5vuO//8OuOERVCT6Kr7xqeFExSRUKYcYOS019E+T8v4A7OF?=
 =?us-ascii?Q?rVzEfjvDMKP0l6SG2pLyTPsxk8OWecSRquWgretDyRWAwouyI6OAv4zyFkgb?=
 =?us-ascii?Q?26opezRnCCjND29+btIoDWVktdOroA1o1rS0YY3g1/Oa/5J25zazjG46nEZS?=
 =?us-ascii?Q?RJ3eTuSlsRMLHSk6/meXYZnTTqnvuKzrkcCYTHNSBWfBaeCAmLOdAbbc/dDG?=
 =?us-ascii?Q?ZUPSIbYD7CEMp7vDZECM20tSQh4ZH6TLGS4ncdJHUXDLWN8JupZi+MOnxOvY?=
 =?us-ascii?Q?b4mDwfWlsNi0uNKEkRje0yWoqdwWTAj0Oqeo2rIFhJzFgIVodxbgCmPg+ShH?=
 =?us-ascii?Q?RO/vGr4iQk3SafA5Xz2Dhl1SaxBW7VKJqEnhv3jrfRJ3U8nxP+SJ2GRQxFPr?=
 =?us-ascii?Q?t4I52Q8sIytu/keFUNTEAOchrxuRKkvwu9nq6qJs3SyhB8hX/hGZKIx5IhgB?=
 =?us-ascii?Q?f/Z8S1OgicgtxRqcAD4+opr1Ku46Nd+cQttACuzG6EgBYNE9IC9VEp0EgXeB?=
 =?us-ascii?Q?jI1T+O4hAV1yxlYTWtwpR1g9pHcsThlwxV3PAhyLEKbaAXV7msjEcv3isgk2?=
 =?us-ascii?Q?1nzeeLwgpC2LYb3P9nkJJrNlgwpmoW1XQP5vExOm7DeLuDDzBoKOpfAx6cXb?=
 =?us-ascii?Q?a0PvBP5RkD3fKar/H3lB3GPtADv6YYVMrFpjCtI++FejH2odnjH6I3RcDJDj?=
 =?us-ascii?Q?vpicWrjnixmMAFKgHXIs9eOphAaSqruwM2Tq2PVtug1R5HZvP4bO4QhkS89R?=
 =?us-ascii?Q?JDRBG469+OTdfToAs1bYJdXwv7+K1NevJBthE8/IEgfGvFnHIjax4gHlaYhQ?=
 =?us-ascii?Q?ldUt3F9XeOMmNczN/vhbQZ2nsgcd9RVn0PfCLPc/yVmXvDK7zCDYm858BP63?=
 =?us-ascii?Q?XsAtd/vaCJ/qPcEJJZl3T7fsWoaiivmn7eHznsDZhX8ydu9JxOUgHNyzlHv7?=
 =?us-ascii?Q?g9G5hvwny0PP2/OmciKP8vgG6AolxxGAr8sBP6/x5mjrnGkQr0KlchWlKUrN?=
 =?us-ascii?Q?07DESHalY73kYyAUwtHJUoYKF1n7VFAR91GlURbr5rAx8agAQCApB4BOYbvP?=
 =?us-ascii?Q?FFAtRaMd82LAbV+bUowiOcEvbv190f60/Pd+DZ+FzzyKbM3st/i2cJH/Bvze?=
 =?us-ascii?Q?kCGiAYHcsbYbb7qCfk8WQRJxD1hp0QuI+n32l6RSRyz+IGmSgQdq2wHtUNbB?=
 =?us-ascii?Q?kpGOhEuRytbDt7CIB6OvcSPbyW5nwwvS3GNKNFLwmcoVN3gqFl8fa9pbMHkk?=
 =?us-ascii?Q?d50kUqKTOonXLBMyOv59Gl08ovd9eoaCQS/9HXLozzr3mPbr/q24ooeROUQY?=
 =?us-ascii?Q?DqlaLXRgliavieITLJKVEMzigbYY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h1y1sLfsoKRCdQtgseWkIvX8+NKGSxrnCsETyg2ySsDWbYueItExHXKIpVrY?=
 =?us-ascii?Q?g2qPLI/Jn4/FZ3K+3C0PI1MSVExE8G9ZtdjmFu5D0mYHi1v4i51lv48tQMCg?=
 =?us-ascii?Q?JrWzBKnl2oAQeX4MW840u4nQ7G7R6+uDcIdBR4w/DXhWdwQhKkic5sURIpfb?=
 =?us-ascii?Q?cJfBN44xwcNvKkVQJMCOQ8aiaes14O4bCCht+OzYuwiCSzgV77S2fayAEwNY?=
 =?us-ascii?Q?+rC6tSDFfBaJPzHLEs1ZV0Mf4AibCeYagmzcN9Z033UpppWPRknnUU59Mp2G?=
 =?us-ascii?Q?qnwR93YAoVXhWKzxLG0bT7mIW/VdQQK/lfxLZpFQ/qLLqlwDvgNhAJllovVE?=
 =?us-ascii?Q?qwh/qEC309exNwcgXRh2hcV3CEGjbbn1br6/jJBlD/ok81Q6AkiMqolQtQDD?=
 =?us-ascii?Q?uqRK/R6ztyYi64DSuSM0hL8EkjOguDkW4UELl/EKOhDpZgoiDA1FqH+34n8y?=
 =?us-ascii?Q?smDvZ8AP9dkcKVOSTzC+8cbD8goeNRx7fd+fLIHRmm8aXL1YHuWk6OgF834w?=
 =?us-ascii?Q?wWKvbh0UvUAIwlSqJJXh0+6ZjeSeytN4UhwwP06W7BOtS2IO/qfIZTyqqtE0?=
 =?us-ascii?Q?r11IXJKLPkDI+pT6MgsEAKZu9DR7DG9qa+ADEYOPwM1XyCN4Mp1dsAyeAOEH?=
 =?us-ascii?Q?R9pvEeuXT5aBDO1BQNADe/o5c8A3kSm3GiFK+oCQG2m7thNNQuevSwekqnh0?=
 =?us-ascii?Q?UOtrlrbiL2NgbBHQZfX70qjd/R6kyCYcP+kV6xLjL3W1w4wxqzF1IasRgsr+?=
 =?us-ascii?Q?xQD9oG1zugxUCQFvysMK67reT9gSqseGQtMz7iXgzh221Xr5jTyKuTiYZqDX?=
 =?us-ascii?Q?0TGXOf3e8SqV0Q2hMEpop35hmw2sRJHLdg7QQ7G3DXZwsyNbLBokjEPrpCpf?=
 =?us-ascii?Q?/prPQ0+UIPUPmWNvA2aBnAkhwtyf3hiHwRpgcCywyzO2luV+rJaCWWz0rm7p?=
 =?us-ascii?Q?365VYSoD7IY+rWKjhbgNi6V6z+3YrgnGeWBESOKdxrtWGCK97WGNe7/Eas6t?=
 =?us-ascii?Q?edcC2FglNHDqOi4VzUKN6pz80Bz4nKRa7QaqgM/RyQwzazp31voUr5MEufPW?=
 =?us-ascii?Q?Zh0ZKGOa6jnj+fOLyYVvlpFq9tXtpJKUOZ5dfZGZ7qQBAqX9p4A9DIPoNjiA?=
 =?us-ascii?Q?h7Aks2hPdgkUdheHtug0Uh14r0ujU8qOfZiyRgA2fCjOBJZSUTiyEoFyPWH5?=
 =?us-ascii?Q?4nRhh4IPIOE3FMl65Jk09aiqZYxoBGM9VTE7U8zMs/JKiNiWMXgyiOyENMsZ?=
 =?us-ascii?Q?mJ0joGCbjWhaE9ikiKGQoF3pQY7OKg9GiVioPyzFc5QR0s+5UimBQpsegpVE?=
 =?us-ascii?Q?hFum5Disi0ZMLDnJNJKDkUssjdmWM+12s7LIW410rCLunJAkHWScJsDtcS4Z?=
 =?us-ascii?Q?Vdz+C8Nq68m+uWxwj/MIsXxo6DS4J/kLovvYveCplVJLMIQpPdIjvr8pWydy?=
 =?us-ascii?Q?7wCVJF2j7GlvOGe4/GuZnCyUzQVPjt69XqpBSbK7DyOGGhHgyhLECoaKP2CK?=
 =?us-ascii?Q?syEd5pnYl8PkBgI4vxK8saMyic4Q8H0/qmO9+pefLLAiIcaEzuLtlH5OkQcw?=
 =?us-ascii?Q?+MGjT41H6HImNJw6vgY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3097ef5f-9215-4655-5d20-08dd660ef09b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 11:20:51.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9AHVMRmgd0LjJNxSnMlhS2pCilZEvPSderqAUN50gETrGfvap5nnN8MvBLFK1nR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB6B4D32F9

On Tue, Mar 18, 2025 at 03:43:07AM +0000, Parav Pandit wrote:

> > I would say no, that is not our model in RDMA. The process that opens the file
> > is irrelevant. We only check the current system call context for capability,
> > much like any other systemcall.
> >
> Eric explained the motivation [1] and [2] for this fix is:
> A lesser privilege process A opens the fd (currently caps are not
> checked), passes the fd to a higher privilege process B.

> And somehow let process B pass the needed capabilities check for
> resource creation, after which process A continue to use the
> resource without capability.

Yes, I'd say that is fine within our model, and may even be desirable
in some cases.

We don't use a file descriptor linked security model, it is always
secured based on the individual ioctl system call. The file descriptor
is just a way to route the system calls.

The "setuid cat" risk is interesting, but we are supposed to be
preventing that by using ioctl, no 'cat' program is going to randomly
execute ioctls on stdout.

You would not say that if process B creates a CAP_NET_RAW socket FD
and passes it to process A without CAP_NET_RAW then A should not be
able to use the FD.

The same principle holds here too, the object handles scoped inside
the FD should have the same kind of security properties as a normal FD
would.

Jason

