Return-Path: <linux-rdma+bounces-21701-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KzVvNVxuIGpo3QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21701-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:11:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4263A6C5
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:11:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=LcbHNJCE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21701-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21701-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 926DC302AF25
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD2138AC9A;
	Wed,  3 Jun 2026 18:11:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C32773FF
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 18:11:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510271; cv=fail; b=cMBQPLoCoyT4tMl9v7k4OBgTxIU1i3+Gyo/kx/Fryi7dZs1OkYBp8xI1v4iIoliQU17TKrmnl5bElzrPNBKUZI/tfX4sfMcbYaIq/RmNyREO++ZjENSBklhlWMEH7DsAMggmX0paTrexpfUqC+SX/Q6iSTEt20rSUNU0xRd+wGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510271; c=relaxed/simple;
	bh=s38G2oEfAxPBjamzLwj8kT2uhhrMtLrUdl7DZpG3CS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ARTZ4zmq25bYBXNkBEr9zwa+bglFWEFOLY20Xa5mAlttY4nL5/BfFd1oSBs6mIEib3okCeJOjRewqerkbd0A5WI0ZNWx5bSPSevmvH9FZ9D1W+lAs4GPb9ieUBIC1gcz3OO92KxTXTZq6Sf1dXYPgec1OnNKRN5Q9iZ1zMNLf6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LcbHNJCE; arc=fail smtp.client-ip=40.107.208.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljNlivd/3FpBEBhNeSM6wNHi/GefY1h8Pvq4o9bfFkyCvxpncAAW2jWsRDRpTrXbHN9dbYgGPeX3egmCDUPx0v+jlpwzCU7S2ioBQdmP+aY464/WTtGRHzGlAl83xHJEC2O8i4k7WMoZv1bTbw7vdj4nab2jTlIUGO3hrOtlQX44K+ZHigo4euhzzyzmNh0V/on/032JHswcRJDgpFSZGML5ADOuvPG+k+h8/sH1Tq6o+4xvV9Da9otpSWXvZJYLKLtbPlM7Ig65d0vIACkHLW6O6hKNFZcoLsHfHad6ce2BKHdGUx7aSFQ9nBLPA4cNIaS7MYoUl9jB8l8fWPJ19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMoEy4Ni8yvA3S1n2FVCA5jQOFOzvoeuHrlwp5jqLxg=;
 b=JkZn/5fyHgav1u7wnT/HgxFK0n/IV1qiyWNVPhptIB3A0BvAbmmob9YuT8w0JCUEY8GnmZ3SKOxq1UfxMetrcVr23xFBzfJrSOUlQz5ePr/PssFQANr404Ra8JeNHYkTJO60CYAtCZv0kBxuHiTtSKBRpJg1cjXUzY3mqNl2WdZjUEosJPJ5aAd04Ltq7k45vifuvqBAMSYEf/FFssuqnE/8/Lb5Ir/LZP7ERQU2fjUlzTjeJEyjIOgB0s4yhqXpieU6/1YXSpCO+BNqIGLAdqx2Sv0hc2sy/2PS3JVfqaREOLd0hLxJpJbqJkQBQ/u1BaGpad1oETvxawmRE6s2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMoEy4Ni8yvA3S1n2FVCA5jQOFOzvoeuHrlwp5jqLxg=;
 b=LcbHNJCEx/gIbG7mXAoDRHfYTaZ5bRiBrkedkKl8xndr4UgxEd/U1y1cZLtw5lmSrbZHUBTTBbKOUeMfC7cAKqGa9HibOVfbCPwZD5K9Q6eIf+S2rf5N4xcFo23Ohjo0aTOB296CkxbUD+V5jXDYTsFTIkWqm2h2ZWLryZ3+RNMDjAoqVNIy7Xm9L2XT8ovs3JtQ50hjy6jI8HZ7QFn3Je8oooiB4rjYRLd5938kNlFenVSQ6vjH14g7ssRXqETQYRGL4Bn41n7OGwRx6C3s+zBX1xBXPJ9lavT2zZUY4xHNpOMtKAE3514rNr5nVuHf+hax2jLuyvexf4xv46SR1w==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:11:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:11:05 +0000
