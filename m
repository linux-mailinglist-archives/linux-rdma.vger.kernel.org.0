Return-Path: <linux-rdma+bounces-22333-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9TKsL4YAM2rX8QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22333-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 22:16:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D969C517
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 22:16:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NeF+VaL8;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22333-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22333-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 567CF30A90C6
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 20:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982883932ED;
	Wed, 17 Jun 2026 20:16:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C65257855;
	Wed, 17 Jun 2026 20:15:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727360; cv=fail; b=BOlLYRp5hY4JCWrEZnKEfjQEYQjNykFwJTKYazS8xG/GL2NJCisv3/FnJQCP+H0Ssm9zN7p18TarsvdSVfrN187v4Yn5GUxOYP1yZFN++hJwnwDSOI14TRAL3TgaaT+ubqC9Cq1a7JAw5W3KdlAzKoqMuu9phzyab67pVk8SUhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727360; c=relaxed/simple;
	bh=yme4qtf6kvrYBDrirNukstC+roQJ+g9OSm8tVJoMVz4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ecFNdHyfXoQtbfXhKef7JqNOL594Vy3kDWka/p7m8gh9h64AqKsC67DVLI0njV2p1uf6l2mYAR7QlsNoGeWYmF3LS2NhlnY55aN4n6OB7H6K0SBc2DAqE1756d31RhxlqDuiYmiuzEgzSRhUjnht+r7XhhkVKioMYgsQPQSckxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NeF+VaL8; arc=fail smtp.client-ip=52.101.56.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvChTP+DeD79tyAV5ZeJNXzzf+Cn0DhE4lRmYnDVUcW4BvsIdRbHajwTyfkoEtpcM2PE5Rinj0leCERfd5I0R5MnlrMZn0FVXHruZUqr6orAD62w4jmr6pfljPEJTtZfwtv2EEjOY/FdU9kuo7FyIpRYUXVU2B9Vs1uVsALgIC6pAqJFlrKMrOYH7vfHFE9nbz9BrwG46eVv0we23dlq7PfcNHCGAuz3rDvekbdhvxIP2++3x/FmM6WnmYdAxL1GUzN7wtj05zAL32mc4jMuD0BJ+XszxnR/kp28BhcbEQ+3KcaPzMN1TKcq5uaJajOzte74p5BGKvILCqXFySonBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYcGSae5SGy+RjjtFGQsz+UVLxosFSLO8MYhznnI8KU=;
 b=CLcUnph9cIKqOhwF/niXMvboWsNkJ363zpViyOtN2/bAI2iHFmVOI1bXcf9NTZ0OtMBPXZTtSAbQX1xebnAxfp/ibf6l1sidjz2e8CpoKI6bUurOcBVsGJBEwtv67a7HWfbFPXGH6LmN4ribKoRl7+Tk3SsOVFg59iwsFv093ostNAbMrrBQ1AU7z5PA+Sj5Et1/Ae7stJWtY+hG9Aa5do3E81cFPUaUO4ppyb1SF6xVYR/kLVGX8LUZHHC+1aODTaibQYzIJjJpX8MZQW9fLAf7XBG3eSriaklSIxJWTvL7ESkRCP6hz7lk78/YAWN4fXeyy9ScPbKQOed36XE/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYcGSae5SGy+RjjtFGQsz+UVLxosFSLO8MYhznnI8KU=;
 b=NeF+VaL8k2/EIMHbNcqcrKmTzns6rjdxeHCP7vvzaIe2escme3kLmVCDJMWj0tJJeE36eKoVciw2jk6ot+9G3EOjXdrt2sQ03bZcK7dmxBmww5YfoFapm5IlzZfM6krtmA1/7LJ43BmeKrxAJqn/lahrqaT4mHx9DriNiyZwQ8sCND77GhuG56UEcFJVao3Obk0qPIJo+ekwKMbPe3qWwHcFAC1Pj3V/9UQKBAu/EdsxAdun6VV/laNUmTmIIbO47oIdz0jrxULVNNByUaAnwLhPE9o/xpA4EGY4cquNpsKzi9DT8XFtsWkhY1VSym0LMAzDBuZrYdIDZ1FxUnbTwA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 20:15:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 20:15:46 +0000
