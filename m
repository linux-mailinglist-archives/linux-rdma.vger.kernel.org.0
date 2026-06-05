Return-Path: <linux-rdma+bounces-21840-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wKKuKD/2Imo+fwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21840-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:15:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E87649ABF
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:15:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="nY7YDz/G";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21840-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21840-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B448B301CFB6
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA27F3EA942;
	Fri,  5 Jun 2026 16:08:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510D3E8695
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 16:08:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675687; cv=fail; b=GZOXuYJXA172bbC313AoOVwOpM2mJYcxdAecuQIRvBhhqlVSwK/4VspyjlZj8W8LZKVjbBWGF3zwG6DHgUFtDoAkVRcpFZuDSAlwPX54ZZqjZVZ5XdzH1JxeI+x3z4hPYbAFKUENs6lx6QxLDdZ9UCuEekwH53YoRcVybHsRyhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675687; c=relaxed/simple;
	bh=pDDCxx1hBaXvLf1NWh2KUXoaEIWToSCsQZrAlmQK3eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PMBB7XwvoEuFaUKuChJsD+Ys7y4g2v2p3xNq9XNbnNbRmMyzcrFwrbMgXyQmzadSiqnQjIkk+4CjlYwDmgR1fEkAXC/J93UWLw3gldkwkJvI1ayDRet/5a3jxvQ5nqZlXUt5dcnC7/Ztn03bvZfpM+Ctn7Anhj66w+5Snm8Y/pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nY7YDz/G; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn2wBczbKYEjVCFc4KY1knlGD7e7dNniISCWWin4u3jWVBQtWPJ0VEsZ7nfvQClqFRqLhYEW1CMlgvvHr1+2vuI6XgYmUe2V87OIJqwIrMZP7Yu7wAIB7kC7uetRKYinXWC2a/+n3yM7QeCsjhrYudygr+0YcvwBY/g+51I+Yupbk7eDwckn9MpBGgP/tytTrOP7Bynf7Je+W29ou2txmUjWlpW2JfimO6w8ci+IFpXcQtjS8QJHNZ82W9uiq65FDlGhAeA8Fy7IzCHMWPLttKJBAtizcf1fS2Qm2Jj5GCFMlGoP51vFBqHDTkA/yfURvqceXD3UThN5U8F7UB8t8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyXwD3rfHb/4szf0xyCc7uWEoDdnpge0uX2Z26iPpdY=;
 b=qHWvWFanOwrKzhbP7ZFp4mVlgWQCYoU+t+RPWPL/kvoUFOvq85gvK9orGuYHvQ1iz5BrLrN1tOpspG6ylUfwP/pIr6AIakx97LcHgb9Ky2O+iwjOMJRcBemk2zuaQbVGFZ/LblOjFxxpsPebNyejrtHu3rpYGshTitxPlahgwQG9tNR4oAPBeToX6Bpf+pD0DsfRsEEqhXb5jnWlINwuUIKJ1rOSVbwEK2gnMdhlaZpdC4ARHg5Q2+YQX2pUq6nG0O1RtwexTEnPqcH+iYWZ6kSPqT0XiapzuEne7CEHCYFjBJIDh/f6Wj+pla3MNNKNlX3n8ftXEbphArANg2AdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyXwD3rfHb/4szf0xyCc7uWEoDdnpge0uX2Z26iPpdY=;
 b=nY7YDz/GFfAd0GPU6RKNQSYGlkI0xY+TSjNpdBJKTpAa1dn7olr7NgJ/R0u5dPlokaN5q4vgIjy+Sjjyc/NOp1SBS87Niwqimbk8OZsXPF+YiRLQJWGaH6/e153OwQMhyQB4AeigXR1bhtz+Ps24oU3IkdmAZ/ONq9YiixWWKnLaASGcrzqSM+5RZVBCJ/PJh1wKHvxzUjgSnuG7NVJvYMIicvOxGaFfUuj6ayNv/+6tLSnaPQsBJmTmlXMhaAAr3dF5UjXsko1exmBX9h2smaIm2hJQXhL3PzvuMmL3l6i+2iHVRPZ4tssx3hIqv/vHfkDX8moEQ2UkhX5OiRVwzw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 16:07:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:07:54 +0000
Date: Fri, 5 Jun 2026 13:07:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH] IB/cm: Fix av cm device leak on an error path in
 cm_init_av_by_path()
