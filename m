Return-Path: <linux-rdma+bounces-21237-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKpJD8VcFGpxMwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21237-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:29:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C175CBBA1
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2191300F1B2
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC47F3EDAA4;
	Mon, 25 May 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WIRTJBpA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4E2AE78;
	Mon, 25 May 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719362; cv=fail; b=gTUEqbqjQVFJR7WN4TrWlKZNy9Ln6lRJKwWQd0RPeASaMngzN2lvIYWC+6CKC5LmCT7hggE6Ih7sYEfLBoZapvhlaUodlkSjB7Mu8dk4Qv3QbqGaIca8BxqRPXuymdora00EHGQ9GliyLoqaTp+rXlvnGS7R8+Gjz/zAsKKU5mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719362; c=relaxed/simple;
	bh=AiZV25ho7sAJAIOGx/tTyAGrigR/aW6srudGGYK0Tt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m/aUqqW90i/JWDAncFPqGmMtngkXqabTTekUdsFOcIWDCoRTE520TPb19w8FPbIPoPAAmLVpMazLW7dX9CUhxoL17hLC1tsPM8E13I/A2Bg7LXxZXOoIpCUAbGtJgXD/AQQvTCjKH/DRh4ndeh21u6VcFGraNCeWbG01BnKbbEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WIRTJBpA; arc=fail smtp.client-ip=40.107.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnyYAwtmPrGItVISm7Go53EShzpVsSSjN+ZuUJ2VSax4tJ6PRjH21C8o10Drl3B5uFjLYvKhl1IJVtCyO680K0Ypjqf+O+lzqP77vlA3jTcAjTIslMC/SwwC2uLK+cp1s2FSGuux5GFYyaKIdDCgYIUItucfYQAd52GX/FoNTI13gF4UsXbza9HYXg4i1uTZp5PdJdt00XBRZq/ntTsYPC0tKAoY2midTH6Ko39UKwsB10FnkU5Ui81Xc3fgzwib+7qeQa/ysApERDXEzLsc08qm7KzquJDPlw6bBCaqF/SrELx4dKnEzt0zwiOFN8rpjHgjinH2luYmJZHiJNiylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIWtKxVtpGBH4KHbz+JtmoTsunXlDC0nI3pmlBz5obs=;
 b=jGzoRsczgcz9eLpBJuabalD/6/jhf+PClDLscS/ah2QW3PQJsXxZB1MDJiA5Oj2mALW93iw2tX57cOeso/WqngAtF7dU9nhz4XW/pc62c5ZAFqP0POyDEogH9NxcowFSz2BdpzgPgHPj9Gh46pRQYfdz0XJ2rBVLiBcsnVQxSDq7DSMhu0Y3QIvUn0RiEKRoovANkXrfzR0aHIXIq2E3+J6HxWG5RJT8TsWCVWE7q1yfVp21eH6+RCYaTIC99Td+ieqf1Yd8DYuI5F8aHsgFRdDyOuhzXNwyuZYmlD4OI+5thBPgRYaOpd1VZwENlSiOzWeu5mOs3SR8on3DY4unoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIWtKxVtpGBH4KHbz+JtmoTsunXlDC0nI3pmlBz5obs=;
 b=WIRTJBpAgl9Jgl8/VqAQ2/5EspNZzkl1qetmRhP6S34ZRPl/L7pcjSFzK8nL1McCpnR4yVGAsSzSz4UEORXzV1AgZ1KiwcPOxGguvgl5/iwCN/xd3ztt1231GiaWcgxakdEMplAjPfk6/170642+Gq1H9sruS8Yv56TktueYH1shTte9XkFELag1cP4zgN3ScSheSR1aaFPHXRXvHIg2ezkEzVfWM3rJp8hXCe7wiYkuMPeOhuyqwWyyB/lj0KkYGey2ApRM8b6bG8xxnSFiaeNvDtAgrtqpsW9JWx6UZtHPCcKTcqcIqigADGYR8uG114I3zbyFOOzHy9JWq+IKzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Mon, 25 May
 2026 14:29:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:29:17 +0000