Date: Wed, 17 Jun 2026 17:15:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20260617201545.GA320356@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gMHphsJXOJvnS3MY"
Content-Disposition: inline
X-ClientProxiedBy: BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f40973b-0776-446e-7149-08deccad3776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|5023799004|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jr66J/X77cVEGWgEIpvRsO8RD156TkbwfJ/XXMkIUsLTEVHJJ5gAlWA50VCCrhBh5pklr3tRbAOpKBkmZtTUJU6zuZPTf9kX7DiBBbLmMeTCYrSWX0YGheVWwop5hX8vUHDudnr/HmYxJq+ae9GfwkeHG5RYwDoCfqtSsSQg5hmelPLm5eXQK3E+Zg0dbAcSYCn0Rq5BW13CANS72JelcuIuWZvax3zcpjpNJ3Gq0+ZvW+Y3iODr+1WDWuPv6d2aLK1mKi8tnlZ4nZBG1iukO6XbOgvWNy0IcXAA8mQEhXh+WzH+93tLlo7Nw1pknlXkzblqvdM26L+Khf/DZDXpcpXqx1y0OeP89qHdGvyCX4XciRSgzQqpYd/MKbt8aueQrfiYVVgeWrK/mUBDDPHqjkUXMrd6MRA6Btizc7ffmwQKQBU8eoXjgknHAlz4OaY5u8C9L/hw7kySd6ZlUOEASVKnu0DWvJ1CDUWooQtcCl31NWyM8CUphkjBKi4U0E9VZdnNC8GFjzmhaHghHy2bvasgD8K6T5wxOsNU8RI5OVBg9XgIxC0Oled2fUeSxTxVdMY7mMtPrQJkRuSNYxanNpVNfOAU/mctIHb3Yvo9PSCVBO01Le5ow1DEetOI/siHjb16nPXBbgEnM3vJkULmoqk9bGIbmIGEDwYvIRqsLMrP6CoEjydOAR1PxvkXwSc/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(5023799004)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czlVd0lXTEdSU25vK0FqQVIyQlFNMFduYUtoMEJ5Tmx2WmVwcXdqMDd2eGlm?=
 =?utf-8?B?UjVoeFlYYnA4NEY2NmI1OVprUEhZbW9wMnlSbE4wZnRoN0J3SUVERGZJdTd5?=
 =?utf-8?B?Mk9zRmVCOHZHWHYxVUNzMWJ6aDBDZ2Uzb1Z0SmN6UUxUUWY1YlBaYXNtQlYz?=
 =?utf-8?B?cXhPRkFzWGZxOWp6MWJKVS9nQ1NTRjcvb0c3TVNPdGIzSmYyTFFzRVgvamEr?=
 =?utf-8?B?M3h3cVErYXBMbXJDSXJUalNCVCt6YXJJMS8wWjVtRHl1T0xaemJETE5iLzVE?=
 =?utf-8?B?Nk9UWnRjQm9kVjlROE1KS0VKREhVOXZVdUYxNFRRcFdlUkI0MXZ3V3B3S1dQ?=
 =?utf-8?B?S1B2NlFPNEd1UEplemg1SkwvNVpPTVcrb3RyWElUWXY0NjR3T0hMdUx5OUwx?=
 =?utf-8?B?SzlVTE1zcExVNnhIK1J6UktWN3NIamdxZ2E2YVVvWVEwSVBRV3B3cHJrbkR3?=
 =?utf-8?B?cVpCdkJkZ0hTT2tZcVAwaS94RGkrcVNZT0pYNVJRZnJRZGlpRzhiS0NLVlMw?=
 =?utf-8?B?MUZ6c1pWL29CekRUYWhVS0hHYjh0SjQ3MUJSYTVMdXYvUldBM214dGdaSlI0?=
 =?utf-8?B?cllZT0t0LzZGaHIybVlYZVJRY2swWjE5dmxRbmxlUHhxU0pzaGxaOVRWN0dF?=
 =?utf-8?B?cUUyTWxtZSsrZ2pQYjJZK2k1ZjVnNExuNXlCWkx5QmR1cXJQR3VjS1BaU21E?=
 =?utf-8?B?bmxEMmNNUTcxRDB3U2FGOXVBSmRFeHVkbjZFOG1LY0NEaXlrZ3MvK3g1QUN3?=
 =?utf-8?B?ZTVwSmZMcUFEQnRYMCswU3EwUGVYTkp2N25TMlRsUnRVNkxaajNJM1JvaEMx?=
 =?utf-8?B?QlJLMjl2WGRNM3lFQkxFTTJ5UzF0VGtOMSt0RkFOOHBzano2aHNZKzhaUUs3?=
 =?utf-8?B?a0M0bVRZM0dFM3hnRVdqYUpMdVpBamZLYkZGTkpQODhlZEFTUlRyZWRHZlly?=
 =?utf-8?B?dk1FMHQ5L205REdJRkFGOGtQWFc2VTBwMkNjZ0lpdDlINWI1c1h2WjdLUXNU?=
 =?utf-8?B?dTlUSUhGbDAyQ0U5eDRDY3dzMnlKZ2ZCOVdvNS92SkQ0WXRHUUJYYU0vT3dU?=
 =?utf-8?B?RDVWZGRyNS90UEpVRnRTYzFaS25xaEtFelgyZVNSdkNmckZ6WDlQZUhRK3Rp?=
 =?utf-8?B?K0dHZGp3ampzZGdDdGRTeUNDMHRLWXZuOW91VzU1K1ZOY2swU3BhMEdBRFA2?=
 =?utf-8?B?ekVJSDdMOEEydVorcUdSZ09JZEl6NEZmaEVUb2JtTGN4akttbm5ISlIxWjNE?=
 =?utf-8?B?dmhqR1RwVXZPRjYrc0RQMUtVSW5mcVVyQnJsNHZZQ1JVRkZEUlZhbDBNYnFF?=
 =?utf-8?B?eFRGa0dQd0hhS25PRnlJTmY1Nm9XeWpwVUlGY1lIblhmQjVLNitxNmMyVENX?=
 =?utf-8?B?aGVhZzNMYnYrRk9YUXhCUGN3dWllNmxYV0I4MWQ5bEZYR1ZvZm1SQlRKcDhW?=
 =?utf-8?B?RWpHb09icWN6UlZ5M2dXaG1WODlSOUJuSjBMdGFoNWRka1NVZmE0Z1RxaUhS?=
 =?utf-8?B?YWZGTDg5RU1WbWloK1FzaFR1MHJCZkkvMktRanRxT2d0c2NzUkZGSytUbUR6?=
 =?utf-8?B?NG1YWGY3VWR0OFE0NzJnNjRBZVZMNGpEMFpYajRwQk5SeG1oeUVGc2hLVjJY?=
 =?utf-8?B?S1RJZ0VGS2lESEVJVUx6SlZzWDVmcUxTSTVDVkM5cVpvb2NaK3BSVGZ0MVVI?=
 =?utf-8?B?aW5paHZ4RnZNUXpwejlSTUVNaXpldFdYWHJrYnFybFNRQ0FJcnQvWTlHVCtE?=
 =?utf-8?B?ZkJJeTRiay9WNG1JTDA5akJCb1BsditjL2dIOGRBU3NSa0N2M09uY01pcXU2?=
 =?utf-8?B?U0FCUG1IZzdYMVpmNTQ5UUhlNXJXMTA5czNEOTVMaU1NVDMxWitCZEVMUnZx?=
 =?utf-8?B?NWtCOUlxdG4vdHlGeHFtb3Q5K2VLQmpxSm1lb3Q2djdPVWtSK2s2QjhBTXly?=
 =?utf-8?B?TlNrT0c3NWZLc05YK1JTMlVJbE5NRlkxWHNrc0U1amhCUzNCYkpvUkdzc2Jz?=
 =?utf-8?B?R2M5WE1RakNiSkk4UWM3bTByZVJUYVZVN3pUTURLMnJQSG5TeG5GVVpOOTRO?=
 =?utf-8?B?Qm9ucmgwdERNWCtCY0FDRHVhZzhFSmFGU1lrM281N25DcWR6ZHhDa0RmMlhn?=
 =?utf-8?B?UkEyOTVMUksrRHRyNTVaZmRadnNtZE1PbkFDU3lsM2tuTUY0Y0liRHhmYXZC?=
 =?utf-8?B?NzQwaG52UUQwZkZzS3F5TWdkWThET083U3g3NERjT2kyRWJhb3liWDVpdnp6?=
 =?utf-8?B?WjVJK0FXYkNpVlN6MEd1dzhYT3FXckptUmthMEFKOHN5alFoNWl1Q29aVkpE?=
 =?utf-8?Q?IEt79h+Z20Ds8p5mwW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f40973b-0776-446e-7149-08deccad3776
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 20:15:46.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjZkmlo9EroqC+2NKHozXRBM9F/S9g56We6hPq2Euqic7F0yz1R4gDkj/cLxj7XO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.26 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22333-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leonro@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 328D969C517

