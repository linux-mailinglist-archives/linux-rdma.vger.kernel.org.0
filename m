Return-Path: <linux-rdma+bounces-19766-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MCRN0+18mmUtgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19766-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:50:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4473A49C1A4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC201300B9CC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C927A476;
	Thu, 30 Apr 2026 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NJsrahh+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502D13777E;
	Thu, 30 Apr 2026 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513804; cv=fail; b=BGgguBRsy49xERa0bpORGxCFW5/En8XgXcLqW8XKQ+KfTbpmEZZIr7tF6x7w4TKXBmKE7BDJU5lgNTbtrBc5MzAf/Kt/wGJYiT2q35DIGeYrhjoiLJGlcSOSVmWSyS3OkpfgQiGa0vb4c9YvZpFVPpYCIlfhrU9FxdnQVqwL4pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513804; c=relaxed/simple;
	bh=j1IGUFTRkL38zr7oGdiJ9iR8q2p2NAhl23z5jfkHGX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BTEm5RVrFovEFE0GG22GocspxmrHiYy5Bw0a5jiUwAxvJZGtKFuKGLmvQIn7ln9jMnQCAW1AQRY2v2uO/TMGJnOjIxklkPIGxqiv38lZVrZqtpn0IOBHy1V8utFRDron1aobfhAQ5xkekBIeOTOhHteHxtBxjNKQ5Q2uToAUn9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NJsrahh+; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+ZfTPFLyL2QszaNzHYTbkhcXDwsCxQb+sOqty/0rFp+0QY6HwFMW6Qq9VAMX0gwIvXkHCUow/i7L7hHkYOezLPzPVlWrLZ/2vLAlulROWrzxkHPJg1lWJVXFtT7/0g2yXjH2M6vrMOURe1IF3aOmjOQMupkB/Ow+YYp7+x39OkfRZEyMoBCS53MLcjrbHlD3qf+mFozMFHgKib1x/zvJl4wehMsNbojbgyrY53y6S//qA9egNpfcirmSn8CcchRYHiQVHfOWfwCfH2S6j7odY27PPTRVzcDLAELL3i6mPqKwynBp9D9TlP6PnvOBUFTmwUKBwzyhmUvXpoQolHTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hIr0Xm/dqKiGZ7Ji5PUuVGb3cgXnIAWdk4+G6CJA4g=;
 b=ZvYNX2APiWtG+JU4v+RBxwlogldqRnMDhnyShurImY2ZYANoAQeOdgPZvHosIhgxSIH/Blxyp2EChhBfeBgGbo6MtzLhYT51gWMI3RQCfi3tcSv8ZV5APhrsmPp//u2PKMbAf8eePlX6ZPJcK4cz7OnwN0qdXLA2ud0AvYeJEjG2fD64CybPBNYEQ3MxrQ7bjeue1UOIsizxMSnGIOKBZXPCe93mwR905X9hww7nKaqc6mPy54NLThnM/AZNwZD6i9gG7yQvXGrxjZ4vKQNv2RW+AWpvbuBaxT7e7a/qkhTTRARb0wGHy+f+mfinxcAWOGucnTnkXAGQ5zxTq/Vf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hIr0Xm/dqKiGZ7Ji5PUuVGb3cgXnIAWdk4+G6CJA4g=;
 b=NJsrahh+4/z7H/9wLOv4XHwjEb1xPveou3jjpzgDt9Nty9QlDgko3YOonWKYc1FWu7CcihJ+kTssHHiZ7ZCECaiDWMT/9okRusBM4mCMf0vmf2alOiA/9N6xAwgbYUUj0PQanSULQuuH4r273QJC0s4Mk+U+l17h5BV7zM7BMDy5l0pYPgFFlgTEhBPvzlDJLHeCCm9Bh+MQ+8E860zPLvPcum8Y20DRjvtCb7Udo/d3c7zTsZSfqFaWq4mOFNkWrS54jCpVSB9rJBSNoQJCRNaRYL7Ph3+ru/LMblRDzYq1u3NySqF3GrzsaGH3rJSjPMAxoioB94DjJgNO+/Qdbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 01:49:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Thu, 30 Apr 2026
 01:49:59 +0000
Date: Wed, 29 Apr 2026 22:49:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <galpress@amazon.com>, Mark Bloch <markb@mellanox.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Neta Ostrovsky <netao@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Doug Ledford <dledford@redhat.com>,
	Matan Barak <matanb@mellanox.com>, majd@mellanox.com,
	Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next v3 0/5] RDMA: Stability and race condition fixes
