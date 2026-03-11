Return-Path: <linux-rdma+bounces-18010-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFCONFyzsWnbEgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18010-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:24:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0CB26888D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 19:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C3B5303791C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F953E8676;
	Wed, 11 Mar 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F0utkjdm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C41221FCD;
	Wed, 11 Mar 2026 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253463; cv=fail; b=XkoLz7c8kD2LOw/SQ/iZtWjDzul2ilxZ5mLbSXt3NUr5HirzdjOSMXdLI9Ew6pTfUhUWo/jpjUi0oeK71GBCoOqF7pcqWyF0DCkfKl7eQkfcY3073bBJvnufWHIgdp/0LiGXObkif6nnyTmz2l3WIaG5zuy5YmdeF3ObUmxBrtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253463; c=relaxed/simple;
	bh=BfKoAzhwVSHvoS8jpgxBCC1qPqct/pUP04abr2Mjyl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KURyfnHv+LSwJ88dwIdytvOo5QvArR5WUVFr2TjhSRcdO1w4Lq227//ZkQcUy1leAzxPL5tcKbUrHnNFlihJYjJ1K+9JQfAo+OzTmzh7M5GiXvgIx3Pns17NmaNPKvPCHzd14+sIJnlA6R9+TDXqOgNVowSlv0BYfRXVTXQluC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F0utkjdm; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgaashI+/xabzvx52UE00PJyy1p4HZI4NbkpXmWexYDgwrbgd4yAQEDSd2aG6urOWtSx2mG2RWqytAOZGZpF/Ht4O6oiQOOoyV98QiLlFbH45PidRoBLqTSTbZpVCRV+fgHnRDj4izNS/LcV4HnFEmYWmwSL76bi3acPY6ucksaTTsh3ZrhQOMCtA5urddFnsJGeXLrOjUL8J6m5rTdS5rxrx093vO1HNGHS9Y+44qRV6jzlQyVHD//GZgAk/4h0kkRdFVWZGiGjTfO3ztxHa7UZX2lfw7N/eBTUFPrE4ob2MUNIYcHNHyoO96JMKzxU5XVI6zSB1mFoEVGetg693g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/inejUG5MxiP35QU9HZtk0B76actu3dsRgUikxOJ3G4=;
 b=qo6IZuAY2FQD9/TVaEomw6FM7KP9by+biTv2jFBqcP28tgpQI6bVTmJ9EZgyKRqdhuaqCVXxfUVX3PpKRpONACpL/WFMswPmECli/qbOjebrAfogFF2G4HwWyUyvpZvWVDCFRJubKK0d3rZb2x12dYwhDm209ZbcUUEcq6ByXmvFdF91XhyXO+7aIq1xBvoSNhvPTuV71HdyqrpSEf6wyLbr5Bzulz8QH1/u4PVeEttF6WcYfn1n9MI9ZwegkKKwwaAsIaDUINB1e0s68SCR9Tnb361AFf56TX6hOLSAzxderDNzDvwWvZXtO6RbLdsoNJaBrhVTNoMIDtxo1UDCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/inejUG5MxiP35QU9HZtk0B76actu3dsRgUikxOJ3G4=;
 b=F0utkjdmRN+bAnQM28pyonlL8hnPdyJe25GRS3wzluOUNxI/3Wkc2p69DaKl2mH1CWapw5MCN3s490nydYkB298BbhzxEDZIEfYl+67XzDQRFj2HD4zh+wUn8pSTo0F8oLiMQZRy9TaK2C1GjKn9AjU5vLFsNahS/O5OTw7j7eYfBpI8X3AwMgdiGPVI8W6VfpONdofL6XW/tg8a/G1YS2NQSNVHa5kweK0/yQTy9jfODPn62lgmI6ayVVYOsGx/4QJU7GK10ZUfvP+bnEPEZZb/aegpJzQes60HX/wvE96COnu36sWHsf+GaNnfvDZsq+E23HPxkAMBAxHESW6UUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 18:24:17 +0000
Received: from CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9]) by CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 18:24:17 +0000
Message-ID: <5de5103e-e2e4-4b72-9c3c-22847728fbb8@nvidia.com>
Date: Wed, 11 Mar 2026 20:24:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260302192640.49af074f@kernel.org>
 <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
 <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
 <20260304101522.09da1f58@kernel.org>
 <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
 <20260305063729.7e40775d@kernel.org>
 <ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
 <20260306120301.0ebe1ab2@kernel.org>
 <74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
 <20260309133341.7e08b35d@kernel.org>
