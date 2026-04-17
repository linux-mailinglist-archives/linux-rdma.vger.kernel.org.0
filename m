Return-Path: <linux-rdma+bounces-19412-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMUJGt5P4mnx4QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19412-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:21:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 981F841C83C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 17:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD16F3013195
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798322DF6E9;
	Fri, 17 Apr 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ami2mYkt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF08472
	for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439238; cv=fail; b=Ms+wMUBe3zf4DwBPtHKub7OSecfW0ClrQxJ2GLJvfOmJQYmdrAlTh0S07Qij9Yz+/KzwHDmTqaHzF2iWJNfXhefB0uZMBeRMzmte4o3aaBdDW8R1DYPtULFKmY9hjDOpJDlq8n3zaDd2T9m9BpnyyhjDQKygK3emrDN37bMEE3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439238; c=relaxed/simple;
	bh=L4ha6My23xpy+Oz19uWdGbpfneobBk7FQB+uwEzpPHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V8dNx7AyHM88M9d7PgG5/tL6uXehEgIm1H4TF+jVFAVPzAZkh/NSnR+JAaj/aXrRoXTN9hVP0ybyzFNVJuRwKOIYtl/VkloiXL8/qnAXlB24HokVcWn8DYCMfHZ2TMVg5jJxBTy3qR0g5jcS3EZaho9/IPh+F1Ah0cbekacgLYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ami2mYkt; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZyGsx3WhTL/G2BmFLR91B159jyCrgMJ5lQYA/0I9KdM3QPAf199hvSysWyJgBOTqoVyqn61L98Cy9YTAbWe9YwOEY1J+8GvKWmVW9lfkMm6GWthn5CBLldIifapdhhmeJ0nTNJXMkOb4m3YEqMN+1H0WM0IijGOAhhJqtpPE3A/MkU65fu/Ef9daB3Bc2xkrpNpwfXMRNMLXZB5nPJRaZ8p19Zj9ojnuxmjImdpw7oxy7wziKfRyGjH/O7htjR8mK0k4EYrX1Gq0IPWU9Cf3qpFDGV3bfAt/ImgXbkTBwb0ZUuEFQLZlLei8hfxemCOIvJZVpFISNP61qy1Ql+ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKh0YYBaGqr4kr5i4vodtiFoeTMRPFPx8ZUk6/OwlhA=;
 b=A3HAIGTyqlLBNfsmDx2azAILf6gpUT8b1BFpiOiMqZqFdBMkk2h7x2RJ/6Gvp/I0mI3lh0xdZmVuejMwW80GB1DOKYvwotDAtAx2GUua1tMQB9cYYwHVW/eCXsLxv/WJoTSlNS5gPNak4GywQYyeHy37OANAIGlWHwP3ZQsd3Z5Ljj2o8+gkCdVrr7CK0+HsUjDT7x88wt8RAqSNbtSoy0pU4kIUilGLWu0SqGL8R+DLTTsJmwjIzbXMOrs2KZLQkE9BtH2dgoBpPdZe3N9dXQjxHn6z6kQ7tkaa2NjdeXDDCLwhcbic/vqefatShbUKPnh7+BTvcP8v7F3nHQsp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKh0YYBaGqr4kr5i4vodtiFoeTMRPFPx8ZUk6/OwlhA=;
 b=Ami2mYktXoSqaPksWcIXP4QpGc5gHR1R3MBbom3NO7LGD3nR4rHp0thK9OLtCjVFEroWfPVya3KpV+7uJJTCzIsyJaKSOBuTHysYcudNHpnoe7jBe7iopyTLSWuHBjz+JgvidH/rPIkICl8XAG8pjXpRh7VySrE02IliWtyduS8+BECJlzhnrk68EQUfP/iirlL9rLIZzZEycYMsc4rJiZu7zskhJBTJlJBnGQDIwL20P75l2gz22FtY8h0H+EpB+DXRGWM1ar/Y9yEw7vB0aajycXpmGrgaPYo+lEeOeh/7T9pxwEPG9xflXlK4iSw+CZXt/+xpZ9RJdXJSEUwC3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Fri, 17 Apr
 2026 15:20:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 15:20:31 +0000