Message-ID: <20260430014956.GA928887@nvidia.com>
References: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e52f7f2-c5e4-445e-f67b-08dea65ac96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	40tKXC9LJRfydDQE6OFP+R01X3r8SOma7KYvSA2XPuk5LIPTJINFoTUfmZZ0NO5SCgPb/9HWauNFo7az9DPWxT2SyLPZlLAXxYDBu3FFHJfrhSQDQg+eOrakJpKfNjnyk01jw4yOliJRL0cV7F88vvERHIcGG4RQ3nbC8ojR627DuAJFcGku8eoAptrGiCtMtmh2JgQO2PwAQ1B0mEhsLetmiCdxo0JslhxyKLT4GwctIKFNhGYvxBCl0DxxKKWoofOlK1ofOKaOyWfjFv5vnS0gERWFNc9JirRzsNgptr+ADijz3rt7ZL7oF1DM9OK1Sr+YBzne8GNo1bOQCTy5ASWV76Q67S0Ac0W7j7CC2aLjuAOlGFfK169jonajjfWd+DjMIutlMm5YqFZJTgFD4h0IwhhtYUN2P9bH+bsPAjHRidPJaWVgQuCrzZW3Gp68GlR8yf/0IbfQKUfRxdKUe60hhGCaZR9mZw800c0XQqMxGlg8Ja5j1qlhKdBes9cKxrHEEGyNirixQBITAs78w/i+1jxeVkHFjpxA1SeGn1Qfl0RQX3MRGd/Fqlh7HrXWKgkg7wZxqv0L6BSeOq3od5iDr0L7c+N6xKS4rdDsaX2oVTzWHZDkxtA2h/oIwWpvqaqzNe+kSl/m4insZDbYG8FL3iwAfPVbDV/pl4FWuOUuzFcLqHJ2acQRJhIzSU4i1CKkpAKKds+FhhdpqAYGlF7V8uYZjTbAaxE/JyOocQj1Gls3uEWhilYfJl2Frryj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCM/Hc9BcDMZaualSVRCon/PFbW64hjdPkD+poF3VoGx7rW2H+lWiA4qB+3o?=
 =?us-ascii?Q?VdKWRLMTf1PNttPlfsMUj+K3FX6/HmELqKDiVkbLJcgniXy1hRfBNvVuO9gW?=
 =?us-ascii?Q?O174y+CZ2eEocx8Fa9mSu+qVuUq+HhsXZIsHoZTPBGlEMiPwFzRVxjFdd49B?=
 =?us-ascii?Q?N2WXGQb+8L2SZNscVYLyHUa/Jnp29IPhGQSmUTa9Wu59a99pjeYpiF6oCBGx?=
 =?us-ascii?Q?j2WkcfjpTChiIq1fH8vN6tNzV/9SuK+dsmOd0bxeXECCPcuB4pXw0TXiGEhv?=
 =?us-ascii?Q?qD2LS7xV93nqnNJFIB0GCqoPI7Vfq3zrtQUVy3l0OK8Pko4f9V0RyZ7bYLf+?=
 =?us-ascii?Q?R7QjDwQCfchqxNcCn/eOls3pnaMJlEV9QkKMc4Zqd8Ijozra2eYg/3sh52Kv?=
 =?us-ascii?Q?6QOwDL++SytewbVBU/62FDRqg6V0VEfgIDQ27YXNllN8ghTgioK+VYzexjFX?=
 =?us-ascii?Q?WzyIyAgRzJWG+HG8KGI3nlZnYHaRBwaAQkZOgJ/EnMw0qol/PTgmj4ScwLWz?=
 =?us-ascii?Q?myrWOMmmVPaJnXEta5JWOBJu0j5bU9PqgbHLbCvKTNckbu8qs17D/sAz259m?=
 =?us-ascii?Q?1XTeh4XZQ5zIdi3PclvTgCy4TqyI2ZhCbcIAG6bHbrSVogknC8QSvEXAqaTt?=
 =?us-ascii?Q?EVClJ1xv2ZF66X7zEQ2BpIAhmHKj4ZXfMWpquTyVhke/Xy8bpRzBj2Fnw5j3?=
 =?us-ascii?Q?iGvlbQFGu9TGNlgf3ne2PzCYC7qxhGf0QpiRhdkxdFqUgarITBNGNzw85XGm?=
 =?us-ascii?Q?lAuAE5oMzpD5bYPY5HpmnIn/ThlVdKqVpkS9AgnsNCtjtNThxbyycficSm7N?=
 =?us-ascii?Q?8rgC+vG4KjcmYcNbO5eiaJ3PHIzOw7rIlqkthXFkzNCneZ3WQMa2LMSEpVEe?=
 =?us-ascii?Q?sJ7hbmZZtpI3iMFczVmL+X1ai0F79vqnW6Ub63ct4ibl0jDjHcrWs8Bp0Q0P?=
 =?us-ascii?Q?JFQ1i8kpUhN/HprOVhMls7XA7NYUc/cvBIYFlijCyHGCL2cCeqBrsm7OTUW9?=
 =?us-ascii?Q?IlYCgX+/YeCBPCve/fXiq19MWM52bosDcZv+o1HOE/wJB3xbaD97fXUQcymH?=
 =?us-ascii?Q?SgG6GysSFnashymsTdl+GQkjFQMCH8P5N/5J7+hgmjwyo0BlqTLVovgLOJcg?=
 =?us-ascii?Q?grqXC25MKqhSwePAXrqYPrXmc0NbiM/26YJhygSNSNzbsd7xjQhVyA7ALnrR?=
 =?us-ascii?Q?dKQxTlRxQcXFqh9wY9tM0d9ob1PJXftjHK5KxdOV3fXoXXwM6wByMTflR8h0?=
 =?us-ascii?Q?cEoys6U4tXOJWtd0zFsq46HIfFaEgUK/kH0AOrPdV+S/pMTGmD+PjNa7p0dg?=
 =?us-ascii?Q?ZtbMmLR4xPFWay7pP+QiGOasyBH0+vLS+m+pCC4nmGLVdEkMVbeZHj+6erk1?=
 =?us-ascii?Q?lx2UcTvMfLp68/9EPbFEL4neJsXmTEOxIOlECotXjVgaDyul8JCU8y4tiYE8?=
 =?us-ascii?Q?b3Y73WGa18LsOvmPdi++GALEP5Bddo/F2I/fvonI1WaeTwcb0OK0Ov4IYGpN?=
 =?us-ascii?Q?zcHSJik+ozLGahfUZgVAdoQFAZ/+vc+nZNS0j1MxeN3EpqFo3p3P2Iahyt/8?=
 =?us-ascii?Q?bT2fQ9mHITFaBCHDB3tCjGY08jakxPYumjs9Br1mia2QnAOdj95QqLHw0xpR?=
 =?us-ascii?Q?UbF6fJIm8I3vOor4N4ihvG3QgLuQiJzyblMldT4Cf0S8LhGXK1b+8BmEPnJV?=
 =?us-ascii?Q?xYbNLB01cotHEJqLevR43xuVHnrtDRfR7d1thLz5ZZ1nzozF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e52f7f2-c5e4-445e-f67b-08dea65ac96f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 01:49:59.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rsCSmGvFKnLhGSRy6fqp3fyr4eRmkFy5Gu7Mcu1VGzsOMVF/fwSnlJrkMnf8zrQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465