--gMHphsJXOJvnS3MY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Another PR full of bug fixes. This has been an unusual cycle with a
high percentage of bug fixes and many fix patches from first time
contributors. There are still bug fixes from this week sitting in the
patchworks that will probably end up in a rc2/3 PR.

Thanks,
Jason

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to d9c8c45e6d2f438a3c8e643ae78b59454fa0fadd:

  RDMA/irdma: Replace waitqueue and flag with completion (2026-06-16 15:29:=
33 -0300)

----------------------------------------------------------------
RDMA v7.2 merge window

Many AI driven bug fixes, and several big driver API cleanups

- Driver bug fixes and minor cleanups in mlx5, hns, rxe, efa, siw, rtrs,
  mana, irdma, mlx4. Commonly error path flows, integer arithmetic
  overflows on unsafe data, out of bounds access, and use after free
  issues under races.

- Second half of the new udata API for drivers focusing on uAPI response

- bnxt_re supports more options for QP creation that will allow a dv
  path in rdma-core

- Untangle the module dependencies so drivers don't link to ib_uverbs.ko
  as was originall intended

- Provide a new way to handle umems with a consistent simplified uAPI and
  update several drivers to use it. This brings dmabuf support to more
  places and more drivers

- Support for mlx5 rate limit and packet pacing for UD and UC