Date: Wed, 3 Jun 2026 15:11:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rxe: Fix dma.length computation in wr_set_sge_list
Message-ID: <20260603181104.GA1565410@nvidia.com>
References: <20260531120721.1347977-1-jholzman@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531120721.1347977-1-jholzman@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:208:329::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 296ea320-3d3a-48e1-d5dc-08dec19b7a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Slx9fHV9xieV5qRGK2LG4BD7zVQVrYdLLIJcc9FaawwGLc9wtk2PX102suTZAMoHltyoSqxk2ZrgeAbREyzJKSK7CZLBE4OGmzihMlwfrLqIutAP5EbZSWIBo9hRGZe1J06kWHH28yPlmHV1ZA/K0AE+UdPuvW03O5YFZu1PKSQHFQiutDPd/DbrEx4yteEwfTrvZM4I+WefavB3W4WVkyLTudhU5hCHCqRFpOe/XuEVvtHAhsFqNHDe/A0F8I7+x0g9rCehK3NmevqDotkOHV9vxjyHPXk0pCA4qx0CumHfJ9qlm6fPvxb8tRxQDT9TU/m7lh4XcsuVMi2PhDcK0gWKjZXtdr4AGzqFvgdVoz6rJd6f7hv68G04gdlD88FEzrCJ2uWs3v4eqp8aJgKdq4BTlIGoAtYQGULq5/glYnPSkqXzrCSKYJx4yozzoWXZ7nT0BfRsWfwf7RgJ4K3fYCd0MMpOX59tyVe8/d3g8cmBCGjGjAJ87Zwi7BvUDsLEfGdW58NE+nDGZoxaWYacT7oRZTcnPINF8KobNy9EccIUvjDHYgRSNTvkbyML1Tkhd8Ni4BSgU7Jj4YwDzheRwzIhdXACjrLlo5GDi56E3q0wG3PS22gI5bdxD9h1oR3epF2sOO0rFbYIgXA7dsMaqNqZG45IrnIvDFUwiaVuFv16RUIZRMHJEImTDaDKkhADr3lKGpeu4fQ8sCMTYKcCVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dv70s5I46/uF+LCUp8hgvn41zzDBOOPeRAnbT6hBqTbu2c4Eq75ZlrXn44ks?=
 =?us-ascii?Q?AxI0CgG5O4ZPNQD/2IqEchpbbalBuNXwXHa4LdRGg3LlQ0w0gI1kQnyvdgm0?=
 =?us-ascii?Q?WLodpK6XwTqvDioJLwivkkQJYtICqe3ruiRiW4jzUmeVP9Tl04Don6ZFGSSY?=
 =?us-ascii?Q?TQNIzn8KV0Jz6kGJUUM1tdGpLLYUyBLdWV9yUMHFKcVbxTpvUywOwKSdbKFN?=
 =?us-ascii?Q?z7TmzLsjtP64mRrImENITJknGXNFnA+xhNlsdeJrgeLfaltRhuYfGeiMhqkW?=
 =?us-ascii?Q?A/nUj+lyaItZNuwRALi0MGt3wROlXH9IakTjfpxnNyUO7YpBKV5IdtokVvWT?=
 =?us-ascii?Q?tGeD9FK9AyyKFrD2RA196vcOvG8+n+FEXap5Vc7fFQRQVZxSBP+f5R7C8l3Y?=
 =?us-ascii?Q?OeQRGFf0Pzwv0+A22TeLaldfln7NwBd99igLnFUgfQ+skIUCLz0ZEAfvBx3s?=
 =?us-ascii?Q?iyJAfqpkpILbOu1zDzAizejgNFytgG+zhdOc3dSfkT52tbH/VEvOF+vt4JAd?=
 =?us-ascii?Q?MnsEH4klhVWXcMyi+KKRUKnU03m2UpYZqIAYqvk3ZV3/aI9nsJML2HuXIoek?=
 =?us-ascii?Q?VUKwb69BXXVsbY/55yaxaXtFMy8prGUPkEYZD5MwAo0DxeSSS2tQiaMy3rx4?=
 =?us-ascii?Q?mt6/u85L7ZQLRzFtnuooI95EugVStSrBRqdNmpHdVqY2SwEGkqcrnq5W/5SD?=
 =?us-ascii?Q?qtS9SgxW00GhVwA7uTPfYr5vTY/HklPHv/KZjMZ1qet0YwUj37X4jyp3Klf0?=
 =?us-ascii?Q?ogdegdiZFzSiA2slDfDwAwJe1e5PTZP6SvzeyLV4FwU2ijZigGjDbbthFe5D?=
 =?us-ascii?Q?3K0Lzxj7c0XoJoRCuTexlzxjvSX8jR0xwl5zq8vJ3UapoX6GxUU4FZ/vepc4?=
 =?us-ascii?Q?rn8s1DdwvsagubVyGTyxuQW0MOEi9DRjuR3qfo6Lz2wiiO63usm95+8s8HyG?=
 =?us-ascii?Q?oluON5vkwxGUlycXfALg6DB7yw0gasADPaRP54U3oK6No3CGdVQR6e8hq4At?=
 =?us-ascii?Q?UYgR+6DgtxZkZQHYwYCNxg5H5aKy9s/gKQrFt1jhl/5MFgZrzeL8M3GLJ7Hb?=
 =?us-ascii?Q?MzHLq64B9P7/SvHS7K2xThasfEMAECmCZ9vYoe6qFbkqHrnIusLvhnTcncKW?=
 =?us-ascii?Q?+O+hJVea+5+YUH19toHCKsxN2g9egEuFjOBHY8RJbljk2eeT8ag/lmhqoKIL?=
 =?us-ascii?Q?M1NLVhpyne3GcMsxECnZBAAG9EQhob7Kh/rPMptkcWxJQpx8bj2eSoW4Xe2z?=
 =?us-ascii?Q?d7ftSCmbIO1dG8qUSmiWnj+x3uOlQQ71QggLZXvkbM23ZOjMMmk5WZGkuBxP?=
 =?us-ascii?Q?klHkorppxsFBsbDqUT5+yzvxVkNY/qPA2xvP/f86TqJdtqNZBZOXjYoAieAO?=
 =?us-ascii?Q?SR+kPHPGNPfozzaDoCXo41CnCZNxgfVlc67BWMTun79Htsas5HSzKKwJcLFe?=
 =?us-ascii?Q?00P5ZWvMFGqID9SBIC99aUzpK3+AKid9Ih1HLCkpONKkHykfOP4sheDbXVse?=
 =?us-ascii?Q?7iYVmaGpeyQnKISr7bHNRiFKn/b7YyVGmfPdH3y2/zZS5qM/jCDsJphU6NY3?=
 =?us-ascii?Q?auVQoOmtZEfjPfv5FbiWVhqWQr6rEnPIwbjVHx37fKY1J1atgvBlY2KQq0tS?=
 =?us-ascii?Q?64AfahEnt1wwlCroFsrFCX6N6JFCMldnFuw9UcWRCdw2upDQ9pYIIO4H0+xs?=
 =?us-ascii?Q?AbTj1XroBVwrND6VXKf1YENCof/NaVxw8YKxvpEq31oc2seK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296ea320-3d3a-48e1-d5dc-08dec19b7a9b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:11:05.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQJxCouax3njrUgIB3NE+SQmYsvA77sRSeZPQfrOEiuRYPklPoTRMUfEdhOY9vgP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21701-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jholzman@nvidia.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47A4263A6C5

