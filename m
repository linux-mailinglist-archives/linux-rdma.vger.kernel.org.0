Return-Path: <linux-rdma+bounces-22283-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2LLCGoKJMWr3lwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22283-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:36:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 730276934BC
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:36:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=S4kaTN9X;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22283-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22283-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2899A3044012
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBA5478E53;
	Tue, 16 Jun 2026 17:29:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDE2750ED;
	Tue, 16 Jun 2026 17:29:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630994; cv=fail; b=F5Un7edjqiYXbRK/vtcaFq+sS4qy83yD6gkwx8aUOAVyXYfsUF428WIZkBFaLl1LkUID2ltyw+VH7mGOowwNgtHef+NLo7s38hPsSpbmfTKEUuQ4PqTjfEyxSvgQVsuQLtY3Z9gK9siGSjZzHked/RMlE6G6gES4PGk9j7+nzDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630994; c=relaxed/simple;
	bh=Q+5grJoQRu430WXh6bjG80G5JoTOk2xp3xE77ZyhRoI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=esnSVNxqm0QP/pyNaMi6yC7sEVomDl01qUOcBRbKfVe89MNvEZ98xGt61WIjTeQKXj+PEKweTEoQlLEy12UHqtSFT5sC4IcexXSfMggkacljpegOgWKyS8MOBQVseVuGSPKeMC0JtszVWU2LlF3BSX6Z8H0MvkdTgbn/GTmSO2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S4kaTN9X; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR43eT1RVEC9wjxLDWIHg6JAc5+wz5ZdLDELznSIR+mvMfvrNltwOamd5rtYijV5hpe01NUvidoWIh5BrArIlDbR6LiBVw/WJ/FpUfQ2UpwLWUrXZRniuoRapDbQgWkWIFdxQGSAEzVtgo+8DCK3nsLQADqLmRRZKuf8Dma/yy6+SAAsuqVUwPvx4k8JAu0zY7OIU3IRkMBvPZA5AXXL79jrgFxwCZOQJ7L9z8ZWq8Ta9HgfTBVwJVMNp1z4kU1GbMip4jRYHCuw7+Vr2q0x/4dvD2N1lykUcSUjK2uj2UL/XI7DMBNj+Seh+wfT36+B2OGNflt2Va9aEXrkp3S2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvwbOPWoVo3Oyv4KhP1CeNZA4z7mPqMqt13wHYtQ6Ug=;
 b=A3BYiKXTIkw63hyX1mcMHwOiWdFTh1JWB96orxHjmx/ULCgGSHF5UkyS285bbJ6gPVaGbmtx5+s4z4Qq+cwy8DVAy18L6XszitLWs5VdguIHFSt9G4iqnj+nC1BxTFm/RYC8rdVLfxGedvHode9HfVKP63U0rpW9YzJguwmTCuRMCDP9/KnQDE+TfaYSxPZRLE2dU7NT5r/0dczZmHJnqwOvD0rObiELPn6mFTvUAYKSkuiHYqZmZlyk/KpqKN2yfiEnpy0+WBzOlimHVuEGHYGXF/kIph24ruavytjglhS7hW/CeQS8w4J/wfRp/s9QB1AQkgMWb7GzKqKEnOt7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvwbOPWoVo3Oyv4KhP1CeNZA4z7mPqMqt13wHYtQ6Ug=;
 b=S4kaTN9XifHsm4LIpW9ZJxGzgXN8rSl02flBb5SAeFwhupIDhfWXARMvIkA7lnyi5y5OpYw7cD2SUaFX8QLPbQsm0Gx/he7waQO2+Ec1G3Xxiwmp312P+Q80eTplLQx2Mt/8VhKKiPVcvc1cr1cxjjvDgNH5TA3AyHDrKq2e4Z8W6leRi/m/dXvsP5Vrz2SV+RHl4U8/04KD51pm38aGuQxqfDPf87k+oKx6aR96KY66Lv8lw3BgDzrwWJyBRg26zSmuAlSs1XeyaiV22gRXf5EJWkm13J8oTj34r6v8eJqCu8WCufvZjJEkb+FfAU50kyP9ZDtj52bl9uSVfqLTug==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 17:29:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 17:29:44 +0000
Message-ID: <7635d50c-1c82-4090-8907-53a72444fc04@nvidia.com>
Date: Tue, 16 Jun 2026 20:29:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 2/7] netdevsim: Register devlink after device
 init
From: Mark Bloch <mbloch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Sunil Goutham <sgoutham@marvell.com>,
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260605181030.3486619-1-mbloch@nvidia.com>
 <20260605181030.3486619-3-mbloch@nvidia.com>
 <20260610165053.7c91f331@kernel.org>
 <eb525345-da07-414c-9d05-7e00e3eb472f@nvidia.com>
 <20260611085440.4fe36bf2@kernel.org>
 <f266dfa5-0c6c-4be0-b73e-b2185dadd6a7@nvidia.com>
