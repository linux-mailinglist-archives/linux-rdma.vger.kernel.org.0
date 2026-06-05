Return-Path: <linux-rdma+bounces-21859-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +kvmKzgII2pVgwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21859-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:32:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390664A304
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=YDxwKXVn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21859-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21859-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84EEC302514D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C0333557D;
	Fri,  5 Jun 2026 17:26:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315633B97D
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 17:26:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680410; cv=fail; b=KyQ8FkEoQ+zJniyE2+ayLjDtNwsZIfo/ZYtcj0VnvVYl/8N/gLrlZ2DtkojKDddKM8NrMt5XsiyGrE7QsCdA6tDzRjR9eieHIB+LMSXJ4SuJqh9/0AJEpar+v6FdHTre9rpZZgm6sWYC+dQDyRWxw+heItgVoDDt78JraqoCJvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680410; c=relaxed/simple;
	bh=paemBiGak7luSlfW4a0JXO9iqK7gsPp4/pW4/QzuAUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HJQKymbJIoB38ycWt7JcVsXDE24otqLenaT037CHP7GxJMClU7sxTqC+/2NvpsHKcBJjICbskwSLgAKOmrVGb1v6oL3b81pr+7LliLoVK7frR9C5ponJkZrv1f7OhFuft79y/VmWuOzMSuQz5vQGeed0wBav1aAFeXqg0Tn+dog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YDxwKXVn; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEbNWtwZT6KK94lrMXO6E5JXrYLkJL+PSG+kpwQOyYJkyGynYjt4LdCHHBgltcbnsKwurXafIAOfDoJpgtyNraG1v2q3WeyuRWAiQlaClr3yqJIBxrWJM7lGCq/9DjoYVJoRjhDuCXWAvgcPwo5qgLa2IJCAqhxIb1de29jynnL6oznYCKGRygD73cWoQ28X73uxLDOgz3FDmrKipIbFtNKMte9PzEZsR4Z7oN5p1J8CmjbbA1uiSWytZEO38rMNT6W5jDK62vpz61ieLWxBLlX+J0w8OTzQN/n3jblhTgMN7beoNzPFiT8wT8PimxG1wDOMSjMIiVJ7cfZJwbxY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAoIPQHcSulHx2vlCr7RVoOK4u7URZGju1qgVi1Kues=;
 b=ArezJIRTQB4O7z1YeQPsf6/Xi3YeRTu9vYt+fR3GZ3aeQdGakyBxypeOopr8Y0Q81ns6epyB3OiIrxNKN1UQ7CMl/XD1FR8UBEZyBBN6pgz8j+Huhh/0DfeFHCgW2jD9BEuh3VKAMmaA3sHuSq68BqNHQ6HF29cnttgQhUaW3JihTTYQE1ZErx/D0mWizX7DK8TXemPtP6IM8v5NF3NPPiWwooIl7jcQnSjRqi/oTO1K4f7Rhri05yCEheOOGaomwiRZMdt4Z5wC/vUfXWoQDWKSKXhaXOFpOid6SX3bA9VMNR2GCMv9S+OO56pVBMDC61x8tLHRMbIBUd6540OeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAoIPQHcSulHx2vlCr7RVoOK4u7URZGju1qgVi1Kues=;
 b=YDxwKXVndVknsJn8Vktm8ZsYOQyn976xawLaWpjRFAA1scAhlK4TLyT1gjDYrwFTBBkMBfCra52I9xkuHhKuPzrsSgBxc3vpTdHKFlzlZohDK0jUNkOVSP+zir1iAg6QUt7s6+nT0KkfdG+Y/L+3cIam0NNOFCJ9jroOikWyxul/o0xtkgL42kEToAmqi3w2JQ6FEiD2rwsJTw3WHIokw/3DQZOdTL6V8UMS3pL2ibyFzeOfU75PtYArU7RWsuhFSOx9x3ITKqsbgKx1IcRcqi0QfuROYtwrtro9MIdzlsiEXBMBawdlzAid5yrZbq7yzkCWw1Imsm1PuojvD6bDxw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 17:26:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:26:44 +0000
