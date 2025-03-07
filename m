Return-Path: <linux-rdma+bounces-8488-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEBBA57645
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 00:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2AC7A6E5C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB511212D6B;
	Fri,  7 Mar 2025 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lCmoCSLW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061B212D7D;
	Fri,  7 Mar 2025 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390697; cv=fail; b=ICJ4wAgrdKs6AHP4+UqtyUE/GgEhKSOW5haniUoocbBN7kgYsg24zyTXptl8xqqCnxUW5UwvI5R5xy3Clt6QH3GGVBrSXoNzS0s9Y5GbPuNrKukziklK+bb2QPfMeTkx3Ik+Vv4DdkOWBXsTPynA163IJ/DYEUfA/Y8jwoFvpSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390697; c=relaxed/simple;
	bh=cfhnl82LuBb7sdZpVfJb5W8Cu6AGS4mLaV02m1n9jGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sKwg1PYKZIOGjP3U2XQV9121z5paNV+NsMVSqVD8uE6pdvh8CgZIlHvjp8IrLzNL9H6pLpUQur2Sr7kYzX39qHwIUCqI6oT0FmaOiTBXQ0U/FNYvHmGk3mnOjYHGmX5nodZYeiPB8ansObFS+2O/sHT1ZNLscUkij8ejptuLU1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lCmoCSLW; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwT8LySuOO1a3YsM2ruvX9CYfKgeeV6Pa0DNW4D0evSPPduBdMjAZYNRmur9uyrma+No7FBn9rBVoM5XFBbxYBc7yN+j2L8+yM5dPk7CpqAuHALUrurGWYPqboX8Sz0iUDMacdQ9xt9bBG4QCgG/zRYYhjDuyAoZb/w9KLyLH5to5zuXEUPlnl2pPzHl8Wao4trBCo1bp0BrPtrHPSN8eKkaY8sldVI01kEDl2YcGjuyjauuFcs9SaAuaHPBy+vexnHhiwUDzprm3OZdsIDxXlC4bzrYadF5X5mmN7xJc4wCvIWrCacaDyV1+3CcTn6MGH/pySeroy4KVpUALvE3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEvO9puPQ3FEDvoBx52IiT0NF3267VOO02kkhu06I94=;
 b=R4aOMBuKAgbqG++HXMBifcO+2KRh4+4zonLCL0xgFjDB+V5ipTGU0G0k7pvryMsI28sZ4og511nMBg3ggr7O3//da92igmGPGgKXPHpXdFNzk+uWKvIRCPLF+fLXa7r6MzWnC9RPflp/M3GgsIz3WzkWj12kJJw1uLSWuMrwmRM0sCYm/+3BFEZhU09UmS0+m6FVVGBWEB4IXmchx1h8l1Scjmrp0gxivs55QVHVK3vuXp6E1mfQZdDFpMaVsMVtZJpmUYOdjMlX2TX7kesopXcSenhkcG7/QNBbVBeRg64DClMM759pzHmBM34Cx5fdS49qwpGo0aDrq0+G5RvlaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEvO9puPQ3FEDvoBx52IiT0NF3267VOO02kkhu06I94=;
 b=lCmoCSLWGCGhkQFvymeNL7aNAJarlZfphjjf5ftui87Hgwh0hgfHheDDdyZHcLEsdjB3C1C6htT6/F3noT3+FhxExc8zz2mImGurIpDaNKyVQJprTCvWQ2eqOVIKfkzp3lFDXUsyNknt1m3ko9ERexcdd7CrJwLgpeCezY9J/LoMVgb0N+PlfOxsp4OHbilFkDI4MGiEti64jCM1swOBju1ZmMIkmK1Xng1W/ktPa1GfGFZYo7XqXGLzqJVazBHzmRs3PZDL+o7NXHjr9HMvBi6njc3J33oezIsoNxa2cLD62HS1E2DKkvENJM4rduzuL4mbGb9jDAX//JSBlEFCbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 23:38:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 23:38:12 +0000
Date: Fri, 7 Mar 2025 19:38:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
	dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
	dave.jiang@intel.com, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH v3 5/6] pds_fwctl: add rpc and query support