Date: Fri, 17 Apr 2026 12:20:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev
Subject: Re: [PATCH for-next] RDMA/core: Fix user CQ creation for drivers
 without create_cq
Message-ID: <20260417152030.GG761338@nvidia.com>
References: <20260416201408.13980-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416201408.13980-1-mrgolin@amazon.com>
X-ClientProxiedBy: BN1PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:408:e1::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8079d7-c696-4dc7-6dfa-08de9c94dd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6rqdeSDRxViN+zOkgwXl0hxp0g8zQ3AGXnVaSzellUtReCpBQh1h/hlloWPYlq+OqmF9U1os5BjMxKbkAarbHKxfNIdHbupFtPCnppNueQxKChf6EiQi8lEzSCXQ/rPN/xujX39wKPCRguQIcmlQO8+OLKK08NVRRgE0du88GXfDcNQct8yKe81CBsgHlNdzAlFMXkJL0DiXXtfwt/PXyN1bG1+RFn0QhpixLhwHLJTtPkSXDuDzfMRlbAbCvPuMxFRXBkU1QxiV7xWIdiSlg6jqrHd/ZAFSJ2Rd4UwvJEEjZqZBdB68xOtciCYATTnNH4iS0nXHUuWI1VvJ23U4XrbzMViYf7Altj4IUBo/nA+VLeQI1x0hLkbsrVvcUl1L9hLKvJegCbBJWseyvoxTlcPwfLzCQiErEiLe2HGWuZ/cMWSoFyelHHpTLbflKG1bEeavJj1THyQb2qD6mQVnTuEL9DxRiGGBR6aDFiDYsW/9r6JhpFzI7yX1T5PN3CF9QODDB2P3W+zAXU3SuDCPPNumuS2l43rCdCPGANaLsEExtVEHp5e0xAKq6B/LlDpMmoByKX+RW08a5UFHOWNmJ04guHPGcDMdZ0SeXM4y90j6PxGgr/3UCWZrqZgVW0NiSrgRyfEL5ljI9Vuo4/asxtLrxW9XZdiDUsCaAK6U5hiVPghNq37VnSOt8clt60cZkxFBQ7LkuQMZfZyXmlvOFJN5x92nDuIJbRTQlms8YB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vKfWqIY0GKuCqBhUTYq+j7+/QjQNoL78lnWTSiElis2430YXj8xUP0bo+sv1?=
 =?us-ascii?Q?J3xWdFzys+C8V5X05o1Yv+fPXmmTcxhh5L0P53E3ZM4aS507VFFlBKIIYLCm?=
 =?us-ascii?Q?vuDwOPv5Dx84dsvmGURN3OXhoVB4zSY/rLtdfO0tG2TGhGJJtLDBZ16EV8I8?=
 =?us-ascii?Q?DZgPJWVqVaXmidNNEYx4NmG53z5BfHgHlUxQgIJrBdxkVzxfOK+MVUaZOBGB?=
 =?us-ascii?Q?worlSOE3odKJtVzDug3Gyg/BKF/UKPiuk4Tw56KDsBupN6YjKYE5DB5HT4cQ?=
 =?us-ascii?Q?StkmmFDuzKZX6CesS9frypelhfo7KwlvsnUGE8FnSeX8k6vfJpitPYxkWlRY?=
 =?us-ascii?Q?rNu36JOkFnLmDTIEfHA4DyLjjLu0N1WUExOHywKtd6zQ9Wgpk5hUgTMrBLME?=
 =?us-ascii?Q?RJiV0MYNYGkmbX00Z8XiVTl64WfXsJ7975L3oIFS1bCfJ8cRB/471Lrkh2YO?=
 =?us-ascii?Q?g5TvrKV7RNt2JsRk6aYmWe+o0x63oejXNI/KLOX+nzErl5nhamN5ECctZrmC?=
 =?us-ascii?Q?w9v+8tcmiZJiT8WV8adwam0CKynqakiDOmbyCM3lDHVDvMEm9pazWx1Qm2G8?=
 =?us-ascii?Q?8sWZxGVNlE+XTL1nabyx3ERv1bWNqqaOXWcXAA0uYFLObznMVWITHpApYLRb?=
 =?us-ascii?Q?m8z65A41W8UJ52fNM0/cy4UnvCBrpsARkfw3E9lFF9k7gVpgIJrukq2U96tY?=
 =?us-ascii?Q?fs21aD6VSKVMhe+04ErpNqtBvyYQ/p+5qw2yfRgH1znKl9g51MnQAd++cMDE?=
 =?us-ascii?Q?9BaFuruThjMWpQV9+yJrpgxcp0mlA7WkqjubQPrvYu7fKZ0zdMHB1tLQ5I+c?=
 =?us-ascii?Q?Fcp4C+ULCGggVeo9vWxaNqnvhfUGEyPeFRYruQpJNDw14zKekO/36sqUD9j4?=
 =?us-ascii?Q?tKF/icqPOpYrTM10wdC+TDZ1kIfGFweSiNyWaNvgM0Kz8IR3eq6GuKryG/HX?=
 =?us-ascii?Q?L7dfbQyyLJ8SXV+k/dAOHpenvvrfUYzAvU01tmn4iMzFFOLAJrss4t2mfRqi?=
 =?us-ascii?Q?4SUqu/v//NFdfM2HW1ObLozmSQcRBHjYCeDXr9aDO9OPcIZ241jBBlbeOwnm?=
 =?us-ascii?Q?QvGpnLYTH5M64oEs7z3zYoOZQQkdHRUJEbfEjmSg9pZuxZqndF3eK/a9YKeA?=
 =?us-ascii?Q?RvfKEJcxm7Ly7wlnQ0NEnzgNLrlJcBcMCGR6ANk1Hre/biUjePxo8EHKzwSK?=
 =?us-ascii?Q?58stn+m8d/mMdRIldZGBo4kkk3EcPxuDgPXnb0xQ1xsv1C/Dl8ADbOve+I+W?=
 =?us-ascii?Q?PJq4IgsOhsxDHAETAmbwcJH9FD6QZXOjPug4+2m1fPEDZo8A2rxhKjie4rHo?=
 =?us-ascii?Q?P/WH07UWoyDCtGYM1sMctUsPnn9IZrf0JynQX+kSwT3Zjkjz4eD2mRsr3ht/?=
 =?us-ascii?Q?iCHA0+QBbGCDSdTE7irCT0AVsDX+uR6mins5uMt4scLENXrZQibHgjqzP/s1?=
 =?us-ascii?Q?fxXzZenVUuubtnTm2m4fiZ1PeOGgIqN7Xa2BF3QPcp8iu6+u0qkfMX3voU/f?=
 =?us-ascii?Q?zX22UU5YCdQeoNFrW3UFWxHgcHIRljj86lEZmHEyw259ouoW8e3Ggz1mtTM/?=
 =?us-ascii?Q?uB/umn19aZLYutshZq756Iv3y2kYTyo/9gCUIXqfUkDIE21rTiJMrPBRLMlB?=
 =?us-ascii?Q?RhFWqAc5KA6aCVnTnv2RBHlPXk+GneQ7Hw0rRNVstueF0wmTtMwqg4hqD59Q?=
 =?us-ascii?Q?FdFBloauWcDfD36X+8Mcteq3W/2wGjYFtbyPL7FH8sTaVBTU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8079d7-c696-4dc7-6dfa-08de9c94dd2d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:20:31.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQGFcfduglfmGtsGpCMMuKC4D9Xi1+11fCgqYUIDdqgVMm+ekDic/eZevHzOTdH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19412-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 981F841C83C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 08:14:08PM +0000, Michael Margolin wrote:
> CQ creation is failing for drivers that only implement create_user_cq
> (e.g. EFA), when buffer isn't provided by userspace. This because of a
> leftover check that requires create_cq existence in such case.
> 
> Remove the create_cq existence check from the no-buffer path. The
> buffer is optional and drivers that handle their own memory should work
> through create_user_cq regardless.
> 
> Fixes: 584ec74748e6 ("RDMA/core: Prepare create CQ path for API unification")
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_cq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied thanks!

Jason

