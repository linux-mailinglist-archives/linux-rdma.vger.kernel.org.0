Return-Path: <linux-rdma+bounces-18081-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG2VJv+MsmkQNgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18081-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:53:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B95026FE62
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D80D030F2E89
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D913B7B87;
	Thu, 12 Mar 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fwyf3oaQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A638B122;
	Thu, 12 Mar 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309056; cv=fail; b=qGeCovZfTLDDdERwggOHer9k0EHzft4X4/yNrHma3hn1LQ+xooe+Hoa/5A5vM4CHPNaJeEetM8QZiKrnA1oBBkHObktoJd8j6s/xckKd59YwdjbNbZNGLgCToBiQll1xOeiLIaq6M4iYfxHnwm1L1NO7dZt3zymqHf67Y56FRwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309056; c=relaxed/simple;
	bh=mmLe6u1L4GgPCAOLo/W/M0GO9gqLdtnY1uIKQ68ANJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMd1jLMUqQX4GDvk90DZiSDarZ1CciwfnxAgDOhENnoT7Zs0vdoo81htOAdbcuaEJAZvDe50Dm8f6Jo7cx688gJ+It/ylhs/8iCIAceqUjC0MK0RLhWQ0ofoNnJm40WwIBZELNdK2uf7BDw7QaMI4KSIS4AZJnp+taE3RBKeOJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fwyf3oaQ; arc=fail smtp.client-ip=52.101.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVpCz/d/Iu3Pyi3ttkpw2lU4JIz9Hc7sEHkOhkB+dOkE+PeASucTMAEqtw9bsoehGcj1SM4qMpTCB/ngj3BGTrpPwZiCuYPgLRGCxoT3engd5qf7mLCziB+Pl7I3Sy/n3rR0cKvTq1SD3GXG4EUdtYlkCxOCJ3+HZL3cJSWapuNNs99rjGYwDz1f8oK8SS9FcAodFeO/1+/sgyLxVcCviwQJcYChryzIeDCeVNomgh9aWhRPz+JS2kzKLqAh7gSL+AOB2fP2cGTYFwUdvBXREXBQk3KirsN0PFpTNVuCWt++uwrIedvs4I63NseKhYSz8wKWisMde+N/Es4PpZoeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDG3HOPKjgPIxsalUAVoClSOZocwl7Qb8MZvAKPN3qg=;
 b=tFj/meWZFRTyduFzXbcBc4ibcfJPlmZbNHtC1l7QlIL8l8OH5rmQbPqdzeU2JeMLUA5X0D3tnjnB3bL6t+/WT34MXOZBfFYmt9tgaRdBqDWlTJnsX3FOHDu4Zuysn7xdFWT6A2DG/7bErX9fBGBjzuws83pZslO6kVrmPuW0Ia6lL8rVkssv9ymXUK0MTHWkwfosRIGkp/9YlONmb61jIxurBdwL1u2l3btNJAqPEASGpJun/qw3I0XOgSXfeuZItTMkm3fn9I5r1uVbt+q45KlHhPjwkUw6ZgIWs/rrIIhf1JMM7NgW4Aap8lQqBXtG66Pz632bjzopfyk9XaPCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDG3HOPKjgPIxsalUAVoClSOZocwl7Qb8MZvAKPN3qg=;
 b=Fwyf3oaQJLY9HTeXn9FVF79dQGHlP469te2VnSVjeA7S53JjWPHT4wA+6W4L/tu6jmjP6D46GquRLRwBtcXtZPr/b9P8kJF9UH31GEz+VHtKSNfHupgHbTpEVSbWpqe9IGfDgtGby8TNan2iLt3wt9bsBo1GIkbcVArrTZ4a/XozU4OjAd/pePtf1gFHhxbMWgXqNKEvONW0QvlTQRQj9YefyE+QJE70t31MpHxi+LrVM4sFd1pU9Mf3h5inruqRGHIks0+qxE2/9TATZuVS7brN37V3iVJoBUTHgNLrBpKP3uo3oT7GLZHtT3R2LQaH1iZ687MGuF4pznOSX8OHYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 09:50:49 +0000
