Return-Path: <linux-rdma+bounces-22139-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q4HfH1cIK2qk1gMAu9opvQ
	(envelope-from <linux-rdma+bounces-22139-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:11:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB9674ADF
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:11:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=HOko3nrc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22139-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22139-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFFB73124C1E
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412033E0C53;
	Thu, 11 Jun 2026 19:11:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45492DA74C;
	Thu, 11 Jun 2026 19:11:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205072; cv=fail; b=l3TdNv7vLeGRUYkezkLxgU8gO89J4IOSJL9ycIymXx1n57DLRMUhM5zCDhIdhMPAmyhKTRqr3DgAq53Q3vMwOqPdl6s7hrBauriv5ttdIeS9uwL570aPuZ+6NSJUVZQu4dPF0SOZPPRBTNTWdvIZckS8UJY7cuYlisB49Fwg02k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205072; c=relaxed/simple;
	bh=Wq8j5TVWdkfPJgQt1V+DS5tBo3ppO2LZamQLN8zgB6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gxsAFkuaXuiH2YQrwa80XTBrIrr5pauY/DeDU8p5fKCvf+uqMzzYtNxXaqLcEaozIIg4w2CpG5f89rEXI6cSD+ojjBjbLrar54YJkm2QC1HpjADUB+cK+jNY0Yy/jW4X6c5xB39PjgCpT/XxUQwOQfTy/XxURvwbXn/03JQh7V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HOko3nrc; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPZenrOiHb+PaQVVyA18ZTng5aEiF1j5FtweTbAB+M0Wgcgsr+reCMgAojbcIq6SRdahEummpN4R2TGPHNssk/OeiRtAETsvcF2hFkA6keEMD/lchPwXa22J2tIeD0S6pyeMPYH/6YMFPES/3egjIB0guS6XIKHegmRJw1ZAy01BvOQ6XF5t270BEs4tUl7az6JJ5/Di8KXPjAxYKlBB0OUa7YUN0t5NGebeXa2UJZWkUAabKAVgjCDeb9LFUv2s9HDLgrStc9953n+MvGX5fzRXkCr+HqpTEeGKHTQQTm5LWOQ0nOCyEpgTuvq8B+ldxbf3Ei8yQivwWTrAwgzSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JokvTeSiZJzEtg/moMnX4J78G+wq6qWrON40QU9p/j8=;
 b=pBvZpl+k3MbNy9l4Siq3D5uliIu1GTBN2YybEavptrT8Q8aKkqRlFAlXO7zcIKoDMAgJFQCM5RxIDgHa7FgMSKWnrTbpYf9o4xmiGxXXLuXkVU9PsOHOSVpeG5+ZL5OXisz1m1rxrWsllWT4COyA69Eijq4P4zks3PxgUHx8eS7BswaS7FAy7z1h4+2QgcO0lCw7Zmh7FGg4bVy9/xZk3yETOCQusIlNpUz1WIvOU/C0MRPRt1m3S6y/P7OrYFfcw9CdSSRbZERONCLOj8RtY3RTdgBzYieW7iyEyrnruu8gGO1rTHZEuRBoPjdnys36OLt1ImcuqjcNLf4jwpYV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JokvTeSiZJzEtg/moMnX4J78G+wq6qWrON40QU9p/j8=;
 b=HOko3nrcyidX1nvbr6BQOl/LkLZjiF7b+1OZXbMiqHw16YznGNMtsi+IEOBouqVpZ2RKENyTxrZfgRL6o3+ysZqxW05hFrDNFSiIqlk2INoV4qgaw3UXeFlP80U0rqVeOTr1gCDbliiic4kSO3YnMWIcy4c7pZT4La/phqg1amTXry7NRCY7xrJUfrTAa0rV8Tq4/5xjBoJ9AlDZvcgUv+IItAPnCMZkg9VqhtTUvk658v1fyiX7ZLH9W+xKYoAeZ+ofX+aZWAkt++D1Ej+tb1r1Imkjow+1oIxrT2d1MoYpXMyw01fYcLXrds18DICUQdgGm4Wo8h50avuYJbyMfw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 19:11:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 19:11:06 +0000
Date: Thu, 11 Jun 2026 16:11:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maor Gottlieb <maorg@mellanox.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <galpress@amazon.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Mark Bloch <markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>,
	Neta Ostrovsky <netao@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 0/6] RDMA: Fix restrack UAF in QP/CQ/SRQ destroy
