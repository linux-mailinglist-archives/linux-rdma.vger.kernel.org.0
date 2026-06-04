Return-Path: <linux-rdma+bounces-21777-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q+JnGJqGIWpvIAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21777-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:07:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2358640AB9
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:07:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=O0ZaH17S;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21777-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21777-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A9530FEC9D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89E47DFA2;
	Thu,  4 Jun 2026 13:49:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F44014A1;
	Thu,  4 Jun 2026 13:49:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580952; cv=fail; b=FJt2TtjqU8BCJgg3tTc/ZVRbLx6A0IulMzFbYfUA+D6n2h0L39OxBPbpQEv10iI6veoG2mHw73h4ijqBlLvc2jgl8TEN6I0xqpyVCG96N5foNUOyIWLRlEj+mHYahBUVSbRphPh+MRjiKKpthSsPVK1KSKPPNSwnRD3ok7c9+Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580952; c=relaxed/simple;
	bh=To7QCwQ3DfeFo3ybnCZ0zELtkGbxYazoJ5lGdJEx1cc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j6UKW9nJ59s0zJUt/61RGYmCB0mfPIq7G6b3OqlBfwxVNkBMs0MrpzbcXl2p8VhfnnFx45/zLMdCyuacjNV+5guFtQCc9IadnV5Q6+dqIVVLGu3QyMWcnNwGdYQoH1UbSLYfy+9/I5ypNEKOwDnF9LDw+S4KhmeBRZPFLem85ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O0ZaH17S; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn62hguG7oxIMoON4WO/NriPgHyre7odS80xtrcugbi6Lmv71mOMZGJim4va/2mG0xgv9+GKlBA4gMgS4TOcL5dVtV7EnyxaxElL4w3Tu0VAFVp9zvFIOelK6oxlmQ6Cvnm9TGcSILWKBUVkFxwDranocTvXaV/QVIdVu97CQkfQ/TjRXuvpUWJtw6DQwSN1VDouhhXE/qBF313Fg2PQQgQCxpnyTA+3YQV/ALqdS0IFzQKtPsFPrLU9+PWezJs35DClmbFNC5/8l8f2txs7zzj2Qg9D7yuWY7O/DeXpCvmygyle9xfyxkKLJRTmlex9plPvj+69fR0dsnNLHUDD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zS1qRfOikP06NN+r9d6o19v/A3ZipD//oOVk7m1t7Q=;
 b=FLzzCfDabmw5Iu4B38OU4si3A+l6bG4N1ogcXnz4PRlNqrfdTqPpAjGgCoFR/F+mWSVwvYLAHgBraDNQlqeD/RM6K1RF9nTj67fIedaFEpz4CxlerKddiAaybREOtJxig4SZguJhls1B++mh5Hy/XpPjtgZQIrc+xw5d+9zo1IsfgJPIiHQJG+XsHqA7pzmo0d6l6ziSTDRu9d9CO9XU61Sfq+YA19PAOyVu86S191yMfbiDryrbkcy86xVeqYDjjob0kp8p47bat8V48LDvKohwjFJYSPDlwcyh0CmbghZD8WIO5lgfOMJPzMksUN06HCeYKaQ5JuH3fIE3briFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zS1qRfOikP06NN+r9d6o19v/A3ZipD//oOVk7m1t7Q=;
 b=O0ZaH17Sd/u26bSydF9KZRhyQZ2sAPc6SK953Ed9n//IiY3OlZcQBf4FaCKW7ZENezJV5O3vyeWSkNjvXg2xnuLVEhg/yIC72fQgG+A32FbgxuncCiZQU22HD6wki3HvACulH4pXBXzYOVtnGBhttSbx3XWAssbXOm1jup3553ZDcOOXeMFOULMNMfHL8CgcRZOlarMQhVpNi/EZjHP01UXRsYHJsu0BrQNKrGX2qTsXVTBRYMW1z27F25uBEFjpbE0KfB6uUv5BrxzB6JQKttHvhW0rzkgBpA66ThA/OehxAmAp7uA0/ByzPUSdjBHvIGmdS0VK+x6aLVgoG1uMvw==
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Thu, 4 Jun 2026 13:49:07 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 13:49:06 +0000
Message-ID: <c20ec16b-8154-4f6d-8cfa-1d3507f19a0d@nvidia.com>
Date: Thu, 4 Jun 2026 16:49:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: convert miss_list allocation to
 kvmalloc_array()