- A batch of fixes for the new shared FRMR pools infrastructure

----------------------------------------------------------------
Alexander Chesnokov (1):
      RDMA/hns: Fix arithmetic overflow in calc_hem_config()

Arnd Bergmann (1):
      RDMA/hfi1: Open-code rvt_set_ibdev_name()

Aurelien DESBRIERES (1):
      RDMA/rtrs-srv: Fix integer underflow in process_read and process_write

Bernard Metzler (2):
      RDMA/siw: use kzalloc_flex
      RDMA/siw: Fix endpoint/socket association handling

Chengchang Tang (1):
      RDMA/hns: Support congestion control algorithm parameter configuration

Chenguang Zhao (1):
      RDMA/mlx5: Use QP port when decoding responder CQEs

Christophe JAILLET (1):
      RDMA/cma: Constify struct configfs_item_operations and configfs_group=
_operations

Cyrill Gorcunov (1):
      RDMA/irdma: Fix typo in SQ completions generation

Dave Hansen (1):
      MAINTAINERS: Remove bouncing Intel RDMA ethernet protocol maintainer

David Laight (3):
      RDMA/iwcm: User strscpy() to copy device name
      RDMA/usnic: User strscpy() to copy device name
      RDMA/mlx5: Use strscpy() to copy strings into arrays

Ethan Nelson-Moore (1):
      docs: infiniband: correct name of option to enable the ib_uverbs modu=
le

Guangshuo Li (1):
      IB/mlx4: Fix refcount leak in add_port() error path

Jacob Moroni (5):
      RDMA/irdma: Fix out-of-bounds write in irdma_copy_user_pgaddrs
      RDMA/irdma: Remove redundant legacy_mode checks
      RDMA/irdma: Fix OOB read during CQ MR registration
      RDMA/irdma: Initialize iwmr->access during MR registration
      RDMA/irdma: Replace waitqueue and flag with completion

Jason Gunthorpe (33):
      RDMA: Use ib_is_udata_in_empty() for places calling ib_is_udata_clear=
ed()
      IB/rdmavt: Don't abuse udata and ib_respond_udata()
      RDMA: Convert drivers using min to ib_respond_udata()
      RDMA: Convert drivers using sizeof() to ib_respond_udata()
      RDMA/cxgb4: Convert to ib_respond_udata()
      RDMA/qedr: Replace qedr_ib_copy_to_udata() with ib_respond_udata()
      RDMA/mlx: Replace response_len with ib_respond_udata()
      RDMA: Use proper driver data response structs instead of open coding
      RDMA: Add missed =3D {} initialization to uresp structs
      RDMA: Replace memset with =3D {} pattern for ib_respond_udata()
      Merge tag 'v7.1-rc5' into rdma.git for-next
      RDMA/core: Do not compile ib_core_uverbs without USER_ACCESS
      RDMA/core: Move many of the little EXPORTs from uverbs_ioctl into ib_=
core_uverbs
      RDMA/core: Remove uverbs_async_event_release()
      RDMA/core: Make a new module for the uverbs components needed by driv=
ers
      RDMA/core: Move ucaps into ib_uverbs_support.ko
      RDMA/core: Move flow related functions to ib_uverbs_support.ko
      RDMA/core: Don't make a dummy ib_udata on the stack in create_qp
      RDMA: Update the query_device() op
      RDMA/umem: Be careful about boundary conditions in ib_umem_find_best_=