Content-Language: en-US
In-Reply-To: <f266dfa5-0c6c-4be0-b73e-b2185dadd6a7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 26205119-87dd-419a-ee57-08decbccdac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|18002099003|22082099003|56012099006|5023799004|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	A0EaCErmmQ+BNx0a6iT4LtF4wRdjleEEUL+Mj9HVXbDZbyReu9bIN9If+68atHAabjSe337J8AZuC+3dDZxVM+REvjZCQ6dASs7kq7jsgoSWGfo8ewIjqkY0uLO/qB0z2ZoD4NmPw0e8EjmGml9kdnqUfXW/+72R5M/imQ5CGn1SovCFvr2lFQRTyy34XsQ4k9QHsbLCU630TfwYhifYOT4z00M1aZdTV7SoE6phuv7BtLx6JtBO3Dv1vkwcK+y1cN16bsteSmTiBrrEk0kPKP4RPd8yxW+dtvvQfvpJKPFejGJccDt/Gbvm2/qfYHKYf4rV0yVstwj37qpOfkh8fReCUHo0ECUImaSPSaslolEXdG0eHuyg/X5DTQQotrsNSFs2FUIGE98789xE1uK3sNsXOMTi8qy3KXG1nkGg0l7kz2+kPiEdiOmAo4oagiL5JwO+0iD/yZZOTZ5owJxJHc0LoVUjVhY9k5NLxgOZSFyNVazeb6qTweotkJaPMZhfaV2MNQv/dvzDjvEzt/WdTTLaInOpFTmMTjZk+yno1j7NwGMbjj7wun1wVaCUg97z4uzydqgUNatP+vT+1NC2XA7NS67F9kIIzAaYjdZjoHH62NHO8hgqnpD3JIdqXmebo8yiw3R1Orog+e33Yr6Ib0rUrR4+Y+xvQQTDKsQeTkc7LTT14erkyF7Mn2BFK0lz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(5023799004)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGRSVkU2UEpFM3BaK01tbENwS08wU2t0Kzk0SFNkelRaSWw1VGxHd3lKWklL?=
 =?utf-8?B?RDBxbHlzWTVQcmJGT1ZHOHp3ckUzOU5XenhzOXgxZjR1Q3FEeEVnaGRUa3pK?=
 =?utf-8?B?ek5pblpPR2Qrb2hKRWxUN2p4WCs1RmhjTUZsN284TzJVdExhMDhiaXBaWVZN?=
 =?utf-8?B?azgwMFdLd3g4U2hxQWFid0cxS3BIQUJzM2hWWGNqUkw2dUh5MVhWRXB4ZHBD?=
 =?utf-8?B?N01NK1o4ZGZPbnNGWG5sdzFwMU56RGozQmpPWUZ3RWsreE1Oa1lCRzlXK01B?=
 =?utf-8?B?b28zMlVHUkx6NjZhWDFsbXh1MENkRVpLMGV2YTVFbUs4bk1TSm9hTGFmdkcx?=
 =?utf-8?B?bEhFaXQvZExyZkNoVnNzbnN3MHVOazZsUW9Fb3NhTDEvNjNBVkl6eVBXckZB?=
 =?utf-8?B?SkdibTZEbHZjYXRxNFJTOTRmSmhRYUpWK0V5U01oc1NWL3NKZk9uSExTcDdY?=
 =?utf-8?B?TUxpQzdpTWRwSGE1VUxYdWRTNXhESHFhWUxjVHhab25Odk1zTTdza0Z5TVdn?=
 =?utf-8?B?UklLc2hNSUtBeDFaNmpWeGRaYXYvUVdOMDlBU3ZWQ3RqWnp6OEp1ajBjUndl?=
 =?utf-8?B?ckJsNmJ0UFRXeXFiL3k0TWRkVTBaSC9MWDRnUHBnbXM4N2wrTmIrWXIrTE02?=
 =?utf-8?B?RUc4M044L3l2bEZvL05RNGVseTdwZ3NQSk1qRGloeGhXZFdBR1BrVmdGMGZF?=
 =?utf-8?B?REl0Q1dGUVVCditmUkhoL0RmZDREdEVHQXd5ZFVYRWlrYU5LY0YydWhOK2dr?=
 =?utf-8?B?bzBVVTZZbDFPZXowMVVYMGFiUTFWM01nOXorK3lqbmhKTU8vWjNkZERmWms3?=
 =?utf-8?B?Uk9kcE5tNG1lbWw3MEdLVmpuTmQwb0Ewejh1YzFiUzZJVlFmVzcxTCtvd3hp?=
 =?utf-8?B?YW84RnozZStpQk0yVklBZmVDWlB1YktyOU1DYU1pR0RZaVVQUHozaGFweG5y?=
 =?utf-8?B?bjBuS3V3UjEzYkcyWnhqNTRZTFo0Y3k5VzNpSGdEd3lDN01WcU9IV0Y5M2I3?=
 =?utf-8?B?SklqTkhHNmJiYUNLYXcwSVlrbDlBNW1hR1hkR0swUGtpcmRDWXlwdGZUZEdL?=
 =?utf-8?B?Qk52UU84NXRHNDRmb3h4Zm1kbzdzaGQ1QVBvV05SaGtqZXZkRUdTalFHWHQ3?=
 =?utf-8?B?WkorNVNvMTlaUWZVTDMyL1ROQmduMkYwblIvWGtUYnpQbHJSUDRPT3JDakUx?=
 =?utf-8?B?bmJoNWVnaDM2ZFVkUEF3a2F3VlkyTWhzWlVjK3ZhRzNnOVFvRzJpNi81Vzl1?=
 =?utf-8?B?dldIQ0NUVFlTYzdVTWppQTVQQ1RiMEFDZzRUUXdZWGdNZUx2YktEcmxuMVFu?=
 =?utf-8?B?U29nSEJsNVNUcnE4T3Mya1gwazh5dVI2THhSNDA5bStwQi9RZmRCeW5mVEhh?=
 =?utf-8?B?R0s0ZFZzK0tiQXlENUxGYXk5Qk9rUVZ2NzNsQVpveU96QWVmL3Vwd0pyT01I?=
 =?utf-8?B?MUc0R1R4a1RYRlJ1Ymk1ZVJFYTlHeHM0WG00TU9SQloxUGpCTTU4ckUyZEpq?=
 =?utf-8?B?ZHBKbytDNlJnZXRBdDNTOVFPRXMrRk5NVCtnMGkxbm8zdkJyeUpuNUFDckxY?=
 =?utf-8?B?YVZGeXBXOEZTbU0rS1hmeVN4cG5xOEdOZDhPVTZIekRJU3BBMkEyRXAzcHVu?=
 =?utf-8?B?Y2YvajFvc0N1Zm1tVWNhMkZwbEc4ZGRWTDJkeHBPekF6RW1BbTc2cXViOHlN?=
 =?utf-8?B?Sk5GcGVuTlh1cjFCa2FCK2F6bU93WUx5Y0VqUVI2Wkk1V1ZEZnh4UGJjaTZJ?=
 =?utf-8?B?VTFvd2Faczc2Y293MVFIZkVvajZyVEovNzAzTFYxZ1JKMXQzYUlXL0VITGhp?=
 =?utf-8?B?QzNZclRrS2d2c09qWk94M2JOT0FrUzZUNGU1ZkVrNE9oSVZKZFEybXNsK0hX?=
 =?utf-8?B?TVJ4MW5MNy85bnRmRmRJcVhPZTByZnBTdU05cm51Q1JBSUd6RzZZeXZwT0Fk?=
 =?utf-8?B?dEdzZHcyZExHM1dWTk5zTkNMK3NMQ0dOOC9UT1ZweXVpWmJ2MjNYSGJrNk55?=
 =?utf-8?B?TjNTZ3NORHB1bHhHZGowL1hlVTZMNlVnWFRXZ3I5aXcrOVFxTXhFY0daY0dS?=
 =?utf-8?B?MExyVllSSzVueER4R1lYdkpmeTd6WUI4UTVEaVJQQmduVlBNYzRIVjVnQlI1?=
 =?utf-8?B?dE9VT0hPQzYzRkxOcVNYRW1KMXFLOEhCZnl6V3ZkNU1rblBHenNETHhQTDJZ?=
 =?utf-8?B?SUFnZG51SW5jazF6V0MzbTNDMSswSnpMU25scW14cldEd1R1ZVI3RjBCc0lE?=
 =?utf-8?B?V3RTNWdUWUROTjh6ejg3cFpxSVMzUVJXYi9yTHU1Ri83NGZCamdjVG5CTGl2?=
 =?utf-8?B?N2V3TXRiZWNZQTdiTXI5Nnp6SGNGZVVHNlpNQlU5S24yU0tFcXI4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26205119-87dd-419a-ee57-08decbccdac5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 17:29:44.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqLGBeCi3Ra51l6AI1moJmVHZFYpTSZSGUNhLvyZ8yqxyUg4wo3wdGsCSG13t1Tf4KmqGxvmLQWT312kl1a3XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22283-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:jiri@resnulli.us,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 730276934BC



