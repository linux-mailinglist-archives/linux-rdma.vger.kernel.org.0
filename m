Return-Path: <linux-rdma+bounces-20231-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHNCJVSq/WmEhAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20231-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:18:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8F4F4277
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C0193055401
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C431F98C;
	Fri,  8 May 2026 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CBdurmMg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906430E829;
	Fri,  8 May 2026 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231738; cv=fail; b=lKsx5E9Yocxv+u6+tlUvB3hjKJ1CWvraI83jpYmQz1G6ZvwbMfF4Rl8MMFSS6SFN5fbRijqWN1uatvPuVxh8WP62ruMgAjvIRvhP4Z1sS2pO0JQUnwXeTrqrHT2F4lOj7ZmLwdCrD99c/eLTL7dBmC1VwR1GjpMHASZYg7sjAK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231738; c=relaxed/simple;
	bh=xDJXqMROWBg3wdbKdifFhbKGCq+7gvnNnHAT3AIIVqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ly7edLVpfcVY0Sf+mwAaiy2b2MjgDxyx2qci0Fp1mJ7iPFTJhghk2SKGHPbc/89eqoh0lih4pstc8zI6/d3TlBz4lcj5VvMq4o0crHWJgubZancpLQqvLGFCJ75EzEZjhP2HcoyUAgXYUGsOI5sBsy6Vb0gax/Xo13S4Eu0Zia0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CBdurmMg; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6JXtja2r0IcpYMG/HuweKPokZchswAc6fp7MIFCB+ngs0BdpRVhYzUML04DjC9BNgs5vBAtUmt2edJIpvbjdAr3Aob5enBgz1dAsewE/7eycq7LBaPdOFEK+ClxzfGQ2UfrmgTUdjMMFD1+91rQ3/zyAuAh/8UxTdUBDqLi1OT5SnlXeezk1BpY3EgpkwPXO33qkmdJx3XbhurXUA73zqwUzS6Mup/lHsiNeq/h1U9L275P5Zv+sLeXHNudhdO2D7ZbXlKr3oHXw40mbHXDxz1MrYLVxYlVg0x51ukUTttfKBj9I4KzRS+BVpO2LWGl6WG9m/LE77y4Q0+COWkLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wcpn7zZm4+UZu4fh+au+VKes06zgviDl7vc4f9c7B1s=;
 b=wAqnt6Z3dT5wH4kUA0eHFUMWGE5yclQ2COC+bYjfDn6RgGfVp9BrtfF2NDeWoYXhQntuCpc5pQOpPc9F2VkDb1U79zECydUq8PTwTfKulEPlO0adbDZ4Nz7sapDgdF7F44qhi4zQtmgB9e+mUiJd3Koi6S+S+fkxD1yQ/y6jUtsRblZiUug0PbDq3FPV/9Qjx/3xVhkr4mnCb3NDaWIeGcdqZz2KM8asigH79YH9jseRisOD6jwv3vUQgYpw46SCGVGcujMWQqCIfstDbtvI8aktpRky1jx/XDLLE+6YMZPFAWL0W+83UKL0vf+cdP7wH6VdyFpX+LOB0srGeEaO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wcpn7zZm4+UZu4fh+au+VKes06zgviDl7vc4f9c7B1s=;
 b=CBdurmMgI6z046Sm4FvMTpVmwyjgQuCrL1SbMvvUJIAuwi7VfUm5TwkKWXypYJTROSOU21EygI6+DHmitCydmH4uGsOs4ZBNU0mhr9WMAK1jc4ETmQNEDSvOnGCegFmsHfmnFI3EIbhas/GKQPl0oWXWkhNndfJIqM9F8MxoBSMBJ+S2xwi25te34eGsgtCW4hkuMuB7iMBC2NNEv9NoSRS74gKbyQeBGcLzIqUJ7ramSP4VG0Q1GLPszO1qwaBd3VBVUtMvvT4b0Z2SCtZfYflftg7fckngstSqJDRXmvsn9nKRTW5Mwaq+h2iz7CliODsz0rg1sqzGWSe8zR7c4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Fri, 8 May
 2026 09:15:33 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 09:15:33 +0000
