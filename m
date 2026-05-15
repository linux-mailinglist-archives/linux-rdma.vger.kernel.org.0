Return-Path: <linux-rdma+bounces-20791-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG9nAUyoB2rP/QIAu9opvQ
	(envelope-from <linux-rdma+bounces-20791-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 01:12:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA3955941F
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 01:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6715F3007481
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B350384242;
	Fri, 15 May 2026 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c21V3gRu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC75A175A9A
	for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886729; cv=fail; b=o3d+fVDT5goAoNNwUtTj/jt9IMAxJCVn2Z7x5dULbpGwr2/oqKfZelwk77dOUN/KIEY3dxmxPmAL/8FV34sGRcP7qDB+PnkZy/M0vBQIMlVcmdgauuAezq+xsnPDuSayCq+YFjfvdCHDb1hlDWeQcoeij0LCyeU4eg6yTNGjVNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886729; c=relaxed/simple;
	bh=CvUi7x0dYWoKvh+PkUJ5tXrMHh7fJDHkNqlxBtIURlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mg6EYqQ0JQCMt+9wqdOKdlDaEQ+RkCERaUvdsa9dYv3g5r7Wv56olrdZbmJolKLBCSy96UonAbE8LiZqkqbT6tI8MZTX2fPJUK11YAV2E/C/R3hCl9xn/H/jqwdpJz/aCQydMAABeA+3oLwEkzdkAhtUmlMgmbMXctrDO1Mop68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c21V3gRu; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtYMaG5eRQFLd87Xgt/55t82z2zwKlQg2xzb0QUSBe/SrRvxhLWlrs8UA0JP8jrLQuyU3cMbCtLv3iXkAzC8GCQmCTHXASrH5WXzHxU7woYno1fI2flTuKMQD2sl7HImUaTS4jDYmYf1RW2iqHpENzgLdDXKMEK5LaK/2jOyfeW2jwioUuUOMOWsmDiV7VNAOjKBtwifW5XvXyUZXf2P2toxqSXKHIZ/CSl+VgVkMmuuHmhhFyBBSBhjV15w/iBp1W2T/xlq+I5A5Ut8kJqEFx5fkCqi9wkLHRR/mJBOxhlGunGgQpocjgnxtuaml3Lhs6nUVQ6fFi5RCjivFELWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LNphvNQT+nhnMRkvgeyK1KvGQOqINwRvQOo4gHMLn8=;
 b=bGpWpQNnBRd6qDp/k1jh/IIDA7hz2m8CycmAemSopr7ygtP+h6n6X0JWaCJmt3TKoGl1ehUQQvqPBFi9ZQN2rTh6Mzyf9Uk6QTXbjxfZl0FPisB1cFcDbsT3WqvDzcXToG8cuG+GXT6N3BHkK/mlAXhlLJ2oo+bkIC2b6BevnufjsuRGAhmQqCNRB5+KQA9Ge86DHVmH7Go3PKDI/qwKRYcFndmYDGDYSP7l6nwkRvvppFdfJrboNRDgFadjTJOpiOLA+zO49iUnwJRNfBp4Gnuorr9eJ9cTBRM3bgxhzTfCPBUOSytSba792DOOIiPiqUuDpAS2/zmiHS2jqvWBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LNphvNQT+nhnMRkvgeyK1KvGQOqINwRvQOo4gHMLn8=;
 b=c21V3gRu+dA/BNNopV6neakwpC1eRo9HIO6tX8zYoxNHYPNhQJtIZMujsqyoSZXFOrHgMtR3398hefp7DM+agondiAXduL1OMsOCjsZkeqNH8AHE5M1s5k802+et5ka7ZY/wcgBj+dPNItAgH7aUelwEpehq1l6yQA3H/9XHqyqV0akkd3SIUPNvUrPAS/5vLUoxH1uBq0ans0i11zrC4DdIewhg8oxoM/eWosYLFCzhV4GzhAT1tL9Fst86RqLl9SkjkrWM+3/q0bU7bie+1Q31GHiOukOi2Zns+wO4J37b4VwWN6NZDVBDxES1RuL8g+Gqio+9oo6ZyMOWrBit1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 23:12:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 23:12:03 +0000
Date: Fri, 15 May 2026 20:12:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH 1/6] RDMA/core: Move the _ib_copy_validate_udata*
 functions to ib_core_uverbs