Message-ID: <20260611191104.GA1501742@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 34584aae-359b-4d96-e2e6-08dec7ed2fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zKOZ3c5+o4l5FU/Pf6GitHFt6b6hJY+v+Qzy6CIEWjmWgLOKWIupIeR3Yc79l3K+AHXukqePiOh582QIPOJbUubpdemM01gr/mefoprl6FTEVPp/l/SUUslUV76o/Ic4bGV+6UJoo223wSEc1sfQ+ogvSZfuUtWogMnpoyj/4z/45XpcpUffzPJ7KyJIYlCxwLfKJ6EDOtMKil/io5xeSCRiPTC4koJOi6BQrthEaSJ5O4jSpPOV58rJdRxZjmXX+tnDWzQPWJ8Ox66vGmjb/KH8Gct/NBlg5lZJ6geCyqlsMSaDt2iS7AVMA9gRUKFdJ6WofU62etRzgzoRLfrn94B35h/1sp9gPBb9sfR+lvk3RLPn6ElSg66GjFtEi90K9zsIcJSmn7nlYOJRgNBZIwUqY/uGuKBfrASizM8fgP3bGb4UQj7GoPw/psg+OmycwGzPUCzwOTglPnXGkPgOQGZs3WkJpKLJedCKPIQ0YZQXF0G6/7bR3QTESc1k49MD+frT/tS+wEiqYtOhguuZPq3NeD31eq2kdKmPtw0Hn0pnliZTBL4art2HtUogpJDtCcK/eVzx0V+HhKeAKp4SiDZAA3qsyTHHHfnCgnqTzuCRh+/wIRjVvDSCMA4Vgphu5nOHadcAx24kZWL2DAPy7S6PrcpomdlqHw7VbC0epIYUivF0niRlSSnx+TXPdatU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u2tQte1Ase3rd0Cg8DwzZlvKzAduOQXt70PMszSpE0gcYLa2eAJBieyaStWi?=
 =?us-ascii?Q?t7oAJp4hCHsfMrzEUfktBmFbJnfiqu1uR333VDNZzWRtHztyBt3xXX/0iqUZ?=
 =?us-ascii?Q?/QeAA0ZoG4XCw79sUn1SvgOx2y3oDRgGkq1U9axAapYtAaJMFyg0NQ1xOCpx?=
 =?us-ascii?Q?ghM5ExYvWnQvOX+RzTSNZzWeha0iLjM/2svgEADB6fvhRjiow4NuwX/6Z7xi?=
 =?us-ascii?Q?BoxaWQ1tfMckdyiGkCg+Ua4GjyaV9vVRlUYVe6ZssYJfqDEof103jgkZABeZ?=
 =?us-ascii?Q?Igdj0KwgRP0Yf1KwUbzUF6s456Jks29jTg1KYdc50n2OUFQjQGxcCQYF/GOp?=
 =?us-ascii?Q?KtQS2v2JZMOUoU0QqZe6pWmbR4vnUfx5XbK4zv3GMvBurY1eLtcZzZix5n5z?=
 =?us-ascii?Q?vx4DCA8MGif5e+YOxhOhXmiduq+7aGcX2aipKgo151T4DL3unzvHwLFTou4T?=
 =?us-ascii?Q?1j7vVTCvzTBYm+ghUGkQLxHsKRKLPUeVCOaAjj7LAMI6rnjp7KApoaodbTaZ?=
 =?us-ascii?Q?ih/WaJnGlu2GICFmyTMbKZ9xIUirBd9Kpf+Pq1upJ61nkFMkgNbr3bQ0AUgw?=
 =?us-ascii?Q?kjd5G4BqJsT1+Ns6dlrGpEJm8tlEFZ2GVrnyjaA9omCb9BBHOAXD8fQslsvg?=
 =?us-ascii?Q?a6OZAxv3Wl04e5/nty2JgElvmxzvbODvgGswyA1rtU3La36wf524igksqhR9?=
 =?us-ascii?Q?pmKBpUV0etDBVRaRMAqa5alioDMopbsnYG+lktTwQg1YrYpXaafVvRad4ycM?=
 =?us-ascii?Q?tlFUY4g4xtf2wKJtIk0txBV30o25oFoOYrLsHo4cr41X+zF347M63uSheUuE?=
 =?us-ascii?Q?dOaUtxC2KjY0NVUfOx2k027T6JgMVoQbakkAJ97hYbnlNhR8Gbl7pmkEulJu?=
 =?us-ascii?Q?sABjXT4/16jczGpdMNpheUt18sCZBG3igDHEOrNN2NMnSPQVXK5r+zyvNCim?=
 =?us-ascii?Q?j2msWAk2JoYlh3EYS7QZ6NgbWv8AildtiWfYKpOhWQwZbklYzuy/KfLx3ql0?=
 =?us-ascii?Q?c2LSLQ9FKdSJ7iubseKrOnHfF0T4AUfymEo8p+hZssU1Q0J2cpgBt0ULNCO5?=
 =?us-ascii?Q?r9yR5UE5WTI26N7VzWh9yAM8oHjtO8216VF25jZD/zLOlbshrtbj2EW7HeNR?=
 =?us-ascii?Q?gqcfptwkNRXmoaaVvlbhTEwbebnKpDM2zMvLuqwDkodXA1I1LRd91+KYijNv?=
 =?us-ascii?Q?Ms+Drbr9bqWiJS5ytdP65lz9i2G5W0RuJpuCm0qoW5uQtB0MXBIljuUNecxu?=
 =?us-ascii?Q?cR8wuZFshFk8JLoVQMrny/Y7aueDpV8Cw5iKE+IkNSzuvxTZ0lD0KPx6X4Tw?=
 =?us-ascii?Q?fm3EI4EYU2QZqIphj9MpQ5aKCVSVedurCIw63Mqf42vmHwUKcvR4A/s3z/i6?=
 =?us-ascii?Q?/GK10HuAumdqKHIaVMl4G18aZSyjgevXtrtC3F9hCtDm+i263j7JiJDWe+oE?=
 =?us-ascii?Q?IAlATX51Za8wJe7MUPAMOqEOyGyIg+wwj1klovhmTVgvmbDWDv2cWnYzDUXK?=
 =?us-ascii?Q?f+15UuAgStlm4FnyWQtoaGuwtsIwNVaBqzxaHFcMtUPB1+yve0aapEIv0G21?=
 =?us-ascii?Q?HCwblrlrAswHNJMtMyPfbQ57CGtRyKoTrBIXCimVFcpPsbDvZciLNiUBh0q2?=
 =?us-ascii?Q?9r8BfHWWBD9cexF9JhYq5rSK6BaA9qhEM4Vv+ZaUQ4g5BEp0uS1JrHHGIGLb?=
 =?us-ascii?Q?M/R1KQQhoznGeYs12160kPgkQ30DaJh//H26wBTJnJWqcyyB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34584aae-359b-4d96-e2e6-08dec7ed2fd9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:11:05.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAi50ncs6cMWHw1rAG90XicWzV6a8Jk1NGk3nMoVBEXF7agl/iyLV4L+Ra/Cq1u9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22139-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edwards@nvidia.com,m:leon@kernel.org,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7CB9674ADF

