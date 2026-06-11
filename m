Return-Path: <linux-rdma+bounces-22140-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GHEsCyEJK2rU1gMAu9opvQ
	(envelope-from <linux-rdma+bounces-22140-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:14:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96774674B2F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:14:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ukFLPZTr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22140-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22140-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A778B30AEF5A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464A346E56;
	Thu, 11 Jun 2026 19:14:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7AB1D6BB;
	Thu, 11 Jun 2026 19:14:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205278; cv=fail; b=OtgCB6Z5ExbZF9CmWS/J5O85tWce6qIN48P7w4wntOfC4DQIf+GwltN1Okmdm+FNQ6InqkzBkPFLh0GL4RZ0MHf1CIlwWIhueLMGlAhLvwFZJztPHjfjYeYutxpVMY35Bvhq37iD+CQdc1H8OU/So4QQ+QLlE4JQs8n3pnu+2Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205278; c=relaxed/simple;
	bh=6w+qr7nzVBgJIu5OofJbj/W8qyTxhzooxTnSSu7I2KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JAs1aeQiWN5/HPcGcvWDQz1P786uRPHtgqiq3BiFJqiVDjwzz3gfUaNTOUc5zge9Wgug3kCaUOCvS63XMri8tMCxWZFtYp9qdcjbNgIV+gZsfySSJ0KXOKyUjRKdch1qJvMkTsCX6tmsFgt6nzF0Z3qMfHu+eCV2w61WstQ4fn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ukFLPZTr; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/cdpnVFThkaBV/a3NH2eYRplKl/sWuduo60o346c7/q5NxEccBQRVDdlAMDGnJN2IvtHrgeqA/hgn7BySv8/mSZSl71f5RPybfM+BGCK2hDxvb+s6w8kWAvMBOky2II9kYbcPzJaWDfSZ4mi0AporCoMDXcoTuN7R86Yks+1M8iFEwSc0L8/7A6mi6NgUrWwbIrBm7hcUobMf4GU/9GDqeiVXV/bCpRXBMcNds+z+mMGrD8/kXeZGZrfSXdeemYlMIu1Jjv3HVWETeqYdv55cGUtmjnAd8L07M6bjilee60LGXyAkLBVCICsU1gbyHdVzJutABDAhFzdbylZqm0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vZXyxRhDEHJ3nQxXZSMD6qiiTrC1t9s/8R2sg8C5sA=;
 b=JcpRdV6+C2o6fHwcX8lIcUf7p0Q1tG61gD5loLFk3zCMuy6QkZuhfRKbLcT3WimlrF8c4hSlBxuSdyU9Uye43aftxfZsMLX3czhKB02bt8OeMV43pv5LHB+4ElYyfQvBYtawMnzYYIhyKUdBsFMkBBo5YlS33Jcx8784qGvBzDS6xfhypL1RffiFDDSUIiiwLoQL+I8BndejaUrqQfWNZUOxVb4+nA7ZBgYMbMp1SJ67Fel8PDxkl3mzupcibybNx9tVxhflRNMcJQCQultqdMNR3d8yLIas+KVNqewDihv7LUtQ7//yBWg5wfQ+M8kahMD0Ph/ozJP0pw0h3zDInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vZXyxRhDEHJ3nQxXZSMD6qiiTrC1t9s/8R2sg8C5sA=;
 b=ukFLPZTrSP1vCkrfY+zhf1plqnQwz2qNqNrze55EjWRfPDziPvnuRs8H4XvQ93N9YOHJiBw2T2guXhuPJwpQrgGaFkmrQ8eEPxtcfKixGYURQYogn9esKOenb9X6GpGpEZq3ted7WfiI62j4ps6P3n/tJGTBNBJZ42rj6cUA2zzlPg4iXJfdxP1gNqYjSYNq1ZVsSaJEzM9f1YbCh3HKMDTMM2e4YUGEfIrhJfcRwd/bCkmGeskyRUE2uLGIglssqicOL/wwrVCSWG54N4thxFQU+s4xk4CuA4fQ07FUKNJNopIrU2VNHJN5uRCbOT239s6Ypt2fZPfCbF5Ch6x4BA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 19:14:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 19:14:29 +0000
Date: Thu, 11 Jun 2026 16:14:28 -0300
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
Message-ID: <20260611191428.GA1516154@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 37978057-d1e7-4fc5-3be8-08dec7eda926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7mZOSxLm9ccwAKCaD8YeK7QFjkpCIYqDPL0hevY7oC9ynUeNa/2ZKf7DN6gYK1rye2Ldn8+WrwAOpWqXj1/alB3tpQuI6PORSyWN8REFH6G7ZL8eq/TTv+09rJexTC2PTIc0G1/Irz/qb7zAE62gdhwiaxGuILR7O78M/SAIlcyXuIgMtAquKiMDsMO4YDnrhzWGcLvZS24ms9rEWANnbp62B7St2gZHQPPFJSy/SUJ/RoizOhn1XM9Nc4hy1MEPmSO4SsSpwg6rjGFL+4cBGRHtpi99tbhaRY36P/TsPKZmg8sUnPf2lwp58uIcARGGAxlCxhXi8h0gX44hstOx2/Uq6LQ7yeXV9DCiVrMjqNYmIZ0IiQObSymBH7t9VG+HgElKsmW5+ahNo4Ny3bMMRKIyk2vUebOqpZGSOu1fqXAB6zmhTRPLFY1+z4/KzaRGZElWDvO9HuPm2PedV0mzubnNaKtFFijOSTeyMuLbmEqe6w1eleST+sPsToMAqR/3H/4sgIJNP+ImYk561wZ2APXOPLFQaa3WKm6tBrn9rTQfV6MuCl69JmAL+ewDWQLmFsbm4Bk3IJyuJvYP/9hU9jTN2/zv7BvFkAPnPXk4sSABR3lXS2Bl3x0ZCkRvmpaTZuxkkT3lFeTPvlY+weD/I3RtgZzhp5weJCj8/xrGvB2gY5nYeuJwt1zNZXI3euC3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ACjwocEw9lPkfjiYRXZ8dvKImwv+/yw9A2C+vn5tSZ32BtPMr1CrGzfK6Zb6?=
 =?us-ascii?Q?9hyZDBzMMeep1MF+S3ArE7wAn0xgkH6VeWwGes2zK4AzQPH3FlFrRHoMmbQt?=
 =?us-ascii?Q?c4yLKe+GD6DJBaZ/15ETlZFuPq9IqQbSbrePXujJg6S2Ju1IfemkQs3d8343?=
 =?us-ascii?Q?cOJWo4TyKk68WvSwR+qbCvGA2ZxX3lJhBU/3dtgE0SaXznh+OqemRCyUR2al?=
 =?us-ascii?Q?lhs7NByjcwZXkuXRt1b8XNPL/+aEfjUXRBqWyz5/bQTE3DgnHm2sVzVMdFNz?=
 =?us-ascii?Q?/pKk2x9ABBeWDecAYtFuxcZeRal69Dd+3m/4ISRghKx1MZ/uI5UQLWe50Mek?=
 =?us-ascii?Q?xiYPQkddN+s2mk5zGVb11P70rxNdOCV7kC+K5NfDwGOtVVIMYn3etidSGQAs?=
 =?us-ascii?Q?vr67aOUQr11rh/+39dCXUBNsn5uxP2+I9tk/KouNqK1UnpCgWXC1t1V3T075?=
 =?us-ascii?Q?XmDSm8QbGCMHbTFWgQCcfDCpdAiXpUo7pOrAB6jdw5vfYVqfc5NqjOlzrOG/?=
 =?us-ascii?Q?hSyyugZt3nxeI4c91PcD685wj7l/eCZ74a+i9P+kx9mT6tXj7nZyc/uohCDa?=
 =?us-ascii?Q?mB5RxgSEdUiBBNgTlRHJlbJ6vA7NDUD1EIi1Y6wAPIBdNgxiwEbYFQpcXNGP?=
 =?us-ascii?Q?iRWTe66YT1SmTsnSRrLCXqJtLfEDO7YuQ2TdRtLyQ8HgEXT4noXaAzLWLaJn?=
 =?us-ascii?Q?+4PBk/IBZW1lnsp1KBwvSeMrjWEAh3tLyOoOVzFtOVkbfGU9NgpLzZk3C8uZ?=
 =?us-ascii?Q?u1ly8+tP6YSvDQxrUQZLgjLREqnuVUBPKFljnjlwqD82crMyp5NijvrTxWPT?=
 =?us-ascii?Q?SRGi86KcYHyGOf/rE2wNyd1Gzx5hpw2GJOdo8ZL9RbvASV2bNvwPKpTCLwjq?=
 =?us-ascii?Q?+hV7y/X7Bqs/ejsoinUF1n/0rKJYTDQhXIlFVjgGzmn91Exy+3ZVzWD4mIJ9?=
 =?us-ascii?Q?iSizlbiOKT0Gua7rI9aZAygHmvAkjY5/9v/dUsoUDBqm5Aa28W2x8N9BJfyA?=
 =?us-ascii?Q?8mWgeofq6xGUVGY0prUJHqgcSu5jIQ0Dt40SF4C7yzZdv6XQMMnnGY4NqkS0?=
 =?us-ascii?Q?vX3HZzoN1Li5L7EzyT/csxmcY/8pSmoYh0j0H+9YtGSTxOBMh3FjuFRkMk84?=
 =?us-ascii?Q?XQdEPfu63CKmrVodfUbOUXMc4Qo+R80Kr97+siALcETcaM6KwB0JtrC2bzwu?=
 =?us-ascii?Q?NOE/4pAuaQh9LDVliCTM5wK+FCyeufR25XRx4lQKP64omhGh1soGY88ZBXfZ?=
 =?us-ascii?Q?XCfCAXr6OI9pSvLrMNmSE5wEQc/7tJXLnKWICX7YnekkMhPlpTabT9bipvKM?=
 =?us-ascii?Q?xzDGONbGPUtJ9Tw8RspyRjHONN5UmQwY/jgzN2jpoDMti/rI3Od+W9OCKaDA?=
 =?us-ascii?Q?56HTtjsyyMFrjpA9hn34cfzDIJTP4m1zP5osH0c/fKtBEok5gqqpbOkRXPh1?=
 =?us-ascii?Q?Z8iNYBk+eFMk8CeCpA00rZiFRh3GjdKpiPWaEQRx4R+D2e0Uf1lxQVSS7vMC?=
 =?us-ascii?Q?NBd3qwFdFq75ikqVCe2BiL5e1gWiKByYFsO8Q1ZVARvKbdgwiPdmXRPAvqof?=
 =?us-ascii?Q?Q3Wvj2xFNpsoLAwTdS4NR8RjgR3ZVAQDF6Mda/QrKA2nom0F7y+4hd7naSld?=
 =?us-ascii?Q?Ys+zrcDndS7GFSNOSYoxen6A2zynJgIG8ttiN0KJ9DeyAFdBJ85c4UTciWzI?=
 =?us-ascii?Q?2D5X6erJeZm6KbjOsxcnd7ymc7v32X3rkXa0twUo9dOUBNcf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37978057-d1e7-4fc5-3be8-08dec7eda926
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:14:29.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMqWK9rQFmbrF9ssGsH0RjMYQdpX5YpBWugKtB0dJFmRaXIR3rGtE52mG6dl3+D4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22140-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96774674B2F

On Sun, Jun 07, 2026 at 09:18:07PM +0300, Edward Srouji wrote:
> Patrisious Haddad (6):
>       RDMA/mlx5: Remove DCT restrack tracking
>       RDMA/mlx5: Remove raw RSS QP restrack tracking

Applied these two to for-next

Thanks,
Jason

