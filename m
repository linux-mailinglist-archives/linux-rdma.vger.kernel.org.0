Return-Path: <linux-rdma+bounces-22031-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B6niEQ1lKGr8DAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22031-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:10:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89184663882
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:10:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=j+A5l1qc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22031-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22031-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03A6E301BF55
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 19:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756EE4C955E;
	Tue,  9 Jun 2026 19:04:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396124C954B
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 19:04:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031888; cv=fail; b=jxBS8yVmk/fG6r+Oe1o+CokVFARajt2d4tv2AAsi9HTGQQ40k+B1E89ypsz81R9hKDxyfcxRKGUm3J3Z7+fEDDkbTpDGVBFumh6FjyxnUYvN++ryOPW4APyfgytv8JJS+VgX00enbTMQUd/eqs9OCXsBmtWIcuNBgXa4DN30Cv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031888; c=relaxed/simple;
	bh=JEHYYO7FTMGv2PoUb/GswVQw7s+hlihW0kqns+Dn96I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TyX8g7oqWD0wKVmOnsM76kYgkfih58WHEZV/XbwCt7+wdhqdmUCp3GKjTfpi6ldXsgGc4mwO2WkyZBfzTv0hK/Tx9yDsK6VVNQHTHY8DGTaaEabggC71giSANXSuQElkufVLA9PUI+emR8A22KiQ5xFGC+eURqrK6rFFyu1FdAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j+A5l1qc; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNoUVk+xstHJQlGTD06JL217WzmwoSaiI+jjWpxV1SSseELDHXxJ4rUvApF9bn0GCXLxujQSUucnU8TJMInyGuI6lMzD/Yrrx60eadAX5qf3r2WHKd5or1R7a2kC2TO7FRkeO2FstiIfmNknWP/GNz+et1ge1XnLQYNx+IAzSRR3jY3dkjHjtvIHsBi65HqcTahSSfjBDGcoiNwqxKpccxhZXawChXTVYf0h9YFWjTkg05IiGgqa6334iLvRjB67KzK1ge5JB7r5VvG5Gnz/uyKGZXx4I8qSZE3nH9oGOzOS+q9Xbrox4yBSGXlAbJ6GgcQyHVVGK9DxzwFQskfj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rVUmizYJ04BrKrp+/DuYP7sbKgabfVEBKupYfV0rNs=;
 b=U3g1sas46W4wVoV37KyD2bjgNVnWa4f2swGaZD2rXfy335KJpq9B6A7UP8+e8eqsUTYAmJvSnHAEGDcdDUZX8utUh/H8KNGKa3Q3GM9UBgyP5i0Y7YU49TnoAaEB2mZWb+gU0yqiXYfZaVpIYnBsdBgfxDPoAX+JrRe7EyMbxTE7EXuEOx5elWB6dbigRunsDAryqE9qByKuV56sWDnLA8dfyIW+BOuMtuStOsIakUNFBf8qh++ZVrxV1HXYjnWUORn0n+z8217w72xeGbnD8t+sWI9lbjX6qQi30HXuTOBnONTRYTDquc1cAxb9tLdefIv9dLLrYHgKFfvagfwzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rVUmizYJ04BrKrp+/DuYP7sbKgabfVEBKupYfV0rNs=;
 b=j+A5l1qcRRrCVwWR26CBDam7b39m/k15zjyL3fgdvPAy5ecQB6pEVpVw9sItdc/JaTBy5/1NyRoQJO7a+XImF5HFBAXVZ8+CEXLUXNNjr2NrO1kM42fOiRseZFuY0rWRLwk0oYY/8MquZv4Q8/2TMPW+UP2yhc5cCKgdEQzqNuoVcfaWDo/ZwaG3vNA50EcCLjNEpg+1/u9F8Lm2vqsgxzI5ujN/SzgOTu0yu7m9n+ulZuNEMfTaCtPzwO49I2ycUdrFV0RrjeSDvS28fmGNPDR0opMtf8kRr+O/tt26aH+KIj7tKVuzaWWbbVrzdHSvzbIvd7V/cR0bfheNgsihdw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 19:04:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 19:04:42 +0000
