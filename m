Return-Path: <linux-rdma+bounces-17727-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Am7NEbBrWnq6wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17727-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 19:34:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADD2231B18
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 19:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9333B301C3E6
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61363939D1;
	Sun,  8 Mar 2026 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9sgN2Rz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F8A299922;
	Sun,  8 Mar 2026 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994873; cv=fail; b=u0rhZyT3gIUBER0bBAGMdgEzkAKPiCHgm4jqGtCh3N2SclDUbwi7NwLCNsU6rR/XxLw54eku0O6sAu4w7rGuuH947y+tYz3nZG730fPqxbcnN9MEbjoqo2K5omHi79LKTCsKtUHTSUTJlGDN9M65fAXjSjw0WGbdEDQQdKQFCBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994873; c=relaxed/simple;
	bh=xXKrKOIhWcTtphC8XScYOnKLu/YmhOHar2xXJlDngNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ejJtuzTfq4343Oy8dwNDzj/kbvmune4CV+VIcaZVHeec/hcFVnv7xJzMlB6+MP5defCcJne1U0Chl24l+WmBNcepnNfYDE9jOFLgrBct9njh8Ve3AfZPT/RvOkFdJK5+ET9avvLvtn6BOT922K+/PMJOyiwyzNavH/lNstNIGsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9sgN2Rz; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUqb7E1x2IEHdPnL93c2fioSp+ld4RzkVZHx3BG3kjCaVZ96HO3Linl+qKB7YnXHVcTuiH3mVlf2m7XkG7gKO5JWiXji744emVOJRVSw5yPzNPr3MVil5iYzDpq3Bq3ZcOxZGoP1V0J+bgHnwsVr0blv03t35lDC0GA1mGCV99/jTWubFj3ofcbhT9KwLxveA6yEdNFhOVQICS6iSTLYJySVFc7g+8A3RvUwH4P7RM93uj1drGtBnRjJ4hmep6ey8iI1q+Ndbq6VZsIlivLhjc8KyAuOXBRse6yYO+boKw5bh6hjVi/fW+cZlj/LbULHhEblxjCK+pGILuznc13JFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYsg3zndjLn1TPPMR7TsRMg+hPN5YpEGVRusmc+wB/I=;
 b=xHQQyfqGFVDFNJYNH9mG8FVH1S91Q3CeXZ1nuzXcwKwERxi9aTrBB4YvOwl047GFq5oGnfWYXmp+aiR78732EUVfnDsQxrN0WE4kLQoEFIfzctacDRVsXBDzBb4qy3/8+iP6X5afxJa7h4K2l02cqb7P0BaJV6X6Wg90jjMAIYm0IOotEA+3KDMWSBYeUJZEAUak/5peY6DS1/1ufBGF1ChoPV3LXAiLdBR3AvHgfx8KK3sZmP8Iad4u6e+FP/3nM8vmGsVwgNNFRZt3p0fWL+qBcxhdvEA1zacyQmZwSGfN470Y4sRrtIvnu0uK8n4Bkh3xuGnYIora8u/PX9k89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYsg3zndjLn1TPPMR7TsRMg+hPN5YpEGVRusmc+wB/I=;
 b=i9sgN2Rz42HX/LdWdS2cQH9jVzip4hTX8jE1EcsDjPHk8y7iFue34IY5wzRjg0Q82mWeixbvi5NJQjiTJX1CqA6TFM2oj5nvjRp6haRG1E4g1VVWIG6CGOSeDFGocuHUBgSt+ig5aZ27d7nHwVIRMFZInIWd1OKs9+sE1GZcg291NsbGuz2DW7z7VW1F/zW/2YWrAjnFuYSoH1nOD/rFntcgSvAMOB2Fwd9B1eCXuVPGgUsj4GMohPtSm/G6fiZaI/U2DrgGmBistnk1CeTc+FoWbrCT4hLmsTLOv+VXShxEcHT1ifBtvGbkMKhJkO/a3Utfn64VU8uoeK1Ym7HCDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 18:34:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Sun, 8 Mar 2026
 18:34:29 +0000