On Sun, May 31, 2026 at 03:07:21PM +0300, Jared Holzman wrote:
> wr_set_sge_list() summed the SGE lengths with a loop that never
> advanced sg_list:
> 
> 	while (num_sge--)
> 		tot_length += sg_list->length;
> 
> so tot_length ended up as num_sge * sg_list[0].length instead of the
> true sum, and wqe->dma.length / wqe->dma.resid were written with that
> wrong value. The per-SGE entries themselves were unaffected because
> they are populated by the preceding memcpy().
> 
> The kernel rxe driver requires dma.length == sum(sge[i].length) and
> enforces it in rxe_mr.c:copy_data(), so a multi-SGE WR posted through
> the ibv_qp_ex builder API (ibv_wr_set_sge_list) on rxe completes with
> IB_WC_LOC_PROT_ERR once finish_packet()/copy_data() runs off the end
> of the SGE list.
> 
> The legacy ibv_post_send path (init_send_wqe) is unaffected; it sums
> the lengths with an indexed for loop.
> 
> Fix by computing the total with an indexed loop, matching the style
> already used in rxe_post_one_recv() and init_send_wqe() in this file.
> 
> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> Signed-off-by: Jared Holzman <jholzman@nvidia.com>
> PR: https://github.com/linux-rdma/rdma-core/pull/1744

I don't know what this is, upstream doesn't have this code qp_ex
support or 1a894ca10105

The rdma-core thing looks OK though.

Jason