pgsz()
      RDMA/umem: Make ib_umem_is_contiguous() safe on 32 bit
      IB/cm: Fix av cm device leak on an error path in cm_init_av_by_path()
      IB/mlx5: Don't take the rereg_mr fallback without a new translation
      RDMA/mlx5: Create ODP EQ for non-pinned dmabuf MRs
      IB/mlx5: Properly support implicit ODP rereg_mr
      RDMA/nldev: Fix locking when accessing mr->pd
      IB/mlx5: Remove unused mkc bits in mlx5r_umr_update_mr_page_shift()
      IB/mlx5: Pull the pdn out of the depths of the umr machinery
      IB/mlx5: Don't mangle the mr->pd inside the rereg callback
      IB/mlx5: Push pdn above mlx5r_umr_update_xlt()
      IB/mlx5: Push pdn above pagfault_real_mr()
      IB/mlx5: Push pdn above pagefault_dmabuf_mr()
      IB/mlx4: Fill in the access_flags if IB_MR_REREG_ACCESS is not specif=
ied

Jiri Pirko (18):
      RDMA/umem: Rename ib_umem_get() to ib_umem_get_va()
      RDMA/umem: Split ib_umem_get_va() into a thin wrapper around __ib_ume=
m_get_va()
      RDMA/core: Introduce generic buffer descriptor infrastructure for umem
      RDMA/umem: Route ib_umem_get_va() through ib_umem_get_attr_or_va()
      RDMA/uverbs: Push out CQ buffer umem processing into a helper
      RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
      RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
      RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
      RDMA/bnxt_re: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
      RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
      RDMA/uverbs: Remove legacy umem field from struct ib_cq
      RDMA/uverbs: Use UMEM attributes for QP creation
      RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
      RDMA/umem: Add ib_umem_is_contiguous() stub for !CONFIG_INFINIBAND_US=
ER_MEM
      RDMA/mlx5: Use UMEM attribute for CQ doorbell record
      RDMA/mlx5: Use UMEM attribute for QP doorbell record
      RDMA/uverbs: Expose CoCo DMA bounce requirement to userspace
      RDMA/umem: Block plain userspace memory registration under CoCo bounce

Junxian Huang (3):
      RDMA/hns: Initialize seqfile before creating file
      RDMA/hns: Add write support to debugfs
      RDMA/hns: Fix memory leak of bonding resources

Leon Romanovsky (1):
      RDMA/mlx5: Release the HW=E2=80=91provided UAR index rather than the =
SW one

Li RongQing (3):
      IB/mlx5: Reduce spinlock contention by moving free operations outside
      RDMA/mlx5: Fix error propagation in __mlx5_ib_add
      RDMA/mlx5: Fix state and counter desync on loopback enable failure

Lianfa Weng (2):
      RDMA/hns: Fix warning in poll cq direct mode
      RDMA/hns: Fix log flood after cmd_mbox failure

Maher Sanalla (10):
      RDMA/core: Fix broadcast address falsely detected as local
      net/mlx5: Add UD and UC packet pacing caps
      RDMA/mlx5: Refactor raw packet QP rate limit handling
      RDMA/mlx5: Add support for rate limit in UD and UC QPs
      RDMA/mlx5: Support deferred rate limit configuration
      RDMA/mlx5: Report packet pacing capabilities when querying device
      RDMA/bnxt_re: Validate rate limit attribute in modify QP
      RDMA/ionic: Validate rate limit attribute in modify QP
      IB/core: Delegate IB_QP_RATE_LIMIT validation to drivers
      RDMA/mlx5: Fix undefined shift of user RQ WQE size

Manuel Ebner (1):
      ABI: sysfs-class-infiniband: minor cleanup

Maoyi Xie (1):
      RDMA/hns: drop dead empty check in setup_root_hem()

Michael Bommarito (1):
      RDMA/siw: bound Read Response placement to the RREAD length

Michael Guralnik (9):
      RDMA/mlx5: Fix mkey creation error flow rollback
      RDMA/mlx5: Fix TPH extraction in FRMR pool key
      RDMA/core: Fix skipped usage for driver built FRMR key
      RDMA/core: Fix FRMR aging push to queue error flow
      RDMA/core: Fix FRMR set pinned push error path
      RDMA/core: Avoid NULL dereference on FRMR bad usage
      RDMA/core: Fix FRMR handle leak on push failure
      RDMA/core: Add ib_frmr_pool_drop for unrecoverable handles
      RDMA/mlx5: Drop FRMR pool handle on UMR revoke failure

Patrisious Haddad (2):
      RDMA/mlx5: Remove DCT restrack tracking
      RDMA/mlx5: Remove raw RSS QP restrack tracking