X-Rspamd-Queue-Id: 4473A49C1A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19766-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]

On Mon, Apr 27, 2026 at 02:02:31PM +0300, Edward Srouji wrote:
> This series addresses several stability issues in RDMA core and the
> mlx5 driver.
> 
> Patches 1-2 fix xarray race conditions in the mlx5 SRQ and DCT destroy
> paths where a concurrent create can reuse the same firmware object
> number right after firmware releases it, causing the destroy path to
> incorrectly erase the newly created entry.
> 
> The remaining patches are independent fixes.
> 
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
> Changes in v3:
> - Dropped restrack destroy-ordering fixes (patches 1-6 in v2) to
>   rework them in a dedicated series based on code-review feedback
> - Rebased onto latest for-next
> - Link to v2: https://lore.kernel.org/r/20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com
> 
> Changes in v2:
> - Added patch "RDMA/mlx5: Remove raw RSS QP restrack tracking" to
>   also suppress broken tracking for raw RSS QPs, which suffer from
>   the same silent failures as DCTs
> - Link to v1: https://lore.kernel.org/r/20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com
> 
> ---
> Edward Srouji (2):
>       RDMA/mlx5: Fix UAF in SRQ destroy due to race with create
>       RDMA/mlx5: Fix UAF in DCT destroy due to race with create
> 
> Maher Sanalla (1):
>       IB/core: Fix IPv6 netlink message size in ib_nl_ip_send_msg()
> 
> Michael Guralnik (2):
>       RDMA/core: Fix rereg_mr use-after-free race
>       RDMA/mlx5: Fix null-ptr-deref in Raw Packet QP creation

Applied to for-rc

Jason

