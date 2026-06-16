Return-Path: <linux-rdma+bounces-22290-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mWUEHSefMWrroQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22290-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 21:08:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C86694C5B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 21:08:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=dLdx7L6y;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22290-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22290-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D965C303F705
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE44318EDA;
	Tue, 16 Jun 2026 19:08:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A13DE45B
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 19:08:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636887; cv=fail; b=mam+BrJkpi1cnRkPXolKeq8V9UoBgEPXTSwWC8DXV5t5Jd44unnVVR3BNIB4RfshWteZGNWVSA7Rq79WLkgMLCJuFS0Y9gpwtRmFlJW791lsJKYgjOoOg7MpjDJRBmViRFAYfsqiu2JTadAol7LlSLlkrakkVMJyuL3yWBzIcE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636887; c=relaxed/simple;
	bh=g0wVyrGClbekrfW4Lq9W1BlMmt9qhtcQfEOa736gCyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cTiNpVE7gmYeg/1UB2myCyhlKfWKeDr9gmnmgHuRDnWT5TetQ5FC6epH3nFwz4UDucg/asYL8YPVylxamAbZES5OOl6qnlHzG2lhXLQAGcmcAfF7z4aFPtaewIbwoTGkwhEbFeraiAR1Vw/Jb0s5qYCcPXuXWUKuUrUXJQl1J7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dLdx7L6y; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJJzmnYVFzbYaJYPSr8Fc8j9fhRCB9b3e/ZEh/3SZ6vdpl1x2A+GBD0UwMYl9SbFabZDxM7bxxdeDmdhM66d5/ZcJMPF9d5pUaOQukKsvZYtcz8dfXjrXY8GN0K+mUG5drh4mnNfJD7xVPvGMJUEXuCOW2MgdUN7n6sALpYke6GXSH0JUE41Dmz5LpFnLo3ZWUkiM9eO6OEANSxl6cEC6zPkitYYyw7AOHJWmlTNiIAjGmtu77PKbqwvAnzx1Uw2jdxG2M3LRrRijh/19BiDG+0BJW9uNp3wNwlvfZYxqmVifqx2GAMKXRKOWuuFnLBGRiFApmqvs5srGiJ8ND2pQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i53nqklXZ3gDeeNzAhQE0mWDaSyXyqrXhk0mMLUoFc=;
 b=HBbWytjkKb1f+IOye3VCGJc+s6U7ZrWtJqxtfB9o2mj2SEkWVa0IB2hK4huIa4EVpnSlwnWgQjabuA+Bxd8sd4WifYcn5WnkcM77/FwxQ1NdFCvdbKMKojJ+ONlnJu0LUYY5FGn+I26Ew+ytiINjdB+RWUQCjQt0cCLP835gFqHlaoDbdYp2sEyzEM0lyJwA/vtnn3FR5AcEnG5JDmo8CGStHUA0xacqvbvmeK8O+4/iYJiqRWP0aa5tcQYLfHLMubk8GVacVfXpiSgNIhaWM8gxA7uQrNHWgchm/VdIK1b8dbqPnflo2fuEJ0V+1S7bVg0WTdzPjozR6D5nq29zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i53nqklXZ3gDeeNzAhQE0mWDaSyXyqrXhk0mMLUoFc=;
 b=dLdx7L6y1z2PY/h+C52BABkmD2iP7myIVOM4tlebsTaIsnnARjBcI+xMtnPW6+BV2EfADXafWPYoqrqYFSdwsJjqkJoEhZig6HIliXZOF5pbc0IggMbmoCAhP4AbgE2FiwS7RGolJsr82bqj2kniJKwMekEHfM0kq5G4Tfi3+b3NDaYK+ck/ZdT+wyV/KLtE5oYXclOmTjNWfwVctSO8QIJKb+tgI7xZ7+lPi0M9wLcK6zaLoK/y6CLpaOBxjY05ZF38nuhS2dAi9eLXDz3ToZA4miSDFmED7gIHAEFBTPoBmMEMJO77FSklTM4oQ2U94+UjowyThiivmjYpYXA1Qg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 19:08:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 19:08:00 +0000
Date: Tue, 16 Jun 2026 16:07:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/irdma: Replace waitqueue and flag with
 completion