Message-ID: <a10faf04-36c2-4070-ac8b-86b110e6976c@nvidia.com>
Date: Sun, 8 Mar 2026 20:34:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 8/8] {net/RDMA}/mlx5: Add LAG demux table API
 and vport demux rules
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Alexei Lazar <alazar@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
 <20260308065559.1837449-9-tariqt@nvidia.com>
 <20260308085248.2427feed@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260308085248.2427feed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e02b911-9129-417e-48c8-08de7d415528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	dQjK/FlfIjC6XYlj62DxX0Cpt6Gt9RcpOuzoZlLiVyak27DSUDMcseMX/1TfcG5k+OC72baNGMajkcivgjrKhmoGZUop9PiaomthCgDSQnZ23ZR6pfm8JzZDanRMHQxqdBfcoxuw/sYcZJZWreGg1VTPPqbNZYcfAnb0Uc5/u5lLv9jxUNHA59BVaY8NKv5t/IhYldzNWOcc+zv810a22tI5Zb3hzkcKBVA3OnFetkENqO68JO57NEgmglMLiuCNDJxYiu5GggcBHJa4ZwyfIRW+ZTJFKrzzhYMKbULDsuaffXO3HxCBURu8vtcm9VFvPCmCNJUAOcha6p52PwLi1m84e6naOfqGdBcAfkOUpsw/LgfYuPCaeNXHGcHxOIlwn+huSN6pmwePbNZw3H+QVOms9zHIhxGoDK4Z713ETg2QCWZcH6TIiPSmte8OcNU3KyrPtm5vo/M/MIfuNbLSE2OoRdHTvzCfluSYLAE8r8kYZQAvtmlywSm2qm/FivH5vYw0enDF+ASLlIEkNs+/iAHOApR54KsH4/TuIUYQkprdD08Atm/ZtDnyt8oeiuznEbdqokD6OB9ny7+CahePIu1Xxnt4NxfUs4TwmAdY2dKwXCwow2QHSu7ah43CAzuDguN/OCBuaC0mAylh5gF9Liaw8XWY53d4WeW2tu0fnj425Q5Ir7K7e29hTe0/vBW0Iynhf40KTt/nS1HnbbMkCcJU1UnVnEx+u08HKXI712M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDY4djRCcXQ4aVJ6K0ZCUVRhSXlRcElDczJnNXBTTCtONFpOSHJBY1hxbmxt?=
 =?utf-8?B?VzkyZHJxZ2xCYzZ3ZW80OFhrZVhjVVNNSmdVY0pHcThLeHJaczhlYkZOdEpC?=
 =?utf-8?B?NlNKWHkyU2RoSEpsZVdVL0VPOU5aYUE1bm9xclYvNDJFYjVVQVpzYXl6WGc4?=
 =?utf-8?B?S1poVHRJYzdZWWNGSWtuK0hqZlAxTXVjL2FKdWVTVlNoQUpVbFl2OHRrV04w?=
 =?utf-8?B?UklmaFZ0UlhzZlovTkFXT3RJaXZOaGFFZGljT1NBZVFYZnlnU2VLUkhjQVhN?=
 =?utf-8?B?SmVER2krb0YydUVjdUZFTW1kd3hSc2JtTWFPUnZwb0JwWi82MHNYODB4azg1?=
 =?utf-8?B?em92eWJlb0k0Rm9aOUhpRlYzU3BFVXhMYTlYRlNrU3JXaEZDRVF6QVRYRlRQ?=
 =?utf-8?B?NjB2RitDNWxsRERHd1VBd2Q2R1Yvd3U5b05EWk1TMHk0blFhZkt4TlMrMTRE?=
 =?utf-8?B?dlczK2xxaDFhcEFiRS9WR0pFZFl6ckRMT3FVSWpURVZ6RFFUc1hqTDNhckMx?=
 =?utf-8?B?TXFXTm9RQXpCeTVtMkxXL1NlN3Y5TEpOYTBpTDV5em4reS84cjdBZ1IxaHRT?=
 =?utf-8?B?VTRZT2JuNUFQVE8zSFo4SW9zNWt4ZzFRaTIvOEJ2eEZGK09Wb2FPWW4vSmdp?=
 =?utf-8?B?QWhmKys1enVFY1g5OHQ2VGNiMCtGcFdBVXNqWWE0SWZVeGZkN2ZHTFBXOG54?=
 =?utf-8?B?N29iSlJKNGozQU9ud28vY3Iwc08xbFI5czN5aDB1RzBKL2gxdFpIZklodTQ1?=
 =?utf-8?B?U0thQlB2dzVqZ3c5bDJ4NVY1L3JkZUF2NTM3VzM1YlJUdzZNVWpUUHVyN29Q?=
 =?utf-8?B?bllkdDNiaHJla1pYTlEwMW9QdnJIdmg5TjNFQUdSWmU1UUFWU1N0WnAzWVRt?=
 =?utf-8?B?aEdnMTZERmlPblRGdGNvSEhvdFVPZFFjYkNQWGFyUUtqQW9nemlGcW9kejVq?=
 =?utf-8?B?ZXhDbENvWHZ1ajk5TU96bHhneFRUV0cwWXkxai8zclJ1aHFXdmZRdnZGMi83?=
 =?utf-8?B?REFFdVc0em9FcUpoUU8rRE5renhkSXE1RDF0MFM5dloyUHFrUkM0elZ6WFF4?=
 =?utf-8?B?VXBPSi9zRUJHT3VETHdJckc5OG5VbktSQjJRdEt5YVZpK1lxV2NuczNpS2hx?=
 =?utf-8?B?SGY2RTh2OGtpN2R6dlJ3QStqNm8rdEdiR3J6Z09Oa1dwUWNwMGxIaWQvMjI5?=
 =?utf-8?B?QlhKVTN1aTdEZFQwWW9BV013T29DT1NhOXhFL01PalQxQWV4cFNZRXJwaVdW?=
 =?utf-8?B?Q1JhQXRQbUh5ZlZjY2dnQWxpVzVHQmdISmxMcHh1RU9wYVp0dWdDTGFad2Zx?=
 =?utf-8?B?cmRnbXkwZG41UWp5bHAvbWpta1dXN0hVQkY4Q3IwcXlYb1pid3RBanB4ZU5m?=
 =?utf-8?B?Si95M0VLQVNFSHk2MStWbUF3TEVyRHJmdkRERC96RGZ4UkRaV1Zuem94M1hr?=
 =?utf-8?B?TUg1NUFTemlrazJON0dnNXhuTyt3clU0SzZkMVJyNGNlZDA1NFQ3WFlMb095?=
 =?utf-8?B?dWpQUjJnYWJmTGpoM1ppT1BsQ29pSHdoQkttWmUzazQrQnA2cS9iQkN0VmlX?=
 =?utf-8?B?dmxMYzNMSlF1RU5DRWh0ZjJDRmhqL3JKUHJDOXJlUG5qa1owdlRhKzhWUmV4?=
 =?utf-8?B?VGIwWTFRenF3czRVMzZaczdndE1VZ0hXNHVwODNkTDV2cTdBd21sQVRsV1R4?=
 =?utf-8?B?VUJSUHA1WU51V21Yd2JpejF1a2ZaL3ByU0xnekp4dGJiSzdZci81TGNLSzRr?=
 =?utf-8?B?OFJ1U0FHZklsYy9TZUkwNVpURGxJK21nbmRrM2E4N2NLb3JlSTFxamR5VjAx?=
 =?utf-8?B?blY1UEVVVXdtaHV5WTFrK0RIeE03MnRDVUU1UXZDYWJGYTdOWFZEUlFhYnpx?=
 =?utf-8?B?a2hqSzU0elJOd2t3NHEvVE55T0paRk12UzZtVktoZ0FIUjJDcnBicjBnS0Qx?=
 =?utf-8?B?ZXU2Zzd5Z1NLZmdDdlh5MFIvbjdyOWV1RWZhSkV1TDFFUmh0dFUrMnRLLy9C?=
 =?utf-8?B?TlF3Qkl5Qi9VMndvWDNHczNsaDBPdFJyc2RLTGFGZGViMGxqSGNXbk5IQmJM?=
 =?utf-8?B?U2ZCUlV5c2VxZHhVZ0psQkI3SmNMeUxRQ01sSUNrOW5LTVRLaWJqb21jU1VI?=
 =?utf-8?B?Ykg5eHFERlFTTTViaENIZ3NrV0RhV0w1bWxnTWVMSm5MWitsZnB4cXQrUjY5?=
 =?utf-8?B?TWNXOVRMYWlLRXdOUS9Kb3I2VyswL2prejlDRllrMEI2ZTZvajFsSnNKdmhv?=
 =?utf-8?B?dlgxVDF4TUY2d21PWjhTQytCTDVHeUZsMERMWkhOQVB1eHZ0cUlhb3p4VUlh?=
 =?utf-8?B?azVWc0t5cjNaKytWZHhyWDl2OFY3anBNWEk3RDRmbmhyTlpuVWNDQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e02b911-9129-417e-48c8-08de7d415528
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 18:34:29.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpOLbSofB6pbb0mEFiMOF9R/Jxyk7HzJU96CMwWqdhSYapTfPq+ToDBTLJG6eNFLgogocFOD62jXMAzHFVweyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
X-Rspamd-Queue-Id: 3ADD2231B18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-17727-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action