Received: from CH0PR12MB5236.namprd12.prod.outlook.com
 ([fe80::f025:9f2:ccaf:6edd]) by CH0PR12MB5236.namprd12.prod.outlook.com
 ([fe80::f025:9f2:ccaf:6edd%3]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 09:50:49 +0000
Message-ID: <a9a7b620-53e0-44d6-9ba4-c740748b8bb5@nvidia.com>
Date: Thu, 12 Mar 2026 11:50:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 4/5] net/mlx5e: Report RX csum netdev stats
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260309095519.1854805-1-tariqt@nvidia.com>
 <20260309095519.1854805-5-tariqt@nvidia.com>
 <20260310202024.0caa4ed0@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260310202024.0caa4ed0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To CH0PR12MB5236.namprd12.prod.outlook.com
 (2603:10b6:610:d3::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5236:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d233fd-f15c-4070-c63d-08de801cd6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Pc3OQszVmO2yd7WY3w66J9ES4I8mmWde7ptrnFBd8sXltKKpXc+OubOR7+zTG5NbcXcE5JGiXj09HaeQ3Obvd860PwVBlQH9TAxSYjNen3x7nfaNEPAk1UTD/JWRVmyAZzrFBAsvQ44+0vtePOJOtIEj4VrluS0p5/VLwSAvStREIbQzuw1XEY05UDF2pmJi7j8J2uiQGTIBfdj+vwrgnMVMYymOt6GSyouIx3y5yHDCtCVrV1+wPTB4c2eGQ+/Qhu0nLt2H5Kvkubqh/AIDcgo8FiC45JsHSfRo5mZE9v1gFMxodUN7vSt+97MjvtD+KuT+CNtfaPLv2ZvHmExbeRR4Oe8zdeVu9VE7VKl91iK/ZhgUcu9tXJjAZg9CElOwmC/iynayhHGVNkQ0Fs9UCAclGQFqB5qd5aZOYbNuD1wZlXJ6WRMYR5qmWZYzqUZmzf/0cSNQwDKHv79nB9RfG6kNhOkOROeZdkpxUE/yuk1vspV5IgeWXrqBgcNxQSYM7OJ/LelhwCa0kPJdAKDDmGRqxk7VpRY+ykYvq8mwiOIhigOlrOBgMo/jlMOaHojI2rbcxA7zuGpo4ZdombV3rPij8voeqS8xJwfMQbkOYJ5eb4aiOkTx3PkDqxtQuwyUAk4lAm8meUbOcbHpcXZTf8bNKLJAvM5oBWdafYi782IyTd00rR59Q4Dt2pXkBE0wJdB94LH+d867KNiyJCixTbAapQnZOPq8cP+uYO1Zq0I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDJTY0Iwbi9LM2owYUh3S2cydGlBc0lldE1vRVpnN3ZKRVJwSU4vYlhEUjB5?=
 =?utf-8?B?cDgrbTZleTNmTjZmNmkzMGl2NUJWMlVIREpNM05KSVZNNmhyR3p1bkxiNFJO?=
 =?utf-8?B?NnVpZndBbmFzdnBCUU1kYXQxQXNUSnhJNE82TWEzdkVML2FFV1VibnRFQ3oy?=
 =?utf-8?B?N3MyT09ZV3BjdkNYR0h1YXF4SkErOW1UVlNXTXgyS2RYVEQxbmRBcjB1aXRE?=
 =?utf-8?B?ZGFpL25LUE9wVnpLT2JYRUpKTS9EYkVPK1dGc0syWElCSDdIa3RjYXBYT0M2?=
 =?utf-8?B?MnhNdTNJUS9xc3prN2JqTCtkb3BEVkJZR0VDNldLMk55TW0yTnloL3ZLTllv?=
 =?utf-8?B?SHJhaEJJMUNhalprdElvWkhrU3h1T3QyVW9lc2ROU1pJdk9ZL0lRd1dLN3U0?=
 =?utf-8?B?aWdsZklUeFhlNjhHTnI3YjRlL3RZb1NtVlNMUWkwa3lFWlNqeUFENDk2bEdm?=
 =?utf-8?B?dVlINlN2bXIvUXBuemdWcXExWHlzMUVvMlg4aHJaY0ZsS1hEUkNRNmNkRkhz?=
 =?utf-8?B?ZGh0ajJpa2IrVmlhNmtUaTdIc3Q4ZEhwVGM0b0p3Y1h4Y0FnSGk4eUV1TTgx?=
 =?utf-8?B?dTQ3MWtaL3N1RUdkTnppZXFkNjhaWXNEbjhaMjdHYzh3QXJaSXNwaHAvOTA5?=
 =?utf-8?B?WVVCaVl6dXRvbGk1Yng4eEh1ZE9UdzJPSEFpR2YrSGxVeXdlMG1NSzhlcnhE?=
 =?utf-8?B?OG5zaWhSM3FVUzJtd1paNnhPYk5YNEttVmlweXp3UWdmMVkzKzVHQkU0cVRC?=
 =?utf-8?B?ZXdwT2c5WllmYTBqRVlGVVZSTXF2T2RWOGhwK2hDTVE4NmFqd3VFMGswTXpp?=
 =?utf-8?B?Y25ZcFgzYTRIQlVpYktlaUVVSUZlZkpDK29wamU0c01LZVNvVFgyeGl4Y2dZ?=
 =?utf-8?B?eE5Xanc3R2ZiYzJDREsvOWJYa240OGExRnp6R2phZGRkYnA3UlRPMEdDMDdQ?=
 =?utf-8?B?ZnFUZExjOGFEVTlXV2N4eFBMNEVsZFM1TmJrOFZnaDIxMHVUMER0dlJ2bk9h?=
 =?utf-8?B?ZEE5eXY5LzRpUURBYkRCR2JpOFp0SXpqYXNnems3azZoQmszc1haSHdIRlBX?=
 =?utf-8?B?emkxeW84NjB3SEZDYTlSU2VsRXF2ZGxpUWtYRGxBSlFwYUwrOW5HUVdLMUQ0?=
 =?utf-8?B?eWhER1ZQeXNEV1l4dkgvRXNkcm9vaTFXVEl1SXhTL1FNb3hVcWgvZERCaHRG?=
 =?utf-8?B?MVVnVXc1OFI0NGVka1VZOG1DRk4zOFhTYWd1NU9oY1c2ZWRvODU2dzl1dWtD?=
 =?utf-8?B?Y21IamJsQWdiOXpKMjVxbXpzRlUwY203bHNWU1A0MUUyeHhnRGpTWnhKYytp?=
 =?utf-8?B?NzdjbDJzRS92bVMvWjllSjh4cTdiZFRHRzd0OUJKNnEwZVpaWXA2emxEYmk0?=
 =?utf-8?B?MzltNEhCOC8weE9rYWIrL3JLLzBqcTFBNlB1WnBRbC90V0ZvNTBBUHZvQVJE?=
 =?utf-8?B?cHBSRDEzUEFoeXUzZTJhZjhwRTA5eVJUd0I3NzlENnVwblcrZUlidUtCc1Nr?=
 =?utf-8?B?Q3kyRTlMZVZzdmVuWE9BMVJUYWh0bFUzSXhxUmJBNFZ0cDhZWlMzYmd1V1gv?=
 =?utf-8?B?QXVoVEdZMXFGL2UwZlQ1SnQvYXJZdWVrWW1aZjRxOE9ybmJaMEIySm1sdTBr?=
 =?utf-8?B?Tkp5MjNaallmSTh4Tm5iK2RYZnJHbmZyTVBqZHhKRU9aOUJRTzVtd2xNR3ha?=
 =?utf-8?B?RkVud2FpSTVta0t6ald5d0F0cURHVW02bHc1Z3VhYUc3VnN5a0o1TjVpUXp0?=
 =?utf-8?B?YXk5SlRoU2xMUlg4RGdVZTZuK3I4eWYzRlRmQjA2aCtlUnpoTGVSSkJPZU9W?=
 =?utf-8?B?QkU1aVJnTEEwSUZsc0RRME9uZWxZTVlCR3FoNWtTQlBkQUVEU0Z5d3ZxY1Vo?=
 =?utf-8?B?VVErSUVUWVRTQjJoUXRNVmhLSjFHd1pDNTFjWTRyeEFuNUEyN3l1K0ZNcmRw?=
 =?utf-8?B?MjFXTmxRZG9LODhBeEt5LzdsZVhnREN4OStlb3NUaHA0RE1TNGVTL0o3NCtX?=
 =?utf-8?B?aWNPKzJIUkROY2pmRkJ2UUJ3am5EeWUyeTlQekZWYW9SMlRsS2ROTG9tUTY2?=
 =?utf-8?B?NzlUSE1KV2dRQXZ2bVZCbnFBYUwyeGc3cW40VVJEZXpTdHg2Ui9aakRNZ0Ft?=
 =?utf-8?B?eUR1QW1xaFRodGxsL1hmN3E5aWVOaE1DL3VLSFhReTZNUlExRzR3RnNBSFBR?=
 =?utf-8?B?ZkFON1U1YWlxSGovT2NOdmM4QkZWdm9xaU5XVGhpYlUxOUdjNXZUOUFkOEJW?=
 =?utf-8?B?aGZyZ1ZhZVMwOFpvLzlLb0ZIYWdnenFlOUYrR2VYWjdnYnZNK3hnVjBpa0Jp?=
 =?utf-8?Q?kf6EpC2/zY+rFfDLMF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d233fd-f15c-4070-c63d-08de801cd6ff
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:50:49.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrjWLlFFWBHn675uvNrvJ4sGn1w9lUoEN7/fBvV7siu8Jxh24AEMTqctWNLMwREO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-18081-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 1B95026FE62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11/03/2026 5:20, Jakub Kicinski wrote:
> On Mon, 9 Mar 2026 11:55:18 +0200 Tariq Toukan wrote:
>> Report RX checksum statistics via the netdev queue stats API by mapping
>> the existing csum_complete, csum_unnecessary, csum_unnecessary_inner,
>> and csum_none counters to the csum_complete, csum_unnecessary and
>> csum_none fields.
> 
> The doc doesnt say clearly but I'd assume this should also count wire
> frames for consistency with the Tx one

Makes sense, so this also doesn't fit naturally.