Message-ID: <20260515231203.GA1973448@nvidia.com>
References: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
 <1-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:256::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 96be4fbc-2789-41af-822c-08deb2d76057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tI5I06gLPGRlCP7rKLkLrSfv4yE2eNRYBxh+HTTuelZ2hNdH6wRS2tMNbyOuxkCmbvCRZaFK+eQ5tJ4P0mL6FfxPd6lYTv3GLsEa57ABkPOSq3CbVu+0A3126H4DRiZY9J3TeVhl8ZNR1JPEG+Hbp9ZKgdrS54J5SEHtYxlQsQfvoGPH36YboG4vxDYtcTnxuELzlijhu8Idj9WbwAE3sY0CA+VJ206L/VFHMkeLzWHl2HZUynNdSE85BBtLKthwzcHSesEPB0psnKleFMoKOkmfDxyp/N1KvzEHPaNaQHhYZ3Kay2sRt8vlrICML10743RsombdeJQzK134hxBJFoJ0CE15QqRg8fmPLez9tRwGFzIjP6ngF+nNaW7w8EbPc4isPDgR8cD4Tt1rFNZam3XCfZjidURimSibqhBkZYT9UClfzgUbTJxwXcix5U8Bmm1mitCHun80Td7gfcqM3IRDwOhmbpzDnKYjmBt40LGpJQ9gmctEJ3K3B4P939DaVGWZBmla1xnmkuFixsg86V+jxOPP+IyZ8AEqJl/GBk2rHNuWCMngv1KChmqeIkJrWYjsXEpR3ZNZ2P2sgfYgxQzHCEi+jFOQSy00oPhHJ1yNWssKJeTFE6fdp756MBdKSErPnZshqGKYnmBFupAZC1qqV4x/b+bkADyjjyDYsDMiuyPVMDzvZmYxhP8Z2oOp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(4143699003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5tIiAdBnt9wX48oTvtHA04xfi6nbsrmdCj4OMvYVKuPnidooSY9PQA8UWU+n?=
 =?us-ascii?Q?mwPxAJdip6oNnRDOJhFw9YHjiCQHyFDdtLvG1iHI3DV9i9iTnkKyA6CP3d5+?=
 =?us-ascii?Q?Bp3kyuvv1o1/oELfBPDFOfs1ip9FiAwHI9cFjbT+BV+CANEDIJdFbdjoR8eR?=
 =?us-ascii?Q?oc4OYSlsEaAYRybJsfJYfuwFpFRERZED2NqaPQbf+QHMO61d+A7LD3EIVT0v?=
 =?us-ascii?Q?Zm5sOdk70aDGUbQQtrrCSc+kBL+n0Lahhfz2GoD0LAjv0uAK79SE9pLtOy7Y?=
 =?us-ascii?Q?1RNC03A3pBRBn3ckQMN23n3kw1jiycp4P2CPRl1xwScZ6JagM+S8RG7714ne?=
 =?us-ascii?Q?RCS84/IXILjN8SjSbrJkhj1zSBfTwEM8jl0gHBd0ODS9duB6GbJbp4bRFfdy?=
 =?us-ascii?Q?WrPen3hl+anBG05LGT3J5cJKfx6k5wCDq/pkSVfcnJWNjztiliHJY5IJRHa3?=
 =?us-ascii?Q?GPAkQ7GIubYzqm+HSOB9t1WSkc/UKStzyNgpRPNgT3iutVPJ4d0dMUDn8GGr?=
 =?us-ascii?Q?eGecgs+BmKgBvAFaVi9uDEEhm6Sizrdzz9VUO512/ROr0y0ABXQwd/fWTu5Y?=
 =?us-ascii?Q?eCg6MpdhWRrtlWxuqarslAwALvugOrZaCEFB6mv1csooGavVbTFaaxlXJQl2?=
 =?us-ascii?Q?1UFg0dlIfFekswZB9PqLOEXSD1qkZmwMS2H7Ax0/g32928NSot4Z36dPMvIM?=
 =?us-ascii?Q?Krz0+fFCW8KzABSxYWXkpZtvq843ADoIo51RMuM9zsymm4exZbtRlqh7+DMq?=
 =?us-ascii?Q?YnvLnfDLPvSfi9CA3G7lDCNzCoxBVrb8w3hrWNwjSYG9JCSlImD2tKiAkeGz?=
 =?us-ascii?Q?SIAIQtlzqOk7h/u/JI892IHoyhrueeZDt+5fDx+fpyjOdTH0DDsUZSAB2U4y?=
 =?us-ascii?Q?KJoipgm2bztBvUORDNDfeAg4iJ+j2Qzp5kq9IUN/f43Hro71BU1JdVAuf8hm?=
 =?us-ascii?Q?gbodV3K9rPTdGb99u9N7A+FoN3FeyQ0NjNNDaiGQk5A+5LXnkbKUGvDIjI5c?=
 =?us-ascii?Q?LD3ZP8Zhe8cuqFwwutRP5DKYPZpmg2+sy9xKdpl5/laal6o2a8FTN7LNd14r?=
 =?us-ascii?Q?iFE5kGDcRH7a1mmfpIqC+cPEwxj/s9quUt2TKovKMq2eP3nSoysxzffywxg9?=
 =?us-ascii?Q?z7y8aGIXUzEJypt5S4xZGC5Nj5lkiAYWGqdQyT9qY/fh4k1R1Jup9BIdf8Sc?=
 =?us-ascii?Q?6du67guoLFiPBTz+RASSTXoGDyoEGMye4NIsWC1stzIufufcijjZTvR1BOzS?=
 =?us-ascii?Q?TUwPe5bJlfodJHe7JW8bJGnpI3QPJFVWHSbFezDoY3BcEEmoX1t1uPaA0U1Y?=
 =?us-ascii?Q?NYrtEJjc0n8Qi7CWw5SCpyu++CtZfyjbfpzJQRH31kPpdnx2EfcVwavOYcmy?=
 =?us-ascii?Q?KcjCRrc8JqKVEM9Nd/HyAgomhdE5mFBh6+mP0j4Q49moNZNneOVZGVW6zgV/?=
 =?us-ascii?Q?kodmDShKK+IpYWJL1a4Ofj8qlAbCmET/l9volSIv3Lw1TdCV0EobG+A2m1WE?=
 =?us-ascii?Q?I1mcaTOF/F1lnX8uP0qpEn5FBm4OYhYCZo1Ilym8ZD2wwkZFpx8z/5B2V5YB?=
 =?us-ascii?Q?DZqtwH2BJ0HALAYS16FJ4QyzL5Lco5DwXYoleEr2tXSGYkqBaWRMnP3eIIbv?=
 =?us-ascii?Q?zQVU4XoEKQrlvfTk3C8w8yKgsJS6jX3+FLwsJN00UAm5My7CPdaG9m9oKBj2?=
 =?us-ascii?Q?qDqQ1VdLmtZaviaiQF1j4kSdTo22Okys1ZwF0TO3riz0WjVt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96be4fbc-2789-41af-822c-08deb2d76057
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 23:12:03.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpfddT1T0zqAxsbYxuhdRQ7dAf0mFK+ZurQBk6qiUptkoD/Unh+RBiMkKtX+agzF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
X-Rspamd-Queue-Id: 9DA3955941F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20791-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 02:33:23PM -0300, Jason Gunthorpe wrote:
> It was incorrect to place them in uverbs_ioctl because that makes every
> driver depends on ib_uverbs.ko, which is undesired. ib_core_uverbs.c is
> for functions used by alot of drivers that are linked into ib_core
> instead.
> 
> Fixes: 1de9287ece44 ("RDMA: Add ib_copy_validate_udata_in()")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/ib_core_uverbs.c |  87 ++++++++++++++++
>  drivers/infiniband/core/uverbs.h         |  35 +++++++
>  drivers/infiniband/core/uverbs_ioctl.c   | 122 -----------------------
>  3 files changed, 122 insertions(+), 122 deletions(-)

Applied to for-rc

Jason