Message-ID: <20260605160753.GA2727797@nvidia.com>
References: <0-v1-38292501f539+14f-ib_cm_av_leak_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-38292501f539+14f-ib_cm_av_leak_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d61a30-0abd-43e7-5f14-08dec31c99c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rfDluq/EW/oGwj7cMW6OmGhchqKFA2mN6Ni53hT3elVQRMjPDbm1Cxh+I1SfiYZliaikkDxo9oGYSksW4NYsznx/XalZeTyhSUdfvoDFPbYn9t+7p+tzHSqVQfBeZue6WLqpSONeHZQHznRlbVMPahqQqATzx6mi+u9miwGf1xfzZIs9U+qF5ee1n+ov4i7/oP4yx9wtQTzMPiFEuwoO+dnxOmmfD8PD5ofvU35XFQ3Imlm99AYj4q/Tgur/7vmcTc9bJkkxEGR2kRpsdzKx43SIBHpnkdUeJXfCdGge0AWRQVsnomXILz1+ub4lJy7w+r26ie3rNeGd+u5ukA43g8zd/e/5T7VIPWvDdVmo1fERgVgs810lCKqkjW2+nG/gIKdslqc6cgujKVTNo/BkhpI30ARnskmo1I85/KDREPEZARA12yd+0obDiXnXetA4cH8yXPaGXo/zUMpHQRyc9sYv+spaeNPsIGjMsekR4BkHbyHbAZ8VRHMocENxe+P2rkUxqct/2ugD+En87GDgI1j931c4MYmGJF9pRdJ2gUWGGPhFLklzI8ZhI3d9nn9fDbY/1jsibjQ537BObZlCeKw/5jM0oQwiGKC1ILN+dYaM14+P5V8OufyYRwxLKLbU+6C/Fovweyf/DQZ+lghumlrzFqC9PzbhChVekRPfwAURGGfenzVjcAxf2rdNOoZa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPEBAQ9gF1nQBwLic5Ko56bhLgfY7v73tEXTxcLE1k5ZkEIdoNkaH5UrUNY1?=
 =?us-ascii?Q?DIYyPlGH43loFQ5S5HG7BTEX2KwHVCUMv1znZA7cIxn8i1fylrfYTthh+Jio?=
 =?us-ascii?Q?v8RL4CM+HIdsOC4hLYN79P5EVHY/j6DVinXdJ3rpEtUO86U2a4T5ayG588p3?=
 =?us-ascii?Q?5XYnqohH2wADP2wbEawrm6L9gygRlqMPConw18LPBgU64XBlq/K0n+5fjpMT?=
 =?us-ascii?Q?tUSz17AFeH7YCeTNlBH3OnbMzoyMFkBd7fIjz9eb5YHKwbx7uWxZn9zcbQXB?=
 =?us-ascii?Q?+6ckZas60o3qBrjccDjMsDRmgZyvEJFFhyFFAJ6rpguAKqlI1tsmMM2pgp0t?=
 =?us-ascii?Q?TOT3W/kmaQMM+ogSTevw2gN2Q1v/DKEQy2ZJvrmUqSj85u5gwQ34hTD/kThF?=
 =?us-ascii?Q?+Libr8wpuq6mJEijE1vcq0p1UxGU6fq67II+wJlv7owNxaeHsOXjBtShq+si?=
 =?us-ascii?Q?LmSRQyrzcFwcI7VNy4d9SiX/h0KkXZWGTw28+waqNSkWk5ztQrU5pIetmbxn?=
 =?us-ascii?Q?huXnOA6WjiyjaQeuBybSQT+YQvXTBW07SAOgb+kh76XKmptPFdeszeTG+lwB?=
 =?us-ascii?Q?qUaP5t5FuA4ws/aKL/TzpIQqSuCVP92EKVHhqkWfawsb+Dt/wHFjCFswSI66?=
 =?us-ascii?Q?CMhKBBrM8adHRyl/9r4XA2ZtUVG+TtTuXVe5NP/qaIvTHSrqVFmtVojAkK3e?=
 =?us-ascii?Q?dh1lEefWe5IS8TZKqLGrnUGD47mPOHNRhyEbUbyRJJYNsAlGOfzEN3U6srqA?=
 =?us-ascii?Q?lknj34FqUo8WobhbzEqFhuF4dP9fzbMgAHFszbnQcXu+hqTPD2eorXEiUmnK?=
 =?us-ascii?Q?3QuAj/LUZVmQ9oAwYPn98MCGS79Naou6Dsu7M3G0bOr3FDXibIiz2Az4T1V6?=
 =?us-ascii?Q?D6AXBYGndTx8R9BfKYvbuK9HAkLOV8l4AIG+MSd+dINW8mHOmxS+Ur2Mp2Ru?=
 =?us-ascii?Q?cz0MUGFOLwEt6bYvk4x5FDZADVI2xByyk7IEk6254fTdx78VTpZKg36CR8AW?=
 =?us-ascii?Q?GVrP6f+btx+q/rbHBN/9F7oReRUX2lgQ4WBxE/4ZRpKUOLGZEyR/J2q3eonB?=
 =?us-ascii?Q?vfyAVyZfBioZ692YNLZ1VraquSOYUBdFlBIKHVJ52YYp+P2JQJ01YXR81o9n?=
 =?us-ascii?Q?MLRLSV4y6HUiTvQzNDgI1pJAbZrX1bIICCqJX+NFVSkYTFruKNuLRLudJx6O?=
 =?us-ascii?Q?mXJRoKj5hUs0Y4HBktuabdOVT4Ggyc/jJkjLUNmetp4rJ3qH2LdcKR27tQKN?=
 =?us-ascii?Q?SriljxhzlZJq9IOOew3ePtzfkQrrWPwGcnxFccCmAUk/QBlSxpvRLB3UoVSO?=
 =?us-ascii?Q?kTSQzW+Mx92cZiMJ1RN3VnY5D/VIzKQdbXX1Mt0LpdEEya8w+RBOIXX4jWjO?=
 =?us-ascii?Q?2wO6dmcsjOnKDhf2z2yeYLO+/h88+3eONCLZRvlKmWIPzvr9Ze/dr8vSlVM5?=
 =?us-ascii?Q?aLafgtSNCZLXL0rQSFZe3CIo15+2cGklIdPomcHbbW7Zf6NLIpDPE8NGq0Uw?=
 =?us-ascii?Q?34KlNwzT0G7J62VaAJm0IXboE1Wd1CPZqa7EqTw3O4q0PYEk7opZpGofEavT?=
 =?us-ascii?Q?FHK2JuRqhu/GvoUyF+6Fb8TYtJOVqdumfKEM34GGZO+Nrfpg9Dx+/7vDpeBX?=
 =?us-ascii?Q?zTlm/4/pYLDZU+ky/ahTdCbf6tWA8ySO8P0PGixOgt/m6O+iraJvqnWKeBfO?=
 =?us-ascii?Q?xsEAVC/DG08/mBeRE/zM+HBH9Y3VR4bGFj7YB4OlgKwW07LS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d61a30-0abd-43e7-5f14-08dec31c99c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:07:54.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbAGtWEwQ797FriFzH0GByv4gaEKQIZKO1OtubY3jIRDC9x9c3gV7IOcV1x3VwR7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21840-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:markzhang@nvidia.com,m:patches@lists.linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00E87649ABF

