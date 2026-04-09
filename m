Return-Path: <linux-rdma+bounces-19172-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EhDJ0e412l0SAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19172-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:31:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F773CC0C7
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6A9730166D7
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA63CD8A4;
	Thu,  9 Apr 2026 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k2tu0yvp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1CE3AD505;
	Thu,  9 Apr 2026 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744802; cv=fail; b=RxfPSHUb9uJUSyrBChTjYGaneLzzKBkcogK4pni6vE/nfWRfFOBl8IkAkunFJfqYrAXY8wGG/117Jdpiq18u2HGl7qq6t/ooMoJaUL0DUiMSpBHGvj2uTuJiSpsVUOQwyiqokhWeg7i2wx88XPkscydy4omxHUmLx/4u0h1AqEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744802; c=relaxed/simple;
	bh=rh2GNDCh/OWFwxCBkrF8SerPy7UZgfZ6eQaAxJ42Qk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ewQBCP1DggbOAjL93xNM5zwdl6xzV8pDM8+S/ewIu28qM1+d15UORY4JRzxpzSrXEExNX+mqkxYhRU4bI5BrI3/APd2Wp3hmtuL2edzOBc33U7f7SXpYIfVmL5efudZL1oDgVtOeeuPHbw/469iQOgG4ehIP7TwK88gLmOAWvvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k2tu0yvp; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHNFIJkb6jRGcEX9gPEKl+0lpVhjOxDy0/j4mK3j8rkjhykGfsVmLvJoQSmCuaSS8CFBnNuZnev3LLqJB6RPo2XOYROXPBIZMhL5DvSZVX61Smf/LtiLUwOcnKUoziXzUmY+ngkTUNc3wygiZ0FfTkRbh9Lh95Rhpo0nt8qpfA29y5UhVqW8QkavgkBZiBCLLHbCCXbz8eeV2PG1UkbAC0JwWlBo5X2edY8lx2jd8SoTjWPL2ulYoolvMgSxdVaS5Lv/uaOqI2swQtCtoEc/pU9I0Pqxe+uxcgxZuqV9l9wdXroXA4By/S32pSWWl+Uzmq+89SGvCxHXCZ2djHQ6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwnuA1RxEg1DNNYNSIwpiYInceZVndrvS8pf5UGpcpM=;
 b=DL2DkAlEbarJpsfRxlIJ/Ndv/RVK/Q6QKNh8mDIy8v8efkOhhupjmIcHSkHbe8wp+fWEb9UObLP4xVd96tA3zLmURo9+Cx/gPPctgLlQkRuq3qqti8zU6rz8vVFZXAhuCPu5xrtitvapyifS16ksPIPx/nbwU1p9h/kwuZL8X3MRhyfCo7Mcl+/GJTzsSbX3lcOESTboef8B6TjoF+Q/SluVYr3/awJuUPX2EvfzDG0xlDu2uZXw2zBXZ3Iup/RiIvzhPxNEV+X9FNTH/0bMEIFzJcXpGpeZm+BVrNy3zXprUI69lQx2K5RI++fFvW/6OofadnEWyQCqFBqSxV5AdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwnuA1RxEg1DNNYNSIwpiYInceZVndrvS8pf5UGpcpM=;
 b=k2tu0yvp8N128GkQBF6qNVwoEcQXOJGwKEQWSmCfqe0kKN1sUF4qbMND7ytr2CL9CT+A1N1/pthd5aP8tJ+4y90/CSyd/Gww4XkFpvyCx7ssLshP9l1Jrh2IsuMZpDX91Iyqxq94NYBMNNsHiS5xk5+huE0bVm07WRjDdXyNu4FMaw2Gaq3A3SslIV93rl9RzpnsKzFy+nePg8dDH2XPYkBjYs4tXl8mSg09dAQr40d5XvR2Bswc5Uv0GTarbh0Ki4PWt/7zGcFMhsDwQ7lLk7CRC2BxuN51jRJu4QSqf0a4BVHNiMd4UbsGxP1FjyYPoAzmBHHaoH2PL87fgiXvFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 14:26:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:26:33 +0000
