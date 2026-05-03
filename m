Return-Path: <linux-rdma+bounces-19876-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKjoJN0A92m0bAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19876-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 10:01:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A85A4B4D8D
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 10:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 924B130028D1
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CCB312807;
	Sun,  3 May 2026 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oWA2WXbX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A50226D18;
	Sun,  3 May 2026 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777795285; cv=fail; b=rOxt92OwAp7Wm6V1Ir8wNaaku5uSrp5Q17BvfvloAUNZUG1t8nf0fcaC6/8M093QIv7HycqRR3LHgSrK46bSadKjrMhP0u8+igbKoCZp2nkz6rOa43ktMhNThQCSoC7yTcyXMJ8YwoMiCXJ36wHTdh44BuSCIOBHKVY31y2kO88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777795285; c=relaxed/simple;
	bh=KP8a7kB+Npez7DlOnhf/LZiJzZ36DVJvx+bB6x1Np58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JNh53Qn62MPYJcWy5NGjfIvu3hLmf+fnq7z5Zj+2uJokEA7bIoqzcUtnGro7zfuh8MGXyovuz885InxabyRcb3BF3l4T5sZt1ZvuWyqdYg/yBfPbBVsgxCSQKfqy0z8Rjwdf+f9Y90x4uGRyYRVIWqM4VCNbviVSmC+qIOCXlLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oWA2WXbX; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpnnF60tl70CB5bajlPHq3x4UUJdt9YM1ccEY1LigOYJ/q/9eWQg4rgDH1h62r0Cl8dpUhnYHqioiuLoL/B8jE3Ir7+5B9G14njCjwRcSHFXy0XMA0GHCoaUVHNBtq+iUxP0WhOoCX9i+67/8txV4nxTnxoTK/rIeWVCcRfJyb8bBXTVyHJTgNOxmf/ITglh1hDAAnr7A6CfLchKQzSylA9JfX2NIIGbhIKD13X2hV36DPh0jy/5NRjjLSJet4fj/gTU6QIzUdsonrSOrkpXwuTIkItPFCrFWQOU109w3bdaPLCJlYtRkJQ8zRJ/6dfCSHx9qI5R+HyyWM4wXUF2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSiQ6N+fcwCjDNTMZZJy4vWeoKABngQT5LnzQKwMn94=;
 b=LdchYew/jM1BFFCYyzXTWwqdpHu4dY2RFDHcnw9DU1M74y/9+tQxpPLbgPrIjY+5Jy3Ar/OrruhSY49Ph4FNuyPd38UTtSYQ/jO9neqnjXyyzcMacpGCa5sX/6MkAp+OLdyAjuoC4fORnkzg8cWxqtGgqbjebcX3wFMJCgJwnwCexqlO9X603voYyr0sR9ECSktljCNKi4R2NbqxXvVlLGcpKv+yjJkDEhLp2sseFyf00MVIrl7ukZwA06mmtmdjVjGmVHIju/w/vMQAWyugxImJZlCucowLdYhLg7QNdAW2W4qqlWX6vMnuNZmMBZwxJSb3fXghAPoUyZL14jJjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSiQ6N+fcwCjDNTMZZJy4vWeoKABngQT5LnzQKwMn94=;
 b=oWA2WXbX4zB2v/MpG0NeU5cl/0HJ4wKhrlgHgTj0rVKaJIZAdc7BuNoDiVCC5r1MtDbLA+BZR2biWBO/PX5seGCZpPVDVL80aEM/PWD3qjas1jHzlEnMHdGxEnV6KD3mYn3QgeRV3bMjajYdpxkO43mt0S4tAMYBoMPSAmi2dQgRDgGJROUJ8JpmZ7C4ckkQchTEasaPCXHlb5s1/DhSuDa3kO11q+TTJW4qMs9vAWVhgBSgLHCq9iZsWglnFSh+oFe+fXkCf0i1yoCwlegpjUpj85UxNIkyi3AhXV6yGLjntQeVu8SE4IO7TW/WUqXh8jDommPlpyRpjyPPtfHH+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Sun, 3 May
 2026 08:01:18 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 08:01:17 +0000
Message-ID: <b1daab16-8d4d-4ece-b09c-540932be111d@nvidia.com>
Date: Sun, 3 May 2026 11:01:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 6/7] net/mlx5: E-switch, load reps via work
 queue after registration
