Return-Path: <linux-rdma+bounces-19170-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMYdLTS112lURwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19170-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:18:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DFB3CBE16
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C2C300A3B5
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F07B2EC0A1;
	Thu,  9 Apr 2026 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j22c/HB9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BC3BC681
	for <linux-rdma@vger.kernel.org>; Thu,  9 Apr 2026 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744191; cv=fail; b=h3P2LcM90DPpdYgsev/jMjHoz+hRQbCg90yvPrujBqZvPi4hR7YtzX7MU6uGcn+4sNMaRgLIqP2glsM26hzqAD3+NGvynOULZxQMO8mVL+je/NM5EqYsuKc6upeumZXrgvZl7T2yyaF9skQEZZUU64luwwV1GKN7smeuK4FEaN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744191; c=relaxed/simple;
	bh=i3fTBGv16tTFOuXphg5g46JbHZDRkYznAuBvp0b2GnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uIvG6HRdtf4q8DSZCgMuhbt8B2NiorxdXgwtD3guaYvHB9ErZauYtzk/hfyKZDnQZUuCv8hw7ln4MyXjfVotMUuaFJkz7oAKzeU0fhziwygIV0tYmqZau77yJSWoduxxTV1nRw6eJESglotcpo5IXtSGgjqXjvUbg2F2lAkOn6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j22c/HB9; arc=fail smtp.client-ip=40.93.194.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhVBxUXoGrELl9ywNDtCMmbQDxPiAqVKFRCvkrFVLr9KndbqUVccXBOxty2A9/MxNCz3HDArDkzVTzls6CfX+55eT+thGX9q0WOWHoEgitpO9KKEyibdbi0R9LsC33c05bi9DjnxEi8No4V2XxRp2PQ0TZ2Cz2DBbCxPcHqHuPEW0XVTw2m81sDzgjA3DmCUVmiK51msj4B8DFtN1+eIN40CNK70c8PHHKHPfy74PV6g6xj3WoCEtldzVcLewf/Mtl0/p6bIBQMS0AiwDXSuF87CyUKEuvBkkDXToKV6ElgyaigHf482rY1HRZLURTYS1BP3OosUNlqRQXFfAq4zHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUVzmhA+QrjsPb8XwEgG0CeZOTOVZk8wzaLs7eJiWVg=;
 b=YvNYzyveujzqkCGHcu17z/IeEiTC97nSOMwKf0SM7UVuGf0nP28MtPdV7gRN4NbVpx+pesUZbnDFHMjXCdVKDr3ZXl2eiiNJo6T0j/aztjXw83ItBchyvwUboQTzRoLQYUXZRxc03UzRIjNU1Dw17Q6U53DTRi8OP+fSzrs/bvdEKLQ5USCr5X3jlcbtpZhTBwTBcumRY5ByBW3hOaZdj2Pe4Ogm8YzSyHtkC+Qxy2TU8TUp7oGGXu/YakBxgrfrquZvwwU3XA+tKkov+glEZzM6IDZ9laWnnvkdv/XQknyNEOVWeitW37DEntPYJlRSQLSkKJAGzlLtOniDsIoMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUVzmhA+QrjsPb8XwEgG0CeZOTOVZk8wzaLs7eJiWVg=;
 b=j22c/HB93da8eyJu40rVW/mQiU5l9hZHbLuqMZKGjw+uFNgb72ZOwCPWvrP9Zr91agYQWgrAd4dF6kz5I+a/O8YAZG6bmasZ658Mtb5XflciN2qVKlow5CmKWZiNF/n7q2xiGUFJtbjKz6OaBFc8jV7Rp6Z0RKhMN7IVoq2gm6rcUggvoIwcEjQ6swyP6usr2H8pg08mrXynRBamQzWwmQUgdKbzssQCwDXTh2U7vjPXGk/+sKtUnUB6aaozXMPeVT5OWjiKWXRp+7BhBDdLabwEy/i/svWHkcPkYnda3AIW92LXpJNjLYwHaIB+UAvqTTJcpjE+ifWfBU3Yo+F7TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:16:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:16:18 +0000
