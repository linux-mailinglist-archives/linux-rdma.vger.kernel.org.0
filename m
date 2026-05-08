Return-Path: <linux-rdma+bounces-20260-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMJiH9su/mmvngAAu9opvQ
	(envelope-from <linux-rdma+bounces-20260-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 20:43:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A04FABA4
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C9C230733FD
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9FD3F1671;
	Fri,  8 May 2026 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WlTrTSr7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D992C3E869A;
	Fri,  8 May 2026 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265759; cv=fail; b=Y8aPfxBVpR8d9gWrBefd/sQDV1bEYcrTIFKT+Ejm92tz+hp9kugTJlRzW41MeuyuFnhq2wvJ5xW4IbwujoX5DaLjLebVHkbjzxMCGLDAzuXII+dLXD1+YrjA2B/QbzAWaapXnjroIm1smgDP06No3yIcgIFe7/M6gR6+ch2qObQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265759; c=relaxed/simple;
	bh=QA0renCzY3IOc2dzjRZ6lb5xa+6hREvFk9wwXfeVGdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h9YcnzwQaGj7kQEz2hUnAM65a1O1FSzVPTbhjy7z/ZP/azyqEjYr2aMJqPARND1c5UCHR1ZD/unt8yrmVhCWMlFb2NP+Fbjjwvph6K/lHaQ3OopTjq+vyQYRcvG340WF43iS6f5Sg0Kw391bDEJjlJT65+lb6ZvGxVdLHbI4jgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WlTrTSr7; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILafuUBLYD/A3Z/mVFhpvdk2F2yy5W1pIKp4udZFMwWNkZybfsm5yvvAYgJlDTVeDW/mBixt+qBvp+zIwo07plpEHhAPTC3APlojXRAZ80AC304IxGP4hFvt6KlArgSIpd2OWF4Bi4QacOOk+c5esPiKVqC6GOtlxAEl8LSWCXRGBYoIQMPqwBoDYM3IzpDLb3e5STLxsS9kn0mnQgBSQpE5TZAvaa+RdN1xCtYeuQZI8l96p59jEnRQLrcYB/HHX4F4SXsmGI6+vl1vNAeUqEMINpMMXypLxA0obZYNQ/UkfQk6ZdbvD88CuWjHDW2Aa6a4C2e03ltcjb9+ZIhvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPI4sTAXJVSFALkNXQg8sjaQLMctn5w5bGXoPbwFOH4=;
 b=UOEto3tPg8l17CXY1SzXQvM2+kNkDilCcfF3g0LRhfB6nKGbaqxt9MGcQDRr4rr631fNdjVWtxXX3EotdSETEHn4NpiPr4PY3E4ze+gGW4c+vH/FGvK8eM1GRyEH1/2kPDK/phZUd/8JkG0WgLaE8/qO/TMELwGq19q203GA8qPKycHRNUmGjjNl8uonir01/VB2zAfDbQdoGj2F/TW+NgyYBPlxMt6oXmIp+0hOrf5rLJdakUeE8Gw6EmfVI/r2imuFKA73VCHpiFo8rVpPu5V4GpmhIUn7p9blQerj+USRhkjQSgChTnoKFJ+MxCIbmSgg0wNRe4Uk3m0T6ygauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPI4sTAXJVSFALkNXQg8sjaQLMctn5w5bGXoPbwFOH4=;
 b=WlTrTSr7pxa0NQWFHY1t5yyq/KohgKppjN/OBUQlHwF6XCuzGLkh05HougLfN7czmaQCzhBmbIZh9w6rL2NKNC3e6ZFIyChdMODMFrZ01DhvLRuDTn2BTA94m5EpXdx39V0jcqNAJVr4M2oFlS41e5t5FeRrxnMf+Q/Datf2FisZdL0KOx42NQBRLdF3JNAFI31r1/00gpiYDlSsdunhKBWnHHpCXA30c4ui7iffDQkHpVqfDVH0TxulaedP+2c95oHOl+GxBpeecclSI1WBPjDIulvudvLwQ/fJCcYbcAqYfaQwjEKsBWB62k1oGQJq4zVWgV8r2bu/Z3tgWi1n9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 18:42:34 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 18:42:34 +0000
Message-ID: <6b7998e7-b2c1-4650-9564-679d647146cf@nvidia.com>
Date: Fri, 8 May 2026 20:42:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Christoph Paasch <cpaasch@openai.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>
References: <20260507095330.318892-1-tariqt@nvidia.com>
 <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
 <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com>
 <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
 <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com>
 <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0294.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::15) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d12241-d84e-450d-d0b5-08dead319154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/rUT4Urh2dZRUSunvqTiJbk58yvqLeQwCu/iyD+TXbEvAoQRcgoiQ6eT3VXIBZi+fh2U3AiVLmd3Tsyop7WUbQfPZYemqeL1eo4tcxPeDBJh9mss1NJV+gOd3Kos7VtgoEonyHLHPSgrHNiYoisP4zNds0ca76wAzm7/OPbxCqahaw8/d1sKsIPt3IldD8U8Hw1J026ZgiVvU/TtaqcAOClxBSAc7Vr83wetHBvgCTN0/sSY7ianZfAe1X9PWxV/Fw0p0AQhubOx2H8uIlkaNnW2rHZwfYOXF2tRF983OmlxISYZybc9iRJir3uNDki2aK/LyOU4jAtE1meYGfNv134rTsLyegoAfpHJcfxWA6YyrjEgp2BigXY0Ui3ZoISRyX8uKWlzK0HB1cL7EREXdM9N2Kt4DgGrSGuAeSBM0tbavcuuuiOoCi3nW/LQ7yUj2JPs/5bDA6AMB2BTFwLW8t6KkIy1SgB37HjAkfUmejMZX2kSw83OEt3LXCoYUyWyT9y+oBx3iPzbYCrvRsDO8QggML25UrG0anzJ80WAeDM1G6/rG3a1ErMIItYUtYZ07mkN8+j49Z3HCRzHS5uph+nIMF3aPfjlA2EZHPgiSU04iJ99MA+rufEZtlwx1SRH4OzRTdCts/BEUU0KW47fMlJaO4lqgGHeQ2VGo3HvUteLw5pROpaba1CZadpvo49J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVZaekJNdnRheXE3aVRxTmp4ZkVRa2ZUVnFsOTh5ZWxwUXZZWGtNVzlQWXJO?=
 =?utf-8?B?K0RUS09mZytRVFY1S0tlbmp2cHBDSUtZbmVkMkRLMmhoQmdmMVpLekg5TDVU?=
 =?utf-8?B?VnZURStIenlCa3JsTjlaVmhLdXhIbjlnaWJnYXBzeEV2UktoRU5zM2JORU9q?=
 =?utf-8?B?M3Z4dXVPL3NXQ21jOXpnRnI5NEdva0M3YklEa3BSU0ZaL2xsR2dyVUx4eXo2?=
 =?utf-8?B?S2ZHTzhHY2ZuNVkvZHBxWDAwV0RMdlFoeFFRK3piY3lpMGMyNi9kMU02OEFm?=
 =?utf-8?B?elNIWlhRK3A4TndadGpUM3pwUlhzM1pqbmh6NWQvMGxjUnNOL29vVXEzbGhz?=
 =?utf-8?B?czRkQ25URVJYTnlmK1FJOTg5OHVJVVc5cVRFTGFGbUNXS1RJazVtMkdkbWpS?=
 =?utf-8?B?WTA1WEorcHlGQktyMTJ3ekFqQS94MWs5SG9MSDJsbWh5YXdVVFJ3K0ZXRUpj?=
 =?utf-8?B?NG93cmluY0YwYk94dWlwaUR0RVIwSVdkNVlrZ3l2NFZCUHF3b2Jzb3RvTFRx?=
 =?utf-8?B?UHZUM002TTFDR2dqR3RoZ1VrRXpmT1kyU2ZTejNzMHVITW9lMnM5VGJuUzdU?=
 =?utf-8?B?SUlWRHQ1aGVNRGlLUENQc283c3YxYzd2L1ZSYkxiUTFkMnQ0TUpIYlVZTFZi?=
 =?utf-8?B?eXhoTE15RWVTVXJzazR0QVd5aEd5S1V5UUZyMCtMMGNJaTV2c3BMakp3eEVD?=
 =?utf-8?B?Z2VUVUlnMFF1aERVdjA3UkhMdGJQSk5VcXZuellSYURGZW82TXFYclp5b216?=
 =?utf-8?B?N2w5QmVzWkd0Mms4MnIxRGI5U1d2Qmo2ejBudzcxOVN1dWcvd2Rabm1Qa1Jt?=
 =?utf-8?B?ZHJKOGo5SitIcjFvbmxES2lnSEE4bko5bzA1MVFNYkNnVHp1a05uS3dwTjJS?=
 =?utf-8?B?N2MzMnBTRktmMzdBMjhWZHR3czlOTXRIdWhtaXdoeWdZZnFhdEMyYjEybzNC?=
 =?utf-8?B?bkRnMTg0L294MjM3QWpYcVlTZjBYQ2piWkkwenpnUGFMNU05OXE5UEUwL2JW?=
 =?utf-8?B?UzhOOGszQVdHV1F2NVBSa1hld0pXeXRWOWNzdmdhUGdqVi9vVVZsaVdsYWRs?=
 =?utf-8?B?S05lcVc3YkhPSWpPbXNCQ1o3TU54V3g3NmRuTGp1V0hZSG4xYVpJZWpGS0Jx?=
 =?utf-8?B?OE5RZ1VOM2REWkVrdGFNK3EzTmVoZUJTWE8xZkMxVVUyZGZpSkd2aXIvcFhr?=
 =?utf-8?B?eWd3bVdXdDM2c3NFZFJOU0p1U1VaME1McmVRanM4Q3JabmxOSmRpZmZUZUll?=
 =?utf-8?B?QkEyelM3RzJUcDJRZ3hVdm9BOEp2OWRnaGxzaGxZdkt1Z216aG9oZE5pL0lm?=
 =?utf-8?B?ZjdDYVJUdEp0N0o5QmlqK1VsWm1SeW9seGJTdUxndlFPQzlsZnZmNjhoL1ZW?=
 =?utf-8?B?VmhrN0RpL1MrVElzVERjZC82UkhQcEN6ejltTHlyZnVIeUpkN1p5QjZ5TWRs?=
 =?utf-8?B?cFNlRE9Xb2gwU0JERXRVeVpoMWpyTVRvbFU0YjR2T016UmlSUGVOVnJyNG80?=
 =?utf-8?B?TTdtZ08zL3JxTXhoUkJ4RldEOHZ6amw0V1IrNTV3VkNORnVId0RZcEV2dXNi?=
 =?utf-8?B?NE5JYXMxSGNHTjFEblZqNTV3MnVqUis2UDBsTE5MQVFpR09ITHVDbG5mMTVT?=
 =?utf-8?B?NVJJZ24vR2ZQbWp0dWxQTVdLQkw4UXFEQnVycHFXcTlLWjRwcTdvMXBoUzh3?=
 =?utf-8?B?d2p5Qk12eDlycHFBRUVkTXNacTR5ZHd0M2cvRjJ2d2pSYndXeW84azl5d21J?=
 =?utf-8?B?UkNXdzZRMks0ZHZPQ1pXaXVSK2xuY21sNGc2REk1T0xHaDVtYVNNQjRLRUYw?=
 =?utf-8?B?WWxNbVFjL1RiMU5FT3hwMlk5WnpqZkxKT2JWNzlNRk5Yelp2TlVjQXhzMVVL?=
 =?utf-8?B?Z3BhNHpXcmgwdFM5WFNCL3RTV29ZWVFqQXNCN3ZMOTJwTElsNXBOOVozMVow?=
 =?utf-8?B?KzZIWUN3WnRwam9tRHFUcjF2a3Qzbll2ZXozVWc4c1g2bWo1RGtlUjBVTWts?=
 =?utf-8?B?UTIwa1ZQWGJ1RXIvQUhRTVpWaldNSW9BVG4rUlhhSVhFYWRNYnErODZvR0lv?=
 =?utf-8?B?RGIrVHZaUTM0YTZWMmR0ZnVqaXJHMzArZEFFNm1ITTVydS9WcHdNbUp5MTRL?=
 =?utf-8?B?clc0UWdrd2orS3RBNHo1dFRrUTc1cXNzL1VFQjFOYjBndVdmbmI2VFJqRjRs?=
 =?utf-8?B?WDFQVDBVcGZ1Y2dReCszcjE5NDFpS1ZYRXAxNndvU0paMlRrTFRMemZHQzI3?=
 =?utf-8?B?RkpkRlczVWVTbXhhV3VtQjBSWTFqcEY4d0psclRRdis5T21xNDFqRTJGVTZB?=
 =?utf-8?B?NTlINVFEU0pSL1AzZjVnMjQ4bWRLdU1aU25jd1BMcW5tb1JmcXUvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d12241-d84e-450d-d0b5-08dead319154
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:42:33.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43GJiwjIH6Zy4PzIbMOCcvhzfR67nlmSy6avxZZkhfpJ3Dw916TK9UYQ7a68TaIfO4XZkx+eVXJ46wzNddGeAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107
X-Rspamd-Queue-Id: D69A04FABA4
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
	TAGGED_FROM(0.00)[bounces-20260-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action



On 08.05.26 19:44, Amery Hung wrote:
> On Fri, May 8, 2026 at 2:15 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>>
>>
>> On 07.05.26 22:50, Amery Hung wrote:
>>> On Thu, May 7, 2026 at 4:50 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>
>>>>
>>>> Hi Amery,
>>>>
>>>> On 07.05.26 15:53, Amery Hung wrote:
>>>>> [...]
>>>>> Am I understanding correctly that the better performance comes with
>>>>> the assumption that the XDP does not change headers?
>>>>>
>>>>> headlen is determined before the XDP program runs. If it push/pop
>>>>> headers, there could be headers in frags or data in the linear region
>>>>> after __pskb_pull_tail().
>>>>>
>>>> That's right.
>>>>
>>>>>>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>>>>>>                                 struct mlx5e_frag_page *pfp;
>>>>>> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>>>>>>                                 pagep->frags++;
>>>>>>                         while (++pagep < frag_page);
>>>>>>
>>>>>> -                       headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
>>>>>> -                                       skb->data_len);
>>>>>> +                       headlen = min_t(u16, headlen - len, skb->data_len);
>>>>>
>>>>> headlen - len can underflow but will be capped by skb->data_len, so
>>>>> this should be okay, right?
>>>> It is safe. But it might trigger an extra allocation in the pull when
>>>> len > headlen. We could also skip the pull in that case. Or do a
>>>> min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?
>>>
>>> Make sense, but this line took me a bit to understand. Maybe consider
>>> checking len < headlen first?
>>>
>>> if (len < headlen) {
>>>         headlen = min_t(u32, headlen - len, skb->data_len);
>>>         __pskb_pull_tail(skb, headlen);
>>> }
>>>
>> Yes, that's what I had in mind when skipping the pull. I would also
>> tag this as likely.
>>
>>> Another clarifying question. So this patch will improve the
>>> performance when the XDP programs don't change header length. For
>>> those that encap/decap, they should precisely pull only headers into
>>> the linear area for optimal performance. Is it correct?
>>>
>> Right for encap, but for decap not quite:
>>
>> Let's say that the XDP program pulls 64B header into the linear part
>> and snips 4B of the encap out. This would result in a pull of an
>> additional 4B (headlen (64B) - len (60B) = 4B) which are now
>> data bytes => sub-optimal layout.
>>
>> I don't see how we can improve this corner case though.
> 
> I see. Thanks for the clarification.
> 
> I think the "if (len < headlen)" makes too many assumptions about what
> the XDP program did.
> 
> How about this policy instead: If the XDP program did not create/pull
> data into the linear area, pull the parsed headers; otherwise, assume
> the XDP program owns the geometry. min() is still needed since the
> program can shrink the packet.
> 
> if (!len) {
>         headlen = min(headlen, skb->data_len);
>         __pskb_pull_tail(skb, headen);
> }
> 
> This preserves the optimization for the default no-modification case,
> and most importantly allow XDP program to get the optimal performance
> if it gets the final geometry right.
> 
I like this. It will also save us some neurons next time we need to
touch these lines.

Thanks,
Dragos