Prathamesh Deshpande (3):
      IB/mlx5: Fix transport-domain rollback and initialize lb mutex earlier
      RDMA/mlx5: Fix UMR XLT cleanup on ODP populate failure
      RDMA/mlx5: Fix devx subscribe-event unwind NULL dereference

Purushothaman Ramalingam (1):
      RDMA/rxe: Fix typos in comments

Rohit Chavan (3):
      RDMA/mlx4: Use secs_to_jiffies() instead of open-coding
      RDMA/mlx5: Use max() macro for bfreg calculation
      RDMA/bng_re: Remove unused variable rc

Rosen Penev (1):
      RDMA/rtrs: Use flexible array for client path stats

Ruoyu Wang (1):
      RDMA/bnxt_re: Check debugfs parameter allocation for failure

Sara Venkatesh (1):
      RDMA/srpt: fix integer overflow in immediate data length check

Selvin Xavier (9):
      RDMA/bnxt_re: Initialize dpi variable to zero
      RDMA/bnxt_re: Free SRQ toggle page after firmware teardown
      RDMA/bnxt_re: Free CQ toggle page after firmware teardown
      RDMA/bnxt_re: Avoid displaying the kernel pointer
      RDMA/bnxt_re: Add a max slot check for SQ
      RDMA/bnxt_re: Proper rollback if the ioremap fails
      RDMA/bnxt_re: Avoid repeated requests to allocate WC pages
      RDMA/bnxt_re: Fail DBR related page allocation UAPIs if the feature i=
s disabled
      RDMA/bnxt_re: Reject GET_TOGGLE_MEM when toggle page was not allocated

Shiraz Saleem (1):
      RDMA/mana_ib: Use ib_get_eth_speed for reporting port speed

Sriharsha Basavapatna (10):
      RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
      RDMA/bnxt_re: Update rq depth for app allocated QPs
      RDMA/bnxt_re: Update sq depth for app allocated QPs
      RDMA/bnxt_re: Update msn table size for app allocated QPs
      RDMA/bnxt_re: Update hwq depth for app allocated QPs
      RDMA/bnxt_re: Enhance dbr usecnt logic in doorbell uapis
      RDMA/bnxt_re: Enhance dpi lifecycle logic in doorbell uapis
      RDMA/bnxt_re: Support doorbells for app allocated QPs
      RDMA/bnxt_re: Enable app allocated QPs
      RDMA/bnxt_re: Update create_qp to use QP buffer umem attrs

Surabhi Gogte (1):
      RDMA/addr: Change addr_wq back to unordered workqueue

Tao Cui (2):
      RDMA/counter: Fix num_counters leak on bind_qp failure in alloc_and_b=
ind()
      RDMA/counter: Fix incorrect port index in rdma_counter_init() error c=
leanup

Tom Sela (2):
      RDMA/efa: Report 800 and 1600 Gbps link speed
      RDMA/efa: Implement the query port speed verb

Tristan Madani (2):
      RDMA/rxe: Fix TOCTOU heap overflow in get_srq_wqe
      RDMA/rxe: Copy WQE to local buffer in non-SRQ receive path

Uwe Kleine-K=C3=B6nig (The Capable Hub) (1):
      RDMA/hns: Use named initializer for pci_device_id array

Yonatan Nachum (1):
      RDMA/efa: Add checksum support for admin responses

Zhenhao Wan (1):
      RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in rdma_write_sg

Zhu Yanjun (2):
      selftest/rxe: Add selftests for perf
      RDMA/rxe: Fix a use-after-free problem in rxe_mmap

zhenwei pi (3):
      RDMA/rxe: remove rxe_ib_device_get_netdev() and RXE_PORT
      RDMA/rxe: add SENT/RCVD bytes
      RDMA/rxe: support perf mgmt GET method

 Documentation/ABI/stable/sysfs-class-infiniband    |   8 +-
 Documentation/infiniband/user_verbs.rst            |   2 +-
 .../translations/zh_CN/infiniband/user_verbs.rst   |   2 +-
 MAINTAINERS                                        |   1 -
 drivers/infiniband/Kconfig                         |   4 +
 drivers/infiniband/core/Makefile                   |  16 +-
 drivers/infiniband/core/addr.c                     |   4 +-
 drivers/infiniband/core/cm.c                       |  13 +-
 drivers/infiniband/core/cma_configfs.c             |   6 +-
 drivers/infiniband/core/core_priv.h                |   2 +-
 drivers/infiniband/core/counters.c                 |  12 +-
 drivers/infiniband/core/device.c                   |  12 +-
 drivers/infiniband/core/frmr_pools.c               | 104 ++++--
 drivers/infiniband/core/ib_core_uverbs.c           | 263 +++++++++++++-
 drivers/infiniband/core/iwcm.c                     |   4 +-
 drivers/infiniband/core/nldev.c                    |  15 +-
 drivers/infiniband/core/rdma_core.c                | 146 ++++----
 drivers/infiniband/core/rdma_core.h                |  11 +-
 drivers/infiniband/core/restrack.c                 |  49 +++
 drivers/infiniband/core/restrack.h                 |   1 +
 drivers/infiniband/core/ucaps.c                    |  10 +-
 drivers/infiniband/core/umem.c                     | 370 +++++++++++++++++=
