Return-Path: <linux-rdma+bounces-17400-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBHJG9rmpWlLHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17400-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:36:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 763FE1DEDEC
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D300C300B517
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14BF47D94F;
	Mon,  2 Mar 2026 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YYS0Ci6q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0647D943
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480194; cv=fail; b=f0CKGvRZf1DMbZNNUNyj63n8eAoRa4l/bcnhAGTjIgHzqPXnn8sdD09nbLenbg3LGu6x8E5sdMzqnzLWJd+qkUkmf4neqZY+R/WK4eGxVHk+d4JsA+HtLgDtHKpkYmVkYEyOkyXWG+a0w573RqMzQs+rSz7gGgXmMfhy7DR2bwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480194; c=relaxed/simple;
	bh=vzrfg2bxVkitaDJZvve/5r1SnPevxaUEaLxy5zkGiU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JXvmoj4vLSWh154HZJzrK0YvHGvDRRsKu8qNv5+S6M8aIUAclep9zLqOa3If+QEYzLqcEb9qIdPGvFHf5zJEvZN8hl5DcKag9hXVa9WnGM4V1jD9KrUJLSwCY2PtKem0bBaztRfxjHTJuPf704PXRhwDWWPrPHBhOoyrMuPwvzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YYS0Ci6q; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXh4R31u+P3SQflYE80W2JuARtRZ2axhc8Z9sep/GaESoO7XZe6MbClJF2/vYUs3r8rqWovnbvKx5ifdv6YmfnWLWY1Ex/jCB/2x7sEzsWr1SWFupWzVpf+utIdW1jjukgcuHnlmFjvNzjuNWPyKXFxWm4Je+e3mLR/Vn2482jXBtmJ1UjEC1xevRGidN4GPRQjdxCsPhTj7EXfcHJeJL/ymhct+I4d96Is1/sKrhrfnxW+1GqO41tn5HISlqcsMVAFfriyI3LZUXy2t2ORcJQtd1VSpWqgwcx65JL3mqcsPIeW9jM5Q+w27Uxzwo/EO8ppe7A0QLnoy968N08ailQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9Ai/c1C3m0Z1Rq9u9FKoRa3I+l4cJUq6kPt1T8FTZE=;
 b=U20UQOMGeJjpm24zIQWoN3LZyQtAhEKGL+VEXgTaYvRBHDkQAKk13Ex0tGOrB7WF3CocrV87J46R+rTLJ1KZeP75PyPZ7vpGg+RB7Aeb4HDjGUhW024bbRloSDBGfzh9sDBF5Wz3waIYglRaPTW7A/WPpIKN8CbyHpFWpLqACW/W+FQTgT3O9QuiXL4qjDYi+HpBwTH4kyz4ms70Nt2lKy2UZnysM8TBQTDYFJjaTXYpTZCTjesFWM4JfuqC4nFqnBj4/6qdIij3FVF3FA4va33G0/voHAUN1KAINNCJQbPF3A5pcTFwxuiDjXIIWWUjQX7+0f3oh1ASSV1MMzNZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9Ai/c1C3m0Z1Rq9u9FKoRa3I+l4cJUq6kPt1T8FTZE=;
 b=YYS0Ci6qEq9CBtIMGtFhEvvCOeJxLTGys0jaHLbX+9O9Ge2InWBRK0r9AC3RURU0GrE3SbAlt6kcgO8bpj5baYxRNp7joto4bfDCaFttTFryp4kXpt907XeIfAHvJzLyY+6ZednT0VczKcddhE8/Iawv6VOQdRBvIsGOQN69s/ToN3xyh5qboR6KvglyOiFyea37sqYPoPfIAVpQiqzw9yHbPkf9uESeum22fdUjOk174zUJrT8inNqxNHo20OLeuZXpOlceA72F8vVrvyl4ECM6iYEZp1Gws6C9mIAvqKfnZh/UfjwVoRPhTzwTHk4rKgBo/htnt/FESjz5rkIhlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Mon, 2 Mar
 2026 19:36:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 19:36:30 +0000
Date: Mon, 2 Mar 2026 15:36:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 02/13] RDMA/core: Add rdma_udata_to_dev()
Message-ID: <20260302193629.GY5933@nvidia.com>
References: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
 <2-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
 <20260302193056.GT12611@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302193056.GT12611@unreal>