On Tue, Jun 02, 2026 at 04:37:28PM -0300, Jason Gunthorpe wrote:
> Codex pointed out that cm_init_av_by_path() can call cm_set_av_port()
> which takes a reference on the cm device, but then can immediately return
> error if ib_init_ah_attr_from_path() fails.
> 
> Since callers like ib_send_cm_req() put the av on the stack this leaks
> that cm device reference.
> 
> Re-order cm_init_av_by_path() so it doesn't touch the av until it has done
> all its failable work, and then update the av in one shot so it is either
> left alone or fully init'd.
> 
> Fixes: 76039ac9095f ("IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Sashiko also pointed out that the cm_destroy_av() prior to
cm_init_av_by_path() is harmful as it leaves the AV broken in the error
case and thus the REJ won't send. Since cm_init_av_by_path() is now atomic
it is safe to delete the cm_destroy_av(). On succees the av from
cm_init_av_for_response() is cleaned up by cm_init_av_by_path(), on
failure the 'goto rejected' guarentees the av is destroyed during
ib_destroy_cm_id().

So I folded this in:

-       /* This destroy call is needed to pair with cm_init_av_for_response */
-       cm_destroy_av(&cm_id_priv->av);
+       /*
+        * cm_init_av_by_path() will internally pair with the above
+        * cm_init_av_for_response() if it succeeds.
+        */
        ret = cm_init_av_by_path(&work->path[0], gid_attr, &cm_id_priv->av);
        if (ret) {
                int err;

applied

Jason