Date: Mon, 25 May 2026 11:29:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] IB/mlx4: Fix refcount leak in add_port() error path
Message-ID: <20260525142916.GA2454164@nvidia.com>
References: <20260518021910.972900-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518021910.972900-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: YT4PR01CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd61f79-5e87-4ade-1d95-08deba6a009d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|6133799003|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	74PoeFfx2X2HC/NlkhdTHSlQAYhordT253Ws0hOuTCvl205ys2Py8Vj57GUuqEiHmcE6TbywmLjDRY2GIK/F6OQNwBPG+LhxAF7bi4NGLrbgDwZBj3jrDSgqb6tdOxaI3ee3hYnvjDXktUzWQVAJ7ZdzBPv6fOOzSn+f09OzLPwLCHsNqHDdLf7M/K0dMiSFBEdH25lXQiuUcZVngBVMUvUSlxeFV8Qjg/Zix6JChsXUGravZeHACNJXy9xvL1/6Ii6rGBwuFXr33vYS1vHYu0q6roOpCPQHiLrJJnzl+On+EW/7owURNR6kYJz3q+6JRWhd7AMqJLxzy6y5J7ifueM7Sg6ixnU2PJrtNc1UOc44lSfXZ7XrN7IBRbGC6F5ttny4jWDDCMvfssDnVduRVtGtJjwrlcf8pTJMFaG2EYgSKdF49SpU7lZ8EKN7+DRghR4XP49CzbsNDapMKfH0rkHu2aWmmUVREKL4YSJ6cQ5JLe88JxeSLruovp87NdNbhVRJ6qAv64bekh3JpdealDB6RSv8Fch6vBgd9F4R/rtXzuKq8Sf0dc6COXnu2kbLKxlOCBMSQtvdC+inH9aTTSukbxgMMlKb4miLag7a1hNkDZAy/9uka1EFl7hn8JT37VZ+TQML92E24YXKcGrSgE8lTYCNKNw0Hjj+2LYtUQi6OYJ8NmwNQM+axDcj9B++
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(56012099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BiVnHDj2Yq9b/3Vpx6YnewKi996VHFTKfMJY7MpZk32E8sgU919sO5P6vOFn?=
 =?us-ascii?Q?9y1YJ2H5Ld1Km1yHs6QAF3Jp/Op84qh8cXgkBWm3Tp0fQ6uWkvPB1WeYQe6j?=
 =?us-ascii?Q?B397Jx6THmBPHnOAFXcbl5BEd7rBWcaOoI5xjbNuGCCHN/IelDvxMizqhoUE?=
 =?us-ascii?Q?pLoig2XkYONgUgqVF2gJnAe3ur5F6lyCVrhB+fk6YpPXm6A5sVbg8XKRaKKo?=
 =?us-ascii?Q?7MyR7z+TOZRLabN/DeD4szLDFwGslykwbJDbgo5qLOV/0F/iKcLfuDVDR2m2?=
 =?us-ascii?Q?0OlE9D65ID23iI1EGWixljPp9HEgqIFISHa0meR7MuXfVHHJ3QEWRbo2tWJg?=
 =?us-ascii?Q?n07o+MpFoJNhQE5s2gMKuEqKGY506sDmO4jKriWtSDHrD860d5Z+6I84XzzZ?=
 =?us-ascii?Q?x+bWE2uFJREcYLb3iC83+187d8V83lt+yAOQiRTZm5e8JhBXzJOhg/hHTn9/?=
 =?us-ascii?Q?2r0BzwxSVeq9ip+wyxfA2ahuI1L6QrmYP4Vf7c4qjKRqE60DpoqZuZhl9rQY?=
 =?us-ascii?Q?t71zsu0taEmizKujNLHs9i30KRfDcmN99QD2mJpwlh2sY7Q6IWUy+ewzJ4Wj?=
 =?us-ascii?Q?6OHMOBn1Om6uO8E+OH/ZbVKFagKd3DWWAzcKEIiY2S4L+4xxZKZgZ4LG5Y9E?=
 =?us-ascii?Q?JTIzNUpuvYE1xtB7Aq+vo4Eo5g2rrQ6flDJuIFGAv5IXixqcD0Hs2Ci5TmYw?=
 =?us-ascii?Q?R78snJWTubGRZXEq39ygAo5iUdMAKHXhUsMWnA26rFJLqQDhKRrQvepo6Roi?=
 =?us-ascii?Q?XS/rA4q0HxwGt/d0Nxtmugtw0mtYxoP6qN7W6uRwI64Qyd7mPEARMop7M8mh?=
 =?us-ascii?Q?txGObQMcYZ3y3OWuGPY4kK01vGwWBsZiwi+QeM0/DCHGiAXihdPdZyW37JbT?=
 =?us-ascii?Q?jZJQDbYb3d4xEVNwYCc5AI1Qb5wutI8OoADLDv2HrJ1VMg+SkE5kRgqUea8r?=
 =?us-ascii?Q?y1/cos9FsIdZXL9p4F6NmaWHSKUAXZHBQCpnkGWFmR7dhRqeY4074M/BYCmk?=
 =?us-ascii?Q?F/i9uYBugP4+cQtOwI0k9ahM+ZKTWZDtGABwwIrwFMAlOd/UvrffUIZ1QK11?=
 =?us-ascii?Q?2mMn6pbjMSG8sTz2oBk+RZfpjl/7C8JVjLWwOmv6wyrAT6zw6IEL7EgR0xQ5?=
 =?us-ascii?Q?BxQ16fE9ci3A8C95NJqoROVis9JsBLYwZBvHsDj4pXjDxPB9HwSxczeWlGln?=
 =?us-ascii?Q?iuFgPY/6LALdfJmHg0I2lgiD+qlJBxdq0ZR1iuMc5rANPoQWw946YjZjKIjW?=
 =?us-ascii?Q?lJ91dc213jZBmLAvDxRm+Yfx3C8OhHXXIMHZMLI3vg5h/1Uc5HYTg/EVBBls?=
 =?us-ascii?Q?/TCHfFj2f4Ntt/W08Vv+1bMx42infKeKgzlt74ozvxl1dSVY4z9rO+FRcZ63?=
 =?us-ascii?Q?YlCopUuOceGeKCoOFQMjerrNhIQSEcrTLhQnQT5sWwyQSiGz1pwyv4aQrWBi?=
 =?us-ascii?Q?PkWiGdIKRcvIq83rpml3WwMcrfM9iesB824mT5DTofgZfh9GNVpSpuGB2lVT?=
 =?us-ascii?Q?K0k4mElG/pw2YzPeweDFUPUpciF4DV2UQAPXAewHP4xRPe6+ynsFOigzks5O?=
 =?us-ascii?Q?AegYSOR6gxPktSSswIlkxXrOOHxvkZJSZoPHyQ5cBfW7mnbk+WLP+vXd2tjr?=
 =?us-ascii?Q?g7OzIhrFgIGKDISRB7QKWl9IzW9NMn4Etnnt+2pnBqAU9DuIzsymznlRQROQ?=
 =?us-ascii?Q?4rT4Pvdm7FP/8QJTydKhvxqNhK8UeFtpo9CXyySF1EaNYEOo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd61f79-5e87-4ade-1d95-08deba6a009d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:29:17.4119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9UiNPZfS/zGLBCCk04Isc58x1/K9h3YmYaOdrEqiIbg1RbUrVLHDzj59LA0A95p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21237-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B3C175CBBA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:19:10AM +0800, Guangshuo Li wrote:
> After kobject_init_and_add(), the lifetime of the embedded struct
> kobject is expected to be managed through the kobject core reference
> counting.
> 
> In add_port(), failure paths after kobject_init_and_add() must not free
> struct mlx4_port directly, because the embedded kobject is then managed
> by the kobject core. Freeing it directly leaves the kobject reference
> counting unbalanced and can lead to incorrect lifetime handling.
> 
> Allocate the pkey and gid attribute arrays before kobject_init_and_add(),
> so failures before kobject initialization can be handled by directly
> freeing the allocated memory. Once kobject_init_and_add() has been
> called, unwind later failures by removing any successfully created sysfs
> groups, calling kobject_del(), and then releasing the embedded kobject
> with kobject_put().
> 
> Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

>  drivers/infiniband/hw/mlx4/sysfs.c | 45 ++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 18 deletions(-)

Applied to for-next, thanks

Jason