X-ClientProxiedBy: MN2PR14CA0015.namprd14.prod.outlook.com
 (2603:10b6:208:23e::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: aa51ab0c-dcda-4e9b-84fa-08de789300e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	T4f2/jEehsQbBPortSo6vAJbgNiiRVK4w21PINuwce75IqzZSnvQ4PVY7uQbycgEFtX/d6GsuHCwAY278/Wgt82YRv/hiyppMZ7EZ1/2F7wqIUzxnIdQVUu07VwL0Wh7bi97S2IeOsO+LEd4v8yviHJKol2TB27Nj/6/4mqPFiCzo26SvkBgosWP4custIBoq98loUl6oPw7tbBXZhLoYxnrhlUhu5B51wTG8GcSvzLF64zDJmX3foVw1jN0TU3ALXqaOcdpMXN+otkQzUu5bPk2KrDGWN4Cb2TnGp2oDIfaNdq48YXduEQFnkK3lc4gw6X1KUarL+ZRPaRYLj05n+67e8160GzVb8wX2qXPuPZ6cGBMlVx0P4xcnjTGAfvNjR36d8rBhvk4RkVp/06bkIaCLLFqfNbyl//F9Qo+OJgtMSU/fBEpcK+CyxNKuLm+CR3i/OzkQm6XvqF4/sanBGOnXBDlvjJYW01Zqd8iNvJnM3xgLiONfFRWWBO9eqKuZ7qk2GSsRb4DsRRdhr2Jx3bqoDcyn35br0Kd1lszLjaVYpZCHv+YfLrqmkGOS+heSqONA+RAqQPQsx604l/LXtM22MLnN7i1nKFbtW3T9gMmJ/8fUKQ18P5tv3EGWmYNDzjDUz+VJoyF8Dc2I/Y4ZZG2+IJKMPCElsYfcW/Wh+kipq9GGxmVVYFIsV1E1x1yGjAVYdJ6n64beGEPCwLeqhShmq+85QNr/R1RMfzFEc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkAJwyECuoXjz3jEPU5y+3aWHmeNViG16JZ5NvGn+qP4vD42p7mURoU2XfKZ?=
 =?us-ascii?Q?2Xxd9CkxL0QrQfPBCBqR7AhcWVdHuylvaGVXTrUrRvT+cFbdnwKC+DZ9Ntbt?=
 =?us-ascii?Q?3kRsGp3SAqSUf6RFVmL8oLoEFlTCSwv/vvgqlKGNaN73JUtRtU8v0cw2Y/Sg?=
 =?us-ascii?Q?+ZwO/TbDfzdhrRKDwQyRRhedkdeRh7W34NBP8cg5mVmpTwlUdo/tdI4ZTASd?=
 =?us-ascii?Q?NgF0cfLgOB48VhEgcmocGotZORjY4tTpFtNX66J3nFhagyFrVWOGoO+EF/Dg?=
 =?us-ascii?Q?czC6OOJBsHQwpMrP3B/rl/Z7KZ0hSYUv8xxE5Df5DxYMQn48M1AqBw08jOwX?=
 =?us-ascii?Q?pMaVCvApVP0/2eR0zBy2+0uBaD5DPHASWbWRBg/8r74zTOQQNLByGxoUcFRx?=
 =?us-ascii?Q?g6eyf1lPpzG5efCqCIXKZGv7VvQUFat0JdGrLg9XzTM3fOneUuGUqn0hYtWj?=
 =?us-ascii?Q?ne2qwANlpCocfTfoOokPrkxM9qgiDGJ8JA2FIHqsy90jbpR+kSnKSKUjaqwN?=
 =?us-ascii?Q?jzJ1n457DDq0otQzpUdx393QsPeS4VZ69N8YVPiHE9XNWiAUrIeC3SmhwAIe?=
 =?us-ascii?Q?glJXSS4fWNszdE/gTh4A5WvaxjDU+0oGMrieG2I90m5pet3wcf9h8DR9X5OX?=
 =?us-ascii?Q?g4wh9MiFs3m/ynA6kEbatzL6WyVis/y+RfqyPfPenrPxqkAUcO1pII11z+CE?=
 =?us-ascii?Q?3fDTzrwiwz4gQxwmA9I6VsfBadta+Iczw0Dm8muYElvNEnN8AyCV8ooMYC8X?=
 =?us-ascii?Q?6T3ncMv7Lzg36lacNy3//3//xf9iWN0dNVTCeF2DtjUy548N5EOAP47eqMQY?=
 =?us-ascii?Q?ptP7ykriDH4i/teSX+3tWVS303i7s7xDgDsetawBFJcbLHr/v3oJPio2Oxs8?=
 =?us-ascii?Q?S/o0I/tGsgYLPz/qttK653LvQfsxiyIoEpypffp9WJYSn5Uek0x8qWuSw090?=
 =?us-ascii?Q?Hri28I8AkVuhoya1XZDGoN3T9Noqu/9lpG/+QaID+nQJOWpwTgPYUAO6vRnu?=
 =?us-ascii?Q?DvZ4APzGoFxsUAm9oVMWs2tHKy/sOGtEFoN+It9ct6GZgV02B5X0+pnb13nP?=
 =?us-ascii?Q?r1G0IR57g38ME+rTgLWj4isnrSJxtwps304RPHIsTD0HikEBUr5dSrPgweCL?=
 =?us-ascii?Q?QxOXfGIG5z5OyifbIOmAurV8pvIZzG8I+O3KnaGnBFq0xXpQdnOCbJWhElAk?=
 =?us-ascii?Q?7pXYolbKSy9tHaNqUidz01B/RHBAsvHJYbMIP2g3WFyOxWd5AkCKRrcoWDEk?=
 =?us-ascii?Q?+tYnucL1JMse1i0O06+I517BWUxVhztR7mKJF10K1m/3JFkry6xq6MnHvpOW?=
 =?us-ascii?Q?Su0Ct27TR65rWYlswkwPLDj3cB4UVCTC4oxGfDFuORNU7Vv8thIQ9cERkEKX?=
 =?us-ascii?Q?giec7xQduMjiFAI8hrxNEPQ/NlLmSK8AETUgKXld1QnFVt1KG0RSBR1dcCyH?=
 =?us-ascii?Q?O82ZsexAGrGx5tzv+JSqlq3pEWLQl1ddbjo5JIpB5/JxB0ZZfW9IbEACP6ZF?=
 =?us-ascii?Q?fPcOwGLVkV825ZLP0nqYApLCEd0zua+lv659TVJK0Gy7S8YZqYfR9MU82oWb?=
 =?us-ascii?Q?bKKJ/3Y5/Gi5pj+PUZRFKwbYRZJvFQQahciVtw7QajvcY0a/FVXnZKh5fiKF?=
 =?us-ascii?Q?TeIz03YsfTb6bOO/9DUQYp6tufkLuL8QoqBM+bWG8THap7gMtTdDIsAS/vHn?=
 =?us-ascii?Q?epm8Iy/B94vVLdKr42Y6mbEAc+xkWSDYrKA2XaCcsDmsQHM827hHjzpHV/dy?=
 =?us-ascii?Q?NHPaLaOqgQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa51ab0c-dcda-4e9b-84fa-08de789300e6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 19:36:30.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diCbP9Pg3k/GFfwCLJaJ2GrI4VEhdJAChIHT7hhavKZ55IGqe1S3T8XUxy9nTQSD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Rspamd-Queue-Id: 763FE1DEDEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17400-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:30:56PM +0200, Leon Romanovsky wrote:

> > +struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
> > +{
> > +	struct uverbs_attr_bundle *bundle =
> > +		rdma_udata_to_uverbs_attr_bundle(udata);
> > +
> > +	lockdep_assert_held(&bundle->ufile->device->disassociate_srcu);
> > +
> > +	if (bundle->context)
> > +		return bundle->context->device;
> > +
> > +	/*
> > +	 * If the context hasn't been created yet use the ufile's dev, but it
> > +	 * might be NULL if we are racing with disassociate.
> > +	 */
> > +	return srcu_dereference(bundle->ufile->device->ib_dev,
> > +				&bundle->ufile->device->disassociate_srcu);
> > +}
> > +EXPORT_SYMBOL(rdma_udata_to_dev);
> 
> Thanks for this function, looks great, however I wonder about use of it
> in debug prints. What about changing:
> 
> +       ibdev_dbg(
> +               rdma_udata_to_dev(udata),
> ...
> 
> to be something
> +       udata_dbg(
> +               udata,
> ....
> 
> Together with keeping this rdma_udata_to_dev() function.

I thought about that, and looked at it, but the entire flow to build
the dbg prints goes through alot of common infrastructure and it
rapidly became a big pain to put the udata through like that.

All drivers should be able to get the dev from their own information
so shouldn't be using the udata version at all.

Thus I'd prefer this since it probably won't be more than these couple
callers from the core code.

Arguably discouraging drivers from using it is a positive.

Jason