Date: Fri, 5 Jun 2026 14:26:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: bernard.metzler@linux.dev
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: Re: [PATCH] RDMA/siw: Fix endpoint/socket association handling.
Message-ID: <20260605172643.GA2785196@nvidia.com>
References: <20260604160808.30948-1-bernard.metzler@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604160808.30948-1-bernard.metzler@linux.dev>
X-ClientProxiedBy: BN9P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b23e87-db43-454a-6811-08dec3279d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LRmsmZTYFuG4TKnwA9c83AyvUUvl47F3prP06UF5lE1WK/fRC0buRBcmnO4iJQ6lXd9ae40M1FSAJY4nbdBcd7Fb2w9T2QlS4kfc7EJpNX6/NNOnCMlKX1lnKTScRu4oyLDRVKJYhp7BxiSeD+GGHWlbnmrFUg/jqgwNu+sRdGM1MQW/Bgj4H+xSRDHNst8KAEYflCPAmxI9DvlJaH7/yG1DkMKSDj4CivQnpzmdfXySfxF07zl0NI4RmZROZ9c7Vwz000DPVHFD/xpaDBWQDnlgA+OzLLwW76RwSdvL+4hW7Bj22TR42PCo37CKOgKad/fhYGLOZaNEw6/gGKcjfLe2bnPyYqRqkAncdD4scS3QaMFR1bQeom/f5XmhZrIrKcQh6nNC+w3F+grcGvAT3W1KFsHINYdK68qJ7yEzqSuCrD+CEzxvTgibEjtiV93D/pW3tuvKmZJRMuxp1UU0lx5/LjET2L4gXs0szaqqXLkJKh7Y98bE7DuHfG2wUyXlx8Ov958fJPjgyOg8I0w7lNGYRcztr74qYP+Srf+II6e7UTd4XR5CGEmiQYMXSWMB8OhRIMFepRfCSPmTibYxvqUfmNEJ/Q2AZOLWh5FfM0Jm0qRwbKM0Xb/hlbFuTPuateP6onSK2L9ksWduT2IF8rFweXQbnF+gVjHBGbWxsLI8zcKnzNn8gciT/7DieYbv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CGAYXF4W/huHcsh6r1s5qCmmTPNzjzajcONSyoMwcfi+RcChPY3vkbZUvLDj?=
 =?us-ascii?Q?CCv0o3X2BLDDQwTxAUIWLH/8yV5+DV7gHulsamcPHm7hjUjK5cAOZDMelBfI?=
 =?us-ascii?Q?SSnYqRTxZvMAkehcCPDI6+6lOsg1Q2yYMNyAhgMVMm8pegPeDevWa/PNiagv?=
 =?us-ascii?Q?ZjQjbNO+Dg+2H+CLG+vZR7/MilbS2DLsaXglqcA4lxhtaqYozioOwL8EMVE7?=
 =?us-ascii?Q?PlHwjns7IUtyZ+dMnKcNTHkmabG1AqXhE/1UZLoMVwHVbGZFWRSdcP3Yd/aE?=
 =?us-ascii?Q?id2NHUs4NquFq+0RXLG4Cc/P1R8/am/EoBSguBuFCCopvvcVJ8Pvs/06KOy8?=
 =?us-ascii?Q?UtivKNDNKR5A4ls59RfHY44SWGOYnkBB/RIwF2RbhkfGls4zqyyNWiDNcTRg?=
 =?us-ascii?Q?UXGMGL6pRMgJMz3NMmyqhg7cy33O9eDFMQ4H0FlgZo0YBDb/FJtuoLh6PoUI?=
 =?us-ascii?Q?8tyP0ndkUfCLC6sB1zHrYbfvKYpy43jFFmU6aJhMnav0dM4OR9bDvtat5jO6?=
 =?us-ascii?Q?t4fzDm+1ws1dut8HG4HMg/NKxDQXPk3hmHCvIMxLeDPS7IsfC+ktrZKJYcM/?=
 =?us-ascii?Q?biAi9xAaBaAvSg0lhkXAaQxVTaITTHBmEulbFPkKwHQydZ1zVOA4trBV2tmH?=
 =?us-ascii?Q?jx/K0RNJe6JyCEsUEpyX277rskdefOBKtjMc5u/T0ibpElYg5kDw8UN8QIG8?=
 =?us-ascii?Q?5K/YkSbBHSBVFvYyLVQILL9iypD2rXNWmITEc+BVlBSG4t0wBeV/TPJBjJ5T?=
 =?us-ascii?Q?CdrCzPYpMHU22Meggtuc77Y1+zn31LwNlzqyqtya0CZBG6RBPgOLquuhrkRg?=
 =?us-ascii?Q?+Tguc/dfORfAieDez+8kfP1DCnaRhFSMa274O0cK1qYj68saxXwaqlQvJDA7?=
 =?us-ascii?Q?5Nq2TPNEbhkPwNsqT7NNYR1wz/CGRRaaeVmH3t0uKppaaniHbONGKC2H5jUP?=
 =?us-ascii?Q?6ccJa8tuY6+MfNxBV/5buLb1UGs9tqYgML3LPHex5PjoAvEEqIoHQ+k1ju30?=
 =?us-ascii?Q?Nh4MfUzFWVi8KzO6lbX6B8PFmBO1eTs61jgHJM5KR3bEcviGdonDIbisEHzp?=
 =?us-ascii?Q?8vqL3mkgmh6cxAlPaKnjKC4QUZ3LzDairQWVgKswNlGacM5oHsDzHbAdu+nE?=
 =?us-ascii?Q?0Q9TVcsbv8F5+SJbhnXui/XyNl2jLvZZb2sSY5jzUkVwhf9ixQ/II6HvV1ug?=
 =?us-ascii?Q?G1wfbXHYHKkDUtLnPd5cCeP4gl4Pzs/IRaz+u+i2QO9YfiRo2WZ17/4a+X81?=
 =?us-ascii?Q?SrhVZQ+AajhCDYfEXTaAncSx1lv2RIf1BxkGfDRqeuwTKoFtv9Ez6Nbsn0C5?=
 =?us-ascii?Q?kFc/9NS3lLnFvZUC34WTmy/rqCoi0b1AEZx7EnwuPen0kazfNcmZsRmXxPal?=
 =?us-ascii?Q?YY5/NG22hpLK3GHUJ4nlhsZuoBLuG5JTIE2ozLkHOC4MyjT8AxjYSLAS75F7?=
 =?us-ascii?Q?XhRF80bky3wurjOdEEnXB84ysfqOPz+D9LGWTTEDHG+j5dHsyvi8mUH2AqNr?=
 =?us-ascii?Q?T1CQ1ylzW/ab78UmrXh7ElRufHx5GLgZuFZhUXq+pINC7ZBvZkKiSbV9la94?=
 =?us-ascii?Q?FNNKUKrtvDvXRgtGnUST2cirW3omBfIWBkosP/AbKojH3H8ZZgAWXTD1NnVJ?=
 =?us-ascii?Q?dvoxtF+NbvlpJq0705R7ujJTxyvQOoNyU1+TU/fmCoHPPJCr+FYgwEASxIG7?=
 =?us-ascii?Q?yeY3CEwXCjKr4dTJJurcR7aZwOqNJFg+5c3YZo18Og7if+vc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b23e87-db43-454a-6811-08dec3279d24
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:26:44.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLxZSGvO9qE2wMWezc2xCSArebdFZkh2qdJpTbcr8JiHLZlnUCrBdGdtU31ETO4t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21859-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bernard.metzler@linux.dev,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:shuangpeng.kernel@gmail.com,m:shuangpengkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:email,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4390664A304

On Thu, Jun 04, 2026 at 06:08:08PM +0200, bernard.metzler@linux.dev wrote:
> From: Bernard Metzler <bernard.metzler@linux.dev>
> 
> Disassociating a socket from an endpoint via
> siw_socket_disassoc() may release the last reference on that
> endpoint and free it. Therefore, don't clear the endpoints
> socket pointer after calling that function, but within.
> 
> This fixes a
> 
> BUG: KASAN: slab-use-after-free in siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:1053 drivers/infiniband/sw/siw/siw_cm.c:1075)
> 
> which occurred after processing a malformed MPA request
> during connection establishment, causing the new endpoint
> to be closed.
> 
> Fixes: 6c52fdc244b5c ("rdma/siw: connection management")
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Applied to for-next, thanks

Jason