++-
 drivers/infiniband/core/uverbs.h                   |  25 +-
 drivers/infiniband/core/uverbs_cmd.c               | 103 +-----
 drivers/infiniband/core/uverbs_flow.c              |  78 +++++
 drivers/infiniband/core/uverbs_ioctl.c             | 204 -----------
 drivers/infiniband/core/uverbs_main.c              | 127 +++----
 drivers/infiniband/core/uverbs_std_types.c         |   6 -
 .../infiniband/core/uverbs_std_types_async_fd.c    |  22 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |  73 +---
 drivers/infiniband/core/uverbs_std_types_qp.c      |   9 +-
 drivers/infiniband/core/uverbs_uapi.c              |  13 +
 drivers/infiniband/core/verbs.c                    |  40 +--
 drivers/infiniband/hw/bng_re/bng_fw.c              |   5 +-
 drivers/infiniband/hw/bnxt_re/debugfs.c            |   2 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           | 379 ++++++++++++++---=
----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   8 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   2 -
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  11 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |   1 +
 drivers/infiniband/hw/bnxt_re/uapi.c               |  92 ++++-
 drivers/infiniband/hw/cxgb4/cq.c                   |  11 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |   2 +-
 drivers/infiniband/hw/cxgb4/provider.c             |  22 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |  10 +-
 drivers/infiniband/hw/efa/Kconfig                  |   3 +-
 drivers/infiniband/hw/efa/efa.h                    |   1 +
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |   3 -
 drivers/infiniband/hw/efa/efa_admin_defs.h         |  15 +-
 drivers/infiniband/hw/efa/efa_com.c                |  50 ++-
 drivers/infiniband/hw/efa/efa_com.h                |   4 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |   4 +
 drivers/infiniband/hw/efa/efa_main.c               |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c              | 137 ++++----
 drivers/infiniband/hw/erdma/erdma_verbs.c          |  28 +-
 drivers/infiniband/hw/hfi1/init.c                  |  13 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c            |   4 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   9 +-
 drivers/infiniband/hw/hns/hns_roce_db.c            |   4 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c       | 285 +++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_debugfs.h       |  26 ++
 drivers/infiniband/hw/hns/hns_roce_device.h        |  21 ++
 drivers/infiniband/hw/hns/hns_roce_hem.c           |  10 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 106 ++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         | 125 +++++++
 drivers/infiniband/hw/hns/hns_roce_main.c          |  12 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  10 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |   8 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  13 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   8 +-
 drivers/infiniband/hw/ionic/ionic_controlpath.c    |  39 ++-
 drivers/infiniband/hw/ionic/ionic_ibdev.c          |   7 +-
 drivers/infiniband/hw/irdma/hw.c                   |   7 +-
 drivers/infiniband/hw/irdma/main.h                 |   3 +-
 drivers/infiniband/hw/irdma/uk.c                   |   9 +-
 drivers/infiniband/hw/irdma/user.h                 |   1 -
 drivers/infiniband/hw/irdma/utils.c                |  14 +-
 drivers/infiniband/hw/irdma/verbs.c                |  86 ++---
 drivers/infiniband/hw/irdma/verbs.h                |   1 -
 drivers/infiniband/hw/mana/cq.c                    |   6 +-
 drivers/infiniband/hw/mana/main.c                  |  12 +-
 drivers/infiniband/hw/mana/mr.c                    |   2 +-
 drivers/infiniband/hw/mana/qp.c                    |  22 +-
 drivers/infiniband/hw/mlx4/alias_GUID.c            |   2 +-
 drivers/infiniband/hw/mlx4/cq.c                    |  63 ++--
 drivers/infiniband/hw/mlx4/doorbell.c              |   4 +-
 drivers/infiniband/hw/mlx4/main.c                  |  44 +--
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |   2 +
 drivers/infiniband/hw/mlx4/mr.c                    |  13 +-
 drivers/infiniband/hw/mlx4/qp.c                    |  13 +-
 drivers/infiniband/hw/mlx4/srq.c                   |  14 +-
 drivers/infiniband/hw/mlx4/sysfs.c                 |  45 ++-
 drivers/infiniband/hw/mlx5/ah.c                    |   2 +-
 drivers/infiniband/hw/mlx5/cq.c                    |  51 +--
 drivers/infiniband/hw/mlx5/data_direct.c           |   2 +-
 drivers/infiniband/hw/mlx5/devx.c                  |  68 ++--
 drivers/infiniband/hw/mlx5/doorbell.c              | 103 +++++-
 drivers/infiniband/hw/mlx5/main.c                  |  84 +++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  19 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  76 +++--
 drivers/infiniband/hw/mlx5/odp.c                   |  82 +++--
 drivers/infiniband/hw/mlx5/qp.c                    | 360 +++++++++++++----=