Date: Thu, 9 Apr 2026 11:16:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Florian Westphal <fw@strlen.de>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH rdma] RDMA/core: prefer NLA_NUL_STRING
Message-ID: <20260409141617.GA1897442@nvidia.com>
References: <20260330122742.13315-1-fw@strlen.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330122742.13315-1-fw@strlen.de>
X-ClientProxiedBy: YT3PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbcabc3-16a6-41c9-e564-08de96429175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	G12Uc2UMRwIXFlNo6082eX+9OFXcuT71IAFHyrIVNQ8CyNRoCMqKXVe2dYAprm+w2Y0Qj3Ga/1WkWZ1S+9Jz8foWQZR7p8w/RXPPoVNFlxnoQnnnvP8Yghdk2a6+vq58PDEXimlzLOaDYk3Qtln4mkrYZG44KScXScJ2T82BbFj3gamK4ioTCNFnte3ZxO4jHStZt7s3LbMMy2CvBGeQNTq1b2yRF79nKl1NGqaQvVKAXBKrlaiS2SCiramuuE0NKXlQk5k1gvXkQDeCiS2lruQIzppS9L1dyaT0v8cU07Kc5FoFH3iT3LF6WOwldWzm+V8WTfnB2pcSiSGcrtPYUvRp9uTzG1CF6ylvwsNy1RC7tyRIS6OU0KZnMODVK5wUmQE9wO+6H2+Yi+IaBk3UhVSY8AfapCaN8OTht8Mon+bO3X5Bnr3iYCsGDNJMYJk4VEdzzsd/2Nfcj3kWVlVvyrDvRUG0seefIHJXwLvrBYITeiqWz8DXiizrzqLx6iLW8zJRZ4miDn3CyS9HlVl2zoR2bVJwHY4pQGlrXAHbXG5/vUL1WQ/nJud4YPlvB514OMhLBBsK6bvQhVevjXo1aYXA6KtpCT7W+jZGjbPztuEa+VHOhOk3TGSwFCISuO+EE+6nKTvEpaA+pNXKuMz/78OecQWlT2OaC8zJEu76+DBmLsS3sNiChjTkVL0zc6/yQmC9LStrSasTU3wwS3ouOyEAtCO+QejF6hkA8eNPw2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BCW9GqoFGJYSLH3N/gqarWolTv8V2gioBYCUaBHU31cc/3oRuehzsp7lGDZL?=
 =?us-ascii?Q?Xx0HFfjl8gSKidgVv2fruYe6jjoSD8zAp9fiMX2bSIMZGV7yal7WOMIDBEx0?=
 =?us-ascii?Q?Gk5pCNnudBenKNEpJ1pIiOHh2mJLwKw+Ec3cY4VLZ7Ofi5VJq68eqv8DbdVF?=
 =?us-ascii?Q?OEsnJVjhYBXqB0lWQIJfp9Ga5JEam/eMQtuD6CWL9tQZGYyTFYmForE6VhYF?=
 =?us-ascii?Q?Q6Ww+Md9DCuxkua4sXY6UgaHTHsi2kCE3G006PpPx75DXbWAefwXzbkynWJW?=
 =?us-ascii?Q?sdwOmJWEGc3voOpKnsKBk0WSIfBH487c30ejInE5u4rHnrhYGtYM3nW2b1al?=
 =?us-ascii?Q?8nUEujYodY+LtJMfobpAJ2/KP9JWPYeb949yQLNqnV1K0cq0Dl95n3qyg4ZA?=
 =?us-ascii?Q?FCeh2zhKshA3GzVb92KuXaUPtAtRKqWd0oglu5Ty2dSZkLcFQJGKYxc4tU2H?=
 =?us-ascii?Q?l5YeMs7vmLx1q/3LyvSDbrbV45trWnfXILhM32hxcPWixQcpnx9Q7gVmAF5H?=
 =?us-ascii?Q?A0rse1jMw/xdtRoqX3HJSyIeYl6XfBRKxDZhcuctTBXvKfNbpYoYu+ftM2/U?=
 =?us-ascii?Q?tgudoY9Sglu92XxGKnss7d9zpiwP9B00+hfEopboaSqG1gworEoYxSng8jel?=
 =?us-ascii?Q?twK+PooXPQ/9F9OBRhArsWvTQWcKQMOBjjBbF7sBpS+xKAY+AjZVhvR6opbS?=
 =?us-ascii?Q?aPNjloiEjewdtAkj/7a7BSbuv961hHdcExM/9Z7rsKgVdRnQAYdIqQQaOnj0?=
 =?us-ascii?Q?VgK06Av4CYluT5cK3qga8GhXv42casi61MefaWOpW4Aai9gv19S/DzCJOpTl?=
 =?us-ascii?Q?oIsaGtblxdLPaRmsx8vqNJ82GLA4qy4fSBgNtRG1jDQjQDy3p24avEsfw+K9?=
 =?us-ascii?Q?25UDvbI4JPRLTQgSX85jyFqgdi+LJdnGTJ6DZcJRI46aoWrFJ8KkhIjQ2hTT?=
 =?us-ascii?Q?gsQ6Q2J92g1/l7eMPgbXKOvR2TBTifk3B/bNBCzUMrxl/Y97PIu9tcrlehfM?=
 =?us-ascii?Q?d9j5F9aLvApOMyer4Uz9OwkC5RZ1uIaLasRvycWwOCNX10o+DqiTz+dWVsTV?=
 =?us-ascii?Q?GT23cRMLwbS+HpD6A0vL2BhyGJ/ZxNlo+mZMYGMhp2QGKPnq2weTM6hoDmPS?=
 =?us-ascii?Q?Mr7kRG2qa0m6zp6PCtjU9Hf0jOL0t0GY/I0SykptrVMP8/hETtUPSTvZrdEO?=
 =?us-ascii?Q?AINOu2cudt58B7xpEwyY0DtZDCPaQV4dRrWLvTXantOJOrruE1OHpLz9gblF?=
 =?us-ascii?Q?Xfb0yxgn0IIZDBFBHrFfzMqd6r4jNcImCr4VelGkQlXvW1cseYRBVONnjNcG?=
 =?us-ascii?Q?BT7ZtWSpHQpNmgqS4mJ1R0A9/tHfVwvh9ANNT2eoJNd9GUD2TH6UiZUKu+Z8?=
 =?us-ascii?Q?aDz04V/tHnIkD/ImQh7pBwpuEeiPoMm8I9VRv5ePVjXOkknVBJwVPgAruND6?=
 =?us-ascii?Q?JpMRBoYO1V8L/qgroICedFbH4i8jVbJwGc19bC6n9Ifozzf8hgmqF5bRmse4?=
 =?us-ascii?Q?IekTkbuBWJW5TnWj7U+CS6gO2d1RZBv5iedSP26YC8348IBFhx5q5EmIAhuU?=
 =?us-ascii?Q?i/7uP2Sh3eZAV5AymHrKOoTICbbVXlZbbgfq6B0tSzWQIn6zGf7udwWwxx2m?=
 =?us-ascii?Q?kt0IxLj1z2QLMvlZWNrtlHuK/279SI5ZH1d0NTudFh1OAYKnfnQayqMJjrOY?=
 =?us-ascii?Q?3sQVnLeG1vVL9wg930l5XQ7AM2DAZPKAK7unnqEmkax18fSO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbcabc3-16a6-41c9-e564-08de96429175
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:16:18.7161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BotKjRnG3P1UdKZWrkSj2RCRJS+RY4D1vULEsnxqOrLrdfEppjlYh5ZlFgzymDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-19170-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: 23DFB3CBE16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 02:27:39PM +0200, Florian Westphal wrote:
> These attributes are evaluated as c-string (passed to strcmp), but
> NLA_STRING doesn't check for the presence of a \0 terminator.
> 
> Either this needs to switch to nla_strcmp() and needs to adjust printf
> fmt specifier to not use plain %s, or this needs to use NLA_NUL_STRING.
> 
> As the code has been this way for long time, it seems to me that
> userspace does include the terminating nul, even tough its not enforced
> so far, and thus NLA_NUL_STRING use is the simpler solution.
> 
> Fixes: 30dc5e63d6a5 ("RDMA/core: Add support for iWARP Port Mapper user space service")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  compile tested only.
> 
>  drivers/infiniband/core/iwpm_msg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-next

Thanks,
Jason