Message-ID: <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com>
Date: Fri, 8 May 2026 11:15:27 +0200
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
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea7d885-c74a-4247-cbc1-08deace25b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BrHVg4k4XjTmLvMUal+aKstuAR+J61CNg8m58oF5WaQDaHcg77WZVKfEqnNbnDeQGfnPh/r70BnF50Hc8m1NTV98Hxch27pormOR9TFxUDQMasBKYV8xmeMjPOA94jaYNwlvtU8LxAY0fpW74R/vyi3mlKhMsva9fsfMiIhChYDKhI570mHfXvQY54USC2IyKn91H25jukpkd5IJbMpBBh0mnvjOzp+IU5+Mm2Ua/6YfPlIylOySpe2hgLSWGrDrJSkQWF/V7hQgvdRxz6Xz6lGMyMBdK7BaRt1JEgCxJHv6rTfwmpexAclALE+6Z5Jvb5LatCtlAq4NBT40HVhFzej+DyReI1oCxM6vmq4QxgoV7jxKd/aDjZpDjrOjDQnOG2VmVSCNoLRvcex0rNL55ht9SaOqun2zt0BPViC3ggRnYIRJQpw/GvNAwZslOTAGStSaQreLKrhOt1YaNA9aSCrX1mgaSR1ssWBWWb5FSUURnieG8k36VmGZkS8w8SJifpCHRbPt5zU870XGFtE1Rj7tBCRRrenI9mbzqolRm0yBJqqTyblfShM79s3dAQGWqYmPasiGEwhoL16tBUVsEMzXFEfrbizt8z0TwLCUKNSebiHxoPw8m7zoq+bNa+lK7azSiYQk8H2OqsLibl82hSyjsBCkS1QOtl77gGpQt0AOXzlklz1ZwVeebAb7JSOw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU9PeXdDdWQ5ZHZzQVIxSEVXY0VWVDQvb0tCZjdIRVVSMDh1T0w5TUxRMnZB?=
 =?utf-8?B?SC9pZUk5bDNYUXNQYWFCK3BrVkFPVVpjd0oxL0FNdHdpVkF3Znk2YitjR1dS?=
 =?utf-8?B?SHFUM0xKOG9qbmV6eS9hWnBaTGlpY3VQRE51Tmt6UGtjS0NoaU40VEZncCtK?=
 =?utf-8?B?NlozTVRjeWNLN01uSUlWb1NsTVA5L3Q1OUdqMjY5MzJiampaZ0JqT0NYd3pr?=
 =?utf-8?B?U2MvRkhmWDZhU0RSaHU1a0huMUpNYkw1dkE3SndhdldhV25ld2pkSkFzTXpr?=
 =?utf-8?B?S2JZV3BHbEJZa3M0d3YwTTZCdkJkbE1VV3hoR0tBZ21oWUpzQ2lwQTEzc3pH?=
 =?utf-8?B?YUp3a09tT0xFSS80eEVaTVdDcVQ5L2hCL0ova2NuMWtrMDBXM24xVDhxR1VQ?=
 =?utf-8?B?Rit0NytZZDloUDZjeGNIdkpMVWFUaXZ1WkNCdzNHMkRRWUVtREZTNGczMDVO?=
 =?utf-8?B?VDdTODRIMFB1UFRkS3Z4K1YxMXE3VHNEdGQ4WUh6MlZhZ084U0s0MGwyNUlk?=
 =?utf-8?B?QTZqdTFraklYbzFBWWxqZHd0eGFuVVJtdFZDVnk0eDcvZ1RuZjRNVzJCeFh2?=
 =?utf-8?B?Vy80TWFkTkRsU2N2SEFmTDhwQTFnV21WSUlnUStzUVc5VjNkZS9TdlpoRExh?=
 =?utf-8?B?TE4zTlZlWml4ekdlM0s4YXYxbFk2eVoxZUNyR2IzcXFmSU02MnloMk1SbnFP?=
 =?utf-8?B?QndQTkFxRXdDcDNSY3pvbUpyR0JPc0ZaMWQ2VW5SMnUyR1Nka3c4M3JNZkFM?=
 =?utf-8?B?YXFPYlNuSmttYTJBK2pSVUgrNitmaU1LZlNtR3ErWEhWZ08vWlEzMGJ6RTNE?=
 =?utf-8?B?M3lETktlcHZQaWxTUVRpeEhhQjBOM2xWRE5MbU1aQVBGRGlhdzl5WkhGRi9P?=
 =?utf-8?B?bk9vbFMyenNmdUNVajh3VVk5ZzN5dDNUdXJyUExvNDJPdHlvZWkyWEwyUnY2?=
 =?utf-8?B?cm5PdllvUkUwT2FBc1haYmNhVFU1UG55RzYxLy9XenMwQWtKK0tYaHZBeDdw?=
 =?utf-8?B?aEVZak9GTXBXY0hQM1JiL3ZWeWFwU29HREhIeG9LOEl1SEkxd0pFVy9BSXV5?=
 =?utf-8?B?UHNBdTdlWmtiMVdpc2hDc1UvYXdLR2RrcFpkK0s0YUpjM3hybExLK2Q0ZWV2?=
 =?utf-8?B?TFlPbUlPM1dWTGxOS1JhczhBNjFKejlnMWQrN1BlTWxaOTNqWjdLNEZmR3JW?=
 =?utf-8?B?QXJLQklERktrdkwwLzlqWmhTWnNVcE5Bb0JmQTdvdkYrZEJQVEl5MHhKQUJo?=
 =?utf-8?B?eEl6SnhPU25iM3phejkwaHBDT1BZRmc0ZFFZemltZEQvMWhpS0xaRDI0NGwz?=
 =?utf-8?B?aktWWUZZYmFZS3F6emt3eStiZDlCenVOcGJaSWhYWHlXTjFSUE05K2pDSXMw?=
 =?utf-8?B?dFBTYk00QmI0ZVJQRmNhbjBzUTVHYnhZOUw4MTZuL0xhWmVtcWxiMk1hUmtq?=
 =?utf-8?B?M21QaXY3dENTNmNMRXJuREZIZVRzTjVEUzR6ZzZsU3N0ZUZpTjk5SGpaMkpK?=
 =?utf-8?B?UFl1N0h3SE1TR25GVUxUSE0xN2NrMEo5OVY3NHl4OFVlM2pYRWN5OWZOWVRq?=
 =?utf-8?B?NGRyK1dELzZUMzFkcUtLVjVFdmhCb2xyaGJackNlemJNRFd4T3pFb1ppZERH?=
 =?utf-8?B?enVlcjVURi9QZ3VKdVFjWmxPSzdYOWJWVzB2cEZhOUpDL2hwaCtmL0Y2Q0I3?=
 =?utf-8?B?NEJxN00zM0R5aDQ0bGhuRjlmamxrczllOUovR1BweU1qSkJnYjk1K0dVd2RI?=
 =?utf-8?B?S014WnAzR3dmNlZmWldLMmVXVVo2amdWeHRoM0ZmMTh0MHFKOW0xVjQ2WThI?=
 =?utf-8?B?OW1TeHo3cWxyajNMT25lNXdSbklCUVdUeFRrQlJqMVF4R3FicHJSUStvNEUz?=
 =?utf-8?B?SzdHakIydGxhQXYxclhSZ1hYOVRraU1ocWRERHRqYThwQTlYUndnSW5Vd3d4?=
 =?utf-8?B?MjdJd0F2MndJelRvUGtTc0ZEbjMyTlhZZXEySmxoMmptTGVLNHF4aVh4b3I5?=
 =?utf-8?B?U0s0SmpiODNUU3RIWEpmOHZBSSsrNms5RlYwb3NZRDhZMzlHL3NuOEFJVFQz?=
 =?utf-8?B?Z1Q2TS9PTGpFRVQrbUhTZHV1ZmV3b1k4ZUJUMFdTV0hOOEFGdjN2cFI2dGkv?=
 =?utf-8?B?RktjYXpIR2MvRkFmekxOamkyVUhoTnpBUkwxWXJmdmJnY210SzVNMHU3cXN6?=
 =?utf-8?B?Y1d1UFM1UU5jSlF1Z2xZZU52Q05hcGVCeThCS0xtQkM3NVUxTm00NjRLUDZk?=
 =?utf-8?B?aWVaTGFNNDg5bnhjRjhkWUxCY1RnbllLYmhxSzFSaUZSOVFMcTNrOXpaV1dC?=
 =?utf-8?B?Y3VaUzZNUFRyeUZvU2szMHRrYW14K2dRbWJiRmZNVUc3KzJ0VG42QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea7d885-c74a-4247-cbc1-08deace25b52
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:15:33.0784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLFR14HJwM4/IbGNves4N7eXy/ZhS74u8lsEoK3exAdounp9zNjsrGFMY4u8QAoYdzFqXaRm8t9Rd8DubWHpZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9
X-Rspamd-Queue-Id: 38D8F4F4277
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20231-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action