Message-ID: <20250307233811.GZ354511@nvidia.com>
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-6-shannon.nelson@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307185329.35034-6-shannon.nelson@amd.com>
X-ClientProxiedBy: MN2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:208:236::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: cfca3913-0978-4a28-1c63-08dd5dd11ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/aPUVsWN5FlA9Fi8UR8WpZD7Lk8oxfAH6QqafXeF8QtKvPz74dffhgX+apTV?=
 =?us-ascii?Q?Sni0gZeyyoNuYalNN6Mg5vvJkBNTjHSYvpo5ePwCbGwj1gKhbWreU3HiNrDc?=
 =?us-ascii?Q?gd9nssC3jREWyI9LtzhX3viU0jsn/DZZg+W4x/LApoA1QYW7N4HUei/H21ZP?=
 =?us-ascii?Q?DBAgDiMo9+7csVEtgSLQjO/2eT7OKDOZo48Zq0Ln452Stb4M++fcWDUDo8Xn?=
 =?us-ascii?Q?Zm0IpluADepJyLG/dv1lEjl4dzJBE3vrYtOPEBBDlAgfoW8RnF9dyry8Nyew?=
 =?us-ascii?Q?B6objTFPqGyNNHxY9aRlYK/A6lsyXM+UhbSqRTDjJjvpPECHNORXM4x2dXag?=
 =?us-ascii?Q?W4zmeeEqFsjrc3Rr/d9Msetk1rJ7WDaQiQ1hmhFbJiEWTDkpgBpsTlQoSdbc?=
 =?us-ascii?Q?2zD6Ota/nG5yl5G4L8n0TGoOHjusUa3J8K8JAGUnHzVwWnmtL5NC9yFNnuGZ?=
 =?us-ascii?Q?vaEpiMFdVMTibfAo2zcVvkYURZSXAWt9XJD+Ge+OkJN1wZuxzBqo1AZwV4++?=
 =?us-ascii?Q?cC+TpoYdlJB8LWz+tjPNNEs6xAAAqOpvi1rK4sv3UuKoun6MyypQo+xIUTHa?=
 =?us-ascii?Q?hg/NXaUZL+AHpv+B+YrB6Ckm8hdBOSNAr28VkTdjvDy+wySXpIcRAEIQeU+L?=
 =?us-ascii?Q?Tz4v8v+Ebjn5ceKzNedR5/p3uuhSQB1WqEvRTu9akaltActnBR4auX7sly4v?=
 =?us-ascii?Q?4yo6ItcV5eozCxMTDJVBLTvt72sR9daHnXtbkq2+8qqd/x1vZQDimudkREIW?=
 =?us-ascii?Q?qgxyLTSZRXJpaIf88+oyLALFbalt0T5z+IAz6kgm4xuGLzHSA0E0G7d5ctBR?=
 =?us-ascii?Q?vMZE8spztUHuXhmnHzKDL60DKSxDtYYWt7HGBHLT5nRluXz3bJmf9t61Eijp?=
 =?us-ascii?Q?t8kwmG7e3k5e87mLKLBO9W01YLkOe8V2u9E7hkVvZu+iUMUvdsTnq5tE935i?=
 =?us-ascii?Q?g1K6net689uPYHlTni3+UTkNwujxXCZs90dhXcmPO0pMRGrjIHEiDvXcAygK?=
 =?us-ascii?Q?BK8KpSB4h0ZMfqUHEO8q+bqqMD2txEBKFln2gTV5StHxGyaf1g4+ruzv2QvW?=
 =?us-ascii?Q?qUpDypC4rXJ5K83xVecKAJ/CJ2RFx6c2+j7kXYcK1mCSlg61M3S6azW/ST40?=
 =?us-ascii?Q?8jJFKQCdIr3CrJQcbSqeoP64t3Mx3iIlGiQY4scHfICxonqTXcZdQAZKWuq9?=
 =?us-ascii?Q?KXzJgFoeUbv/V/sNZtCOO/VU4Gwt0SkMWUPwb5LT5aqRkBgN/uAdVoSWSJ0g?=
 =?us-ascii?Q?llx6NeK4fgh2DlXif1E6/T9BBlqHU3+b7yanGRBBAkI7V+/ZXlqu/gu0W/bi?=
 =?us-ascii?Q?2cmX0Jn+C4sZVKOelgiaVZY+klOojG+5M7HVY4vPV5H8YQDgxLHeku/tisp/?=
 =?us-ascii?Q?iGtWxSGu9oVVdYdmMesVb2yz+Sfp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbSUqhDp+cyRAYOnkHUPmbhQQRjnQsmcUFkHBF4JBXs3yn8QbOUaSD+O9oEf?=
 =?us-ascii?Q?SYkHWKdKRRd5TtRdm7P0xmbf932hohqj6YIh88utIwgT2n3lgGOV4uG5FZbZ?=
 =?us-ascii?Q?yMZDYqHur+5oQoZMN7/evnbWO31BkN/3TOsV6W7SYAST5sEw1STCOJAhRNou?=
 =?us-ascii?Q?PH7sDDHOox9RCjscOJp4qEY6Kga4TfKNfmyUQi8mCowTQZDkE0AqAxanZo7k?=
 =?us-ascii?Q?QIOglUAA0xN0AaZ50mYrZ04jd3Y7cbyIjRANMrRJiFqY2G5+QkJHAuWFkzxG?=
 =?us-ascii?Q?VbsZbMRn+qEbO2iq/jTG9h37JOXK0DuQCvE/s4mc1iX2UkzsYSmdM20FCxPb?=
 =?us-ascii?Q?V59vFs66yAG6ft0S+zpY4i3uEhhZgv0r7Zy/UFREUSm1DvQcUT8p39x2nvBa?=
 =?us-ascii?Q?IsTdz/vcsH9+f+0b4WRQuKA554dwFkyxDjAd5LS5KCYDaI3pWkE+zCSqlr/6?=
 =?us-ascii?Q?u7uUmAdppuvOdKGuBRFttqUDm9iHybNZHSw0XsjfMt3a2zjHLJM2mIWDuCiU?=
 =?us-ascii?Q?H4bWV/URl0qXrz3iYK6OKyuH4dE1g0ZKnuJvHFxSNE/p8xy6lp8Id6VqTjKD?=
 =?us-ascii?Q?/U6NYoeCB891zeMoYqQTIpAgELVt5wZHbtDVqZ10nBFBXeo4FcRm+Bigo6Qe?=
 =?us-ascii?Q?vOsXim3haeKTCdvkIj36EEYFf39CSC6qStpNhOYUP114r13UuhqHgk9wE/Kz?=
 =?us-ascii?Q?bQZZSAdR1t+4Pv52Lfoa9JYxq0uvRIkv9iOcHtVMt1tW+8nlRVC3th6Aax2e?=
 =?us-ascii?Q?zSXkONnTRRiHUZrME0xZwjXzc3f1WqfcNuyZ6EepMDPpW8gpJdokoMrZbah5?=
 =?us-ascii?Q?jF2alutb+ZebS4fZr8yJ7Qqkp6fLy3aFCE2ohVEET0zjj/aNKqXYPZ1CtUYu?=
 =?us-ascii?Q?lKa5hNZ8SM+8MFX+TmGfrKVdq/K1b5XHQn4i4KV5IWEg0dN19JrS1CUU8X65?=
 =?us-ascii?Q?8YA5pUDMCGK//hrnucBmqVX0FrDy//edyHyoiyE8xNaZhf0YISD0sqEN+odt?=
 =?us-ascii?Q?PmJr+IY+S7kkK10W9ZAePiczyiU1oAzIDw6OBLRU06IxD54kmVh2sFq3wVjD?=
 =?us-ascii?Q?1uUg3J0QnYrr2zMKYV9T0yBILoSpJbMWJDL2ByBZ+hmyddvRJ5aWNk0nwrN6?=
 =?us-ascii?Q?IcLCrcHYt6A+oEjxIpruBwW59Vd7hcV0gMjoFuXXRcapUOr/QU8fv/gWWgnQ?=
 =?us-ascii?Q?gKWBU4TKFxQEWxtODIP/fr4RYhh92FvTyhb/w0TI4wZR5qf1AWdLisVERBsV?=
 =?us-ascii?Q?tABjNxoi2H4+Bcsx4nmGrqIVyRgFQvFmXAFyd+FcZxYCiClUYbM/sg3xrGTz?=
 =?us-ascii?Q?A7v/VEMQ2MSsbC4ldBMsTbOZgqka60O6sGHK7AN+xET12m4KGt+Xaw+QXG8I?=
 =?us-ascii?Q?WypqmUynGxPX7wVBa8mpkPZ/Ho14Ok4S2tKeKTN9himoSI++KybaaSFyBQZj?=
 =?us-ascii?Q?MQejYMbsYxss67k2B33uQu2Ui4v4aHGZxvk18d6tsqD1mgDMEoPaFZWzFdiv?=
 =?us-ascii?Q?owk8kVv/uDDpt7ZFiLY8l+aJQ7nUKcKGV/9Pib1wlwScbVqJkG7w36eAP+6u?=
 =?us-ascii?Q?oJJ5T316eqrDq9laJPJ8YrUBK752BxfaU/2ZA9rX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfca3913-0978-4a28-1c63-08dd5dd11ff0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 23:38:12.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UC+qeQVGIZWOPZwJeRao3qX3RDCdFt3GlNDbdfY9u8mtGw1IajJ7wJpb8hiiO4kl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315

On Fri, Mar 07, 2025 at 10:53:28AM -0800, Shannon Nelson wrote:

> +#define PDS_FWCTL_RPC_OPCODE_GET_CMD(op)  FIELD_GET(PDS_FWCTL_RPC_OPCODE_CMD_MASK, op)
> +#define PDS_FWCTL_RPC_OPCODE_GET_VER(op)  FIELD_GET(PDS_FWCTL_RPC_OPCODE_VER_MASK, op)

../drivers/fwctl/pds/main.c:302:7: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  302 |                 if (PDS_FWCTL_RPC_OPCODE_CMP(rpc->in.op, op_entry[i].id)) {

Add:

#include <linux/bitfield.h>

Jason