On Sun, Jun 07, 2026 at 09:18:07PM +0300, Edward Srouji wrote:
> The resource-tracking (restrack) database is the back-end for the netlink
> "rdma resource show" interface which pins objects with
> rdma_restrack_get().
> The QP/CQ/SRQ destroy flows call rdma_restrack_del() at the end of
> ib_destroy_*_user(), after device->ops.destroy_*() had already freed the 
> vendor object. Therefore, a concurrent netlink dump could look the
> object up and touch freed memory, causing a use-after-free via
> ib_query_qp() for instance.
> 
> Fix this by splitting the delete into a begin/commit/abort sequence:
> begin_del() parks the entry as XA_ZERO_ENTRY (so lookups return NULL),
> drops the birth reference and waits for in-flight readers to drain,
> while keeping the index reserved. The destroy paths run begin_del()
> first, then commit_del() on success or abort_del() on error.
> abort_del() re-inserts into the reserved slot, so it needs no allocation
> and cannot fail.
> 
> The first two patches remove DCT and raw RSS QP restrack tracking as
> they have never worked (their ID is unset/reserved at create time).
> 
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
> Patrisious Haddad (6):
>       RDMA/mlx5: Remove DCT restrack tracking
>       RDMA/mlx5: Remove raw RSS QP restrack tracking
>       RDMA/core: Add rdma_restrack_begin/abort/commit_del() operations
>       RDMA/core: Fix use after free in ib_query_qp()
>       RDMA/core: Fix potential use after free in ib_destroy_cq_user()
>       RDMA/core: Fix potential use after free in ib_destroy_srq_user()

The pre-existing sashiko issues look real too, can you fix them also:

https://sashiko.dev/#/patchset/20260607-restrack-uaf-fix-v1-0-d72e45eb76c2%40nvidia.com

The sashiko notes about XA_ZERO_ENTRY seems to be really obviously
wrong:

void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
			void *old, void *entry, gfp_t gfp)
{
	return xa_zero_to_null(__xa_cmpxchg_raw(xa, index, old, entry, gfp));
}
EXPORT_SYMBOL(__xa_cmpxchg);

This looks legit:

For instance, in drivers/infiniband/core/cq.c:ib_free_cq():
    ret = cq->device->ops.destroy_cq(cq, NULL);
    WARN_ONCE(ret, "Destroy of kernel CQ shouldn't fail");
    rdma_restrack_del(&cq->res);

and so on

Please send a series switching more/all places to commit/abort,
probably there should be very few/no calls to a naked del left.

This doesn't apply on top of the restrack_sync addition, please rebase
it.

You should probably be refactoring rdma_restrack_sync() and using its
parts in this implementation since it does the same things.

I don't think this should NULL the task on abort either, it doesn't
seem necessary.

Jason