On 08/03/2026 17:52, Jakub Kicinski wrote:
> On Sun, 8 Mar 2026 08:55:59 +0200 Tariq Toukan wrote:
>> +struct mlx5_flow_handle *
>> +mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
>> +			       struct mlx5_flow_table *lag_ft)
>> +{
>> +	struct mlx5_flow_spec *spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
>> +	struct mlx5_flow_destination dest = {};
>> +	struct mlx5_flow_act flow_act = {};
>> +	struct mlx5_flow_handle *ret;
>> +	void *misc;
>> +
>> +	if (!spec)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	if (!mlx5_eswitch_vport_match_metadata_enabled(esw)) {
>> +		kfree(spec);
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	}
>> +
>> +	misc = MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
>> +			    misc_parameters_2);
>> +	MLX5_SET(fte_match_set_misc2, misc, metadata_reg_c_0,
>> +		 mlx5_eswitch_get_vport_metadata_mask());
>> +	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
>> +
>> +	misc = MLX5_ADDR_OF(fte_match_param, spec->match_value,
>> +			    misc_parameters_2);
>> +	MLX5_SET(fte_match_set_misc2, misc, metadata_reg_c_0,
>> +		 mlx5_eswitch_get_vport_metadata_for_match(esw, vport_num));
>> +
>> +	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
>> +	dest.type = MLX5_FLOW_DESTINATION_TYPE_VHCA_RX;
>> +	dest.vhca.id = MLX5_CAP_GEN(esw->dev, vhca_id);
>> +
>> +	ret = mlx5_add_flow_rules(lag_ft, spec, &flow_act, &dest, 1);
>> +	kfree(spec);
>> +	return ret;
>> +}
> 
> drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1512:12-13: WARNING kvmalloc is used to allocate this memory at line 1502
> drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:1532:11-12: WARNING kvmalloc is used to allocate this memory at line 1502
Hi Jakub,

Thanks for catching this. We’ll address it.

Also, I saw IA flagged issues con
“net/mlx5: LAG, replace pf array with xarray”.
Just for context, lag_lock is already a known problematic
area for us, and we do have plans to remove it. I ran the
review prompts locally in ORC mode, so I assume I saw the
same comments as NIPA.

So the issue raised there is not really a new one. lag_lock
already has some known issues today, but we do not expect to
hit this particular case in practice, since by the time
execution reaches mdev removal, the LAG should already have
been destroyed and the netdevs already removed for the driver
internal structures.

Mark