Content-Language: en-US
From: Or Har-Toov <ohartoov@nvidia.com>
In-Reply-To: <20260309133341.7e08b35d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To CY1PR12MB9558.namprd12.prod.outlook.com
 (2603:10b6:930:fe::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9558:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 45934d9b-7182-4780-c8db-08de7f9b67c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0e0mnrJ/pbPXmRN29G0aCtpSrnyqKS76cWVTCIYFVBjyNmcFGAMW/1YdNvRePXGsyi89penaYLaVyy2RQWq4NzCn14hiOQ/COWJBcohPkg6o3N34F0SsK8oLfJ1ronsgv8/+b8gE02xzaHSFv2QAXEwd/tpx/NkdB9LVOXpV2Ukbog+Sb0mwr2WpE4dV3gpaQwlxqnXLR0erlXfAujNyqHk9fAJU5eaIwSImgxAd/sM6P+1DHzcb11aHUMaKplMXrfNqce+pXDH91CIa65LtZO0cujeI2/xRvvoqPwFKDgGjwcQ2zn5r8sgTwS0sd22G+G6fRABwDwT7P6s+XvFJRdA5hSiimnyw2+ZsKXIOrs0tPwCZe7/aCzJH1BUgCZyxlGm6utRqQOyWHvg6Dubb+9TDsidO1KMzYU8N7hp6Ma3/w/dzNt+UeE8gnr1EYxRLVksPHEbkNRDoj1/b2IyWssT4PFQZNyWlckADgV14FO4XvZCneckJmXS5tqlbcXqUcHxH/1BOQKwi8LbUEKK7evu+Z4A8arCRUHOc3NwzM99ew0szXyep5qtv3ONbbBA/h8eQFjKqneFssHg06YFvMCborzMSl0bfaPoAhNujtklAWGfg3KdS/yyf/luVkS7TVRgmyKkISses9hlVy3PblQlImkb4ygPMGZF8kDH/VRHQBi3qAA8Tx2UOsT2NA+fpoi9v/9I+IL7A/OquEGVErdGvQ7zJp5UHnNIPlEggBhA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGxRV3ZRQjR6U3NsSGREdUVTNXVWZFlnRWI4bWV1cmwraUE3M2U0Y0JxZmFy?=
 =?utf-8?B?bkJhb20rR1NMN2tjWGc1Q0RPYW9ib3ZJUjdSWGpyYjR1dEdLRnpQOEpkNHNE?=
 =?utf-8?B?YmsydEU4OXF2N0Z4enNFV1NKbkp1STVVRVpJdHJLVFJsTVV4aVZMcXNXemx3?=
 =?utf-8?B?OVFWT1RrY2I3b0hITVR2SVUxWDNDQmVJc1hQQUo3bW1FbGk0d2JxSkcxRmhi?=
 =?utf-8?B?R1lXaE0zcW54M28vR1RSQ1JtdnZyT21LWEc3dGFEY25MZ1hTRjhkL0MyMXRT?=
 =?utf-8?B?TjVsQXhKQ09uUUd5UmVWQ1Vsa1U2aXhlcHVGRTVtbFZjQkRGMStkMTFiZ2s4?=
 =?utf-8?B?YkorQzl0Qkk1cVArRUttMnFZZkRGY1U5d0FmbVpCMVpncUVDQ0tKRFQxQ2pT?=
 =?utf-8?B?RS9kNHRXRzN1Sk5RS2JibGdyTEJESmlEcDV5T2NKNk9KVUhONkVaVDZ2cHFX?=
 =?utf-8?B?M1RrcDdPQW9nSzFDT0I3MnFlbzhJcE81RVV2SUpOaSttRUF1NmxSYlhDN1h6?=
 =?utf-8?B?cTZGaENibmlQeUtGUnhaQVFQVER2em5kSUVRN0wxNUFLbXl4VjdNT0YxTnhY?=
 =?utf-8?B?WlB5RzUzSEVEdkU1eUJFM1BsZnFQYXFRaTVZaVpnNm56Nmx3aERrNVdEMEtZ?=
 =?utf-8?B?T2hlQ2x0ZkRDeFVibW9mUGdnaWpUcWdjcXUxUCtCS3ZpNHFER0Fpc3hmeVRW?=
 =?utf-8?B?aHQ3Tk10bjg3Y2FPZm95U3R2bHh1NSt1bTdTUWN6eWRpeDl6NFJISGdkREY0?=
 =?utf-8?B?V0xncTJLeVd1NGs3R0ZwS0pVT2QvTVlVdnBhZEdVem83c3M2T1FWMTBmSTRI?=
 =?utf-8?B?RitYb0tYNTNjTUx5OVhWUGtqRUR0TFlSRUtyaGduOHhZUGZDaXJZK2krdEVy?=
 =?utf-8?B?TjlKcUZCdXd6WFJsUStkU0Rrc2VDTkZBZkhVMXI4VkU5RTIvcldIM0pBckgw?=
 =?utf-8?B?dytxdTdXVmFvMXpyKzk0ZzNQWkVDTmw1M1VOVUpBUVVla28rTExuV3hpTVN4?=
 =?utf-8?B?eUFVN3E4eWJoV1lCQUlUa0RVK1VDNWp1MFhQT2EvdlVmNjlrSTVlVWw3YzBL?=
 =?utf-8?B?ZWNoOHN1UUVLK0JsTk1oL1RmcEVPbWZ5TTQrN3hVdHNDZXAxa0FscDZjYytW?=
 =?utf-8?B?eUdiZm1XU29QTlQ0S0RuemxpUUQ5Vk1XMXBDbjZmUXowUjR5aWFUSWluNk9I?=
 =?utf-8?B?Sm5saTBxdmNrNGZzcGRpc3FBclBMYUdhS2oyd2J0S3Q2QjgrdXFIcFpYeTlT?=
 =?utf-8?B?VGZZUWx2VXhhcTJpSVNWRGt4Q3c3a0lIOUJLNS9vdXhOcm9ScDZnRk1EWGJV?=
 =?utf-8?B?V0V3bUgxemJNZ0JYTVZMMjFLNWMwTzQwWnQzREdxYnYrNEQ0MkpmZ0h2SW1I?=
 =?utf-8?B?eGFLbmxwTHlVNFBYM2VqRm9xZEJvOW1PdnJIS3Y5NVY5QzVTWXZpUEQyck12?=
 =?utf-8?B?WlROcWcwZkcvaEpPZFlDWlYzSE14N2QrQnVldm1IRTdTM3k0TkJpTFZWb1Q4?=
 =?utf-8?B?VWRxcHFpNW1ETnJCOSt5Q1g2QVozZjFwQ3M0N094MG5TUVNKRHliZVRQQ0NU?=
 =?utf-8?B?eXRxYlRlVysrOTZINnBRSjd5Y0pyQit1aXBFcmVxbHJ4THg1NGRLRXEwSUtv?=
 =?utf-8?B?dDZPSWkyNWZKTzQ4aGZ4US9SQnNvYU9ha1RNTDB2eG5uTjhEejQyZFVEcG43?=
 =?utf-8?B?QUVhcXJkdVRpcFRTdEdSUFQzdVhkN1NoMCtMSkJHSVBjLy9hTy9uMGlIaGhX?=
 =?utf-8?B?SjdBa2VEU3B0anhqd1p5am96c2RUV0EvL204T0lOcWdKMjYxTC9IeXo5MWg5?=
 =?utf-8?B?dmtFd0lOQUtKcTRmUU5BL0EwRnFQS201THdUSGwzWHRnZjUxNWpnQXdMT0tN?=
 =?utf-8?B?RXNpem93cHp6VC9yd1ZwNkx6L3ZYTXoyWktJVnFJUWlIS05Na1Z5Q3Z5UXRu?=
 =?utf-8?B?cDRSZDBPSUtYRlk0V2swMzRNU095eGQ4QnJZSERKcVplYW1uSGFkdHFzMzQx?=
 =?utf-8?B?VnczbUM1dzZWWmg1RHZYN2xjUjNYMEF6REpmVEU3Z3FaQjY1UE1DVmN2bzhp?=
 =?utf-8?B?UTlxajdnZ2NEekxPOThUbEI1R3VtWWUrUndqWkhML0tQSXltaERLMnBJQkYw?=
 =?utf-8?B?MmZZY1IvcFhvZmkrWGhYcXVHREFIV3VXai9KMU9WMmtxUVpRYW9Qc1lFb3Z2?=
 =?utf-8?B?QVJSR1BqNURyYnFZV1Y2K0tyRU02SVBtTmNhNllXUDc5UC9Pc3paNUdKWS9L?=
 =?utf-8?B?YW1PVG5hMW1aUys2Zkx1VkpQd1NzQi9JMTVnUnc1QWFnRTVvWkkyS2w3ZFlQ?=
 =?utf-8?B?YkxTRUtXQ1pOZitETDdZVFFxWTEreU9DSUF3QXdObnBNRU0wNGtBUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45934d9b-7182-4780-c8db-08de7f9b67c6
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 18:24:17.4446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gy6eyNmxKFb1h/yB9XaezXu7eaEwn2hRfR/XVPlK6wERYgJUtJ5Cba/kNNstqcq5S4QCu7FM6U/AuKzG7PgBVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18010-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ohartoov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E0CB26888D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/03/2026 22:33, Jakub Kicinski wrote:
> 
> 
> On Sun, 8 Mar 2026 18:03:11 +0200 Or Har-Toov wrote:
>> Do you mean that we will register resources per port, but not show with
>> new devlink port resource show.
>> Instead, the current devlink resource show dev command will also display
>> the ports of that device?
>>
>> For example:
>>
>> $ devlink resource show pci/0000:03:00.0
>>     pci/0000:03:00.0:
>>       name local_max_SFs size 40 unit entry
>>     pci/0000:03:00.0/196608:
>>        name max_SFs size 20 unit entry
>>     pci/0000:03:00.0/196609:
>>        name max_SFs size 20 unit entry
>>
>> Or should we keep the current behavior where devlink resource show dev
>> displays only device-level resources, and only the full dump shows both
>> devices and their ports?
>>
>> For example:
>>
>> $ devlink resource show
>>     pci/0000:03:00.0:
>>       name local_max_SFs size 40 unit entry
>>     pci/0000:03:00.0/196608:
>>        name max_SFs size 20 unit entry
>>     pci/0000:03:00.0/196609:
>>        name max_SFs size 20 unit entry
>>     pci/0000:03:00.1:
>>       name local_max_SFs size 40 unit entry
>>     pci/0000:03:00.1/196608:
>>        name max_SFs size 20 unit entry
>>     pci/0000:03:00.1/196609:
>>        name max_SFs size 20 unit entry
>>
>> Want to confirm which behavior you meant.
> 
> No strong preference on the CLI. For the kernel I think specifying
> the device should not exclude the port resources. Whether port
> resources are shown or not should be entirely up to the mask attribute.
> 
> Thinking about this some more after my last reply to Jiri I think we
> should add that mask attribute to let user decide whether they want
> only the device resources, port resources or both. This will retain
> the exact functionality of the series.
> 
> On the CLI "devlink resource show" should show all resources in the
> system IMO. How we define the CLI arguments to scope things down I don't
> have a strong opinion on.

So for the dump of all resources it is clear. But I want to make sure I 
understood the scope/mask part:

For the dump-it command:
devlink resource show
pci/0000:03:00.0:
<resource>
pci/0000:03:00.0/196608:
<port-resource>
pci/0000:03:00.0/196609:
<port-resource>
pci/0000:03:00.1:
<resource>
pci/0000:03:00.1/262144:
<port-resource>

devlink resource show scope port
pci/0000:03:00.0/196608:
<port-resource>
pci/0000:03:00.0/196609:
<port-resource>
pci/0000:03:00.1/262144:
<port-resource>

devlink resource show scope dev
pci/0000:03:00.0:
<resource>
pci/0000:03:00.1:
<resource>

For the do-it command:
devlink resource show pci/0000:03:00.0
pci/0000:03:00.0:
<resource>
pci/0000:03:00.0/196608:
<port-resource>
pci/0000:03:00.0/196609:
<port-resource>

devlink resource show pci/0000:03:00.0 scope port
pci/0000:03:00.0/196608:
<port-resource>
pci/0000:03:00.0/196609:
<port-resource>

devlink resource show pci/0000:03:00.0  scope dev
pci/0000:03:00.0:
<resource>

The way to get the dev or port scope will be by bitmask in the netlink 
message of the dump/doit command.
Thank you

