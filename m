Return-Path: <linux-rdma+bounces-19177-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDXUGuHR12mrTAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19177-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 18:20:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF343CD962
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 840C3307B352
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616AD3DDDB6;
	Thu,  9 Apr 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMFhaGLq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C71253950
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751250; cv=fail; b=eCc7e3Wl+dpzxFX8aHxybs8G5WNkw3m1bGGQ3N2j/8anBi2TqvWZmvAHbZdPT2Ig/qQTDgqnGQF7JhOnPQ3+UQeongoRUWItI86VmerBdGEnwZP40IF4v4hn8smVnNLV41A7XMx4EbiljDcKKyld4D768yOFxUFT0K3bjthPRuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751250; c=relaxed/simple;
	bh=vXw6cmOBGaKnYNa9F/t7rVoA4grRFaKz/z3r6Vf5W+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NRzsuPss9aiimU70wLaw3lUtDFN4mTzR9rEhrRP0uppOy2IfT1k1jWvRc0dLyIlrEn1rNsEB+oh0zxUyf4HJQTUQfEPzFe4/c7MEFFazBDzRsz5+UBoFSUJI8RgEdHFd251vMZ4AGRxwenfm75g5crBh6qqilAFUDcwv/RD5ZDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MMFhaGLq; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3yvs4oArAfVhEN57q5LgcrOaCtqCkKLBZ8ySDPu5E/HjRmYMlVMpP0I4YE19ljHTav/OiuRKNKHl0vyrjrCDXiOszeF9Zz7TrHZfiZLEpEZXoRvmY0G6cjaLDY4bDmt27Y4m6LiprgENcI0/loRxHUajl1uNrf3vbjDim1q7MfHnvi3cxCJ0yRiJK0B9JbxaNh3pCCx6cHHO3KlZctwYoCzSt0AkllkPCK2tDf6+3Ef9J57zNtVUPa6AIomlqDIemvXBDO7FdXiH9UUW056sKHDJ2Lnd/6L0fq2+xCSethhy39wNdpsF4bXUyQct6qE8KpXGd5lqH1Kut7cPRBJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yImpomZns08ZanVblcI8JLfuBRAToNtP8CF+srdi/NQ=;
 b=PF1i0S18Ub5PlGflhjOfuVmUzSLkmIxnDBXkb8Piue9r42PYnOzC1iWGJfo352steJfgo8LzgMTUk1VP+OciVby84cza8fzbJzEq4wPWAiKHH2YJsWFM6/i+UDbOIGlOObBdffv0ZtRXUr86Lh9WZtE2jq3jzcPTDcgEypDGa0LkuEt/8gpHoA2hBnW1D/c3Hw4syt71NetbjIFcbF7oo04EGLAF02a0SCM9szSjsKnSzxw3RIDL45JDtzP/Nd/rSXq0bPcm4NaYs83wuyhqdmPRr7HVHgngEizBfT2VN8aQYFOPRCM2VvhN4t5X6aKIZNgFXAvE4FWm/F9BA0QYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yImpomZns08ZanVblcI8JLfuBRAToNtP8CF+srdi/NQ=;
 b=MMFhaGLqMhvJJu0UxZLOw6z7PgVsIv4jV5+EnMJDxA7WYoaRnK1Z32RtLoTMiy3uejURODT2ZjzIbXVpOWNrKlRbo7+ZbAPdFyxO96H7VYtgZ1Fy90yxKaLyCQI58eBribP4mnn3Fn3rKqFZNt4wziKQyOLN0uvtL+8VAJ9muyvbsHUdNYvti01khWmR50O9Ua46bvB35KZM43r2TskLEnU2V8+5avY8MmIsgul7xFYoteokivGINT/gG1yBuEkzxh0vytD4CvE0SCzZabp/+CvmE3bsvdCGFtU29EH9U9uttu0kXckKhyK9FKKtaieQX3Ek+jnBggpW9j0JyuPWDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 16:13:59 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 16:13:59 +0000
Date: Thu, 9 Apr 2026 13:13:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Message-ID: <20260409161357.GL3357077@nvidia.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
 <20260407115424.13359-2-mrgolin@amazon.com>
 <20260407141731.GC3357077@nvidia.com>
 <20260409160007.GA24340@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409160007.GA24340@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