--
 drivers/infiniband/hw/mlx5/restrack.c              |   3 -
 drivers/infiniband/hw/mlx5/srq.c                   |  11 +-
 drivers/infiniband/hw/mlx5/umr.c                   |  94 +++--
 drivers/infiniband/hw/mlx5/umr.h                   |  11 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |  55 +--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |  41 +--
 drivers/infiniband/hw/qedr/verbs.c                 |  68 ++--
 drivers/infiniband/hw/usnic/usnic_fwd.c            |   2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |  21 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |  11 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c       |   2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |  18 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |   8 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |  19 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |   2 +-
 drivers/infiniband/sw/rdmavt/mr.c                  |   2 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   3 +-
 drivers/infiniband/sw/rdmavt/srq.c                 |  19 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |   9 +-
 drivers/infiniband/sw/rxe/Makefile                 |   1 +
 drivers/infiniband/sw/rxe/rxe.c                    |   2 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.c        |   2 +
 drivers/infiniband/sw/rxe/rxe_hw_counters.h        |   2 +
 drivers/infiniband/sw/rxe/rxe_loc.h                |   6 +
 drivers/infiniband/sw/rxe/rxe_mad.c                |  97 ++++++
 drivers/infiniband/sw/rxe/rxe_mcast.c              |   4 +-
 drivers/infiniband/sw/rxe/rxe_mmap.c               |  19 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   9 +-
 drivers/infiniband/sw/rxe/rxe_param.h              |   2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |   2 +
 drivers/infiniband/sw/rxe/rxe_resp.c               |  35 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  19 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |  10 +-
 drivers/infiniband/sw/siw/siw.h                    |   5 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |  30 +-
 drivers/infiniband/sw/siw/siw_mem.c                |  58 ++--
 drivers/infiniband/sw/siw/siw_mem.h                |   5 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c              |   9 +
 drivers/infiniband/sw/siw/siw_verbs.c              |  18 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c       |   2 -
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  13 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h             |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  17 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   5 +-
 include/linux/mlx5/mlx5_ifc.h                      |   8 +-
 include/linux/mlx5/qp.h                            |   1 +
 include/rdma/frmr_pools.h                          |   3 +-
 include/rdma/ib_ucaps.h                            |   1 -
 include/rdma/ib_umem.h                             |  90 ++++-
 include/rdma/ib_verbs.h                            |  76 ++++-
 include/rdma/rdma_vt.h                             |  20 --
 include/rdma/uverbs_ioctl.h                        |  43 ++-
 include/rdma/uverbs_types.h                        |   8 +-
 include/uapi/rdma/bnxt_re-abi.h                    |   7 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   4 +
 include/uapi/rdma/ib_user_ioctl_verbs.h            |  27 ++
 include/uapi/rdma/ib_user_verbs.h                  |   2 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   5 +
 tools/testing/selftests/rdma/Makefile              |   3 +-
 .../testing/selftests/rdma/rxe_sent_rcvd_bytes.sh  |  75 ++++
 163 files changed, 3773 insertions(+), 1831 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_flow.c
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mad.c
 create mode 100755 tools/testing/selftests/rdma/rxe_sent_rcvd_bytes.sh

--gMHphsJXOJvnS3MY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCajMAbwAKCRCFwuHvBreF
YWUZAP9hFYdW+Axufbnagn8PT7R+YkICaZ9Vu1x9TajzbdSBdQEAjkmm5DvKtNcn
Hu6E9/aUE/LKeIyUfxw+OXmuGXFvWQM=
=ORwo
-----END PGP SIGNATURE-----

--gMHphsJXOJvnS3MY--