Date: Tue, 9 Jun 2026 16:04:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tom Sela <tomsela@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Implement the query port speed verb
Message-ID: <20260609190440.GB587646@nvidia.com>
References: <20260608083927.4116-1-tomsela@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608083927.4116-1-tomsela@amazon.com>
X-ClientProxiedBy: YT4PR01CA0321.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c08c454-e906-4941-7df6-08dec659f63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PMh/eH+Giz9OKT40uqVnW0JO4sfAUEcK0FcFzDdALGbelEPATrevlyI4snmQp80ZGmTK6aPvaGuV854kZX2dQLXr1M9x3lEEdVsxFMh19sJfMPWlh1gTWdsM8IWQn3XzFpRp+O3qsRfqs1ZKOOGSqqV/hfyKxWTyBlSXD+HF6KMLG7dpb97WK0snRGSizYebC6O5u15hB1rc6Pk2EMJh3H5ihmmgVREEOCiqjVVWVuUZRQ+QFr3Qx3mMkGnLvoC9xnl2AO0vTDyJ6huCpuLMsMXcywnCYl3y+6B/MEWeIusCgKnXn2cjiyQCluBvOKM7XzUUvea/+dq90K/YXSguMvqnV/xJPtwQCb8kiX1f281Sv6ygBC1iTosSmpXaOEr2zx4LDROubxlfr8Cha8h895hASXQ0Rw7gWOTtqUsTEci7UT5MUc8neT+2tJ6UMtGQuH+mAO7UAdc3QOmSwgFXM0QQLhTg9Q1RAP93YF+M9U7Jp5YVdfUYQfa973m0w6KLeI84l9/u/a4OAu1NxnVANYhnRxIZg+JbQ97+W0/AqzTXJb2wjk5vll1zd0rNbCzRzcsIMFoud9jYfVquhEVxPhpfdMB5zOIKQoYGzwfdJJyOIXCxBtoyUKc1wXlm1v1QXC04p6y2OEw8eT1HPZOSpoKxWsWs3yvfOE4rmBrJM26mOw3QGPIPvVObAXZWHWje
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gpWYt6ycCqfZPtA+H2WAOqEfk4SI6b/ltXCud98b43t5ARzhMj8msstmeJlh?=
 =?us-ascii?Q?dX4bt7ybsewrYmLGFOxpvnWIEQvV6RgUHP5HV235AM5/KHbwtyePBvNIQqxl?=
 =?us-ascii?Q?wlyMihU4st/rk3eALjEOrqXHjmQLbZvUVd9XnTdQ6qGcinVRhybXs0ej/qJc?=
 =?us-ascii?Q?uqUPs7gKURh96Hv7fGIwHWjTVhNdiB7CbGCdhC6IHI+o6leJUJH3t9uKQAHZ?=
 =?us-ascii?Q?Fu48oYXHiNkWZhn6XdOSDQiDS5zJM0BGYz0AT+IzWSWbJ+jREwBPAxvnPwpf?=
 =?us-ascii?Q?Mo4Fb5w2IGiUU0k42+pzcElX3leiGnHQv03HH7WsK1tQZ94xR8W+ysr1w7Ai?=
 =?us-ascii?Q?kn2Mjhw5Z+FZ1DVOgwgqtRFAn2htLLXp029oUf7y5jW4+EIG8CqiwjdxC9Ah?=
 =?us-ascii?Q?zYN2klqthusdhuYKOZjShdMhlao91r2U3QgXPOl4o1867Q2wjK7QHu6U3Myf?=
 =?us-ascii?Q?QHRrMuvP7V6vBBIMmSaJW0oEuHX6SCwSAMbvbNPJjGkdqZnQXnnK/PGO9Ae1?=
 =?us-ascii?Q?BU4KT59lERe9BgSnLWtcS/38rzdJXKXN9qBsws1v5rouwrSs5MA+k9M2ekib?=
 =?us-ascii?Q?vzjkLXcyEjb83B7cd+XsJVnIMsYlZIEnn5Lr7Ng67iMBBhrJtV2JSbJrFT6b?=
 =?us-ascii?Q?nlw1yKvPPZ5yzTAlilwpaka9v+4v7dAozwQVrPUMJvg78yBb7m4rXlKfeHWW?=
 =?us-ascii?Q?aZtqkSsRaRHoR5/6T3UvtY5l3NTra1LPqCSOj6B5b77eP/mR+E2+eZ20v5qC?=
 =?us-ascii?Q?fPVpTJr/qz2P44wdiis3WuqjJDfHRy7Gb4kKFIxh2yv6C6LPLJQ1m2HLoi58?=
 =?us-ascii?Q?WTMzIh3b9zNk5ROQF/mmFDl9+bY3aWL6g/Dfeh8R3n11JElM3VcotIuUxwGQ?=
 =?us-ascii?Q?HWw2/h8tZq3tUaOjMAMWLO71Br70RNnw9n39fLb+N2VvmouMRZ5OrGVR6Ype?=
 =?us-ascii?Q?8x5ajQTioivwrhbG9hbbOYoEplvamRKp4ZWTdIRfMekWfRCdm42xAt5KFubi?=
 =?us-ascii?Q?22vZVhJtP36NTnvBas3VZ0OMuX4HiPqEO0p4Bc53/MAZyRS3KWVkN9GTWXgG?=
 =?us-ascii?Q?vx6F8+mA8oTAq5jDtZxRbbT4PeqkgFxd0xscFUFogvio4H+rxibKno+FOUwg?=
 =?us-ascii?Q?8nS3Q2DELSnr5d+mdLJ9e3ie+mCtDBdll3S7zpbBHINhzElH9bhyqDl+7kra?=
 =?us-ascii?Q?roRb8nIOcpil3Pz02Cv6VmukVhNJeuq5Pk70FsLz1x7OaF9GmppPfe7hHSRQ?=
 =?us-ascii?Q?0TfXUi/RPLu5e6G+cL2i64ux6xcwYZBdaZEs5Tw0cWVm3TULb1FguUOtprhb?=
 =?us-ascii?Q?Jj8FFa/W+WuOq0St9vOl2FEjQfAgqBzzOtvA6+m/yYJ5L8Cubemc3j5yBXNY?=
 =?us-ascii?Q?b8hjQsYlaVHRtK7G3kw+o2AzCTAb6jF06h8ZGfscd5ro7DcJY0Mp8TAI+8U7?=
 =?us-ascii?Q?m74rOBoTQ2nzw2DAdtlt9+AloqD7JxyAuE5/wNMl7msT3MiG+6vkv1ZA9XqA?=
 =?us-ascii?Q?IUyK+JcdLK8EFSpHJWGRLspciezKV83DOwRf2ZXvrS9X/fmmcwR7lCrIKHKC?=
 =?us-ascii?Q?tIqa8vy+3XIHiBhAKYLsHRxnEmk/jPkVeyB+3LULCgPjBY9QMtpO35FtqKT8?=
 =?us-ascii?Q?cSeeSU+GJ6bYND7adjP6jwg5n1fJdLApiDCBuSj9AKx0WrMu1Hg0ox+1OjR0?=
 =?us-ascii?Q?iVJtnGyFwRxULToLATXngX8/V1Jm93xS7VCfZSvpuysfJywy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c08c454-e906-4941-7df6-08dec659f63d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 19:04:42.0327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkS5AVtO4D2GACvEIlcixF52dnlSdKVb3CFDX/uDiVpypzrrfrFeTfHGEbNPXqtz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22031-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tomsela@amazon.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89184663882

On Mon, Jun 08, 2026 at 08:39:27AM +0000, Tom Sela wrote:
> Implement the query port speed callback to report the port effective
> bandwidth directly in 100 Mb/s granularity.
> 
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Tom Sela <tomsela@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa.h         |  1 +
>  drivers/infiniband/hw/efa/efa_com_cmd.c |  4 ++++
>  drivers/infiniband/hw/efa/efa_main.c    |  1 +
>  drivers/infiniband/hw/efa/efa_verbs.c   | 13 ++++++++++---
>  4 files changed, 16 insertions(+), 3 

Applied to for-next thanks

Jason