On 07.05.26 22:50, Amery Hung wrote:
> On Thu, May 7, 2026 at 4:50 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>>
>> Hi Amery,
>>
>> On 07.05.26 15:53, Amery Hung wrote:
>>> [...]
>>> Am I understanding correctly that the better performance comes with
>>> the assumption that the XDP does not change headers?
>>>
>>> headlen is determined before the XDP program runs. If it push/pop
>>> headers, there could be headers in frags or data in the linear region
>>> after __pskb_pull_tail().
>>>
>> That's right.
>>
>>>>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>>>>                                 struct mlx5e_frag_page *pfp;
>>>> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>>>>                                 pagep->frags++;
>>>>                         while (++pagep < frag_page);
>>>>
>>>> -                       headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
>>>> -                                       skb->data_len);
>>>> +                       headlen = min_t(u16, headlen - len, skb->data_len);
>>>
>>> headlen - len can underflow but will be capped by skb->data_len, so
>>> this should be okay, right?
>> It is safe. But it might trigger an extra allocation in the pull when
>> len > headlen. We could also skip the pull in that case. Or do a
>> min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?
> 
> Make sense, but this line took me a bit to understand. Maybe consider
> checking len < headlen first?
> 
> if (len < headlen) {
>         headlen = min_t(u32, headlen - len, skb->data_len);
>         __pskb_pull_tail(skb, headlen);
> }
> 
Yes, that's what I had in mind when skipping the pull. I would also
tag this as likely.

> Another clarifying question. So this patch will improve the
> performance when the XDP programs don't change header length. For
> those that encap/decap, they should precisely pull only headers into
> the linear area for optimal performance. Is it correct?
> 
Right for encap, but for decap not quite:

Let's say that the XDP program pulls 64B header into the linear part
and snips 4B of the encap out. This would result in a pull of an
additional 4B (headlen (64B) - len (60B) = 4B) which are now
data bytes => sub-optimal layout.

I don't see how we can improve this corner case though.

Thanks,
Dragos