Date: Thu, 9 Apr 2026 11:26:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 1/1] RDMA/mana_ib: memory windows
Message-ID: <20260409142632.GA1927464@nvidia.com>
References: <20260331090851.2276205-1-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331090851.2276205-1-kotaranov@linux.microsoft.com>
X-ClientProxiedBy: BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b0d097-f9c0-4a96-465b-08de96440003
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HuJ8CvvrgrNAI1HQgA12Kt0UcfvvP6RffiBoY+NFlcvLHRcprGOmtECjVEVm+1NMgofCwW4YlMrD0ymmPqyuKArpTxZqdEMaT9VolWXZYDy+pBw5pTJdxM40DtML4f9Q65oUJxCwWGSvqW3EjqNrNNJi+Sg/uE2L4/L/UZ7WWIbqnghmbU457jx1etBph6Ep2bSnpK2Y1a/2AL55e1SNomXr4mnFoGn8bGR70h50zKJZuZwW6irYJvFsR2TRaFf1Q0uJxiGM9mEffCaqER0vvAVmJmzLaqmuVkhkP5jXcgDn123tlujZkG4JS++aXI2/SMwmSQooyxl9v+RNFnC3wmIUa9+UWgubOgcECMffySs6c6laHF9ImgjbkgjPtGWc9//Kdz187tP9gIyuP5IHOV8AF3OsqY5c4lZ2fES0SX9mK85irxMauvkEdEgR07KuFlFcHOfzcmNPSn9Kl/9j1HKyK7uXRbu6puwzrLCrdF3/5HR0W2VHuAuhXAdw32vWczmSbVV7bIXvXwS3bppUPyEYV8yWBiMGJU/gLz9VI5vYDK74gQBo2QwUJgA7D6rIb9FRVwKTpc3jqFqkmuiX6L8GL6T3VlUTVMIhlljIby8RNOo/u24NA4cW8m+VUTbQuvwo3x41sDEZtCNyB2FKKn204aF6ycCcE0xDJH+M1LvMU/KyQTn4Q5r0knLVkL1dA7QP75hrweADgQ0lPw1gJbsLKlFlVBtM85IgZZ1Xgek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?elCu3if5qWRyMlx6c3sPofxD+gy4TKsh405hKs5M/qM2qP/bgHmsfaedH1PP?=
 =?us-ascii?Q?20KnwXfslJULMcKa7wCKpd+EgRadAj3AxpCKksmWKHXBaigii5ry7HnAHsCU?=
 =?us-ascii?Q?N8U5xmpQtgDlM0s5gghC1iEFU99YI43guPTIxfwoVNE6YMkymDBGckKVhEV8?=
 =?us-ascii?Q?B6610l/oGB7iZs1tBNiWVyycUaV8LveTP1UyPsHSANuDQW61kZYhwc15GVon?=
 =?us-ascii?Q?ogb/8ghQGENl01+3oYIe8IeaN2RQ6bYmO9M/z4zT8k91Tt5LB3PGYew5OFR3?=
 =?us-ascii?Q?syHgLZoN8PGJHOVm6J8DCWzO2Mhr7ryC/Ug+Lv7CuXZNqbt25MLjVWNEsyag?=
 =?us-ascii?Q?yiUP8eXgyB4WTJqBCKPYY6YHvzctXG+UJKFVXEv99LZwdgyhFU7aMbQvFgPo?=
 =?us-ascii?Q?PdCxeqejlCL0GYl9NbTiWPVSvg/I0/4ST56ZD5xh90HxbmBs3NThrWUq5HBR?=
 =?us-ascii?Q?Tb4h3fqJg8YEK7xMwcbL+kNhUNStKiP7KU8hIWVJSM35wO4/i8uxpl5187Wz?=
 =?us-ascii?Q?7MqJouC5Rj+7QS8+UYc0Ns/GkhwZx8ProABxzTFWHzw7RjmR/RTRy6+viJUV?=
 =?us-ascii?Q?X06uYU6TMr7Gj2JrtHFdsiPJVcXxXFDvqjDs/RSyAj0qmHMX/AuYlJZxbTfM?=
 =?us-ascii?Q?4GMY3DacmOw2AsNdoDoDRpEXtF3Vf9+fCgO/EAehiCufn3+CVfrvvI5BYBOA?=
 =?us-ascii?Q?cz/5fG+OJvG1Pq0TrVjuLf/qW/FvmlRTyJ9WTB0N2HVZazUnktpyFpzxlkLp?=
 =?us-ascii?Q?Umh2fc9EVGE8Uqao4MiG/YZH5HdwEcOMEm+/8ayV0OwgPfVVxxA2DmyUpUp2?=
 =?us-ascii?Q?Yja8tv9r/q3HWOQwcAX6QghSiyJy4s6OcRzrHuyaw7DipAJ5mn3VBef0qpP3?=
 =?us-ascii?Q?MMmsM6qgUJNnfpxZemP4kysiSKVEWL85Uzov9x+xAFfYJ8n6UdYy2A1Bsu+H?=
 =?us-ascii?Q?MgLiWEL/LlsiNWIF9LVdeAuYWj8LY9COWqoohhx4HrUM/YB8TLPwKnaqsiYT?=
 =?us-ascii?Q?jF/bMzrabR7MkSin40oQuYZtBGB/P1mM2pxmWokQtal2X9ZsFO+jYfjuB3BV?=
 =?us-ascii?Q?vKZP4NIXvVo/ESLIZQo/2XXSMLTylptwgYDhqGgOKTwvVX5yImCw9mxFQngk?=
 =?us-ascii?Q?YQLFu+T76VSVIQvQjRJqwr6fl/u4tOaUCb3tsIj8UuQ3YHdorTLmIjHF/JsZ?=
 =?us-ascii?Q?KbAaH4ZHnrp8Ci+6dJlJAt1NeTPDsHwN8HQCLjBsNprQtXtanU7r1MqYQv5q?=
 =?us-ascii?Q?S1CrauWpjNfOqJ8kg6jBafWSVe2+ouu98sVAqSLujkfR0wIkh0auzPJa8eQR?=
 =?us-ascii?Q?9MNeGpFTkw0rOGFmaCxitn23cu8uSRABZBgoN1cIuasd+yuTEKT4bmHxb2yj?=
 =?us-ascii?Q?Slxj5H9eK65UxP6NcIAKRR3oJTaAM1ASBrugHW3tzDzTeZX0JNjro1Eg2tQl?=
 =?us-ascii?Q?ybxFY0d506mHdzlhWX1ZnWRVRz0s6fw+M3/0y1MOd0J8yaHUCprvIvE6TU4X?=
 =?us-ascii?Q?nQpPDkZFPI+PEkW2Sda+jAoes4XzQfCBUzJjMmA+mODbfuCg1jNzI+lqJAaP?=
 =?us-ascii?Q?4hYUu1mEbFmYllG4MIgdX2mzYZYCPRFrSpsUG5TK0Qtrwpnrm9OiKwHq+Sve?=
 =?us-ascii?Q?a/jMNwj4NAfnr4cCIWt6h+1eVAggIkvX3SXT1fhasxeUOJCFEixr6w4l5LEJ?=
 =?us-ascii?Q?+1BWsWD486XXMiC0MyBpUUPJ170H5KtWWdW0xFWZBfdWRFuH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b0d097-f9c0-4a96-465b-08de96440003
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:26:33.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbgocQYyMORhPAqLk8Plvjo0DSMvvOVN9fI4THtteX+u7Nf6Ir8Aktaw3589Kk+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19172-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: A5F773CC0C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:08:51AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement .alloc_mw() and .dealloc_mw() for mana device.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Long Li <longli@microsoft.com>
> ---
> v3: Use v2 request
> v2: fixed comments. Cleaned up the use of mana_gd_send_request()
>  drivers/infiniband/hw/mana/device.c  |  3 ++
>  drivers/infiniband/hw/mana/mana_ib.h |  8 +++++
>  drivers/infiniband/hw/mana/mr.c      | 54 +++++++++++++++++++++++++++-
>  include/net/mana/gdma.h              |  5 +++
>  4 files changed, 69 insertions(+), 1 deletion(-)

Applied to for-next, please don't delay getting the other parts
completed

Jason