To: William Theesfeld <william@theesfeld.net>,
 Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260601193758.626537-1-william@theesfeld.net>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260601193758.626537-1-william@theesfeld.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7fdfbc-84b2-430c-4576-08dec2400bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	AdCa9o3TLfnF9DSmN42lH4rxH9cxjUEOq9oFB6pSPnibGigMENGIr/c+QoI1qaXJ+m0Dtkjm0YXKwpNfk4m9od/9u/iE6jVXOzJt91APZY1fyvlH8EfoNgUQVsgdrsIYQQoFaE0zn6wM1hb7H5hXW4ZHL/gayj9SejDnJ2Y72hFibqjf+aasNibw5yT3SZfxJAOJqpmKWZGajH8rgjnY8iASTN9L8PGBF1/SBD5ZFEZsFrV1xydYGal5bg/A31lc4IZe3Exa2wC15N43TSG8Vf80jlgVcbe+d9/XVaHlUaEUJCc0YX7hg8A2EOl8TZVBKMHYhr50CAH2n1x1eolfYE12N4smcNogvmtC7iDiMwwjsqCgK30jIu9AAdtGZ4WJzdLizA4bw1vFjPSSI0wKy+gT8P/sR8Avt0vgKOosqK26Us9pp8rGYJ+FK0z+LmsPavtEz4R+X9yQUBqU/p8IOgIv47IQpTizqJYV1H7btnsL+iZcB0uF4GpfpzbQg81bEewHvKy7mfWwQesA4Wx+DKF1xMQrRmi9BG9eBU60G1q9ENAgauGjqZYhtco/0W0JQF7YD9G9f7ecI7MQ/33cKqfd5U6BvrWrliZLsfBHR/tuG03Y6Bm8Sml4U+GRTTlICyEp63lhRQHgOhe+7Qdf/aNr3pseju1y96SyEOc5yCo+rANn6JNbp17mzC5lR0CD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFR4RjY4UFlhckNMQ01PbU13RnQ4ODlpNWswREdUNzRoVHpIdGI1ak1tL2tW?=
 =?utf-8?B?QXJoU2t1M1BzZVNNTER4eXhqZXhrOUhWS0gyNFk2MllkSmJ6MnNaSklPM0ZW?=
 =?utf-8?B?UHZTUUdRKytqeFFYRWNZbm5MK0hvT09YVk9ZUVFMOURQVElUR0wyaGE2blkz?=
 =?utf-8?B?L0dxaHZ5UXNEV1B4dGRDT01pais1amJId3Q0NHpRU2JmVjFWTWlXQ3FrODF2?=
 =?utf-8?B?ci9DakRTclduUE05elV1VDBOK29HN24wVUJrUUFXMXFyNkJ6aHQwMnVMQ1Bo?=
 =?utf-8?B?OWVqMXVTcUdCM1A1Skpray82UEl0Nm51UDY3MXpwa0dNWlZvZDlNZ1JNV2dG?=
 =?utf-8?B?OEdETkR2cFZhbWV0eWtnSkxuTjZiNWtvRmpCdkRSd1NJZWVuclY1RDZPaTZJ?=
 =?utf-8?B?YlhPU1Bxd0xNZmZNY0pZVHFEL2JlK2JlQld3TGV1VVJCMUp4RHN4L2NjbmpN?=
 =?utf-8?B?UDkxaEkvK3pzRjdjeHUyNlVTVGZTYmdBWXJ2eHNDemU0UlZYYUFDSTR3Y2pP?=
 =?utf-8?B?NmhNSmQvTVNhUmFDYlZYYTdPaTYxUTZKOVQ4RUpDMGRXYTNlelpoVldwSkd1?=
 =?utf-8?B?NCt4eE1kdklzaVgvMmdXa2U2cnhhSEFYNUxLOWd3Yy84UkhpaHhnL3ZQZng4?=
 =?utf-8?B?b0FBOURRVGxZMmRMSFBzY0p0NEhxOXpveDNoM0hsWVlWeHVWUnpJSkdDUk9t?=
 =?utf-8?B?Y0hCNGhST1hmVTZyTURBbkhUUE8xVlpTeHZheDJBdi9paEpvU2NTMCsvUUVy?=
 =?utf-8?B?OGJHY0hyVEszUWJBbGRLYkVqYXdySGlNU1pLSFN5MTZKUlkxQlA3ZWlMUVNU?=
 =?utf-8?B?Y1E1UDBtdzhCS29PamFNbU5LZTB5eWN1YjdKTklGVVk4bnZ4YVJKbm5mQVhy?=
 =?utf-8?B?NnkzWjl5V1YrNjIvQ0NIS3Bpd2V6cU5QL3VQOHE4Ni9kZ0toNEpOb0pTVEJJ?=
 =?utf-8?B?aERpRWg2YTBsdmw2clhzSTVOZWVLOS80UmFQdDhMeno2a0k3bWdlU1AvUlM2?=
 =?utf-8?B?SDVCQ1B0c25MRXdrV2I0VUtjQzRTUnIwamg2QUpvSGJKS1NzdFNsRlQvMUF2?=
 =?utf-8?B?VXR6MFZzTUJMY1NZUzlkNUlzUGpPVE1NOEpXTTlLZC9NMlh3SVM2VlcxVkZs?=
 =?utf-8?B?eVFOaTFCT2xTSm52bFZoeW9rTXExZWxJdDd0R0lsRVdubjNTa2dtalcxYlNq?=
 =?utf-8?B?MXl1Nm9DZkc4SlFqWWZMc2dlUWx6bnNPc3d0M1ROcGgxZlNRaXNwZ2dpaWh3?=
 =?utf-8?B?bDZGV3o2d2d5K1k5R2JHY1AwRWZkUDI4SUJLZGtFRkcxYytZTlF3cUNHUHF4?=
 =?utf-8?B?cjM5S1RkSFlFbkg4djlmQ0Y2NVlnYURRQmlGMXRRTWJvQ2t1c05KMDMwY3ZD?=
 =?utf-8?B?RGk0K3lMMGp0NnJKbEQ1Nk11cWZIbzdXYTNNMWlZQmoxVGNjdUw5S0lnN2d4?=
 =?utf-8?B?N0FMR3RZVnlrNVZmRTVSYmhveERXalViMFo5NWk5ZTcwSHhVd0YrMjY1VThO?=
 =?utf-8?B?bkRtUlVaU01pZnhlbE5KOUNDd0ZWZGZ0R1U4Q1dXTUZJN2FOTjh5Q01tTnpa?=
 =?utf-8?B?NGY0NXFXRVcvVUcxUmdrVy9HbXh5b1hCZDlMVWV5c0kzQysrRDFUNW5yKzFk?=
 =?utf-8?B?cmhDaFJibk8yTVY5Mk5hbGdvZEFlVFVUVVBmRHlGNUJOZEVUcnRGR2lMWFp2?=
 =?utf-8?B?enhLaS9ITlVTaCtJTk9CS2JZSmdoNlQvVmcyclRUNWlZUDJyUDNCZ0NrbVRz?=
 =?utf-8?B?ZzkvQ3pPZE9QcGZnaW1TZE9ZR2J2dTJ3cTdaa3l3dElqV0RnenBOTjJRd1hO?=
 =?utf-8?B?SXoxWkxJTHNUR0hoUnFVdm1ERHk3cEVhcnRLbURSc2lMU3VCOElOU2hUZG1K?=
 =?utf-8?B?SW1ORG9OUG1adDhob0QvUWlJekY3Ylh3WEpZRDhxczFLcTMzYVZ5WVJYYnR2?=
 =?utf-8?B?ZnBFVTNOSmR1M2ZTM0lmSkhPZVBoeVJQelZXNlZLNXI4dXdTd1g5eW16R1pC?=
 =?utf-8?B?aFlNQkk2SkI3NjlrVXc4MktHdDFNMExaQS9zbjc1YWVhUHp0T3hNd1FxOXFH?=
 =?utf-8?B?OUVYZndiOEllVmpKTmRFeFFPdUoyNHFEYTFYU0paNGV6c1d5dmFrNHRDYUx0?=
 =?utf-8?B?akV2ZUVyL3hkSzJ1U1pTVDFiRHBrVlgwcURKbjloQTBwdERVSDF0N3lQYmll?=
 =?utf-8?B?czFvSUlKRmlxblRSRGdWSjl0SktwVGFUMXY5OUN2WldZMmlndnp1L2diZXkv?=
 =?utf-8?B?cXBYV3RZdUdCMWRGQzVSemROdCtIMERSUWQzc256L0poYVFmeUdWY3FWbnZX?=
 =?utf-8?B?eFpFNkJKMFpCQWk3UC8vc05tTHJWdWFISitJZ1NwZ2xBTWJuRHBQZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7fdfbc-84b2-430c-4576-08dec2400bcf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:49:06.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVEWrqn2PdglcmM0GJA3jblei9kTaT+eg86+1qwAck3Sf9TB3dWhRdEm+saaVKpKQxiLO97NV2KyC4KKDHP6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21777-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:william@theesfeld.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,theesfeld.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2358640AB9