To: Jakub Kicinski <kuba@kernel.org>, tariqt@nvidia.com
Cc: edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca, saeedm@nvidia.com,
 shayd@nvidia.com, ohartoov@nvidia.com, edwards@nvidia.com,
 msanalla@nvidia.com, horms@kernel.org, gbayer@linux.ibm.com,
 moshe@nvidia.com, kees@kernel.org, phaddad@nvidia.com, parav@nvidia.com,
 cjubran@nvidia.com, cratiu@nvidia.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com
References: <20260501041633.231662-7-tariqt@nvidia.com>
 <20260503014231.4096128-1-kuba@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260503014231.4096128-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c15864-4d44-4789-40d5-08dea8ea27a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZYP/2eYb/vMPYHfvoL4Yra6DFshFxK2gyXikancXvNs8DppCakxRzJGvMNvDg7J4j5HCQXwDHtbZlFav7mlHOlwVZvrIYwB26C6MvXm/Qz+3dX74uiYNPih6K+u4/9FluYIPZSnGFtCQbLG4OIcgSoDqv+ew+hjyqvXd2vnirogiGgVOMjC1MKz/TT9BRIC64usxv+P60a+IatmmAo8Q9nqm39X+sJgDhMuUfey0pfaek4xgutEgyHT/v0GpBlgdDHhVkz5qbVnDHw50gjT+IzuBaYbX1KkRPYz8cf3xoA4mAkyUya+QUR2Jwx6j5iVu7OcffQcx4pOP9NiFe1XKUwDRwXKknYPcBXVCOoIhyVeoNbsO/Naih0T+irYkP2C1JVkumnc49qcLdxZbsWsgtdt/zye6BxVJCQnqMOYy75+ILp12jOEIDsk8vLQcy+RBk1hGby4/aU0/UjZJE48cb2YRte/fBVMT94x7+ViJ4zWDuE2Gz+tHg16JofBrY7c4yKR6MvbQUs3IfPhRIGAQCtX/TrkKGqSDPQL/Z3BgeRkBDmai2rlgi3tz4FEik51UmL7qc/jR6nmsH4n3PlLud2LYDkO8xN54q7YLGKV7W1OosGX9nfEHjpF1lrQVWt4wLDHTh47WyyGlGLjIrc1KP0o7JrPhhBqUCdutfi2nRqV3XsFZZm4zSVuHYZ2ukC0m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1BiR0JEVHNTMXl0cFpDWXF6Zi9kNHZiSFhMT2VRNzhkRmNuMG8xUUpwUUN1?=
 =?utf-8?B?WUVoOVdKSlBlNnJHa2s1NzI5Nmo4OCtNVUNhWHI4NzZ0MzRLQlJNVzcya1ZG?=
 =?utf-8?B?TWVCOXJPZ0N1dy8wRFZrSFJzOFpzZ2hmdGtBVHp4bitJeHh2Tm85UlRzK1Ft?=
 =?utf-8?B?LzBKYmlndFAyeXpVNWhOdUxCYmFjcjFrK3VGSHRrb0ZXMnhYQ0VwZWtKRUEx?=
 =?utf-8?B?THcraUNGNzh1aHFCN1QwYUNjZXFKRnA3K1o4ZEFPcldWcDh3WlhjMWYrMWYy?=
 =?utf-8?B?c2MvTnZVQnJJcW5HaGw1Z1MreEJsTXNtd1kwZTV4WmZsZExPbFpoaUs2MkZT?=
 =?utf-8?B?eDRWOStoNjZOMU54N3BGaHVqUEtxRlgrRnNMbHJxZFJSelFLL3IyZ3dFNFhR?=
 =?utf-8?B?S0pMUCtpVG1hRVc4ZHJVdmpUVmw2cERsNFlFeVhtMzlqR0ttc3pibzhTVzN1?=
 =?utf-8?B?S1ZkTHVncGdUZ21SbkZUbXpVRG8vWmc1MFpESmtUaWRpMm1vOTBkRE1Xa0hn?=
 =?utf-8?B?RW11UDhmWWFuRGgzT0FaV2toRlhrUWVqWllldWdVVGlmU005VXNlWmxQMTJO?=
 =?utf-8?B?d1pTRDUwMmVmQUNpNHJkcWxPcmQ3emp6ZFN2SDRMREt5TUp6RnNjVHlpOUdz?=
 =?utf-8?B?VXJMWjUrcmIvV1FSd054bVVQSFBXVWlFcUo5akFjR3hHSU9HakdoeDVxQW9s?=
 =?utf-8?B?WC9VdFFEcEpxMk5uZW1LeDZGRkNCaUVNbnVJUXYzUDQ2OXE1ZUMwbkM5WkVq?=
 =?utf-8?B?OXBPY2RFaEpBcFNpRHpPRG9VeFBnd3B4empyWkQ2aXFSWkN3TEVBa290VXlO?=
 =?utf-8?B?bnNkaVFsblJwaWxwTjVHZ2dFL3F0eXZhYW1saHcvUFUzcTI4RU9TRFN3b3JF?=
 =?utf-8?B?YkZUYmNQWGFIYmNKckdrNWRXYW15RTN6YmVLblJXVWRheWxqTWRJa3YyQmFE?=
 =?utf-8?B?NmpoQm5zQzRtMHpINDR5a05nQUFxR09yNCtyR3RQbmI3STAzcnZNZ2tMOTc5?=
 =?utf-8?B?UE1JNmxzalNYUmQ0OTQ5QUhqVmpaL0Z2elpwZGlRQTlQSlhXTzlYQno1N1Jn?=
 =?utf-8?B?dTVHbzdoWWpFYWpIYUdLeU9PRkxtd3cvUkRCcXlPMlZLQlVVeGpzMExtYnBy?=
 =?utf-8?B?T3FxbzNzSkNtZk43M2tYU3JYeFdlaWZKQ2JNTm92ZGMyRG1xclFyd3prbno2?=
 =?utf-8?B?aTJ3bzBBTnRqMmRzNkIwY2E4ZjIwc0JpcU5JaWt3enoveCtINmgvNUlHQ3dq?=
 =?utf-8?B?Qmgxd05GYVZzdm5jQzR2dGkxM0oraTBBUGJITFMvL0NGSkpaRHNaZ2hLNmhh?=
 =?utf-8?B?RWxabnNjR3Y4RXU0N29kUHNWNkE2bTJocnFFajgwT0hTbG1FVkdUZTZQcHVv?=
 =?utf-8?B?RjBIYXpVazhqelptelR2VEd1UWdQZ0JwUTlWK2lxZG5OQkNyMHhIN0QyNjlM?=
 =?utf-8?B?ZHVNQ1RLVTNOVzFGL3FSU28yN1BsWmpkaG1rd3ppdWc2OW9iSUJtdGovZ0k2?=
 =?utf-8?B?alEyaThxR2RBSk5yeTdUaGVQTmU5b3gxNmswejlnU3BEM1Zwa0l6VW1MWW81?=
 =?utf-8?B?TDRKbUVYRVZ6bldwRGk3NUxwVWVuQXVKcmFTeXBTMUxBRGNKNXZFT2lQTWw3?=
 =?utf-8?B?ODVtd0RuTUhZWUpiT3N4Z0Y2dWFpemVLazREZ0RZV1N5NVkzM0FTek5qeFND?=
 =?utf-8?B?OHhiUk5zbWllaHRuNDlvbzN4bG9BVlczeFVXbGZjQmV6MjhKU0VBb2lIbTNq?=
 =?utf-8?B?U2VuUWhkTFlwUW1Xcmw3UUcySXUyazNna0JFUFg4QTFMTTBydmk4RDdJdUZj?=
 =?utf-8?B?UGF4a3RRQjNyaHNjMjh5a1VwVHlxTHJoaW1CUkVyNTl5ZkR3ZEpyTi9pdmw0?=
 =?utf-8?B?K2w0cm1yK2tOMktpT1VzdGE5YnFhOUpHYzEvWHVxdVkyUEVrcmdFRVdoeVh4?=
 =?utf-8?B?dGpBZnd5Nk9adlJTdkM0U2JCU3cwK0FWaEkrM0V4M1UrclZPOWZPV3RQRjEr?=
 =?utf-8?B?V0xNaDNRbXU3aHZTRmF2NzU3a0lVbnNLcU9UV28zNGJsSkVocWZpN1JBUUNP?=
 =?utf-8?B?RjY1RnZiRnB0ZHhnREpCMTcvT3gzTUJaOWJLeGxIMEQwalNiUmhrdXVteFVP?=
 =?utf-8?B?bVk2TXBqWUxOODMzRjFkZWpxT21EdHdGcE84bXp0MnNtSWwzV09MWXd6VlM5?=
 =?utf-8?B?elgzdklqQmJrSEI3NTFsbFlEVlp3WHB1SXBpU2pqWXVkcVJzdjQ1akdWeFpw?=
 =?utf-8?B?b0lCZ1lJR3JESmRyQ1E3VGZRcW9uV0hneHdmQTVNa0hhZ2lvNXU4T3RJdjhY?=
 =?utf-8?B?bUh5TVQ4ZFFQTEdOeWg0Skg4STBUMXlVVlIvbm4rZzQ1bksrTHMvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c15864-4d44-4789-40d5-08dea8ea27a7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 08:01:17.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2mSoZXRi/oVPqZWrV9lPvW2Q0YlDTltT75dMUHcf5/BvfJv1Z3xHjHNmizx7/YjD8FqXIovImdCPimdRfmyCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