X-ClientProxiedBy: YT4PR01CA0296.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::12) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f832190-7f2d-4d37-a118-08de965301c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NjypCJZd34ZBUZcmkYT6ILifdNd/NUgPm1iBdOnAykvtWO5VcjPaL1vB7D0pA9+yU5zSNMS4hfZcPwHLZ5S5gC0Tk+neRyTjOWZw5hAnUzpguSlRFNu5ZY8xTI7frpq0xxgv7pcNZnuHVADX7nsW21OjL0bJxeqNgLcIim73JEh9F0vDztDnt9CMgUCJhbwec6VaQGNJfAju04SUGW3vwF7Cx6onq4B5LpZ+z6GH0tt3zNLv+cCKU6uQCFlNATXyef10blJu/1b+OXnmni1sSfmw6it28FSDbpCfhYlKZFxlBv4uazulpztGwiUxQEIQNFVV6vxw72B0qkQDXLS7elTyG+LoTrih7yBSbMDuYLSqJAfAghYUZmRZTnrAOpqumUvPST4jb476eu74POYOlY/VVukhmZxP3aZWsASmJ4A0HeE1uDRnOt49qCFd9onChMgskmpAdefi6duZxAOXXBoI9RlZ7FlsHhSvwXtKVZ5wvuL0IpbgbNfCHwzkg84hg+HwgcK4W54D7a+3DbyKT2B6sP5JIslhl/6biILwNRNJcB3+Aq/9nnrJnsT8H85EG12y575PpIsHMECD+kX/tmGEaYAo5RpVZHfrfhDLx5hi40Dmg6IBQco1llAhqlWKtaw4XsXDlJNMCFojyuAXqAeyfHT4nz3LD8uJxyqRRqhzUsHC4iW8+/FO8mz5dlpauzcavqcGMZ13XZJkWCuDLvfOn+tUw7aSt4e8w1rF88g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KuyvsjaDVNYAypN93bp7373ayUIHg3J74rHhp2VzDk3J+CUnlhIFKK8ZUvf4?=
 =?us-ascii?Q?Ls/1n93jubQP1O1xCK4dnDA3IYxKMLhbHQIU9TUcgW+MDSrAM5nU7gzP6TIF?=
 =?us-ascii?Q?XkXUHjtjuGVquNboTPuomhjL0yHwvW+bgIh2wvt1qZOP+htd6cM/YC7y8pyO?=
 =?us-ascii?Q?c5rnzU7cr5si9kcsVnGe22H8Q559a8qxQampic9YnxI1wmrAhGYejv4Cpd9o?=
 =?us-ascii?Q?f3UarrrsvjV4lKy23wQ7/px7mUgqhS/GNrh+aOQVbE1D7I9znaDaz/C3+HWt?=
 =?us-ascii?Q?6WGbaCDswdPCxbV9dsQt60rPtJIrc43ordSnFIm2tFS9E2c3Dn8SwiUwUfW7?=
 =?us-ascii?Q?1E/VX0HxiHpHh+fFSPeKMj8dHtMUxFhO5hwk2GG40hFby/Tuh6udFUCc4s0i?=
 =?us-ascii?Q?b+RxE6XP5HxZ/4GSfDS3azuwpGS2Aogul7Uisi+g3jehSYdpdEaGanacIkxG?=
 =?us-ascii?Q?peLYm8zKIVglnhUARvCxtx2guwV1sURZMf6BrQwc4X7i9BnMBrNYgDqiZIc6?=
 =?us-ascii?Q?5FE5TmCirjqNeDTpzQrx/mIfnAqQp+QHT+rNsg2wGiHRgJOIKLnZFGkLj/t5?=
 =?us-ascii?Q?UKh8sEgGQuSgC+sEP0FPt0kSLAVez14gJxMZP0exar2vmhhadUziIDP3JOA3?=
 =?us-ascii?Q?I9v7Ykpj39MrGofJMNclxJM6L7zJPgVQUMeri2Z1UUYzJ93LYVacTjavbd9c?=
 =?us-ascii?Q?Y+3S/Sm49gffjziqWYsKJaBQK2oIpHsQX5u7ivGTbNxz89PwnM5MLqH6i2Hy?=
 =?us-ascii?Q?7NFN6NFSlO7RK25mh9Vt8KBDP06oxzBk4f2sMr4500+J+nV7RKigOsYzsGNd?=
 =?us-ascii?Q?AW698EY42/klepmcq8vFFX4Wtlz4C1AfbswBF0LWPZiFAd+36sC2/aNlPAb5?=
 =?us-ascii?Q?5Jjt2suLxe7p841uaGTsgMfb/iDKAypRnUN7vMxqRvDlFwOZO/Jqzo3/+0Np?=
 =?us-ascii?Q?civ1Ad52kVkiI/qyhYibA+g/wnV3V0NX1A3whDrBZbSlZ6Qny/mMVatdaAdn?=
 =?us-ascii?Q?qUgLjg3XAxn6JWCKBvbpZ8vAvbmm9eqMPnRsgsGvEZdHYEburBBEb7qDV5rv?=
 =?us-ascii?Q?rcOJj5UNj+Z119VeK8oiSxWh7Qo3xRdBwAQRLx/6inCeDmxpKuZs9uTDcm2U?=
 =?us-ascii?Q?/v5OkDZuwlI7jrk8fuxQQvdsWDTagvmOBrFTbg4xlFWIf93rgUaPwKK5VfYe?=
 =?us-ascii?Q?7bTnT5Xh6DWnQQVgL2rvmGaAL6lSoSEPeUZv5I0704lGVKgonK+Laf/wY8Kw?=
 =?us-ascii?Q?/aZqdWuq56G3QqQyZoVy2TSoLFujitnPBniuB7mujINW07EkX9R4eKHPM92U?=
 =?us-ascii?Q?CHwDQuT/GK1jFfMpeJd4BzdXxUj893fuWvPZkYivQwKQ2JwsqRr9Z4OFph2U?=
 =?us-ascii?Q?VIqMkgN2kuWEdW73VcF+t0KEYs3tp66dYkm7b+xEDa2yWBQJFYSoMTWwxloj?=
 =?us-ascii?Q?OTwoCrUMl4rrkoFyP/QFlxI+5ywq2s1BXwrws39O5pfxU4xGySYg7UH9hi0c?=
 =?us-ascii?Q?8y0Dfr03TKaCooq/inVpGAo9cgGhVsHAv6DJbsMgP9aOi0h4BY28mBNIkrsA?=
 =?us-ascii?Q?nx6n5MUWTs4y72c90/wuMwgDJRdGn3jKXoiCS9dNs3//jC0sNARNi0gx/F/2?=
 =?us-ascii?Q?YKVVxcZeRKzCcwytXxVbMvZqXTD1jjuZN9V99phonIYHMqzkU67R4F73XOMU?=
 =?us-ascii?Q?RawSn0W8hWS8sMmWnjTRse+pThdY4GzrIkC0MJw0J4FTvYpG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f832190-7f2d-4d37-a118-08de965301c2
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 16:13:59.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3ZMjZtoYZcTs0jDvFf3hYdAzq9c+C3lsx4v5rJ/MzQWcZcKWlsbfVndnB//nkNq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19177-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: CEF343CD962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 04:00:07PM +0000, Michael Margolin wrote:

> EFA actually has a single counter object type that can count all events
> as you suggest here, but I chose to define a single container for
> success and error completion counts in core for three main reasons:
> 
> 1. Consistency with userspace - we usually have a 1:1 mapping between
>    rdma-core and kernel objects.

Well here we would have two kernel objects right?

> 2. Although the UE spec does not define HW interfaces, it does couple
>    success and error counting.

It's just counting, it seem slike the api is you get a counter and
when certain events happen it counts. You get to pick what incrs that
counter.

> 3. A single object for success and error completions gives more freedom
>    to device implementations. For instance, it allows optimizing device
>    HW resources by implementing the error counter in a less performant
>    way.

This can be done anyhow by choosing fast/slow counters based on the
requested bits to count. If userspace requests an error only counter
it can be routed properly.

Jason