On 01/06/2026 22:37, William Theesfeld wrote:
> dr_icm_buddy_init_ste_cache() allocates the per-buddy miss_list using
> the open-coded kvmalloc(n * sizeof(*p), ...) form.  The neighbouring
> allocations in the same function already use the kvcalloc()/
> kvzalloc_objs() forms; switch this last one to kvmalloc_array() for
> consistency and for the size_mul overflow check that kvmalloc_array()
> performs.
> 
> The semantics are unchanged: kvmalloc_array() returns a non-zeroed
> buffer, just like the previous kvmalloc() call.  Existing callers of
> buddy->miss_list initialise each list_head before use.
> 
> Signed-off-by: William Theesfeld <william@theesfeld.net>
> ---
>   .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c  | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c
> index 7a0a15822..fa4d24b3d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c
> @@ -239,7 +239,7 @@ static int dr_icm_buddy_init_ste_cache(struct mlx5dr_icm_buddy_mem *buddy)
>   	if (!buddy->hw_ste_arr)
>   		goto free_ste_arr;
>   
> -	buddy->miss_list = kvmalloc(num_of_entries * sizeof(struct list_head), GFP_KERNEL);
> +	buddy->miss_list = kvmalloc_array(num_of_entries, sizeof(struct list_head), GFP_KERNEL);
>   	if (!buddy->miss_list)
>   		goto free_hw_ste_arr;
>   

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.