X-Rspamd-Queue-Id: 9A85A4B4D8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19876-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]



On 03/05/2026 4:42, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5: E-switch, load reps via work queue after registration
> 
> This change defers loading of newly registered representors to the
> E-Switch work queue so the handler can acquire the devlink lock that is
> not held by the auxiliary driver registration context. The unregister
> path continues to unload representors synchronously.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>> index 8f656253981b..f26d1652dd05 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>> @@ -4563,6 +4563,38 @@ mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
> 
> [ ... ]
> 
>> +static void mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
>> +{
>> +	mlx5_esw_reps_block(esw);
>> +	mlx5_eswitch_reload_reps_blocked(esw);
>> +	mlx5_esw_reps_unblock(esw);
>> +}
>> +
>>  static void
>>  mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
>>  					const struct mlx5_eswitch_rep_ops *ops,
>> @@ -4574,6 +4606,8 @@ mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
>>  		mlx5_esw_reps_block(esw);
>>  	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
>>  	mlx5_esw_reps_unblock(esw);
>> +
>> +	mlx5_esw_add_work(esw, mlx5_eswitch_reload_reps);
> 
> The return value of mlx5_esw_add_work() is discarded here.
> 
> Looking at mlx5_esw_add_work():
> 
>     static int mlx5_esw_add_work(struct mlx5_eswitch *esw,
>                                  void (*func)(struct mlx5_eswitch *esw))
>     {
>             struct mlx5_host_work *host_work;
> 
>             host_work = kzalloc_obj(*host_work, GFP_ATOMIC);
>             if (!host_work)
>                     return -ENOMEM;
>             ...
>     }
> 
> the allocation is GFP_ATOMIC and can fail, in which case no work is
> queued.
> 
> If mlx5_esw_add_work() returns -ENOMEM while the E-Switch is already in
> MLX5_ESWITCH_OFFLOADS mode, the reload that mlx5_eswitch_reload_reps()
> was meant to perform never runs, so the newly registered rep type will
> not be loaded for the already-enabled vports — which is the exact case
> this commit is introducing infrastructure to handle.
> 
> Registration still returns success to the auxiliary driver
> (mlx5e_rep_probe / mlx5r_rep_probe), with no log message, no retry, and
> no way for the caller to notice the dropped reload.
> 
> The other existing caller, mlx5_esw_funcs_changed_handler(), does check
> the return value of mlx5_esw_add_work(), suggesting allocation failure
> is expected to be handled.
> 
> Should this call check the return value and at least emit a warning or
> retry, so that a GFP_ATOMIC allocation failure during switchdev-mode
> registration does not silently leave the representors unloaded?
> 
>>  }

I don’t think this needs a warning. This reload is a best effort path
for late rep_ops registration, REP_REGISTERED only means the ops are
installed, while users still key off REP_LOADED before using rep
private data.

The work can also legitimately do nothing because the E-Switch 
mode changed or the generation check made it stale. When registration
happens during an E-Switch rescan, the normal E-Switch path will try
to load the reps and report any real failure back to the user.

I’ll still make mlx5_esw_add_work() take a gfp_t, so this path can
use GFP_KERNEL instead of forcing GFP_ATOMIC reduce allocation failure
risk.

Mark

>>  
>>  void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,