On 11/06/2026 20:43, Mark Bloch wrote:
> 
> 
> On 11/06/2026 18:54, Jakub Kicinski wrote:
>> On Thu, 11 Jun 2026 09:02:03 +0300 Mark Bloch wrote:
>>> On 11/06/2026 2:50, Jakub Kicinski wrote:
>>>> On Fri, 5 Jun 2026 21:10:25 +0300 Mark Bloch wrote:  
>>>>> devl_register() makes the devlink instance visible to userspace. A later
>>>>> patch also makes registration the point where devlink core may call
>>>>> eswitch_mode_set() to apply a boot-time default eswitch mode.
>>>>>
>>>>> Move netdevsim registration after all objects (resources, params, regions,
>>>>> traps, debugfs etc) are initialized, and after the initial eswitch mode is
>>>>> set to legacy.
>>>>>
>>>>> Move devl_unregister() to the beginning of nsim_drv_remove(), before those
>>>>> devlink objects are torn down. This keeps devlink register/unregister as
>>>>> the notification barrier and makes the later object teardown paths run
>>>>> after devlink is no longer registered, so they do not emit their own
>>>>> netlink DEL notifications.  
>>>>
>>>> This is going backwards. At some point someone from nVidia thought that
>>>> we can order our way out of locking, so mlx5 is likely ordered this way,
>>>> but this must not be required, or in any way normalized.
>>>> We (syzbot) quickly discovered that it doesn't cover all corner cases.
>>>> devl_lock() is exposed specifically to allow the driver to finish
>>>> whatever init it needs without letting user space invoke callbacks, yet.
>>>> Almost (?) all driver callbacks hold devl_lock(), so maybe the devlink
>>>> instance is "visible" to user space but that should not matter.  
>>>
>>> Let me clarify.
>>>
>>> No locking is changed here, and I don't want to make register/unregister
>>> ordering a substitute for devl_lock().
>>>
>>> The only requirement I have for this series is that devl_register() is called
>>> only once the driver is ready for devlink core to call eswitch_mode_set().
>>> That follows from the earlier direction to have the core apply the default
>>> mode from devl_register() instead of adding an explicit driver call.
>>
>> This is exactly what I'm objecting to. AFAIU we are trading off
>> explicit call to get the default value for an implicit behavior
>> depending on order of calls. We want to optimize for how easy it
>> is to get the API wrong, not for LoC.
> 
> Right, the reason I moved in this direction is that in v1 I had
> the explicit driver call, and Jiri asked to make this transparent
> from devlink core instead.
> 
>>
>> If we don't have a clean way to implement this without driver
>> changes let's add the explicit API to get the default value.
>> If driver doesn't call it schedule a work to go via the callback
>> once devl_lock() is dropped. That way drivers which care can optimize
>> themselves by reading the default value upfront. Drivers which don't 
>> care will work correctly, and there's no API call order trap.
> 
> The workqueue fallback is possible, but I think it makes the semantics
> more complicated.
> 
> We would need to track devlink instances which still need the default
> applied, and the worker would have to skip/remove them once handled.
> 
> More importantly, the worker can race with userspace setting the
> eswitch mode, so we would also need some state to tell whether the user
> already changed the mode. That feels more fragile than an explicit
> driver call.
> 
>>
>> Not ideal, but isn't that best we can do here?
>> I still have flashbacks of the fallout from the call ordering games, 
>> we have too many drivers to keep this straight...
> 
> That's why I started with the explicit call in the first place.
> 
> I can switch back to this model: drivers which support boot time eswitch
> defaults will opt in and call the helper once they are ready. This keeps
> the support explicit per driver and avoids making it depend on where
> devl_register() happens in the init path.
> 
> With that, devlink can tell at register time whether the instance supports
> boot time eswitch defaults. If the user configured a default for an instance
> whose driver did not opt in, devlink can write to dmesg from
> devl_register().
> 
> Not perfect, but at least the user gets a visible failure instead of the
> config being silently ignored.
> 
> Mark

Jakub, Jiri, any thoughts?

I think the explicit helper is the cleanest option here, without any
workqueue fallback inside devlink. It avoids depending on devl_register()
ordering, and makes the support explicit per driver.

Does that sound like an acceptable direction?

Mark

> 
>>
>>> So if the objection is to the commit message wording, I can fix that and drop
>>> the "notification barrier" language.
>>>
>>> For unregister, I can probably leave the old ordering as-is. I moved it only
>>> to mirror the register path, which felt cleaner, but it is not required for
>>> the default-mode change and as the lock is held I see no issue with doing
>>> that.
> 
> 