Message-ID: <20260616190759.GC3986358@nvidia.com>
References: <20260616155601.1081448-1-jmoroni@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616155601.1081448-1-jmoroni@google.com>
X-ClientProxiedBy: BN9PR03CA0902.namprd03.prod.outlook.com
 (2603:10b6:408:107::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: e13c291b-97bf-420c-8613-08decbda95a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XUYXmgpsi/ufyyAjWTOh3FrsJI/Li+jpZw98Spi97Me6UiZyl0RUUHUHLsjCgGBa9+owg6Hj58BzPALGfJdO/jQyhRO1ehqaUm7gBvIunO6XZdxmLnOEoNtiaSFgWYvUsWcAMkIghLPguBrZC0SltjZ7zxjAo9CfGxas5TJBDK7wF55AQgILuUGpArk5lMUriakOBaKff4bpKeQjO4ET2Ut5M2SeF72kYwAz5yWyUluQBpxT1yA4PXmsLzqzwpoSnKh5FyF5zrlPYRjRlZPIbOXy4Ir6misA4/WvdRcYLNdRJaQ3Pcxfk3oPVnLk5zyeuFAsNtu5l11ByKj9cXPoSZUkXpUXIpUeovoSp8kZlkwX6gPornlVbT9459s29VR55fjeJqZ2jNuD+dqOU+qN2A3W5o/qVYISwwGzl0KQ6/pTUr9LvD3+w/Xp+c1ny8EhjYnbIjAfjngGrTr1KEknhSkXh1gj3Wru2nEEA/FcED2+8AXOayLK/gRVptna/qKIXlppVPeoWqsScdVN32Lvz5LonkfZHYnmKnguZvQup4/kexe1Xqk8YMpMNzHHDe+UsxYGdhMV1HwB1UsTwOK2TgenEDxQgATI8h9OQAD4ExODfAratYGseNYcVG0zNOBpgeUBC5sz5jKvaTVPPjgOxkxqfVHGZYW0EWBIzkx4t3epnb0i3QLd+dXEJaEKLVrf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Si4g03a+rZqcbuozK68BCNKj6wCDm31ukhBo4MwcyWvOau3PreXDBYIGr0FN?=
 =?us-ascii?Q?WLgcZG0FFJP9rJbDYWtvagp6himmVy4N3BEWJLNQjhfZ3TeYvBisn3i+3kxd?=
 =?us-ascii?Q?F/NH9zXBvKftdRfMguuG47Vd9VGmEG6yoOQ9EQPXk/kSLLOgSfteN/r5VzfB?=
 =?us-ascii?Q?Lg/yginqXT+SJVu7w6il2udsKyjVkpTvXvHMezGojwBybu4THUW0wJK1x8wB?=
 =?us-ascii?Q?qM4ud0T3AZYltCWZBWtjV+L3AjN4Ew9u7x9DcNeSBKDxkFK5Bwo6HIQHDx+y?=
 =?us-ascii?Q?JGx663l5WycUM1NZfvYC3Dwobse4RcAJEnzo5Hf1xBg+iQPYGmIE5nLp6V2m?=
 =?us-ascii?Q?XduuK/LXCArbFoBZrp9TS83qUczAtkTwtDPygd8HqewwMwOz+1ifxH0Z0zGt?=
 =?us-ascii?Q?0UwQTXp440VIjvM3r3Kl0gRcDB1l9MxmCLhq07BNKEtaI+uowuXQE4klu/9H?=
 =?us-ascii?Q?Qao6D2HP1pMOsxHcDqBDkTuS6xE0tKHOPJFYeubDQ8LxigXLMVVVCUqvrt1u?=
 =?us-ascii?Q?m8PuGN602Dsx8vFMUM69uMjaUS0ceGo21sarosxk6zTnaehT+GA0or9kvqpE?=
 =?us-ascii?Q?TPL0FgZqxlDx+ZXIog+pEvMyUMFrz4g1D0dwAMZZ3cZS15KeHOq+4qU2MoZV?=
 =?us-ascii?Q?m8gHabLe3p484SUrHzXRBTHZBOWuDx2Tck57KkVehisXKVNiovStzTUBQt40?=
 =?us-ascii?Q?v1J2iWTF51pN+Z/GWAq4uAOpI+DnHpgTVPh2KhqviMGZoFJmzy8lNz4c2nVI?=
 =?us-ascii?Q?1ekTaToE4L62xkWG+h6JtL1AOSMv9lNVOSV7ZlpbeJ9yBQ3dA1DlMQCZNYDD?=
 =?us-ascii?Q?cqTAPekVDpnKjaI3+Kdlh5FHJRx3LDWxnR7Ien2xIxcH97M1dm5xqxP6pyqo?=
 =?us-ascii?Q?F1Smhq5PndHBlObu+qTnu0dGYKTC3rQwAu92+qHPxIe6HiHVIIKLvSvMQM9o?=
 =?us-ascii?Q?4+Pt1R/VrzdC7iAtG+GLeVuN7dH5Nj5N5jb9WShsd/cAqzJEQszZ4kkTm7jK?=
 =?us-ascii?Q?/6w3DV59x7xt6VAgPciLCgN3EDZn8Lm4VBD3b4VwWzPObPHf3avGGbOqEU8d?=
 =?us-ascii?Q?Nbp21gGNn6uJ2VNEGim5RiftR77gyM2kDr3esmrKcptH3axCDe+RTF9Z7Kh/?=
 =?us-ascii?Q?XQ0T1lcqvT5vT/H0d+K2ZznWqi7L8TBAyLn3b4V/PAKCv2lnuA4ei/YZE3C3?=
 =?us-ascii?Q?clCInPWcRSi5zChdyN1V9ol5a1GvB47A918I5T5kIgZnVYyor5hQEKCFGN4l?=
 =?us-ascii?Q?MYPDZm+y901rS4IDJXY1MVDZcChtljoEiEbFNU815JJYZoePJ28pG2dxj181?=
 =?us-ascii?Q?TcRiLeCBUA4DdfwI8Zpi4Yg2eeq52aRLmzADRXMJ8BtNOuN2coRWcLkQtfNr?=
 =?us-ascii?Q?XfPGNSoIkXnbvAWPemyPuwnrPSpeWbAMswBKLsem8CzceKARozIrTP5TFEv7?=
 =?us-ascii?Q?0wv2mNm5takoWGDI5KMV/C3SJ9RqlnIcxTGW1VVCzQZIRtkcSmIdEIQy8GH0?=
 =?us-ascii?Q?CfPy3HhWtNm2AH+toAFL8q4wLSowq82+b20o+LilW+LgM2GpvJ6jMITwwbiK?=
 =?us-ascii?Q?O2aEchK9GbTDop9FOXq7tn69+Xm8MxgTsazzlHfjnNJVADoGTi3ydfvs/YGS?=
 =?us-ascii?Q?fksEGMF/ehMSYFrG8R33lBwO3bgfX/XWoD4WKQYjYEqeoEJ8xA5IRXB23HTa?=
 =?us-ascii?Q?zZFlWoPGoUPiVmq9zj+DKwxdj/i6ZxCQkfKr5dW37mPGFSLA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13c291b-97bf-420c-8613-08decbda95a0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 19:08:00.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ol0H9bjVM0cPdaeV6+RJV1uXNs4qhZPcZKuYq1NetMov1ta+dP7jU2NJlRblzxMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22290-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02C86694C5B

On Tue, Jun 16, 2026 at 03:56:01PM +0000, Jacob Moroni wrote:
> The driver previously used a waitqueue along with an explicit
> request_done flag, but without proper barriers around request_done.
> 
> An earlier patch by Gui-Dong Han <hanguidong02@gmail.com> attempted
> to fix this by adding the missing memory barriers. Rather than
> adding the barriers, this patch replaces the waitqueue+flag with
> a completion, which is designed for this exact purpose.
> 
> Link: https://lore.kernel.org/linux-rdma/20260604135513.GU2487554@ziepe.ca/T/#t
> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
> Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c    |  7 +++----
>  drivers/infiniband/hw/irdma/main.h  |  3 +--
>  drivers/infiniband/hw/irdma/utils.c | 12 +++++-------
>  3 files changed, 9 insertions(+), 13 deletions(-)

Applied to for-next, thanks

Jason

